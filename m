Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A58E292550
	for <lists+bpf@lfdr.de>; Mon, 19 Oct 2020 12:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgJSKRh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Oct 2020 06:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbgJSKRf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Oct 2020 06:17:35 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445DAC0613CE
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2020 03:17:35 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id a7so13458950lfk.9
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2020 03:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=osqVRR7NKEZeTxdL8fvwacFAlgcehNbNVRbt9Ptb0gk=;
        b=e5KnIPgQlFsyLy0bBwZOzINzBvPzYgGeFKJbWzXVIVa4c9Eq0zK9gnRK/Mg6cXfAmN
         4W1791Kx7spPprsxVSREmxmipK0m5X4EvOEZkfF6THXkmxn8fe8SaAJte1bWQWAZMl8R
         wlNPz0Bl/HQP4KbiLNlaIEtfo8R6ceGHaCxUuMUAW3yoUIVfs9ra/1+k9zHcZhkxomEQ
         hDDzEcslX//HtxTH9I80bzCAEA4dg6tL5gWGL3eePMFoZFsFGMY+97DH7BmEHf4Q/R7c
         s6lllT1b1c81t2gtz2QVLequ+GrZ2Jq08sFrjUGgDRHdSZULXiQUPDEzJxGZUNzsqXAW
         ioGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=osqVRR7NKEZeTxdL8fvwacFAlgcehNbNVRbt9Ptb0gk=;
        b=mb86SVgC/gyGHN/FE65XLfcoaH/v96BHW142CIjcQGSmUcQOlpUdfYz3a4qyCX+1mv
         35lKyghNzHmfidkUN3Zn7FnsKYKh4b8X11wvyzTWK01rX8ME3T1OcXr8CkbX0njcu4bY
         +jgxS+JVY+r8B/MD/ADdejcJ3Ziw4okblhcHp9/fhMRUO6jXBuEFfbf6gzG+2lAflQEW
         CfZuBh4yb1RzEVvkYfZNA9P/xot5D6GhBynrm6MkEyWp3Jqfk+XyNOYapO3zLEPPGNIG
         +tpJyxtHvDBi5fVhBfNpfLJ6OaarZiwfOFC3yrD89SHLSo0w3HHDUC1pbjqbifwolY8g
         QnZA==
X-Gm-Message-State: AOAM533eQoksfglWZhsG8Yp3sl7t9clbiZ9jgmxSiRIT7PAd404rqFRa
        aCYdIjtZuA/Sdcc5RyUWz84ndu4YOjq8UZJteb1YZZQVv2Q=
X-Google-Smtp-Source: ABdhPJytsX2XorD32HZP2HYGM11zYW8sgH1t2Ob8Qwe68QFUZYuiplVUeJO7LHkQMclW01WEo0SqXvxpb1uXHOmm424=
X-Received: by 2002:a19:80d5:: with SMTP id b204mr5263038lfd.384.1603102653164;
 Mon, 19 Oct 2020 03:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAOjtDRXzkwG84UCUVw0J_WmRt585OhOSjuWbdenYFNFinsSG0Q@mail.gmail.com>
 <CAEf4BzazaFZQHLcNARGWn4TTJJTQPdBVbskg+bJGp-dds-t1xw@mail.gmail.com>
In-Reply-To: <CAEf4BzazaFZQHLcNARGWn4TTJJTQPdBVbskg+bJGp-dds-t1xw@mail.gmail.com>
From:   Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
Date:   Mon, 19 Oct 2020 12:20:05 +0200
Message-ID: <CAOjtDRXrSzqb4PTBXDAHMuCArYjpMoTcT0Maw2UqefJN2DbATA@mail.gmail.com>
Subject: Re: Running JITed and interpreted programs simultaneously
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Luka Perkov <luka.perkov@sartura.hr>,
        David Marcinkovic <david.marcinkovic@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 14, 2020 at 12:05 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Oct 9, 2020 at 12:58 PM Juraj Vijtiuk <juraj.vijtiuk@sartura.hr> wrote:
> >
> > It would be great to hear if anyone has any thoughts on running a set
> > of BPF programs JITed while other programs are run by the interpreter.
> >
> > Something like that would be useful on 32-bit architectures, as the
> > JIT compiler there doesn't support some instructions, primarily
> > instructions that work with 64-bit data. As far as I can tell, it is
> > unlikely that support will be coming soon as it is a general issue for
> > all 32-bit architectures. Atomic operations like BPF_XADD look
> > especially problematic regarding support on 32 bit platforms. From
> > what I managed to see such a conclusion appeared in a few patches
> > where support for 32-bit JITs was added, for example [0].
> > That results in some programs being runnable with BPF JIT enabled, and
> > some failing during load time, but running successfully without JIT on
> > 32-bit platforms.
> >
> > The only way to run some programs with JIT and some without, that
> > seems possible right now, is to manually change
> > /proc/sys/net/core/bpf_jit_enable every time a program is loaded.
> > Although I've managed to do that and it seems to be working, it seems
> > pretty hacky and looks like it could cause race conditions if multiple
> > programs were loaded, especially by independent loaders.
>
> I agree, the global file is not flexible enough and can cause problems
> in production environment.
>
> I don't see any reason why we shouldn't allow to decide interpreted vs
> jitted mode per program during BPF_PROG_LOAD.
>
> See kernel/bpf/core.c, bpf_prog's jit_requested field determines
> whether a program is going to be jitted or not. It should be trivial
> to allow overriding that during BPF_PROG_LOAD command.
>
> We can probably also generalize this to allow to "force-jit" or
> "force-interpret" by users, which would fail if kernel didn't support
> requested mode.
>

Thanks for the suggestion, that makes sense. I've started working on a
patch today.
I'll post again when I get something working and test it.

> >
> > At first glance it seems that if something like this was to be added
> > to a loader, it would have to either somehow be aware of other BPF
> > programs being loaded or possibly implement some sort of locking
> > mechanism which also seems hacky. From what I understand, doing it in
> > the kernel looks even less promising as bpf_jit_enable is a system
> > wide setting, and I imagine that changing it to work on a per program
> > basis would pretty much require a rework of the current design, so
> > that looks even less promising.
> >
> > It looks like the best option right now is to just run everything in
> > interpreted mode, but I want to make sure that I am not missing
> > something. If someone has tried doing something similar, it would be
> > great to know about that.
> >
> > Thanks,
> > Juraj Vijtiuk
> >
> > [0] https://lore.kernel.org/netdev/20200305050207.4159-3-luke.r.nels@gmail.com/
