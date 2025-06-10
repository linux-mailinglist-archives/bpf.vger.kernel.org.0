Return-Path: <bpf+bounces-60249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A5EAD4602
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 00:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E6F37A336E
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 22:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0439286D71;
	Tue, 10 Jun 2025 22:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NqW38djB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95A32686A0
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 22:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749594723; cv=none; b=LSe+z61AvfbED70UCoA/WKRemudBhzSkPNy1uw3O4yq+y1sW3h5nnsT5+6ZVfLVIap/g9fBNsPRc9W2Ejw61SWHWqKbbgQKPbaTmk7Leg8POYLkiSofvx/8435VmdYhxYitIbYqIIVL95X+hfGWYapOeWLRpL5kfarZNBh6hKaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749594723; c=relaxed/simple;
	bh=fVyuMs5wEHh9PifuXzZaCZW55tmcH2IrOUzv8Hv71RU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ujv2jsZC67KXr7pDX2tDKzrbDvPSXmdwyTiGIojeShGXDMSFX7j3rZgl1P0rGSfBbyeoDWAkVNq3bUZEeAirPz8+8ngRTcdobn2tBv5CQznusOYNiNovqtS4ZrqPnWQnC/mJz+xXyGJezl1FeCQVeH1aPeE7g/VJtA/CAW+lXVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NqW38djB; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-70a57a8ffc3so59473237b3.0
        for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 15:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1749594721; x=1750199521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJ6l+yEiVxr1pNGEQGaOqFOGipnplcDF76/qLPufpH0=;
        b=NqW38djBal1sFYmcvT1Y5SWVL1A3FB9maQnCFvEN1ARxvdVp8pXn2Knhpy7c5V/Cnz
         Cg9Lld367PXPqTp0rKRoEuvpX7qU5L6FI1pRYdC+43FQSluYeBGC1LHLBPr3zbT9m7Zn
         npsxmd5pb6VwBIW+it7fWa4YxTU9vyi6OKs7obXJ7GcsIXOvb8z9NyyGolN7OdXdXmVU
         xSD33064aAlHe7lhugObMq+qPERjW1xuter1GkmGygBpcMnLX6M7J427RfNg2pswxpEJ
         vo6B1h1mRXwEmu23VSL1HeswvJFNtIKK9iz3uUj2N3V812GtwW/QsyX7dA0lSq9bWVnr
         v91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749594721; x=1750199521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oJ6l+yEiVxr1pNGEQGaOqFOGipnplcDF76/qLPufpH0=;
        b=LsVSLrHPWaHvL0d9jNdobu//gL4pKZ07X5Y/6AcmcfMEgqj18qhgNpmRAklZS26mXl
         8cubthALeTMp4j21ZqZK6BW1FK/6GZPX7HbvNRJPzvVFjcJenYGcBqcly7I9utR3Y001
         UBueMZIyztWIUP5XbiNGixMsfQ+PKTYvC39w9Ac8ZoJdriMHRZz/C1BUC6mwFERQ2jy6
         yR5VuNaNLc/BBeHO89uBnzPnt1PeWkXBmYIvyjbOEJmEo33mH6wxujoGbpdaDtuJlynI
         XfCaitN1YUWM2hX9yjVMB8kaNLincfCt8KS4UZruo0/mEbbhXHSDFj+NFC/q2B8sIOBe
         kbLg==
X-Forwarded-Encrypted: i=1; AJvYcCXfMUsaXzVJiV631kooTKN2OmgTS4+ECRyFQBhX676wfAxJLR8JREFf6t9bJjxh5vkmccI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3SzAD38BlnmgAzIELLIJhBqoEcb40PHwGGQ+H3oYO9aEkmrIM
	U9Vzgj8o/Bn4Y8neyNUklbLqcgpCihaAz3D5AnY1+AgQnxJcOcmuD48cw6BfolXXZso+CEc9nCo
	swDs7uQoCVt2ZDYZOXaA3fWDk+U/BtXT1cExj5qtC
X-Gm-Gg: ASbGncvzjw7mY168RMwhSK/36EAUImKUJ6n0Ywf/Y093W3cxYZ0BMyvlFqxfiVf0y3f
	a033FiaHyKg3JrQZ8SHw9Z3C+uWA1Uef+xqczSol5hQP6oBQFo14aUftZmpyyXHrCfJgAmyQNA8
	Cbr4eEFLtU/CCwQ2KoeiTOIp7fiDnceEQPpxUqFFPzG18=
X-Google-Smtp-Source: AGHT+IHaaUlD03n52oEjNObUj+hcQLQUuNTQ+nktkM3lhu1/6afPeePwmkD0IMlQ7EJD8bQTEj5lyIh1mDJ9wD2+8BE=
X-Received: by 2002:a05:690c:6f07:b0:70d:f07c:f593 with SMTP id
 00721157ae682-711423b5f53mr11433127b3.6.1749594720772; Tue, 10 Jun 2025
 15:32:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606232914.317094-1-kpsingh@kernel.org> <20250606232914.317094-11-kpsingh@kernel.org>
 <87qzzrleuw.fsf@microsoft.com> <CACYkzJ6M7kA7Se4=AXWNVF1UyeHK3t+3Y_8Ap1L9pkUTbqys9Q@mail.gmail.com>
 <87o6uvlaxs.fsf@microsoft.com> <CACYkzJ74MJkwejki7kFNR4RWh+EnJ++0Vop8eRkSwY6pJepMEQ@mail.gmail.com>
 <8cf2c1cc15e0c5e4b87a91a2cb42e04f38ac1094.camel@HansenPartnership.com>
In-Reply-To: <8cf2c1cc15e0c5e4b87a91a2cb42e04f38ac1094.camel@HansenPartnership.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 10 Jun 2025 18:31:49 -0400
X-Gm-Features: AX0GCFsNQ7O8dBGMdD6GCumtjN-NVq04ERQppfo2oV-EpzEuuGYvZnKQs2MiuKA
Message-ID: <CAHC9VhS6EwOXX7LBFh+odVLj4vB6t=HADAK-787r-H1p4kpHuA@mail.gmail.com>
Subject: Re: [PATCH 10/12] libbpf: Embed and verify the metadata hash in the loader
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: KP Singh <kpsingh@kernel.org>, Blaise Boscaccy <bboscaccy@linux.microsoft.com>, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, kys@microsoft.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 5:24=E2=80=AFPM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> On Tue, 2025-06-10 at 21:47 +0200, KP Singh wrote:
> > It's been repeatedly mentioned that trusted loaders (whether kernel
> > or BPF programs) are the only way because a large number of BPF
> > use-cases dynamically generate BPF programs.
>
> You keep asserting this, but it isn't supported by patches already
> proposed.  Specifically, there already exists a patch set:
>
> https://lore.kernel.org/all/20250528215037.2081066-1-bboscaccy@linux.micr=
osoft.com/
>
> that supports both signed trusted loaders and exact hash chain
> verification of loaders plus program maps.  The core kernel code that
> does it is only about 10 lines and looks to me like it could easily be
> added to your current patch set.  This means BPF signing could support
> both dynamically generated and end to end integrity use cases with the
> signer being in the position of deciding what they want and no loss of
> generality for either use case.
>
> >  So whatever we build needs to work for everyone and not just your
> > specific use-case or your affinity to an implementation.
>
> The linked patch supports both your trusted loader use case and the
> exact hash chain verification one the security people want.  Your
> current patch only seems to support your use case, which seems a little
> bit counter to the quote above.  However, it also seems that
> reconciling both patch sets to give everyone what they want is easily
> within reach so I think that's what we should all work towards.

I agree with James, I see no reason why the two schemes could not
coexist in the kernel; support both and let the user/admin/distro
decide which is appropriate for their needs through policy.

I'm sure Blaise would be willing to build on top of KP's patchset if
that really is a sticking point.

Finally, I just wanted to bring some attention to my last comment on
Blaise's latest patchset as the needs mentioned there seem to have
been ignored in this patchset.

https://lore.kernel.org/linux-security-module/CAHC9VhQT=3Dymqssa9ymXtvssHTd=
VH_64T8Mpb0Mh8oxRD0Guo_Q@mail.gmail.com/

--=20
paul-moore.com

