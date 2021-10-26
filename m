Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C971D43AB15
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 06:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhJZEUy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 00:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbhJZEUy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Oct 2021 00:20:54 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CA5C061745
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 21:18:31 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id i65so30731089ybb.2
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 21:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z1cr2Nj/dJS0nT5ueBzZC8dFPC2ShcEGzpjFdED6HoA=;
        b=mOo4OB181MEUY90C/iQhdypZhg0Ga6NokJ++Jsm7EVx3lrSRs/B90FbForNe0SR9UI
         uybY1TXL75V8YuGfmLPqArYFIH1PnmgO/FPBeOjcqHyNOcN5OysQbGPiZzCsZnxVtIc5
         Y1r59sW9jt2sHJSOTdble9iLXs5GtTL5bmVUuSfnCdZOoY2aCKostEiKu/QqU3fJJipC
         j4VcsxwWVFekUBkb9IsJvjFEfdVZu2hrm99haxiTw7i9k3FrgcVt5VL8QnPym3CcVySz
         hmmCFBakYfTdpSZPFV9HWKuX6IAUBsbUbIYRnH8JeuO3MjCZrmkuumNLXF4yjCAv1O/2
         il2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z1cr2Nj/dJS0nT5ueBzZC8dFPC2ShcEGzpjFdED6HoA=;
        b=MeowJY2s9LJjJTLNKtQl9HqyrbtzMlI2xTeVGzXnsV1fvNEi6tIqgIf/E5AgescWd2
         lGsoSLNjlZl2E9uP6ZfCr9+QL61Y6cLX5Tg8MPZvkmGy43QyIkze7cI9ak6HhUBuIA4s
         OS2VGV0lSr0H7fAG7jIrE5sFhxIkrF0NeP0geOvBQaQpKjUQ22xCivJrdnKoiMj27kW4
         8kWQ+iWVx0BvD9HTvIZ4slRYbL8l4DWIU9rSHaF35U9KyvVSdtQKpDEMFFbsfhnT1nQ8
         hykQTQa0wP8H57Na2feG1yYRH1O/gUyEpOEEnV6eunYFLaONY0gW7vTFcPg1mHeXtzuE
         EO9A==
X-Gm-Message-State: AOAM533r6PJpCBJuOKlMP5Zhy+52T/GNR8rEbY5yAI6ENF++POYZZmw+
        ZoI15gr9sYb9GNmimrsJbaf5e9CZReIdprKr2uUL1W7XYhLNjg==
X-Google-Smtp-Source: ABdhPJwmp8wnaJb2MOPWly/Kb6pSexF4AaKcoYNEAEV+QCIkAY1+Ba8355oQSR7ojnRlLED+S1rxDZj1X49PCraHxak=
X-Received: by 2002:a25:8749:: with SMTP id e9mr20972358ybn.2.1635221910420;
 Mon, 25 Oct 2021 21:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4BzZ5Uajg5548=vpq8O2L5VLrONmr8h2O-6X6H0urMDXEqA@mail.gmail.com>
 <CAJ8uoz35Xqx1YCnxB0wCd-58_u9fdzEy5xS45Jcs82gXiAnK1Q@mail.gmail.com> <87v91lay7o.fsf@toke.dk>
In-Reply-To: <87v91lay7o.fsf@toke.dk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 25 Oct 2021 21:18:19 -0700
Message-ID: <CAEf4BzZoajVwGywDipuAk7ojY9WjL2rvuk82EtCZKGU-JSZUow@mail.gmail.com>
Subject: Re: libxsk move from libbpf to libxdp
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Magnus Karlsson <magnus.karlsson@gmail.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 25, 2021 at 9:03 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Magnus Karlsson <magnus.karlsson@gmail.com> writes:
>
> > On Fri, Oct 22, 2021 at 7:49 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >>
> >> Hey guys,
> >>
> >> It's been a while since we chatted about libxsk move. I believe last
> >> time we were already almost ready to recommend libxdp for this, but
> >> I'd like to double-check. Can one of you please own [0], validate that
> >> whatever APIs are provided by libxdp are equivalent to what libbpf
> >> provides, and start marking xdk.h APIs as deprecated? Thanks!
> >
> > Resending since Gmail had jumped out of plain text mode again.
> >
> > No problem, I will own this. I will verify the APIs are the same then
> > submit a patch marking the ones in libbpf's xsk.h as deprecated.
> >
> > One question is what to do with the samples and the selftests for xsk.
> > They currently rely on libbpf's xsk support. Two options that I see:
> >
> > 1: Require libxdp on the system. Do not try to compile the xsk samples
> > and selftests if libxdp is not available so the rest of the bpf
> > samples and selftests are not impacted.
> > 2: Provide a standalone mock-up file of xsk.c and xsk.h that samples
> > and selftests could use.
> >
> > I prefer #1 as it is better for the long-term. #2 means I would have
> > to maintain that mock-up file as libxdp features are added. Sounds
> > like double the amount of work to me. Thoughts?
>
> I agree #1 is preferable of those two. Another option is to move the
> samples to the xdp-tools repo instead? Doesn't work for selftests, of
> course; if it's acceptable to conditionally-compile the XSK tests
> depending on system library availability that would be fine by me...

Seems like the only thing that uses xsk.h is xdpxceiver.c which is
tested through test_xsk.sh. It's not part of test_progs and so isn't
run regularly by BPF CI or maintainers. It makes sense to me to move
such test closer to the library it's supposed to be testing (i.e.,
libxdp)?

>
> I pinged the Debian maintainer of libbpf to see if I can get him to pick
> up libxdp as well, or sponsor me to maintain it. Should make the
> transition smoother; guess I also need to get hold of the OpenSuse
> people.
>
> -Toke
>
