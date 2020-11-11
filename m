Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80DE2AF7E3
	for <lists+bpf@lfdr.de>; Wed, 11 Nov 2020 19:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgKKS2K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Nov 2020 13:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgKKS2J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Nov 2020 13:28:09 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB71C0613D4;
        Wed, 11 Nov 2020 10:28:09 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id 2so2764621ybc.12;
        Wed, 11 Nov 2020 10:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mYdQCCLutDfpOiGNIQ7mOmF7M9CGC3JeXE8HZEAVCOU=;
        b=mGgFFhYsWinFLsrA2HpF6Q4zSiPv9cjBmrNauD7foqZBIqGfqAoAILuaXmGJqLHnkS
         vkUf2P4dAaoWof/VQP/8WFVnkBVAdsCuX/hi1839Hkwr2iB43+XJ9s5RTUgMHeTapYal
         6NCGiL1ig3CY6VKYfcEU2taxYctVTsjCSVrKKUZLrTESb+JO9V5doCAO2+8zz0lEwq98
         2Mr5vB6Ynkc4U+kbX+tYtwG/2oSwgr7o4D6HPenD8MIprIYYCSN3VGU7Sy+IHewuHgyl
         bv5yQHEmC5JJQiVOlqb+Jup3Y/AKERkgt4yqueEKFrvj9dT35LRfwoYkjwk6V1Nf/Gd9
         /i+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mYdQCCLutDfpOiGNIQ7mOmF7M9CGC3JeXE8HZEAVCOU=;
        b=SoipfQKN/cKWBgCx3F0ZuetD9LVKZHbY1+rohYhqWZazF/8LVMtoqjb+mu7KxLAZBQ
         CymGUtPszaGbXiS8LvTfoxvgHTwSCWkPuUOEtI2m1UED8hTIbnyb0+D9HJIwnt3J+hBQ
         QQx0yVeaoaIY7neUVXY/O7x+C/Iy53D7EBy7cQOxQYYpdVzELVkDXWqNy/SJXhYjlX1U
         g+uC2v1srsUWEMcOsF2jfaWPHOXp3vm5vLgORnRSsDNMYvtGU3++syajbDPr2hVKz5Bs
         lOPZWWgKfYO3y29J2hteVCNAH2KVFaLXpfRaZ8SAa+APRTO626NfAkCFSrDUTWQdccP4
         lBiQ==
X-Gm-Message-State: AOAM532NXDrhLxwREmrF7C/nKjiU9P5eqq7s2h5lKzH+R1mGIBBfx2ls
        Y2eqbJoakeouh0sb+WQJTBQhD4NmjCfBDKrVQnQ=
X-Google-Smtp-Source: ABdhPJxD7pxaECvlHTXzBVurRweUq1ilVrcdZziUT7CILu9DyddeNu1A8y71Ptgatsxo+4Dy123mmF1MKY2A8SvY+nQ=
X-Received: by 2002:a25:7717:: with SMTP id s23mr22654634ybc.459.1605119289137;
 Wed, 11 Nov 2020 10:28:09 -0800 (PST)
MIME-Version: 1.0
References: <20201106052549.3782099-1-andrii@kernel.org> <20201106052549.3782099-5-andrii@kernel.org>
 <20201111115627.GB355344@kernel.org>
In-Reply-To: <20201111115627.GB355344@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 11 Nov 2020 10:27:58 -0800
Message-ID: <CAEf4BzZZ9HcfhVg=YF_0-7tO8Gpp8Jitm1Utg2h_jasXT0n4sw@mail.gmail.com>
Subject: Re: [PATCH dwarves 4/4] btf: add support for split BTF loading and encoding
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 11, 2020 at 3:56 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Nov 05, 2020 at 09:25:49PM -0800, Andrii Nakryiko escreveu:
> > Add support for generating split BTF, in which there is a designated base
> > BTF, containing a base set of types, and a split BTF, which extends main BTF
> > with extra types, that can reference types and strings from the main BTF.
>
> > This is going to be used to generate compact BTFs for kernel modules, with
> > vmlinux BTF being a main BTF, which all kernel modules are based off of.
>
> > These changes rely on patch set [0] to be present in libbpf submodule.
>
> >   [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=377859&state=*
>
> So, applied and added this:

Awesome, thanks! Do you plan to release v1.19 soon?

>
> diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
> index 4b5e0a1bf5462b28..20ee91fc911d4b39 100644
> --- a/man-pages/pahole.1
> +++ b/man-pages/pahole.1
> @@ -185,6 +185,10 @@ Do not encode VARs in BTF.
>  .B \-\-btf_encode_force
>  Ignore those symbols found invalid when encoding BTF.
>
> +.TP
> +.B \-\-btf_base
> +Path to the base BTF file, for instance: vmlinux when encoding kernel module BTF information.
> +
>  .TP
>  .B \-l, \-\-show_first_biggest_size_base_type_member
>  Show first biggest size base_type member.
>
> ---------------
>
> The entry for btf_encode/-J is missing, I'll add in a followup patch.
>
> Also I had to fixup ARGP_btf_base to 321 as I added this, to simplify
> the kernel scripts and Makefiles:
>
>   $ pahole --numeric_version
>   118
>   $

Oh, this is nice! Can't really use it with Kbuild now due to backwards
compatibility, but maybe someday.

>
> Now to test this all by applying the kernel patches and the encoding
> module BTF, looking at it, etc.
>
> - Arnaldo
>

[...]
