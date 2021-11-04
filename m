Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E03445B91
	for <lists+bpf@lfdr.de>; Thu,  4 Nov 2021 22:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbhKDVTA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Nov 2021 17:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbhKDVS7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Nov 2021 17:18:59 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7BEC061714
        for <bpf@vger.kernel.org>; Thu,  4 Nov 2021 14:16:21 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id y3so17716354ybf.2
        for <bpf@vger.kernel.org>; Thu, 04 Nov 2021 14:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XZdZxX8dn4aefyh+/KNL7bUiS3H3G5UaCeN35YlggVQ=;
        b=dBi0wjmxj3/+Nmk2ZVBeB/0BYcvY0arBYc7GaLWdTd0BDuqtmFfvgcA7z9WD9mJSMQ
         67xxGD6tX7HV1+aGm/hPkSukeg31dWqT1omJKjC6MLYaDRdGR/XnjvRjkjI3Kl+pXN6t
         KmGb2KjQFtipU74NrDtvUjMwNEcxKn8+hT/HcPeuj7ehLJW2oiqdfa2hKVzJ3hBfuibW
         za+QfQUjz6t5UxzumD4cBf3QmwRNf0A6jwAMJcQHIrqnOPF2SZFJG32Ohc0PTtWm4Y6f
         U2mq59cgk+fdqbmGSp5toqauVaE835XQ2HGxBfeQKOkV1zzau/5Wx65lhovIs67Ox3+8
         f1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XZdZxX8dn4aefyh+/KNL7bUiS3H3G5UaCeN35YlggVQ=;
        b=U7xg/S/XXvwoiPToqbjps7b/VS6AclXZ47J/lq1W+9yvI/HD3EpviRBEFzxLz6VY6O
         z6sPpzzTHiiAIzZR7A6scJsdH0GE12N1hyd5fln76W4b4PwjmHoHrKywMgNr6Jnx7g/z
         ULtvf0EvQpYDkLKYN0gvo7/mW/r5dds1eecBe3lv48crr6RKZXptCGYSFk+XSAIJIR/t
         hVzozyMss97pHE5XBNP6a8sg/BNulRBU24XhtofR068IE+TwnJaTm1m4BK4lxQVeSKJL
         UVaVosjZXpmHS813VmIsyfSXjKtAothC84ZCaPVTcNrunnnuY4wQcOk+jltRPpnLJ4Zz
         nA0w==
X-Gm-Message-State: AOAM533rJohds+Jl4Bcn/nBwP36ytPbX8EFgwSt4+iWAB6x2V4nlyxnT
        dRHkLDAK+9Yn0ZAhcB6PHsrevEBJ4L6QxVh81fU=
X-Google-Smtp-Source: ABdhPJxo2mvG9uXQ91Iq5hoSAjP662UQo8Hs1v9DS7v8l/rELLnjVdVcxyOEJJYLXIhDmArEoRgGt41W1XwKLShkLec=
X-Received: by 2002:a05:6902:1023:: with SMTP id x3mr28514226ybt.267.1636060580512;
 Thu, 04 Nov 2021 14:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <20211104122911.779034-1-toke@redhat.com>
In-Reply-To: <20211104122911.779034-1-toke@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 4 Nov 2021 14:16:09 -0700
Message-ID: <CAEf4BzYGjV5DQB7tqRkSKz6pz-3QtU7uSWQVNJMW4eSjnpF98A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: demote log message about unrecognised
 data sections back down to debug
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Ciara Loftus <ciara.loftus@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 4, 2021 at 5:29 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redha=
t.com> wrote:
>
> When loading a BPF object, libbpf will output a log message when it
> encounters an unrecognised data section. Since commit
> 50e09460d9f8 ("libbpf: Skip well-known ELF sections when iterating ELF")
> they are printed at "info" level so they will show up on the console by
> default.
>
> The rationale in the commit cited above is to "increase visibility" of su=
ch
> errors, but there can be legitimate, and completely harmless, uses of ext=
ra
> data sections. In particular, libxdp uses custom data sections to store

What if we make those extra sections to be ".rodata.something" and
".data.something", but without ALLOC flag in ELF, so that libbpf won't
create maps for them. Libbpf also will check that program code never
references anything from those sections.

The worry I have about allowing arbitrary sections is that if in the
future we want to add other special sections, then we might run into a
conflict with some applications. So having some enforced naming
convention would help prevent this. WDYT?

> metadata and run priority configuration of XDP programs, which triggers t=
he
> log message. Ciara noticed that when porting XSK code to use libxdp inste=
ad
> of libbpf as part of the deprecation, libbpf would output messages like:
>
> libbpf: elf: skipping unrecognized data section(7) .xdp_run_config
> libbpf: elf: skipping unrecognized data section(8) xdp_metadata
> libbpf: elf: skipping unrecognized data section(8) xdp_metadata
> libbpf: elf: skipping unrecognized data section(8) xdp_metadata
>
> In light of this, let's demote the message severity back down to debug so
> that it won't clutter up the default output of applications.
>
> Cc: Magnus Karlsson <magnus.karlsson@intel.com>
> Reported-by: Ciara Loftus <ciara.loftus@intel.com>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---
>  tools/lib/bpf/libbpf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index a1bea1953df6..ac0eadbe1475 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -3297,8 +3297,8 @@ static int bpf_object__elf_collect(struct bpf_objec=
t *obj)
>                                 obj->efile.st_ops_data =3D data;
>                                 obj->efile.st_ops_shndx =3D idx;
>                         } else {
> -                               pr_info("elf: skipping unrecognized data =
section(%d) %s\n",
> -                                       idx, name);
> +                               pr_debug("elf: skipping unrecognized data=
 section(%d) %s\n",
> +                                        idx, name);
>                         }
>                 } else if (sh->sh_type =3D=3D SHT_REL) {
>                         int targ_sec_idx =3D sh->sh_info; /* points to ot=
her section */
> --
> 2.33.0
>
