Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7376E42B023
	for <lists+bpf@lfdr.de>; Wed, 13 Oct 2021 01:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbhJLX2O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Oct 2021 19:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235947AbhJLX2F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Oct 2021 19:28:05 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846ACC061746
        for <bpf@vger.kernel.org>; Tue, 12 Oct 2021 16:26:03 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id d3so2465002edp.3
        for <bpf@vger.kernel.org>; Tue, 12 Oct 2021 16:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JmjecroCDznoRWvi5I4eApXaxei+ev67/IoxokvgyWs=;
        b=S40ty1fuBKRGDJTvHf5OjZpyDgRjMel9pmNdivR6WxwqLtLPV1oJUjyph+Sc9P1/yK
         1u8AomdbLb6qUtKlhbA3TxSaGpZP0gqHWLLzt92dxsqBrNx5XD1r7WAEGdOa2Uutf0BA
         EBxTmJh8qq4Zj3TuaOxPePZw2Wq3trOJ1EdG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JmjecroCDznoRWvi5I4eApXaxei+ev67/IoxokvgyWs=;
        b=kZZjYICwChSJnnav62McdX5HtEgayJsxeyQxy9tczW0kHe/tyaAxr/HqUEdPPW5DoL
         fwDjiVY4r1VHX+n/teZSHgR+HirPzmtyJcTr0Qbs/LEo9q6ARoVis6RZA08KrN/OHvNY
         UxSe/cM82qOlerYGcmf9Xm8AsqNw3CIutx1mQXbl+oQIdBrtmBXOO3VOpw/p33WqGZFX
         ndocUz48rFlcxSNROg0Envp0laVfqbcuDygAmnGw1ns6cN0xRjfOHl4ykZqKzl24mTSR
         6jUjY2YV3PJ43cIJC6EormxHgKsj8AxusOGkkjjosmwV+W/JGjS/c5V/Sn/tKVwHqEeV
         BzIw==
X-Gm-Message-State: AOAM531rVNipa8yRAkIGVMjX2moEIvTNiIimtRBpJsWNjaIYJRB+qRhg
        IKQzdli0EoZ7EBtHT1B0f1Au7INr7oiHmO4+K0THXAz24H5GYUtskDY=
X-Google-Smtp-Source: ABdhPJx6YMn0NxsKdyVtQtD+uw0fWgrc4ygjduEv6BqcynOGePq601psBQnydxROdAgCl3HFs+gEHp2ycr5WKEnAPNM=
X-Received: by 2002:a50:e145:: with SMTP id i5mr4188046edl.16.1634081162079;
 Tue, 12 Oct 2021 16:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211006222103.3631981-1-joannekoong@fb.com> <20211006222103.3631981-2-joannekoong@fb.com>
 <87k0ioncgz.fsf@toke.dk> <4536decc-5366-dc07-4923-32f2db948d85@fb.com>
 <87o87zji2a.fsf@toke.dk> <CAEf4BzbqQRzTgPmK3EM0wWw5XrgnenqhhBJdudFjwxLrfPJF8g@mail.gmail.com>
 <87czoejqcv.fsf@toke.dk> <CAEf4BzbWVCz6RNKHVgqLYx8UqGUdDqL5EPKyuQ5YTXZMxt2r_Q@mail.gmail.com>
 <877deiif3q.fsf@toke.dk> <38d80c55-97e1-4cbb-cb23-d6331d8f539b@fb.com>
In-Reply-To: <38d80c55-97e1-4cbb-cb23-d6331d8f539b@fb.com>
From:   Zvi Effron <zeffron@riotgames.com>
Date:   Tue, 12 Oct 2021 16:25:50 -0700
Message-ID: <CAC1LvL3DxGWtk1vx3o=1XOj=M0m+KF3yT9z=gONWFXgnc_voiA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/5] bpf: Add bitset map with bloom filter capabilities
To:     Joanne Koong <joannekoong@fb.com>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 12, 2021 at 3:47 PM Joanne Koong <joannekoong@fb.com> wrote:
>
> On 10/12/21 5:48 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>
> > Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
> >
> >>> The 'find first set' operation is a single instruction on common
> >>> architectures, so it's an efficient way of finding the first non-empt=
y
> >>> bucket if you index them in a bitmap; sch_qfq uses this, for instance=
.
> >> There is also extremely useful popcnt() instruction, would be great to
> >> have that as well. There is also fls() (find largest set bit), it is
> >> used extensively throughout the kernel. If we'd like to take this ad
> >> absurdum, there are a lot of useful operations defined in
> >> include/linux/bitops.h and include/linux/bitmap.h, I'm pretty sure one
> >> can come up with a use case for every one of those.
> >>
> >> The question is whether we should bloat the kernel with such
> >> helpers/operations?
> > I agree, all of those are interesting bitwise operations that would be
> > useful to expose to BPF. But if we're not going to "bloat the kernel"
> > with them, what should we do? Introduce new BPF instructions?
> >
> >> I'd love to hear specific arguments in favor of dedicated BITSET,
> >> though.
> > Mainly the above; given the right instructions, I totally buy your
> > assertion that one can build a bitmap using regular BPF arrays...
> >
> > -Toke
> I have the same opinion as Toke here - the most compelling reason I
> see for the bitset map to be supported by the kernel is so we can
> support a wider set of bit operations that wouldn't be available
> strictly through bpf.
>

Do we need a new map type to support those extra bit operations?
If we're not implementing them as helpers (or instructions), then I don't s=
ee
how the new map type helps bring those operations to eBPF.

If we are implementing them as helpers, do we need a new map type to do tha=
t?
Can't we make helpers that operate on data instead of a map?

A map feels like a pretty heavy-weight way to expose these operations to me=
. It
requires user-space to create the map just so eBPF programs can use the
operations. This feels, to me, like it mixes the "persistent storage"
capability of maps with the bit operations goal being discussed. Making hel=
pers
that operate on data would allow persistent storage in a map if that's wher=
e
the data lives, but also using the operations on non-persistent data if
desired.

--Zvi

> I'm also open to adding the bloom filter map and then in the
> future, if/when there is a need for the bitset map, adding that as a
> separate map. In that case, we could have the bitset map take in
> both key and value where key =3D the bitset index and value =3D 0 or 1.
