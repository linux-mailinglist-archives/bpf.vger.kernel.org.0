Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00AFC2DB3F5
	for <lists+bpf@lfdr.de>; Tue, 15 Dec 2020 19:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbgLOSsa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Dec 2020 13:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731434AbgLOSsa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Dec 2020 13:48:30 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D165CC0617A6
        for <bpf@vger.kernel.org>; Tue, 15 Dec 2020 10:47:49 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id a16so19951363ybh.5
        for <bpf@vger.kernel.org>; Tue, 15 Dec 2020 10:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bcC8yxdCx1qa+8KlXbob1bBa3AyPb6WsrSYqH6z/cB4=;
        b=KYyQhV8t0/AfJ6tK9Qd8oyQpSPWLYrarz/H8TaJhU1fd/NQcmxwpxbge5sd6G56Hw0
         YJTlhr/e+GwRLa6op4bno5Ia9pE+CKp4WdEWNz6wglfXreJG4HFQLYydIN8GCTHT79qY
         xLgFA4PjgZZYa3VjofTRuHfRUQ867ctiVV4rnQcGlapi9AlvU3PliRT6ZZSVYkq5sQvR
         En1qsEA0B3lGuEIPTRswC9bbvSLHXv/kZtB3rp6Oc6q8SqV0MLuUfNuHEb6HcSyRhieb
         VD/3r7VP84X2UL9jAKLQLErp9qxiaCPqPh+h+P8NUnEHLUYte5/0myuIpbXhiTUcYLyr
         FCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bcC8yxdCx1qa+8KlXbob1bBa3AyPb6WsrSYqH6z/cB4=;
        b=hWSBzYNBnOTicMaGjGkC/6bWraovbqbPjl46KDZ/FJKd8+hc04X4hKMkgRvPrSDZEA
         bc3am5Szpwy0xsDJo3okdSGTsFa78uLffpH0llLk9gyrSDaV+EKeoDCasmhC0jtXbNMc
         eMEY8YMs4aJP0vjJGWV0uNnpLOPfz+ePMlOyLv3+mVNVx1zkaK4F+D2UvnmECvk0nuII
         j+pXaMQyBn38rJ2mSsGFlRgMYuLqAzJNGYEWze/utPKjuO9bN0ddMHhWCM81ad8YejFT
         SMghCWbpZq0+VvIIpxTr+iLnUCPa6QDmNABGpQmr4ssgG1xD61nSZkVY4i/hRgwmVoyv
         fIRA==
X-Gm-Message-State: AOAM533U/KorJLjWxqzuQzTLCo3YjqYD2/r8x5cZ/Ad9wjdbQY90yqPI
        oJadvtRpvKneT68sR/ZSXgnpuEXz7iz8DHbrkAM=
X-Google-Smtp-Source: ABdhPJzurhNF7H9FIl2Hz0oDZLlHUJ1ngqyaIy6YXlZxp1V1wLiRLvkn32bAXjxG6NaRQQN+YMOSeZXTcwMt0ndzvY4=
X-Received: by 2002:a25:aea8:: with SMTP id b40mr46552414ybj.347.1608058069125;
 Tue, 15 Dec 2020 10:47:49 -0800 (PST)
MIME-Version: 1.0
References: <CANaYP3EH2tS=LnAoRfYsnO-zs5qaO7GuHDhw03==t+B_C8Gf2w@mail.gmail.com>
 <CAEf4Bza4P51cGFN4zgTBr5nt_3tcoeGQ-QfP5CjoGx2scJP5-g@mail.gmail.com> <CANaYP3Euo8XYsDtqgoESLT_VRPGDKEyR8c0Wf3z1r_+nvS+ffw@mail.gmail.com>
In-Reply-To: <CANaYP3Euo8XYsDtqgoESLT_VRPGDKEyR8c0Wf3z1r_+nvS+ffw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 15 Dec 2020 10:47:38 -0800
Message-ID: <CAEf4Bzb3ShNmD=_6XqUfL7DSDd_3rDcuuPN0Y4u8qVK2uOUsAA@mail.gmail.com>
Subject: Re: libbpf CO-RE read_user{,_str} macros
To:     Gilad Reti <gilad.reti@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 15, 2020 at 4:50 AM Gilad Reti <gilad.reti@gmail.com> wrote:
>
> On Tue, Dec 15, 2020 at 3:26 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Dec 14, 2020 at 1:58 AM Gilad Reti <gilad.reti@gmail.com> wrote:
> > >
> > > Hello there,
> > > libbpf provides BPF_CORE_READ macros for reading struct members in a
> > > CO-RE compatible way. By default those macros reduct to the relevant
> > > bpf_probe_read_kernel functions. As far as I could tell, there are no
> > > variants of this macros that wrap the _user variants of the read
> > > functions. Are there any plans to support ones?
> >
> > BPF_CORE_READ() are using BPF CO-RE and thus emit relocations, which
> > will be adjusted by libbpf to match kernel struct layouts by using
> > kernel's BTF(s). Because of this, having xxx_user() variants doesn't
> > make much sense, because libbpf can't relocate field offsets against
> > user-space types (as there is no BTF for user-space applications,
> > typically). Which is why there are no BPF_CORE_READ_USER()-like
> > macros.
> >
> > What's your use case, though? There might be a valid one that we are
> > not aware of, so please provide more details. Thanks.
> Currently my use case is tracing syscall pointer arguments (For
> example, "connect" has a "struct sockaddr *" argument).

So if it's a kernel-defined data structure provided from user-space,
then it has to be part of a stable UAPI type definitions, right? In
such a case, you shouldn't need CO-RE, because the layout is stable.
So it's still unclear why you'd need BPF_CORE_READ for that?..


Or is it because of the convenience of doing BPF_CORE_READ(s, field1,
field2, field3) instead of a sequence of bpf_probe_read_user() calls?
That's a different angle of BPF_CORE_READ() and we should clarify the
desired functionality you are looking for.


> >
> > > Thanks,
> > > Gilad Reti.
