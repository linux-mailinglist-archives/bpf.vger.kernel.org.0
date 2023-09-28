Return-Path: <bpf+bounces-11041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3FA7B1A03
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 13:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id BDD2C1C20A94
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 11:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA36374DA;
	Thu, 28 Sep 2023 11:08:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206163715E;
	Thu, 28 Sep 2023 11:08:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2766EC433C9;
	Thu, 28 Sep 2023 11:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695899293;
	bh=0sL8RCBSm5AJGYaXOgQaGuqOaK3gCtO5ozWYMZg9Syc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qJcJYfprelsc2r0GYWq1Jaa3nLRh/GYED6eLIgjfyn0rxDT8+VZjOvYs2ZZu6LjE1
	 VRShZmZMQ7R1QKZP6BWkfWLeLjlKyknxplXOBavJNZP7besHqEL4LF8eXcxT2lZdLE
	 lYrg5KlR5UICZWe6B+SiMtzDLAYeAZWlRo0rw6UyI5UEu/5ybj5LVzp/5s6rHrJHGA
	 3Cuh52pWs1qLeZfLJnuGSjvxY+KOMQH9OSgevp42Iq9enHQy/KNvCBoiKnBydYDkYc
	 HdwDCXNDowk+QvhzSvLIWRojTyH6CIK6hW8TpAohB4tbmoPA1yEwSGDwL2QTZQMRRZ
	 +8ywwdKWidcMQ==
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
Subject: Re: [PATCH bpf-next v2 6/6] riscv, bpf: Optimize bswap insns with
 Zbb support
In-Reply-To: <20230919035839.3297328-7-pulehui@huaweicloud.com>
References: <20230919035839.3297328-1-pulehui@huaweicloud.com>
 <20230919035839.3297328-7-pulehui@huaweicloud.com>
Date: Thu, 28 Sep 2023 13:08:10 +0200
Message-ID: <87pm22mu79.fsf@all.your.base.are.belong.to.us>
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
> Optimize bswap instructions by rev8 Zbb instruction conbined with srli
> instruction. And Optimize 16-bit zero-extension with Zbb support.
>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>  arch/riscv/net/bpf_jit.h        | 67 +++++++++++++++++++++++++++++++++
>  arch/riscv/net/bpf_jit_comp64.c | 50 +-----------------------
>  2 files changed, 69 insertions(+), 48 deletions(-)
>
> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
> index 944bdd6e4..a04eed672 100644
> --- a/arch/riscv/net/bpf_jit.h
> +++ b/arch/riscv/net/bpf_jit.h
> @@ -1135,12 +1135,79 @@ static inline void emit_sextw(u8 rd, u8 rs, struc=
t rv_jit_context *ctx)
>  	emit_addiw(rd, rs, 0, ctx);
>  }
>=20=20
> +static inline void emit_zexth(u8 rd, u8 rs, struct rv_jit_context *ctx)
> +{
> +	if (rvzbb_enabled()) {
> +		emit(rvzbb_zexth(rd, rs), ctx);
> +	} else {
> +		emit_slli(rd, rs, 48, ctx);
> +		emit_srli(rd, rd, 48, ctx);
> +	}
> +}
> +

Prefer early-exit.

>  static inline void emit_zextw(u8 rd, u8 rs, struct rv_jit_context *ctx)
>  {
>  	emit_slli(rd, rs, 32, ctx);
>  	emit_srli(rd, rd, 32, ctx);
>  }
>=20=20
> +static inline void emit_bswap(u8 rd, s32 imm, struct rv_jit_context *ctx)
> +{
> +	if (rvzbb_enabled()) {
> +		int bits =3D 64 - imm;
> +
> +		emit(rvzbb_rev8(rd, rd), ctx);
> +		if (bits)
> +			emit_srli(rd, rd, bits, ctx);
> +	} else {
> +		emit_li(RV_REG_T2, 0, ctx);
> +
> +		emit_andi(RV_REG_T1, rd, 0xff, ctx);
> +		emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
> +		emit_slli(RV_REG_T2, RV_REG_T2, 8, ctx);
> +		emit_srli(rd, rd, 8, ctx);
> +		if (imm =3D=3D 16)
> +			goto out_be;
> +
> +		emit_andi(RV_REG_T1, rd, 0xff, ctx);
> +		emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
> +		emit_slli(RV_REG_T2, RV_REG_T2, 8, ctx);
> +		emit_srli(rd, rd, 8, ctx);
> +
> +		emit_andi(RV_REG_T1, rd, 0xff, ctx);
> +		emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
> +		emit_slli(RV_REG_T2, RV_REG_T2, 8, ctx);
> +		emit_srli(rd, rd, 8, ctx);
> +		if (imm =3D=3D 32)
> +			goto out_be;
> +
> +		emit_andi(RV_REG_T1, rd, 0xff, ctx);
> +		emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
> +		emit_slli(RV_REG_T2, RV_REG_T2, 8, ctx);
> +		emit_srli(rd, rd, 8, ctx);
> +
> +		emit_andi(RV_REG_T1, rd, 0xff, ctx);
> +		emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
> +		emit_slli(RV_REG_T2, RV_REG_T2, 8, ctx);
> +		emit_srli(rd, rd, 8, ctx);
> +
> +		emit_andi(RV_REG_T1, rd, 0xff, ctx);
> +		emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
> +		emit_slli(RV_REG_T2, RV_REG_T2, 8, ctx);
> +		emit_srli(rd, rd, 8, ctx);
> +
> +		emit_andi(RV_REG_T1, rd, 0xff, ctx);
> +		emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
> +		emit_slli(RV_REG_T2, RV_REG_T2, 8, ctx);
> +		emit_srli(rd, rd, 8, ctx);
> +out_be:
> +		emit_andi(RV_REG_T1, rd, 0xff, ctx);
> +		emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
> +
> +		emit_mv(rd, RV_REG_T2, ctx);
> +	}
> +}

Definitely early-exit for this one!

This function really show-cases why ZBB is nice! ;-)

I'll take the next rev of series for a test!


Bj=C3=B6rn

