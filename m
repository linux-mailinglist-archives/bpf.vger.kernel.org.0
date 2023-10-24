Return-Path: <bpf+bounces-13161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6937D5D2D
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 23:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 433CD281AFD
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 21:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD3A3F4D0;
	Tue, 24 Oct 2023 21:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgDBAhek"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FDC3D967
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 21:27:16 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD4E1BC7
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 14:26:59 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4083740f92dso40780645e9.3
        for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 14:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698182817; x=1698787617; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rQyOBa7gpcdwJtnO8cZn3owf3MV9JeNdGawfaDxhqG0=;
        b=OgDBAhekRAOQVzZV2NviijvBQ1hKq1FymVRxQIYuF/j4qhyIqzukJNDsCVXH1A4tlr
         /3UU+OykvgxpZIRmR/wbSvGWL9vMJec99SYF+AeDleHs06jVw294xiKiTi80SZjTf2fd
         4XOXM90Hs63W/obWQjcM11QskQmSoGZZd1e0PdngRvpS2OI8ONBEde2y4gZ5vaiY4/lA
         7UDBSp8guL5kcjIXyeG2//F28yvwVUsnf/XVpmGpIlSC07GY8DrGvEOEL2Innbxa5pM4
         WHpyuijfnGPjMlzrgat2DcK2c8TYrlFGOMnKpLj4fBBtnRHj/zpe2eQe3tB8Iva1ECBs
         E0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698182817; x=1698787617;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rQyOBa7gpcdwJtnO8cZn3owf3MV9JeNdGawfaDxhqG0=;
        b=eOSon/J23A+jVMkSb5AFCjo0YU0EXBKmwrICSmsa6gSPB1N2qyCTAgsH/pBg3bkwTW
         NXx57jvl4XK7eXv6pLTDqziX3ZPN3juGqLZvqO+opXt3JPN8Y59GXh79xvdXzF4c1Wtn
         lOczq/qm5DftPXnkoDikAnsr2q9i2upP/OJha+XUaQaeQf42ngOmxQS09QuB61NZqYOm
         tIg2I9uhowpMOm+4QSQItKTsfw4LRZWCD7kieIrtTa67N/GX6h2MDmm6aJsjaxD/gU8q
         9VQI7eCM8oRzcGGD8eOSLdeZeGrhyyFeemY4VHWXVBz7oZNQUbDz9ecXT8WY11j0R5jV
         MIDA==
X-Gm-Message-State: AOJu0YyiKKUmW2E3W/v2Pal7wps1FzmkUM0Ja0VZOPlkRQvN7DB6UJ8c
	+ULWfJJf05ogusReWzYomL4=
X-Google-Smtp-Source: AGHT+IGyvo//8jS5yRWzAlxWfBod9hPXnrdZZ2WgJ0hn2omAf+wB7vkH8T0ERik3LwfaMtfUKoTXIw==
X-Received: by 2002:adf:f151:0:b0:32d:82f7:e76 with SMTP id y17-20020adff151000000b0032d82f70e76mr10652331wro.34.1698182817000;
        Tue, 24 Oct 2023 14:26:57 -0700 (PDT)
Received: from Mem (2a01cb0890a26e00cc5e497626b56255.ipv6.abo.wanadoo.fr. [2a01:cb08:90a2:6e00:cc5e:4976:26b5:6255])
        by smtp.gmail.com with ESMTPSA id h12-20020adff18c000000b0032d402f816csm10556192wro.98.2023.10.24.14.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:26:56 -0700 (PDT)
Date: Tue, 24 Oct 2023 23:26:54 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Srinivas Narayana Ganapathy <sn624@cs.rutgers.edu>,
	Andrii Nakryiko <andrii@kernel.org>,
	Langston Barrett <langston.barrett@gmail.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <sn349@cs.rutgers.edu>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"ast@kernel.org" <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"martin.lau@kernel.org" <martin.lau@kernel.org>,
	"kernel-team@meta.com" <kernel-team@meta.com>,
	Matan Shachnai <m.shachnai@rutgers.edu>,
	Harishankar Vishwanathan <harishankar.vishwanathan@rutgers.edu>,
	Paul Chaignon <paul@isovalent.com>
Subject: Re: [PATCH v2 bpf-next 7/7] selftests/bpf: BPF register range bounds
 tester
Message-ID: <ZTg2nkmkIs9olFhH@Mem>
References: <20231019042405.2971130-8-andrii@kernel.org>
 <ZTDbGWHu4CnJYWAs@u94a>
 <ZTDgIyzBX9oZNeFw@u94a>
 <CAEf4BzYgJR6SAjbvd0uZ6w8D37Sy=Wjd2TROOGEAZDiEq7xb2g@mail.gmail.com>
 <1DA1AC52-6E2D-4CDA-8216-D1DD4648AD55@cs.rutgers.edu>
 <CAEf4BzbFhA585gSN1YfaDaeEmmUvWSdpMY605fmV_RvSQ7+xeQ@mail.gmail.com>
 <ZTZ9tYlVgt9DVcgi@u94a>
 <ZTaWo7ZUv9jrfIa4@Mem>
 <CAEf4BzbJ3hZCSt4nLCZCV4cxV60+kddiSMsy7-9ou_RaQV7B8A@mail.gmail.com>
 <CAEf4BzZqji_3NvJgkDu3Di6CjWZmyf+N7v=23ayfskEEwZZokA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZqji_3NvJgkDu3Di6CjWZmyf+N7v=23ayfskEEwZZokA@mail.gmail.com>

On Mon, Oct 23, 2023 at 10:51:57PM -0700, Andrii Nakryiko wrote:
> On Mon, Oct 23, 2023 at 3:50 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Oct 23, 2023 at 8:52 AM Paul Chaignon <paul@isovalent.com> wrote:
> > >
> > > On Mon, Oct 23, 2023 at 10:05:41PM +0800, Shung-Hsi Yu wrote:
> > > > On Sat, Oct 21, 2023 at 09:42:46PM -0700, Andrii Nakryiko wrote:
> > > > > On Fri, Oct 20, 2023 at 10:37 AM Srinivas Narayana Ganapathy
> > > > > <sn624@cs.rutgers.edu> wrote:
> > > > > >
> > > > > > Hi all,
> > > > > >
> > > > > > Thanks, @Shung-Hsi, for bringing up this conversation about
> > > > > > integrating formal verification approaches into the BPF CI and testing.
> > > > > >
> > > > > > > On 19-Oct-2023, at 1:34 PM, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > > > > > > On Thu, Oct 19, 2023 at 12:52 AM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> > > > > > >> On Thu, Oct 19, 2023 at 03:30:33PM +0800, Shung-Hsi Yu wrote:
> > >
> > > [...]
> > >
> > > > > > >>> FWIW an alternative approach that speeds things up is to use model checkers
> > > > > > >>> like Z3 or CBMC. On my laptop, using Z3 to validate tnum_add() against *all*
> > > > > > >>> possible inputs takes less than 1.3 seconds[3] (based on code from [1]
> > > > > > >>> paper, but I somehow lost the link to their GitHub repository).
> > > > > > >>
> > > > > > >> Found it. For reference, code used in "Sound, Precise, and Fast Abstract
> > > > > > >> Interpretation with Tristate Numbers"[1] can be found at
> > > > > > >> https://github.com/bpfverif/tnums-cgo22/blob/main/verification/tnum.py
> > > > > > >>
> > > > > > >> Below is a truncated form of the above that only check tnum_add(), requires
> > > > > > >> a package called python3-z3 on most distros:
> > > > > > >
> > > > > > > Great! I'd be curious to see how range tracking logic can be encoded
> > > > > > > using this approach, please give it a go!
> > > > > >
> > > > > > We have some recent work that applies formal verification approaches
> > > > > > to the entirety of range tracking in the eBPF verifier. We posted a
> > > > > > note to the eBPF mailing list about it sometime ago:
> > > > > >
> > > > > > [1] https://lore.kernel.org/bpf/SJ2PR14MB6501E906064EE19F5D1666BFF93BA@SJ2PR14MB6501.namprd14.prod.outlook.com/T/#u
> > > > >
> > > > > Oh, I totally missed this, as I just went on a long vacation a few
> > > > > days before that and declared email bankruptcy afterwards. I'll try to
> > > > > give it a read, though I see lots of math symbols there and make no
> > > > > promises ;)
> > > >
> > > > Feels the same when I start reading their previous work, but I can vouch
> > > > their work their work are definitely worth the read. (Though I had to admit
> > > > I secretly chant "math is easier than code, math is easier than code" to
> > > > convincing my mind to not go into flight mode when seeing math symbols ;D
> > >
> > > Hari et al. did a great job at explaining the intuitions throughout the
> > > paper. So even if you skip the math, you should be able to follow.
> > >
> > > Having an understanding of abstract interpretation helps. The Mozilla
> > > wiki has a great one [1] and I wrote a shorter BPF example of it [2].
> > >
> > > 1 - https://wiki.mozilla.org/Abstract_Interpretation
> > > 2 - https://pchaigno.github.io/abstract-interpretation.html
> > >
> >
> > thanks :)
> 
> Hey Paul,
> 
> I had a bunch of time on the plane to catch up on reading, so I read
> your blog post about PREVAIL among other things. Hopefully you don't
> mind some comments posted here.
> 
> > Observation 1. The analysis must track binary relations among registers.
> 
> It's curious that the BPF verifier in kernel actually doesn't track
> relations in this sense, and yet it works for lots and lots of
> practical programs. :)

It kind of does, but only for the types where it's actually needed. For
example if we have:

  3: (bf) r3 = r1
  4: (07) r3 += 14
  5: (2d) if r3 > r2 goto pc+50
   R1_w=pkt(id=0,off=0,r=14,imm=0) R2_w=pkt_end(id=0,off=0,imm=0)
     R3_w=pkt(id=0,off=14,r=14,imm=0)

R1's range actually refers to the relationship to pkt_end, R2 at this
point. So, R1's r=14 carries the same information as R1 + 14 <= R2.

A big difference is that the Linux verifier is very tailored to eBPF. So
it doesn't perform this sort of more complicated tracking for all
registers and slack slots. I suspect that plays a bit role in the lower
performance of PREVAIL.

> 
> 
> (Speaking of kernel verifier implementation)
> 
> > Third, it does not currently support programs with loops.
> 
> It does, and I'm not even talking about bounded loops that are
> basically unrolled as many times as necessary. We have bpf_loop()
> helper calling given callback as many times as requested, but even
> better we now have open-coded iterators. Please check selftests using
> bpf_for() macro.
> 
> Note that Eduard is fixing discovered issues in open-coded iterators
> convergence checks and logic, but other than that BPF does have real
> loops.

I'll fix that. I also wasn't aware of the more recent bpf_for. Nice!

The larger point is that PREVAIL is able to fully verify free-form
loops. It doesn't impose a structure or rely on trusted code (helpers
and kfuncs).
In the end, I don't think it matters much. The amount of trusted code
for this is small and well understood. And we probably don't want
ill-structured loops in our C code anyway. But the lack of loop support
used to take a lot of attention when speaking of the BPF verifier, so I
guess that's why it ended up being a selling point in the paper.

> 
> 
> And about a confusing bit at the end:
> 
> >  0: r0 = 0
> >  1: if r1 > 10 goto pc+4  // r1 ∈ [0; 10]
> >  2: if r2 > 10 goto pc+3  // r2 ∈ [0; 10]
> >  3: r1 *= r2              // r1 ∈ [0; 100]
> >  4: if r1 != 5 goto pc+1
> >  5: r1 /= r0              // Division by zero!
> >  6: exit
> >
> > After instruction 2, both r1 and r2 have abstract value [0; 10].
> > After instruction 3, r1 holds the multiplication of r1 and r2 and
> > therefore has abstract value [0; 100]. When considering the condition at
> >  instruction 4, because 11 ∈ [0; 100], we will walk both paths and hit the
> >  division by zero.
> >
> > Except we know that r1 can never take value 11. The number 11 is a prime
> >  number, so it is not a multiple of any integers between 0 and 10.
> 
> This made me pause for a while. I think you meant to have `4: if r1 !=
> 11 goto pc+1` and then go on to explain that you can't get 11 by
> multiplying numbers in range [0; 10], because 11 is greater than 10
> (so can't be 1 x 11), but also it's a prime number, so you can't get
> it from multiplication of two integers. So please consider fixing up
> the code example, and perhaps elaborate a bit more on why 11 can't
> happen in actuality. This example does look a bit academic, but, well,
> formal methods and stuff, it's fitting! ;)

You're absolutely right. It should be 11 instead of 5. That's what I get
for changing the ranges from [0; 4] to [0; 10] at the last minute.

> 
> 
> > It’s a bit disappointing that the paper doesn’t include any comparison with the Linux verifier on the same corpus of BPF programs.
> 
> Indeed, I concur. It would be interesting to have this comparison as
> of the most recent version of PREVAIL and Linux's BPF verifier.
> 
> 
> Either way, thanks a lot for the very approachable and informative
> blog post, it was a pleasure to read! Great work!

Thanks for the read and the review! I like reading about what academia
is doing around BPF so certainly not my last post on those topics :)

> 
> 
> >
> > > >
> > > > > > Our paper, also posted on [1], appeared at Computer Aided Verification (CAV)’23.
> > > > > >
> > > > > > [2] https://people.cs.rutgers.edu/~sn624/papers/agni-cav23.pdf
> > > > > >
> > > > > > Together with @Paul Chaignon and @Harishankar Vishwanathan (CC'ed), we
> > > > > > are working to get our tooling into a form that is integrable into BPF
> > > > > > CI. We will look forward to your feedback when we post patches.
> > > > >
> > > > > If this could be integrated in a way that we can regularly run this
> > > > > and validate latest version of verifier, that would be great. I have a
> > > > > second part of verifier changes coming up that extends range tracking
> > > > > logic further to support range vs range (as opposed to range vs const
> > > > > that we do currently) comparisons and is_branch_taken, so having
> > > > > independent and formal verification of these changes would be great!
> > >
> > > The current goal is to have this running somewhere regularly (maybe
> > > releases + manual triggers) in a semi-automated fashion. The two
> > > challenges today are the time it takes to run verification (days without
> > > parallelization) and whether the bit of conversion & glue code will be
> > > maintanable long term.
> > >
> > > I'm fairly optimistic on the first as we're already down to hours with
> > > basic parallelization. The second is harder to predict, but I guess your
> > > patches will be a good exercice :)
> > >
> > > I've already ran the verification on v6.0 to v6.3; v6.4 is currently
> > > running. Hari et al. had verified v4.14 to v5.19 before. I'll give it a
> > > try on this patchset afterward.
> >
> > Cool, that's great! The second part of this work will be generalizing
> > this logic in kernel to support range vs range comparisons, so I'd
> > appreciate it if you could validate that one as well. I'm finalizing
> > it, but will wait for this patch set to land first before posting
> > second part to have a proper CI testing runs (and limit amount of code
> > review to be done).

Happy to!

> >
> > BTW, I've since did some more changes to this "selftests" to be a bit
> > more parallelizable, so this range_vs_consts set of tests now can run
> > in about 5 minutes on 8+ core QEMU instance. In the second part we'll
> > have range-vs-range, so we have about 106 million cases and it takes
> > slightly more than 8 hours single-threaded. But with parallelization,
> > it's done in slightly more than one hour.
> >
> > So, of course, still too slow to run as part of normal test_progs run,
> > but definitely easy to run locally to validate kernel changes (and
> > probably makes sense to enable on some nightly CI runs, when we have
> > them).
> >
> > Regardless, my point is that both methods of verification are
> > complementary, I think, and it's good to have both available and
> > working on latest kernel versions.

Completely agree!

> >
> >
> > >
> > > >
> > > > +1 (from a quick skim) this work is already great as-is, and it'd be even
> > > > better once it get's in the CI. From the paper there's this
> > > >
> > > >   We conducted our experiments on ... a machine with two 10-core Intel
> > > >   Skylake CPUs running at 2.20 GHz with 192 GB of memory...
> > > >
> > > > I suppose the memory requirement comes from the vast amount of state space
> > > > that the Z3 SMT solver have to go through, and perhaps that poses a
> > > > challenge for CI integration?
> > > >
> > > > Just wondering is there are some low-hanging fruit the can make things
> > > > easier for the SMT solver.
> > >
> > > This is how much memory the system had, but it didn't use it all :)
> > > When running the solver on a single core, I saw around 1GB of memory
> > > usage. With my changes to run on several cores, it can grow to a few
> > > GBs depending on the number of cores.
> > >
> > > --
> > > Paul

