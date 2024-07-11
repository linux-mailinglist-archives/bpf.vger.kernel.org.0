Return-Path: <bpf+bounces-34503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC2992DEAA
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 04:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D27D282533
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 02:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB417DDCB;
	Thu, 11 Jul 2024 02:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrVON57B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45798F72
	for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 02:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720666600; cv=none; b=i3r8PDv3PYYSniZo0enkWvaRbIrFIdY3mYn32/7xk8pyqEX2TGiYet1wv/WKjfgTF+yh/k8ifx2cUB1ZPGs8ed7DKdDSduiQyDeErXMOr8XzZgmFAuNXmcSqThb/36T6V6n2R2Bb1iZhN9evd3G3GXT3a8w63+ThmOnk/6tWEPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720666600; c=relaxed/simple;
	bh=WPltMIiS0KcqAS3WhCv68GSkv5gh+F2GD0K+F9G38go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UiRK13A4GqwUpJAcw8nqM/avsr2W5MQaY9/4B9ChMp7oVlryR6aTN+tDSt2dWCC24FH9h4hX0JjGFtbRwEcclS0d+2KZ1yj3VvaVa0TNCPXBx/u0LcsqlaZiUwwQKliExR078RKS+77VuegXAs6oIxbtqHHM/xkzicK0K+wlQcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrVON57B; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-52e99060b41so417970e87.2
        for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 19:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720666597; x=1721271397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LCSVOOnLvF0tOedklZJygEwJjDIKzKUH91fTsGNL80=;
        b=CrVON57BvQdCJbXTL+a0gXv9oesCm7isrQrnwevI2g4Maj3MWmc2MYawcGEnOuiBeF
         g3rhthWCAvsZumHb+4AQpfFF36UCvmU7et9NEe7f7Z6GBjTBqrkB6s8NRwgcx07u044W
         uxcoU55P4ghsUDmA67T+4ampikyfT+hZax3aicGxSprPNB7u92ZDSvsjQb5kyzIpMU/l
         mDbepI2iUZO+3KR7BlJO6/NPS1+WP12PJiuObNr1dDeFx1Ntb8YLnETN9tjkrmVo9a3n
         jy0HIdTizQjmWye1kHwGbi84RQ/aX2e7T3Ya1pD3JrHPHwPrlzGP3yXwRV74FnIbXF1a
         n8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720666597; x=1721271397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LCSVOOnLvF0tOedklZJygEwJjDIKzKUH91fTsGNL80=;
        b=Xm/3+kJmamUMOYkR3iFIJ73EorFt48IUiwPbeGLV5m11QvK+Xgtz/Y1N2dobNQ/t7d
         4BaoQSpPXi6dFNdYBBArzVczhuMatpkUqAhfLMIiJNd1VfcZxvf4GEDLd2Ztxhfc46Y4
         rE88i929oTiJWfj79oI/cSzUctBbZB4rlR1sAQOpdcxEigsvcphYrMkEkUpXLXtQjqfa
         TPNCkoTXIEmLx4tRK6Ncic8SmkjjWTEqMIx51bLkkuCUzQKzrINl729RNXC43E2HzUZX
         nlu3aLWVJN5nExTfiMNcDKH40kJpLA1AkJ3jAAzNZr6zGuxxKNktElDfxgQ9fDT7haLr
         i1cA==
X-Gm-Message-State: AOJu0Yx8W04+2C9+NNlDAlM5Nkcbebn4J8sYGz3o94nRyS9Wcf4us3LQ
	X23NEjScPYJPVzi51dDv586Y3kSnqcujF6BJUDUzbmlBUnuZX9iAxDdcjr9I+UfPYMA6lbBXw8O
	G4bJUiLoamcLnZaL5NroN+TPvi7Q=
X-Google-Smtp-Source: AGHT+IH4go49aX54MFbyaLkFTlF1bHz+YnJPG48CsFlTp01tJBaogLrMYC2gz8pUuZmiHD9orvORCdZKztjpzcVDuFI=
X-Received: by 2002:ac2:5bc7:0:b0:52e:a64c:33dd with SMTP id
 2adb3069b0e04-52eb99da2a0mr3395670e87.69.1720666596608; Wed, 10 Jul 2024
 19:56:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709185440.1104957-1-memxor@gmail.com> <20240709185440.1104957-4-memxor@gmail.com>
 <CAP01T77vmSEZ=cgb499s1jP1Usjdz6yR2C2W9jXDOMi9arg7Hg@mail.gmail.com> <CAADnVQ+yJn_mtT+ZdiJEY3H=LYdV4TdTG+zzUDC89FU=Ly7hGQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+yJn_mtT+ZdiJEY3H=LYdV4TdTG+zzUDC89FU=Ly7hGQ@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 11 Jul 2024 04:56:00 +0200
Message-ID: <CAP01T77w3RCLWbFCTKUTOgg_JJs1imD5pFF60bhcHEqVnqZmUw@mail.gmail.com>
Subject: Re: [PATCH bpf v1 3/3] selftests/bpf: Add timer lockup selftest
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Dohyun Kim <dohyunkim@google.com>, 
	Neel Natu <neelnatu@google.com>, Barret Rhoden <brho@google.com>, Tejun Heo <htejun@gmail.com>, 
	David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Jul 2024 at 01:28, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Jul 9, 2024 at 2:07=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gm=
ail.com> wrote:
> > > +       while (!*timer1_err && !*timer2_err)
> > > +               bpf_prog_test_run_opts(prog_fd, &opts);
> > > +
> > > +       return NULL;
> > > +}
> > > +
> > > +void test_timer_lockup(void)
> > > +{
> > > +       struct timer_lockup *skel;
> > > +       pthread_t thrds[2];
> > > +       void *ret;
> > > +
> > > +       skel =3D timer_lockup__open_and_load();
> > > +       if (!ASSERT_OK_PTR(skel, "timer_lockup__open_and_load"))
> > > +               return;
> > > +
> > > +       int timer1_prog =3D bpf_program__fd(skel->progs.timer1_prog);
> > > +       int timer2_prog =3D bpf_program__fd(skel->progs.timer2_prog);
>
> Pls don't declare inline. Some compiler might warn.
>

ack.

> > > +
> > > +       timer1_err =3D &skel->bss->timer1_err;
> > > +       timer2_err =3D &skel->bss->timer2_err;
> > > +
> > > +       if (!ASSERT_OK(pthread_create(&thrds[0], NULL, timer_lockup_t=
hread, &timer1_prog), "pthread_create thread1"))
>
> pls shorten the line.
>

ack.

> > > +               return;
> > > +       if (!ASSERT_OK(pthread_create(&thrds[1], NULL, timer_lockup_t=
hread, &timer2_prog), "pthread_create thread2")) {
> > > +               pthread_exit(&thrds[0]);
> > > +               return;
> >
> > A goto out: timer_lockup___destroy(skel) is missing here and above
> > this. Will wait for a day or so before respinning.
>
> I was thinking to fix all these up while applying.
> So I fixed it, but then noticed that the new test is quite flaky.
> It seems it can get stuck in that while() loop forever.
> Pls investigate.
>

Will do.

> So I applied the first two patches only.
>
> Also pls fix:
> +static int timer_cb2(void *map, int *k, struct bpf_timer *timer)
> +{
> +       int key =3D 0;
> +
> +       timer =3D bpf_map_lookup_elem(&timer1_map, &key);
>
> 1. no need to do a lookup.
> 2. the 3rd arg is not a bpf_timer. It's a pointer to map value.
> So use
> timer_cb2(void *map, int *k, struct elem *v)
> then cast it to bpf_timer and use it w/o lookup.

2 makes sense, will fix. Lookup is still needed. We need the timer
from timer1_map, while the callback gets timer of timer2_map.

