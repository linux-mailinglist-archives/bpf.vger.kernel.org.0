Return-Path: <bpf+bounces-76442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8DFCB4492
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 00:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B36A2301842C
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 23:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6B931CA7B;
	Wed, 10 Dec 2025 23:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="eGR+SZjI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449AA4A23
	for <bpf@vger.kernel.org>; Wed, 10 Dec 2025 23:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765408735; cv=none; b=PmsOoZoMdDYm13dBgMmDuy/FIcwc6GnqWGxmnPCP3yNqHUs/W9THhW3S1MVUl1GunvcfXk8v0+/Xn8ovFYBc/abRPPi0tRwgqEglbIseYqtsR9Z4gnQYuFe3iLNTeWLJy+jxKQtd5IX819YpjMDrfZaeF446KIfmCX2e1bVN21o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765408735; c=relaxed/simple;
	bh=oBGWwAk1dlLiq5iSyZDcDb+MN0DbVkZn6LRM9AmiesE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QIMy0HfSq3nI1ighiUttZ1r6wvbgSKxYeCcX61Pf4+3yVxyQ22CE/Kc0An4YJQCzPPm+uH3jGiUW50JGKDJsh4eICmKClqB002pB1KsOl1/4pcY3fWaWTJeYwB6eN04AeWjJ5riyHASnoEnI4c8pvHtxyYMgqlEHorLZqYrSXjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=eGR+SZjI; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0B8653F2B3
	for <bpf@vger.kernel.org>; Wed, 10 Dec 2025 23:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1765408722;
	bh=sIaosH07Gafx59MUdEA02TlpZ0yTFoN5xt9+F0UBKeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=eGR+SZjIg1/ePbOtgBSWziqrWXVLFgudWkrr3zngVfXU804sl9reeOVpuqDz4VO0T
	 dIGgjzVHtnVOCG3aiIh8oHuTO02Yj8k4wqFKblaDgPN2cP3Zi4Loain3RicTMr4gF3
	 hwqkdsDHgKEnwpfCvohSvQ1XCIJcQwIMW9R8dPOwd7rqYR+Ko7P7mc6NlQMoYMPJNV
	 aDWmPpptrvB0IVev3qDqJffXH47dOird0cJjMg9rsZn3HhIUbGnP6+037f2/PZO017
	 RwAmEcJ6vkKnQnkzqFidbljiT2ghnr0AGuiFffwOrsoXJdPUghcpejM0M4RLu7bzUv
	 MesZFBO/x5x/Ys93QclvvJ8aS3V0zeGUegidDnL2RfqMAuWpsF00U0lsb0X2v8aP0h
	 ab7jPk+5RiidK33meW7GAJKF0JibQQunr1m0BRn52BBcwznxMxZyk/PIhMIVF4VvrA
	 lkxwymUopecULYvIu7TcVTvIoZxWQGbb1WiX0LuBXDRTo2+pAds7ltIKkYSZ7z/COG
	 eSbVgFrLMoIl423/K1hcXIREvtI53ppZTIo1Ysa5GDNztmp/3KmRmhwyzt9q01CgKB
	 sFS6keDfhKZJykNKJatna9HYwKORHw66WtxEyTC5TjSP0zkbD+DtU3gLpiQky34yo2
	 6ADDnO9s6jVqAjqYDgIFhr0Y=
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-5dfa91798b0so192268137.3
        for <bpf@vger.kernel.org>; Wed, 10 Dec 2025 15:18:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765408720; x=1766013520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sIaosH07Gafx59MUdEA02TlpZ0yTFoN5xt9+F0UBKeQ=;
        b=kUMwV5FS8HWJAXbbMzIYNCF8PtYM51hESovGSLVmeDEXT/wM4ypId1WaE8heGsnQti
         wwJJ1HdyMbXfWli9M+ukFRFOWbt0LswF0wxuDAWRQ2EXGxbc1URCh6Cff0LN1u9LGrCD
         mkAtxX+ZHaTYg88Y3G0KIf0BZEW0ckua011/U2b0RpsUMmuIObFIk8wQCrh9Tii3BQfz
         kUxM4WD+jthGJIwnxO13ESQO+l/iXRohaasSWE5nHM72eKm8edV277S8VMz4RAbw+I9v
         7Ct1XtrX3SzN2XWAedNHP8Buz33Ygw6zJIVS3idNBFCL19WaQbvUNKRG3YqW8LF3BI70
         GGuA==
X-Forwarded-Encrypted: i=1; AJvYcCXvlawoaiQfRsqKdzxj9uNQb2i33AJsghSP5s9HcJ0/oQnceBEu7ASjSAajC1SE/bW+wVE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz223QZiPyP1PL3ElQlaIZEKTLY/4DTJKggpQolokvDd3VIJFNU
	DuO+MLyqF32hi6INJzCsp9vgoP0NkFT7jegMuvoQQjDl7zYyVx8293WSgCUWzh9d+RQ4NdmCSOO
	wzN7JcWI0dADYViPoeoTV2CYkp0c1YJwz5yshFV4IPkGRIAkJ3ZQ6kvua564HtKo5G2hDPyQC52
	zamE5lXapvwQBFOXlDeMxHxyaq3Hgk009k76Msgo4dyoCR
X-Gm-Gg: AY/fxX6ADKoD9Ef0Wnn5PUc5GBsk2ckxu7BNaAmdRTPJeh+mXJ4IPYMc+7X5Ruxpmtg
	p9IFNKDm2vB9GvSeOvY/l/XX/4++x34x1FcwDIThNJdoKz1ggecBr74NuavPGEtlSGoSNNFtov9
	k84Hm07Zn9E/+k1Gnyj6EDJOChwRbhGHGf7ncLh5BfkuDGeqOexaxaEftSUsFMnfc4irjx1TG2L
	RlotCglA3LkB6AnqY2b9zXe/Q==
X-Received: by 2002:a05:6102:4407:b0:5dd:89ad:1100 with SMTP id ada2fe7eead31-5e5717fa98emr1340351137.6.1765408720229;
        Wed, 10 Dec 2025 15:18:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0HSTpikv4Krz+XVqS/horHW7O0kIOyu9pv2LhSM98u9NVs8LxPXdhrQlYg6EBhKlhJeu576DhcO6Yhn/ECi0=
X-Received: by 2002:a05:6102:4407:b0:5dd:89ad:1100 with SMTP id
 ada2fe7eead31-5e5717fa98emr1340344137.6.1765408719816; Wed, 10 Dec 2025
 15:18:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202115200.110646-1-aleksandr.mikhalitsyn@canonical.com>
 <20251202115200.110646-5-aleksandr.mikhalitsyn@canonical.com>
 <CAEivzxf0a8EDzVJ+j7FLuarKHrCRPUtS9Z+tQ4se9E+xHvE0Fg@mail.gmail.com> <aTGmOGTNndl3oTk7@tycho.pizza>
In-Reply-To: <aTGmOGTNndl3oTk7@tycho.pizza>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Thu, 11 Dec 2025 00:18:28 +0100
X-Gm-Features: AQt7F2pl5QDGbtuzQBrS5_p5DiAZkm_mz9b61Sse-H0oqxy13fuVslJenmYMMjM
Message-ID: <CAEivzxe9aRMRK6Ujm17cy_rh3YPJdogvNizBnvKO0WQfQRaNaw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] seccomp: handle multiple listeners case
To: Tycho Andersen <tycho@kernel.org>
Cc: kees@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <shuah@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, Andrei Vagin <avagin@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 4:18=E2=80=AFPM Tycho Andersen <tycho@kernel.org> wr=
ote:
>
> On Wed, Dec 03, 2025 at 04:29:49PM +0100, Aleksandr Mikhalitsyn wrote:
> > On Tue, Dec 2, 2025 at 12:52=E2=80=AFPM Alexander Mikhalitsyn
> > <aleksandr.mikhalitsyn@canonical.com> wrote:
> > >
> > > If we have more than one listener in the tree and lower listener
> > > wants us to continue syscall (SECCOMP_USER_NOTIF_FLAG_CONTINUE)
> > > we must consult with upper listeners first, otherwise it is a
> > > clear seccomp restrictions bypass scenario.
> > >
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: bpf@vger.kernel.org
> > > Cc: Kees Cook <kees@kernel.org>
> > > Cc: Andy Lutomirski <luto@amacapital.net>
> > > Cc: Will Drewry <wad@chromium.org>
> > > Cc: Jonathan Corbet <corbet@lwn.net>
> > > Cc: Shuah Khan <shuah@kernel.org>
> > > Cc: Aleksa Sarai <cyphar@cyphar.com>
> > > Cc: Tycho Andersen <tycho@tycho.pizza>
> > > Cc: Andrei Vagin <avagin@gmail.com>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: St=C3=A9phane Graber <stgraber@stgraber.org>
> > > Reviewed-by: Tycho Andersen (AMD) <tycho@kernel.org>
> > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical=
.com>
> > > ---
> > >  kernel/seccomp.c | 33 +++++++++++++++++++++++++++++++--
> > >  1 file changed, 31 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > > index ded3f6a6430b..262390451ff1 100644
> > > --- a/kernel/seccomp.c
> > > +++ b/kernel/seccomp.c
> > > @@ -448,8 +448,21 @@ static u32 seccomp_run_filters(const struct secc=
omp_data *sd,
> > >
> > >                 if (ACTION_ONLY(cur_ret) < ACTION_ONLY(ret)) {
> > >                         ret =3D cur_ret;
> > > +                       /*
> > > +                        * No matter what we had before in matches->f=
ilters[],
> > > +                        * we need to overwrite it, because current a=
ction is more
> > > +                        * restrictive than any previous one.
> > > +                        */
> > >                         matches->n =3D 1;
> > >                         matches->filters[0] =3D f;
> > > +               } else if ((ACTION_ONLY(cur_ret) =3D=3D ACTION_ONLY(r=
et)) &&
> > > +                           ACTION_ONLY(cur_ret) =3D=3D SECCOMP_RET_U=
SER_NOTIF) {
> >
> > My bad. We also have to check f->notif in there like that:
>

Hi Tycho,

sorry for the delay with a reply.

> For my own education: why is that? Shouldn't
> seccomp_do_user_notification() be smart enough to catch this case (and
> indeed, there is a TOCTOU if you do it here?)?

seccomp_do_user_notification() is smart enough to handle the case when
a listener file descriptor was closed,
but a tricky part here is that SECCOMP_RET_USER_NOTIF can be (legally)
returned by the seccomp filter
program even when there was no listener at all.

Then, as nothing prevents you from loading a program like:
    BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_USER_NOTIF)
with
     seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog) // << no
SECCOMP_FILTER_FLAG_NEW_LISTENER flag

we can easily do OOB write in matches->filters[] array, because our
limitation with 8 elements only works for those who
set the SECCOMP_FILTER_FLAG_NEW_LISTENER flag.

Actually, I decided to get rid of this array in the next version of patchse=
t.

Hope to virtually meet you at LPC soon! ;)

Kind regards,
Alex

>
> Thanks,
>
> Tycho

