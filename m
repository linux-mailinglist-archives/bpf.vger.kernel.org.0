Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809235B34EC
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 12:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiIIKN3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 06:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiIIKN2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 06:13:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC12D32D98
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 03:13:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A4C0B82491
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 10:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61FA9C433D6;
        Fri,  9 Sep 2022 10:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662718404;
        bh=ADvd2vYzjmh5rcCio/hEZv35Yc3l3XuYE9cf2aq2aAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fmDar7hremxEq0a32UqXc8f1q6qtg/vEjO1wtSCZWtfYKKzOPlDEFAI1HaDNz0jjU
         IJaySPu9VH9wd4MZLkzZAQeRL+PE9woJ/W4n9of2mS21hDnESdx/g+u1SJrPJZ7h3o
         wsu1Vwxb8N39qDNGwBD758Fyf+3L/lbxsxMLBoOjCI8H7l/qFlE9A845ZQ7K+olCu5
         GcG12tYzzTQQToSx0SQkoZnyVAIHeFSbcTCC1NqII8i97EV8t1FeSJ59LMZ3hCikAz
         p9HZa7BDtvpDMALxXMuN6ppZ6x40hoKie6hnfnMpIrE42/nqjtSLhzFgmweyDSte5N
         Ff/MR6RlYT1qA==
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
Subject: [PATCHv3 bpf-next 3/6] bpf: Use given function address for trampoline ip arg
Date:   Fri,  9 Sep 2022 12:12:42 +0200
Message-Id: <20220909101245.347173-4-jolsa@kernel.org>
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

Using function address given at the generation time as the trampoline
ip argument. This way we get directly the function address that we
need, so we don't need to:
  - read the ip from the stack
  - subtract X86_PATCH_SIZE
  - subtract ENDBR_INSN_SIZE if CONFIG_X86_KERNEL_IBT is enabled
    which is not even implemented yet ;-)

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index ae89f4143eb4..1047686cc545 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2039,13 +2039,14 @@ static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
 int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *image_end,
 				const struct btf_func_model *m, u32 flags,
 				struct bpf_tramp_links *tlinks,
-				void *orig_call)
+				void *func_addr)
 {
 	int ret, i, nr_args = m->nr_args, extra_nregs = 0;
 	int regs_off, ip_off, args_off, stack_size = nr_args * 8, run_ctx_off;
 	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
+	void *orig_call = func_addr;
 	u8 **branches = NULL;
 	u8 *prog;
 	bool save_ret;
@@ -2126,12 +2127,10 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 
 	if (flags & BPF_TRAMP_F_IP_ARG) {
 		/* Store IP address of the traced function:
-		 * mov rax, QWORD PTR [rbp + 8]
-		 * sub rax, X86_PATCH_SIZE
+		 * mov rax, func_addr
 		 * mov QWORD PTR [rbp - ip_off], rax
 		 */
-		emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, 8);
-		EMIT4(0x48, 0x83, 0xe8, X86_PATCH_SIZE);
+		emit_mov_imm64(&prog, BPF_REG_0, (long) func_addr >> 32, (u32) (long) func_addr);
 		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -ip_off);
 	}
 
-- 
2.37.3

