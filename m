Return-Path: <bpf+bounces-19050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B5D82482E
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 19:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A5681C22550
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 18:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E47126ADB;
	Thu,  4 Jan 2024 18:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNSISFVJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E45F28E09
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 18:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e9e5c97e1so941226e87.0
        for <bpf@vger.kernel.org>; Thu, 04 Jan 2024 10:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704393049; x=1704997849; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3NbtTDNz1OO1Xy0CTFBMxkfIzdL78neCxWNMZ/LSgAU=;
        b=iNSISFVJrHJdX8kNgGhvx5pDs8w+7Se/dh+r0SVL9AvVCRlnTnvY59L5O5KkPjvf1e
         +8tyT0SmqFx/CeegZKCDyQ2CYkk4clN6F+koqGxbbqFWOWy7T1p5CCiZ6cjZ8Mfi9j2D
         Bzrtb0OmDTwiQSe+QC+jiYWjOmopeTeIn9XCYsQn88EYZ+IRkOdpQbhDSUw8VHPXGa13
         klQRRL4+Th9fScuB3NhefAXQheWNEwh8NcoRoZrum4UiMO6Pb/o2WKa28PbVrdWzynvj
         xo4Hf/63IPEyindQBNuLuNrbMBqlLxIq5dT2gIhVc/21D9Drh4hxCJnJ8HuS+lGq2Tiq
         /3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704393049; x=1704997849;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3NbtTDNz1OO1Xy0CTFBMxkfIzdL78neCxWNMZ/LSgAU=;
        b=PlUH03ZmjnkroB4rWfX3iAnyR9s4CFZMWUWs4sq40qXEPIJYivcyGCxbU7yUDoM5OF
         ELWmlvDg4Wgac14uuyuE3bz+8xhGQ1w03Q+ylyHKgGRArqLBFjMjCQxsTii2k2GN/C1E
         JZb5DzDqmJJlPunw6MwKYmMA3wUaZiqu4wRkn5iBywtZNR3gDMT9TWNuTFFYzA1ZAjs3
         IJCk1y239X4zKRwL23A5Ja9nfM4mMdv/WJjC6VZYnQn/OphJaIY1b2HqJTUN2Z6WrI7t
         unN5Xszz/G8So/zcHfWS7DbtqoQidsc10KyRCQLim5bPCs0eZgvBRtzpqYP5NVB840Im
         mo2A==
X-Gm-Message-State: AOJu0YzzpLFo2t5DoE14AmgeTNocQ5BaXtHQJ+xJHIMuY0rPwrcpzWl5
	Z1QuI6FiMbGZhNgvFwCs65U=
X-Google-Smtp-Source: AGHT+IGrq6vFiTrMClh+VEdl3JSksrxaDZVWIf5yHJEIdWhp4PVw88XmF9C7ZWtb9B4C/NnUBg1HgA==
X-Received: by 2002:a05:6512:951:b0:50e:76aa:77d6 with SMTP id u17-20020a056512095100b0050e76aa77d6mr518273lft.32.1704393048580;
        Thu, 04 Jan 2024 10:30:48 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id n2-20020a170906164200b00a269e651abesm14354325ejd.176.2024.01.04.10.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 10:30:48 -0800 (PST)
Message-ID: <f4c1ebf73ccf4099f44045e8a5b053b7acdffeed.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Track aligned st store as
 imprecise spilled registers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>, Kuniyuki
 Iwashima <kuniyu@amazon.com>, Martin KaFai Lau <kafai@fb.com>
Date: Thu, 04 Jan 2024 20:30:47 +0200
In-Reply-To: <20240103232617.3770727-1-yonghong.song@linux.dev>
References: <20240103232617.3770727-1-yonghong.song@linux.dev>
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

On Wed, 2024-01-03 at 15:26 -0800, Yonghong Song wrote:

I missed one thing while looking at this patch, please see below.

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d4e31f61de0e..cfe7a68d90a5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4491,7 +4491,7 @@ static int check_stack_write_fixed_off(struct bpf_v=
erifier_env *env,
>  		if (fls64(reg->umax_value) > BITS_PER_BYTE * size)
>  			state->stack[spi].spilled_ptr.id =3D 0;
>  	} else if (!reg && !(off % BPF_REG_SIZE) && is_bpf_st_mem(insn) &&
> -		   insn->imm !=3D 0 && env->bpf_capable) {
> +		   env->bpf_capable) {
>  		struct bpf_reg_state fake_reg =3D {};
> =20
>  		__mark_reg_known(&fake_reg, insn->imm);
> @@ -4613,11 +4613,28 @@ static int check_stack_write_var_off(struct bpf_v=
erifier_env *env,
> =20
>  	/* Variable offset writes destroy any spilled pointers in range. */
>  	for (i =3D min_off; i < max_off; i++) {
> +		struct bpf_reg_state *spill_reg;
>  		u8 new_type, *stype;
> -		int slot, spi;
> +		int slot, spi, j;
> =20
>  		slot =3D -i - 1;
>  		spi =3D slot / BPF_REG_SIZE;
> +
> +		/* If writing_zero and the the spi slot contains a spill of value 0,
> +		 * maintain the spill type.
> +		 */
> +		if (writing_zero && !(i % BPF_REG_SIZE) && is_spilled_scalar_reg(&stat=
e->stack[spi])) {

Talked to Andrii today, and he noted that spilled reg should be marked
precise at this point.

> +			spill_reg =3D &state->stack[spi].spilled_ptr;
> +			if (tnum_is_const(spill_reg->var_off) && spill_reg->var_off.value =3D=
=3D 0) {
> +				for (j =3D BPF_REG_SIZE; j > 0; j--) {
> +					if (state->stack[spi].slot_type[j - 1] !=3D STACK_SPILL)
> +						break;
> +				}
> +				i +=3D BPF_REG_SIZE - j - 1;
> +				continue;
> +			}
> +		}
> +
>  		stype =3D &state->stack[spi].slot_type[slot % BPF_REG_SIZE];
>  		mark_stack_slot_scratched(env, spi);

