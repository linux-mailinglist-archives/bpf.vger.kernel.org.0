Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74809262C81
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 11:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgIIJuJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 05:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgIIJuH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 05:50:07 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D57C061573
        for <bpf@vger.kernel.org>; Wed,  9 Sep 2020 02:50:07 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t13so1705165ile.9
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2020 02:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AByC7SM7WYk081vXb3/jRTzygXFUSdG9LyGSgV6OFXc=;
        b=ZbkxlP9QHmsI1edfuDb+WHvkeEjjbYDZb/UwnXPO2O7tuye86SKjQCdC+sjuGIBH/c
         7hNQr8Giev/UpygR2Krjp0KI4zOFgNeCnp85dRbHh0tY1HyN3Y7FRtyGLaHRrU0bheOJ
         gneGoJNGjXOQ6xbsSPlueXJSF32L+zLbzbkXIm21O7H2w3bAuOR8pQfkLI2eDZR8dDSL
         8bNGVIj6iKB3sTZ384lUhVW/hdeA+F5xiOapnqiqd2GPfiJ4d+z1wt8tA9IsIgNRLT9J
         r+UefVo/fajWKtICIVE6yiWr/4KPjkMIiTp6winBZ0GGduHpw0yRyqhF9RQxrjU6awP7
         EzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AByC7SM7WYk081vXb3/jRTzygXFUSdG9LyGSgV6OFXc=;
        b=q/sAZk28URqdunpRH7HAb2ev08yKb7J4/vbAvtdAxRKUDDDp6jLPReA2lrWr5K6etD
         ZbTfvDZsmiL/4kuWIST1+6rD71oJI6r7TKEUjcsTX0+vOJI+99S+hMbv6WaUgKQ7UYso
         ExYB3n+eiKf/oKbzlwhA/WffZN8PUsmDZNa7IennJg3cUFqTd8PjvjAVLbE+uWoWLRM1
         PJllXe4kCdWFPnx6AEznJnX4TU9rlvXGEp4T+ohRVBr7Pzg0Y3EQrarwn92SnqmBjGLn
         tmZFXPA92gBjnQ/911HykJtd7sP6VcyqgSc/g3FpMd0MvWo/f7Hp9VlFvR4s22YSsxCM
         pXvg==
X-Gm-Message-State: AOAM533YJX2F01YErVuHlFYBAXI0tVTkNDsbMXI6wv9CG1z38lk+khG+
        C8xS3xHUqW+fWnCEHyMW5z49T6EytewQocuE6k/qfg==
X-Google-Smtp-Source: ABdhPJx53jSVp4MJzAr921QvXzf9PYPAObbNkewW8nXbjteTChpLMZHgfVvcTXnLZae8IVwbuD/njzMK6ce+A2QWTlQ=
X-Received: by 2002:a92:c991:: with SMTP id y17mr2904121iln.148.1599645005983;
 Wed, 09 Sep 2020 02:50:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAGeTCaU1fEGVVWnXKR_zv4ZSoCrBGSN65-RpFuKg9Gf-_z6TOw@mail.gmail.com>
 <CAADnVQKsbbd9dbPYQqa5=QsRfLo07hEjr1rSC=5DfVpzUK7Ajw@mail.gmail.com>
 <CAGeTCaWSSBJye72NCQW4N=XtsFx-rv-EEgTowTT3VEtus=pFtA@mail.gmail.com> <878sdlpv92.fsf@toke.dk>
In-Reply-To: <878sdlpv92.fsf@toke.dk>
From:   Borna Cafuk <borna.cafuk@sartura.hr>
Date:   Wed, 9 Sep 2020 11:49:54 +0200
Message-ID: <CAGeTCaWDk_ok38Xm8H8-8HQYP-bbPqMuwWDpEYM=i1=e0e88bw@mail.gmail.com>
Subject: Re: HASH_OF_MAPS inner map allocation from BPF
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf@vger.kernel.org, Luka Perkov <luka.perkov@sartura.hr>,
        KP Singh <kpsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 7, 2020 at 3:33 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redha=
t.com> wrote:
>
> Borna Cafuk <borna.cafuk@sartura.hr> writes:
>
> > On Sat, Sep 5, 2020 at 12:47 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >>
> >> On Fri, Sep 4, 2020 at 7:57 AM Borna Cafuk <borna.cafuk@sartura.hr> wr=
ote:
> >> >
> >> > Hello everyone,
> >> >
> >> > Judging by [0], the inner maps in BPF_MAP_TYPE_HASH_OF_MAPS can only=
 be created
> >> > from the userspace. This seems quite limiting in regard to what can =
be done
> >> > with them.
> >> >
> >> > Are there any plans to allow for creating the inner maps from BPF pr=
ograms?
> >> >
> >> > [0] https://stackoverflow.com/a/63391528
> >>
> >> Did you ask that question or your use case is different?
> >> Creating a new map for map_in_map from bpf prog can be implemented.
> >> bpf_map_update_elem() is doing memory allocation for map elements.
> >> In such a case calling this helper on map_in_map can, in theory, creat=
e a new
> >> inner map and insert it into the outer map.
> >
> > No, it wasn't me who asked that question, but it seemed close enough to
> > my issue. My use case calls for modifying the syscount example from BCC=
[1].
> >
> > The idea is to have an outer map where the keys are PIDs, and inner map=
s where
> > the keys are system call numbers. This would enable tracking the number=
 of
> > syscalls made by each process and the makeup of those calls for all pro=
cesses
> > simultaneously.
> >
> > [1] https://github.com/iovisor/bcc/blob/master/libbpf-tools/syscount.bp=
f.c
>
> Well, if you just want to count, map-in-map seems a bit overkill? You
> could just do:
>
> struct {
>   u32 pid;
>   u32 syscall;
> } map_key;
>
> and use that?
>
> -Toke
>

I have considered that, but maps in maps seem better for when I need to get=
 the
data about a single process's syscalls: It requires reading only one of the
inner maps in its entirety. If I have a composite key like that, I don't se=
e
any way, other than:
 * either iterating through all the possible keys for a process
   (i.e. over all syscalls) and looking them up in the map, or
 * iterating over all entries in the map and filtering them.

Looking at it again, the first option does not seem _that_ bad, but just
iterating over one (inner) map would be easier to fit into our use-case.
