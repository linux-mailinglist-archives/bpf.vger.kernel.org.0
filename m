Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0079743AC65
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 08:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbhJZGtm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 02:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbhJZGtm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Oct 2021 02:49:42 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6534C061745
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 23:47:18 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id n11-20020a17090a2bcb00b001a1e7a0a6a6so1451527pje.0
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 23:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gnIVLsJyA0yzh89IATRCGC19WIcHSUuElFLSRXaUsWY=;
        b=JdgmMfaZF6cbfcbI3yPHWo40euLqnXZ9lnu3Xb7vyVcBJZDIjAGsTHE6Mt/BPKvhv8
         ZzRgQ6CDDpMVYZLNW7hK4cd1w985XlO4EWwV+nnYuuFrGXc2cCX8U2QRHee7mg001aUc
         bNaoYeACHD7dZjF3lO8/lV+wb40aB8+iaVr/wYTh66q4Hmb5yR8k8hscvgoWaeu6+c/C
         yJMoSwr8vozv3SuDZjPX1RngRJeTEaC4uzqMJRlgPThoFDn1sjHdydtU1PtAMQ4uplcm
         f3nOJuU9bKBS60dSXKMeA97D+s7zpxKA37ZXJbjGetR/5185+Hwx9vnI8Zr3RAJOawWe
         L7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gnIVLsJyA0yzh89IATRCGC19WIcHSUuElFLSRXaUsWY=;
        b=1y1jN8s9hv4kQQzhN0bAH7dlaNTdV7/+TvII/9H+z/fuQYV11+xEe/hku/d1NWU66K
         VZNvAESqVpJR8AGmWKQxyKkdWau9skmV8LkKc7JTnTvbArpfSwzzZdzrl/nRDA4kTuDk
         q6RngCiGCCnHAja5M/XxMOuKmQHgaOuSBB/lX8KX/xYawc7CtbVfcGrUcTxmm7G9FRz9
         USujyG/TIpmquw+ei4Yj4soCJgR44o+d7vM0iHeLqX+GHwVPA9nUKoJfXA7eDhoxK07T
         qNm6Dem/gOl0WR5BRjhsjf8p3AABuNvAkuGwHLbKiVQgqkQLqDthjulQ1pxGwGsRikJE
         a+dw==
X-Gm-Message-State: AOAM532cp1vvPlxAHHrQOr4V2ix7p3Y8+wWgWLaUig7uvRTiypQKYAjf
        IYQdI2UeWfV4vpW5EgUjbnOffv3/XN0g/8qhcC8=
X-Google-Smtp-Source: ABdhPJy+nipSjE2qe6nk7ZBwFrYRFBdStjUsecRx5RT5gMM8XWyToJX+mLIvmE4zErcUqIiu3k2qu51gKrg9EvZlb/s=
X-Received: by 2002:a17:902:c410:b0:13e:cfac:45ad with SMTP id
 k16-20020a170902c41000b0013ecfac45admr21021072plk.68.1635230838201; Mon, 25
 Oct 2021 23:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4BzZ5Uajg5548=vpq8O2L5VLrONmr8h2O-6X6H0urMDXEqA@mail.gmail.com>
 <CAJ8uoz35Xqx1YCnxB0wCd-58_u9fdzEy5xS45Jcs82gXiAnK1Q@mail.gmail.com>
 <87v91lay7o.fsf@toke.dk> <CAEf4BzZoajVwGywDipuAk7ojY9WjL2rvuk82EtCZKGU-JSZUow@mail.gmail.com>
In-Reply-To: <CAEf4BzZoajVwGywDipuAk7ojY9WjL2rvuk82EtCZKGU-JSZUow@mail.gmail.com>
From:   Magnus Karlsson <magnus.karlsson@gmail.com>
Date:   Tue, 26 Oct 2021 08:47:07 +0200
Message-ID: <CAJ8uoz1GP4M71E-PNScndfeTbcCG2OUg+wcoO4ZaJF5UTBiXCQ@mail.gmail.com>
Subject: Re: libxsk move from libbpf to libxdp
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 26, 2021 at 6:18 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Oct 25, 2021 at 9:03 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
> >
> > Magnus Karlsson <magnus.karlsson@gmail.com> writes:
> >
> > > On Fri, Oct 22, 2021 at 7:49 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > >>
> > >> Hey guys,
> > >>
> > >> It's been a while since we chatted about libxsk move. I believe last
> > >> time we were already almost ready to recommend libxdp for this, but
> > >> I'd like to double-check. Can one of you please own [0], validate th=
at
> > >> whatever APIs are provided by libxdp are equivalent to what libbpf
> > >> provides, and start marking xdk.h APIs as deprecated? Thanks!
> > >
> > > Resending since Gmail had jumped out of plain text mode again.
> > >
> > > No problem, I will own this. I will verify the APIs are the same then
> > > submit a patch marking the ones in libbpf's xsk.h as deprecated.
> > >
> > > One question is what to do with the samples and the selftests for xsk=
.
> > > They currently rely on libbpf's xsk support. Two options that I see:
> > >
> > > 1: Require libxdp on the system. Do not try to compile the xsk sample=
s
> > > and selftests if libxdp is not available so the rest of the bpf
> > > samples and selftests are not impacted.
> > > 2: Provide a standalone mock-up file of xsk.c and xsk.h that samples
> > > and selftests could use.
> > >
> > > I prefer #1 as it is better for the long-term. #2 means I would have
> > > to maintain that mock-up file as libxdp features are added. Sounds
> > > like double the amount of work to me. Thoughts?
> >
> > I agree #1 is preferable of those two. Another option is to move the
> > samples to the xdp-tools repo instead? Doesn't work for selftests, of
> > course; if it's acceptable to conditionally-compile the XSK tests
> > depending on system library availability that would be fine by me...
>
> Seems like the only thing that uses xsk.h is xdpxceiver.c which is
> tested through test_xsk.sh. It's not part of test_progs and so isn't
> run regularly by BPF CI or maintainers. It makes sense to me to move
> such test closer to the library it's supposed to be testing (i.e.,
> libxdp)?

xdpxceiver.c tests kernel functionality, not libxdp functionality,
though it does use libxdp (and libbpf) to make the implementation
simpler. So it should remain here and use strategy #1. libxdp tests
are on another level and should definitely go into the libxdp repo.
The xsk samples in samples/bpf/, we could just stop developing/retire
(or even remove) in the Linux repo and move them to the xdp-tools
repo. They just show how to use the xsk.h api:s and it makes more
sense to have them together with libxdp.

> >
> > I pinged the Debian maintainer of libbpf to see if I can get him to pic=
k
> > up libxdp as well, or sponsor me to maintain it. Should make the
> > transition smoother; guess I also need to get hold of the OpenSuse
> > people.
> >
> > -Toke
> >
