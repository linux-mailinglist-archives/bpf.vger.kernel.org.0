Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874E628DCC4
	for <lists+bpf@lfdr.de>; Wed, 14 Oct 2020 11:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730352AbgJNJUB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Oct 2020 05:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730512AbgJNJTm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Oct 2020 05:19:42 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B9DC0613B7
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2020 15:05:14 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id a4so906228ybq.13
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2020 15:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HtM86A5oGlkCWxqd8nSfr0h9tyf3tkyyqBku5Y8YMAg=;
        b=QA9CFN/BEmBHYh38C9BvfwprlQuXXwaBlur7ZOcLF/ha4WiE09fx3K+xSnaoi7fRL/
         FGkEVbGsdV0b5YWlxODaAC/Lrjo/7eFanR4f6s8Cx+ZiR3UV8ZENYHM8sNBlRWq6Lkql
         2CZDOlldLz6mC9OSdnt2Jexnmhgh5WlmZUhoRhB35+acRKVXW4L0LXgHrowUi4ZEsw7G
         0NDTjGi08tfOA0PyJ6E828Q/lm8mrfJIq+71ndCcb4Lc7oqVx3LMB6STlc2mRovqxkNE
         EOOtp9xg4SLuAtzE42BBWUvWZwNlcAn4Zk4EwQjFnhfnHH+rKItGMc+WjI3sebyFMYsK
         gi0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HtM86A5oGlkCWxqd8nSfr0h9tyf3tkyyqBku5Y8YMAg=;
        b=hYdof3PU+itXpOqIa2TM5MGGULgdJ7BFYcRWEhdQDLdJX4hofoIJCXyDuZXO+ODYe8
         rKg/ehRqobAzD6lqFq3ODHw7rCozzukKCvY8RYy3SDO2f3KcdDL2cjN4H9O141JaJqYc
         JoEV5Gkwli4OdE+VFC0IfC0hoFeeN+IKiS/i4GyyCOAz3Lg2hgBGkg6P+ciZEdJ2TBrI
         y70IlaHhhSFbuT65Bol1EqRpoCh7BnafmOYNwLOBfVZXEP4qPny03kq/H9No9TK79gzs
         5XT3VoJBR0qF+81a8/Sm3VKteTEJCIx+qspBGlS7PZuVF/lVOJe0bZz5tdr/cYn4cVaV
         SSnA==
X-Gm-Message-State: AOAM530/ou5uplOLTEr3dTeCsk5tNfoPSwMEkoicY6osAhdxpQBkAc6k
        Yman4PdF9T3ERVuhpgGD0H6ATsfpnYhRdEQhvJAf46sR4pU=
X-Google-Smtp-Source: ABdhPJwSYnaqHoqBj2Wl0ZxqaxZ/3gz7LmvEWGxrEFZBB773/nHOGv51qn1tOKDvbOsTgfcE2vGbhNHBCpxYB4nsDwg=
X-Received: by 2002:a25:5f08:: with SMTP id t8mr2919617ybb.260.1602626713322;
 Tue, 13 Oct 2020 15:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAOjtDRXzkwG84UCUVw0J_WmRt585OhOSjuWbdenYFNFinsSG0Q@mail.gmail.com>
In-Reply-To: <CAOjtDRXzkwG84UCUVw0J_WmRt585OhOSjuWbdenYFNFinsSG0Q@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 13 Oct 2020 15:05:02 -0700
Message-ID: <CAEf4BzazaFZQHLcNARGWn4TTJJTQPdBVbskg+bJGp-dds-t1xw@mail.gmail.com>
Subject: Re: Running JITed and interpreted programs simultaneously
To:     Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
Cc:     bpf <bpf@vger.kernel.org>, Luka Perkov <luka.perkov@sartura.hr>,
        David Marcinkovic <david.marcinkovic@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 9, 2020 at 12:58 PM Juraj Vijtiuk <juraj.vijtiuk@sartura.hr> wrote:
>
> It would be great to hear if anyone has any thoughts on running a set
> of BPF programs JITed while other programs are run by the interpreter.
>
> Something like that would be useful on 32-bit architectures, as the
> JIT compiler there doesn't support some instructions, primarily
> instructions that work with 64-bit data. As far as I can tell, it is
> unlikely that support will be coming soon as it is a general issue for
> all 32-bit architectures. Atomic operations like BPF_XADD look
> especially problematic regarding support on 32 bit platforms. From
> what I managed to see such a conclusion appeared in a few patches
> where support for 32-bit JITs was added, for example [0].
> That results in some programs being runnable with BPF JIT enabled, and
> some failing during load time, but running successfully without JIT on
> 32-bit platforms.
>
> The only way to run some programs with JIT and some without, that
> seems possible right now, is to manually change
> /proc/sys/net/core/bpf_jit_enable every time a program is loaded.
> Although I've managed to do that and it seems to be working, it seems
> pretty hacky and looks like it could cause race conditions if multiple
> programs were loaded, especially by independent loaders.

I agree, the global file is not flexible enough and can cause problems
in production environment.

I don't see any reason why we shouldn't allow to decide interpreted vs
jitted mode per program during BPF_PROG_LOAD.

See kernel/bpf/core.c, bpf_prog's jit_requested field determines
whether a program is going to be jitted or not. It should be trivial
to allow overriding that during BPF_PROG_LOAD command.

We can probably also generalize this to allow to "force-jit" or
"force-interpret" by users, which would fail if kernel didn't support
requested mode.

>
> At first glance it seems that if something like this was to be added
> to a loader, it would have to either somehow be aware of other BPF
> programs being loaded or possibly implement some sort of locking
> mechanism which also seems hacky. From what I understand, doing it in
> the kernel looks even less promising as bpf_jit_enable is a system
> wide setting, and I imagine that changing it to work on a per program
> basis would pretty much require a rework of the current design, so
> that looks even less promising.
>
> It looks like the best option right now is to just run everything in
> interpreted mode, but I want to make sure that I am not missing
> something. If someone has tried doing something similar, it would be
> great to know about that.
>
> Thanks,
> Juraj Vijtiuk
>
> [0] https://lore.kernel.org/netdev/20200305050207.4159-3-luke.r.nels@gmail.com/
