Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F0C53D3AD
	for <lists+bpf@lfdr.de>; Sat,  4 Jun 2022 00:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347161AbiFCWiv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Jun 2022 18:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243961AbiFCWiu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jun 2022 18:38:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3517C3879F
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 15:38:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7352B824CB
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 22:38:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF54EC34115
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 22:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654295926;
        bh=7sfpTmn4C3OGacyEMMvo8ZPFpES6bm/4Xa5OciqZ+Ag=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qbUfIM2jigmnxFIc+oPv70QJ1JSiuWa36DzSttLwA32QTJCaHaqDvK3nDN1G97iGh
         ZFwrstMLQ8KLB108rmjlgwlGEIztI2Y3XpxSAvrVv8u2CDugkx9oDWc9Qxf3dOfMaH
         yA9g9luk3D2LBNDCkH/DhkYZ1at+KnfRIyhoAfxE+2dJPxYluwtMnKwIkLGy4NrlnE
         qM5mfh0Z01t5OWnSkthtRmqxkulXfhfHFrXlZW13iqmtJXDkKMb8htr4F8w7GKNSGB
         kwqpD77m8UTnkTo2pBgaWthKekVEnmsASzdZIP6em6tL5NqcpH36me48Tnevcc4JY8
         7/Ogev5frKiJQ==
Received: by mail-yb1-f175.google.com with SMTP id g4so16104024ybf.12
        for <bpf@vger.kernel.org>; Fri, 03 Jun 2022 15:38:46 -0700 (PDT)
X-Gm-Message-State: AOAM5322+pzCwSYrQOfrQ4QUTI892HEtuzhDRcMtluWn+C9qlbAOIaxt
        VXBnNRwcAWeVDnOMYnuc+oWDE/KTM1QzBoW5xgU=
X-Google-Smtp-Source: ABdhPJzULd1Jxu/kc15QsnhttdiZWLrUCcOOdLg0dH82SD+YRLot7LmsbbvnhL1lTlW04COTkMnI8UWDD3Z/O0l/IsI=
X-Received: by 2002:a25:8303:0:b0:65c:c9f7:3dbc with SMTP id
 s3-20020a258303000000b0065cc9f73dbcmr12444913ybk.259.1654295925680; Fri, 03
 Jun 2022 15:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220603141047.2163170-1-eddyz87@gmail.com> <20220603141047.2163170-5-eddyz87@gmail.com>
In-Reply-To: <20220603141047.2163170-5-eddyz87@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 3 Jun 2022 15:38:35 -0700
X-Gmail-Original-Message-ID: <CAPhsuW66Ry3BjEi3tC960Kx8ZkKAtcdsJEwVtMt3Tiqx6Wioww@mail.gmail.com>
Message-ID: <CAPhsuW66Ry3BjEi3tC960Kx8ZkKAtcdsJEwVtMt3Tiqx6Wioww@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/5] selftests/bpf: BPF test_verifier
 selftests for bpf_loop inlining
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 3, 2022 at 7:11 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> A number of test cases for BPF selftests test_verifier to check how
> bpf_loop inline transformation rewrites the BPF program. The following
> cases are covered:
>  - happy path
>  - no-rewrite when flags is non-zero
>  - no-rewrite when callback is non-constant
>  - subprogno in insn_aux is updated correctly when dead sub-programs
>    are removed
>  - check that correct stack offsets are assigned for spilling of R6-R8
>    registers
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  .../selftests/bpf/verifier/bpf_loop_inline.c  | 244 ++++++++++++++++++
>  1 file changed, 244 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/verifier/bpf_loop_inline.c
>
> diff --git a/tools/testing/selftests/bpf/verifier/bpf_loop_inline.c b/tools/testing/selftests/bpf/verifier/bpf_loop_inline.c
> new file mode 100644
> index 000000000000..d1fbcfef69f2
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/verifier/bpf_loop_inline.c
> @@ -0,0 +1,244 @@
> +#define BTF_TYPES \
> +       .btf_strings = "\0int\0i\0ctx\0callback\0main\0", \
> +       .btf_types = { \
> +       /* 1: int   */ BTF_TYPE_INT_ENC(1, BTF_INT_SIGNED, 0, 32, 4), \
> +       /* 2: int*  */ BTF_PTR_ENC(1), \
> +       /* 3: void* */ BTF_PTR_ENC(0), \
> +       /* 4: int __(void*) */ BTF_FUNC_PROTO_ENC(1, 1), \
> +               BTF_FUNC_PROTO_ARG_ENC(7, 3), \
> +       /* 5: int __(int, int*) */ BTF_FUNC_PROTO_ENC(1, 2), \
> +               BTF_FUNC_PROTO_ARG_ENC(5, 1), \
> +               BTF_FUNC_PROTO_ARG_ENC(7, 2), \
> +       /* 6: main      */ BTF_FUNC_ENC(20, 4), \
> +       /* 7: callback  */ BTF_FUNC_ENC(11, 5), \
> +       BTF_END_RAW \
> +       }
> +
> +#define MAIN_TYPE      6
> +#define CALLBACK_TYPE  7
> +
> +/* can't use BPF_CALL_REL, jit_subprogs adjusts IMM & OFF
> + * fields for pseudo calls
> + */
> +#define PSEUDO_CALL_INSN() \
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_CALL, \
> +                    INSN_OFF_MASK, INSN_IMM_MASK)
> +
> +/* can't use BPF_FUNC_loop constant,
> + * do_mix_fixups adjusts the IMM field
> + */
> +#define HELPER_CALL_INSN() \
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, INSN_OFF_MASK, INSN_IMM_MASK)
> +
> +{
> +       "inline simple bpf_loop call",
> +       .insns = {
> +       /* main */
> +       /* force verifier state branching to verify logic on first and
> +        * subsequent bpf_loop insn processing steps
> +        */
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
> +       BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 777, 2),
> +       BPF_ALU64_IMM(BPF_MOV, BPF_REG_1, 1),
> +       BPF_JMP_IMM(BPF_JA, 0, 0, 1),
> +       BPF_ALU64_IMM(BPF_MOV, BPF_REG_1, 2),
> +
> +       BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2, BPF_PSEUDO_FUNC, 0, 6),
> +       BPF_RAW_INSN(0, 0, 0, 0, 0),
> +       BPF_ALU64_IMM(BPF_MOV, BPF_REG_3, 0),
> +       BPF_ALU64_IMM(BPF_MOV, BPF_REG_4, 0),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_loop),
> +       BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0),
> +       BPF_EXIT_INSN(),
> +       /* callback */
> +       BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 1),
> +       BPF_EXIT_INSN(),
> +       },
> +       .expected_insns = { PSEUDO_CALL_INSN() },
> +       .unexpected_insns = { HELPER_CALL_INSN() },
> +       .prog_type = BPF_PROG_TYPE_TRACEPOINT,
> +       .result = ACCEPT,
> +       .runs = 0,
> +       .func_info = { { 0, MAIN_TYPE }, { 12, CALLBACK_TYPE } },
> +       .func_info_cnt = 2,
> +       BTF_TYPES
> +},
> +{
> +       "don't inline bpf_loop call, flags non-zero",
> +       .insns = {
> +       /* main */
> +       BPF_ALU64_IMM(BPF_MOV, BPF_REG_1, 1),
> +       BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2, BPF_PSEUDO_FUNC, 0, 6),
> +       BPF_RAW_INSN(0, 0, 0, 0, 0),
> +       BPF_ALU64_IMM(BPF_MOV, BPF_REG_3, 0),
> +       BPF_ALU64_IMM(BPF_MOV, BPF_REG_4, 1),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_loop),
> +       BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0),
> +       BPF_EXIT_INSN(),
> +       /* callback */
> +       BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 1),
> +       BPF_EXIT_INSN(),
> +       },
> +       .expected_insns = { HELPER_CALL_INSN() },
> +       .unexpected_insns = { PSEUDO_CALL_INSN() },
> +       .prog_type = BPF_PROG_TYPE_TRACEPOINT,
> +       .result = ACCEPT,
> +       .runs = 0,
> +       .func_info = { { 0, MAIN_TYPE }, { 8, CALLBACK_TYPE } },
> +       .func_info_cnt = 2,
> +       BTF_TYPES
> +},
> +{
> +       "don't inline bpf_loop call, callback non-constant",
> +       .insns = {
> +       /* main */
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
> +       BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 777, 4), /* pick a random callback */
> +
> +       BPF_ALU64_IMM(BPF_MOV, BPF_REG_1, 1),
> +       BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2, BPF_PSEUDO_FUNC, 0, 10),
> +       BPF_RAW_INSN(0, 0, 0, 0, 0),
> +       BPF_JMP_IMM(BPF_JA, 0, 0, 3),
> +
> +       BPF_ALU64_IMM(BPF_MOV, BPF_REG_1, 1),
> +       BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2, BPF_PSEUDO_FUNC, 0, 8),
> +       BPF_RAW_INSN(0, 0, 0, 0, 0),
> +
> +       BPF_ALU64_IMM(BPF_MOV, BPF_REG_3, 0),
> +       BPF_ALU64_IMM(BPF_MOV, BPF_REG_4, 0),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_loop),
> +       BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0),
> +       BPF_EXIT_INSN(),
> +       /* callback */
> +       BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 1),
> +       BPF_EXIT_INSN(),
> +       /* callback #2 */
> +       BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 1),
> +       BPF_EXIT_INSN(),
> +       },
> +       .expected_insns = { HELPER_CALL_INSN() },
> +       .unexpected_insns = { PSEUDO_CALL_INSN() },
> +       .prog_type = BPF_PROG_TYPE_TRACEPOINT,
> +       .result = ACCEPT,
> +       .runs = 0,
> +       .func_info = {
> +               { 0, MAIN_TYPE },
> +               { 14, CALLBACK_TYPE },
> +               { 16, CALLBACK_TYPE }
> +       },
> +       .func_info_cnt = 3,
> +       BTF_TYPES
> +},
> +{
> +       "bpf_loop_inline and a dead func",
> +       .insns = {
> +       /* main */
> +
> +       /* A reference to callback #1 to make verifier count it as a func.
> +        * This reference is overwritten below and callback #1 is dead.
> +        */
> +       BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2, BPF_PSEUDO_FUNC, 0, 9),
> +       BPF_RAW_INSN(0, 0, 0, 0, 0),
> +       BPF_ALU64_IMM(BPF_MOV, BPF_REG_1, 1),
> +       BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2, BPF_PSEUDO_FUNC, 0, 8),
> +       BPF_RAW_INSN(0, 0, 0, 0, 0),
> +       BPF_ALU64_IMM(BPF_MOV, BPF_REG_3, 0),
> +       BPF_ALU64_IMM(BPF_MOV, BPF_REG_4, 0),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_loop),
> +       BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0),
> +       BPF_EXIT_INSN(),
> +       /* callback */
> +       BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 1),
> +       BPF_EXIT_INSN(),
> +       /* callback #2 */
> +       BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 1),
> +       BPF_EXIT_INSN(),
> +       },
> +       .expected_insns = { PSEUDO_CALL_INSN() },
> +       .unexpected_insns = { HELPER_CALL_INSN() },
> +       .prog_type = BPF_PROG_TYPE_TRACEPOINT,
> +       .result = ACCEPT,
> +       .runs = 0,
> +       .func_info = {
> +               { 0, MAIN_TYPE },
> +               { 10, CALLBACK_TYPE },
> +               { 12, CALLBACK_TYPE }
> +       },
> +       .func_info_cnt = 3,
> +       BTF_TYPES
> +},
> +{
> +       "bpf_loop_inline stack locations for loop vars",
> +       .insns = {
> +       /* main */
> +       BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, 0x77),
> +       /* bpf_loop call #1 */
> +       BPF_ALU64_IMM(BPF_MOV, BPF_REG_1, 1),
> +       BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2, BPF_PSEUDO_FUNC, 0, 22),
> +       BPF_RAW_INSN(0, 0, 0, 0, 0),
> +       BPF_ALU64_IMM(BPF_MOV, BPF_REG_3, 0),
> +       BPF_ALU64_IMM(BPF_MOV, BPF_REG_4, 0),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_loop),
> +       /* bpf_loop call #2 */
> +       BPF_ALU64_IMM(BPF_MOV, BPF_REG_1, 2),
> +       BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2, BPF_PSEUDO_FUNC, 0, 16),
> +       BPF_RAW_INSN(0, 0, 0, 0, 0),
> +       BPF_ALU64_IMM(BPF_MOV, BPF_REG_3, 0),
> +       BPF_ALU64_IMM(BPF_MOV, BPF_REG_4, 0),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_loop),
> +       /* call func and exit */
> +       BPF_CALL_REL(2),
> +       BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0),
> +       BPF_EXIT_INSN(),
> +       /* func */
> +       BPF_ST_MEM(BPF_DW, BPF_REG_10, -32, 0x55),
> +       BPF_ALU64_IMM(BPF_MOV, BPF_REG_1, 2),
> +       BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2, BPF_PSEUDO_FUNC, 0, 6),
> +       BPF_RAW_INSN(0, 0, 0, 0, 0),
> +       BPF_ALU64_IMM(BPF_MOV, BPF_REG_3, 0),
> +       BPF_ALU64_IMM(BPF_MOV, BPF_REG_4, 0),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_loop),
> +       BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0),
> +       BPF_EXIT_INSN(),
> +       /* callback */
> +       BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 1),
> +       BPF_EXIT_INSN(),
> +       },
> +       .expected_insns = {
> +       BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, 0x77),
> +       SKIP_INSNS(),
> +       BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_6, -40),
> +       BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_7, -32),
> +       BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_8, -24),
> +       SKIP_INSNS(),
> +       /* offsets are the same as in the first call */
> +       BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_6, -40),
> +       BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_7, -32),
> +       BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_8, -24),
> +       SKIP_INSNS(),
> +       BPF_ST_MEM(BPF_DW, BPF_REG_10, -32, 0x55),
> +       SKIP_INSNS(),
> +       /* offsets differ from main because of different offset
> +        * in BPF_ST_MEM instruction
> +        */
> +       BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_6, -56),
> +       BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_7, -48),
> +       BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_8, -40),
> +       },
> +       .unexpected_insns = { HELPER_CALL_INSN() },
> +       .prog_type = BPF_PROG_TYPE_TRACEPOINT,
> +       .result = ACCEPT,
> +       .func_info = {
> +               { 0, MAIN_TYPE },
> +               { 16, MAIN_TYPE },
> +               { 25, CALLBACK_TYPE },
> +       },
> +       .func_info_cnt = 3,
> +       BTF_TYPES
> +},
> +
> +#undef HELPER_CALL_INSN
> +#undef PSEUDO_CALL_INSN
> +#undef CALLBACK_TYPE
> +#undef MAIN_TYPE
> +#undef BTF_TYPES
> --
> 2.25.1
>
