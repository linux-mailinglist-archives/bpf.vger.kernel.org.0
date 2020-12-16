Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1292DC071
	for <lists+bpf@lfdr.de>; Wed, 16 Dec 2020 13:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgLPMoR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Dec 2020 07:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgLPMoR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Dec 2020 07:44:17 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A36DC061794
        for <bpf@vger.kernel.org>; Wed, 16 Dec 2020 04:43:37 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id h16so24648461edt.7
        for <bpf@vger.kernel.org>; Wed, 16 Dec 2020 04:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7f/TuKYXcY2S7hF3e7foyaVj4dg6Ot16VKFFTCnvppE=;
        b=b3kkbvL8oHgWwqJ2gd+sCarUljOg2nMmJfjIxe9OvRJrTP+RYF1p2/uNbqQEipdGkj
         oYMjzxcC5Iz2lx1NzWlGzOrWuCmDuWOlysKje+vr1kjwmmGB8rKpU5t6/C3NIi4M+UkU
         Cqf4Ns+hC7J3tKPsHJ1/Oez6S1IqwelGr9u+odV8Mh7e6lrqMtyriFK/26byhIKTGVcH
         SQknnZ12PY1zmTKu/8DYV17MI43dZF08CymtwNtjlDef0g0vGAXrrOIiEZ1RToX4O9MT
         82uPC7PkiK/2oXbGlmgZ/8g8l7g26Pd0iFTAPxTDg25JeenGETsBh7HeVU26PYKdQHdo
         kjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7f/TuKYXcY2S7hF3e7foyaVj4dg6Ot16VKFFTCnvppE=;
        b=J+pgne8K/uPsY4zKpiobAd9BoYVuVxtO8rb1Wg83TCjDMXaupCDqncNOiPYatTBrwh
         9UyV4C79p5GuAEfGEUuZNuBnH+QvIxQGZiVXSjKCXXw7mqyKNItKSmoQVvZOS4m4nXYd
         dZ/K/wjSLwZ7NKeP2mGbuv9sI4HsioDrSuZ62hKopowdcAXeyhNAzQzJBYEDDYOf7/OX
         Kn6qbv6cRUzBV18i7MQW5i8JXczF0swyufJx2UO+mgGMYTkkh8BPPHvSK2rrGxa7zaLV
         cSJP+8Hr5a4foEnndPGDPontS/Efg11t0WR27sz4tR/8R5If1RR2nwV4+gppdPT9pJv/
         2jYw==
X-Gm-Message-State: AOAM531NKpRHbSNw1WDuhlhaqFb7Ja2hPwCqzlMZRVRZ8Gg9FaZy3Vto
        4id4jy6ZKNKQBVch0BoBQIWDLJERw9byhi6bZ+w=
X-Google-Smtp-Source: ABdhPJwcsj0DSwd8Q+TOZ5pFpnIG0ISLblxeRpLz6tgXKpRjHMgZONmSJlSFpE5Q5iQ9BRdXkO686Az8e6I/ZoYi8hY=
X-Received: by 2002:a05:6402:2070:: with SMTP id bd16mr32548026edb.107.1608122615728;
 Wed, 16 Dec 2020 04:43:35 -0800 (PST)
MIME-Version: 1.0
References: <CANaYP3EH2tS=LnAoRfYsnO-zs5qaO7GuHDhw03==t+B_C8Gf2w@mail.gmail.com>
 <CAEf4Bza4P51cGFN4zgTBr5nt_3tcoeGQ-QfP5CjoGx2scJP5-g@mail.gmail.com>
 <CANaYP3Euo8XYsDtqgoESLT_VRPGDKEyR8c0Wf3z1r_+nvS+ffw@mail.gmail.com>
 <CAEf4Bzb3ShNmD=_6XqUfL7DSDd_3rDcuuPN0Y4u8qVK2uOUsAA@mail.gmail.com>
 <CANaYP3GetBKUPDfo6PqWnm3xuGs2GZjLF8Ed51Q1=Emv2J-dKg@mail.gmail.com> <CAEf4BzZdFB_PgB4sYLn5xcNY5DDihWwZ8_0WvrLJL7zGETD4iQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZdFB_PgB4sYLn5xcNY5DDihWwZ8_0WvrLJL7zGETD4iQ@mail.gmail.com>
From:   Gilad Reti <gilad.reti@gmail.com>
Date:   Wed, 16 Dec 2020 14:42:59 +0200
Message-ID: <CANaYP3Ezq8p6dkXj8Vwj2d5qC4Ls2Zg=mu_UJPZJQVfKQN9gyQ@mail.gmail.com>
Subject: Re: libbpf CO-RE read_user{,_str} macros
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 15, 2020 at 11:48 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Dec 15, 2020 at 12:44 PM Gilad Reti <gilad.reti@gmail.com> wrote:
> >
> > On Tue, Dec 15, 2020 at 8:47 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Tue, Dec 15, 2020 at 4:50 AM Gilad Reti <gilad.reti@gmail.com> wrote:
> > > >
> > > > On Tue, Dec 15, 2020 at 3:26 AM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Mon, Dec 14, 2020 at 1:58 AM Gilad Reti <gilad.reti@gmail.com>
> > > > > wrote:
> > > > > >
> > > > > > Hello there,
> > > > > > libbpf provides BPF_CORE_READ macros for reading struct members in
> > > > > > a
> > > > > > CO-RE compatible way. By default those macros reduct to the
> > > > > > relevant
> > > > > > bpf_probe_read_kernel functions. As far as I could tell, there are
> > > > > > no
> > > > > > variants of this macros that wrap the _user variants of the read
> > > > > > functions. Are there any plans to support ones?
> > > > >
> > > > > BPF_CORE_READ() are using BPF CO-RE and thus emit relocations, which
> > > > > will be adjusted by libbpf to match kernel struct layouts by using
> > > > > kernel's BTF(s). Because of this, having xxx_user() variants doesn't
> > > > > make much sense, because libbpf can't relocate field offsets against
> > > > > user-space types (as there is no BTF for user-space applications,
> > > > > typically). Which is why there are no BPF_CORE_READ_USER()-like
> > > > > macros.
> > > > >
> > > > > What's your use case, though? There might be a valid one that we are
> > > > > not aware of, so please provide more details. Thanks.
> > > > Currently my use case is tracing syscall pointer arguments (For
> > > > example, "connect" has a "struct sockaddr *" argument).
> > >
> > > So if it's a kernel-defined data structure provided from user-space,
> > > then it has to be part of a stable UAPI type definitions, right? In
> > > such a case, you shouldn't need CO-RE, because the layout is stable.
> > > So it's still unclear why you'd need BPF_CORE_READ for that?..
> > I may be completely off, but can't struct offsets and members change
> > across different architectures?
>
> Hm.. that's an interesting angle, certainly across 32-bit and 64-bit
> architectures UAPI structs can have different layouts and it's
> possible to write and compile a single BPF program that would work on
> both. You'll most likely still have to compile twice (once for each
> architecture) due to the user-space part. But I think there is a use
> case or BPF_CORE_READ_USER() macro, so I don't mind adding it, let's
> just figure out the best way to do this. Thanks for elaborating!
Thank you for your time!
>
> > >
> > >
> > > Or is it because of the convenience of doing BPF_CORE_READ(s, field1,
> > > field2, field3) instead of a sequence of bpf_probe_read_user() calls?
> > > That's a different angle of BPF_CORE_READ() and we should clarify the
> > > desired functionality you are looking for.
> > >
> > >
> > > > >
> > > > > > Thanks,
> > > > > > Gilad Reti.
