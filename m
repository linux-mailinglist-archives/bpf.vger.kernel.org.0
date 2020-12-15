Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4802DA58B
	for <lists+bpf@lfdr.de>; Tue, 15 Dec 2020 02:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbgLOB1l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Dec 2020 20:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729510AbgLOB1a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Dec 2020 20:27:30 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E5CC06179C
        for <bpf@vger.kernel.org>; Mon, 14 Dec 2020 17:26:45 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id w139so17400107ybe.4
        for <bpf@vger.kernel.org>; Mon, 14 Dec 2020 17:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RTHfTDiuDxTh9tdklxDykjQOAjDArd2yccl0ApUykM8=;
        b=bjne4MTUL+epN/Fxns8YgF21KRRnHwoTjvzQQVE6Cjlxj2m5xzwtjfrGeieRm6xgdo
         0yOczr2zhJWhlOxYwi0boHhhxWbZsQGAHKPTNnouk1LuwIYDTmJ61fGP13pE9n8O36PM
         2a5sxFhwXo1xYpFnrhBuuohyHr+1RXOnn3hJgSTXgW8S3LHk+i6HTY6BDuUq3maCRmW1
         L62CRvBHwpAJ5gzacSurXZPXhjmVi/G4AYoZa3g8StKEPEBJAkejTqygocKEgIYciidT
         Oeyl8zmLoGqob3Dvm8UO5qXgRz1rzCk+v0ph/neRkP1RECPprOzZ9Tbj7sacScPIU4gk
         pgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RTHfTDiuDxTh9tdklxDykjQOAjDArd2yccl0ApUykM8=;
        b=saN25FM58NgItrgcKGg32Eh5NAyPWVbPkjeRRZ2a1FYUqFiZ3w1gDbHD6XVWkSnkya
         rd+X9qO2iTYPFb3eK4Hssed4fBLplhojRLiVIX5fSv/E/1X+8QS91XkD+Z8AuzWflU1d
         H67sgNLSAjcgZBjFkP/LVEmISPFbLNh/n0v/vyeL/ZFAyxuxA/I6QF2AoTzgleXCcapH
         Jinghx2aH/+Srk51Nvs9glZqK6fB0RWTnqAGEUi1tIvjlnjXjGwqLf2T+xfFjub97Uc2
         LZmpBNETu3Q+2cSs1ytLD5SRpm3HqeKXN92bOEd4hnPnnBNsGp4R2GUxHmDEdf/GbPDD
         4+fg==
X-Gm-Message-State: AOAM533zB/NF1B/VKSLRg0AfaPFOYrCG0URwtm4uuVuS924HxS4Em351
        nSTcb5yRZNYxrB3MBIO36iKZJVoFFlV2QMjDYkfor5Ch+iw=
X-Google-Smtp-Source: ABdhPJwAG5JAymotM/kgDSkmbHJu9lGvo7UjQICJQRIuOhcekLdoLZlb4i28izyoDkokqjDmWk9OgD0i84hITHD5fwQ=
X-Received: by 2002:a25:c089:: with SMTP id c131mr38288213ybf.510.1607995604589;
 Mon, 14 Dec 2020 17:26:44 -0800 (PST)
MIME-Version: 1.0
References: <CANaYP3EH2tS=LnAoRfYsnO-zs5qaO7GuHDhw03==t+B_C8Gf2w@mail.gmail.com>
In-Reply-To: <CANaYP3EH2tS=LnAoRfYsnO-zs5qaO7GuHDhw03==t+B_C8Gf2w@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 14 Dec 2020 17:26:33 -0800
Message-ID: <CAEf4Bza4P51cGFN4zgTBr5nt_3tcoeGQ-QfP5CjoGx2scJP5-g@mail.gmail.com>
Subject: Re: libbpf CO-RE read_user{,_str} macros
To:     Gilad Reti <gilad.reti@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 14, 2020 at 1:58 AM Gilad Reti <gilad.reti@gmail.com> wrote:
>
> Hello there,
> libbpf provides BPF_CORE_READ macros for reading struct members in a
> CO-RE compatible way. By default those macros reduct to the relevant
> bpf_probe_read_kernel functions. As far as I could tell, there are no
> variants of this macros that wrap the _user variants of the read
> functions. Are there any plans to support ones?

BPF_CORE_READ() are using BPF CO-RE and thus emit relocations, which
will be adjusted by libbpf to match kernel struct layouts by using
kernel's BTF(s). Because of this, having xxx_user() variants doesn't
make much sense, because libbpf can't relocate field offsets against
user-space types (as there is no BTF for user-space applications,
typically). Which is why there are no BPF_CORE_READ_USER()-like
macros.

What's your use case, though? There might be a valid one that we are
not aware of, so please provide more details. Thanks.

> Thanks,
> Gilad Reti.
