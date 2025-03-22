Return-Path: <bpf+bounces-54572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2618A6CB11
	for <lists+bpf@lfdr.de>; Sat, 22 Mar 2025 16:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C9C21B872D1
	for <lists+bpf@lfdr.de>; Sat, 22 Mar 2025 14:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A106F22F160;
	Sat, 22 Mar 2025 14:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zz/9oNGo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C9622D7A1;
	Sat, 22 Mar 2025 14:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742655047; cv=none; b=Br1L1zj9waR1vh9tmGfQvfdjMy+ybGJJQIxoHdT8Hig1v6PfTdnmMX2xZCU+Xsochm5Tw3RqvRF9N3z9/VWKKFtUU2gfcmltc37axsI7dUFHvzUmRBSlg815Vj00CigQwKaZCUnE+0YU3zMA9awVJoWHsBBmwrTslE1jkVFWF7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742655047; c=relaxed/simple;
	bh=MRoAVc2GDCJCO/s0k4oaM7vuQUpM1BiL16QTCzZwOdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q1q0fAvkouzcxYBKcZvTrKC1moDavkb39WxBS89U2LVDySWGaFYbiXGuP8pTspc/SfrWiPvYVZdwIWYLsAdOtSfR4A84FiRmtyXYKqP6vrSzdxu4n7ChoI5HNmjdx+ZydcaiScdQgapPKruBvZCG4v3wNQ2uMeCGx+Qh8pJMaU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zz/9oNGo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A150EC4CEDD;
	Sat, 22 Mar 2025 14:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742655046;
	bh=MRoAVc2GDCJCO/s0k4oaM7vuQUpM1BiL16QTCzZwOdQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Zz/9oNGodvJX6CxhRbiX/ESk4X/siHPrlbtUTAz6w+P/AZgwBRmrPu2UMFlgXKKDm
	 UYmoV1TXRAdZY0oRbQNM3qXXvkfSXEcL90fmNFe9IPUdWfYdZ6h09QUy5gLLIefdXk
	 ai5Wtl/+hmefJhy2HBZDjTyy5koN5Ne1w2x0jcU9UvCHPhtODjLzUlcdBzQng1WIIa
	 LLVY9CfYyFRdPZV5tOTzbZtftcYD5mtAtFM35SvvhzVhStAGm9o8c+qkjDy32FGUU+
	 McFfO+ojOmdnhwqhDRTegI82KYM+c171UA3dBV11bnfOGP3sE6WcBwxVPmdVg9gpPO
	 UOiz1kGlFLPuw==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30c2d427194so31489201fa.0;
        Sat, 22 Mar 2025 07:50:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVPicXoo76ptE1b++5Hj+qgFnW/1WDx0GUt+bFzq8uQhGBL4P5aSwlvHHFAxDej6iVeQzE=@vger.kernel.org, AJvYcCVzruTomzDCyl6XXXLjDAv2fSwR4tRansT7y1+VDsgVeWMOq2SCsFXPCqvnFMs+uoNiKwEybE/5cgAvxj1n@vger.kernel.org, AJvYcCW/AowKlxuc6x0qAldQUCEzbE7KYw+G3WUql7hiF2p0hPlujRHJwcZcNhbVZHSlPqxThoWMhay4CjIu+NwD@vger.kernel.org
X-Gm-Message-State: AOJu0YyTLPzoQWkMAiEx6Pfe0uHbimQRoFKT+JS1m2KnRl12u+51jUy/
	DfEw2yQUxkZ4y8ft0pnxQfVzr6AfLhlZnXF+koMDoXRraqLK/i/LsrRqjNIqVUAcPMts5pOyxp/
	J0+P5+NPqwJjMiO0lrx+oPv3HCxA=
X-Google-Smtp-Source: AGHT+IEPyO40RHCkLyep+QoZo8ZSD7sl3b6ajVdYBN9FpCfSyatfhQvpbVV5r8atteZQ5BPsfIfnbfg4mVa5S/o2PPU=
X-Received: by 2002:a2e:a595:0:b0:30c:4be7:1d42 with SMTP id
 38308e7fff4ca-30d7e2226b8mr23222091fa.12.1742655045343; Sat, 22 Mar 2025
 07:50:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211002930.1865689-1-masahiroy@kernel.org> <CAD=FV=V19pgzU8NSyWwHSEs85kU_Fbofcn8uJVj-TE2DNKfUHQ@mail.gmail.com>
In-Reply-To: <CAD=FV=V19pgzU8NSyWwHSEs85kU_Fbofcn8uJVj-TE2DNKfUHQ@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 22 Mar 2025 23:50:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQX03w=AVkntA=8KmSAmX91Z3BdB4Z8H5oDt3iPsJNXfg@mail.gmail.com>
X-Gm-Features: AQ5f1Jp60oEhyRreLddsPUneE01Rm0Mr3qS0ImcRA2yELUdXSRJR5g-xQkGj3ys
Message-ID: <CAK7LNAQX03w=AVkntA=8KmSAmX91Z3BdB4Z8H5oDt3iPsJNXfg@mail.gmail.com>
Subject: Re: [PATCH] tools: fix annoying "mkdir -p ..." logs when building
 tools in parallel
To: Doug Anderson <dianders@chromium.org>
Cc: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>, 
	linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Borislav Petkov <bp@suse.de>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	bpf@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 1:41=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Mon, Feb 10, 2025 at 4:30=E2=80=AFPM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
> > When CONFIG_OBJTOOL=3Dy or CONFIG_DEBUG_INFO_BTF=3Dy, parallel builds
> > show awkward "mkdir -p ..." logs.
> >
> >   $ make -j16
> >     [ snip ]
> >   mkdir -p /home/masahiro/ref/linux/tools/objtool && make O=3D/home/mas=
ahiro/ref/linux subdir=3Dtools/objtool --no-print-directory -C objtool
> >   mkdir -p /home/masahiro/ref/linux/tools/bpf/resolve_btfids && make O=
=3D/home/masahiro/ref/linux subdir=3Dtools/bpf/resolve_btfids --no-print-di=
rectory -C bpf/resolve_btfids
> >
> > Defining MAKEFLAGS=3D<value> on the command line wipes out command line
> > switches from the resultant MAKEFLAGS definition, even though the comma=
nd
> > line switches are active. [1]
> >
> > The first word of $(MAKEFLAGS) is a possibly empty group of characters
> > representing single-letter options that take no argument. However, this
> > breaks if MAKEFLAGS=3D<value> is given on the command line.
> >
> > The tools/ and tools/% targets set MAKEFLAGS=3D<value> on the command
> > line, which breaks the following code in tools/scripts/Makefile.include=
:
> >
> >     short-opts :=3D $(firstword -$(MAKEFLAGS))
> >
> > If MAKEFLAGS really needs modification, it should be done through the
> > environment variable, as follows:
> >
> >     MAKEFLAGS=3D<value> $(MAKE) ...
> >
> > That said, I question whether modifying MAKEFLAGS is necessary here.
> > The only flag we might want to exclude is --no-print-directory, as the
> > tools build system changes the working directory. However, people might
> > find the "Entering/Leaving directory" logs annoying.
> >
> > I simply removed the offending MAKEFLAGS=3D.
> >
> > [1]: https://savannah.gnu.org/bugs/?62469
> >
> > Fixes: a50e43332756 ("perf tools: Honor parallel jobs")
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  Makefile | 9 ++-------
> >  1 file changed, 2 insertions(+), 7 deletions(-)
>
> I happened to sync up to mainline today and noticed that my build was
> broken. I bisected it to this change and reverting this change fixes
> my build on mainline.
>
> In my case I'm building in a ChromeOS environment and using clang as
> my compiler. I'm also cross-compiling an arm64 kernel on x86 host.
> ...but the pure mainline kernel should work there. Presumably the
> environment is a bit different compared to the typical one, though?
>
> The error comes up when doing a clean build and the first error messages =
are:
>
> In file included from libbpf.c:36:
> .../tools/include/uapi/linux/bpf_perf_event.h:14:21: error: field has
> incomplete type
>       'bpf_user_pt_regs_t' (aka 'struct user_pt_regs')
>    14 |         bpf_user_pt_regs_t regs;
>       |                            ^
> .../tools/include/../../arch/arm64/include/uapi/asm/bpf_perf_event.h:7:16=
:
> note: forward
>       declaration of 'struct user_pt_regs'
>     7 | typedef struct user_pt_regs bpf_user_pt_regs_t;
>       |                ^
>
> btf_dump.c:1860:10: error: cast to smaller integer type 'uintptr_t'
> (aka 'unsigned int') from 'const void *'
>       [-Werror,-Wvoid-pointer-to-int-cast]
>  1860 |         return ((uintptr_t)data) % alignment =3D=3D 0;
>       |                 ^~~~~~~~~~~~~~~
> btf_dump.c:2045:4: error: format specifies type 'ssize_t' (aka 'long')
> but the argument has type 'ssize_t' (aka 'int')
>       [-Werror,-Wformat]
>  2044 |                 pr_warn("unexpected elem size %zd for array
> type [%u]\n",
>       |                                               ~~~
>       |                                               %d
>  2045 |                         (ssize_t)elem_size, id);
>       |                         ^~~~~~~~~~~~~~~~~~
> ./libbpf_internal.h:171:52: note: expanded from macro 'pr_warn'
>   171 | #define pr_warn(fmt, ...)       __pr(LIBBPF_WARN, fmt, ##__VA_ARG=
S__)
>       |                                                   ~~~    ^~~~~~~~=
~~~
>
>
> I don't have time to dig right now, but I figured I'd at least post in
> case the problem is obvious to someone else.

I do not understand how to reproduce this.

Your build machine is Chrome OS, or other distributions?
Did you build the upstream kernel or downstream one?
What is the build command?  Just "make" ?









--=20
Best Regards
Masahiro Yamada

