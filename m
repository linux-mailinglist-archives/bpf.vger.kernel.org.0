Return-Path: <bpf+bounces-42312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E310B9A256C
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 16:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1215E1C23CA8
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 14:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE861DE892;
	Thu, 17 Oct 2024 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRbCyaiN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26E81DE4D8;
	Thu, 17 Oct 2024 14:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729176391; cv=none; b=o0k4pSIVNNFsPGREg5K0V6BWj+1LH/YHyOhZcVZspavYgO8T11Y5OyiD11yHmXScdD98/mWe6ZU/qyxuNuI4EFFqR5xD/UeEZLJvklBoxBx3ntyAvPmY1toUTl2PLo+i4C9iXQPLAdGwBoJYEtH83hZgKPTqMWhCJ/pm65fxqqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729176391; c=relaxed/simple;
	bh=EN4o83L5LW0Nv23WNaoc5ktMNbo7M2pTJF42vpcsdrA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Oi58HidDw2Ptg/1hS9xHvr0Tfup3WBh33iAFK7h0q+tXRhTt31gQmjBsgYDNHJ0a3Av8HMBQWkuqcdYbfWMT1EKPDGW/DP/iKafcvR8mZN6pQsyLckIIdUluW3Sg60zdDI+q2MiobbS2wTcOveep4CNlkfaQ41N8up1l5CYwLBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRbCyaiN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA1CC4CED3;
	Thu, 17 Oct 2024 14:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729176391;
	bh=EN4o83L5LW0Nv23WNaoc5ktMNbo7M2pTJF42vpcsdrA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HRbCyaiNoTz9MNRRGHYrMsrITjx6XKQocVQfYVI3usEaOsivNKl42XgyXnN4RuW2c
	 We2sMgNT334XSBV+gLTjQfgVTVOliDlbZORZENpvMx0QGsJF/EFQQaCQ7WeFLND8++
	 OQYg8UzsL68vm7Di2EvShh5B77eWi3qC8YtUmGVoNp/YxJffe6ylJhfd0lgPPXy4jA
	 r2WMK9yg7EOzWjUYHZMej+gDlIQiXyI6C6ZOLmKEmL2bViI/Ikd8JqfT4XeUiWAWQv
	 T8h+bro9CD6cyiQ3gHzTO3w4LjRVtjtsNqEFF/hTnkas3aC5Kcwvm5bTauhyYHvozq
	 xRg6K4/90+byg==
From: Puranjay Mohan <puranjay@kernel.org>
To: Andrea Parri <parri.andrea@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bjorn@kernel.org, pulehui@huawei.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 paulmck@kernel.org, puranjay12@gmail.com
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [PATCH] riscv, bpf: Make BPF_CMPXCHG fully ordered
In-Reply-To: <20241017143628.2673894-1-parri.andrea@gmail.com>
References: <20241017143628.2673894-1-parri.andrea@gmail.com>
Date: Thu, 17 Oct 2024 14:46:26 +0000
Message-ID: <mb61piktqpz25.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Andrea Parri <parri.andrea@gmail.com> writes:

> According to the prototype formal BPF memory consistency model
> discussed e.g. in [1] and following the ordering properties of
> the C/in-kernel macro atomic_cmpxchg(), a BPF atomic operation
> with the BPF_CMPXCHG modifier is fully ordered.  However, the
> current RISC-V JIT lowerings fail to meet such memory ordering
> property.  This is illustrated by the following litmus test:
>
> BPF BPF__MP+success_cmpxchg+fence
> {
>  0:r1=3Dx; 0:r3=3Dy; 0:r5=3D1;
>  1:r2=3Dy; 1:r4=3Df; 1:r7=3Dx;
> }
>  P0                               | P1                                   =
      ;
>  *(u64 *)(r1 + 0) =3D 1             | r1 =3D *(u64 *)(r2 + 0)            =
          ;
>  r2 =3D cmpxchg_64 (r3 + 0, r4, r5) | r3 =3D atomic_fetch_add((u64 *)(r4 =
+ 0), r5) ;
>                                   | r6 =3D *(u64 *)(r7 + 0)              =
        ;
> exists (1:r1=3D1 /\ 1:r6=3D0)
>
> whose "exists" clause is not satisfiable according to the BPF
> memory model.  Using the current RISC-V JIT lowerings, the test
> can be mapped to the following RISC-V litmus test:
>
> RISCV RISCV__MP+success_cmpxchg+fence
> {
>  0:x1=3Dx; 0:x3=3Dy; 0:x5=3D1;
>  1:x2=3Dy; 1:x4=3Df; 1:x7=3Dx;
> }
>  P0                 | P1                          ;
>  sd x5, 0(x1)       | ld x1, 0(x2)                ;
>  L00:               | amoadd.d.aqrl x3, x5, 0(x4) ;
>  lr.d x2, 0(x3)     | ld x6, 0(x7)                ;
>  bne x2, x4, L01    |                             ;
>  sc.d x6, x5, 0(x3) |                             ;
>  bne x6, x4, L00    |                             ;
>  fence rw, rw       |                             ;
>  L01:               |                             ;
> exists (1:x1=3D1 /\ 1:x6=3D0)
>
> where the two stores in P0 can be reordered.  Update the RISC-V
> JIT lowerings/implementation of BPF_CMPXCHG to emit an SC with
> RELEASE ("rl") annotation in order to meet the expected memory
> ordering guarantees.  The resulting RISC-V JIT lowerings of
> BPF_CMPXCHG match the RISC-V lowerings of the C atomic_cmpxchg().

Thanks for fixing this, I fixed all others in:

20a759df3bba ("riscv, bpf: make some atomic operations fully ordered")

> Fixes: dd642ccb45ec ("riscv, bpf: Implement more atomic operations for RV=
64")
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>

Reviewed-by: Puranjay Mohan <puranjay@kernel.org>

> Link: https://lpc.events/event/18/contributions/1949/attachments/1665/344=
1/bpfmemmodel.2024.09.19p.pdf [1]
> ---
>  arch/riscv/net/bpf_jit_comp64.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index 99f34409fb60f..c207aa33c980b 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -548,8 +548,8 @@ static void emit_atomic(u8 rd, u8 rs, s16 off, s32 im=
m, bool is64,
>  		     rv_lr_w(r0, 0, rd, 0, 0), ctx);
>  		jmp_offset =3D ninsns_rvoff(8);
>  		emit(rv_bne(RV_REG_T2, r0, jmp_offset >> 1), ctx);
> -		emit(is64 ? rv_sc_d(RV_REG_T3, rs, rd, 0, 0) :
> -		     rv_sc_w(RV_REG_T3, rs, rd, 0, 0), ctx);
> +		emit(is64 ? rv_sc_d(RV_REG_T3, rs, rd, 0, 1) :
> +		     rv_sc_w(RV_REG_T3, rs, rd, 0, 1), ctx);
>  		jmp_offset =3D ninsns_rvoff(-6);
>  		emit(rv_bne(RV_REG_T3, 0, jmp_offset >> 1), ctx);
>  		emit(rv_fence(0x3, 0x3), ctx);
> --=20
> 2.43.0

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIoEARYKADIWIQQ3wHGvVs/5bdl78BKwwPkjG3B2nQUCZxEjQxQccHVyYW5qYXlA
a2VybmVsLm9yZwAKCRCwwPkjG3B2nTaCAP4qMmlQ6iMqVLKFJlw1LZHBdW+bNk5s
hWwrivacAb81SgD/UMV6elxQS94ZIvNFq1hi0pdytkDerIU+13rAHLW3Wgk=
=AIsB
-----END PGP SIGNATURE-----
--=-=-=--

