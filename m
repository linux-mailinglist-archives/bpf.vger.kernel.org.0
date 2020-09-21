Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30D22731C9
	for <lists+bpf@lfdr.de>; Mon, 21 Sep 2020 20:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbgIUSTm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Sep 2020 14:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgIUSTm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Sep 2020 14:19:42 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC4CC061755;
        Mon, 21 Sep 2020 11:19:42 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id x10so10928942ybj.13;
        Mon, 21 Sep 2020 11:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OA7OMhVny79rEZ0VyCzVUSE/eCVD3h2nOGxmWDGw6Pc=;
        b=IjKsh3MA1CB5vWSjGLje0keGrYGDJpyA47/lNF1OBD5GrAJ0sTGozrwKXR0WYyGJIe
         yRIT1QZvRB2Ovj+j+Pp9rNpYJwSRTaMv39CNpL1nBAbsvxoh+GiseRBycQ+3lgvU9NKv
         /ErVGUC8YeyRTT0CUu1sQVyho3NY4eKMVuk9luQ2E1jo5m5mvTA6nsOMtaOHbshdMBsz
         P6T0SGPcL5B2aIRe0pRokYFa73Qd+QlEtKzYgAl3UubRjJTKpI8SPN94oPAIjkolPA57
         TymMGmyKfdD3Msk4K4funK9PDJDPgh4nCeRziB6xac0REXWSQqqIVSlZGVi19JL0dbtz
         VZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OA7OMhVny79rEZ0VyCzVUSE/eCVD3h2nOGxmWDGw6Pc=;
        b=LtT+3NjnqS0N+86KzLY8MeZ+B2qsvvodKpWi3H/I/B8ae5F7SkMBobEQI1Zgfkyz0x
         EqV+zhERmkrGE4b8pXfIHW19z/0oeyCcRQhW9WmIadAkQ2AZv1ro551xw5Nt2rvaROEC
         QEUUrjqnnHvwoju7yL0c64n64KMcpShRpliPn4FrbTXpDvsyYaVeE9lBOrYvJhXN4cU1
         ESFO8uk856BS7ERt/FOVGa9flWTYwD1CO1OSE1n7hjX1zf0SxFNno3BaS1gpW24+TezB
         HF/BDbdCbrImz+SIE7+GQUV0TZWrMjhzBbEHB3GEm/sO1Eb5CZZwkdBaFWNaXfwzj7OV
         6s+w==
X-Gm-Message-State: AOAM530UYMHy+DSe3z+UFB+Bc9a/aWPw81jLUjWUjMk27sJ3AXuPwV6d
        CmjQzbpK3bJeYN2WWKZFxD7F0hYSlqQqOfLt13U=
X-Google-Smtp-Source: ABdhPJwmUtogJgBwpqGXZrmuNNPLByxgh1x2Wfw+SH8KuzcWrz+Nq5+vysVNiTAIJs/b7vidWPbgVqvQQA2IHJ5uRdI=
X-Received: by 2002:a25:cbc4:: with SMTP id b187mr1610206ybg.260.1600712381417;
 Mon, 21 Sep 2020 11:19:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAPGftE8ipAacAnm9xMHFabXCL-XrCXGmOsX-Nsjvz9wnh3Zx-w@mail.gmail.com>
 <9e99c5301fbbb4f5f601b69816ee1dc9ab0df948.camel@linux.ibm.com>
 <CAEf4Bza9tZ-Jj0dj9Ne0fmxa95t=9XxxJR+Ce=6hDmw_d8uVFA@mail.gmail.com>
 <8cf42e2752e442bb54e988261d8bf3cd22ad00f2.camel@linux.ibm.com>
 <20200909142750.GC3788224@kernel.org> <CAPGftE8jNys9aVfUZW2iE5vB=QWKEmmwwWuWq9ek0ZXp-Aobkg@mail.gmail.com>
In-Reply-To: <CAPGftE8jNys9aVfUZW2iE5vB=QWKEmmwwWuWq9ek0ZXp-Aobkg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 21 Sep 2020 11:19:30 -0700
Message-ID: <CAEf4BzYDm3QOOgND9p+LR21bn98QMjE+VYspQSvi4ebG9EdW0g@mail.gmail.com>
Subject: Re: Problem with endianess of pahole BTF output for vmlinux
To:     Tony Ambardar <tony.ambardar@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Sep 19, 2020 at 12:58 AM Tony Ambardar <tony.ambardar@gmail.com> wrote:
>
> On Wed, 9 Sep 2020 at 07:27, Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > Em Wed, Sep 09, 2020 at 11:02:24AM +0200, Ilya Leoshkevich escreveu:
> > > On Tue, 2020-09-08 at 13:18 -0700, Andrii Nakryiko wrote:
> > > > On Mon, Sep 7, 2020 at 9:02 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> > > > > On Sat, 2020-09-05 at 21:16 -0700, Tony Ambardar wrote:
> >
> [...]
> > > > > > Is this expected? Is DEBUG_INFO_BTF supported in general when
> > > > > > cross-compiling? How does one generate BTF encoded for the
> > > > > > target endianness with pahole?
> >
> > The BTF loader has support for endianness, its just the encoder that
> > doesn't :-\
> >
> > I.e. pahole can grok a big endian BTF payload on a little endian machine
> > and vice-versa, just can't cross-build BTF payloads ATM.
> >
> > > > Yes, it's expected, unfortunately. Right now cross-compiling to a
> > > > different endianness isn't supported. You can cross-compile only if
> > > > target endianness matches host endianness.
> >
> > I agree that having this in libbpf is better, it should be done as part
> > of producing the result of the deduplication phase.
> >
> Thanks for confirming this wasn't a case of operator error. My platforms for
> learning/experimenting with BPF have been small embedded ones, including
> cross-compiling to different archs, word-size and endianness, which have
> "helped" me run into multiple problems till now. This one is the first I
> couldn't work around however...
>
> [...]
> > > > I'm working on extending BTF APIs in libbpf at the moment. Switching
> > > > endianness would be rather easy once all that is done. With these new
> > > > APIs it will be possible to switch pahole to use libbpf APIs to
> > > > produce BTF output and support arbitrary endianness as well. Right
> > > > now, I'd rather avoid implementing this in pahole, libbpf is a much
> > > > better place for this (and will require ongoing updates if/when we
> > > > introduce new types and fields to BTF).
> >
> > Right, we could do it right after btf_dedup() and before
> > btf_elf__write(), doing the same process as in btf_loader.c, i.e.
> > checking if the ELF target arch is different in endianness and doing the
> > reverse of the loader.
> >
> > > > Hope this plan works for you guys.
> > >
> > > That sounds really good to me, thanks!
> >
> Andrii and Arnaldo, I really appreciate your working on a proper endianness fix.
> If you have a WIP or staging branch and could use some help please let me know.
>

I have a bunch of code changes locally. I'll clean that up, partition
libbpf and pahole patches, and post them for review this week. To
address endianness support, those are the prerequisites. Once those
changes land, I'll be able to solve endianness issues you are having.
So just a bit longer till all that is done, sorry for the wait!

> Best regards,
> Tony
