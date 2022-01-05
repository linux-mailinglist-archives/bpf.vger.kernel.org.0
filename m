Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED96485CA7
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 00:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245660AbiAEXza (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Jan 2022 18:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245538AbiAEXyn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Jan 2022 18:54:43 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503BCC061245
        for <bpf@vger.kernel.org>; Wed,  5 Jan 2022 15:52:58 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id ay19so178905uab.12
        for <bpf@vger.kernel.org>; Wed, 05 Jan 2022 15:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VtdHEvF0NenBwKfZZjXTMc/ARKkLLwjkUVmZqWfzEwM=;
        b=McycAVibpAEzhnXxTL6DRjA4lHSOuooRaoSv75kWr+sbd1jq6RrZ3u1XezKjhydxlJ
         16VNLVxe19rFt5G0G3Pmvi9vZGJGu0DPTMjDdUwZHxH2/NlFUPdss9FHvYAo69lBdf+e
         IPhd59nbEXKP/yIjmFE3nQfiQO3w0FXnASia06vPGhtNOQQBJzis2a5WJt7J8OXx0oDh
         v5rvGL9SdIuypalvKhWllDo4m8PL9CbLY/9mTq0VnhitbA5kgd+6Mh0zogU4lGf3m4NT
         iW2kYL4QjNZYlsnzp51mDmOo/J23nUo3PS77cUWRRrI0EjPn66VGdV5yBmHCI/JSlEIP
         RMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VtdHEvF0NenBwKfZZjXTMc/ARKkLLwjkUVmZqWfzEwM=;
        b=tHtj7GQLhAsE1WvDD93cuPno4byGhnZjjjxOnoVhGe26qasQDDR6edO8TRaJOv2y2G
         AcAy2PnGNJWnMbBw/LalLlW6WdhPOD3inmrSLhkGcAYkA0GroP7s34pxQCOvYfatWHBZ
         CNt6k+fJ7ElHpTJ/O2KqKHdl3r7hS0CkgykL7qprA7hr/X7uF73bbMcIJ0ERSyxsva+h
         dEvesSqOk1STHTVNJoZ+8qNNlIeAyJr9XtOOCEIJXgDYkVnZRKoaSgVOZMv4BYePVZb4
         mSipYYXkvu3WWfHiCzVsb3MEIXyr8w8SKUATWSOr3ZBFUhWemV9byB1rB9qH/zWen+Gn
         h1fw==
X-Gm-Message-State: AOAM532uHH+gPOQopKv7PL8kV1rzXTCQz0QyJMqE832Cn//4OmdRRnoM
        UYZvMK7MDSsKm19l5yjuyefycqk1wMddEll9rjM=
X-Google-Smtp-Source: ABdhPJwRyCQsbamOa1MFB2ck2U6CN5bFw2LCOhlWc/HSkaKxWwjAQ3PA76IOrBxJAcEm4Xa3YQJsscLn7PfKzuwNw5Y=
X-Received: by 2002:a67:846:: with SMTP id 67mr17543403vsi.7.1641426777343;
 Wed, 05 Jan 2022 15:52:57 -0800 (PST)
MIME-Version: 1.0
References: <CAGnuNNuenDT4Y_UHsny6BK_b1+g2joePAdapdn7aLCi99Rh3bg@mail.gmail.com>
 <CAEf4BzZokm=_5vdf3sCccTf2Enf0-kwij7dusykcgtWPkM=95g@mail.gmail.com> <CAADnVQKN9uZ6KA97r1HzkWA63usdWatxXvV5+i=v=So1nirbVA@mail.gmail.com>
In-Reply-To: <CAADnVQKN9uZ6KA97r1HzkWA63usdWatxXvV5+i=v=So1nirbVA@mail.gmail.com>
From:   Gabriele <phoenix1987@gmail.com>
Date:   Wed, 5 Jan 2022 23:52:46 +0000
Message-ID: <CAGnuNNt7va4u78rvPmusYnhXAuy5e9aRhEeO6HDqYUsH979QLQ@mail.gmail.com>
Subject: Re: Read process VM from kernel
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> Please send a patch with a test case.

I have an R&D week coming up next week and if this is still not
implemented I was thinking of looking into it. Any pointers into the
codebase, docs etc... would be appreciated as I would be looking at
this code for the first time.

Cheers,
Gab.

On Tue, 14 Sept 2021 at 05:24, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Sep 13, 2021 at 8:48 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Sat, Sep 11, 2021 at 2:05 AM Gabriele <phoenix1987@gmail.com> wrote:
> > >
> > > Hi there
> > >
> > > I recently started playing around with libbpf and I was wondering if
> > > it is possible to read a process' VM from the kernel side. In
> > > user-space one could use process_vm_read, but I haven't been able to
> > > find an equivalent BPF API for that.
> >
> > Currently only current process's memory (in which BPF program is
> > running) can be read with bpf_probe_read_user(). I don't think there
> > is anything that allows reading some other process' data like
> > process_vm_read allows.
>
> Indeed. Currently it's not possible, but this feature request
> came up in the past and we couldn't do it until sleepable programs
> came into existence.
> Now ptrace_access_vm/process_vm_read could be added
> as a bpf helper for sleepable programs.
> Gab,
> Please send a patch with a test case.



--=20
"Egli =C3=A8 scritto in lingua matematica, e i caratteri son triangoli,
cerchi, ed altre figure
geometriche, senza i quali mezzi =C3=A8 impossibile a intenderne umanamente=
 parola;
senza questi =C3=A8 un aggirarsi vanamente per un oscuro laberinto."

-- G. Galilei, Il saggiatore.
