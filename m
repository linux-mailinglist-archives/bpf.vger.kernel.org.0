Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9AB58F9D9
	for <lists+bpf@lfdr.de>; Thu, 11 Aug 2022 11:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbiHKJQP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Aug 2022 05:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234791AbiHKJQN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Aug 2022 05:16:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7930045F7C
        for <bpf@vger.kernel.org>; Thu, 11 Aug 2022 02:16:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D94EB81F99
        for <bpf@vger.kernel.org>; Thu, 11 Aug 2022 09:16:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3AFAC433D6;
        Thu, 11 Aug 2022 09:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660209369;
        bh=3FASVVfQe0HPIuhc0YXkL+H00bZ5vqd9naD9HimTqZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RIXn/YQ8J0gzWaBZ9JQ/XHXbSJvnvlqGeP2B4XbPMO0PBLuewgg4lTLLtRr1hAtei
         7YnphhHmUEiPgHWqZb1eCL6yg8olDrB/cC7KL9i4U9bAcnwRJptWoaLUrgtGoIZorq
         8VIaAVXV+EEWkSE6/avbVTEIslaiqhZX4KO+/53sFI0cjW+t4X4XZdDim48gu6CpHr
         jv/ANoSq2aEoJnHvz+GPUeXSLX5ANvZ9/p4hlyTFzWkrQ3/8az+VbvN8ZnCxwF93ae
         IAB71/BFOU6Mg2vgKxpoIUanFPpADO0gar1BRvaBLmVbD+nLWq9il55C9nv4jn3Nbs
         tWJ2MADk1rC5A==
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
Subject: [PATCHv2 bpf-next 3/6] bpf: Use given function address for trampoline ip arg
Date:   Thu, 11 Aug 2022 11:15:23 +0200
Message-Id: <20220811091526.172610-4-jolsa@kernel.org>
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
index c1f6c1c51d99..0194880895aa 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2013,13 +2013,14 @@ static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
 int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *image_end,
 				const struct btf_func_model *m, u32 flags,
 				struct bpf_tramp_links *tlinks,
-				void *orig_call)
+				void *func_addr)
 {
 	int ret, i, nr_args = m->nr_args;
 	int regs_off, ip_off, args_off, stack_size = nr_args * 8, run_ctx_off;
 	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
+	void *orig_call = func_addr;
 	u8 **branches = NULL;
 	u8 *prog;
 	bool save_ret;
@@ -2092,12 +2093,10 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 
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
2.37.1

