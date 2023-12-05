Return-Path: <bpf+bounces-16763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67325805D5E
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 19:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22461281F3B
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 18:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AE8697A6;
	Tue,  5 Dec 2023 18:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDrzmEiC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B032C1A2
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 10:30:14 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-54cb4fa667bso3446698a12.3
        for <bpf@vger.kernel.org>; Tue, 05 Dec 2023 10:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701801013; x=1702405813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KxesyzshPHS1+eq5pCaTnrwPhR85EBbtsgcly2x6+f8=;
        b=aDrzmEiCLCwSFQWXsDiaFfZDhU5WHOpNtLeD6zOC/chdLpqGednK7rZoeam2JcnSvN
         T/zfwUBTfrINAS6lpgM89lCsmpZCfAgrOdpqBEP3njHLYpKidG1UOcOhhOU0plslkAse
         gJNWHp53+WVHMB5wmRqjk9EaNsBeqWsY5df4joksDbYp0JZn40Tzx1XJefkwC69e/whi
         AvjLTZDvc+bTWRLWJi/KHjqW/o3nlqhjBE3olCUnWkwf+QeQTiEkV9fZsdokNr5NMBVP
         altN5wgiWA/Ec6uGj9rD/L6Ar/ClBhizkjVgxK8dNckN5hodurV8QvYDY+ZFWITRQaAf
         gT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701801013; x=1702405813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KxesyzshPHS1+eq5pCaTnrwPhR85EBbtsgcly2x6+f8=;
        b=KbK3biLEd2dOrz5uWMzVq8+CPwiu8UxyooKZ8op2RrbZqpYDSprjb8AM16nDqWDVYR
         y2b5Yfr7LPYdXqT/da2Ta4xLkb8WEu0Jx1FqJ21V9UXhsp046E60VrC2EhRTfCK2rLPh
         PGeBnpxtOgT2tVZsZus8yxaUVIjJQEj7YCmm98slPIvlj6qghhK228w/FDva1fYTeGVo
         djSkoO7QMYV6yprBjL09NnmKzmho3cXqf/5Jl9VgLu0WadIjByHWLyi62XirJnROOLuS
         xeZKQP7UCz8lbfq9lr6O63wk15VArlTcak9VLaMdVN90m643a3P3uhlkq0zODcte0w86
         NNAA==
X-Gm-Message-State: AOJu0YxTVWeg4NT0G3+q3GkfdQIRrf1ZYafc4RaRLcpLYoN0LKdRmOmn
	ZlBUvmr9jLiAUTMRSVtKouUqMwGPs42bywvi4Ak=
X-Google-Smtp-Source: AGHT+IF2FRxTWmPiq09ZQ7Qvp23zDGMBesojnFq92P4PGdRILpZQIa7BuY/jhRpFdpOMU7B/sbzYEPimSE8sM0Kkcx4=
X-Received: by 2002:a17:907:1582:b0:a19:a19b:789f with SMTP id
 cf2-20020a170907158200b00a19a19b789fmr869618ejc.98.1701801012704; Tue, 05 Dec
 2023 10:30:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204192601.2672497-1-andrii@kernel.org> <20231204192601.2672497-4-andrii@kernel.org>
 <3fca38fdfd975f735e3dd31930637cfbc70948f4.camel@gmail.com>
 <CAEf4BzZ0Ao7EF4PodPBxTdQphEt-_ezZyNDOzqds2XfXYpjsHg@mail.gmail.com>
 <6875401e502049bfdfa128fc7bf37fabe5314e2f.camel@gmail.com>
 <CAEf4Bzb8LouFSSX5DED_ucgq_xuhukE1BQ7y=hxY0c17Nq4T+Q@mail.gmail.com> <7aa8af01db4fdcbedab376423d3960c22016aba3.camel@gmail.com>
In-Reply-To: <7aa8af01db4fdcbedab376423d3960c22016aba3.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 5 Dec 2023 10:30:00 -0800
Message-ID: <CAEf4BzbK-D0+WU8A--+43TXb2rgUgNPaUs3Dbg4Rz1_hL6A_tw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 03/10] bpf: fix check for attempt to corrupt
 spilled pointer
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 5:34=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2023-12-04 at 19:56 -0800, Andrii Nakryiko wrote:
> [...]
> > > > So it makes me feel like the intent was to reject any partial write=
s
> > > > with spilled reg slots. We could probably improve that to just make
> > > > sure that we don't turn spilled pointers into STACK_MISC in unpriv,
> > > > but I'm not sure if it's worth doing that instead of keeping things
> > > > simple?
> > >
> > > You mean like below?
> > >
> > >         if (!env->allow_ptr_leaks &&
> > >             is_spilled_reg(&state->stack[spi]) &&
> > >             is_spillable_regtype(state->stack[spi].spilled_ptr.type) =
&&
> >
> > Honestly, I wouldn't trust is_spillable_regtype() the way it's
> > written, it's too easy to forget to add a new register type to the
> > list. I think the only "safe to spill" register is probably
> > SCALAR_VALUE, so I'd just do `type !=3D SCALAR_VALUE`.
> >
> > But yes, I think that's the right approach.
>
> 'type !=3D SCALAR_VALUE' makes sense as well.
> Do you plan to add this check as a part of current patch?

nope :) this will turn into another retval patch set story. Feel free
to follow up if you care enough about this, though!

>
> > If we were being pedantic, though, we'd need to take into account
> > offset and see if [offset, offset + size) overlaps with any
> > STACK_SPILL/STACK_DYNPTR/STACK_ITER slots.
> >
> > But tbh, given it's unpriv programs we are talking about, I probably
> > wouldn't bother extending this logic too much.
>
> Yes, that's definitely is an ommission.

