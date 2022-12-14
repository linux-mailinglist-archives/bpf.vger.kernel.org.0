Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE1E64C16A
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 01:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237861AbiLNAit (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 19:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237919AbiLNAiX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 19:38:23 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA7E27B04
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 16:35:38 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id d14so20298694edj.11
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 16:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0DrBXufCaKJEHg3HAFoUByScHfwFFy4NlmAIx/rY1hQ=;
        b=F99sXL3pQa3mlJPcn5f4wFG2Dmt/lXb21d8UC0A9Nw9tLn+HxJwJi3OQbnYN42Gzo6
         d49jNpDCXorHPyHxo6ccOIYaHMmTkSueXvjVgA8aZp8Lwop3XrNzURhJ4iVCBCYhXpbr
         MnmKUV+dWXI1hsMqwURKNNj+4q8yp4Es5ITsi1zKtsuSnw5Zjx6cw4cDUyUdJA1G2pku
         jta99HOfdTaqsVsbuXE5RlME3DSvr3D704WB3UNnHDzZqHXYgsAoEHjLVUFe3pgqpQ/o
         YsfkohaFw7C7fQogoKoCsqGZrgD3MazBN+laQGgaHjMsGzdRudylaQ4yl78mAbuD43Sb
         Q/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0DrBXufCaKJEHg3HAFoUByScHfwFFy4NlmAIx/rY1hQ=;
        b=RMrN0TgdpTp+vErvv674KwH6bU1F8lwmRU6rgV2dHLTlFUg3tnmFu8hzqP0vTsm4UG
         UpEuVKRxPLlP3dryx675E6nBM8s1RhIUFv0Qip/oF+UKVtbvbccxpPm1FmbEfPUSa80+
         7vuFSz8GQywMf4rrVDF3wlSG2/EjnHLXzfMi/wE9eUgArU3933Mnxj/l7UzZH5dcGkNo
         JOLQjEtKMtJVxWMAqtLrxE9UsKkfSEKkwW3Jt9EiBgdZyRPLDHz4z/2O5T8MDKhzZJNk
         S2DnOvUsq13iUMOnOyQc+kll7jhGx/+dl+ax793oh7cFWur9GyDVOtrGjeDygn2I9WV5
         mS+g==
X-Gm-Message-State: ANoB5pmuIROW5SSTkK2DrPczfYxS6FV7eb86SLefZWMjDtteANG60z8p
        pKQhGPZvs/bRpiKWegKKwA5kdxQfQPOnDxBCQpY=
X-Google-Smtp-Source: AA0mqf6cjC/M3ErTuAAbw/d0MHL9mul/IMKbn+mEMXvvV31j0wvdsv71LOzhXTT6UTr+D8oWoMHr8Xj+80Qz73G7oPc=
X-Received: by 2002:a50:ed90:0:b0:46a:e6e3:b3cf with SMTP id
 h16-20020a50ed90000000b0046ae6e3b3cfmr49634415edr.333.1670978123291; Tue, 13
 Dec 2022 16:35:23 -0800 (PST)
MIME-Version: 1.0
References: <20221209135733.28851-1-eddyz87@gmail.com> <20221209135733.28851-5-eddyz87@gmail.com>
In-Reply-To: <20221209135733.28851-5-eddyz87@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 13 Dec 2022 16:35:10 -0800
Message-ID: <CAEf4BzZ7VEdYb+qSFLnY2jkvUHEfNHtzK7WYWMKezyRcjkV=Zg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/7] selftests/bpf: verify states_equal()
 maintains idmap across all frames
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        memxor@gmail.com, ecree.xilinx@gmail.com
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

On Fri, Dec 9, 2022 at 5:58 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> A test case that would erroneously pass verification if
> verifier.c:states_equal() maintains separate register ID mappings for
> call frames.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---

It's so hard to read these tests. Moving forward, let's try adding new
verifier tests like this using __naked functions and embedded
assembly. With recent test loader changes ([0]), there isn't much
that's needed, except for a few simple examples to get us started and
perhaps __flags(BPF_F_TEST_STATE_FREQ) support. The upside is that
using maps or global variables from assembly is now possible and easy,
and doesn't require any custom loader support at all.


  [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=702713&state=*


>  tools/testing/selftests/bpf/verifier/calls.c | 82 ++++++++++++++++++++
>  1 file changed, 82 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
> index 3193915c5ee6..bcd15b26dcee 100644
> --- a/tools/testing/selftests/bpf/verifier/calls.c
> +++ b/tools/testing/selftests/bpf/verifier/calls.c
> @@ -2305,3 +2305,85 @@
>         .errstr = "!read_ok",
>         .result = REJECT,
>  },
> +/* Make sure that verifier.c:states_equal() considers IDs from all
> + * frames when building 'idmap' for check_ids().
> + */
> +{
> +       "calls: check_ids() across call boundary",
> +       .insns = {
> +       /* Function main() */
> +       BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
> +       /* fp[-24] = map_lookup_elem(...) ; get a MAP_VALUE_PTR_OR_NULL with some ID */
> +       BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
> +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
> +       BPF_LD_MAP_FD(BPF_REG_1,
> +                     0),
> +       BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
> +       BPF_STX_MEM(BPF_DW, BPF_REG_FP, BPF_REG_0, -24),
> +       /* fp[-32] = map_lookup_elem(...) ; get a MAP_VALUE_PTR_OR_NULL with some ID */
> +       BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
> +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
> +       BPF_LD_MAP_FD(BPF_REG_1,
> +                     0),
> +       BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
> +       BPF_STX_MEM(BPF_DW, BPF_REG_FP, BPF_REG_0, -32),
> +       /* call foo(&fp[-24], &fp[-32])   ; both arguments have IDs in the current
> +        *                                ; stack frame
> +        */
> +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_FP),
> +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -24),
> +       BPF_MOV64_REG(BPF_REG_2, BPF_REG_FP),
> +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -32),
> +       BPF_CALL_REL(2),
> +       /* exit 0 */
> +       BPF_MOV64_IMM(BPF_REG_0, 0),
> +       BPF_EXIT_INSN(),
> +       /* Function foo()
> +        *
> +        * r9 = &frame[0].fp[-24]  ; save arguments in the callee saved registers,
> +        * r8 = &frame[0].fp[-32]  ; arguments are pointers to pointers to map value
> +        */
> +       BPF_MOV64_REG(BPF_REG_9, BPF_REG_1),
> +       BPF_MOV64_REG(BPF_REG_8, BPF_REG_2),
> +       /* r7 = ktime_get_ns() */
> +       BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
> +       BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
> +       /* r6 = ktime_get_ns() */
> +       BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
> +       BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
> +       /* if r6 > r7 goto +1      ; no new information about the state is derived from
> +        *                         ; this check, thus produced verifier states differ
> +        *                         ; only in 'insn_idx'
> +        * r9 = r8
> +        */
> +       BPF_JMP_REG(BPF_JGT, BPF_REG_6, BPF_REG_7, 1),
> +       BPF_MOV64_REG(BPF_REG_9, BPF_REG_8),
> +       /* r9 = *r9                ; verifier get's to this point via two paths:
> +        *                         ; (I) one including r9 = r8, verified first;
> +        *                         ; (II) one excluding r9 = r8, verified next.
> +        *                         ; After load of *r9 to r9 the frame[0].fp[-24].id == r9.id.
> +        *                         ; Suppose that checkpoint is created here via path (I).
> +        *                         ; When verifying via (II) the r9.id must be compared against
> +        *                         ; frame[0].fp[-24].id, otherwise (I) and (II) would be
> +        *                         ; incorrectly deemed equivalent.
> +        * if r9 == 0 goto <exit>
> +        */
> +       BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_9, 0),
> +       BPF_JMP_IMM(BPF_JEQ, BPF_REG_9, 0, 1),
> +       /* r8 = *r8                ; read map value via r8, this is not safe
> +        * r0 = *r8                ; because r8 might be not equal to r9.
> +        */
> +       BPF_LDX_MEM(BPF_DW, BPF_REG_8, BPF_REG_8, 0),
> +       BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_8, 0),
> +       /* exit 0 */
> +       BPF_MOV64_IMM(BPF_REG_0, 0),
> +       BPF_EXIT_INSN(),
> +       },
> +       .flags = BPF_F_TEST_STATE_FREQ,
> +       .fixup_map_hash_8b = { 3, 9 },
> +       .result = REJECT,
> +       .errstr = "R8 invalid mem access 'map_value_or_null'",
> +       .result_unpriv = REJECT,
> +       .errstr_unpriv = "",
> +       .prog_type = BPF_PROG_TYPE_CGROUP_SKB,
> +},
> --
> 2.34.1
>
