Return-Path: <bpf+bounces-13073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D927D42E5
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 00:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3A911C20B45
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 22:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D4B2375C;
	Mon, 23 Oct 2023 22:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cw6g8OgM"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0636F1B27E
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 22:50:55 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41C010D
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 15:50:53 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53db3811d8fso8053989a12.1
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 15:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698101452; x=1698706252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKdJni8jw9BMgbbXL5N2V2pv7fbPrkWELaOTKRvE0bI=;
        b=cw6g8OgMw7QvQ7cKT1sNJNe5OjzqDJ6wjfKGX0nlP7gL3v5sJU19RpeCL/YL2PX/tk
         Dh01FrYQP5bG8ySLb5gYaHQIxXGEcx8Ct5MAYsBfz6A4lcPlQMeC7aImC6zmgB+AM1UC
         7Bva5uIM/nAORiYp9Or6kuAtiIxw11dk133VFWtIue2G2ibwGI3soJs82LfKNXWGyQ34
         1NvckE4jCC+Yq5210jKzm/mdsuZQTzsB3t5Rr/fiWxycxViOZdbHTGR2xI037n7se6xI
         pn3xLtdWYu87/6x+YgMaCSZm2vfIwYQxLoA+kD+t16AD1QK5W/xIFFfOyG7yMBsxv+td
         GcTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698101452; x=1698706252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKdJni8jw9BMgbbXL5N2V2pv7fbPrkWELaOTKRvE0bI=;
        b=q4WBC0er/My03xEjdyMx7DI0TDzG5bdgxgf1SMtJ1QV4LLdLToI3Zy48Q7ROeiWTiy
         P9IfqnIZK+ysYhN78cveeGsdcDiEnhak34Len29CtoQoNmrYXfgVTevHRFnhG9SPqKGo
         2TdzeUT8pDACgEUsF//pW8LciCgj/Xak4qwjjsmKP/yw517JPqdVLriyNaBCgeMZVNRc
         PRvk5o+uaoTRZxu6LT4cIkCOkqzRsIxl2hOq429wXEuZaIqFpZ0GjYKiMfr3BnuZ092s
         efr46ndNAO91WZO6+u1/1kyK7Tjxzw8YnAb78nMA/NnDaOW4iJediXZG8Y+5KZTsT//u
         iQag==
X-Gm-Message-State: AOJu0YyzVHfD6TI3grUnd6+X3NatMx1tI75ii4Xyf/6PCJIjp6Cz7b7/
	OEsjkeriJrTsfkdehE/KU9BtK7ApyifvzZ0mC2E=
X-Google-Smtp-Source: AGHT+IGqouCTnS6N/7ThFStfR4tcxC/s+66NrWB6yFeV7y+/uQTfmYJ5ThoycfKhMjilLPpAlSImELxTFWKmcu196/I=
X-Received: by 2002:a05:6402:26c1:b0:523:2e23:a0bf with SMTP id
 x1-20020a05640226c100b005232e23a0bfmr9002766edd.11.1698101452013; Mon, 23 Oct
 2023 15:50:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231019042405.2971130-1-andrii@kernel.org> <20231019042405.2971130-8-andrii@kernel.org>
 <ZTDbGWHu4CnJYWAs@u94a> <ZTDgIyzBX9oZNeFw@u94a> <CAEf4BzYgJR6SAjbvd0uZ6w8D37Sy=Wjd2TROOGEAZDiEq7xb2g@mail.gmail.com>
 <1DA1AC52-6E2D-4CDA-8216-D1DD4648AD55@cs.rutgers.edu> <CAEf4BzbFhA585gSN1YfaDaeEmmUvWSdpMY605fmV_RvSQ7+xeQ@mail.gmail.com>
 <ZTZ9tYlVgt9DVcgi@u94a> <ZTaWo7ZUv9jrfIa4@Mem>
In-Reply-To: <ZTaWo7ZUv9jrfIa4@Mem>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 23 Oct 2023 15:50:40 -0700
Message-ID: <CAEf4BzbJ3hZCSt4nLCZCV4cxV60+kddiSMsy7-9ou_RaQV7B8A@mail.gmail.com>
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

On Mon, Oct 23, 2023 at 8:52=E2=80=AFAM Paul Chaignon <paul@isovalent.com> =
wrote:
>
> On Mon, Oct 23, 2023 at 10:05:41PM +0800, Shung-Hsi Yu wrote:
> > On Sat, Oct 21, 2023 at 09:42:46PM -0700, Andrii Nakryiko wrote:
> > > On Fri, Oct 20, 2023 at 10:37=E2=80=AFAM Srinivas Narayana Ganapathy
> > > <sn624@cs.rutgers.edu> wrote:
> > > >
> > > > Hi all,
> > > >
> > > > Thanks, @Shung-Hsi, for bringing up this conversation about
> > > > integrating formal verification approaches into the BPF CI and test=
ing.
> > > >
> > > > > On 19-Oct-2023, at 1:34 PM, Andrii Nakryiko <andrii.nakryiko@gmai=
l.com> wrote:
> > > > > On Thu, Oct 19, 2023 at 12:52=E2=80=AFAM Shung-Hsi Yu <shung-hsi.=
yu@suse.com> wrote:
> > > > >> On Thu, Oct 19, 2023 at 03:30:33PM +0800, Shung-Hsi Yu wrote:
>
> [...]
>
> > > > >>> FWIW an alternative approach that speeds things up is to use mo=
del checkers
> > > > >>> like Z3 or CBMC. On my laptop, using Z3 to validate tnum_add() =
against *all*
> > > > >>> possible inputs takes less than 1.3 seconds[3] (based on code f=
rom [1]
> > > > >>> paper, but I somehow lost the link to their GitHub repository).
> > > > >>
> > > > >> Found it. For reference, code used in "Sound, Precise, and Fast =
Abstract
> > > > >> Interpretation with Tristate Numbers"[1] can be found at
> > > > >> https://github.com/bpfverif/tnums-cgo22/blob/main/verification/t=
num.py
> > > > >>
> > > > >> Below is a truncated form of the above that only check tnum_add(=
), requires
> > > > >> a package called python3-z3 on most distros:
> > > > >
> > > > > Great! I'd be curious to see how range tracking logic can be enco=
ded
> > > > > using this approach, please give it a go!
> > > >
> > > > We have some recent work that applies formal verification approache=
s
> > > > to the entirety of range tracking in the eBPF verifier. We posted a
> > > > note to the eBPF mailing list about it sometime ago:
> > > >
> > > > [1] https://lore.kernel.org/bpf/SJ2PR14MB6501E906064EE19F5D1666BFF9=
3BA@SJ2PR14MB6501.namprd14.prod.outlook.com/T/#u
> > >
> > > Oh, I totally missed this, as I just went on a long vacation a few
> > > days before that and declared email bankruptcy afterwards. I'll try t=
o
> > > give it a read, though I see lots of math symbols there and make no
> > > promises ;)
> >
> > Feels the same when I start reading their previous work, but I can vouc=
h
> > their work their work are definitely worth the read. (Though I had to a=
dmit
> > I secretly chant "math is easier than code, math is easier than code" t=
o
> > convincing my mind to not go into flight mode when seeing math symbols =
;D
>
> Hari et al. did a great job at explaining the intuitions throughout the
> paper. So even if you skip the math, you should be able to follow.
>
> Having an understanding of abstract interpretation helps. The Mozilla
> wiki has a great one [1] and I wrote a shorter BPF example of it [2].
>
> 1 - https://wiki.mozilla.org/Abstract_Interpretation
> 2 - https://pchaigno.github.io/abstract-interpretation.html
>

thanks :)

> >
> > > > Our paper, also posted on [1], appeared at Computer Aided Verificat=
ion (CAV)=E2=80=9923.
> > > >
> > > > [2] https://people.cs.rutgers.edu/~sn624/papers/agni-cav23.pdf
> > > >
> > > > Together with @Paul Chaignon and @Harishankar Vishwanathan (CC'ed),=
 we
> > > > are working to get our tooling into a form that is integrable into =
BPF
> > > > CI. We will look forward to your feedback when we post patches.
> > >
> > > If this could be integrated in a way that we can regularly run this
> > > and validate latest version of verifier, that would be great. I have =
a
> > > second part of verifier changes coming up that extends range tracking
> > > logic further to support range vs range (as opposed to range vs const
> > > that we do currently) comparisons and is_branch_taken, so having
> > > independent and formal verification of these changes would be great!
>
> The current goal is to have this running somewhere regularly (maybe
> releases + manual triggers) in a semi-automated fashion. The two
> challenges today are the time it takes to run verification (days without
> parallelization) and whether the bit of conversion & glue code will be
> maintanable long term.
>
> I'm fairly optimistic on the first as we're already down to hours with
> basic parallelization. The second is harder to predict, but I guess your
> patches will be a good exercice :)
>
> I've already ran the verification on v6.0 to v6.3; v6.4 is currently
> running. Hari et al. had verified v4.14 to v5.19 before. I'll give it a
> try on this patchset afterward.

Cool, that's great! The second part of this work will be generalizing
this logic in kernel to support range vs range comparisons, so I'd
appreciate it if you could validate that one as well. I'm finalizing
it, but will wait for this patch set to land first before posting
second part to have a proper CI testing runs (and limit amount of code
review to be done).

BTW, I've since did some more changes to this "selftests" to be a bit
more parallelizable, so this range_vs_consts set of tests now can run
in about 5 minutes on 8+ core QEMU instance. In the second part we'll
have range-vs-range, so we have about 106 million cases and it takes
slightly more than 8 hours single-threaded. But with parallelization,
it's done in slightly more than one hour.

So, of course, still too slow to run as part of normal test_progs run,
but definitely easy to run locally to validate kernel changes (and
probably makes sense to enable on some nightly CI runs, when we have
them).

Regardless, my point is that both methods of verification are
complementary, I think, and it's good to have both available and
working on latest kernel versions.


>
> >
> > +1 (from a quick skim) this work is already great as-is, and it'd be ev=
en
> > better once it get's in the CI. From the paper there's this
> >
> >   We conducted our experiments on ... a machine with two 10-core Intel
> >   Skylake CPUs running at 2.20 GHz with 192 GB of memory...
> >
> > I suppose the memory requirement comes from the vast amount of state sp=
ace
> > that the Z3 SMT solver have to go through, and perhaps that poses a
> > challenge for CI integration?
> >
> > Just wondering is there are some low-hanging fruit the can make things
> > easier for the SMT solver.
>
> This is how much memory the system had, but it didn't use it all :)
> When running the solver on a single core, I saw around 1GB of memory
> usage. With my changes to run on several cores, it can grow to a few
> GBs depending on the number of cores.
>
> --
> Paul

