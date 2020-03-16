Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF2AA187570
	for <lists+bpf@lfdr.de>; Mon, 16 Mar 2020 23:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732749AbgCPWRr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Mar 2020 18:17:47 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:40554 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732739AbgCPWRq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Mar 2020 18:17:46 -0400
Received: by mail-ua1-f67.google.com with SMTP id t20so7236768uao.7;
        Mon, 16 Mar 2020 15:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wJo7ZmZmH0TiIejQdryJ3EHusk8AK7atRTT/qElU8mk=;
        b=pY8PI3pwZdpq6nPZYjoZpnYpZau8JaiUZE7gfRwRPOV/h9kAcg7RP43uhPrimETyP3
         AiLLjMLeB9OEyc6K+ZwYL2NpOE6s8qUyZxod9xA2xI18QVBNBSNKHTtBMfXRRxEa+A75
         63szQXFHTT5/dUHMrKmGeFoQ13EGUVswQssgoVZJZeWVoJ861d7sH+nLMKA4nY4PTq02
         9rbDElTNlvOZ6ihb1lsegGACNw8ih0+7FtrbjGogLvb1TvEpFN4yQNX2+JqekF51TSNJ
         AHuGUV9olfL0EcJHCCavgvdnN8hiJadhAQp3+gRuOHFjddUY3DYdozbUa3gACSrPt4Uh
         b/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wJo7ZmZmH0TiIejQdryJ3EHusk8AK7atRTT/qElU8mk=;
        b=JR4J+DE2Za4IyixE8w44ThaslJnVVuyA6wWtDC+Lggot49y8OE9BaU2yVruwYcQhij
         rZ4KzMljeneMDngLedUumjjQiOYtB7A2rRhJ1OrIGXZviuHU/2zf9DJopGkDZ9KpTnC/
         ThSSjE9XaAA3at+FuS1xZYdEaNAEkN6QC94lX8IV1C0Fcl1M+qUOGEyYkdugcGOn5SNp
         M3Kz50PledaGXSvHEhjdO2F0otvTJLKH5wYOLxWPCU+coa3UGKemBw1P/X6DiF/+zDjo
         3QLbfeOAQKhPTpLesA028iY0qRxDnxMsQHo+/pAGPmY7y5Da8CscHjjnjXJuxddB1TVv
         ATAw==
X-Gm-Message-State: ANhLgQ0MhAZYtWenW7Uch+J1j7GaLLKASlC/ohHscfLakiZNuo6bNCHJ
        0KNhycN6MypGWsyLKFpIjNYmjZdfRhL4HD0x5WQa1n4O
X-Google-Smtp-Source: ADFU+vuoQ/kRCsq5ARO98ctp//Ll6c0fNXHY/6edADTBa7RcUdzw4y4Go7Ey4w/OkSBRbLy+vcGAG3yEOFZiaB4O6zI=
X-Received: by 2002:ab0:344f:: with SMTP id a15mr1771389uaq.2.1584397065487;
 Mon, 16 Mar 2020 15:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200316163646.2465-1-a.s.protopopov@gmail.com> <202003161423.B51FDA8083@keescook>
In-Reply-To: <202003161423.B51FDA8083@keescook>
From:   Anton Protopopov <a.s.protopopov@gmail.com>
Date:   Mon, 16 Mar 2020 18:17:34 -0400
Message-ID: <CAGn_itw594Q_-4gC8=3jjRGF-wx90GeXMWBAz54X-UEer9pbtA@mail.gmail.com>
Subject: Re: [PATCH] seccomp: allow BPF_MOD ALU instructions
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

=D0=BF=D0=BD, 16 =D0=BC=D0=B0=D1=80. 2020 =D0=B3. =D0=B2 17:24, Kees Cook <=
keescook@chromium.org>:
>
> On Mon, Mar 16, 2020 at 04:36:46PM +0000, Anton Protopopov wrote:
> > The BPF_MOD ALU instructions could be utilized by seccomp classic BPF f=
ilters,
> > but were missing from the explicit list of allowed calls since its intr=
oduction
> > in the original e2cfabdfd075 ("seccomp: add system call filtering using=
 BPF")
> > commit.  Add support for these instructions by adding them to the allow=
ed list
> > in the seccomp_check_filter function.
> >
> > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
>
> This has been suggested in the past, but was deemed ultimately redundant:
> https://lore.kernel.org/lkml/201908121035.06695C79F@keescook/

Yeah, Paul told me this right after I submitted the patch.

> Is there a strong reason it's needed?

I really don't have such a strong need in BPF_MOD, but let me tell why
I wanted to use it in the first place.

I've used this operation to speedup processing linear blacklist
filters. Namely, if you have a list of syscall numbers to blacklist,
you can do, say,

ldw [0]
mod #4
jeq #1, case1
jeq #1, case2
jeq #1, case3
case0:
...

and in every case to walk only a corresponding factor-list. In my case
I had a list of ~40 syscall numbers and after this change filter
executed in 17.25 instructions on average per syscall vs. 45
instructions for the linear filter (so this removes about 30
instructions penalty per every syscall). To replace "mod #4" I
actually used "and #3", but this obviously doesn't work for
non-power-of-two divisors. If I would use "mod 5", then it would give
me about 15.5 instructions on average.

Thanks,
Anton

>
> Thanks!
>
> -Kees
>
> > ---
> >  kernel/seccomp.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > index b6ea3dcb57bf..cae7561b44d4 100644
> > --- a/kernel/seccomp.c
> > +++ b/kernel/seccomp.c
> > @@ -206,6 +206,8 @@ static int seccomp_check_filter(struct sock_filter =
*filter, unsigned int flen)
> >               case BPF_ALU | BPF_MUL | BPF_X:
> >               case BPF_ALU | BPF_DIV | BPF_K:
> >               case BPF_ALU | BPF_DIV | BPF_X:
> > +             case BPF_ALU | BPF_MOD | BPF_K:
> > +             case BPF_ALU | BPF_MOD | BPF_X:
> >               case BPF_ALU | BPF_AND | BPF_K:
> >               case BPF_ALU | BPF_AND | BPF_X:
> >               case BPF_ALU | BPF_OR | BPF_K:
> > --
> > 2.19.1
>
> --
> Kees Cook
