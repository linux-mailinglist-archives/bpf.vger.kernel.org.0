Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E388F3170E0
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 21:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbhBJUFH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Feb 2021 15:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhBJUFG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Feb 2021 15:05:06 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9799DC061574
        for <bpf@vger.kernel.org>; Wed, 10 Feb 2021 12:04:25 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id m188so2725976yba.13
        for <bpf@vger.kernel.org>; Wed, 10 Feb 2021 12:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TDWnbrleUQS+wR5aLHELhNJGINUQVHkwoOgbN/FROfw=;
        b=I6t6LcJdIE9jSIovjvjAaFu/5mZqdPNpfmWdYBGFrMQAKvGz04UBk7MG0zKE48Ic+c
         GYkO0k99HTBuRS4CrF9g2pVtZr45alFvbOrDyZLKFBeqKRGCzNwiX1XuB988x9jZNa0e
         JGLorsFQj2LU7dpyZOGGX8IF5XzaxSrhPaTxhslDslHrK5k3u4T0wzWHnyRkMsB/PUDd
         c7V/I3I2dFdSCJeLPNQDSkUsQVKJsKett+OKGai4KX+Oony0omO2bJK5STcGwlwdzVZj
         TeMKzpBhS7T4aiURuMdEd2iD12PJtC3a1mUIt92GdfURLc3NWAqwEcVwl4MsiG8aue6g
         Ls3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TDWnbrleUQS+wR5aLHELhNJGINUQVHkwoOgbN/FROfw=;
        b=uaVIZ4TDVhEBajhUP6QjqggGT9BBvlX0jjNQRzu8dJCs2/0S+FUnTvvHjDGydPi4DC
         YQ5EfzmBuALIt4RTfPhPQC66WH6fxHnYYGQyKffZdTNY66eWFKJsvbNjXb0asjU/JgN6
         QKJwMKVPKJRGO22Bzc5clULaMPVfn9093wjbCoLaOyTY+54ALPXxoWUf5+W8oviguT3D
         RlTPjJHIBN2zRF839t2olIYELyVgvHq6qrNPYaJOMcAz1gMIoKtGu4HJqSViOKQYLKHX
         fDTCi5F97MO0jvKInVQh1C+hdyVH+46nmq49HYdHttbYUpMgprtj28t7R12MHqb5sgWv
         hQ+g==
X-Gm-Message-State: AOAM531QKNi39Zo7N+AAMCcmhlnPUM4FgT9tBrLuuIv9I0LoSgdFm8Y1
        dgWxunrq/IY0uFLYWlSzJjxlR+4MspUgU1z4VNU=
X-Google-Smtp-Source: ABdhPJwAmnEAuYN0rYmx+qN+svVMgbbGWQUZ7V6Mnyjq3BOq0ZWTMxCbyK206KLhqblWdzimddfBHSvzb4Xbey6bItc=
X-Received: by 2002:a25:f40e:: with SMTP id q14mr6271176ybd.230.1612987464944;
 Wed, 10 Feb 2021 12:04:24 -0800 (PST)
MIME-Version: 1.0
References: <CANaYP3G4zZu=d2Y_d+=418f6X9+5b-JFhk0h9VZoQmFFLhu3Ag@mail.gmail.com>
 <CANaYP3GgBDPBUjrkg0j-NOEzf3WJEOqcqoGU0uVxQ3LsAzz8ow@mail.gmail.com>
 <87v9b2u6pa.fsf@toke.dk> <CANaYP3GxKrjuUUTGaAjYGqwPCNzPJBNPQGMMCNaoHT4rfsYUfA@mail.gmail.com>
 <87mtwetz04.fsf@toke.dk> <CANaYP3G4sBrBy3Xsrku4LjW4sFhAb-9HreZUo_aBNe6gCab1Eg@mail.gmail.com>
 <87blcutx3v.fsf@toke.dk> <CANaYP3FEheoxSp86sFair0CAQz1-fkdmGp0_zvgGqQr_3P+qdg@mail.gmail.com>
 <875z32tpel.fsf@toke.dk> <CANaYP3EUOLf=8+ZuKFr4ozPueqgjvzxkEK+O8WEamwY01yATaA@mail.gmail.com>
 <87zh0es73x.fsf@toke.dk> <CANaYP3G+rtJuMAaTvdxSZCEtA9tSqh00OCkJ0LoeL7L030w0VQ@mail.gmail.com>
 <87tuqlsdtu.fsf@toke.dk>
In-Reply-To: <87tuqlsdtu.fsf@toke.dk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 10 Feb 2021 12:04:14 -0800
Message-ID: <CAEf4BzaUkcnVaGJkMxuc+atqUimxJJQOrZHDkK1Yprysy79hyg@mail.gmail.com>
Subject: Re: libbpf: pinning multiple progs from the same section
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Gilad Reti <gilad.reti@gmail.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 9, 2021 at 3:03 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redha=
t.com> wrote:
>
> Gilad Reti <gilad.reti@gmail.com> writes:
>
> >> > I didn't get this last comment. What I meant is that I want somethin=
g
> >> > like the bpf_object__pin_maps but that doesn't pin the maps, just
> >> > exposing its naming part.
> >>
> >> Right, OK. Why, though? I can kinda see how it could be convenient to
> >> (basically )make libbpf behave as if all maps has the 'pinning'
> >> attribute set, for map reuse. But I'm not sure I can think any concret=
e
> >> use cases where this would be needed. What's yours?
> >>
> >
> > I am using the same bpf objects (more specifically, the new skeleton
> > feature) in two different processes that need access to the same
> > maps/programs (for example, they both need access to shared maps).
> > Thus, I want to reuse the entire object in both. Since we already have
> > a way to pin an entire bpf object, I thought it would be convenient to
> > have a way of reusing it entirely (though I am fine with pinning and
> > reusing each one manually).
> > (I cannot set the __uint(pinning, LIBBPF_PIN_BY_NAME) on each since I
> > want to share the bss map too)
>
> Ah, see, now *this* could go under the "missing API" header: having a
> way to make libbpf pin (and reuse) the auto-generated maps, like you can
> do with the 'pinning' attribute.
>
> Andrii, WDYT?

I think that the whole pinning handling in libbpf feels a bit ad-hoc.
It would be good for someone to sit and think through this end-to-end.
Unfortunately I never had a need for pinning, so I'm not the best
person to do this.

In this case, you can still do bpf_map__set_pin_path() on internal
maps (.bss, .data, etc), but you'll need to specify pin path
explicitly, which is different from what you get with
LIBBPF_PIN_BY_NAME.

So I think pinning support is not complete, but I'd also like to avoid
adding new APIs in an ad-hoc manner without a holistic view of how
pinning should work with libbpf.

>
> -Toke
>
