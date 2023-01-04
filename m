Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0844E65E0B0
	for <lists+bpf@lfdr.de>; Thu,  5 Jan 2023 00:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbjADW7a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 17:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234958AbjADW7F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 17:59:05 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD51B1EEEF
        for <bpf@vger.kernel.org>; Wed,  4 Jan 2023 14:58:38 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id b3so52638945lfv.2
        for <bpf@vger.kernel.org>; Wed, 04 Jan 2023 14:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d4KZ9970Dwph1RDx1AVMPYeNJMWTh7iVn1HOGDTuBsE=;
        b=TODqCjK52tv+ZVoMAcpmxSCxMFJmsPRWcs6hDp66T2mnIKW1qthyg2Ari1dxWyn88Z
         Vl/NlkAF0W+kEwKZFJJAwakrWKuNhVn1d1U5K4CLDxkD3l+x6rKRZ0GzMLSfdGrD7VxE
         rmQ1wUHbIUkS4I5Hxuu++05qNGf7hTHMurTivCEddzpt4cBshDQ3FbhJfIwgiPYCNho+
         DG6G3xDXhnCSM3FHcJfmgrfEXD2MCuVf3OAXEL/llYu/94dGfGFu8raBIi9vNJAObPAO
         QJOotuX8pqyaijkQQiyMKPt5dlhagmFIWfDR3LnzyAjZQtsMRM2IhXZoKQdxJ+6S2ahR
         0RJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d4KZ9970Dwph1RDx1AVMPYeNJMWTh7iVn1HOGDTuBsE=;
        b=sIE4KjpocBxgUF5y90LJqHU6sv+OT7haUpF962zOqYJN5ynnSwwM2TTgNNtVkBoCeP
         VFl+DGXp6S3mufNrmtFguPKSdr8BDNx919jRkft/0Pg0DctXdBNqCBz1BQIySUgTRVc/
         ZujsohruaARHsT0kDb6VzQdLFVOiWktzRY5mdyjdFhO1/wsMlDiyWSluNyQtoonvoUK6
         IE17Ux/Z0lX5CuTSV/O0dPuNDYokvsSar/qv/r8eJMws7uzNb4WZg3V0qtz48qXcy8x2
         nZOnuXlcd9tcmGmwpr7xDLpkgQNPzrc5K0InEvJprzFbR9fTrbh4j3HftJGk2O1BUr8U
         7sfg==
X-Gm-Message-State: AFqh2koGd4+9k/4SrcjQ6ot0RDP4cfyedC9fQUAJDY3F3r6Y+VSKiA0L
        syr3U9ltFLoATnTIKTKNmV+k4c+qK8H/DFS+lrme0Hfu
X-Google-Smtp-Source: AMrXdXs/CYzbYPtifMs8aAYHj7FtCFoVfvDiLgtnsE0MaX3UBPtJYQrXhazQlQ9k/4D1gDbdsXKKcpObsVWs5eMNAmg=
X-Received: by 2002:a05:6402:500f:b0:46a:e6e3:b3cf with SMTP id
 p15-20020a056402500f00b0046ae6e3b3cfmr4587973eda.333.1672872582460; Wed, 04
 Jan 2023 14:49:42 -0800 (PST)
MIME-Version: 1.0
References: <20230101083403.332783-1-memxor@gmail.com> <20230101083403.332783-6-memxor@gmail.com>
In-Reply-To: <20230101083403.332783-6-memxor@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 4 Jan 2023 14:49:30 -0800
Message-ID: <CAEf4Bzac9u4VDMVkuWutY5cGUMpRoxvpszy_gi6OZyXXP=Sp7Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 5/8] selftests/bpf: Add dynptr pruning tests
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jan 1, 2023 at 12:34 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Add verifier tests that verify the new pruning behavior for STACK_DYNPTR
> slots, and ensure that state equivalence takes into account changes to
> the old and current verifier state correctly.
>
> Without the prior fixes, both of these bugs trigger with unprivileged
> BPF mode.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  tools/testing/selftests/bpf/verifier/dynptr.c | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/verifier/dynptr.c
>
> diff --git a/tools/testing/selftests/bpf/verifier/dynptr.c b/tools/testing/selftests/bpf/verifier/dynptr.c
> new file mode 100644
> index 000000000000..798f4f7e0c57
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/verifier/dynptr.c
> @@ -0,0 +1,90 @@
> +{
> +       "dynptr: rewrite dynptr slot",
> +        .insns = {
> +        BPF_MOV64_IMM(BPF_REG_0, 0),
> +        BPF_LD_MAP_FD(BPF_REG_6, 0),
> +        BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
> +        BPF_MOV64_IMM(BPF_REG_2, 8),
> +        BPF_MOV64_IMM(BPF_REG_3, 0),
> +        BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
> +        BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -16),
> +        BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_reserve_dynptr),
> +        BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
> +        BPF_JMP_IMM(BPF_JA, 0, 0, 1),
> +        BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, 0xeB9F),
> +        BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
> +        BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -16),
> +        BPF_MOV64_IMM(BPF_REG_2, 0),
> +        BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_discard_dynptr),
> +        BPF_MOV64_IMM(BPF_REG_0, 0),
> +        BPF_EXIT_INSN(),
> +        },
> +       .fixup_map_ringbuf = { 1 },
> +       .result_unpriv = REJECT,
> +       .errstr_unpriv = "unknown func bpf_ringbuf_reserve_dynptr#198",
> +       .result = REJECT,
> +       .errstr = "arg 1 is an unacquired reference",
> +},
> +{
> +       "dynptr: type confusion",
> +       .insns = {
> +       BPF_MOV64_IMM(BPF_REG_0, 0),
> +       BPF_LD_MAP_FD(BPF_REG_6, 0),
> +       BPF_LD_MAP_FD(BPF_REG_7, 0),
> +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
> +       BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
> +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
> +       BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
> +       BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
> +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, -24),
> +       BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, 0xeB9FeB9F),
> +       BPF_ST_MEM(BPF_DW, BPF_REG_10, -24, 0xeB9FeB9F),
> +       BPF_MOV64_IMM(BPF_REG_4, 0),
> +       BPF_MOV64_REG(BPF_REG_8, BPF_REG_2),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_update_elem),
> +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
> +       BPF_MOV64_REG(BPF_REG_2, BPF_REG_8),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
> +       BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
> +       BPF_EXIT_INSN(),
> +       BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
> +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
> +       BPF_MOV64_IMM(BPF_REG_2, 8),
> +       BPF_MOV64_IMM(BPF_REG_3, 0),
> +       BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
> +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -16),
> +       BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_reserve_dynptr),
> +       BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
> +       /* pad with insns to trigger add_new_state heuristic for straight line path */
> +       BPF_MOV64_REG(BPF_REG_8, BPF_REG_8),
> +       BPF_MOV64_REG(BPF_REG_8, BPF_REG_8),
> +       BPF_MOV64_REG(BPF_REG_8, BPF_REG_8),
> +       BPF_MOV64_REG(BPF_REG_8, BPF_REG_8),
> +       BPF_MOV64_REG(BPF_REG_8, BPF_REG_8),
> +       BPF_MOV64_REG(BPF_REG_8, BPF_REG_8),
> +       BPF_MOV64_REG(BPF_REG_8, BPF_REG_8),
> +       BPF_JMP_IMM(BPF_JA, 0, 0, 9),
> +       BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
> +       BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, 0),
> +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
> +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
> +       BPF_MOV64_IMM(BPF_REG_2, 0),
> +       BPF_MOV64_IMM(BPF_REG_3, 0),
> +       BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),
> +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -16),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_dynptr_from_mem),
> +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
> +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -16),
> +       BPF_MOV64_IMM(BPF_REG_2, 0),
> +       BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_discard_dynptr),
> +       BPF_MOV64_IMM(BPF_REG_0, 0),
> +       BPF_EXIT_INSN(),
> +       },
> +       .fixup_map_hash_16b = { 1 },
> +       .fixup_map_ringbuf = { 3 },
> +       .result_unpriv = REJECT,
> +       .errstr_unpriv = "unknown func bpf_ringbuf_reserve_dynptr#198",
> +       .result = REJECT,
> +       .errstr = "arg 1 is an unacquired reference",
> +},

have you tried to write these tests as embedded assembly in .bpf.c,
using __attribute__((naked)) and __failure and __msg("")
infrastructure? Eduard is working towards converting test_verifier's
test to this __naked + embed asm approach, so we might want to start
adding new tests in such form anyways? And they will be way more
readable. Defining and passing ringbuf map in C is also much more
obvious and easy.

> --
> 2.39.0
>
