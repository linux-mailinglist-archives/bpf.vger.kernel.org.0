Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7F45B34E6
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 12:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiIIKOD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 06:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiIIKN7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 06:13:59 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C468B113C46
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 03:13:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1E772CE227E
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 10:13:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB75C433D7;
        Fri,  9 Sep 2022 10:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662718427;
        bh=NeD9J+hlFmOiZztf/4mgtbH/WlCig7osqOQURM0sWqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oP/KrUAHJJ95FYjktAvVUGywqZU1J752y4639I85CvUoaStZ42B7wMaDmZjw1rwtb
         MMefjrzkOiT7lhryHe1AvEGrcNW+DWF2+pqdTmFUEpMDMDoo6U8dv56/6aFmIbhk9t
         KPwzj3fjVn1BAThG1pJjDmmqjEDq410iiB7XEg6/xI2QYL9soqEM+TtHIf6wSyZgru
         0VwsanQ2pqfgDl/O/MlWLeRara6Rmy2RbTCHtu13trmytEI9q5QROGDk+9tNMtHIFb
         Xcd4jYYIQ1XpiIkykAcH6NZ6DkXsrf7ufFTK6I4gxSMNYPB08htYok1RYhsqVBLeYP
         cDjN3/ZtekOlw==
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
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Martynas Pumputis <m@lambda.lt>
Subject: [PATCHv3 bpf-next 5/6] bpf: Return value in kprobe get_func_ip only for entry address
Date:   Fri,  9 Sep 2022 12:12:44 +0200
Message-Id: <20220909101245.347173-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220909101245.347173-1-jolsa@kernel.org>
References: <20220909101245.347173-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
2.37.3

