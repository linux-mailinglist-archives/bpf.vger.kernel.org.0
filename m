Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F18640555
	for <lists+bpf@lfdr.de>; Fri,  2 Dec 2022 11:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbiLBKz7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Dec 2022 05:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbiLBKzh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Dec 2022 05:55:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF13DBE20;
        Fri,  2 Dec 2022 02:54:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7991FB80139;
        Fri,  2 Dec 2022 10:54:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8EEC433C1;
        Fri,  2 Dec 2022 10:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669978497;
        bh=LSMFzqyB1fXLSKOizp7KzytquPKo2a5Fv0X9tR9yTCY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=l8ad7NbW5u0wdRxS+IL6ctl2VgKfegP2RIE05KO94y1XhSvK4LT9JiPs089HgJxSc
         NsMtBrcg3NHEy8fXck5X5V43E2pALn90tGhyGdmy2Nd5IzK12swQgUpQ4psUZ9+J+V
         +yYd64gKbmMMfnOG3mHojxMaMx3dr3woKWIj2me5QlTfN3URu4WU50HXiQBUT0QSmK
         5LqfCTevkKmXcxcqkGj7dJzv0Y4X42bjROjovG7I6tl4Fxd0DT6Xt3ECUSKwvzg1VE
         eLI5hnqA6FcW6lBB2Zt82HWIficeeCTy+Qf3Jo4ES98qc67+l11XX4k2StIrZ7/TnB
         MneZ3HtNIuYoA==
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
Subject: Re: [PATCH bpf v2] riscv, bpf: Emit fixed-length instructions for
 BPF_PSEUDO_FUNC
In-Reply-To: <20221202094837.3872444-1-pulehui@huaweicloud.com>
References: <20221202094837.3872444-1-pulehui@huaweicloud.com>
Date:   Fri, 02 Dec 2022 11:54:54 +0100
Message-ID: <87y1rq848x.fsf@all.your.base.are.belong.to.us>
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
> inaccurate jump. So let's fix it with fixed-length instructions.
>
> Fixes: 69c087ba6225 ("bpf: Add bpf_for_each_map_elem() helper")
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> Suggested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> ---
>  arch/riscv/net/bpf_jit_comp64.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index eb99df41fa33..9723f34f7a06 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -139,6 +139,19 @@ static bool in_auipc_jalr_range(s64 val)
>  		val < ((1L << 31) - (1L << 11));
>  }
>=20=20
> +/* Emit fixed-length instructions for address */
> +static void emit_addr(u8 rd, u64 addr, struct rv_jit_context *ctx)
> +{
> +	u64 ip =3D (u64)(ctx->insns + ctx->ninsns);
> +	s64 off =3D addr - ip;
> +	s64 upper =3D (off + (1 << 11)) >> 12;
> +	s64 lower =3D ((off & 0xfff) << 52) >> 52;
> +
> +	emit(rv_auipc(rd, upper), ctx);
> +	emit(rv_addi(rd, rd, lower), ctx);
> +}

Nice! Two instructions are better than 6! :-)

One final thing. Please add a sanity check, that the range is correct,
e.g.:

  if (!(addr && in_auipc_addi_range(off)))
     return -1;

Have a look at emit_jump_and_link().


Thanks!
Bj=C3=B6rn
