Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E0B365DF8
	for <lists+bpf@lfdr.de>; Tue, 20 Apr 2021 18:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbhDTQ4M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Apr 2021 12:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbhDTQ4M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Apr 2021 12:56:12 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF27C06174A
        for <bpf@vger.kernel.org>; Tue, 20 Apr 2021 09:55:41 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 65so43812189ybc.4
        for <bpf@vger.kernel.org>; Tue, 20 Apr 2021 09:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gICuAp3Pquh/lrfQ+hVpwQGGb7ciruRL5YwQXBd9yuE=;
        b=f7pLr5I/ZAsprw3VFMITeM5qXtn2Kl862lifEKceXEa2aub70Ip50oVCZGQW6LvDug
         bx7ARU7qCL4feSXj1oipvGgxvdIYEME5air226Rnpo9hPsxvTEEtgbak1RZA4wlSxiBg
         gpUDcfnE6Em+hVrowPXZijRZQV6kNortlx1O745PtNf0puGOKNrL5o1wDhgj7QbW1yvh
         8tndP6m63y/0ZDOEsrSFmtoiHqERO2LkSDCAp2tSJBQnBnDvfYreq6CGMf6wRRNeBIvk
         /Ohz6zokN+2rOpQDdhp3UlAuf5W69MPsEFTpSeSTxesfiaTb/f3C7ZRVc4NoDOXtkQ7p
         FEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gICuAp3Pquh/lrfQ+hVpwQGGb7ciruRL5YwQXBd9yuE=;
        b=KP6zwLjmYl0z8lMeInfayDUeD3FKfYNjaLfyaitQQjBhgMQNU27OpWpxkAb9PEa9RA
         2L7UjbdNOT80VO1hEOzk7aj2yGgb0iWItHHxBpYSjJ1EXNnHTifmzHO+RMGmPrqD6S3V
         79k0BjXcQvuWaEX4xf1mWsZD15bDFDfEMflvLfaVw+MPXBticb4wkg8/yH21MaJM/4Yt
         a1Xjs95l71MWRA5jpqdBnrpkGDJB+GD1D/N/BywnC6ezWqSllfbjAgjdwMvuDSqCCjmr
         OAHUYWpuqpcbgBe1msjC7RlS2mNMr2IVh7sIx8MsG9ep5/RiDLHVMJhPwWZ+pNb5kLe6
         LUQw==
X-Gm-Message-State: AOAM5313q10rVZBOqTUpOGhgksnYgs/fkPzRMAa9hIpowGPYyIE3uUwn
        ynl7WuBA3groFP8AtxsBmAIq2ioSWoJGRBCAI2bVKam/W6w=
X-Google-Smtp-Source: ABdhPJyTzIAmr5qTiXZLjkHcVpOYiJtIv8p+8cYzFlKIwLzzIMVOHcvTu7zGEbfoq33u2AndS9SSKl1mqIFCzOqq1sM=
X-Received: by 2002:a25:3357:: with SMTP id z84mr26091572ybz.260.1618937740422;
 Tue, 20 Apr 2021 09:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw9_66VctZZajdAUb0jhhn03nFkvbFLRMc=1_2zJ2_kr-aw@mail.gmail.com>
In-Reply-To: <CACAyw9_66VctZZajdAUb0jhhn03nFkvbFLRMc=1_2zJ2_kr-aw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 20 Apr 2021 09:55:29 -0700
Message-ID: <CAEf4Bza1=DKHtXJ3+Ez7xXFJ1EKQqB7fUrB-fDz_dSOKcGm7FA@mail.gmail.com>
Subject: Re: Behaviour of bpf_core_enum_value with missing value
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 20, 2021 at 6:43 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> Hi Andrii,
>
> The documentation for bpf_core_enum_value says that a missing
> enum_value will make the macro return 0:
>
> * 64-bit value, if specified enum type and its enumerator value are
> * present in target kernel's BTF;
> * 0, if no matching enum and/or enum value within that enum is found.
> */
> #define bpf_core_enum_value(enum_type, enum_value)
>
> However, the enumval___err_missing test asserts that
> bpf_core_enum_value with a missing value will poison the result if I
> understand correctly.
>

I think comment is outdated. This was my initial approach, but after
discussing with Alexei we decided to keep the behavior consistent with
other types of relocation and require guarding with
bpf_core_enum_value_exists() to handle cases where enum value is
expected to not exist sometimes.

> $ sudo ./test_progs -n 31/77 -vvv
> ...
> libbpf: prog 'test_core_enumval': relo #9: kind <enumval_value> (11),
> spec is [5] typedef anon_enum::ANON_ENUM_VAL2 = 32
> libbpf: prog 'test_core_enumval': relo #9: non-matching candidate #0
> [6] typedef anon_enum___err_missing::ANON_ENUM_VAL1___err_missing =
> 273
> libbpf: prog 'test_core_enumval': relo #9: no matching targets found
> libbpf: prog 'test_core_enumval': relo #9: substituting insn #48 w/ invalid insn
> libbpf: prog 'test_core_enumval': relo #9: substituting insn #47 w/ invalid insn
> libbpf: load bpf program failed: Invalid argument
>
> What is the correct behaviour in this case?

Tests and code are right, comment is wrong. Now looking at
progs/test_core_reloc_enumval.c, /* NAMED_ENUM_VAL3 value is optional
*/ should be probably replaced with if (bpf_core_enum_value_exists())
{ out->named_val3 = bpf_core_enum_value() } else { out->named_val3 =
0xBAD } pattern or similar.

>
> Lorenz
>
> --
> Lorenz Bauer  |  Systems Engineer
> 6th Floor, County Hall/The Riverside Building, SE1 7PB, UK
>
> www.cloudflare.com
