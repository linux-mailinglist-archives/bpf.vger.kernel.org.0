Return-Path: <bpf+bounces-13376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B64097D8BD2
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 00:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B767B215EE
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 22:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC45A2DF62;
	Thu, 26 Oct 2023 22:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSUAGtQa"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE81B2D792
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 22:47:25 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F1D1B4
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 15:47:23 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9bdf5829000so235842066b.0
        for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 15:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698360442; x=1698965242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+JatyEexrZo6LX9+Bdlc5UmwN/w3UUvBMNzIgDfkxY=;
        b=SSUAGtQaKNB/Ow5LOjAaJBsOpgXSPke3NFvpOabMllx0HnbvZNadc+S8IASh1iX0OM
         4ebk0G4cLFV0FEjX6Kph7hl0YDwzqOI9zip6ddyboUC4x+CnniB1cmIkdZoGo7ZU+lZa
         rnIcz5AAiJcwXkJ55kR4q4hNfHS1VSPdzPqZc8Ehre9a9JNw3shvoM+VdeC1kf1jmZF7
         HJo0neJ581/6b8idIucxgQrFmIndM7vrcoqksCS/B/PvBeFAjD5jZbJF145Wh4uRxa9i
         uepQU5y21oMX6JSUW1uQnT2Ors3bhHS0V2QUgil905yLzpz6YICtx+oz29vaszA0XCRz
         eGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698360442; x=1698965242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+JatyEexrZo6LX9+Bdlc5UmwN/w3UUvBMNzIgDfkxY=;
        b=Pj+T2zalyEzMk9gv3kREnK2W45zgaFZXX0pljK4ltMRkvfaAYFpDacJwtpgpjCCi2q
         EDcb9GxGsZWuRGFvOsjys9ILmJJtqR/QqOtTT2Tpq084FkOl+GpUdmwvF+zzn/WjczKs
         xpnSyyBoTa7+Wi0lwgljpDEDYm60huoChwxefyqrOnJS1Xnz0DgqabW2J75Mcn0wtH8E
         2Fh+KrRbNoWlaRjA/FSN1FYmAm1UJL2a4XqeekFEgln1RydbwTPOzm17z8tJ6EtwJapZ
         Wzw1wuxiuJayr3Rdnt8kzSkONP0uw20yMPxdPr6fKok3JAk3uXZOKkVdPVrTtxNpjdet
         RpEQ==
X-Gm-Message-State: AOJu0Yx6KHa5tnzao2Vy1+ca0SRahntsQPk5I3svE2CHfd8te4k216gf
	qPl3HIKTYdmY5nagJaZdLy0wPVQZysKeL+fmnUA=
X-Google-Smtp-Source: AGHT+IEHWmD0+F8/uow7vvno/cnrztWmS+1TGu/APfUEIhVrCsz9F5U/Muoc8ZS6Lac17k1Bx0T2VNV6K5V05VKep0c=
X-Received: by 2002:a17:907:2683:b0:9c7:59d1:b2c4 with SMTP id
 bn3-20020a170907268300b009c759d1b2c4mr717288ejc.64.1698360441627; Thu, 26 Oct
 2023 15:47:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231019042405.2971130-8-andrii@kernel.org> <ZTDbGWHu4CnJYWAs@u94a>
 <ZTDgIyzBX9oZNeFw@u94a> <CAEf4BzYgJR6SAjbvd0uZ6w8D37Sy=Wjd2TROOGEAZDiEq7xb2g@mail.gmail.com>
 <1DA1AC52-6E2D-4CDA-8216-D1DD4648AD55@cs.rutgers.edu> <CAEf4BzbFhA585gSN1YfaDaeEmmUvWSdpMY605fmV_RvSQ7+xeQ@mail.gmail.com>
 <ZTZ9tYlVgt9DVcgi@u94a> <ZTaWo7ZUv9jrfIa4@Mem> <CAEf4BzbJ3hZCSt4nLCZCV4cxV60+kddiSMsy7-9ou_RaQV7B8A@mail.gmail.com>
 <CAEf4BzZqji_3NvJgkDu3Di6CjWZmyf+N7v=23ayfskEEwZZokA@mail.gmail.com> <ZTg2nkmkIs9olFhH@Mem>
In-Reply-To: <ZTg2nkmkIs9olFhH@Mem>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 26 Oct 2023 15:47:10 -0700
Message-ID: <CAEf4BzZa+nvGDD1YcOeFDhQY+4R_Tgk__mpDX=ghjDKkpw33mw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 7/7] selftests/bpf: BPF register range bounds tester
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>, 
	Srinivas Narayana Ganapathy <sn624@cs.rutgers.edu>, Andrii Nakryiko <andrii@kernel.org>, 
	Langston Barrett <langston.barrett@gmail.com>, 
	Srinivas Narayana <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte <sn349@cs.rutgers.edu>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "martin.lau@kernel.org" <martin.lau@kernel.org>, 
	"kernel-team@meta.com" <kernel-team@meta.com>, Matan Shachnai <m.shachnai@rutgers.edu>, 
	Harishankar Vishwanathan <harishankar.vishwanathan@rutgers.edu>, Paul Chaignon <paul@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 2:26=E2=80=AFPM Paul Chaignon <paul.chaignon@gmail.=
com> wrote:
>
> On Mon, Oct 23, 2023 at 10:51:57PM -0700, Andrii Nakryiko wrote:
> > On Mon, Oct 23, 2023 at 3:50=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Mon, Oct 23, 2023 at 8:52=E2=80=AFAM Paul Chaignon <paul@isovalent=
.com> wrote:
> > > >
> > > > On Mon, Oct 23, 2023 at 10:05:41PM +0800, Shung-Hsi Yu wrote:
> > > > > On Sat, Oct 21, 2023 at 09:42:46PM -0700, Andrii Nakryiko wrote:
> > > > > > On Fri, Oct 20, 2023 at 10:37=E2=80=AFAM Srinivas Narayana Gana=
pathy
> > > > > > <sn624@cs.rutgers.edu> wrote:
> > > > > > >
> > > > > > > Hi all,
> > > > > > >
> > > > > > > Thanks, @Shung-Hsi, for bringing up this conversation about
> > > > > > > integrating formal verification approaches into the BPF CI an=
d testing.
> > > > > > >
> > > > > > > > On 19-Oct-2023, at 1:34 PM, Andrii Nakryiko <andrii.nakryik=
o@gmail.com> wrote:
> > > > > > > > On Thu, Oct 19, 2023 at 12:52=E2=80=AFAM Shung-Hsi Yu <shun=
g-hsi.yu@suse.com> wrote:
> > > > > > > >> On Thu, Oct 19, 2023 at 03:30:33PM +0800, Shung-Hsi Yu wro=
te:
> > > >
> > > > [...]
> > > >
> > > > > > > >>> FWIW an alternative approach that speeds things up is to =
use model checkers
> > > > > > > >>> like Z3 or CBMC. On my laptop, using Z3 to validate tnum_=
add() against *all*
> > > > > > > >>> possible inputs takes less than 1.3 seconds[3] (based on =
code from [1]
> > > > > > > >>> paper, but I somehow lost the link to their GitHub reposi=
tory).
> > > > > > > >>
> > > > > > > >> Found it. For reference, code used in "Sound, Precise, and=
 Fast Abstract
> > > > > > > >> Interpretation with Tristate Numbers"[1] can be found at
> > > > > > > >> https://github.com/bpfverif/tnums-cgo22/blob/main/verifica=
tion/tnum.py
> > > > > > > >>
> > > > > > > >> Below is a truncated form of the above that only check tnu=
m_add(), requires
> > > > > > > >> a package called python3-z3 on most distros:
> > > > > > > >
> > > > > > > > Great! I'd be curious to see how range tracking logic can b=
e encoded
> > > > > > > > using this approach, please give it a go!
> > > > > > >
> > > > > > > We have some recent work that applies formal verification app=
roaches
> > > > > > > to the entirety of range tracking in the eBPF verifier. We po=
sted a
> > > > > > > note to the eBPF mailing list about it sometime ago:
> > > > > > >
> > > > > > > [1] https://lore.kernel.org/bpf/SJ2PR14MB6501E906064EE19F5D16=
66BFF93BA@SJ2PR14MB6501.namprd14.prod.outlook.com/T/#u
> > > > > >
> > > > > > Oh, I totally missed this, as I just went on a long vacation a =
few
> > > > > > days before that and declared email bankruptcy afterwards. I'll=
 try to
> > > > > > give it a read, though I see lots of math symbols there and mak=
e no
> > > > > > promises ;)
> > > > >
> > > > > Feels the same when I start reading their previous work, but I ca=
n vouch
> > > > > their work their work are definitely worth the read. (Though I ha=
d to admit
> > > > > I secretly chant "math is easier than code, math is easier than c=
ode" to
> > > > > convincing my mind to not go into flight mode when seeing math sy=
mbols ;D
> > > >
> > > > Hari et al. did a great job at explaining the intuitions throughout=
 the
> > > > paper. So even if you skip the math, you should be able to follow.
> > > >
> > > > Having an understanding of abstract interpretation helps. The Mozil=
la
> > > > wiki has a great one [1] and I wrote a shorter BPF example of it [2=
].
> > > >
> > > > 1 - https://wiki.mozilla.org/Abstract_Interpretation
> > > > 2 - https://pchaigno.github.io/abstract-interpretation.html
> > > >
> > >
> > > thanks :)
> >
> > Hey Paul,
> >
> > I had a bunch of time on the plane to catch up on reading, so I read
> > your blog post about PREVAIL among other things. Hopefully you don't
> > mind some comments posted here.
> >
> > > Observation 1. The analysis must track binary relations among registe=
rs.
> >
> > It's curious that the BPF verifier in kernel actually doesn't track
> > relations in this sense, and yet it works for lots and lots of
> > practical programs. :)
>
> It kind of does, but only for the types where it's actually needed. For
> example if we have:
>
>   3: (bf) r3 =3D r1
>   4: (07) r3 +=3D 14
>   5: (2d) if r3 > r2 goto pc+50
>    R1_w=3Dpkt(id=3D0,off=3D0,r=3D14,imm=3D0) R2_w=3Dpkt_end(id=3D0,off=3D=
0,imm=3D0)
>      R3_w=3Dpkt(id=3D0,off=3D14,r=3D14,imm=3D0)
>
> R1's range actually refers to the relationship to pkt_end, R2 at this
> point. So, R1's r=3D14 carries the same information as R1 + 14 <=3D R2.
>
> A big difference is that the Linux verifier is very tailored to eBPF. So
> it doesn't perform this sort of more complicated tracking for all
> registers and slack slots. I suspect that plays a bit role in the lower
> performance of PREVAIL.
>

Yes, PACKET_END is a special case, so you are right. I had
SCALAR_VALUE registers in mind, and for those we don't track
relationships (even if in some cases that could help with some
compiler optimizations).

> >
> >
> > (Speaking of kernel verifier implementation)
> >
> > > Third, it does not currently support programs with loops.
> >
> > It does, and I'm not even talking about bounded loops that are
> > basically unrolled as many times as necessary. We have bpf_loop()
> > helper calling given callback as many times as requested, but even
> > better we now have open-coded iterators. Please check selftests using
> > bpf_for() macro.
> >
> > Note that Eduard is fixing discovered issues in open-coded iterators
> > convergence checks and logic, but other than that BPF does have real
> > loops.
>
> I'll fix that. I also wasn't aware of the more recent bpf_for. Nice!
>
> The larger point is that PREVAIL is able to fully verify free-form
> loops. It doesn't impose a structure or rely on trusted code (helpers
> and kfuncs).
> In the end, I don't think it matters much. The amount of trusted code
> for this is small and well understood. And we probably don't want
> ill-structured loops in our C code anyway. But the lack of loop support
> used to take a lot of attention when speaking of the BPF verifier, so I
> guess that's why it ended up being a selling point in the paper.

Yeah, I get that. I only pointed this out because your blog post
written in September of 2023 will be read by someone and they will
think that BPF verifier still doesn't support loops, which is not true
:) So it would be nice to point out that this is possible.

>
> >
> >
> > And about a confusing bit at the end:
> >
> > >  0: r0 =3D 0
> > >  1: if r1 > 10 goto pc+4  // r1 =E2=88=88 [0; 10]
> > >  2: if r2 > 10 goto pc+3  // r2 =E2=88=88 [0; 10]
> > >  3: r1 *=3D r2              // r1 =E2=88=88 [0; 100]
> > >  4: if r1 !=3D 5 goto pc+1
> > >  5: r1 /=3D r0              // Division by zero!
> > >  6: exit
> > >
> > > After instruction 2, both r1 and r2 have abstract value [0; 10].
> > > After instruction 3, r1 holds the multiplication of r1 and r2 and
> > > therefore has abstract value [0; 100]. When considering the condition=
 at
> > >  instruction 4, because 11 =E2=88=88 [0; 100], we will walk both path=
s and hit the
> > >  division by zero.
> > >
> > > Except we know that r1 can never take value 11. The number 11 is a pr=
ime
> > >  number, so it is not a multiple of any integers between 0 and 10.
> >
> > This made me pause for a while. I think you meant to have `4: if r1 !=
=3D
> > 11 goto pc+1` and then go on to explain that you can't get 11 by
> > multiplying numbers in range [0; 10], because 11 is greater than 10
> > (so can't be 1 x 11), but also it's a prime number, so you can't get
> > it from multiplication of two integers. So please consider fixing up
> > the code example, and perhaps elaborate a bit more on why 11 can't
> > happen in actuality. This example does look a bit academic, but, well,
> > formal methods and stuff, it's fitting! ;)
>
> You're absolutely right. It should be 11 instead of 5. That's what I get
> for changing the ranges from [0; 4] to [0; 10] at the last minute.
>
> >
> >
> > > It=E2=80=99s a bit disappointing that the paper doesn=E2=80=99t inclu=
de any comparison with the Linux verifier on the same corpus of BPF program=
s.
> >
> > Indeed, I concur. It would be interesting to have this comparison as
> > of the most recent version of PREVAIL and Linux's BPF verifier.
> >
> >
> > Either way, thanks a lot for the very approachable and informative
> > blog post, it was a pleasure to read! Great work!
>
> Thanks for the read and the review! I like reading about what academia
> is doing around BPF so certainly not my last post on those topics :)
>
> >
> >
> > >
> > > > >
> > > > > > > Our paper, also posted on [1], appeared at Computer Aided Ver=
ification (CAV)=E2=80=9923.
> > > > > > >
> > > > > > > [2] https://people.cs.rutgers.edu/~sn624/papers/agni-cav23.pd=
f
> > > > > > >
> > > > > > > Together with @Paul Chaignon and @Harishankar Vishwanathan (C=
C'ed), we
> > > > > > > are working to get our tooling into a form that is integrable=
 into BPF
> > > > > > > CI. We will look forward to your feedback when we post patche=
s.
> > > > > >
> > > > > > If this could be integrated in a way that we can regularly run =
this
> > > > > > and validate latest version of verifier, that would be great. I=
 have a
> > > > > > second part of verifier changes coming up that extends range tr=
acking
> > > > > > logic further to support range vs range (as opposed to range vs=
 const
> > > > > > that we do currently) comparisons and is_branch_taken, so havin=
g
> > > > > > independent and formal verification of these changes would be g=
reat!
> > > >
> > > > The current goal is to have this running somewhere regularly (maybe
> > > > releases + manual triggers) in a semi-automated fashion. The two
> > > > challenges today are the time it takes to run verification (days wi=
thout
> > > > parallelization) and whether the bit of conversion & glue code will=
 be
> > > > maintanable long term.
> > > >
> > > > I'm fairly optimistic on the first as we're already down to hours w=
ith
> > > > basic parallelization. The second is harder to predict, but I guess=
 your
> > > > patches will be a good exercice :)
> > > >
> > > > I've already ran the verification on v6.0 to v6.3; v6.4 is currentl=
y
> > > > running. Hari et al. had verified v4.14 to v5.19 before. I'll give =
it a
> > > > try on this patchset afterward.
> > >
> > > Cool, that's great! The second part of this work will be generalizing
> > > this logic in kernel to support range vs range comparisons, so I'd
> > > appreciate it if you could validate that one as well. I'm finalizing
> > > it, but will wait for this patch set to land first before posting
> > > second part to have a proper CI testing runs (and limit amount of cod=
e
> > > review to be done).
>
> Happy to!

I'm planning to post all my changes as one series in a few days, so
maybe you can take it for a spin at that point?

>
> > >
> > > BTW, I've since did some more changes to this "selftests" to be a bit
> > > more parallelizable, so this range_vs_consts set of tests now can run
> > > in about 5 minutes on 8+ core QEMU instance. In the second part we'll
> > > have range-vs-range, so we have about 106 million cases and it takes
> > > slightly more than 8 hours single-threaded. But with parallelization,
> > > it's done in slightly more than one hour.
> > >
> > > So, of course, still too slow to run as part of normal test_progs run=
,
> > > but definitely easy to run locally to validate kernel changes (and
> > > probably makes sense to enable on some nightly CI runs, when we have
> > > them).
> > >
> > > Regardless, my point is that both methods of verification are
> > > complementary, I think, and it's good to have both available and
> > > working on latest kernel versions.
>
> Completely agree!
>
> > >
> > >
> > > >
> > > > >
> > > > > +1 (from a quick skim) this work is already great as-is, and it'd=
 be even
> > > > > better once it get's in the CI. From the paper there's this
> > > > >
> > > > >   We conducted our experiments on ... a machine with two 10-core =
Intel
> > > > >   Skylake CPUs running at 2.20 GHz with 192 GB of memory...
> > > > >
> > > > > I suppose the memory requirement comes from the vast amount of st=
ate space
> > > > > that the Z3 SMT solver have to go through, and perhaps that poses=
 a
> > > > > challenge for CI integration?
> > > > >
> > > > > Just wondering is there are some low-hanging fruit the can make t=
hings
> > > > > easier for the SMT solver.
> > > >
> > > > This is how much memory the system had, but it didn't use it all :)
> > > > When running the solver on a single core, I saw around 1GB of memor=
y
> > > > usage. With my changes to run on several cores, it can grow to a fe=
w
> > > > GBs depending on the number of cores.
> > > >
> > > > --
> > > > Paul

