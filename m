Return-Path: <bpf+bounces-18999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B748D823AA5
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 03:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ECB41F24C2A
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 02:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC211FA1;
	Thu,  4 Jan 2024 02:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjPqryJQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4770C4C6F
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 02:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3366e78d872so51661f8f.3
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 18:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704335226; x=1704940026; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h4MHiUEnCtZCzdSseD/Of/vjL7cXYmqR/Cqcu7kJxJU=;
        b=PjPqryJQX9zeuTkYMTE1xkD5Vx+6J/xS/r1k6YwR7QTStQrYN9qlev4tdj3BweMcxG
         W3qSvNa0FcaRyBiiT7M8KXBrn88ogoUhzN7X0UAvnwyYw88AyQIXDxhFl5yAfkEbnYtx
         onramoO0OCvPmaVmFJEmIgAQE5UNudYWTZ8P76/ClWMuHaigQR0Psc12RROFV1jsBTOn
         aDbCQcz0SH0vEp2vGK+xzU+bcfgTghO1+eQ7Fg6Uq7DxjjbITNu1zD5Usrou4A+VNEVM
         KOBGJ+/DScHBl4ZnoSEzYy9WwPJXLhip/wiDX0Lr5ytcvNnl+4/H/MRxLGYWMtV7A6hk
         tNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704335226; x=1704940026;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h4MHiUEnCtZCzdSseD/Of/vjL7cXYmqR/Cqcu7kJxJU=;
        b=Mg9tr330s6wJ5QSUJ+cxi6c/lJE2magqgSiZ+l3NuyIpY9LkVA5zIuGZnW+WiZdmnG
         A66IZS7UgxKisxZs/UX7KK0S0xsmJivS/qPhHlfqu8FErZ5jRiPkCB4XPFWl170lubsB
         y0efC68TMZwtOLQJ5HHqxa1NNV6PK+WqS/WGCgb2AfYsfktW+5v7pJ6Vcvg5FRNg04Gj
         Y2+hCvPe9riofYvo9l9+a9ck2CxsbuquOEtNAcLn9a8EEWOGgVlNnzT3i9euSJ0a+7tV
         Yr9NMJIv7sIiFiwJBMwVFhOzp/Bsl5j91zQxf8HvchPfx/1LCcD3Ed8rzzWlv1GwPVt4
         UGfw==
X-Gm-Message-State: AOJu0Yx70TKEv1H5fyy3rT3fiwC0avhWvvjOgIF8A8eTFWdU/xjNPWry
	vcPNVrNAYE5W9L7CYtMx+1EiXuJe17gX9A==
X-Google-Smtp-Source: AGHT+IGFRVX/FGcj4lnxs2hT6KwYyXpPSvIWiKYwfQObL8+PsizvvUrptmBmwQ5xuk+kYGeCHWM08A==
X-Received: by 2002:adf:f5c5:0:b0:337:39c7:2c9 with SMTP id k5-20020adff5c5000000b0033739c702c9mr1570680wrp.278.1704335226546;
        Wed, 03 Jan 2024 18:27:06 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id fj25-20020a0564022b9900b00556cd818dd2sm1603946edb.70.2024.01.03.18.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 18:27:06 -0800 (PST)
Message-ID: <a4c8b7b9f03ff3455fbf430862b370abe9337bc9.camel@gmail.com>
Subject: Re: [PATCH bpf-next 12/15] bpf: Preserve boundaries and track
 scalars on narrowing fill
From: Eduard Zingerman <eddyz87@gmail.com>
To: Maxim Mikityanskiy <maxtram95@gmail.com>
Cc: bpf@vger.kernel.org
Date: Thu, 04 Jan 2024 04:27:00 +0200
In-Reply-To: <20231220214013.3327288-13-maxtram95@gmail.com>
References: <20231220214013.3327288-1-maxtram95@gmail.com>
	 <20231220214013.3327288-13-maxtram95@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-12-20 at 23:40 +0200, Maxim Mikityanskiy wrote:

[...]

The two tests below were added by the following commit:
ef979017b837 ("bpf: selftest: Add verifier tests for <8-byte scalar spill a=
nd refill")

As far as I understand, the original intent was to check the behavior
for stack read/write with non-matching size.
I think these tests are redundant after patch #13. Wdyt?

> diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/to=
ols/testing/selftests/bpf/progs/verifier_spill_fill.c
> index 809a09732168..de03e72e07a9 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> @@ -217,7 +217,7 @@ __naked void uninit_u32_from_the_stack(void)
> =20
>  SEC("tc")
>  __description("Spill a u32 const scalar.  Refill as u16.  Offset to skb-=
>data")
> -__failure __msg("invalid access to packet")
> +__success __retval(0)
>  __naked void u16_offset_to_skb_data(void)
>  {
>  	asm volatile ("					\
> @@ -225,19 +225,24 @@ __naked void u16_offset_to_skb_data(void)
>  	r3 =3D *(u32*)(r1 + %[__sk_buff_data_end]);	\
>  	w4 =3D 20;					\
>  	*(u32*)(r10 - 8) =3D r4;				\
> -	r4 =3D *(u16*)(r10 - 8);				\
> +	r4 =3D *(u16*)(r10 - %[offset]);			\
>  	r0 =3D r2;					\
> -	/* r0 +=3D r4 R0=3Dpkt R2=3Dpkt R3=3Dpkt_end R4=3Dumax=3D65535 */\
> +	/* r0 +=3D r4 R0=3Dpkt R2=3Dpkt R3=3Dpkt_end R4=3D20 */\
>  	r0 +=3D r4;					\
> -	/* if (r0 > r3) R0=3Dpkt,umax=3D65535 R2=3Dpkt R3=3Dpkt_end R4=3Dumax=
=3D65535 */\
> +	/* if (r0 > r3) R0=3Dpkt,off=3D20 R2=3Dpkt R3=3Dpkt_end R4=3D20 */\
>  	if r0 > r3 goto l0_%=3D;				\
> -	/* r0 =3D *(u32 *)r2 R0=3Dpkt,umax=3D65535 R2=3Dpkt R3=3Dpkt_end R4=3D2=
0 */\
> +	/* r0 =3D *(u32 *)r2 R0=3Dpkt,off=3D20 R2=3Dpkt R3=3Dpkt_end R4=3D20 */=
\
>  	r0 =3D *(u32*)(r2 + 0);				\
>  l0_%=3D:	r0 =3D 0;						\
>  	exit;						\
>  "	:
>  	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
> -	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
> +	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))=
,
> +#if __BYTE_ORDER__ =3D=3D __ORDER_LITTLE_ENDIAN__
> +	  __imm_const(offset, 8)
> +#else
> +	  __imm_const(offset, 6)
> +#endif
>  	: __clobber_all);
>  }
> =20
> @@ -270,7 +275,7 @@ l0_%=3D:	r0 =3D 0;						\
>  }
> =20
>  SEC("tc")
> -__description("Spill a u32 const scalar.  Refill as u16 from fp-6.  Offs=
et to skb->data")
> +__description("Spill a u32 const scalar.  Refill as u16 from MSB.  Offse=
t to skb->data")
>  __failure __msg("invalid access to packet")
>  __naked void _6_offset_to_skb_data(void)
>  {
> @@ -279,7 +284,7 @@ __naked void _6_offset_to_skb_data(void)
>  	r3 =3D *(u32*)(r1 + %[__sk_buff_data_end]);	\
>  	w4 =3D 20;					\
>  	*(u32*)(r10 - 8) =3D r4;				\
> -	r4 =3D *(u16*)(r10 - 6);				\
> +	r4 =3D *(u16*)(r10 - %[offset]);			\
>  	r0 =3D r2;					\
>  	/* r0 +=3D r4 R0=3Dpkt R2=3Dpkt R3=3Dpkt_end R4=3Dumax=3D65535 */\
>  	r0 +=3D r4;					\
> @@ -291,7 +296,12 @@ l0_%=3D:	r0 =3D 0;						\
>  	exit;						\
>  "	:
>  	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
> -	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
> +	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))=
,
> +#if __BYTE_ORDER__ =3D=3D __ORDER_LITTLE_ENDIAN__
> +	  __imm_const(offset, 6)
> +#else
> +	  __imm_const(offset, 8)
> +#endif
>  	: __clobber_all);
>  }
> =20




