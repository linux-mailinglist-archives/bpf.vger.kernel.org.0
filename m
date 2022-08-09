Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB6358D9DD
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 15:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244345AbiHINtl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 09:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244316AbiHINsA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 09:48:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4478217053;
        Tue,  9 Aug 2022 06:48:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEF3761166;
        Tue,  9 Aug 2022 13:47:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3844CC433D6;
        Tue,  9 Aug 2022 13:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660052879;
        bh=IQQJyPFnttVbNTaUGHXqrE8BpmegNCUFJ0+ReTCTZu8=;
        h=From:To:Cc:Subject:Date:From;
        b=l8Cq0hSkuZnyXUQSYfpxa755uy8qEYAkefS/L+mNsEuVZ8voZcMQp1ONL8XI5lXdV
         TScVJjrMzmGhL9yhSOc9kqn5FuaCmDqJqQWflx1XS8JwJ/Yf1wCoW1UMKv6TXz7i6T
         YRJjQRFPVHqQB9ZQnu0P06Kb/sPCIxtAaIJdXDR578J84gh3B5IXoK+sdzBEkgwA1l
         LkYqe9PH+C7Xqj3fNd5who6h4OMiLfoV9l1SECY9iqVL7mfDW2mWP4Ip7OJW2tLw5f
         gfrE4DjI7moAUCzMydSt7C5+3SalNH2usvfsCNWVmXw4zVKwFmuK/1gNxONvohhZHn
         F4AEZea/DhO1Q==
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
        Hao Luo <haoluo@google.com>, bpf@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH v3 1/1] bpf: Drop unprotected find_vpid() in favour of find_get_pid()
Date:   Tue,  9 Aug 2022 14:47:52 +0100
Message-Id: <20220809134752.1488608-1-lee@kernel.org>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The documentation for find_vpid() clearly states:

  "Must be called with the tasklist_lock or rcu_read_lock() held."

Presently we do neither.

Let's use find_get_pid() which searches for the vpid, then takes a
reference to it preventing early free, all within the safety of
rcu_read_lock().  Once we have our reference we can safely make use of
it up until the point it is put.

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
Cc: bpf@vger.kernel.org
Fixes: 41bdc4b40ed6f ("bpf: introduce bpf subcommand BPF_TASK_FD_QUERY")
Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 => v2:
  * Commit log update - description - no code differences

v2 => v3:
  * Commit log update - spelling of find_vpid() - no code differences

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
2.37.1.559.g78731f0fdb-goog

