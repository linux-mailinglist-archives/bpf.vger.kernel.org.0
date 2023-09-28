Return-Path: <bpf+bounces-11036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B54A67B1992
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 13:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 60EFE282634
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 11:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66E73716B;
	Thu, 28 Sep 2023 11:04:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9003D36AE7;
	Thu, 28 Sep 2023 11:04:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACFBFC433CB;
	Thu, 28 Sep 2023 11:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695899093;
	bh=7mNdJcFPLoE1YRZIoK6v5JqUWXOtSuDSezshher0uy0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PQ33zNum8w+EXnbDT8al3DaeDYDYIrAxrS2YwpRyXvZOgVEKADhbJCVkJNWRB47gl
	 Sg6bFC/nqVv26c9VAFJemsTHjG+NGq7TJogtSj0PugW8ne4/Wzc/6k2A9fT8Pu2vim
	 l4IvAb+QI52tOnwqkBRSYyoJHbZp1vjCsQkACQ97kyLO73yG4w/+joz/q0rjqgzryN
	 erF4ejPb5o2HpHqVxEeWdOJswrlKbp0Ux7OKZsoUGTypljibsCSUNC0hqdkWkWsvMa
	 tawZTPOfsC4XphDqcx+DUbS83baCZxfyOY6+eQkKe9VX9xA90a/R8Sic9lgMh+F9et
	 mFPkbbm1oFq5g==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, Luke Nelson
 <luke.r.nels@gmail.com>, Pu Lehui <pulehui@huawei.com>, Pu Lehui
 <pulehui@huaweicloud.com>
Subject: Re: [PATCH bpf-next v2 5/6] riscv, bpf: Optimize sign-extention mov
 insns with Zbb support
In-Reply-To: <20230919035839.3297328-6-pulehui@huaweicloud.com>
References: <20230919035839.3297328-1-pulehui@huaweicloud.com>
 <20230919035839.3297328-6-pulehui@huaweicloud.com>
Date: Thu, 28 Sep 2023 13:04:50 +0200
Message-ID: <87sf6ymuct.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huaweicloud.com> writes:

> From: Pu Lehui <pulehui@huawei.com>
>
> Add 8-bit and 16-bit sign-extention wraper with Zbb support to optimize
> sign-extension mov instructions.
>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>  arch/riscv/net/bpf_jit.h        | 20 ++++++++++++++++++++
>  arch/riscv/net/bpf_jit_comp64.c |  5 +++--
>  2 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
> index 4e24fb2bd..944bdd6e4 100644
> --- a/arch/riscv/net/bpf_jit.h
> +++ b/arch/riscv/net/bpf_jit.h
> @@ -1110,6 +1110,26 @@ static inline void emit_subw(u8 rd, u8 rs1, u8 rs2=
, struct rv_jit_context *ctx)
>  		emit(rv_subw(rd, rs1, rs2), ctx);
>  }
>=20=20
> +static inline void emit_sextb(u8 rd, u8 rs, struct rv_jit_context *ctx)
> +{
> +	if (rvzbb_enabled()) {
> +		emit(rvzbb_sextb(rd, rs), ctx);
> +	} else {
> +		emit_slli(rd, rs, 56, ctx);
> +		emit_srai(rd, rd, 56, ctx);
> +	}
> +}
> +
> +static inline void emit_sexth(u8 rd, u8 rs, struct rv_jit_context *ctx)
> +{
> +	if (rvzbb_enabled()) {
> +		emit(rvzbb_sexth(rd, rs), ctx);
> +	} else {
> +		emit_slli(rd, rs, 48, ctx);
> +		emit_srai(rd, rd, 48, ctx);
> +	}
> +}

Nit/personal style: I really find it easier to read early-exit code,
than nested if-else.

  | if (cond) {
  |   foo();
  |   return;
  | }
  |=20
  | bar();

> +
>  static inline void emit_sextw(u8 rd, u8 rs, struct rv_jit_context *ctx)
>  {
>  	emit_addiw(rd, rs, 0, ctx);
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index 0c6ffe11a..f4ca6b787 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -1027,9 +1027,10 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn,=
 struct rv_jit_context *ctx,
>  			emit_mv(rd, rs, ctx);
>  			break;
>  		case 8:
> +			emit_sextb(rd, rs, ctx);
> +			break;
>  		case 16:
> -			emit_slli(RV_REG_T1, rs, 64 - insn->off, ctx);
> -			emit_srai(rd, RV_REG_T1, 64 - insn->off, ctx);
> +			emit_sexth(rd, rs, ctx);

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

