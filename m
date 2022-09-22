Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B0B5E6D98
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 23:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiIVVEr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Sep 2022 17:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiIVVEq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Sep 2022 17:04:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B33132EF2
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 14:04:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6CD27B838BF
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 21:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BDCFC433D6;
        Thu, 22 Sep 2022 21:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663880680;
        bh=tyIn95ASZrVudNAaDcgs4Mh4QEiwQUf+uUpcrL9YQTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dn26HQoCpJK1cLz0KqfCakrpibj82QXit737P1v0E5lCjV/HSUrX5dzaWCGk/Ko7S
         QhvnIZZ6I9IZ5yhjgS4bsFjkXsWSQhYnyA2vgWe6KnA9O4AdciXxKfkvfvJDwhTd36
         iugUeTssIxfLjdSUb3lLfntUMuloWlgBwZzDcGaewMj/naYr4Ez/+M7gX2QYPs9eW3
         BwgLz2HTghtIkEQmK0FwLYrTG5VHl2wY8Zf3QHEijvH0dbyCoIoCSqgRlDyabgsxkt
         26qnTruGnrAxfu2YfMOSBfwnsjTwbEAhSZE27+qZMIUYeg0fIdDs1bavf8WsCBcnb7
         z4sD5CLNJu8yA==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Martynas Pumputis <m@lambda.lt>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: [PATCHv4 bpf-next 4/6] bpf: Adjust kprobe_multi entry_ip for CONFIG_X86_KERNEL_IBT
Date:   Thu, 22 Sep 2022 23:03:18 +0200
Message-Id: <20220922210320.1076658-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922210320.1076658-1-jolsa@kernel.org>
References: <20220922210320.1076658-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Martynas reported bpf_get_func_ip returning +4 address when
CONFIG_X86_KERNEL_IBT option is enabled.

When CONFIG_X86_KERNEL_IBT is enabled we'll have endbr instruction
at the function entry, which screws return value of bpf_get_func_ip()
helper that should return the function address.

There's short term workaround for kprobe_multi bpf program made by
Alexei [1], but we need this fixup also for bpf_get_attach_cookie,
that returns cookie based on the entry_ip value.

Moving the fixup in the fprobe handler, so both bpf_get_func_ip
and bpf_get_attach_cookie get expected function address when
CONFIG_X86_KERNEL_IBT option is enabled.

Also renaming kprobe_multi_link_handler entry_ip argument to fentry_ip
so it's clearer this is an ftrace __fentry__ ip.

[1] commit 7f0059b58f02 ("selftests/bpf: Fix kprobe_multi test.")

Cc: Peter Zijlstra <peterz@infradead.org>
Reported-by: Martynas Pumputis <m@lambda.lt>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c                      | 20 +++++++++++++++++--
 .../selftests/bpf/progs/kprobe_multi.c        |  4 +---
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index b05f0310dbd3..ebd1b348beb3 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1028,6 +1028,22 @@ static const struct bpf_func_proto bpf_get_func_ip_proto_tracing = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 };
 
+#ifdef CONFIG_X86_KERNEL_IBT
+static unsigned long get_entry_ip(unsigned long fentry_ip)
+{
+	u32 instr;
+
+	/* Being extra safe in here in case entry ip is on the page-edge. */
+	if (get_kernel_nofault(instr, (u32 *) fentry_ip - 1))
+		return fentry_ip;
+	if (is_endbr(instr))
+		fentry_ip -= ENDBR_INSN_SIZE;
+	return fentry_ip;
+}
+#else
+#define get_entry_ip(fentry_ip) fentry_ip
+#endif
+
 BPF_CALL_1(bpf_get_func_ip_kprobe, struct pt_regs *, regs)
 {
 	struct kprobe *kp = kprobe_running();
@@ -2600,13 +2616,13 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 }
 
 static void
-kprobe_multi_link_handler(struct fprobe *fp, unsigned long entry_ip,
+kprobe_multi_link_handler(struct fprobe *fp, unsigned long fentry_ip,
 			  struct pt_regs *regs)
 {
 	struct bpf_kprobe_multi_link *link;
 
 	link = container_of(fp, struct bpf_kprobe_multi_link, fp);
-	kprobe_multi_link_prog_run(link, entry_ip, regs);
+	kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs);
 }
 
 static int symbols_cmp_r(const void *a, const void *b, const void *priv)
diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi.c b/tools/testing/selftests/bpf/progs/kprobe_multi.c
index 08f95a8155d1..98c3399e15c0 100644
--- a/tools/testing/selftests/bpf/progs/kprobe_multi.c
+++ b/tools/testing/selftests/bpf/progs/kprobe_multi.c
@@ -36,15 +36,13 @@ __u64 kretprobe_test6_result = 0;
 __u64 kretprobe_test7_result = 0;
 __u64 kretprobe_test8_result = 0;
 
-extern bool CONFIG_X86_KERNEL_IBT __kconfig __weak;
-
 static void kprobe_multi_check(void *ctx, bool is_return)
 {
 	if (bpf_get_current_pid_tgid() >> 32 != pid)
 		return;
 
 	__u64 cookie = test_cookie ? bpf_get_attach_cookie(ctx) : 0;
-	__u64 addr = bpf_get_func_ip(ctx) - (CONFIG_X86_KERNEL_IBT ? 4 : 0);
+	__u64 addr = bpf_get_func_ip(ctx);
 
 #define SET(__var, __addr, __cookie) ({			\
 	if (((const void *) addr == __addr) &&		\
-- 
2.37.3

