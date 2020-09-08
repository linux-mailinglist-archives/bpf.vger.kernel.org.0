Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0385261FD7
	for <lists+bpf@lfdr.de>; Tue,  8 Sep 2020 22:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730673AbgIHUHT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Sep 2020 16:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730079AbgIHUHQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Sep 2020 16:07:16 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CB4C061755
        for <bpf@vger.kernel.org>; Tue,  8 Sep 2020 13:07:15 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id c17so289034ybe.0
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2020 13:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XgVQ3QbFarEDILyufFnpyBmVmGtIcKPA8eUKLoYj4c4=;
        b=ss2Bwf4EkWNn5p6U7f08VMVlIhYP3eN+HiuxaWroqm+VZ6aIdumFnzUxf92TPF4gZf
         b4rQNOP37OnmS0VxyAlH7jegtrmSjcM4JADYyaQ5oHg1GyEcz5Tj0caRxnDbPGfPAkza
         kXD7gUCNePyPLzwu4ZmVx5me0aAAsxCiMyePhAD507W0ZvO0dSfye8tnVwWpFs0Pt3bD
         D2nbAKtFHyrArAyAF65FJGPx5rBdPqAhOZJfAJBnJuCZ2NC40BPtz0WQS6IB+2/+nzDX
         Cphq9Zlj9QZ+umXq7yNkewfCuXffXYO8+2rGczO0P2buURTUXCObF0TrnGIPHNp/XAOV
         6hRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XgVQ3QbFarEDILyufFnpyBmVmGtIcKPA8eUKLoYj4c4=;
        b=g0aiyjCEauRhvaAiqrnPKXPomKsxwra8oC8GEY58SlyixtEbPMM5JmXhJfPtOIwczE
         za6mopZYeGfnyHFTRG/TLXXyg8AXjKmUrbDHYWdqJc7RldFUobwJ2NQoSyf1jhaZN258
         ZinQYJOVsFA+jl0tvOpGa7khi5Dzre2wZdc66cep3GGQR/rLU+nemhgstdwrSQghouYg
         mD2H6JhqF6gYaGTT3ZmD5ow1rfGsd1yQN/Yr1tmVoADf95E3/OF7R8jLHsxxXXMaXiXJ
         fQlBdVLM4qCrzEebEWB1/+McWQ9opTVVZ0yYFykMsr4y+75+ouMBMTGOc0woM692/XXs
         VdpA==
X-Gm-Message-State: AOAM533WbggKEoiyo+Doi4H2stv5w54+kGw0vGeOuyuFou1RqjRAIzNI
        5+sJ7jaUFE8n4NnifVj0AC0PMWwnE3IE4DxsC5pREVjT5qw=
X-Google-Smtp-Source: ABdhPJxGgDFvIh/MCDIR0LQsseXoEeHuzznYBRGOyOvSKa4g+WAYrfYTJBeTcV9yY7sQ2T34AzLyBJL6ISB0dUQuBac=
X-Received: by 2002:a25:ad5a:: with SMTP id l26mr839953ybe.510.1599595635086;
 Tue, 08 Sep 2020 13:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAO__=G6kqajLdP_cWJiAUjXMRdJe2xBy2FJGiM1v4h6YquD3kg@mail.gmail.com>
In-Reply-To: <CAO__=G6kqajLdP_cWJiAUjXMRdJe2xBy2FJGiM1v4h6YquD3kg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 8 Sep 2020 13:07:04 -0700
Message-ID: <CAEf4Bza2VA=eAOtmLaL23Fz07giN6AG3f5okwOdAcmrHda6AhQ@mail.gmail.com>
Subject: Re: Problem with atomic operations on arm32 with BPF
To:     David Marcinkovic <david.marcinkovic@sartura.hr>
Cc:     bpf <bpf@vger.kernel.org>, Luka Perkov <luka.perkov@sartura.hr>,
        Borna Cafuk <borna.cafuk@sartura.hr>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 7, 2020 at 5:18 AM David Marcinkovic
<david.marcinkovic@sartura.hr> wrote:
>
> Hello everyone,
>
> I am trying to run a simple BPF example that uses the
> `__sync_fetch_and_add` built-in function for atomic memory access.  It
> fails with `libbpf: load bpf program failed: ERROR:
> strerror_r(524)=3D22` error message.
>
> This error does not seem to occur on the amd64 architecture. I am
> using clang version 10 for both, compiling on amd64 and
> cross-compiling for arm32.
>
> I am aware that those built-in functions are available for arm32. [0].
> Why is this error occurring?
>

Seems like BPF JIT for arm32 doesn't yet support those atomic
operations, see [0]

  [0] https://github.com/torvalds/linux/blob/master/arch/arm/net/bpf_jit_32=
.c#L1627

You might want to try running in interpreted mode and see if that
works for you. You'll lose speed, but will get functionality you need.

> To demonstrate I have prepared one simple example program that uses
> that built-in function for atomic memory access.
>
> Any input is much appreciated,
>
> Best regards,
> David Mar=C4=8Dinkovi=C4=87
>
> [0] https://developer.arm.com/documentation/dui0491/c/compiler-specific-f=
eatures/gnu-builtin-functions?lang=3Den
>

[...]
