Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1943D265D8C
	for <lists+bpf@lfdr.de>; Fri, 11 Sep 2020 12:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbgIKKP1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Sep 2020 06:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgIKKPL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Sep 2020 06:15:11 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE9EC061573
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2020 03:15:10 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id y13so10444922iow.4
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2020 03:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3jV9fLfBHUTeV4QVlSn+bVBlr8o8y9qnRUQ1MKtsnA8=;
        b=jV07dBhO2+gzhssXDCjSwVVqEgjA+QtBIpKGvIkrjrKoQDKdh7h015Srgmivfcj+Zp
         jJBBFSZb7Bj7PjSfB0KGj/IR3kl9znGFXlGkHSgJgGBk0q/5oVEjuc0UOz72BGrRC774
         TIY0BAsePpb+ncWz8xTU2/ILG6GO4ThDoP+B7UNe74KjO8mbPK9gtbOnKNUbaHAUL5yz
         bHCXOHAn35XHNJMaWUYdunE64NH5qACYLuXr+A+gKm5R3abnCcJ96Pbjl+U1vaCTlylc
         42mOFyH3KX5do/EHZE2URM+D2qtIB9JsxnOdrX/7kmi+xVTH5tUDR3bX9RpCvyBLrt4l
         HTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3jV9fLfBHUTeV4QVlSn+bVBlr8o8y9qnRUQ1MKtsnA8=;
        b=uAM6ioDmKRDie+0ll755xFgz4G069+DSFHQT188s/os88CJfKiGraADiSFHSGN33Xk
         CD+vqGZ4pyQ0QTEr/0+C3JCzfwBY0/4VPVsDDuvNko+QBSvpp4c86p42R8+sATmKTXEK
         CryQ+3+NjitY9WoQxjGpirOwTlzbVoHjPWxO1uWXsvcQ9UOZ25SgrVatz+122g7o42Dm
         z2QJxYOUTn3UUcBPhA+M7ANi76b/hBInJKGL0EXE7w7jdQ3gQf3JTPSLDFMQaiDVkMx9
         dqJ04nDAWiMtd4O9KfwX/NzhXxTKFjfrsf6YwCv/VPdyndGnkXGRTomIB+DX6Ntpvyfe
         RCSA==
X-Gm-Message-State: AOAM5311vS3+9HOVL0Oayjru76sY8le/TCicMIMKcTyuIMfWdTlbcgFN
        TSSCaK7j5uJmtJ+w6mIlLOeUUCYx5LKFr3596Lhbmw==
X-Google-Smtp-Source: ABdhPJxu4W51XsPLos7dmfqTlivUjuctzSIlKdzO87F+cNoojDztbwegWhlpMRz7jQ0h802qHkP18scVugu0QYSF7Tk=
X-Received: by 2002:a05:6638:611:: with SMTP id g17mr1191267jar.40.1599819310272;
 Fri, 11 Sep 2020 03:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAO__=G6kqajLdP_cWJiAUjXMRdJe2xBy2FJGiM1v4h6YquD3kg@mail.gmail.com>
 <CAEf4Bza2VA=eAOtmLaL23Fz07giN6AG3f5okwOdAcmrHda6AhQ@mail.gmail.com>
In-Reply-To: <CAEf4Bza2VA=eAOtmLaL23Fz07giN6AG3f5okwOdAcmrHda6AhQ@mail.gmail.com>
From:   David Marcinkovic <david.marcinkovic@sartura.hr>
Date:   Fri, 11 Sep 2020 12:14:59 +0200
Message-ID: <CAO__=G40JVDCb-YBP8q-T0OV-W1LOie0q7N8qRDRTCFgTebv2w@mail.gmail.com>
Subject: Re: Problem with atomic operations on arm32 with BPF
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Luka Perkov <luka.perkov@sartura.hr>,
        Borna Cafuk <borna.cafuk@sartura.hr>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 8, 2020 at 10:07 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Sep 7, 2020 at 5:18 AM David Marcinkovic
> <david.marcinkovic@sartura.hr> wrote:
> >
> > Hello everyone,
> >
> > I am trying to run a simple BPF example that uses the
> > `__sync_fetch_and_add` built-in function for atomic memory access.  It
> > fails with `libbpf: load bpf program failed: ERROR:
> > strerror_r(524)=3D22` error message.
> >
> > This error does not seem to occur on the amd64 architecture. I am
> > using clang version 10 for both, compiling on amd64 and
> > cross-compiling for arm32.
> >
> > I am aware that those built-in functions are available for arm32. [0].
> > Why is this error occurring?
> >
>
> Seems like BPF JIT for arm32 doesn't yet support those atomic
> operations, see [0]
>
>   [0] https://github.com/torvalds/linux/blob/master/arch/arm/net/bpf_jit_=
32.c#L1627
>
> You might want to try running in interpreted mode and see if that
> works for you. You'll lose speed, but will get functionality you need.

Thank you very much for your reply.
The program is working just fine when I disable the BPF Just In Time compil=
er.

>
> > To demonstrate I have prepared one simple example program that uses
> > that built-in function for atomic memory access.
> >
> > Any input is much appreciated,
> >
> > Best regards,
> > David Mar=C4=8Dinkovi=C4=87
> >
> > [0] https://developer.arm.com/documentation/dui0491/c/compiler-specific=
-features/gnu-builtin-functions?lang=3Den
> >
>
> [...]

I am curious if there is any way to enable or disable the JIT compiler
when starting the BPF program?  I am aware that the BPF JIT can be
enabled or disabled by using the `/proc/sys/net/core/bpf_jit_enable`
file, but I would like to know whether there is a way to specify it
programmatically when loading the program. Let's consider one use case
where we want to run two different BPF programs: one with the JIT
compiler, one without it.
