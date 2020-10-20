Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 574DB29441E
	for <lists+bpf@lfdr.de>; Tue, 20 Oct 2020 22:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgJTUyF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Oct 2020 16:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbgJTUyF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Oct 2020 16:54:05 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B26C0613CE
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2020 13:54:03 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id i2so3476555ljg.4
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2020 13:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6f57UWuC118E++fSfjDAkGeplOcLyvysARIHDbfPn0w=;
        b=JpqLXFqd7OjSQ5COym5UxB+bfimtvez4D03DIqi62ssHZ6V0SYnrEUk9t4DzTT9wMC
         2Yk5OTh+nq3oNf3wS3sTRsqQ3fUMNkjhdjIzEBeYN48HK0/PWm6PA36VGpWyJthvav6+
         oURI9UgQ9G+mJgZpAcAK82mRIDO7RGfAv8RZ5Zcc1vVc+vkmCjzoEmmO7V1UVusBz66a
         tWipXGNLtzNErixsFNwe+kfen7tcmGyUh4q/bJZzdUyJv5n9VGrKhdLUVmBU9vXMdQEK
         bnsvn2smdDA7szv3+vKjMRk6oDO+2RA0k+ntC9C/pNKbHUnaOyfp9m3wsrY4Quz2N7ZU
         Y3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6f57UWuC118E++fSfjDAkGeplOcLyvysARIHDbfPn0w=;
        b=a1cYMvOPY2FLDWAJ/Ud+lGBy/Al0e4bNyZroT5UgFPsTb9cY/3XZAJY/ORu8xNQ9+D
         f0KPLxGXHAqZCMazp9amyuTBeBWBfaj1WZqFxXg78544Mb8ZuUrvCnXGEjAlzEZzpdJL
         bsKr6B+XWskoR1AucPcAaY8AcJGBuwPfgtTR8rWp9Oqx4vVET8QA5xV7yOGn3YPiaw2l
         VWDNhfQJpuLC9e9bncygee1Lenswk0Mej1OnXzGDNs4mtxX9C0oaF88kcsb43+xGoL7z
         3yxe/tcDnwXMydW1eoXvdBShY93hVwjjzU9Q4V6La1t/V2cDQpYgq8SZxtJi7pv9Wr5f
         hmkg==
X-Gm-Message-State: AOAM533EqR5GMQ1+LoRmViYwHjsVzkcqmxpxVr3lpdgeE7S1OCQiW8Ap
        /V59/9qqIrHEOzpp6gyh3JsHor43q3YXwUhNb9c/1vI9ARI8CA==
X-Google-Smtp-Source: ABdhPJyLqNei923LW/fEZ1Th1P3ZlLfl5Q+Hl6OzApWJ0A5vh+Zi3MP9Waop8yjoc1OBdZqPdFmokOpdwVqv+fw2PDA=
X-Received: by 2002:a2e:9215:: with SMTP id k21mr25428ljg.163.1603227241770;
 Tue, 20 Oct 2020 13:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAOjtDRXzkwG84UCUVw0J_WmRt585OhOSjuWbdenYFNFinsSG0Q@mail.gmail.com>
 <CAEf4BzazaFZQHLcNARGWn4TTJJTQPdBVbskg+bJGp-dds-t1xw@mail.gmail.com>
 <CAOjtDRXrSzqb4PTBXDAHMuCArYjpMoTcT0Maw2UqefJN2DbATA@mail.gmail.com>
 <8cc1629c-8a85-2d84-f779-6a20bb5d36bd@iogearbox.net> <CAEf4BzatiTgwSqyP8tJRM32YWyHe1QSDEQWKezWTHE9ocLcgjQ@mail.gmail.com>
 <CAADnVQLLQnyiwnw8jPxgJtb59t78wz8X6JQZhTxUe0gw+yRz7w@mail.gmail.com>
In-Reply-To: <CAADnVQLLQnyiwnw8jPxgJtb59t78wz8X6JQZhTxUe0gw+yRz7w@mail.gmail.com>
From:   Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
Date:   Tue, 20 Oct 2020 22:56:34 +0200
Message-ID: <CAOjtDRWSB9_yYMqSy6Z_RGrtpk6uJUkXy4gby0-hqAgafitgTA@mail.gmail.com>
Subject: Re: Running JITed and interpreted programs simultaneously
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Luka Perkov <luka.perkov@sartura.hr>,
        David Marcinkovic <david.marcinkovic@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 20, 2020 at 12:02 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Oct 19, 2020 at 11:26 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > That wasn't happening last time people reported this on ARM32.
> > BPF_XADD was causing load failure, no fail back to interpreter mode.
> >
> > >
> > > Wrt force-interpret vs force-jit BPF_PROG_LOAD flag, I'm more concerned that this
> > > decision will then be pushed to the user who should not have to care about these
> > > internals. And how would generic loaders try to react if force-jit fails? They would
> > > then fallback to force-interpret same way as kernel does?
> >
> > The way I imagined this was if the user wants to force the mode and
> > the kernel doesn't support it (or the program can't be loaded in that
> > mode), then it's a fail-stop, no fall back. And it's strictly an
> > opt-in flag, if nothing is specified then it's current behavior with
> > fallback (which apparently doesn't always work).
>
> That doesn't sound right.
> Fallback to interpreter should always work unless features like
> trampoline are used.
> But that's not the case for arm32. Missing xadd support shouldn't cause
> load failure.

After some retesting, it turns out that everything is working as it is
supposed to. I'm sorry for the confusion this caused.

My colleagues and I originally ran into the XADD issue on a device
that had CONFIG_BPF_JIT_ALWAYS_ON [0].
That resulted in libbpf reporting the following error:
libbpf: load bpf program failed:
ERROR: strerror_r(524)=22

Other than that the log was mostly empty, except for the number of
processed instructions and other similar info.
After the suggestion to try running the program without JIT, we
recompiled the image without JIT_ALWAYS_ON, but wrongly assumed that
/proc/sys/net/core/bpf_jit_enable has to be set to 0 for the program
to work, so we have never tested with bpf_jit_enable set to 1.

We have now tested on a device with JIT_ALWAYS_ON turned off, and the
program works with bpf_jit_enable set to both 1 or 0, while running on
a device with JIT_ALWAYS_ON still causes the same error that we
originally encountered.

Thank you for the help everyone.

[0] https://lore.kernel.org/bpf/CAO__=G6kqajLdP_cWJiAUjXMRdJe2xBy2FJGiM1v4h6YquD3kg@mail.gmail.com/
