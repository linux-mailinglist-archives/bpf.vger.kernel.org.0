Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED492CEFAA
	for <lists+bpf@lfdr.de>; Fri,  4 Dec 2020 15:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgLDOYW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Dec 2020 09:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgLDOYV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Dec 2020 09:24:21 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CED8C0613D1
        for <bpf@vger.kernel.org>; Fri,  4 Dec 2020 06:23:36 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id y9so5373532ilb.0
        for <bpf@vger.kernel.org>; Fri, 04 Dec 2020 06:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VMuaY/klAlzzsF+BfOdEbTu97IO0k7yFn2W8ml70FV8=;
        b=PtEGDW6PbyPfsx9hpTkN+flgWMJ1f8cey7sE8G9TjuLLLvs4vHpobUYmuZOfZn2Oka
         V3EZ0E5q6nRnlQimhr8l60UjlBwfi4xXE/+GbnIpDGVd6Gque8Y7r4ESfEJqt6k/1fnA
         KfFC0Rt/K/9rzIJyV1BDurUq/H+KcgiHs8YzbTIpcqlS5JNkHMMxcpkXIwGVUlvkuEx2
         woo8onS4Uv09ucsphBESKeVkaHvGotJh51KJ9VnmYiOFQbAb2rJPLP7dm9CDmeG/FmrI
         sA2bk5FiEcClrmbC7DIq3+Lowvn5nNVXGkZ5NCSICUXNNdFf3ky9Fx64pjT6OooUkeBn
         hOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VMuaY/klAlzzsF+BfOdEbTu97IO0k7yFn2W8ml70FV8=;
        b=FbPhuGNGOTnUMJH4uIGOzFZaKLF9ekO+ldImBoaARSXr2Gxd8po62HFjd9wVQTx+zc
         fz7eqxGO7POrt/qToo9WyNI0aI9CfH58eNvkxUwp0gMLD76nqXTk8UKVyfogE9EiCU6q
         SvDeBc7aq2ij3XRYkUp3IpTvS6CfDjfW8qX/ai2XW0TxtT8fw5fo4l6JsNqdBRT/Conr
         NYRnvAzALZNUGU5hlJJUVPoUORZudbzrY32g3S4XSD5O8YagxlTDotPEP3RlNfC3f81q
         VFV3tetw/ZRGQOrPqhRWL3dBcSh9K7VEh+Rt4exhJLicymzJ+w9x5V80St3bEZfZVDFK
         lLpA==
X-Gm-Message-State: AOAM533Zv9OpyKzWk6BAZUz5kH2xetSXGXqorLrZqo6lvEUqNfprE4/h
        plIwLlCbL5SEynd0qrXLBJUJFfGBx8TtWP6+/lj4oHP01u4=
X-Google-Smtp-Source: ABdhPJyYkAeGeo+VlHhVwTksZTiNAy5MGFBEapJ8tSTH63KvdNvLXENfi1+Vu68jL7Q7T7atO71iAYqJpk7wlC6geH8=
X-Received: by 2002:a05:6e02:1805:: with SMTP id a5mr6660938ilv.170.1607091815485;
 Fri, 04 Dec 2020 06:23:35 -0800 (PST)
MIME-Version: 1.0
References: <CAO__=G52s_=2E4wF8wDcgc3KwMU0kzmDfBQhDD3+LMZ8M3fZ8w@mail.gmail.com>
 <CAEf4BzbKtAcO81ZvxOJwhpOKauDQ==Y+Bcvy4_QAF3FZyLbMeg@mail.gmail.com>
In-Reply-To: <CAEf4BzbKtAcO81ZvxOJwhpOKauDQ==Y+Bcvy4_QAF3FZyLbMeg@mail.gmail.com>
From:   David Marcinkovic <david.marcinkovic@sartura.hr>
Date:   Fri, 4 Dec 2020 15:23:24 +0100
Message-ID: <CAO__=G5ReWaSsHUmkHk53LF8nBQCU_RtVoLdi=AXMDZX1mfu4Q@mail.gmail.com>
Subject: Re: Problem with BPF_CORE_READ macro function
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 3, 2020 at 9:35 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Dec 3, 2020 at 4:20 AM David Marcinkovic
> <david.marcinkovic@sartura.hr> wrote:
> >
> > Hello everyone,
> >
> > I am trying to run a simple BPF program that hooks onto
> > `mac80211/drv_sta_state` tracepoint. When I run the program on the arm
> > 32 bit architecture,
> > the verifier rejects to load the program and outputs the following erro=
r
> > message:
> >
> > Unrecognized arg#0 type PTR
> > ; int tp__mac80211_drv_sta_state(struct trace_event_raw_drv_sta_state* =
ctx)
> > 0: (bf) r3 =3D r1
> > 1: (85) call unknown#195896080
> > invalid func unknown#195896080
> >
> > This error does not seem to occur on the amd64 architecture. I am
> > using clang version 10 for both, compiling on amd64 and
> > cross-compiling for arm32.
> >
> >
> > I have prepared a simple program that hooks onto the
> > `mac80211/drv_sta_state` tracepoint.
> > In this example, `BPF_CORE_READ` macro function seems to cause the
> > verifier to reject to load the program.
> > I've been using this macro in various different programs and it didn't
> > cause any problems.
> > Also, I've been using packed structs and bit fields in other programs
> > and they also didn't cause any problems.
> >
> > I tried to use BPF_CORE_READ_BITFIELD as stated in this patch [0] and
> > got a similar error.
> >
> > Any input is much appreciated,
> >
>
> Can you provide libbpf debug output, especially the section about
> CO-RE relocations? Could it be that this tracepoint is inside the
> kernel module?

You're right. The problem is that this tracepoint is inside the kernel modu=
le.
I recompiled the kernel with CONFIG_MAC80211 flag set to 'y' and the
program loads
successfully.

Thank you very much for your fast reply.

>
> > Best regards,
> > David Mar=C4=8Dinkovi=C4=87
> >
> >
> > [0] https://lore.kernel.org/bpf/20201007202946.3684483-1-andrii@kernel.=
org/T/#ma08db511daa0b5978f16df9f98f4ef644b83fc96
> >
> >
>
> [...]
