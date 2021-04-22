Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B33283686AA
	for <lists+bpf@lfdr.de>; Thu, 22 Apr 2021 20:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236796AbhDVSjA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Apr 2021 14:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236668AbhDVSi7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Apr 2021 14:38:59 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA996C06174A;
        Thu, 22 Apr 2021 11:38:22 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 82so52689174yby.7;
        Thu, 22 Apr 2021 11:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aL/QKwy+XkQh0q91Wy+csx8NaLsGuJJ+p/obXjssK4k=;
        b=DG2eaIaFHg/xGnlHJ2YODcnqhgKAgP4MxgtBlN3VsV8ikEAFVQ0Y+5LKCsq4rJrdyy
         oQ/oJjBBr272/B8XFd5m8tlWQreDzFAW4Pl0JXHjnh9uHDlSaSgnsYkp+MGTn9Y2wERX
         jQknrD3iKKmfS0htyaOGY3qDRUH8zrqA9A0FL5ycmJyhLhu3hLsSKYcx2zLlGlDweT2q
         5KggMyAe6ePbyjhE7g6tJsaosocbHX2UlO3Hb1HQEp3oQ6GdwDKuH6elRSbcrJpNror6
         c3u1nmhUR5AoMXKr0f7tahnt6VvPplk1QizZFoisOmykzKSOUKLHwj0CYdq6hOi8gee/
         ZQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aL/QKwy+XkQh0q91Wy+csx8NaLsGuJJ+p/obXjssK4k=;
        b=bJj6EQ+uW+ssRx4xbtfnBFqddGedfvEBoSIAAcijRgjSilDSLoJcTllId1UBzVLfij
         ClE1n0Q1JpJEmJEo2hBfJ43NV59uH6N0y/QBUzcbCYU7F3PZenJCK5DwxpABcvmSPeUB
         QLwmTEk+VcsrKBmzbaB4iXFMM/aFFTeE1WlTKanvDnyRoSCI2eTs6SQhPirEwXAdexkL
         N+RX00ei96FNo8Vn6dBHIy08Raqkwy9Twbl1eWg7dceUSs3zE4Y9AhmGpO2mf/8hgG+T
         zGdY5vORf3AoODpZf/DdlvKax8L8G1ahqJNt5Cpk7qmW/347KstZTM/A1sjF9faX3VXo
         nifQ==
X-Gm-Message-State: AOAM531EJpzEyPbVVIH152IKM4os10nch9Y44dNNwc3n3R6u3LB85hpl
        de95dtSFaaU8wIwReE4Rawa/QXXwVr8akrzqX2U=
X-Google-Smtp-Source: ABdhPJwnTGEzcqOzJdfU4E3ZWlI2Iesq9XlOP24Sm67XXm5ZRFNNrltVkwNmgpqD3RuCz90gEUrewH8qMipI7juIIQE=
X-Received: by 2002:a05:6902:1144:: with SMTP id p4mr46904ybu.510.1619116702286;
 Thu, 22 Apr 2021 11:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210421190736.1538217-1-linux@rasmusvillemoes.dk>
 <CAEf4Bza6-Unvr7QmcbvVtNDPc4BNzf8zMaU4XardNqB_GnGDHw@mail.gmail.com>
 <236995f6-30ee-8047-624c-08d0a1552dc1@rasmusvillemoes.dk> <CABRcYmJFfdCU_QxX+gYRWc+7BSbmTWX84o_WT=oBg_CPr8qS=g@mail.gmail.com>
In-Reply-To: <CABRcYmJFfdCU_QxX+gYRWc+7BSbmTWX84o_WT=oBg_CPr8qS=g@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 22 Apr 2021 11:38:11 -0700
Message-ID: <CAEf4BzZsYv78znqAkuhTPLSzgAxhSB9vr6eODn2G-vnV0yQyLQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: remove pointless code from bpf_do_trace_printk()
To:     Florent Revest <revest@chromium.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 22, 2021 at 2:23 AM Florent Revest <revest@chromium.org> wrote:
>
> On Thu, Apr 22, 2021 at 9:13 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
> >
> > On 22/04/2021 05.32, Andrii Nakryiko wrote:
> > > On Wed, Apr 21, 2021 at 6:19 PM Rasmus Villemoes
> > > <linux@rasmusvillemoes.dk> wrote:
> > >>
> > >> The comment is wrong. snprintf(buf, 16, "") and snprintf(buf, 16,
> > >> "%s", "") etc. will certainly put '\0' in buf[0]. The only case where
> > >> snprintf() does not guarantee a nul-terminated string is when it is
> > >> given a buffer size of 0 (which of course prevents it from writing
> > >> anything at all to the buffer).
> > >>
> > >> Remove it before it gets cargo-culted elsewhere.
> > >>
> > >> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > >> ---
> > >>  kernel/trace/bpf_trace.c | 3 ---
> > >>  1 file changed, 3 deletions(-)
> > >>
> > >
> > > The change looks good to me, but please rebase it on top of the
> > > bpf-next tree. This is not a bug, so it doesn't have to go into the
> > > bpf tree. As it is right now, it doesn't apply cleanly onto bpf-next.
>
> FWIW the idea of the patch also looks good to me :)
>
> > Thanks for the pointer. Looking in next-20210420, it seems to me that
> >
> > commit d9c9e4db186ab4d81f84e6f22b225d333b9424e3
> > Author: Florent Revest <revest@chromium.org>
> > Date:   Mon Apr 19 17:52:38 2021 +0200
> >
> >     bpf: Factorize bpf_trace_printk and bpf_seq_printf
> >
> > is buggy. In particular, these two snippets:
> >
> > +#define BPF_CAST_FMT_ARG(arg_nb, args, mod)                            \
> > +       (mod[arg_nb] == BPF_PRINTF_LONG_LONG ||                         \
> > +        (mod[arg_nb] == BPF_PRINTF_LONG && __BITS_PER_LONG == 64)      \
> > +         ? (u64)args[arg_nb]                                           \
> > +         : (u32)args[arg_nb])
> >
> >
> > +       ret = snprintf(buf, sizeof(buf), fmt, BPF_CAST_FMT_ARG(0, args,
> > mod),
> > +               BPF_CAST_FMT_ARG(1, args, mod), BPF_CAST_FMT_ARG(2,
> > args, mod));
> >
> > Regardless of the casts done in that macro, the type of the resulting
> > expression is that resulting from C promotion rules. And (foo ? (u64)bla
> > : (u32)blib) has type u64, which is thus the type the compiler uses when
> > building the vararg list being passed into snprintf(). C simply doesn't
> > allow you to change types at run-time in this way.
> >
> > It probably works fine on x86-64, which passes the first six or so
> > argument in registers, va_start() puts those registers into the va_list
> > opaque structure, and when it comes time to do a va_arg(int), just the
> > lower 32 bits are used. It is broken on i386 and other architectures
> > where arguments are passed on the stack (and for x86-64 as well had
> > there been a few more arguments) and va_arg(ap, int) is essentially ({
> > int res = *(int *)ap; ap += 4; res; }) [or maybe it's -= 4 because stack
> > direction etc., that's not really relevant here].
> >
> > Rasmus
>
> Thank you Rasmus :)
>
> It seems that we went offtrack in
> https://lore.kernel.org/bpf/CAEf4BzZVEGM4esi-Rz67_xX_RTDrgxViy0gHfpeauECR5bmRNA@mail.gmail.com/
> and we do need something like "88a5c690b6 bpf: fix bpf_trace_printk on
> 32 bit archs". Thinking about it again, it's clearer now why the
> __BPF_TP_EMIT macro emits 2^3=8 different __trace_printk() indeed.

Yeah, we wondering but no one could guess why it was done the way it
was done :) Next time we should invest in a better comment ;-P

>
> In the case of bpf_trace_printk with a maximum of 3 args, it's
> relatively cheap; but for bpf_seq_printf and bpf_snprintf which accept
> up to 12 arguments, that would be 2^12=4096 calls. Until now
> bpf_seq_printf has just ignored this problem and just considered
> everything as u64, I wonder if that'd be the best approach for these
> two helpers anyway.
