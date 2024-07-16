Return-Path: <bpf+bounces-34925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B962932FD1
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 20:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB15F282B98
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 18:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412731C6BE;
	Tue, 16 Jul 2024 18:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9/TziaA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA69101D4
	for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 18:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721153726; cv=none; b=bZNvhXuZ9JXkNCSYLzsRJf4TcL4dGQBkNCYkJiCYVoYXbgjwNYa662jLesCH4NhrgWW1RgS6IMFTK6EWmIe1++W6kLAC5TL9nbhqUAAS3ercRCr56JucoWkguGzjlK+PJ9jtsZWHzpmmiAR2XK/YsaD1nezdjHwPUHdP/mKNgbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721153726; c=relaxed/simple;
	bh=TAIaLCCHD1XRdcy1SJwJnGRKxlfnyGGUZDVlZ6viVsM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RPAKQfBJR2CnzT2635CWQX9XEr5oRSsDyZgHkh+7yuU0/D+iTi5iFmt0N1Gu+WHkLS2g2XYt5enDx6wn8zNz3z0oLaLHMYVq2+H6ZivgDNaoR6XYX0/UQklzGoh0vOB8yvH1OF+vOO6M851FRrLSuV8cFSseVeRIk7II1P1y9U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9/TziaA; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fb4a807708so52258055ad.2
        for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 11:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721153725; x=1721758525; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CV3XhgRn/O+4lkZP6G899ME03nMyKF+kA0jczS9QDZU=;
        b=H9/TziaA0HnPCP5DxFO+m3odVBtXAD/5C4Xj7AYBoYOgcEEORR8i2xYx05RfuqyqBb
         btUMRqtr/sAYc6SsSJDKbhLfSb4C2lfNjVNe8MDheESKi6bHBHdRJ23AB7Qz4gH26ioP
         jpdsLoKOKxfCksF0ndq/Vovej7gMm0GfiftefC4dtqYVzNf8OZ7n836kgsvQgZwrCqId
         +Lp2k1e1WKPVjDIcLsoDAWAzBXCkFhk8mHEnoyEfvW+ye1vulfkeO/nODBdMqHYuXdUJ
         j8xpmgc4HENOD5Bh1mzHCEidIVkgY8Ds2m3PfnrxT+2VTmWKxB8VCyu8MC9PE2Dmi4KH
         PF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721153725; x=1721758525;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CV3XhgRn/O+4lkZP6G899ME03nMyKF+kA0jczS9QDZU=;
        b=uEIfGpCfC+YRJRC6jXn16cSLa40d87FGvVQ3Ljlay4lQcPzF9EwU5CQKiK950zKfF8
         rUA1KKnYpTEJweTq73pHpZaUnjg1hVOqiBlxn8vBerbs4xhkte6T+6uQluLx8uISkLlj
         7wIWxxO0pD2/fCn0oAEUItpiHyoBR1LXAQ/N/4stkIBJfpig1j3MDqcP/2GdetnvFFP6
         jgETXggFC3BMa05WDKPwzrk2gCnOGYqZ1GgFka2G5Z+tVZRxmiw2Ayf67qn3BDkf3F+O
         1O8ylDesIzmmBPCCzIVnPGZDAsUDqXrDzTBo7TlBzvwYVUJ5DSSI1WcTtpYK+iGX6uCw
         kUaw==
X-Gm-Message-State: AOJu0YyBC3YTD3JfXHIgeONXHCnNIzAuIxURj1EQF+dbKbiuProIvb1f
	I7A1A2naxFNlm2tHZyBNRy3zT6tlUPoN2m2vwfm0OMwqcsenlBc1EQJJ+Q==
X-Google-Smtp-Source: AGHT+IGFq98jxfscnQ9MOJCqqP7mfNSqly9XtUGy4Xl9l8oUeI9dUSNELLvXqCSAevomr7Yn3PGf+g==
X-Received: by 2002:a17:902:f604:b0:1fa:7f7e:2e0a with SMTP id d9443c01a7336-1fc3da40b6emr27345875ad.65.1721153724653;
        Tue, 16 Jul 2024 11:15:24 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc39f2asm61326685ad.193.2024.07.16.11.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:15:24 -0700 (PDT)
Message-ID: <f27a6146f8ef01fe01efc8b69cba1263b3f45ce9.camel@gmail.com>
Subject: Re: [bpf-next v3 11/12] bpf: do check_nocsr_stack_contract() for
 ARG_ANYTHING helper params
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song <yonghong.song@linux.dev>, "Jose E. Marchesi"
 <jose.marchesi@oracle.com>
Date: Tue, 16 Jul 2024 11:15:18 -0700
In-Reply-To: <86c8004aab94e0e833b438ef2fba25f0835a9aa8.camel@gmail.com>
References: <20240715230201.3901423-1-eddyz87@gmail.com>
	 <20240715230201.3901423-12-eddyz87@gmail.com>
	 <CAADnVQ+2SC6w2h+bNBEZ-R--RVk5zgz2AA-x2=7X8azL26ua0Q@mail.gmail.com>
	 <86c8004aab94e0e833b438ef2fba25f0835a9aa8.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-16 at 03:03 -0700, Eduard Zingerman wrote:
> On Mon, 2024-07-15 at 19:00 -0700, Alexei Starovoitov wrote:
> > On Mon, Jul 15, 2024 at 4:02=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
>=20
> [...]
>=20
> > > This might lead to a surprising behavior in combination with nocsr
> > > rewrites, e.g. consider the program below:
> > >=20
> > >      1: r1 =3D 1;
> > >         /* nocsr pattern with stack offset -16 */
> > >      2: *(u64 *)(r10 - 16) =3D r1;
> > >      3: call %[bpf_get_smp_processor_id];
> > >      4: r1 =3D *(u64 *)(r10 - 16);
> > >      5: r1 =3D r10;
> > >      6: r1 +=3D -8;
> > >      7: r2 =3D 1;
> > >      8: r3 =3D r10;
> > >      9: r3 +=3D -16;
> > >         /* bpf_probe_read_kernel(dst: &fp[-8], size: 1, src: &fp[-16]=
) */
> > >     10: call %[bpf_probe_read_kernel];
> > >     11: exit;
> > >=20
> > > Here nocsr rewrite logic would remove instructions (2) and (4).
> > > However, (2) writes a value that is later read by a call at (10).
> >=20
> > This makes no sense to me.
> > This bpf prog is broken.
> > If probe_read is used to read stack it will read garbage.
> > JITs and the verifier are allowed to do any transformation
> > that keeps the program semantics and safety.

Ok, my bad, the following program works at the moment:

SEC("socket") // <---- used wrong program type
__retval(42)
__success
int bpf_probe_read_kernel_stack_ptr(void *ctx)
{
	unsigned long a =3D 17;
	unsigned long b =3D 42;
	int err;

	err =3D bpf_probe_read_kernel(&a, 8, &b);
	if (err)
		return 1;
	return a;
}

And it is compiled to BPF as one would expect:

       ... fp[-8,-16] setup ...
       4:	r1 =3D r10
       5:	r1 +=3D -0x8
       6:	r3 =3D r10
       7:	r3 +=3D -0x10
       8:	w2 =3D 0x8
       9:	call 0x71
       ... return check ...

So, the point stands: from C compiler pov pointer &b escapes,
and compiler is not really allowed to replace object at that offset
with garbage. Why do you think the program is broken?

I don't mind dropping the patch in question, but I agree with Andrii's
viewpoint that there is nothing wrong with this use case.


