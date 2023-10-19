Return-Path: <bpf+bounces-12726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2DB7D01AB
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 20:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EB12282295
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 18:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9D537160;
	Thu, 19 Oct 2023 18:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIUI8m4I"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AF139843
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 18:34:32 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B66CA
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 11:34:30 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53e751aeb3cso9784758a12.2
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 11:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697740468; x=1698345268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMex6c7h+ajJVUsiuFQXxmNwvgRXAkQUkLGvfmJBjYc=;
        b=WIUI8m4Iaiym4y7+Aox9Jmz4NYxuOquCJLS4TM8twuNW7RGbgN+1fWJbGaUjBxjjuO
         zoznB30s8oNZFTRgVhvu3svlwPzAHC55HwKMkJo3fLv27z1QBjzUyWhBPfcfy/m0NmM7
         ZtVo7jfzcgCyZDPK491L2x3M6VML+bw/sPt7IyYSj2i+Po8U+UjCDBiFFGf4uF7LQtQy
         gKi8T54PsjGV1mWd02FivWrojIZQYqUbDFPgb7rmnfjFpLKJjxlTxVCS/h1g3sW6vfNk
         NqZ7+GpS6OSkO7qKNhE27OO8s0NuCNFa0jIK31nb+1rgTtaCVftCnWlYkTmvwsVkeHxv
         Qn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697740468; x=1698345268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMex6c7h+ajJVUsiuFQXxmNwvgRXAkQUkLGvfmJBjYc=;
        b=hp0mKrslNdQcbihYtW4GN5NMI4SOOYV0Nn/vepemmwQtFE2FH71UTJptpmMVEizoI7
         XNiNLdJr2qweI2JeA9b8Z//OMdLO/EqSitw5yh72DWGiPpvDVkzC98IPF/bnRfSAnimB
         3ZtoW0/gu/de4DXdI1lhOkJTJfz3iNus/NATPtFG0S8j33v7M9BwKbcHZtJqBopnL2uf
         nISks4amdgVoPHISH4QN+pVNcX5eztOD/f+CEzJG9TuRveA25D3b6AhdF6iWBCELfWrh
         fHt1mTrSMixEDUAs2L3HiZPLCBqqz+BqHXTAoTyihP+Ag0FuVopOMMxU4HioeUnT6gCM
         M//A==
X-Gm-Message-State: AOJu0YzZnD4LU0euPOCzt9Mbl+SzF5neJ1rkwgrl9QrjsBZWfpfEsUln
	ExwdvFDFoY0wag0rfB0EFyz7p/sEX3WG6ABSzFg=
X-Google-Smtp-Source: AGHT+IEEDo08iJKAoiVfEBxAb20SSXPWpSAk4MbMJjUWrLEEK8mZCnoILhgvNtU6KNaH54x4s18FwhwYcnIaj+RdWQ0=
X-Received: by 2002:a05:6402:5106:b0:53d:a4e5:67d0 with SMTP id
 m6-20020a056402510600b0053da4e567d0mr2287287edd.13.1697740468460; Thu, 19 Oct
 2023 11:34:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231019042405.2971130-1-andrii@kernel.org> <20231019042405.2971130-8-andrii@kernel.org>
 <ZTDbGWHu4CnJYWAs@u94a> <ZTDgIyzBX9oZNeFw@u94a>
In-Reply-To: <ZTDgIyzBX9oZNeFw@u94a>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 19 Oct 2023 11:34:17 -0700
Message-ID: <CAEf4BzYgJR6SAjbvd0uZ6w8D37Sy=Wjd2TROOGEAZDiEq7xb2g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 7/7] selftests/bpf: BPF register range bounds tester
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Langston Barrett <langston.barrett@gmail.com>, 
	Srinivas Narayana <srinivas.narayana@rutgers.edu>, 
	Santosh Nagarakatte <santosh.nagarakatte@cs.rutgers.edu>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 12:52=E2=80=AFAM Shung-Hsi Yu <shung-hsi.yu@suse.co=
m> wrote:
>
> On Thu, Oct 19, 2023 at 03:30:33PM +0800, Shung-Hsi Yu wrote:
> > On Wed, Oct 18, 2023 at 09:24:05PM -0700, Andrii Nakryiko wrote:
> > > Add tests that validate correctness and completeness of BPF verifier'=
s
> > > register range bounds.
> >
> > Nitpick: in abstract-interpretation-speak, completeness seems to mean
> > something different. I believe what we're trying to check here is
> > soundness[1], again, in abstraction-interpretation-speak), so using
> > completeness here may be misleading to some. (I'll leave explanation to
> > other that understand this concept better than I do, rather than making=
 an
> > ill attempt that would probably just make things worst)
> >
> > > The main bulk is a lot of auto-generated tests based on a small set o=
f
> > > seed values for lower and upper 32 bits of full 64-bit values.
> > > Currently we validate only range vs const comparisons, but the idea i=
s
> > > to start validating range over range comparisons in subsequent patch =
set.
> >
> > CC Langston Barrett who had previously send kunit-based tnum checks[2] =
a
> > while back. If this patch is merged, perhaps we can consider adding
> > validation for tnum as well in the future using similar framework.
> >
> > More comments below
> >
> > > When setting up initial register ranges we treat registers as one of
> > > u64/s64/u32/s32 numeric types, and then independently perform conditi=
onal
> > > comparisons based on a potentially different u64/s64/u32/s32 types. T=
his
> > > tests lots of tricky cases of deriving bounds information across
> > > different numeric domains.
> > >
> > > Given there are lots of auto-generated cases, we guard them behind
> > > SLOW_TESTS=3D1 envvar requirement, and skip them altogether otherwise=
.
> > > With current full set of upper/lower seed value, all supported
> > > comparison operators and all the combinations of u64/s64/u32/s32 numb=
er
> > > domains, we get about 7.7 million tests, which run in about 35 minute=
s
> > > on my local qemu instance. So it's something that can be run manually
> > > for exhaustive check in a reasonable time, and perhaps as a nightly C=
I
> > > test, but certainly is too slow to run as part of a default test_prog=
s run.
> >
> > FWIW an alternative approach that speeds things up is to use model chec=
kers
> > like Z3 or CBMC. On my laptop, using Z3 to validate tnum_add() against =
*all*
> > possible inputs takes less than 1.3 seconds[3] (based on code from [1]
> > paper, but I somehow lost the link to their GitHub repository).
>
> Found it. For reference, code used in "Sound, Precise, and Fast Abstract
> Interpretation with Tristate Numbers"[1] can be found at
> https://github.com/bpfverif/tnums-cgo22/blob/main/verification/tnum.py
>
> Below is a truncated form of the above that only check tnum_add(), requir=
es
> a package called python3-z3 on most distros:

Great! I'd be curious to see how range tracking logic can be encoded
using this approach, please give it a go!

>
>   #!/usr/bin/python3
>   from uuid import uuid4
>   from z3 import And, BitVec, BitVecRef, BitVecVal, Implies, prove
>
>   SIZE =3D 64 # Working with 64-bit integers
>
>   class Tnum:
>       """A model of tristate number use in Linux kernel's BPF verifier.
>       https://github.com/torvalds/linux/blob/v5.18/kernel/bpf/tnum.c
>       """
>       val: BitVecRef
>       mask: BitVecRef
>
>       def __init__(self, val=3DNone, mask=3DNone):
>           uid =3D uuid4() # Ensure that the BitVec are uniq, required by =
the Z3 solver
>           self.val =3D BitVec(f'Tnum-val-{uid}', bv=3DSIZE) if val is Non=
e else val
>           self.mask =3D BitVec(f'Tnum-mask-{uid}', bv=3DSIZE) if mask is =
None else mask
>
>       def contains(self, bitvec: BitVecRef):
>           # Simplified version of tnum_in()
>           # https://github.com/torvalds/linux/blob/v5.18/kernel/bpf/tnum.=
c#L167-L173
>           return (~self.mask & bitvec) =3D=3D self.val
>
>       def wellformed(self):
>           # Bit cannot be set in both val and mask, such tnum is not vali=
d
>           return self.val & self.mask =3D=3D BitVecVal(0, bv=3DSIZE)
>
>   # The function that we want to check
>   def tnum_add(a: Tnum, b: Tnum):
>       # Unmodified tnum_add()
>       # https://github.com/torvalds/linux/blob/v5.18/kernel/bpf/tnum.c#L6=
2-L72
>       sm =3D a.mask + b.mask
>       sv =3D a.val + b.val
>       sigma =3D sm + sv
>       chi =3D sigma ^ sv
>       mu =3D chi | a.mask | b.mask
>       return Tnum(sv & ~mu, mu)
>
>   t1 =3D Tnum()
>   t2 =3D Tnum()
>
>   x =3D BitVec('x', bv=3DSIZE) # Any possible 64-bit value
>   y =3D BitVec('y', bv=3DSIZE) # same as above
>
>   # Condition that needs to hold before we move forward to check tnum_add=
()
>   premises =3D And(
>       t1.wellformed(), # t1 and t2 is wellformed
>       t2.wellformed(),
>       t1.contains(x), # x is within t1, and y is within t2
>       t2.contains(y),
>   )
>
>   # This ask Z3 solver to prove that tnum_add() work as intended
>   prove(
>       Implies(
>           # Assuming that t1 and t2 is wellformed, x is within t1, and y =
is
>           # within t2
>           premises,
>           # Below is what we'd like to check. Namely, for any random x wh=
os
>           # value is within t1, and any random y whos value is within t2,
>           # (x+y) is always within the tnum produced by tnum_add(t1, t2)
>           tnum_add(t1, t2).contains(x+y),
>       )
>   )
>
> > One of the potential issue with [3] is that Z3Py is written in Python. =
So
> > there's the large over head of translating the C-implementation into Py=
thon
> > using Z3Py APIs each time we changed relevant code. This overhead could
> > potentially be removed with CBMC, which understand C, and we had a
> > precedence of using CBMC[4] within the kernel source code, though it wa=
s
> > later removed[5] due because SRCU changes are still happening too fast =
for
> > the format tests to keep up, so it looks like CBMC is not a silver-bull=
et.
> >
> > I really meant to look into the CMBC approach for verification of range=
s and
> > tnum, but fails to allocate time for it, so far.
> >
> > Shung-Hsi
> >
> > > ...
> >
> > 1: https://people.cs.rutgers.edu/~sn349/papers/cgo-2022.pdf
> > 2: https://lore.kernel.org/bpf/20220430215727.113472-1-langston.barrett=
@gmail.com/
> > 3: https://gist.github.com/shunghsiyu/a63e08e6231553d1abdece4aef29f70e
> > 4: https://lore.kernel.org/all/1485295229-14081-3-git-send-email-paulmc=
k@linux.vnet.ibm.com/
>
> Also forgot to add the link to the removal of SRCU formal-verification te=
sts
>
> 5: https://lore.kernel.org/all/20230717182337.1098991-2-paulmck@kernel.or=
g/

