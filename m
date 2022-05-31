Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2EE753995F
	for <lists+bpf@lfdr.de>; Wed,  1 Jun 2022 00:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiEaWKf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 May 2022 18:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348334AbiEaWKd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 May 2022 18:10:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0D89CF75
        for <bpf@vger.kernel.org>; Tue, 31 May 2022 15:10:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C54D161411
        for <bpf@vger.kernel.org>; Tue, 31 May 2022 22:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3412EC385A9
        for <bpf@vger.kernel.org>; Tue, 31 May 2022 22:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654035031;
        bh=qHCb7kYRoXeGCPVBv2+M5Wy88Kx31lZ3P8HtZKDvQF8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kZv8i5vSgJ/7bM3Plg2jbdZoZj9JscoYhBPM+wzgFI4tYTLQBnkY39PXbXnUOmYqT
         IJK3ZiotV+auyRb9PXCBBFeLIsxlFYg5tiwOsVMNWvTeHfltAEUFGISBAgyRfBJq8+
         0e2uzCNvfDNRbuMOEGneZwgr3GHI/YqLfLAxOMX2ICZBN//GqxOlHeXpxg3HlyJIz4
         0ZvBXUiEXkv3brVEnd8E2/akNPMk9CYaMqeetS/XoTEH46j1OutsXxbLzCh5Em+50E
         QhSzmsskutDuUI4gYS/epg62Rebo7ZQSCTiL1cYE7jGG/R5vulBvuCAXSqpHVgcNbw
         CWb+UkuJ8eu+w==
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-30c1c9b9b6cso90571097b3.13
        for <bpf@vger.kernel.org>; Tue, 31 May 2022 15:10:31 -0700 (PDT)
X-Gm-Message-State: AOAM5323wy6DYcIy6ukzhC5lXZhLstSha8GQhovWRwNdCLcnvISP+cNR
        ijO7urDfYYkVQXaw/dWmCnN5iCWgph54W7Q1TtU=
X-Google-Smtp-Source: ABdhPJxpESs+alkHsd+lWqlt689NSRvlWkna/Flsqch+NhvQwVYdTLgyo8yvYIv/i20bRmnd8QfsKleyfLaEG/aRxCU=
X-Received: by 2002:a81:4a82:0:b0:2ff:94b4:b4d1 with SMTP id
 x124-20020a814a82000000b002ff94b4b4d1mr59190854ywa.130.1654035030163; Tue, 31
 May 2022 15:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220529223646.862464-1-eddyz87@gmail.com> <20220529223646.862464-4-eddyz87@gmail.com>
In-Reply-To: <20220529223646.862464-4-eddyz87@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 31 May 2022 15:10:19 -0700
X-Gmail-Original-Message-ID: <CAPhsuW66_coKcYi-NmKx86BqzEv-bd1b-jzaMAJk--QpWnLH3w@mail.gmail.com>
Message-ID: <CAPhsuW66_coKcYi-NmKx86BqzEv-bd1b-jzaMAJk--QpWnLH3w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] bpf: Inline calls to bpf_loop when
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

On Sun, May 29, 2022 at 3:37 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
[...]
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Please put kernel changes, test_prog changes, and test_verifier changes to 3
separate patches.

> ---
>  include/linux/bpf_verifier.h                  |  16 ++
>  kernel/bpf/bpf_iter.c                         |   9 +-
>  kernel/bpf/verifier.c                         | 184 ++++++++++++-
>  .../selftests/bpf/prog_tests/bpf_loop.c       |  62 +++++
>  tools/testing/selftests/bpf/progs/bpf_loop.c  | 122 +++++++++
>  .../selftests/bpf/verifier/bpf_loop_inline.c  | 244 ++++++++++++++++++
>  6 files changed, 628 insertions(+), 9 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/verifier/bpf_loop_inline.c
[...]
> +/* For all sub-programs in the program (including main) checks
> + * insn_aux_data to see if there are bpf_loop calls that require
> + * inlining. If such calls are found subprog stack_depth is increased
> + * by the size of 3 registers. Reserved space would be used in the
> + * do_misc_fixups to spill values of the R6, R7, R8 to use these
> + * registers for loop iteration.
> + */
> +static void adjust_stack_depth_for_loop_inlining(struct bpf_verifier_env *env)
> +{
> +       int i, subprog_end, cur_subprog = 0;
> +       struct bpf_subprog_info *subprogs = env->subprog_info;
> +       int insn_cnt = env->prog->len;
> +       bool proc_updated = false;

nit: I guess this should be called subprog_updated?

> +       s32 stack_base;
> +
> +       subprog_end = (env->subprog_cnt > 1
> +                      ? subprogs[cur_subprog + 1].start
> +                      : insn_cnt);
> +       for (i = 0; i < insn_cnt; i++) {
> +               struct bpf_insn_aux_data *aux = &env->insn_aux_data[i];
> +

[...]

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
> +
> +       struct bpf_insn insn_buf[] = {
> +               /* Return error and jump to the end of the patch if
> +                * expected number of iterations is too big.  This
> +                * repeats the check done in bpf_loop helper function,
> +                * be careful to modify this code in sync.
> +                */
> +               BPF_JMP_IMM(BPF_JLE, BPF_REG_1, BPF_MAX_LOOPS, 2),
> +               BPF_MOV32_IMM(BPF_REG_0, -E2BIG),
> +               BPF_JMP_IMM(BPF_JA, 0, 0, 16),
> +               /* spill R6, R7, R8 to use these as loop vars */
> +               BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_6, r6_offset),
> +               BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_7, r7_offset),
> +               BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_8, r8_offset),
> +               /* initialize loop vars */
> +               BPF_MOV64_REG(reg_loop_max, BPF_REG_1),
> +               BPF_MOV32_IMM(reg_loop_cnt, 0),
> +               BPF_MOV64_REG(reg_loop_ctx, BPF_REG_3),
> +               /* loop header,
> +                * if reg_loop_cnt >= reg_loop_max skip the loop body
> +                */
> +               BPF_JMP_REG(BPF_JGE, reg_loop_cnt, reg_loop_max, 5),
> +               /* callback call,
> +                * correct callback offset would be set after patching
> +                */
> +               BPF_MOV64_REG(BPF_REG_1, reg_loop_cnt),
> +               BPF_MOV64_REG(BPF_REG_2, reg_loop_ctx),
> +               BPF_CALL_REL(0),
> +               /* increment loop counter */
> +               BPF_ALU64_IMM(BPF_ADD, reg_loop_cnt, 1),
> +               /* jump to loop header if callback returned 0 */
> +               BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, -6),
> +               /* return value of bpf_loop,
> +                * set R0 to the number of iterations
> +                */
> +               BPF_MOV64_REG(BPF_REG_0, reg_loop_cnt),
> +               /* restore original values of R6, R7, R8 */
> +               BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_10, r6_offset),
> +               BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_10, r7_offset),
> +               BPF_LDX_MEM(BPF_DW, BPF_REG_8, BPF_REG_10, r8_offset),
> +       };
> +
> +       *cnt = ARRAY_SIZE(insn_buf);
> +       new_prog = bpf_patch_insn_data(env, position, insn_buf, *cnt);
> +       if (!new_prog)
> +               return new_prog;
> +
> +       /* callback start is known only after patching */
> +       callback_start = env->subprog_info[callback_subprogno].start;
> +       call_insn_offset = position + 12;

IIUC, magic number 12 is calculated based on the content of insn_buf.
Can we make this more robust for future changes? We should at least
add a comment here.

> +       callback_offset = callback_start - call_insn_offset - 1;
> +       env->prog->insnsi[call_insn_offset].imm = callback_offset;
> +
> +       return new_prog;
> +}
> +
>  /* Do various post-verification rewrites in a single program pass.
>   * These rewrites simplify JIT and interpreter implementations.
>   */
> @@ -14258,6 +14417,18 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
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
> @@ -15030,6 +15201,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr)
>         if (ret == 0)
>                 ret = check_max_stack_depth(env);
>
> +       if (ret == 0)
> +               adjust_stack_depth_for_loop_inlining(env);
> +
>         /* instruction rewrites happen after this point */
>         if (is_priv) {
>                 if (ret == 0)
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_loop.c b/tools/testing/selftests/bpf/prog_tests/bpf_loop.c
> index 380d7a2072e3..1caa495be48c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_loop.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_loop.c
> @@ -120,6 +120,64 @@ static void check_nested_calls(struct bpf_loop *skel)
>         bpf_link__destroy(link);
>  }
>
> +static void check_non_constant_callback(struct bpf_loop *skel)
> +{
> +       struct bpf_link *link =
> +               bpf_program__attach(skel->progs.prog_non_constant_callback);
> +
> +       if (!ASSERT_OK_PTR(link, "link"))
> +               return;
> +
> +       skel->bss->callback_selector = 0x0F;
> +       usleep(1);
> +       ASSERT_EQ(skel->bss->g_output, 0x0F, "g_output #1");
> +
> +       skel->bss->callback_selector = 0xF0;
> +       usleep(1);
> +       ASSERT_EQ(skel->bss->g_output, 0xF0, "g_output #2");
> +
> +       bpf_link__destroy(link);
> +}
> +
> +static void check_stack(struct bpf_loop *skel)
> +{
> +       struct bpf_link *link =
> +               bpf_program__attach(skel->progs.stack_check);
> +
> +       if (!ASSERT_OK_PTR(link, "link"))
> +               goto out;

We can just return here.

> +
> +       int map_fd = bpf_map__fd(skel->maps.map1);
Please move variable definition to the beginning of the function.

> +
> +       if (!ASSERT_GE(map_fd, 0, "bpf_map__fd"))
> +               goto out;
> +
> +       for (int key = 1; key <= 16; ++key) {
> +               int val = key;
> +               int err = bpf_map_update_elem(map_fd, &key, &val, BPF_NOEXIST);
> +
> +               if (!ASSERT_OK(err, "bpf_map_update_elem"))
> +                       goto out;
> +       }
> +
> +       usleep(1);
> +
> +       for (int key = 1; key <= 16; ++key) {
> +               int val;
> +               int err = bpf_map_lookup_elem(map_fd, &key, &val);
> +
> +               if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
> +                       goto out;
> +               ASSERT_EQ(val, key + 1, "bad value in the map");
> +       }
> +
> +out:
> +       if (map_fd >= 0)
> +               close(map_fd);

map1 is part of the skeleton, we should not close it here.

> +       if (link)
> +               bpf_link__destroy(link);

No need to check "if (link)"

> +}
> +
>  void test_bpf_loop(void)
>  {
>         struct bpf_loop *skel;
> @@ -140,6 +198,10 @@ void test_bpf_loop(void)
>                 check_invalid_flags(skel);
>         if (test__start_subtest("check_nested_calls"))
>                 check_nested_calls(skel);
> +       if (test__start_subtest("check_non_constant_callback"))
> +               check_non_constant_callback(skel);
> +       if (test__start_subtest("check_stack"))
> +               check_stack(skel);
>
>         bpf_loop__destroy(skel);
>  }

[...]
