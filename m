Return-Path: <bpf+bounces-19068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44866824A09
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 22:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47CD31C22A41
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 21:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32E82C681;
	Thu,  4 Jan 2024 21:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gf8jmWF9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8DF2C197
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 21:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-556ea884968so1123100a12.3
        for <bpf@vger.kernel.org>; Thu, 04 Jan 2024 13:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704402661; x=1705007461; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9lgi06d3yN5Bpyuv41l7fyHcUe/8liHKpmoiKC3Wj+o=;
        b=gf8jmWF9DZDTNpPivMhh1aWlgveq/xqg23dPYpWbLY8PlmpSdFJ796mC/DwruvzPqE
         ePTudrZL2K14nWcWGk/BOZT+CgmdYhTIgzwy2kcsCFC1KIVSxnbc7zAd2SFBoxY3hRLW
         7c2m+BIq7PcOMNA+vEzjhSBrrSX8VbB4AVSE1D9N6ncAcZ5sjHF6DLcp2JFuNGcixkoH
         wyvgfYQzn7ZROs3Dlce1hFa7V2fUpdLQbBhHBNUnO/G9hixRc4LBaQbFK2kKTzE1PlgW
         SSomAQ54iAmTI2h9wgJo4HVCt6j+ykr4cs6TYUJ3xd03N9k/Lb8QHkoy143YCmfoUGuD
         TJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704402661; x=1705007461;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9lgi06d3yN5Bpyuv41l7fyHcUe/8liHKpmoiKC3Wj+o=;
        b=KBIGAGGMk8CM/QRxSPS6UGoV73ZGVdl2g5BhOHwvgWfKCPaM6G8M97v3RfPdXqleK9
         gu7pozf0pXByyqMcJcEWI4xz2v+/5QtMQNpoh5tvjvJYq4o53+jIPIBPpT3QkwA9aI0j
         pl3DAT6ag+5dVfLNOVWXtQg7zbDHX7hRLADFeatXWn0lUT3feEGTT9hY/F34DaDkHPl1
         dJGD5zYLBaDdF3MbzJ+8w6rjSIMQsCXoNUBTLe6sB3qKnP1GHl3DLGE1zh+0QY4h+rSk
         scgShcFVbqGQfENiD7XqGdOT2cKSWRbbP2i8aWewbndd6NUze/qhaflHJZBBEwmFow8R
         AkVg==
X-Gm-Message-State: AOJu0YwbGjD8mF6+uTcjaFCTqTJISFMdNNVXCRa3eArZAFGfnS7VNcKV
	feWux9E824mslsqPPJ2lnYE=
X-Google-Smtp-Source: AGHT+IG3q+6EgNSO58Idpp5jC0TEn4nl6y1ZDlqW1pSwVriyByU7wicjtmVrEfSJdvInUMAS6wrM0g==
X-Received: by 2002:a50:aac3:0:b0:556:e0ee:85bc with SMTP id r3-20020a50aac3000000b00556e0ee85bcmr631738edc.51.1704402660861;
        Thu, 04 Jan 2024 13:11:00 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id t21-20020a508d55000000b00554753ec02fsm139307edt.86.2024.01.04.13.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 13:10:59 -0800 (PST)
Message-ID: <69410e766d68f4e69400ba9b1c3b4c56feaa2ca2.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Track aligned st store as
 imprecise spilled registers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>, Kuniyuki
 Iwashima <kuniyu@amazon.com>, Martin KaFai Lau <kafai@fb.com>
Date: Thu, 04 Jan 2024 23:10:58 +0200
In-Reply-To: <cbff1224-39c0-4555-a688-53e921065b97@linux.dev>
References: <20240103232617.3770727-1-yonghong.song@linux.dev>
	 <f4c1ebf73ccf4099f44045e8a5b053b7acdffeed.camel@gmail.com>
	 <cbff1224-39c0-4555-a688-53e921065b97@linux.dev>
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

On Thu, 2024-01-04 at 12:12 -0800, Yonghong Song wrote:
[...]
> > > @@ -4613,11 +4613,28 @@ static int check_stack_write_var_off(struct b=
pf_verifier_env *env,
> > >  =20
> > >   	/* Variable offset writes destroy any spilled pointers in range. *=
/
> > >   	for (i =3D min_off; i < max_off; i++) {
> > > +		struct bpf_reg_state *spill_reg;
> > >   		u8 new_type, *stype;
> > > -		int slot, spi;
> > > +		int slot, spi, j;
> > >  =20
> > >   		slot =3D -i - 1;
> > >   		spi =3D slot / BPF_REG_SIZE;
> > > +
> > > +		/* If writing_zero and the the spi slot contains a spill of value =
0,
> > > +		 * maintain the spill type.
> > > +		 */
> > > +		if (writing_zero && !(i % BPF_REG_SIZE) && is_spilled_scalar_reg(&=
state->stack[spi])) {
> > Talked to Andrii today, and he noted that spilled reg should be marked
> > precise at this point.
>=20
> Could you help explain why?
>=20
> Looks we did not mark reg as precise with fixed offset as below:
>=20
>          if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) && =
env->bpf_capable) {
>                  save_register_state(env, state, spi, reg, size);
>                  /* Break the relation on a narrowing spill. */
>                  if (fls64(reg->umax_value) > BITS_PER_BYTE * size)
>                          state->stack[spi].spilled_ptr.id =3D 0;
>          } else if (!reg && !(off % BPF_REG_SIZE) && is_bpf_st_mem(insn) =
&&
>                     insn->imm !=3D 0 && env->bpf_capable) {
>=20
> I probably missed something about precision tracking...

The discussed justification was that if verifier assumes something
about the value of scalar (in this case that it is 0) such scalar
should be marked precise (e.g. this is done for value_regno in
check_stack_write_var_off()).

This seemed logical at the time of discussion, however, I can't figure
a counter example at the moment. It appears that whatever are
assumptions in check_stack_write_var_off() if spill is used in the
precise context it would be marked eventually.
E.g. the following is correctly rejected:

SEC("raw_tp")
__log_level(2) __flag(BPF_F_TEST_STATE_FREQ)
__failure
__naked void var_stack_1(void)
{
	asm volatile (
		"call %[bpf_get_prandom_u32];"
		"r9 =3D 100500;"
		"if r0 > 42 goto +1;"
		"r9 =3D 0;"
		"*(u64 *)(r10 - 16) =3D r9;"
		"call %[bpf_get_prandom_u32];"
		"r0 &=3D 0xf;"
		"r1 =3D -1;"
		"r1 -=3D r0;"
		"r2 =3D r10;"
		"r2 +=3D r1;"
		"r0 =3D 0;"
		"*(u8 *)(r2 + 0) =3D r0;"
		"r1 =3D %[two_byte_buf];"
		"r2 =3D *(u32 *)(r10 -16);"
		"r1 +=3D r2;"
		"*(u8 *)(r1 + 0) =3D r2;" /* this should not be fine */
		"exit;"
	:
	: __imm_ptr(two_byte_buf),
	  __imm(bpf_get_prandom_u32)
	: __clobber_common);
}

So now I'm not sure :(
Sorry for too much noise.

