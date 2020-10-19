Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11F62930E2
	for <lists+bpf@lfdr.de>; Tue, 20 Oct 2020 00:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387748AbgJSWCa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Oct 2020 18:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729617AbgJSWCa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Oct 2020 18:02:30 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4348C0613CE
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2020 15:02:29 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 23so2111232ljv.7
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2020 15:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7II6SS5VqohjtAxbqQemDFOC71upiwxLecRxANCNdAA=;
        b=DVWtZVhp0ODdbWPZM/uqX8YbYkBHXbrwLrbJfPocE1kwxKCgDZMaRqKX4soNAaDpsd
         L/z78idFgbA+twmnc68FAKtzKK5uWMY7/642sb964f/GeK4fdOsGlqfqRPM49T2Z3zxe
         SRwhkuzRslWMP+73uhoWsVPvvdJQ/ZYairmNreiXRPpc+DL4FtG6JKV9iwBCupsDdqHd
         CrfNFjfVdkQO2rQogYCY/MuYpgW3F7ot3h0QqdKyqHWnO9LZBQ8yA3a++2mE4bPt7mAG
         hgfsKhdI6ZD0T/9WI1gMu3bxbco/6zKtnf4wfTELgQAu7FOt2mgj/UC6G0BKgTnTlKBc
         Fi8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7II6SS5VqohjtAxbqQemDFOC71upiwxLecRxANCNdAA=;
        b=p/XnoZoM9Px9T9Iz38z/6OX/C448svZ+Ev4qfuq+VVwez9mZn7+RY5r8XuY1A9k4I6
         DEXC4leBoERoUivxFVVbqvaScdWRbv0KcOJues034wKzCKEFqRXigkfRdbp2KAZHlv9e
         QBTD8EY/Lasrk5nUUZFl2JxLL3CGE45GCw3s5FCLIAodX3z+dlXPqBVRxeKKyclTYJni
         RilM8tuxCxUSoZN3yBo4uRpPAYXHN9rMZoLOo8imDIg1ZIEcijhcAE551eTImx7xFt67
         5fE0ll76MBHdLeLvOiVhU4QwcoZJn4MYG8flAHiDufOxaAKvalBnwri10zRH6UBZ4MG+
         GNSQ==
X-Gm-Message-State: AOAM530hMh/wV0XugJABMxxWBxw4Y8sOpQfLiOXsiEirmLPtbJUuD1Kv
        79gk0Tx98vYYx28Klqh9/6RvqnOSar8CNNZ0mkEPs2rmJAo=
X-Google-Smtp-Source: ABdhPJz9p1UoghsGE2UfVR/QxeYyYAQzBsqu0W/cOzuTyfKKZDHIOTbKZ3o/lQgX/eBsk1Noe12WNdLuirrFBK/GQB4=
X-Received: by 2002:a2e:9015:: with SMTP id h21mr845674ljg.450.1603144947830;
 Mon, 19 Oct 2020 15:02:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAOjtDRXzkwG84UCUVw0J_WmRt585OhOSjuWbdenYFNFinsSG0Q@mail.gmail.com>
 <CAEf4BzazaFZQHLcNARGWn4TTJJTQPdBVbskg+bJGp-dds-t1xw@mail.gmail.com>
 <CAOjtDRXrSzqb4PTBXDAHMuCArYjpMoTcT0Maw2UqefJN2DbATA@mail.gmail.com>
 <8cc1629c-8a85-2d84-f779-6a20bb5d36bd@iogearbox.net> <CAEf4BzatiTgwSqyP8tJRM32YWyHe1QSDEQWKezWTHE9ocLcgjQ@mail.gmail.com>
In-Reply-To: <CAEf4BzatiTgwSqyP8tJRM32YWyHe1QSDEQWKezWTHE9ocLcgjQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 19 Oct 2020 15:02:16 -0700
Message-ID: <CAADnVQLLQnyiwnw8jPxgJtb59t78wz8X6JQZhTxUe0gw+yRz7w@mail.gmail.com>
Subject: Re: Running JITed and interpreted programs simultaneously
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        bpf <bpf@vger.kernel.org>, Luka Perkov <luka.perkov@sartura.hr>,
        David Marcinkovic <david.marcinkovic@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 19, 2020 at 11:26 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> That wasn't happening last time people reported this on ARM32.
> BPF_XADD was causing load failure, no fail back to interpreter mode.
>
> >
> > Wrt force-interpret vs force-jit BPF_PROG_LOAD flag, I'm more concerned that this
> > decision will then be pushed to the user who should not have to care about these
> > internals. And how would generic loaders try to react if force-jit fails? They would
> > then fallback to force-interpret same way as kernel does?
>
> The way I imagined this was if the user wants to force the mode and
> the kernel doesn't support it (or the program can't be loaded in that
> mode), then it's a fail-stop, no fall back. And it's strictly an
> opt-in flag, if nothing is specified then it's current behavior with
> fallback (which apparently doesn't always work).

That doesn't sound right.
Fallback to interpreter should always work unless features like
trampoline are used.
But that's not the case for arm32. Missing xadd support shouldn't cause
load failure.
