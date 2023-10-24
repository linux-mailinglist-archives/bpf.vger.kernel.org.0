Return-Path: <bpf+bounces-13109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A65F57D4718
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 07:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41FA11F21C7A
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 05:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2A7DF4A;
	Tue, 24 Oct 2023 05:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFl8rFZz"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA1620F7
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 05:52:13 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8BF9D
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 22:52:10 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53db360294fso6331099a12.3
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 22:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698126729; x=1698731529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jcxv0CizIdUDZv3Goq5y80oFQrrrLEPyrYlLwa5ulJk=;
        b=eFl8rFZzBHqiJchDWXwIOnmLEQOCiUyKntD0SO9vlVRvygjelj5+jy2ZlRGeMRxdNA
         p4Cod5MNz/Blzbs1U8lvIxfwG18MFj2qa+MUc/t9N1mrjmEPrQWn32bRxo3QW6V99yp/
         /Z9zec1i4+TiWZzGGrs5o6L7CfmNE/O/MxC7b8ucQiCHp68qpb7m0LagRpyEFvG861Jt
         c3XaTF2HXxl/yY3ephW0UDDGjOTdU+sxTlf9TjuEzatn6x12pLgS6a9XcFsRkk2+vPz2
         +dFKGKdnkOVsZLXb4j4roCbF048yM6RKairAjbzKgTEDqY4w+kyYpbjVnmPErI1rnoF9
         td+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698126729; x=1698731529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jcxv0CizIdUDZv3Goq5y80oFQrrrLEPyrYlLwa5ulJk=;
        b=aw9ux/Uxwc6c0BoIE4BMF0l9MonjqIzkNiXxwxBq5929etuor/6MXpfyqPzyguElsD
         IszDOIxrbxmKCMjBrcizJDOQwRqmV4JmZSQxMD1GClqJ/ZQ6LNpdSSVir2/jPhnBYPym
         ptelNlX7Sqk4SQH6w9kCUap9AVSPYB8Xo9GCpeqI/K3iDksuICLzodCi38amTaygFyxN
         XwPNUZsr/dPYDLXVXQeO3QQdJMOdE3O4TO/z89Bnq2u2Pivm2lfuL0ddz1lHKx5fGh+S
         RdlCbksJhmfBf3SRy3KJ1msFH2CbPr3c6OGi9LTjz3CcUV5Cg/kf42Eq57k9AG1J4/0Q
         Hbdw==
X-Gm-Message-State: AOJu0YxbypCJfsz5TpMvvuZj4tgFOFKODuC49T+tjIjIsMseYmNvxvxs
	VQOac0zzPBuZ8GU5HTO3PHVnciBOr9c63mKHxFc=
X-Google-Smtp-Source: AGHT+IHVzI+LdRIlOQQl889Z5N4Hxvq6Q/zCnWBEMXjRwgjqVZH/70e0RBz1loTWPfXFiAsXBjLnISuRRPbhdv1t66I=
X-Received: by 2002:a50:ab50:0:b0:53d:b7e7:301b with SMTP id
 t16-20020a50ab50000000b0053db7e7301bmr10347777edc.24.1698126728753; Mon, 23
 Oct 2023 22:52:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231019042405.2971130-1-andrii@kernel.org> <20231019042405.2971130-8-andrii@kernel.org>
 <ZTDbGWHu4CnJYWAs@u94a> <ZTDgIyzBX9oZNeFw@u94a> <CAEf4BzYgJR6SAjbvd0uZ6w8D37Sy=Wjd2TROOGEAZDiEq7xb2g@mail.gmail.com>
 <1DA1AC52-6E2D-4CDA-8216-D1DD4648AD55@cs.rutgers.edu> <CAEf4BzbFhA585gSN1YfaDaeEmmUvWSdpMY605fmV_RvSQ7+xeQ@mail.gmail.com>
 <ZTZ9tYlVgt9DVcgi@u94a> <ZTaWo7ZUv9jrfIa4@Mem> <CAEf4BzbJ3hZCSt4nLCZCV4cxV60+kddiSMsy7-9ou_RaQV7B8A@mail.gmail.com>
In-Reply-To: <CAEf4BzbJ3hZCSt4nLCZCV4cxV60+kddiSMsy7-9ou_RaQV7B8A@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 23 Oct 2023 22:51:57 -0700
Message-ID: <CAEf4BzZqji_3NvJgkDu3Di6CjWZmyf+N7v=23ayfskEEwZZokA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 7/7] selftests/bpf: BPF register range bounds tester
To: Paul Chaignon <paul@isovalent.com>
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>, 
	Srinivas Narayana Ganapathy <sn624@cs.rutgers.edu>, Andrii Nakryiko <andrii@kernel.org>, 
	Langston Barrett <langston.barrett@gmail.com>, 
	Srinivas Narayana <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte <sn349@cs.rutgers.edu>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "martin.lau@kernel.org" <martin.lau@kernel.org>, 
	"kernel-team@meta.com" <kernel-team@meta.com>, Matan Shachnai <m.shachnai@rutgers.edu>, 
	Harishankar Vishwanathan <harishankar.vishwanathan@rutgers.edu>, 
	Paul Chaignon <paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 3:50=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Oct 23, 2023 at 8:52=E2=80=AFAM Paul Chaignon <paul@isovalent.com=
> wrote:
> >
> > On Mon, Oct 23, 2023 at 10:05:41PM +0800, Shung-Hsi Yu wrote:
> > > On Sat, Oct 21, 2023 at 09:42:46PM -0700, Andrii Nakryiko wrote:
> > > > On Fri, Oct 20, 2023 at 10:37=E2=80=AFAM Srinivas Narayana Ganapath=
y
> > > > <sn624@cs.rutgers.edu> wrote:
> > > > >
> > > > > Hi all,
> > > > >
> > > > > Thanks, @Shung-Hsi, for bringing up this conversation about
> > > > > integrating formal verification approaches into the BPF CI and te=
sting.
> > > > >
> > > > > > On 19-Oct-2023, at 1:34 PM, Andrii Nakryiko <andrii.nakryiko@gm=
ail.com> wrote:
> > > > > > On Thu, Oct 19, 2023 at 12:52=E2=80=AFAM Shung-Hsi Yu <shung-hs=
i.yu@suse.com> wrote:
> > > > > >> On Thu, Oct 19, 2023 at 03:30:33PM +0800, Shung-Hsi Yu wrote:
> >
> > [...]
> >
> > > > > >>> FWIW an alternative approach that speeds things up is to use =
model checkers
> > > > > >>> like Z3 or CBMC. On my laptop, using Z3 to validate tnum_add(=
) against *all*
> > > > > >>> possible inputs takes less than 1.3 seconds[3] (based on code=
 from [1]
> > > > > >>> paper, but I somehow lost the link to their GitHub repository=
).
> > > > > >>
> > > > > >> Found it. For reference, code used in "Sound, Precise, and Fas=
t Abstract
> > > > > >> Interpretation with Tristate Numbers"[1] can be found at
> > > > > >> https://github.com/bpfverif/tnums-cgo22/blob/main/verification=
/tnum.py
> > > > > >>
> > > > > >> Below is a truncated form of the above that only check tnum_ad=
d(), requires
> > > > > >> a package called python3-z3 on most distros:
> > > > > >
> > > > > > Great! I'd be curious to see how range tracking logic can be en=
coded
> > > > > > using this approach, please give it a go!
> > > > >
> > > > > We have some recent work that applies formal verification approac=
hes
> > > > > to the entirety of range tracking in the eBPF verifier. We posted=
 a
> > > > > note to the eBPF mailing list about it sometime ago:
> > > > >
> > > > > [1] https://lore.kernel.org/bpf/SJ2PR14MB6501E906064EE19F5D1666BF=
F93BA@SJ2PR14MB6501.namprd14.prod.outlook.com/T/#u
> > > >
> > > > Oh, I totally missed this, as I just went on a long vacation a few
> > > > days before that and declared email bankruptcy afterwards. I'll try=
 to
> > > > give it a read, though I see lots of math symbols there and make no
> > > > promises ;)
> > >
> > > Feels the same when I start reading their previous work, but I can vo=
uch
> > > their work their work are definitely worth the read. (Though I had to=
 admit
> > > I secretly chant "math is easier than code, math is easier than code"=
 to
> > > convincing my mind to not go into flight mode when seeing math symbol=
s ;D
> >
> > Hari et al. did a great job at explaining the intuitions throughout the
> > paper. So even if you skip the math, you should be able to follow.
> >
> > Having an understanding of abstract interpretation helps. The Mozilla
> > wiki has a great one [1] and I wrote a shorter BPF example of it [2].
> >
> > 1 - https://wiki.mozilla.org/Abstract_Interpretation
> > 2 - https://pchaigno.github.io/abstract-interpretation.html
> >
>
> thanks :)

Hey Paul,

I had a bunch of time on the plane to catch up on reading, so I read
your blog post about PREVAIL among other things. Hopefully you don't
mind some comments posted here.

> Observation 1. The analysis must track binary relations among registers.

It's curious that the BPF verifier in kernel actually doesn't track
relations in this sense, and yet it works for lots and lots of
practical programs. :)


(Speaking of kernel verifier implementation)

> Third, it does not currently support programs with loops.

It does, and I'm not even talking about bounded loops that are
basically unrolled as many times as necessary. We have bpf_loop()
helper calling given callback as many times as requested, but even
better we now have open-coded iterators. Please check selftests using
bpf_for() macro.

Note that Eduard is fixing discovered issues in open-coded iterators
convergence checks and logic, but other than that BPF does have real
loops.


And about a confusing bit at the end:

>  0: r0 =3D 0
>  1: if r1 > 10 goto pc+4  // r1 =E2=88=88 [0; 10]
>  2: if r2 > 10 goto pc+3  // r2 =E2=88=88 [0; 10]
>  3: r1 *=3D r2              // r1 =E2=88=88 [0; 100]
>  4: if r1 !=3D 5 goto pc+1
>  5: r1 /=3D r0              // Division by zero!
>  6: exit
>
> After instruction 2, both r1 and r2 have abstract value [0; 10].
> After instruction 3, r1 holds the multiplication of r1 and r2 and
> therefore has abstract value [0; 100]. When considering the condition at
>  instruction 4, because 11 =E2=88=88 [0; 100], we will walk both paths an=
d hit the
>  division by zero.
>
> Except we know that r1 can never take value 11. The number 11 is a prime
>  number, so it is not a multiple of any integers between 0 and 10.

This made me pause for a while. I think you meant to have `4: if r1 !=3D
11 goto pc+1` and then go on to explain that you can't get 11 by
multiplying numbers in range [0; 10], because 11 is greater than 10
(so can't be 1 x 11), but also it's a prime number, so you can't get
it from multiplication of two integers. So please consider fixing up
the code example, and perhaps elaborate a bit more on why 11 can't
happen in actuality. This example does look a bit academic, but, well,
formal methods and stuff, it's fitting! ;)


> It=E2=80=99s a bit disappointing that the paper doesn=E2=80=99t include a=
ny comparison with the Linux verifier on the same corpus of BPF programs.

Indeed, I concur. It would be interesting to have this comparison as
of the most recent version of PREVAIL and Linux's BPF verifier.


Either way, thanks a lot for the very approachable and informative
blog post, it was a pleasure to read! Great work!


>
> > >
> > > > > Our paper, also posted on [1], appeared at Computer Aided Verific=
ation (CAV)=E2=80=9923.
> > > > >
> > > > > [2] https://people.cs.rutgers.edu/~sn624/papers/agni-cav23.pdf
> > > > >
> > > > > Together with @Paul Chaignon and @Harishankar Vishwanathan (CC'ed=
), we
> > > > > are working to get our tooling into a form that is integrable int=
o BPF
> > > > > CI. We will look forward to your feedback when we post patches.
> > > >
> > > > If this could be integrated in a way that we can regularly run this
> > > > and validate latest version of verifier, that would be great. I hav=
e a
> > > > second part of verifier changes coming up that extends range tracki=
ng
> > > > logic further to support range vs range (as opposed to range vs con=
st
> > > > that we do currently) comparisons and is_branch_taken, so having
> > > > independent and formal verification of these changes would be great=
!
> >
> > The current goal is to have this running somewhere regularly (maybe
> > releases + manual triggers) in a semi-automated fashion. The two
> > challenges today are the time it takes to run verification (days withou=
t
> > parallelization) and whether the bit of conversion & glue code will be
> > maintanable long term.
> >
> > I'm fairly optimistic on the first as we're already down to hours with
> > basic parallelization. The second is harder to predict, but I guess you=
r
> > patches will be a good exercice :)
> >
> > I've already ran the verification on v6.0 to v6.3; v6.4 is currently
> > running. Hari et al. had verified v4.14 to v5.19 before. I'll give it a
> > try on this patchset afterward.
>
> Cool, that's great! The second part of this work will be generalizing
> this logic in kernel to support range vs range comparisons, so I'd
> appreciate it if you could validate that one as well. I'm finalizing
> it, but will wait for this patch set to land first before posting
> second part to have a proper CI testing runs (and limit amount of code
> review to be done).
>
> BTW, I've since did some more changes to this "selftests" to be a bit
> more parallelizable, so this range_vs_consts set of tests now can run
> in about 5 minutes on 8+ core QEMU instance. In the second part we'll
> have range-vs-range, so we have about 106 million cases and it takes
> slightly more than 8 hours single-threaded. But with parallelization,
> it's done in slightly more than one hour.
>
> So, of course, still too slow to run as part of normal test_progs run,
> but definitely easy to run locally to validate kernel changes (and
> probably makes sense to enable on some nightly CI runs, when we have
> them).
>
> Regardless, my point is that both methods of verification are
> complementary, I think, and it's good to have both available and
> working on latest kernel versions.
>
>
> >
> > >
> > > +1 (from a quick skim) this work is already great as-is, and it'd be =
even
> > > better once it get's in the CI. From the paper there's this
> > >
> > >   We conducted our experiments on ... a machine with two 10-core Inte=
l
> > >   Skylake CPUs running at 2.20 GHz with 192 GB of memory...
> > >
> > > I suppose the memory requirement comes from the vast amount of state =
space
> > > that the Z3 SMT solver have to go through, and perhaps that poses a
> > > challenge for CI integration?
> > >
> > > Just wondering is there are some low-hanging fruit the can make thing=
s
> > > easier for the SMT solver.
> >
> > This is how much memory the system had, but it didn't use it all :)
> > When running the solver on a single core, I saw around 1GB of memory
> > usage. With my changes to run on several cores, it can grow to a few
> > GBs depending on the number of cores.
> >
> > --
> > Paul

