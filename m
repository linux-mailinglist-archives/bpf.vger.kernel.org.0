Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667A65EACE8
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 18:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiIZQqd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 12:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiIZQqJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 12:46:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0881F2DF
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 08:34:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE664B80AF5
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 15:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3833DC433C1;
        Mon, 26 Sep 2022 15:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664206478;
        bh=7G+8dFvjvjib6JQhFMnH/NRvderrmruxsAlg+NuQSfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iyehJWNtnt/YsKYz+hWbzugClkwUKM9frWTcCyubPb2bgannzXn02Nb5TaWgIZ03L
         vyip39N+NgTlMsRtcfLoHf30/eAKtCbDSxUjnJYzszFwn3WLLTWw1jjToV5TmECrEU
         FtLwTBWi7V7tdm9dWjeOqRDwyifwxjUCn+L3WKCnoFETeGBk0rNlWKS9HdJdWemHiA
         blMNV6Jc0SIfqK+9WVYcyaojODrC+yFkbXVs3vQ1h5bNW6kA0/MfqAOHmoNMwIEGGk
         95+Dt4DUJUbRyczW3Oi48irUUa2xaFoB77HhQyusuuHD37tjdM8nnZIvexMtuDPOjs
         RbmQAYib1P3LA==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martynas Pumputis <m@lambda.lt>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCHv5 bpf-next 5/6] bpf: Return value in kprobe get_func_ip only for entry address
Date:   Mon, 26 Sep 2022 17:33:39 +0200
Message-Id: <20220926153340.1621984-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220926153340.1621984-1-jolsa@kernel.org>
References: <20220926153340.1621984-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Martynas Pumputis <m@lambda.lt>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/uapi/linux/bpf.h                             | 1 +
 kernel/trace/bpf_trace.c                             | 5 ++++-
 tools/include/uapi/linux/bpf.h                       | 1 +
 tools/testing/selftests/bpf/progs/get_func_ip_test.c | 4 ++--
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index ead35f39f185..d6bd10759eaf 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4951,6 +4951,7 @@ union bpf_attr {
  * 		Get address of the traced function (for tracing and kprobe programs).
  * 	Return
  * 		Address of the traced function.
+ * 		0 for kprobes placed within the function (not at the entry).
  *
  * u64 bpf_get_attach_cookie(void *ctx)
  * 	Description
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index ebd1b348beb3..688552df95ca 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1048,7 +1048,10 @@ BPF_CALL_1(bpf_get_func_ip_kprobe, struct pt_regs *, regs)
 {
 	struct kprobe *kp = kprobe_running();
 
-	return kp ? (uintptr_t)kp->addr : 0;
+	if (!kp || !(kp->flags & KPROBE_FLAG_ON_FUNC_ENTRY))
+		return 0;
+
+	return get_entry_ip((uintptr_t)kp->addr);
 }
 
 static const struct bpf_func_proto bpf_get_func_ip_proto_kprobe = {
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index ead35f39f185..d6bd10759eaf 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4951,6 +4951,7 @@ union bpf_attr {
  * 		Get address of the traced function (for tracing and kprobe programs).
  * 	Return
  * 		Address of the traced function.
+ * 		0 for kprobes placed within the function (not at the entry).
  *
  * u64 bpf_get_attach_cookie(void *ctx)
  * 	Description
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

