Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD9D63D4BB
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 12:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiK3LiT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 06:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiK3LiS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 06:38:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93682C676;
        Wed, 30 Nov 2022 03:38:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A52CDB81AF2;
        Wed, 30 Nov 2022 11:38:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CE6C433C1;
        Wed, 30 Nov 2022 11:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669808294;
        bh=5bEYlFEyZKCYZEyNNJPRBWYDQP0ERj+j46soRPrLxVs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=dYTi4FNxDiF0nqG0Fg2vbGzAGx/ebqcpdavkWjmErzAeMgb6Dl9RLE1jKWnI1fHGg
         Cvbxb6NbVUL239BT6qpgAZ1vIcICYUW2GKqpKsXiTVSvZWoB+toUy+MwLym5aVTWk7
         wFzDKjGt3rx/ZyVO/PlyPAhztE5YQ924dKxm2qz0RcvJN4CwXbwsSiYNFKoHcbUbhJ
         WXhetBwYCHdC+DdQH6qPtQ+FWgqhwscNcwT2TTo7O3nXoynM8kbTz4+q3rQtOrum4A
         coTd+zd4EXZC1Oi9jPc2ymUD3vWrIywn44pX9bnzUl3fGwGzmWTr2jMlLDhc6LHpi/
         f+Z4r4BZuJlVQ==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Pu Lehui <pulehui@huawei.com>,
        Pu Lehui <pulehui@huaweicloud.com>
Subject: Re: [PATCH bpf] riscv, bpf: Emit fixed-length imm64 for
 BPF_PSEUDO_FUNC
In-Reply-To: <20221130033806.2967822-1-pulehui@huaweicloud.com>
References: <20221130033806.2967822-1-pulehui@huaweicloud.com>
Date:   Wed, 30 Nov 2022 12:38:11 +0100
Message-ID: <87h6yg1xlo.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Pu Lehui <pulehui@huaweicloud.com> writes:

> From: Pu Lehui <pulehui@huawei.com>
>
> For BPF_PSEUDO_FUNC instruction, verifier will refill imm with
> correct addresses of bpf_calls and then run last pass of JIT.
> Since the emit_imm of RV64 is variable-length, which will emit
> appropriate length instructions accorroding to the imm, it may
> broke ctx->offset, and lead to unpredictable problem, such as
> inaccurate jump. So let's fix it with fixed-length imm64 insns.

Ah, nice one! So, the the invariant doesn't hold (the image grow in the
last pass).

> Fixes: 69c087ba6225 ("bpf: Add bpf_for_each_map_elem() helper")

This is odd? This can't be the right Fixes-tag...

> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>  arch/riscv/net/bpf_jit_comp64.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index eb99df41fa33..f984d5fa014b 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -139,6 +139,30 @@ static bool in_auipc_jalr_range(s64 val)
>  		val < ((1L << 31) - (1L << 11));
>  }
>=20=20
> +/* Emit fixed-length instructions for 32-bit imm */
> +static void emit_fixed_imm32(u8 rd, s32 val, struct rv_jit_context *ctx)
> +{
> +	s32 upper =3D (val + (1U << 11)) >> 12;
> +	s32 lower =3D ((val & 0xfff) << 20) >> 20;
> +
> +	emit(rv_lui(rd, upper), ctx);
> +	emit(rv_addi(rd, rd, lower), ctx);
> +}
> +
> +/* Emit fixed-length instructions for 64-bit imm */
> +static void emit_fixed_imm64(u8 rd, s64 val, struct rv_jit_context *ctx)
> +{
> +	/* Compensation for sign-extension of rv_addi */
> +	s32 imm_hi =3D (val + (1U << 31)) >> 32;
> +	s32 imm_lo =3D val;
> +
> +	emit_fixed_imm32(rd, imm_hi, ctx);
> +	emit_fixed_imm32(RV_REG_T1, imm_lo, ctx);
> +	emit(rv_slli(rd, rd, 32), ctx);
> +	emit(rv_add(rd, rd, RV_REG_T1), ctx);
> +}

Hmm, will this really be fixed? We can end up with compressed
instructions, which can then be a non-compressed in the last pass, and
we have the same problem?

The range of valid address for RV64 (sv39 to sv57) are
0xffffffff00000000 to 0xffffffffffffffff, so I think we can do better
than 6 insn, no? My gut feeling (I need to tinker a bit) is that 4
should be sufficient.

Note that worst case for a imm64 load are 8 instructions, but this is
not the general case.


Bj=C3=B6rn
