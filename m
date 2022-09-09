Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCB45B3154
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 10:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiIIIGf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 04:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiIIIGe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 04:06:34 -0400
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6731CB1D;
        Fri,  9 Sep 2022 01:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1662710791;
        bh=isS2ysJweAKK83d4hIdupBj3xtoj8eHTEYjA8Ve6cBk=;
        h=From:To:Cc:Subject:Date;
        b=D8e8jpO+YlXjHOKTbqtX7mr+LRTI0dDG3WkpA6nwmDrypPGUO8FzdbTUAT9TZp+Fm
         87DUpI/A44LsIkzTohZH00WZpm6kERUguWCrRq+fLvaSmsvoHGZHko+9NeocQ9MRf3
         bQBSNXsvcJzj9lmk8oFp3Jo66qDUe3fhyfu6Igbc=
Received: from localhost.localdomain ([39.156.73.13])
        by newxmesmtplogicsvrsza35.qq.com (NewEsmtp) with SMTP
        id CC207C0A; Fri, 09 Sep 2022 15:51:02 +0800
X-QQ-mid: xmsmtpt1662709862tbsgre2l0
Message-ID: <tencent_EE0C066E42FA59A497072A6EAFCCA3358808@qq.com>
X-QQ-XMAILINFO: NySneyYf/AjRrb4FHYV4oF0tB9tTg47LL70q3Y6rLS+vV2y5IbJc1zvh+jIgw7
         p208xIdje4C9jvDGPzQXJF7RcwuOaHPYPgmiR0atA1cUAepDBAhPGz44d3bLwXekrpeXN2a2Y5Fl
         chldw5+ZLj9I8e31yB1aoPYuDaew28WjHbYOxBGYGP62qdGkHrXytkf3aHmfvHrCssE3shrqPOVD
         tIWhvGlO+cl10mQ4zxcVXV+nUgGQuz7oneS5B5QA0MdVIfscFbfNVEw5NL7rxihANpBL4nT247p9
         Poo1KrxHsvHdEa7kxhHptRQO+yUFhGMWj6oXtYQjYjUhxDLHUXAvCnLqf6FzX9MFaRm1DDeGyLb6
         XWYq9vKzU5V/p6MlP8DK2CGpxgP/DpN1JoySFRY5ihNAKwt7jATNHVqNPBmb1hgWm9WeWe0C7H7H
         nXuCjq1kV5ohZ2Vy+gKd3LCBvc8aLoypjqVnmnmbGyshv+xG7bb8ZGiwb0callfezU0XMVhmnG5H
         VlV8CAO7BqNd6I7biFfjacEXFOBpsbpnpndC0zo6RM5hLDz/btVEG2i+nacchb46hO3a/AFm8saZ
         0rwQD2PLiD5TSKs8X+uvQw8ChQ/kOunOesjrFFW1SjawqbbOJIZ+G9Gpq4PtCxoOimHDNC8PyOu7
         /LYQia6QFrt60QTk66aoNsQOtEV6pn3JeubwNnlFZtjPl0W5PEWDbIrGZ94Lwl5NLxy0/MCKlKW/
         91DmK0oEmnrXyJCvm35AUPFLOpjTfL25idcOhuAH2+I/fpXFcysBddXFyGYFZGoxMjnumu09pbIM
         qVjryJcKotQslMfkQNl+tYef7P7jtlB9ta9t7tQEX6tbwnDrSDUe5bq6tJ/mgxzVZim4OXBowt65
         20mupd5RncG+2NOVGQONbQ3U5H7PeD8U1k5XesDNW8/LEw7jmn+R9Y+7VrRBbS4IHeMT8Cou6l8X
         am+ww3T1hvCDdEMY7hKrty9MtOrEc1C2aegdOXA6qF99lNerBC5ID6ITgCXJM0dadE0l/kEfI=
From:   Rong Tao <rtoax@foxmail.com>
To:     ast@kernel.org
Cc:     Rong Tao <rongtao@cestc.cn>, Rong Tao <rtoax@foxmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf] samples/bpf: Replace blk_account_io_done() with __blk_account_io_done()
Date:   Fri,  9 Sep 2022 15:50:50 +0800
X-OQ-MSGID: <20220909075050.7514-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

Since commit be6bfe36db17 ("block: inline hot paths of blk_account_io_*()")
blk_account_io_*() become inline functions.

Signed-off-by: Rong Tao <rtoax@foxmail.com>
---
 samples/bpf/task_fd_query_kern.c | 2 +-
 samples/bpf/task_fd_query_user.c | 2 +-
 samples/bpf/tracex3_kern.c       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/samples/bpf/task_fd_query_kern.c b/samples/bpf/task_fd_query_kern.c
index c821294e1774..186ac0a79c0a 100644
--- a/samples/bpf/task_fd_query_kern.c
+++ b/samples/bpf/task_fd_query_kern.c
@@ -10,7 +10,7 @@ int bpf_prog1(struct pt_regs *ctx)
 	return 0;
 }
 
-SEC("kretprobe/blk_account_io_done")
+SEC("kretprobe/__blk_account_io_done")
 int bpf_prog2(struct pt_regs *ctx)
 {
 	return 0;
diff --git a/samples/bpf/task_fd_query_user.c b/samples/bpf/task_fd_query_user.c
index 424718c0872c..a33d74bd3a4b 100644
--- a/samples/bpf/task_fd_query_user.c
+++ b/samples/bpf/task_fd_query_user.c
@@ -348,7 +348,7 @@ int main(int argc, char **argv)
 	/* test two functions in the corresponding *_kern.c file */
 	CHECK_AND_RET(test_debug_fs_kprobe(0, "blk_mq_start_request",
 					   BPF_FD_TYPE_KPROBE));
-	CHECK_AND_RET(test_debug_fs_kprobe(1, "blk_account_io_done",
+	CHECK_AND_RET(test_debug_fs_kprobe(1, "__blk_account_io_done",
 					   BPF_FD_TYPE_KRETPROBE));
 
 	/* test nondebug fs kprobe */
diff --git a/samples/bpf/tracex3_kern.c b/samples/bpf/tracex3_kern.c
index 710a4410b2fb..bde6591cb20c 100644
--- a/samples/bpf/tracex3_kern.c
+++ b/samples/bpf/tracex3_kern.c
@@ -49,7 +49,7 @@ struct {
 	__uint(max_entries, SLOTS);
 } lat_map SEC(".maps");
 
-SEC("kprobe/blk_account_io_done")
+SEC("kprobe/__blk_account_io_done")
 int bpf_prog2(struct pt_regs *ctx)
 {
 	long rq = PT_REGS_PARM1(ctx);
-- 
2.31.1

