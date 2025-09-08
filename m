Return-Path: <bpf+bounces-67691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3646BB48372
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 06:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2BDD17B5E1
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 04:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C202B221F24;
	Mon,  8 Sep 2025 04:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OvrR2BLO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BA622068F
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 04:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757307186; cv=none; b=amUb5qz8sRuSc738DTk+bmopGWh8g/5IMRnZx2Xs8QRYZIJ5ruxdbCJnh3MZv/D1SX2d10RXjY6ALM8+nayyXSqWHd0Q6I56cADQCl5l/KBCJdABitxYck//Qzi3Y/L+c79AB6dBNdP1AfSTuC9viDji82vbbCkRypgVjb6MIF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757307186; c=relaxed/simple;
	bh=bDe+oTYGKqXjGMV4wp7YuUQnt6EQO3MgnrAA2FmUPSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PxGUlQkUaVdgon0SI4hhExr+dgMh0+vGjwJWHGTwU9abnq14JKfAp5pQFTELPnDzbsDuxeubNESbPw/OhZ/uWByUXCAE8Pwb3H/SZIVBEjRWDpozPYjRsF5yQ4WerNVZN6XmriDc2Ece70XYQk9jd2FAOCUG7Sz3nXJEeai1vDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OvrR2BLO; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55f6507bd53so4132158e87.3
        for <bpf@vger.kernel.org>; Sun, 07 Sep 2025 21:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757307181; x=1757911981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0LQRdujQ1u5i3dMocHWaRijeaazzWqp3JpjpzSpfTs=;
        b=OvrR2BLOKY3EdYdhLJe6CXTFpBVLOSEWHKUC5IFiR6z3pYS3ndrm7mbo5UVPJe+rq1
         MKuvf0uTaB2C7Itm1zlsoy8JBr3X7+VbiWvPsgYdx8ubSTcgrOPd9yd8PmDykrkSHIX3
         aSrlIqyiI762F8A2k4NAUZ1hfA4IJJv7/vyY/WSKZcnQNN712yGtqSbV9OjQ/Y/UQEVU
         EdmByaVB5mKmKLksCA6eEmxK1djwknjKmoiUz1mbz9IDHfRM/8K/PmUWN8Dq9SQp8UOM
         hHOkj99naWc76EetRuHUaLg8r5UjkjG84NL3Y7Uz5yCA3VvkVAcn1MxZM1LqCznDYTV+
         w88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757307181; x=1757911981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0LQRdujQ1u5i3dMocHWaRijeaazzWqp3JpjpzSpfTs=;
        b=NowJVovQpu06r8Qm5v/JsUNpPT6qRHfG+KL3epPhxjC/Kd2p/Ncv3VonwIN/6Dh0RS
         B8JbA1BmxhF8dvq8zID8nAEe4ULJb5LIFowi3aTqiTz8ETRWYelpitqj7EGkxotctO4i
         T6lvHjgvUMc6qAWTeUfowZW5U6O4N9ymwMegqkd6biPi9+BV5ieNxYZNbjVj+mlmFmmj
         YEw3M+AjJShOe3wPDVreAMYMBHzl7J+wH75iraKs7lSFxIxFkDXASQzys34/libGs9DX
         l37eJwOYu6MOA3AQRl4MME8HqOmXN2UHYfR0xSz7nTUoiCloYJbeCxcv4VfxbYPI4QYm
         JigA==
X-Forwarded-Encrypted: i=1; AJvYcCXytRWAn6h/GAUKdNIh+QwCJP0XUcuZKbCQLi14H+PDNlw1Os4hulKe6fYgM54mapmuUng=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOXy9zzLe1g29Ic9LM0Ot1vCEd6HYrNs4+l5W+wlaq2aC9XbU9
	chJwamuikpfJpcAvqpnZpPdIOKzYtBQlp1Ru9X8cOl1Hk8FGgursrO/zKJnc9ZKxl353JNHIzbv
	9oRS62wdK0r0uPb3agmAUE6gX50ktx2YVePG+pqFn0w==
X-Gm-Gg: ASbGnctq03uUr4WJUhT//KSNG2ZP2IEZA21W0GCBMyycsDxlbCpKHFRovqW7aSbBw8O
	F57nYxlcuBwYmld1WJoCHVyPYJmdsMBBD9oTwkMsd1vmVBq+XZ16Oyrq4SbA+iEHb15yzTEUsOk
	NOHTkxFa13n2gSiV7CBeg9ZC1I9XuCTMC15mrTR51bapYpQUS1qalSqyBo3LaMD+Pz17z5ztUdw
	MUSaxCBag==
X-Google-Smtp-Source: AGHT+IHxXLO5818IAl84YgA429XsjCrhQ6IpQWvHITxDvO0Bh1WFz8eatiEe2fDrdys1G9BvlpoubANjqZaXwesA6F0=
X-Received: by 2002:a05:6512:3994:b0:55f:503c:d322 with SMTP id
 2adb3069b0e04-56262d25d4cmr1628803e87.40.1757307181253; Sun, 07 Sep 2025
 21:53:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905051814.291254-1-hoyeon.lee@suse.com> <20250905051814.291254-2-hoyeon.lee@suse.com>
 <ca64e62b-740e-4e02-a386-e1016317b071@linux.dev>
In-Reply-To: <ca64e62b-740e-4e02-a386-e1016317b071@linux.dev>
From: Hoyeon Lee <hoyeon.lee@suse.com>
Date: Mon, 8 Sep 2025 13:52:44 +0900
X-Gm-Features: AS18NWA2MVgylLhC0njVFDJTRSD1Ojs9kXNWbK9lirR8SrUSG1IIQiLIrUb8d7Q
Message-ID: <CAK7-dKZ9fP=2u+-KtwqFiA0SYP-0OUrREjESwvM_vwT4St8ZyA@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 1/1] libbpf: add compile-time OOB warning to bpf_tail_call_static
To: Yonghong Song <yonghong.song@linux.dev>
Cc: netdev@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	"open list:BPF [LIBRARY] (libbpf)" <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 6, 2025 at 12:55=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
> On 9/4/25 10:18 PM, Hoyeon Lee wrote:
> > Add a compile-time check to bpf_tail_call_static() to warn when a
> > constant slot(index) >=3D map->max_entries. This uses a small
> > BPF_MAP_ENTRIES() macro together with Clang's diagnose_if attribute.
> >
> > Clang front-end keeps the map type with a '(*max_entries)[N]' field,
> > so the expression
> >
> >      sizeof(*(m)->max_entries) / sizeof(**(m)->max_entries)
> >
> > is resolved to N entirely at compile time. This allows diagnose_if()
> > to emit a warning when a constant slot index is out of range.
> >
> > Out-of-bounds tail calls are currently silent no-ops at runtime, so
> > emitting a compile-time warning helps detect logic errors earlier.
> > This is currently limited to Clang (due to diagnose_if) and only for
> > constant indices, but should still catch the common cases.
> >
> > Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
> > ---
> > Changes in V2:
> > - add function definition for __bpf_tail_call_warn for compile error
> >
> >   tools/lib/bpf/bpf_helpers.h | 21 +++++++++++++++++++++
> >   1 file changed, 21 insertions(+)
> >
> > diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> > index 80c028540656..98bc1536c497 100644
> > --- a/tools/lib/bpf/bpf_helpers.h
> > +++ b/tools/lib/bpf/bpf_helpers.h
> > @@ -173,6 +173,27 @@ bpf_tail_call_static(void *ctx, const void *map, c=
onst __u32 slot)
> >                    :: [ctx]"r"(ctx), [map]"r"(map), [slot]"i"(slot)
> >                    : "r0", "r1", "r2", "r3", "r4", "r5");
> >   }
> > +
> > +#if __has_attribute(diagnose_if)
> > +static __always_inline void __bpf_tail_call_warn(int oob)
> > +     __attribute__((diagnose_if(oob, "bpf_tail_call: slot >=3D max_ent=
ries",
> > +                                "warning"))) {};
> > +
> > +#define BPF_MAP_ENTRIES(m) \
> > +     ((__u32)(sizeof(*(m)->max_entries) / sizeof(**(m)->max_entries)))
> > +
> > +#ifndef bpf_tail_call_static
> > +#define bpf_tail_call_static(ctx, map, slot)                          =
     \
> > +({                                                                    =
     \
> > +     /* wrapped to avoid double evaluation. */                        =
     \
> > +     const __u32 __slot =3D (slot);                                   =
       \
> > +     __bpf_tail_call_warn(__slot >=3D BPF_MAP_ENTRIES(map));          =
       \
> > +     /* Avoid re-expand & invoke original as (bpf_tail_call_static)(..=
) */ \
> > +     (bpf_tail_call_static)(ctx, map, __slot);                        =
     \
> > +})
> > +#endif /* bpf_tail_call_static */
> > +#endif
>
> I got the following error with llvm21.
>
> progs/tailcall_bpf2bpf3.c:20:3: error: bpf_tail_call: slot >=3D max_entri=
es [-Werror,-Wuser-defined-warnings]
>     20 |                 bpf_tail_call_static(skb, &jmp_table,progs/tailc=
all_bpf2bpf2.c:17:3 10);
>        | :                ^
>   /home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/include/bpf/b=
pf_helpers.h:190:53: note: expanded from macro
>        'bpf_tail_call_static'
>    190 |         __bpf_tail_call_warn(__slot >=3D BPF_MAP_ENTRIES(map)); =
                \
>        |                                                            ^
> /home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/include/bpf/bpf=
_helpers.h:179:17: note: from 'diagnose_if'
>        attribute on '__bpf_tail_call_warn':
>    179 |         __attribute__((diagnose_if(oob, "bpf_tail_call: slot >=
=3D max_entries",
>        |                        ^           ~~~
> error: bpf_tail_call: slot >=3D max_entries [-Werror,-Wuser-defined-warni=
ngs]
>     17 |                 bpf_tail_call_static(skb, &jmp_table, 1);
>        |                 ^
> /home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/include/bpf/bpf=
_helpers.h:190:53: note: expanded from macro
>        'bpf_tail_call_static'
>    190 |         __bpf_tail_call_warn(__slot >=3D BPF_MAP_ENTRIES(map)); =
                \
>        |                                                            ^
> /home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/include/bpf/bpf=
_helpers.h:179:17: note: from 'diagnose_if'
>        attribute on '__bpf_tail_call_warn':
>    179 |         __attribute__((diagnose_if(oob, "bpf_tail_call: slot >=
=3D max_entries",
>        |                        ^           ~~~
>    CLNG-BPF [test_progs] tailcall_poke.bpf.o
> 1 error generated.
> make: *** [Makefile:733: /home/yhs/work/bpf-next/tools/testing/selftests/=
bpf/tailcall_bpf2bpf3.bpf.o] Error 1
>

Thank you for sharing build results! Checked BPF CI, and found 2 issues:

1. selftests/bpf promote warnings to errors (-Werror)
For bpf2bpf tail-call variant progs that intentionally calls OOB trigger
this diagnostic, relaxing just those files keeps CI green while still
showing the warning:

        # tools/testing/selftests/bpf/Makefile
        progs/tailcall_bpf2bpf%.c-CFLAGS :=3D -Wno-error=3Duser-defined-war=
nings

2. 'void *' maps build error  (bpf2bpf / map-in-map)
The proposed warning is meant only for typed .maps objects. When a prog
passes a void * map, BPF_MAP_ENTRIES() must not attempt member
access. A _Generic gate fixes this by filtering only for typed maps and
yielding 0U for void* families:

        # from BPF-CI build error
        # function prototype:
        #         int subprog_tail(struct __sk_buff *skb, void *jmp_table)
        progs/tailcall_bpf2bpf_hierarchy3.c:36:2: error: member
reference base type 'void' is not a structure or union
          36 | bpf_tail_call_static(skb, jmp_table, 0);
               | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

fixes:

        #define BPF_MAP_ENTRIES(m) _Generic((m), \
               void *:                 0U,      \
               const void *:           0U,      \
               volatile void *:        0U,      \
               const volatile void *:  0U,      \
               default:
((__u32)(sizeof(*(m)->max_entries) / sizeof(**(m)->max_entries))) \
       )

This avoids the compile error, but this is not a very clean solution.

As Andrii Nakryiko noted, map->max_entries can be changed at runtime,
which makes this compile-time approach misleading. I hadn=E2=80=99t conside=
red
that, so this RFC seems less practical to pursue further. Still, I=E2=80=99=
m
sharing the troubleshooting above in case parts of it may be useful for
future attempts.


> > +
> >   #endif
> >   #endif
> >
> > --
> > 2.51.0
>

