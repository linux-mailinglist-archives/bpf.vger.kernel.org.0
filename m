Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2CF292D82
	for <lists+bpf@lfdr.de>; Mon, 19 Oct 2020 20:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbgJSS05 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Oct 2020 14:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729369AbgJSS05 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Oct 2020 14:26:57 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1269DC0613CE
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2020 11:26:56 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id o70so417823ybc.1
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2020 11:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fXLKdl9NEJlq5Kvt+9kyvfQHvEnjUdiVfftl37CW4KU=;
        b=HtQIWSyHq+/7d5N2SkHyP2Kg+9tKTT3/7I/+2if5rbAuKE9eg7Ykh+8YNaHNXoreb7
         WLXSYnCoiAR3kF2nxvlWxSqlRB8fg3QjT/nvEp/3rzcwPprgGiZF/AQWU48cmMKYCDvP
         gR52k97RPXW8XEvfIV44Ba+3l8y59QoaVRwpa8wzqElVX91RfwpuicjaW0YOL0+n3uBV
         oeKXPmgkHmNBP3YjiaOS0DfQgTY1lSnyWRimQVvFsrUwif8SvP/gVuAowEeeOs88+JVL
         aaQ5wupcQcM/Ls8OKX/tSf9TUQs/j0sQ1YkkIZcc255pySg1FDvoyRLgByShH7J2EZsm
         rFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fXLKdl9NEJlq5Kvt+9kyvfQHvEnjUdiVfftl37CW4KU=;
        b=nLyByShVIAUoP5zBq7UYuGaUbB5ePsPHfVEHYkAGRI1KyHte98yDHdnfXPsow3NRKz
         zY867PkJlq/irPbhVS5ojdrvFxjv0YoIhDVXpCQlFS8GuePstrMaXkUfrD8dr17wkIda
         GyG7rwVK267yopkSk/kmn6LzmKpYvbCJbNB86csizuaMvtHULwMc6FvcNiT07Qrsgfve
         UKooSPG8BARyADCCEfaa0J3PZfhTtdYy3dArxkGzsqV0O1kAQQiYBGnnAS/dFEC4A8vv
         9D1wD6k1fHede62v2yHN5A6O7kTDt+DThtNBBOYiYqDLtHTSOr7je7B5zyDTxj1a+3Lw
         2tDA==
X-Gm-Message-State: AOAM530W9ah5C8veyr5lUd0iUrEW13H9BH85Sni0b+O7mUF4ZFZl/rji
        VgCqHss+qb/VWFLWD1+FBd6FVHQpXZAJJX7Zxu0=
X-Google-Smtp-Source: ABdhPJyTAZLKEzO1eBtCciKexpoQ0q6uZ5ufEpa16JOWDYK3rPd0BU/qRLY6t5HtPsVfYGs4zuJjawBIrfww5iL1PAw=
X-Received: by 2002:a25:c001:: with SMTP id c1mr753878ybf.27.1603132015096;
 Mon, 19 Oct 2020 11:26:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAOjtDRXzkwG84UCUVw0J_WmRt585OhOSjuWbdenYFNFinsSG0Q@mail.gmail.com>
 <CAEf4BzazaFZQHLcNARGWn4TTJJTQPdBVbskg+bJGp-dds-t1xw@mail.gmail.com>
 <CAOjtDRXrSzqb4PTBXDAHMuCArYjpMoTcT0Maw2UqefJN2DbATA@mail.gmail.com> <8cc1629c-8a85-2d84-f779-6a20bb5d36bd@iogearbox.net>
In-Reply-To: <8cc1629c-8a85-2d84-f779-6a20bb5d36bd@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 19 Oct 2020 11:26:44 -0700
Message-ID: <CAEf4BzatiTgwSqyP8tJRM32YWyHe1QSDEQWKezWTHE9ocLcgjQ@mail.gmail.com>
Subject: Re: Running JITed and interpreted programs simultaneously
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        bpf <bpf@vger.kernel.org>, Luka Perkov <luka.perkov@sartura.hr>,
        David Marcinkovic <david.marcinkovic@sartura.hr>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 19, 2020 at 5:58 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 10/19/20 12:20 PM, Juraj Vijtiuk wrote:
> > On Wed, Oct 14, 2020 at 12:05 AM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >> On Fri, Oct 9, 2020 at 12:58 PM Juraj Vijtiuk <juraj.vijtiuk@sartura.hr> wrote:
> >>>
> >>> It would be great to hear if anyone has any thoughts on running a set
> >>> of BPF programs JITed while other programs are run by the interpreter.
> >>>
> >>> Something like that would be useful on 32-bit architectures, as the
> >>> JIT compiler there doesn't support some instructions, primarily
> >>> instructions that work with 64-bit data. As far as I can tell, it is
> >>> unlikely that support will be coming soon as it is a general issue for
> >>> all 32-bit architectures. Atomic operations like BPF_XADD look
> >>> especially problematic regarding support on 32 bit platforms. From
> >>> what I managed to see such a conclusion appeared in a few patches
> >>> where support for 32-bit JITs was added, for example [0].
> >>> That results in some programs being runnable with BPF JIT enabled, and
> >>> some failing during load time, but running successfully without JIT on
> >>> 32-bit platforms.
> >>>
> >>> The only way to run some programs with JIT and some without, that
> >>> seems possible right now, is to manually change
> >>> /proc/sys/net/core/bpf_jit_enable every time a program is loaded.
> >>> Although I've managed to do that and it seems to be working, it seems
> >>> pretty hacky and looks like it could cause race conditions if multiple
> >>> programs were loaded, especially by independent loaders.
> >>
> >> I agree, the global file is not flexible enough and can cause problems
> >> in production environment.
> >>
> >> I don't see any reason why we shouldn't allow to decide interpreted vs
> >> jitted mode per program during BPF_PROG_LOAD.
> >>
> >> See kernel/bpf/core.c, bpf_prog's jit_requested field determines
> >> whether a program is going to be jitted or not. It should be trivial
> >> to allow overriding that during BPF_PROG_LOAD command.
> >>
> >> We can probably also generalize this to allow to "force-jit" or
> >> "force-interpret" by users, which would fail if kernel didn't support
> >> requested mode.
> >
> > Thanks for the suggestion, that makes sense. I've started working on a
> > patch today.
> > I'll post again when I get something working and test it.
>
> Hmm, I'm probably missing some context, but why is it not enough to just set the
> bpf_jit_enable to 1, and if 32 bit JITs don't support specific instructions like
> BPF_XADD then they should transparently fall back to interpreter if you have
> the latter compiled in. That is what it /should/ do today and user loading the
> prog shouldn't have to care about it. Juraj, you are suggesting that this is not
> happening in your case? Or is the issue tail calls?

That wasn't happening last time people reported this on ARM32.
BPF_XADD was causing load failure, no fail back to interpreter mode.

>
> Wrt force-interpret vs force-jit BPF_PROG_LOAD flag, I'm more concerned that this
> decision will then be pushed to the user who should not have to care about these
> internals. And how would generic loaders try to react if force-jit fails? They would
> then fallback to force-interpret same way as kernel does?

The way I imagined this was if the user wants to force the mode and
the kernel doesn't support it (or the program can't be loaded in that
mode), then it's a fail-stop, no fall back. And it's strictly an
opt-in flag, if nothing is specified then it's current behavior with
fallback (which apparently doesn't always work).

>
> Wrt BPF_XADD, maybe 32 bit platforms should just implement a function call to the
> atomic64_add() internally, it will be slow but otoh the rest can then be JITed, so
> most likely this still ends up being faster than using interpreter for everything
> anyway.
>
> Thanks,
> Daniel
