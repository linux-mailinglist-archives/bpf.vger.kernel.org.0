Return-Path: <bpf+bounces-45804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A53BA9DB1CE
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 04:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C1A3282277
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 03:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD3B84A5E;
	Thu, 28 Nov 2024 03:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEMI3vwI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BFC13211A
	for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 03:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732764161; cv=none; b=Ffykq3l7/dmKYs5BWedNqXo5e2Cm2SkILUClXuWnETVWtrJj+NgCjHfxz0/RRvM+jeNxNtDKPrgGOalkX6WPp8rg9Uyvfy1A0hziC2uDMBzXRA17NSqeHf2rjlLQBPvO+oskFDyNXsygt9cWiw4suuyZa0FgnGrbkkr5KlR/Z4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732764161; c=relaxed/simple;
	bh=MFyvZRt3atypgKGDq2MxJV5NXueYC/84XcyU2oKfc0A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ICtPpMW5j9mftp8mz887Z2a9BTWGA3dZGYkk03LFQECA2qm3Obij9g0qRTFzAra5MzhrgbSjZ2ro4f/xzD2Rz3sD+TnJl3z3iRxFeTNp09PI8+7BQgr4MsGR7R40z8lzfnVoWoyMt3KYObjwRpB462aWR6xnticjZdIJG76qsj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEMI3vwI; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7f71f2b136eso237398a12.1
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 19:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732764159; x=1733368959; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X1RGiMvpZ/F0OwoPRR39wRWcKJEu/Cw7WVb9WIwDfL8=;
        b=gEMI3vwIASWOQVRX7rR3sjWFMoKZxdYj4sbn40AImYu/vCNrgLjjHjD67Zdu+4H7wP
         KiD94QJBmz75iBDVOcm6JhE42Vjy3QEIU6mIb33niFr3w8sIiItjWqpQ6HFhw5Yvk5lB
         pa8dfCNNjpYQf9u9vYJoFMCNXRrw+44WaLfoWXatsYVcg8GmCip9J1dsraJb/tC0Pv7O
         Puhr8cfBbFitCjW/2n5YNb82sMepijYG48eJo3VXlMqtJdmEA5JesnaIcivmVRYsD4Oc
         XZc9p1anv7kbaJeG9DquQUat5DIj/gAORjoPHkHxcQnY3GgIHbeZKvr25VB3gH/fPa8t
         DOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732764159; x=1733368959;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X1RGiMvpZ/F0OwoPRR39wRWcKJEu/Cw7WVb9WIwDfL8=;
        b=qfAhzvJbW4YPLK+C3Kpbjk4ICVXM6TeP0rL3nuptisSVegmjHoJ4nXwUyWA1VAX0sh
         /2OwPOh8lGmZ+4iPkV7tPAbbFoQM380G4/WcrbA4VRXgO//hWHW96pFJZkdigw9OCVCH
         RZCELitzfPA/QLH13TkcHonmhN6r5WIF3ZAuxxv8nY1SoI7b5NRZvzVndgPcQmwE2JM4
         oEY21Ew7kP38dSjNpv9L+T16lykFsvfFm40XqbbdmxkxW7EHbPjOnOSYbjzkMExL6/jB
         10G9UXoNtVLQZfEUjJISCIZnZauoumL1HxN/b56oGzrNZRxLcS6bSX/AyFJzKCwMaoW9
         dncw==
X-Gm-Message-State: AOJu0YzIecbtM2vEPr9IObMj6SmoLOAWTGBp+8DuyoMXjusVhNHSRbUQ
	V5hFv/OfKazmFPfT6GFdN+zvr9i+cmBdIj5ES9zhl6O85uznPkSt
X-Gm-Gg: ASbGncu2w6FWUlNkYBK9wQ/M+grXJSXYn5Cd3BCqon5AbCT06gh665TGrY7/j3KAJ/x
	7bqBvhqSNXTD6As8aQaKAgdwbNNdMVqbOWhXjQfuSSKqTMh/ujIQCZ8ttOPPZ8e1TvuQMICIz7x
	MqXhLi2kmoUjMiwKBIVEytgy5lDOxqpAOo2KI0My6Y19pmDtlcyDFvZ2RyPHNyfaDDj9D3mOUos
	o+KLSnKzgTCqg18Jn3sK/gkl9MJa+FKPJQffMv/OUQaUUg=
X-Google-Smtp-Source: AGHT+IE7F5/bA7dogGD5FkH9jOKBdHKf4PAZ+3nhgb/RkGaq0e4tPihX42qa0qcMSvXcT7hLnY5Szw==
X-Received: by 2002:a05:6a20:3944:b0:1e0:d2f5:6eca with SMTP id adf61e73a8af0-1e0e0c67e7dmr9727727637.46.1732764159572;
        Wed, 27 Nov 2024 19:22:39 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c388ea6sm285128a12.57.2024.11.27.19.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 19:22:38 -0800 (PST)
Message-ID: <68eadb6b1c51707be249af9bacc7afcbfa16df0f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/7] bpf: Consolidate locks and reference
 state in verifier state
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>,
 kernel-team@fb.com
Date: Wed, 27 Nov 2024 19:22:34 -0800
In-Reply-To: <CAP01T76RCf1oHmWhhE8MzUYgJhkxkkqW7gRFCAPGiAgv8v7WkA@mail.gmail.com>
References: <20241127165846.2001009-1-memxor@gmail.com>
	 <20241127165846.2001009-2-memxor@gmail.com>
	 <a4690c29ca3b5f34945cd507def7e0c6ecdec9e1.camel@gmail.com>
	 <CAP01T77t=FmvzyeCJ_3Bp+8D0-Z4GGUHNeGbNBmSY6xFXi-ZgA@mail.gmail.com>
	 <3cc26b1923426203b3d0df91ebb1638c0e492696.camel@gmail.com>
	 <CAP01T76RCf1oHmWhhE8MzUYgJhkxkkqW7gRFCAPGiAgv8v7WkA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-28 at 04:18 +0100, Kumar Kartikeya Dwivedi wrote:
> On Thu, 28 Nov 2024 at 04:03, Eduard Zingerman <eddyz87@gmail.com> wrote:
> >=20
> > On Thu, 2024-11-28 at 03:54 +0100, Kumar Kartikeya Dwivedi wrote:
> >=20
> > [...]
> >=20
> > > > > --- a/kernel/bpf/log.c
> > > > > +++ b/kernel/bpf/log.c
> > > > > @@ -756,6 +756,7 @@ static void print_reg_state(struct bpf_verifi=
er_env *env,
> > > > >  void print_verifier_state(struct bpf_verifier_env *env, const st=
ruct bpf_func_state *state,
> > > > >                         bool print_all)
> > > > >  {
> > > > > +     struct bpf_verifier_state *vstate =3D env->cur_state;
> > > >=20
> > > > This is not always true.
> > > > For example, __mark_chain_precision does 'print_verifier_state(env,=
 func, true)'
> > > > for func obtained as 'func =3D st->frame[fr];' where 'st' iterates =
over parents
> > > > of env->cur_state.
> > >=20
> > > Looking through the code, I'm thinking the only proper fix is
> > > explicitly passing in the verifier state, I was hoping there would be
> > > a link from func_state -> verifier_state but it is not the case.
> > > Regardless, explicitly passing in the verifier state is probably clea=
ner. WDYT?
> >=20
> > Seems like it is (I'd also pass the frame number, instead of function
> > state pointer, just to make it clear where the function state comes fro=
m,
> > but feel free to ignore this suggestion).
>=20
> I made this change, but not passing the frame number: while most call
> sites have the frame number (or pass curframe), it needs to be
> obtained explicitly for some, so I think it won't be worth it.

Understood, thank you.


