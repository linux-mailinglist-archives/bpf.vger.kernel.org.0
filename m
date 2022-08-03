Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAF1588DE6
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 15:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238715AbiHCNvs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Aug 2022 09:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238721AbiHCNvW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Aug 2022 09:51:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639B9459B8;
        Wed,  3 Aug 2022 06:48:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6B20B822AF;
        Wed,  3 Aug 2022 13:48:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF834C433D7;
        Wed,  3 Aug 2022 13:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659534519;
        bh=QofVbPFWlQ6HFFbhEFcRVeQJ036YZ+JLjvZNFuTDFtg=;
        h=From:To:Cc:Subject:Date:From;
        b=ETuvR63hPfNyjnl8aA1zTfgeCrhaMDHj/D46IrW4izDOlIEB7pd84ceNLjR9ThUW9
         Sa/qTouElugysbtT5O1rw5NfPBpYmvl5C/NJVkDeuJp8xAkTn0MPPqNktJBYviyC+v
         nIoVV65WE6PWw/RqdA0YLqX/s5TLT6gV3cD9wp652TK/Tdp0mkEJ0qDIXpWB1XusSI
         xfgjkFWY25hPpVKMfi+U7VTtn9bHZHRM7VwbjEzW8Xx6S9xiZ7hRF8SyygttIApiCN
         7QjVd1/EmkwzeNFyooyt2ZcYWo8D6dtLr4zkv+oh1MTt6x+P0a4gObrs0DERzGUleJ
         OwAQSHDnMlxcw==
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
Subject: [PATCH v2 1/1] bpf: Drop unprotected find_vpid() in favour of find_get_pid()
Date:   Wed,  3 Aug 2022 14:48:21 +0100
Message-Id: <20220803134821.425334-1-lee@kernel.org>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
Fixes: 41bdc4b40ed6f ("bpf: introduce bpf subcommand BPF_TASK_FD_QUERY")
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 => v2:
  * Commit log update - no code differences

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
2.37.1.455.g008518b4e5-goog

