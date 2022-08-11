Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14CAE58F9DB
	for <lists+bpf@lfdr.de>; Thu, 11 Aug 2022 11:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbiHKJQg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Aug 2022 05:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbiHKJQf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Aug 2022 05:16:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69AC326C1
        for <bpf@vger.kernel.org>; Thu, 11 Aug 2022 02:16:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7EDBEB81F99
        for <bpf@vger.kernel.org>; Thu, 11 Aug 2022 09:16:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A521CC433D6;
        Thu, 11 Aug 2022 09:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660209392;
        bh=Kt4GhtVTDhFPgyfUjYbAZ1T6CvswryPDcMW/ASCaDQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K7SwPXvQq8dvYuunW51x31H7fudlywtjllgFQkWxk6Yg21Z/psih9Jzz/Nld1r5tD
         vZXT6Ab+zW2Ia0gIe21dcbbOwAnmzUdS8vat4it3gvlSzmL3Qxnxz0g8Hq+5Nh7tK/
         p9JWq8yqo9EJpjHSF0zX+2YITzapcHNVfwcbsZ0bwM+M+WONnUGmH/nCN2fv2fKC4E
         RGFkZY3q71fJ+/1MKrma97eAO+Pn6oWfB7hQccGqhm91+eqWOq3Rg5xkSv53zgdfQr
         hWmDRQV39XJVc6V57epVifIzcNRBsCc/3M0nVIZGdVg9ppbqN6JJitJF3t6w0r/P55
         MAyicgCciExqg==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: [PATCHv2 bpf-next 5/6] bpf: Return value in kprobe get_func_ip only for entry address
Date:   Thu, 11 Aug 2022 11:15:25 +0200
Message-Id: <20220811091526.172610-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220811091526.172610-1-jolsa@kernel.org>
References: <20220811091526.172610-1-jolsa@kernel.org>
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

Changing return value of kprobe's version of bpf_get_func_ip
to return zero if the attach address is not on the function's
entry point.

For kprobes attached in the middle of the function we can't easily
get to the function address especially now with the CONFIG_X86_KERNEL_IBT
support.

If user cares about current IP for kprobes attached within the
function body, they can get it with PT_REGS_IP(ctx).

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c                             | 11 ++++++++++-
 tools/testing/selftests/bpf/progs/get_func_ip_test.c |  4 ++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index bcada91b0b3b..027abc38faab 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1029,8 +1029,17 @@ static const struct bpf_func_proto bpf_get_func_ip_proto_tracing = {
 BPF_CALL_1(bpf_get_func_ip_kprobe, struct pt_regs *, regs)
 {
 	struct kprobe *kp = kprobe_running();
+	uintptr_t addr;
 
-	return kp ? (uintptr_t)kp->addr : 0;
+	if (!kp || !(kp->flags & KPROBE_FLAG_ON_FUNC_ENTRY))
+		return 0;
+
+	addr = (uintptr_t)kp->addr;
+#ifdef CONFIG_X86_KERNEL_IBT
+	if (is_endbr(*((u32 *) addr - 1)))
+		addr -= ENDBR_INSN_SIZE;
+#endif
+	return addr;
 }
 
 static const struct bpf_func_proto bpf_get_func_ip_proto_kprobe = {
diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
index a587aeca5ae0..6db70757bc8b 100644
--- a/tools/testing/selftests/bpf/progs/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
@@ -69,7 +69,7 @@ int test6(struct pt_regs *ctx)
 {
 	__u64 addr = bpf_get_func_ip(ctx);
 
-	test6_result = (const void *) addr == &bpf_fentry_test6 + 5;
+	test6_result = (const void *) addr == 0;
 	return 0;
 }
 
@@ -79,6 +79,6 @@ int test7(struct pt_regs *ctx)
 {
 	__u64 addr = bpf_get_func_ip(ctx);
 
-	test7_result = (const void *) addr == &bpf_fentry_test7 + 5;
+	test7_result = (const void *) addr == 0;
 	return 0;
 }
-- 
2.37.1

