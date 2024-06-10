Return-Path: <bpf+bounces-31734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F23C9028B2
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 20:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6E0C1F222A3
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 18:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6099614A0A0;
	Mon, 10 Jun 2024 18:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daBSwIVT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B3126AF6
	for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 18:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718044371; cv=none; b=dnyjImzcYT4buX1CTLEYCZnVRV6RXZBrBcuEd8fa9IUfNxS4VqwuFpTzaKc5Ao40u71dDuCGCkvrlovnkIWz/GeL0HJ2kgeSH2OBVFpbXyg+CsIxdVjb/EpL2ecTCbWkK+reoWH6Gmk9t7nXUlCWbZYEAG1lzBz8p8lEbTh0MYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718044371; c=relaxed/simple;
	bh=Jm+totyUpPpmFSGD8aSpvllmFw4VFWE4xK1tXnjHbtI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CiaG+tivsW8dKhFAoAEXDfSohX5rAvyZbNgz6dSx12b+fHXDwfy+sY24vMZC3NUzIH0Vni45WrblBHopl17aHGD52FUhqmrYehZufa/t9E5bmJT4/UwM4H92p6vGPAqmP0dKaduGvR4qyLPxu7JgKodI/+8uZ/PC3s4Fcym+Rr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daBSwIVT; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7023b6d810bso3781971b3a.3
        for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 11:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718044370; x=1718649170; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WLl2xmuu6U6U2kaH+V+KAZGHolCdbaWaHnr2rTTuKPY=;
        b=daBSwIVTJbCuGQCryCH0YiqSyonskBC37XsEmwb1sAqUmkutUt9ixt+Kzfmb0GPi3G
         F1+9xxJvY2J+KdT74xHxwmU39uMXHqvsL0l9xoFnvzMP2p+1ZTWQtFSyUw5XZ4DDjVQw
         Cp4Y7Tt1uLXe92kO9gdx0HbroedsJ2p0t0od7N3DV5/MDrZJPhfPWLcJxptMUvxK3BQj
         f+APdSLYQK6BcdiFePKYfkT4uVLqd4ZR16JfHUjWi+OHmI7xjjvjK7PCSVIW55a1Sx6j
         MAJh5MQpGihCf0xYhPajx6dD1P3y4XmoV+zR0IXB47jh2252ANLs33WkxbufA+5SBofA
         X0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718044370; x=1718649170;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WLl2xmuu6U6U2kaH+V+KAZGHolCdbaWaHnr2rTTuKPY=;
        b=Gq4LWYT6rXDcLIYVQzM/WxynzXkEbog5/5JkvB4zXUN82+nV0issLYZR65uGZXA6yw
         YU3LjyYDh6mIgaNWeQTjp2rydzJbpU/4CD1pdis20SBpNrBtSkBwveevAOxvBFYVrdbd
         2RtKkSQKY/A3CEfdUtj70ksGTym0ouyDxbLBg6aKTuevlAqDJLTi+JCEyUkAPG4q5+Q1
         /Gx9ZLTbMdAk9PKU+Mmb5+b1zMS3F3K/JxQd232jI8oJDXmtEG/enHVZsa9t9oJt0pJt
         QBeLn3IWtSZiJb4L+cLOZT3kfv1xq/+egT9xi54r9H/YJHWDEKt3pytmJwbALTM3bnmv
         Znpg==
X-Forwarded-Encrypted: i=1; AJvYcCViug9/6tvToOyxLC2AZ4IOEknBQCQ/74sgJQYpnLpK5hPY5fb0S6K2unVacBntP2VNmYc0Ro3sokWLBuukWlOrlBh9
X-Gm-Message-State: AOJu0YxjpnPmmidPmJe+5+O1GzJ/5YFy2cr6VZqeFCDWzt8vTUCQ4f4L
	BRrLxgGDOz5dXv5f1Fp763sc+xe9eper/GlvH2zoIAsu8I/7i1BR
X-Google-Smtp-Source: AGHT+IEV95s7yDV3CHnEzuqjivj3t/Pp0zJzL7V4ab1wAwyfB8kDCWvNFj4AX3qH4lwQVHW6kYwmJw==
X-Received: by 2002:a05:6a00:1acb:b0:702:36a0:a28f with SMTP id d2e1a72fcca58-7040c629198mr13424004b3a.4.1718044369446;
        Mon, 10 Jun 2024 11:32:49 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70438151a4dsm2698382b3a.134.2024.06.10.11.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 11:32:49 -0700 (PDT)
Message-ID: <8ed1937f85f1f2b701ff70dd7b1429ffc9d250f6.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Track delta between "linked"
 registers.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	memxor@gmail.com, kernel-team@fb.com
Date: Mon, 10 Jun 2024 11:32:44 -0700
In-Reply-To: <20240608004446.54199-3-alexei.starovoitov@gmail.com>
References: <20240608004446.54199-1-alexei.starovoitov@gmail.com>
	 <20240608004446.54199-3-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-06-07 at 17:44 -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> Compilers can generate the code
>   r1 =3D r2
>   r1 +=3D 0x1
>   if r2 < 1000 goto ...
>   use knowledge of r2 range in subsequent r1 operations
>=20
> So remember constant delta between r2 and r1 and update r1 after 'if' con=
dition.
>=20
> Unfortunately LLVM still uses this pattern for loops with 'can_loop' cons=
truct:
> for (i =3D 0; i < 1000 && can_loop; i++)
>=20
> The "undo" pass was introduced in LLVM
> https://reviews.llvm.org/D121937
> to prevent this optimization, but it cannot cover all cases.
> Instead of fighting middle end optimizer in BPF backend teach the verifie=
r
> about this pattern.

I like this idea.
In theory it could be generalized to handle situations when LLVM
uses two counters in parallel:

r0 =3D 0 // as an index
r1 =3D 0 // as a pointer
...
r0 +=3D 1
r1 +=3D 8

>=20
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

[...]

> @@ -15088,13 +15130,43 @@ static bool try_match_pkt_pointers(const struct=
 bpf_insn *insn,
>  static void find_equal_scalars(struct bpf_verifier_state *vstate,
>  			       struct bpf_reg_state *known_reg)
>  {
> +	struct bpf_reg_state fake_reg;
>  	struct bpf_func_state *state;
>  	struct bpf_reg_state *reg;
> =20
>  	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
> -		if (reg->type =3D=3D SCALAR_VALUE && reg->id =3D=3D known_reg->id)
> +		if (reg->type !=3D SCALAR_VALUE || reg =3D=3D known_reg)
> +			continue;
> +		if ((reg->id & ~BPF_ADD_CONST) !=3D (known_reg->id & ~BPF_ADD_CONST))
> +			continue;
> +		if ((reg->id & BPF_ADD_CONST) =3D=3D (known_reg->id & BPF_ADD_CONST)) =
{
>  			copy_register_state(reg, known_reg);
> +		} else if ((reg->id & BPF_ADD_CONST) && reg->off) {
> +			/* reg =3D known_reg; reg +=3D const */
> +			copy_register_state(reg, known_reg);
> +
> +			fake_reg.type =3D SCALAR_VALUE;
> +			__mark_reg_known(&fake_reg, reg->off);
> +			scalar32_min_max_add(reg, &fake_reg);
> +			scalar_min_max_add(reg, &fake_reg);
> +			reg->var_off =3D tnum_add(reg->var_off, fake_reg.var_off);
> +			reg->off =3D 0;
> +			reg->id &=3D ~BPF_ADD_CONST;
> +		} else if ((known_reg->id & BPF_ADD_CONST) && known_reg->off) {
> +			/* reg =3D known_reg; reg -=3D const' */
> +			copy_register_state(reg, known_reg);
> +
> +			fake_reg.type =3D SCALAR_VALUE;
> +			__mark_reg_known(&fake_reg, known_reg->off);
> +			scalar32_min_max_sub(reg, &fake_reg);
> +			scalar_min_max_sub(reg, &fake_reg);
> +			reg->var_off =3D tnum_sub(reg->var_off, fake_reg.var_off);
> +		}

I think that copy_register_state logic is off here,
the copy overwrites reg->off before it is used to update the value.
The following test is marked as safe for me, while it should not:

char buf[10] SEC(".data.buf");

SEC("socket")
__failure
__msg("*(u8 *)(r7 +0) =3D r0")
__msg("invalid access to map value, value_size=3D10 off=3D9 size=3D1")
__naked void check_add_const_3regs(void)
{
	asm volatile (
	"r6 =3D %[buf];"
	"r7 =3D %[buf];"
	"call %[bpf_ktime_get_ns];"
	"r1 =3D r0;"		/* link r0.id =3D=3D r1.id =3D=3D r2.id */
	"r2 =3D r0;"
	"r1 +=3D 1;"		/* r1 =3D=3D r0+1 */
	"r2 +=3D 2;"		/* r2 =3D=3D r0+2 */
	"if r0 > 8 goto 1f;"	/* r0 range [0, 8]  */
	"r6 +=3D r1;"		/* r1 range [1, 9]  */
	"r7 +=3D r2;"		/* r2 range [2, 10] */
	"*(u8 *)(r6 +0) =3D r0;"	/* safe, within bounds   */
	"*(u8 *)(r7 +0) =3D r0;"	/* unsafe, out of bounds */
	"1: exit;"
	:
	: __imm(bpf_ktime_get_ns),
	  __imm_ptr(buf)
	: __clobber_common);
}

The conditional r0 > 8 propagates same range for r{0,1,2}:

7: (07) r1 +=3D 1                       ; R1_w=3Dscalar(id=3D1+1)
8: (07) r2 +=3D 2                       ; R2_w=3Dscalar(id=3D1+2)
9: (25) if r0 > 0x8 goto pc+4         ; R0_w=3Dscalar(id=3D1,smin=3Dsmin32=
=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D8,var_off=3D(0x0; 0xf))
10: (0f) r6 +=3D r1
11: R1_w=3Dscalar(id=3D1,smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D=
8,var_off=3D(0x0; 0xf)) R6_w=3D...
11: (0f) r7 +=3D r2
12: R2_w=3Dscalar(id=3D1,smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D=
8,var_off=3D(0x0; 0xf)) R7_w=3D...


>  	}));
> +	if (known_reg->id & BPF_ADD_CONST) {
> +		known_reg->id =3D 0;
> +		known_reg->off =3D 0;
> +	}
>  }
> =20
>  static int check_cond_jmp_op(struct bpf_verifier_env *env,


