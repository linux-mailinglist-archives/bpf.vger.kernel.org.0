Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3E253D3AA
	for <lists+bpf@lfdr.de>; Sat,  4 Jun 2022 00:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344402AbiFCWgu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Jun 2022 18:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243961AbiFCWgt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jun 2022 18:36:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE2BDB3
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 15:36:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA91461B7C
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 22:36:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5CFC3411E
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 22:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654295806;
        bh=MIEAP2ZA3lrNgJhnXHkSkBn1V98z59pbYLC8jQ9CRPc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qAN1RdT/l1FoGEyQGnNXmDFOPEoK4SvOGtR7wpAESKdaLA85Ywy5TH430DqD5UaPh
         4SejuzH12KeGEsq80f3JQ5dX89Iumjksz99+I6PqH73dIqDaFyQa667iahUuMMAFvo
         llMdNyIHIg2ntOFddOVoaZZ+EXcaYj/W60U5CLQheJehqTAfW3jDAuz21X70kLnlZy
         rv011Hy3zVbIX/odXWxfeXDiK1KkD6P/OP/sqmkBKRPbL0hsjxOYlKATlhFFoGoYfB
         ZTyDkfVvsJeO4WcNGdKBv0OQa/VSZL90HIAoTPKOmf9leZpjhYMpoqZ1Fv9I0MzKiv
         1ApK8XS0wgh7g==
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-2f83983782fso95940377b3.6
        for <bpf@vger.kernel.org>; Fri, 03 Jun 2022 15:36:46 -0700 (PDT)
X-Gm-Message-State: AOAM530bj9KmCVbFlmgMiujGRweqi0BEq9bdXc3P+zrX2ftshrR/zFSO
        p57CMfmyOT1Ql7YcT4WlSIvCxxn1HRgBzNzWBag=
X-Google-Smtp-Source: ABdhPJyj5getLQ/x9FQRrGULB8IhQ0dRrCiUb+Zcooyjyot96YtpxVWg38jCmkcqIfSdCVfD7tJRwWqqFeIlk8Xp9k8=
X-Received: by 2002:a81:7505:0:b0:30c:45e3:71bc with SMTP id
 q5-20020a817505000000b0030c45e371bcmr13947068ywc.460.1654295805213; Fri, 03
 Jun 2022 15:36:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220603141047.2163170-1-eddyz87@gmail.com> <20220603141047.2163170-4-eddyz87@gmail.com>
In-Reply-To: <20220603141047.2163170-4-eddyz87@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 3 Jun 2022 15:36:34 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4pBi8GTrH_3eO3s8oHyq8mm81-Q9uC0g1iLpYHiopWgw@mail.gmail.com>
Message-ID: <CAPhsuW4pBi8GTrH_3eO3s8oHyq8mm81-Q9uC0g1iLpYHiopWgw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/5] bpf: Inline calls to bpf_loop when
 callback is known
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 3, 2022 at 7:11 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>

[...]

>
> Measurements using `benchs/run_bench_bpf_loop.sh` inside QEMU / KVM on
> i7-4710HQ CPU show a drop in latency from 14 ns/op to 2 ns/op.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
[...]
>
> -/* maximum number of loops */
> -#define MAX_LOOPS      BIT(23)
> -
>  BPF_CALL_4(bpf_loop, u32, nr_loops, void *, callback_fn, void *, callback_ctx,
>            u64, flags)
>  {
> @@ -733,9 +731,12 @@ BPF_CALL_4(bpf_loop, u32, nr_loops, void *, callback_fn, void *, callback_ctx,
>         u64 ret;
>         u32 i;
>
> +       /* note: these safety checks are also verified when bpf_loop is inlined,
> +        * be careful to modify this code in sync

Let's call out inline_bpf_loop() here to be more clear.

[...]

>

Let's also call out here this the inlined version of bpf_iter.c:bpf_loop

> +static struct bpf_prog *inline_bpf_loop(struct bpf_verifier_env *env,
> +                                       int position, u32 *cnt)
> +{
> +       struct bpf_insn_aux_data *aux = &env->insn_aux_data[position];
> +       s32 stack_base = aux->loop_inline_state.stack_base;
> +       s32 r6_offset = stack_base + 0 * BPF_REG_SIZE;
> +       s32 r7_offset = stack_base + 1 * BPF_REG_SIZE;
> +       s32 r8_offset = stack_base + 2 * BPF_REG_SIZE;
> +       int reg_loop_max = BPF_REG_6;
> +       int reg_loop_cnt = BPF_REG_7;
> +       int reg_loop_ctx = BPF_REG_8;
> +
> +       struct bpf_prog *new_prog;
> +       u32 callback_subprogno = aux->loop_inline_state.callback_subprogno;
> +       u32 callback_start;
> +       u32 call_insn_offset;
> +       s32 callback_offset;
> +       struct bpf_insn insn_buf[19];
> +       struct bpf_insn *next = insn_buf;
> +       struct bpf_insn *call, *jump_to_end, *loop_header;
> +       struct bpf_insn *jump_to_header, *loop_exit;
> +
> +       /* Return error and jump to the end of the patch if
> +        * expected number of iterations is too big.  This
> +        * repeats the check done in bpf_loop helper function,
> +        * be careful to modify this code in sync.
> +        */
> +       (*next++) = BPF_JMP_IMM(BPF_JLE, BPF_REG_1, BPF_MAX_LOOPS, 2);
> +       (*next++) = BPF_MOV32_IMM(BPF_REG_0, -E2BIG);
> +       jump_to_end = next;
> +       (*next++) = BPF_JMP_IMM(BPF_JA, 0, 0, 0 /* set below */);
> +       /* spill R6, R7, R8 to use these as loop vars */
> +       (*next++) = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_6, r6_offset);
> +       (*next++) = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_7, r7_offset);
> +       (*next++) = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_8, r8_offset);
> +       /* initialize loop vars */
> +       (*next++) = BPF_MOV64_REG(reg_loop_max, BPF_REG_1);
> +       (*next++) = BPF_MOV32_IMM(reg_loop_cnt, 0);
> +       (*next++) = BPF_MOV64_REG(reg_loop_ctx, BPF_REG_3);
> +       /* loop header;
> +        * if reg_loop_cnt >= reg_loop_max skip the loop body
> +        */
> +       loop_header = next;
> +       (*next++) = BPF_JMP_REG(BPF_JGE, reg_loop_cnt, reg_loop_max,
> +                               0 /* set below */);
> +       /* callback call */
> +       (*next++) = BPF_MOV64_REG(BPF_REG_1, reg_loop_cnt);
> +       (*next++) = BPF_MOV64_REG(BPF_REG_2, reg_loop_ctx);
> +       call = next;
> +       (*next++) = BPF_CALL_REL(0 /* set below after patching */);
> +       /* increment loop counter */
> +       (*next++) = BPF_ALU64_IMM(BPF_ADD, reg_loop_cnt, 1);
> +       /* jump to loop header if callback returned 0 */
> +       jump_to_header = next;
> +       (*next++) = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 0 /* set below */);
> +       /* return value of bpf_loop;
> +        * set R0 to the number of iterations
> +        */
> +       loop_exit = next;
> +       (*next++) = BPF_MOV64_REG(BPF_REG_0, reg_loop_cnt);
> +       /* restore original values of R6, R7, R8 */
> +       (*next++) = BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_10, r6_offset);
> +       (*next++) = BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_10, r7_offset);
> +       (*next++) = BPF_LDX_MEM(BPF_DW, BPF_REG_8, BPF_REG_10, r8_offset);
> +
> +       *cnt = next - insn_buf;
> +       if (*cnt > ARRAY_SIZE(insn_buf)) {
> +               WARN_ONCE(1, "BUG %s: 'next' exceeds bounds for 'insn_buf'\n",
> +                         __func__);
> +               return NULL;
> +       }
> +       jump_to_end->off = next - jump_to_end - 1;
> +       loop_header->off = loop_exit - loop_header - 1;
> +       jump_to_header->off = loop_header - jump_to_header - 1;

I know these changes are made based on my feedback on v1. But it seems
v1 is actually cleaner. How about we use v1, but add comments on offsets that
need to redo when we make changes to insn_buf[]?



> +
> +       new_prog = bpf_patch_insn_data(env, position, insn_buf, *cnt);
> +       if (!new_prog)
> +               return new_prog;
> +
> +       /* callback start is known only after patching */
> +       callback_start = env->subprog_info[callback_subprogno].start;
> +       call_insn_offset = position + (call - insn_buf);
> +       callback_offset = callback_start - call_insn_offset - 1;
> +       env->prog->insnsi[call_insn_offset].imm = callback_offset;
> +
> +       return new_prog;
> +}
> +
>  /* Do various post-verification rewrites in a single program pass.
>   * These rewrites simplify JIT and interpreter implementations.
>   */
> @@ -14258,6 +14432,18 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>                         continue;
>                 }
>
> +               if (insn->imm == BPF_FUNC_loop &&
> +                   fit_for_bpf_loop_inline(&env->insn_aux_data[i + delta])) {
> +                       new_prog = inline_bpf_loop(env, i + delta, &cnt);
> +                       if (!new_prog)
> +                               return -ENOMEM;
> +
> +                       delta    += cnt - 1;
> +                       env->prog = prog = new_prog;
> +                       insn      = new_prog->insnsi + i + delta;
> +                       continue;
> +               }
> +
>  patch_call_imm:
>                 fn = env->ops->get_func_proto(insn->imm, env->prog);
>                 /* all functions that have prototype and verifier allowed
> @@ -15030,6 +15216,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr)
>         if (ret == 0)
>                 ret = check_max_stack_depth(env);
>
> +       if (ret == 0)
> +               adjust_stack_depth_for_loop_inlining(env);
> +
>         /* instruction rewrites happen after this point */
>         if (is_priv) {
>                 if (ret == 0)
> --
> 2.25.1
>
