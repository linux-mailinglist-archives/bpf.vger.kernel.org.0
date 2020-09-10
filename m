Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCE7264366
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 12:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730526AbgIJKLh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 06:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgIJKLM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Sep 2020 06:11:12 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D18C061756
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 03:11:11 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id l4so5137045ilq.2
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 03:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dYn711/ecEMa9YkRKRtL12MOp1Pmr/gkc97vbP51zKs=;
        b=0pUmmi0kKFjMFtMFkm81POxlGd8OLWHIbb357w8LJEutcKtX2TJY2D84oFNqpaKkWj
         LIZu8CjdTYcnK+j9/EGSdH0gxwP/ueYIs5FPFgQm8Sq5hOBWafg1XHeunzk02ZZTN1/H
         xt5iPuSprTSuTlJuVcu1Re0MnUq1SMx7pPtpkIWKnsmYIq4PxcC1cTC+6p0E/2V01yBf
         cWoyykLWj+7Ek7CEAl91yA2xB87BligfWuoTeEfAQH8Nch1eYqHbu9XDDVUcsYJQZx6/
         PwzbWib+tGdPfZZohCcvXg4rknkfDVdQV3v7niGO6T+6FQhL0/4txIB+K4vNxyvLL0Ps
         3wgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dYn711/ecEMa9YkRKRtL12MOp1Pmr/gkc97vbP51zKs=;
        b=LqsPBiAHRoHT5XNcUOSVCwH5wQenxLwc2CiEww8buFL9rTD5CgygfR4gcDB51eR4y7
         SlN4cPFjDwQvDKvgpIhE0bvTqDEUX3urn5B9LTrjhhxZenpphjpse3e2mRhiMr/PgWZh
         JAAosHbLPnFvaPeaJA3hkEiqH2g/b8FIqMtGRnyHHe7PYdnBdzBfv42KAF3yJstUyOKX
         vqJ/iew9zpfMyUSvv7O3InsKaXHHiTdn54sYpXd4ZD8Into4nGGO3Oy8uHLM+Cp2xqL8
         ekJI+V6hZQWmM64bc0ZVuhwmtdgnONREq0Pmi/+uxPB6IntPYtMjFuVnIQgqmojdwbTU
         DFxw==
X-Gm-Message-State: AOAM533Yu1ngmhsoXyxonmTggVXq+UlScjsdIeXvRT0zXLCQSGRjkCEN
        wxauVZOni+Z33LjfM775iFAlIpp1WWUYX3nahk4YFw==
X-Google-Smtp-Source: ABdhPJxsUK2w96KVp27uVBQuyvQ3vG3xd0ASnK210PCB3wzoJVXqDsJLG6KiuIhl1SK9e7YXDDkcbt+3siRcpE26a30=
X-Received: by 2002:a92:ba45:: with SMTP id o66mr7609998ili.38.1599732670989;
 Thu, 10 Sep 2020 03:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAGeTCaU1fEGVVWnXKR_zv4ZSoCrBGSN65-RpFuKg9Gf-_z6TOw@mail.gmail.com>
 <CAADnVQKsbbd9dbPYQqa5=QsRfLo07hEjr1rSC=5DfVpzUK7Ajw@mail.gmail.com>
 <CAGeTCaWSSBJye72NCQW4N=XtsFx-rv-EEgTowTT3VEtus=pFtA@mail.gmail.com>
 <878sdlpv92.fsf@toke.dk> <CAGeTCaWDk_ok38Xm8H8-8HQYP-bbPqMuwWDpEYM=i1=e0e88bw@mail.gmail.com>
 <87mu1znt7q.fsf@toke.dk> <CAFLU3KteR+snvWpth3PBoQARTtpeBhEEVWH+a2bg0y=cxR81MQ@mail.gmail.com>
In-Reply-To: <CAFLU3KteR+snvWpth3PBoQARTtpeBhEEVWH+a2bg0y=cxR81MQ@mail.gmail.com>
From:   Borna Cafuk <borna.cafuk@sartura.hr>
Date:   Thu, 10 Sep 2020 12:11:00 +0200
Message-ID: <CAGeTCaXOT0Nq=6m39Xn7NNP+Bz+iOdH8tR8ZKQ3jMibmgMtxew@mail.gmail.com>
Subject: Re: HASH_OF_MAPS inner map allocation from BPF
To:     KP Singh <kpsingh@google.com>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Luka Perkov <luka.perkov@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 9, 2020 at 12:36 PM KP Singh <kpsingh@google.com> wrote:
>
> On Wed, Sep 9, 2020 at 12:24 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
> >
> > Borna Cafuk <borna.cafuk@sartura.hr> writes:
> >
> > > On Mon, Sep 7, 2020 at 3:33 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke=
@redhat.com> wrote:
> > >>
> > >> Borna Cafuk <borna.cafuk@sartura.hr> writes:
> > >>
> > >> > On Sat, Sep 5, 2020 at 12:47 AM Alexei Starovoitov
> > >> > <alexei.starovoitov@gmail.com> wrote:
>
> [...]
>
> > >> >
> > >> > The idea is to have an outer map where the keys are PIDs, and inne=
r maps where
> > >> > the keys are system call numbers. This would enable tracking the n=
umber of
> > >> > syscalls made by each process and the makeup of those calls for al=
l processes
> > >> > simultaneously.
> > >> >
> > >> > [1] https://github.com/iovisor/bcc/blob/master/libbpf-tools/syscou=
nt.bpf.c
> > >>
> > >> Well, if you just want to count, map-in-map seems a bit overkill? Yo=
u
> > >> could just do:
> > >>
> > >> struct {
> > >>   u32 pid;
> > >>   u32 syscall;
> > >> } map_key;
> > >>
> > >> and use that?
> > >>
> > >> -Toke
> > >>
> > >
> > > I have considered that, but maps in maps seem better for when I need =
to get the
> > > data about a single process's syscalls: It requires reading only one =
of the
> > > inner maps in its entirety. If I have a composite key like that, I do=
n't see
> > > any way, other than:
> > >  * either iterating through all the possible keys for a process
> > >    (i.e. over all syscalls) and looking them up in the map, or
> > >  * iterating over all entries in the map and filtering them.
> > >
> > > Looking at it again, the first option does not seem _that_ bad,
> >
> > You could even use BPF_MAP_LOOKUP_BATCH to do this in one operation, I
> > suppose...
> >
> > > but just iterating over one (inner) map would be easier to fit into
> > > our use-case.
> >
> > ...but yeah, I see what you mean. Well, maybe BPF local storage per
> > process would also be a nice fit here?

Thank you for the insight.

>
> Yes, task local storage does seem like a good fit and is the next one I w=
as
> thinking of implementing.
>
> - KP

I'm looking forward to the patches.

>
> >
> > -Toke
> >
