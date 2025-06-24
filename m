Return-Path: <bpf+bounces-61427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC73AE6F9B
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 21:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A763A24D5
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 19:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487682E6123;
	Tue, 24 Jun 2025 19:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQQto+ZG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5333E17A2E2
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 19:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750793460; cv=none; b=SJ/l6BBzCc50utPBhkTodzI/vh7le5QZfIxMT8uLdD3pxXU0tlHO8KcFUGXzFEdlHfhqiNqemsO04BYsELqEhh1EZJjnNuwCCkOgmtdmAN0+lHe4cbCq4RKRWA3pFOTXuNagFHCck2FDn/1b3Ykvd7RhK9cDQhP7QYlVHeVegEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750793460; c=relaxed/simple;
	bh=iFYBThftnqM5oFc636LXvkU+XjAhvyupP6d2iW8e63Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l97GNmvOquDFnGRu2/wUWpAVIARQtMg3JSet6XE5QaIXx0E80+Mds0cK/+NGvYH4cHjygy+iknfIzQ3kznFVJO/WQvsuP2H/ylE3Og0tc3xyem4iYMzPIoPYDhGN/pGVM27U1/zscSGcqxE774J6ndkDnrFrmIb+Xogc/wgwj7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQQto+ZG; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so108738b3a.1
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 12:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750793458; x=1751398258; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WE6Tv3TBgPqCs5QZxIFiKiHxBu/0shv/EAHm1UeNeMM=;
        b=IQQto+ZGq9vvovzdPlyfkcqi3Npps4lfpqDPL2REDELaN4u6AOREDg+NLit1UgNLws
         TA6Q/Ky21KSws6Kqap9RrALAfnA9wVq1aohMBJyitn74TnWDg4ysWzX+l3q+CQk4BGvU
         jsGDS7r0XO25cvHdazL2DhRs//RrIXYclNsxjkPo7TBpLoePd/6fduke45pszlRjTkjW
         eYG4nIPumYufCYEwEmlKXZ++N2LGHFWNeMn82S6pQn3+MBnf8wTwiWjbSHvH1w4CeNCh
         2mnsPcymhPfjL45dF6slu5LrRgaLQVV20XcwfAMVJxJmVI3OBzMUHThrzD2JkeiHGo/K
         aLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750793458; x=1751398258;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WE6Tv3TBgPqCs5QZxIFiKiHxBu/0shv/EAHm1UeNeMM=;
        b=rde8WJzcaXkrOmVB7dD+P/P6azgKqrjRYA4hpQ+1PXamwsopB/kgysevhuGOW5MCOv
         ok3N++tFBJz92Ce5UZTlbXWtcd8POp4C4PAeAeKVweyUNjCPgqmUdG3nNfWWe1d0zrIh
         6WO3qfoyddmEHkeqDpBgtGdNDozi/Zm/q4K4f04PD8xG3ohsCP08z2eAXDA6aMRst0KV
         KGiBhVqa62L0DcpT3XKX/YT9xalQwNafdejYnfy50P03w+bcKBUFM6zTsMigqPx9vn7Z
         NRmgcOWih5sPBuZQvp8/olndK7a8diY8yAJNc6zVZXLqqwTRM6gQyG2MBj3vnnM1YGul
         4zgw==
X-Forwarded-Encrypted: i=1; AJvYcCX6Z+5Ap1VdSSOcm7qXdjAFcFXcmczhoNYWR1HTzKkdlUvLTn9+nbRkimd4I5BUvEo9m9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDitpH8f3jeaAVqO0PoMz4k18Q12nQvQKCIsHJK11Xw4UdpRiy
	YrcV/Ox4wC04VwlLEmoHL2oT2hxR07ldT+nKCdKYzPcO6kqkfQAZ2Gkn
X-Gm-Gg: ASbGncs1l5J7Ral4CB9FVsAnbFAA0DZhaMuGvYKUT5z49ky4f8Hdq4HDJq0E+SjQNbN
	//5g7uKv5rdsmIqAYUIQW4iNjZoQ/5GEvERIBdgBaPFtq31sL2HBcfD55Gyoxh6AgLwRfHqyRka
	ql7sx7mEYXICCIsmJ1cM77x8nsoRb9qfCqpxTU1nrCdDZrZHnHWD3nPYDXw/McBjaYmE724fc1u
	HNZA6X+cgE4znB7QgqzIRJ32Cb8BBdtIUzXNhsuJjNICG5k2SbhxVjw3+iP6/lrOX/JSJpjP1NE
	RUxGrVHCvyy/lnFAavXQKc4d9R7hM0BO662o7rB7sKKO4oAAjJzRUYjii2MaqHtnAzfMtsoLabc
	gvkeQycn6i+huDzQBNcxZ
X-Google-Smtp-Source: AGHT+IEiDOTukYtiQFGx6TOQP0s9ZnVav7CMa5Ry9Nt4Y56FHh+NWu5ynAFF1Yk5zpbFZEY53UB9Fg==
X-Received: by 2002:a05:6a00:2396:b0:736:5969:2b6f with SMTP id d2e1a72fcca58-74ad4c0266cmr254015b3a.6.1750793457511;
        Tue, 24 Jun 2025 12:30:57 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:9b77:d425:d62:b7ce? ([2620:10d:c090:500::6:f262])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749b5e09881sm2501753b3a.30.2025.06.24.12.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 12:30:57 -0700 (PDT)
Message-ID: <96b5c623be2b07ecab82a405637c9e4456548148.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add range tracking for BPF_NEG
From: Eduard Zingerman <eddyz87@gmail.com>
To: Song Liu <song@kernel.org>, bpf@vger.kernel.org
Cc: kernel-team@meta.com, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, 	martin.lau@linux.dev
Date: Tue, 24 Jun 2025 12:30:55 -0700
In-Reply-To: <20250624172320.2923031-1-song@kernel.org>
References: <20250624172320.2923031-1-song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-06-24 at 10:23 -0700, Song Liu wrote:
> Add range tracking for instruction BPF_NEG. Without this logic, a trivial
> program like the following will fail
>
>     volatile bool found_value_b;
>     SEC("lsm.s/socket_connect")
>     int BPF_PROG(test_socket_connect)
>     {
>         if (!found_value_b)
>                 return -1;
>         return 0;
>     }
>
> with verifier log:
>
> "At program exit the register R0 has smin=3D0 smax=3D4294967295 should ha=
ve
> been in [-4095, 0]".
>
> This is because range information is lost in BPF_NEG:
>
> 0: R1=3Dctx() R10=3Dfp0
> ; if (!found_value_b) @ xxxx.c:24
> 0: (18) r1 =3D 0xffa00000011e7048       ; R1_w=3Dmap_value(...)
> 2: (71) r0 =3D *(u8 *)(r1 +0)           ; R0_w=3Dscalar(smin32=3D0,smax=
=3D255)
> 3: (a4) w0 ^=3D 1                       ; R0_w=3Dscalar(smin32=3D0,smax=
=3D255)
> 4: (84) w0 =3D -w0                      ; R0_w=3Dscalar(range info lost)
>
> Note that, the log above is manually modified to highlight relevant bits.
>
> Fix this by maintaining proper range information with BPF_NEG, so that
> the verifier will know:
>
> 4: (84) w0 =3D -w0                      ; R0_w=3Dscalar(smin32=3D-255,sma=
x=3D0)
>
> Also add selftests to make sure the logic works as expected.
>
> Signed-off-by: Song Liu <song@kernel.org>
> ---

I double-checked and backtrack_insn operates as expected indeed.

Note, bpf_reg_state->id has to be reset on BPF_NEG otherwise the
following is possible:

  4: (bf) r2 =3D r1                       ; R1_w=3Dscalar(id=3D2,...) R2_w=
=3Dscalar(id=3D2,...)
  5: (87) r1 =3D -r1                      ; R1_w=3Dscalar(id=3D2,...)
 =20
On the master the id is reset by mark_reg_unknown.
This id is used to transfer range knowledge over all scalars with the
same id.

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 279a64933262..93512596a590 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[...]

> @@ -15214,6 +15215,14 @@ static int adjust_scalar_min_max_vals(struct bpf=
_verifier_env *env,
>  		scalar_min_max_sub(dst_reg, &src_reg);
>  		dst_reg->var_off =3D tnum_sub(dst_reg->var_off, src_reg.var_off);
>  		break;
> +	case BPF_NEG:
> +		struct bpf_reg_state dst_reg_copy =3D *dst_reg;

Nit: there might be a concern regarding stack usage.
     In struct bpf_verifier_env there are a few 'fake_reg'
     scratch registers defined for similar purpose.
     Also clangd warns me that declaration after label is a c23 extension.

> +
> +		___mark_reg_known(dst_reg, 0);
> +		scalar32_min_max_sub(dst_reg, &dst_reg_copy);
> +		scalar_min_max_sub(dst_reg, &dst_reg_copy);
> +		dst_reg->var_off =3D tnum_neg(dst_reg_copy.var_off);
> +		break;
>  	case BPF_MUL:
>  		dst_reg->var_off =3D tnum_mul(dst_reg->var_off, src_reg.var_off);
>  		scalar32_min_max_mul(dst_reg, &src_reg);

[...]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_precision.c b/too=
ls/testing/selftests/bpf/progs/verifier_precision.c
> index 9fe5d255ee37..bcff70f8cebb 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_precision.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_precision.c

Nit: tests are usually a separate patch.

> @@ -231,4 +231,34 @@ __naked void bpf_cond_op_not_r10(void)
>  	::: __clobber_all);
>  }
>
> +SEC("lsm.s/socket_connect")
> +__success
> +__naked int bpf_neg_2(void)

Nit: I'd match __log_level(2) output to check the actual range
     inferred by verifier.

Maybe add a test that operates on 64-bit registers?

[...]

