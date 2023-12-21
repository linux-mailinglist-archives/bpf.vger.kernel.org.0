Return-Path: <bpf+bounces-18482-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 251B881ADEF
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 05:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4992A1C23026
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 04:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6A06FDC;
	Thu, 21 Dec 2023 04:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6K+wXZr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7928BED
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 04:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-40d3c4bfe45so3893385e9.1
        for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 20:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703132888; x=1703737688; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3SHK15C4+F1s1p/ugEHWAORAMtRvRHufco/NTVlRQ5Y=;
        b=j6K+wXZrJKxM5wmBqiPkiobyaiNsyw3pXY7EygYhZMM0T90mpmJHoOAXIuqsQCX5Hj
         wmfhc7BDSP9oJIladfMfOn16jLJOMB8eT1+WelvdVgm0vwjmdBCnBAEP3VEUQTrJcyqj
         QpENf6pA5Y4p3L0P9s5GODr7pShS78ytm96kHZ8loxyTT4iebRhzD5FG3Hjm2OarX2lL
         6ILyL0z8+/hIhD3Kpve6n9i3hJG2FTMPAftbKZGTQZPbQfh0DDzaPVpQoBctkO/fWLN1
         cMhfrTcWdbzvL74H0+AP7pLrXBQn3nM/OBRV48vwMZfH3fhaRYkP+HItiKHZyjhrIOSc
         LBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703132888; x=1703737688;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3SHK15C4+F1s1p/ugEHWAORAMtRvRHufco/NTVlRQ5Y=;
        b=Rbs4tBvk/Lf7ORyGH6uP/qRAeo/JrsuONTPdnIN9JTaUDuHzaaM9h3ZTsLIHDHBBbH
         Urvi8qHZ1mWacKrWY2anXNSBl+ouToRc9bn61WaWC1XPuE73BgbDtGsJi0O35P1x4/hW
         rCAyh9gKj+Q1sYKAzkFXow56UDJo9MeA6HHOiLFla1ECXxoWH7Z06u8nOz7tK0mR7suc
         wYp08Ul6JDke95lofEpSap4kh71jgsKS1XMkivftvVxMBta75IL+MyhPzocBWtrDZaEB
         HAgyQgIUpQ9GprPLBhE+h9/2HRylt1NR9k5sIdLp7A1xf2BMf4eNykQh2Ha2U8B4FRBv
         H25w==
X-Gm-Message-State: AOJu0YwJGwaB8a6jgNxZAsFJQ/cIQj6nRW00dmhwwNdRUL97oIxR9e4q
	apghYe10WQIg/D/5kkJGt2JH48qGRCpqEOoKGUo=
X-Google-Smtp-Source: AGHT+IHopIx3yw3V07OMXTsZpSUImy5JyEB9to4EhMPeOz9CtCei+E0pU1bKuH1NylO4BXc/tSP2mii4qgkwNA30b5k=
X-Received: by 2002:a05:600c:3f94:b0:40c:4a25:8cfb with SMTP id
 fs20-20020a05600c3f9400b0040c4a258cfbmr168182wmb.226.1703132888313; Wed, 20
 Dec 2023 20:28:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221033854.38397-1-alexei.starovoitov@gmail.com> <20231221033854.38397-3-alexei.starovoitov@gmail.com>
In-Reply-To: <20231221033854.38397-3-alexei.starovoitov@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 21 Dec 2023 05:27:31 +0100
Message-ID: <CAP01T77fbW-9N+Z-2LFS=174HN6v_OJAbR_s6EOfLLW8Oceh_g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/5] bpf: Introduce "volatile compare" macro
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	dxu@dxuuu.xyz, john.fastabend@gmail.com, bpf@vger.kernel.org, 
	kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Dec 2023 at 04:39, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Compilers optimize conditional operators at will, but often bpf programmers
> want to force compilers to keep the same operator in asm as it's written in C.
> Introduce bpf_cmp(var1, conditional_op, var2) macro that can be used as:
>
> -               if (seen >= 1000)
> +               if (bpf_cmp(seen, >=, 1000))
>
> The macro takes advantage of BPF assembly that is C like.
>
> The macro checks the sign of variable 'seen' and emits either
> signed or unsigned compare.
>
> For example:
> int a;
> bpf_cmp(a, >, 0) will be translated to 'if rX s> 0 goto' in BPF assembly.
>
> unsigned int a;
> bpf_cmp(a, >, 0) will be translated to 'if rX > 0 goto' in BPF assembly.
>
> C type conversions coupled with comparison operator are tricky.
>   int i = -1;
>   unsigned int j = 1;
>   if (i < j) // this is false.
>
>   long i = -1;
>   unsigned int j = 1;
>   if (i < j) // this is true.
>
> Make sure BPF program is compiled with -Wsign-compare then the macro will catch
> the mistake.
>
> The macro checks LHS (left hand side) only to figure out the sign of compare.
>
> 'if 0 < rX goto' is not allowed in the assembly, so the users
> have to use a variable on LHS anyway.
>
> The patch updates few tests to demonstrate the use of the macro.
>
> The macro allows to use BPF_JSET in C code, since LLVM doesn't generate it at
> present. For example:
>
> if (i & j) compiles into r0 &= r1; if r0 == 0 goto
>
> while
>
> if (bpf_cmp(i, &, j)) compiles into if r0 & r1 goto
>
> Note that the macro has to be careful with RHS assembly predicate.
> Since:
> u64 __rhs = 1ull << 42;
> asm goto("if r0 < %[rhs] goto +1" :: [rhs] "ri" (__rhs));
> LLVM will silently truncate 64-bit constant into s32 imm.
>
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Sorry about the delayed feedback on this, I'm knocked out due to flu.

The macro looks very useful and I like the simplification for the
assertion macros, +1, but I would just like to make sure one important
point about this is not missed.

When I was writing the _eq/lt/... variants I noticed that unless I use
LHS to be a full 8-byte register the compiler can still play
shenanigans even with inline assembly, like choosing a different input
register for LHS than the one already allocated for a variable before
the assembly is emitted, doing left/right shifts to mask upper bits
before the inline assembly logic, and thus since the scalar id
association is broken on that, the cmp does not propagate to what are
logical copies.

I noticed it often when say a 8-byte value (known to be small) was
saved as int len = something, asserted upon, and then used later in
the program.

One of the contracts of the bpf_assert_eq* macros compared to just
plain bpf_assert was that the former was supposed to guarantee the
assertion resulted in the verifier preserving the new knowledge for
the LHS variable.

So maybe in addition to using bpf_cmp, we should instead do a
bpf_assert_op as a replacement that enforces this rule of LHS being 8
byte (basically just perform __bpf_assert_check) before dispatching to
the bpf_cmp.
WDYT? Or just enforce that in bpf_cmp (but that might be too strict
for general use of bpf_cmp on its own, so might be better to have a
separate macro).

Apart from that, consider
Acked-by: Kumar Kartikeya Dwivedi <memor@gmail.com>
for the whole set.

