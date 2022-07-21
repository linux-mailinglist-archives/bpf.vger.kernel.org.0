Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C595957C99F
	for <lists+bpf@lfdr.de>; Thu, 21 Jul 2022 13:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbiGULPC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jul 2022 07:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiGULPC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jul 2022 07:15:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3317182128;
        Thu, 21 Jul 2022 04:15:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C120461B36;
        Thu, 21 Jul 2022 11:15:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44EFDC3411E;
        Thu, 21 Jul 2022 11:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658402100;
        bh=Z0bgFvFC+a5XePrtTgP5iWpqKqXLerZ1ITI2EwqeVQU=;
        h=From:To:Cc:Subject:Date:From;
        b=qEJeipUsqQ5BECh/krnTuufoQDJ1XlPpQ1jM8fLvBDvul4hTv8yEBKh/XG/EklpfE
         88vhl7GhZjHFz/DAE3tOxbdMAMv54UzdlmPsOcKZ8Hh+S1mkSzBbi1rK3zBxao1PuR
         tf3H/a+0T5e02uQ2DKXZbd/u1M9SO7g9NAP+kASSUBiairWWclkv0r3iFy/d/6Qohu
         jnXMr7OesWc1dhtXw/5K7nMehLHqjIKJjxwEQlkHrioLjrdHlIIGUzZpokvMtVIUlp
         cWT+LfYaz342Ab8QgHv1YArXepu8PdeyrPNp0/rk728G9o4r9nl0XyQDA8hFjfKAmM
         hXtxnbXK7AaKw==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org
Subject: [PATCH 1/1] bpf: Drop unprotected find_vpid() in favour of find_get_pid()
Date:   Thu, 21 Jul 2022 12:14:30 +0100
Message-Id: <20220721111430.416305-1-lee@kernel.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The documentation for find_pid() clearly states:

  "Must be called with the tasklist_lock or rcu_read_lock() held."

Presently we do neither.

In an ideal world we would wrap the in-lined call to find_vpid() along
with get_pid_task() in the suggested rcu_read_lock() and have done.
However, looking at get_pid_task()'s internals, it already does that
independently, so this would lead to deadlock.

Instead, we'll use find_get_pid() which searches for the vpid, then
takes a reference to it preventing early free, all within the safety
of rcu_read_lock().  Once we have our reference we can safely make use
of it up until the point it is put.

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yhs@fb.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
Fixes: 41bdc4b40ed6f ("bpf: introduce bpf subcommand BPF_TASK_FD_QUERY")
Signed-off-by: Lee Jones <lee@kernel.org>
---
 kernel/bpf/syscall.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 83c7136c5788d..c20cff30581c4 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4385,6 +4385,7 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
 	const struct perf_event *event;
 	struct task_struct *task;
 	struct file *file;
+	struct pid *ppid;
 	int err;
 
 	if (CHECK_ATTR(BPF_TASK_FD_QUERY))
@@ -4396,7 +4397,9 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
 	if (attr->task_fd_query.flags != 0)
 		return -EINVAL;
 
-	task = get_pid_task(find_vpid(pid), PIDTYPE_PID);
+	ppid = find_get_pid(pid);
+	task = get_pid_task(ppid, PIDTYPE_PID);
+	put_pid(ppid);
 	if (!task)
 		return -ENOENT;
 
-- 
2.37.0.170.g444d1eabd0-goog

