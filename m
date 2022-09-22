Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70BC5E6D9A
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 23:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiIVVFB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Sep 2022 17:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiIVVE6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Sep 2022 17:04:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A9687086
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 14:04:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85E4562D46
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 21:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D8AC433D7;
        Thu, 22 Sep 2022 21:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663880694;
        bh=e8Nm5c5eqOXG/hFEZ2bBwEbQQdcrnXwYJva1UH1Kigk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rvDfFEnw5Lk9G8kDPcTt+IRIcZhMv1ZQJ5JhCUFXohqXbccNaMJwwZUo65/9qnSsB
         nz0CnJk2JqBYjWzJW5TFUC6cKC3vFz1jyQq32Qv1jjLbaCrIRaLMz7isB0cwZkq7X1
         1DqFE/hSBP63MUrq0ySx+0xMa9qZ8D4EmAev5oGlo6VnCWCqRyg+TfMiv4LaONpNMs
         keYS8usSLcP0XufJhvS18XSqQ2E/cOPyjBYe5W7dKlNMKzq4+Lj0Zdd3X3Sx0zz0Or
         TKZsGvrt0zyYNnA0RpQHHOUTuLlxtoAvWaOsD197Q1k1HJuwgYpj5B8pR1EZPDtBlf
         lQiHLFQazUHVQ==
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
Subject: [PATCHv4 bpf-next 5/6] bpf: Return value in kprobe get_func_ip only for entry address
Date:   Thu, 22 Sep 2022 23:03:19 +0200
Message-Id: <20220922210320.1076658-6-jolsa@kernel.org>
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
 kernel/trace/bpf_trace.c                             | 5 ++++-
 tools/testing/selftests/bpf/progs/get_func_ip_test.c | 4 ++--
 2 files changed, 6 insertions(+), 3 deletions(-)

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

