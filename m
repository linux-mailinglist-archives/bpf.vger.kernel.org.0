Return-Path: <bpf+bounces-13014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 823037D3B7F
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 17:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3706328162D
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 15:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EC01C6BC;
	Mon, 23 Oct 2023 15:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="hGvilwQ2"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683EE1427E
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 15:52:10 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA64FF
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 08:52:07 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40838915cecso28772255e9.2
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 08:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1698076326; x=1698681126; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BRPGgTEUARbMnsGporLeM6Uk6tu4EWuryvS3FhyPA7s=;
        b=hGvilwQ2YUJzQ1H6rOy/AF59DoXePIoYq38XBy+IjIK3Q593gD3rx6PodThvd7EJaG
         m060e7o1xsenv33oBnLp5Cd505I9ajlEJiFYO2pU5p1T0iUyu4J9/lqH1C9AmjH/u5Qm
         aTROcjwOhXkvlpYNbLE9e/J1smBbcVhXTOlNRILvpQOYksQGS+1AUiXDY6WvwNa77bcB
         oL5Gaz6st5iuDsTYEst/5ERtapXtOA8PdgY8+SxooW61UZIz0JcLSyD9FXWcsY5B9FNI
         Krqa4m73emafKekgV4MVWL1rvvEeSQ2C8dE4MlVIX9zjcQHalv//4PVrOoaFX0YobZtO
         h2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698076326; x=1698681126;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BRPGgTEUARbMnsGporLeM6Uk6tu4EWuryvS3FhyPA7s=;
        b=NvMuQ3iadqyeSeFlRw+B4t8DawgaDpO/4INm/go1mZRf/DqsvlfoD99n+Scvct3SpG
         M/1Os9cvttm+Ftz3vaLUs19FK5rFNjMpreJfmCwBTR5DHLfwmYncBvBsYavc7RIFvXd0
         uj5zNAEkRkrodTCkxkooISI2SUfqaWR5m6+hp29Jjjxbgbz8u639T3EwrhzulRIJF8d+
         Z4W5p/x4sY1KzpFUrxq3JR671n+tR1U0EceUN8wuj0f+YWNyz4ASBXswtFM588FuVrSP
         elOfWpE5pSNea3B45GXNkV2G6VM7SXfeRGwGhLcadqFVl/5wAQszWQQF4XoFVKNeOe5/
         XMGA==
X-Gm-Message-State: AOJu0Yw0mYG0f5YzjvoEZel7mv02222s1jVSa6uqALtRK0bLgFWbTyux
	AhHDTQbtuEi+92lFoafMyTnY
X-Google-Smtp-Source: AGHT+IH2aCLDUrmjHkqhsDZvITRd7Xen6+hgNcvWkelPqIqWINrbsFODGBjysv7Mu/XSV2i82pixKA==
X-Received: by 2002:a05:600c:5254:b0:405:3dd0:6ee9 with SMTP id fc20-20020a05600c525400b004053dd06ee9mr7194772wmb.34.1698076325724;
        Mon, 23 Oct 2023 08:52:05 -0700 (PDT)
Received: from Mem (2a01cb0890a26e0047713f6c25756fbd.ipv6.abo.wanadoo.fr. [2a01:cb08:90a2:6e00:4771:3f6c:2575:6fbd])
        by smtp.gmail.com with ESMTPSA id b13-20020a05600c11cd00b0040770ec2c19sm14458189wmi.10.2023.10.23.08.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 08:52:05 -0700 (PDT)
Date: Mon, 23 Oct 2023 17:52:03 +0200
From: Paul Chaignon <paul@isovalent.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Srinivas Narayana Ganapathy <sn624@cs.rutgers.edu>,
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
	Paul Chaignon <paul.chaignon@gmail.com>
Subject: Re: [PATCH v2 bpf-next 7/7] selftests/bpf: BPF register range bounds
 tester
Message-ID: <ZTaWo7ZUv9jrfIa4@Mem>
References: <20231019042405.2971130-1-andrii@kernel.org>
 <20231019042405.2971130-8-andrii@kernel.org>
 <ZTDbGWHu4CnJYWAs@u94a>
 <ZTDgIyzBX9oZNeFw@u94a>
 <CAEf4BzYgJR6SAjbvd0uZ6w8D37Sy=Wjd2TROOGEAZDiEq7xb2g@mail.gmail.com>
 <1DA1AC52-6E2D-4CDA-8216-D1DD4648AD55@cs.rutgers.edu>
 <CAEf4BzbFhA585gSN1YfaDaeEmmUvWSdpMY605fmV_RvSQ7+xeQ@mail.gmail.com>
 <ZTZ9tYlVgt9DVcgi@u94a>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZTZ9tYlVgt9DVcgi@u94a>

On Mon, Oct 23, 2023 at 10:05:41PM +0800, Shung-Hsi Yu wrote:
> On Sat, Oct 21, 2023 at 09:42:46PM -0700, Andrii Nakryiko wrote:
> > On Fri, Oct 20, 2023 at 10:37 AM Srinivas Narayana Ganapathy
> > <sn624@cs.rutgers.edu> wrote:
> > >
> > > Hi all,
> > >
> > > Thanks, @Shung-Hsi, for bringing up this conversation about
> > > integrating formal verification approaches into the BPF CI and testing.
> > >
> > > > On 19-Oct-2023, at 1:34 PM, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > > > On Thu, Oct 19, 2023 at 12:52 AM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> > > >> On Thu, Oct 19, 2023 at 03:30:33PM +0800, Shung-Hsi Yu wrote:

[...]

> > > >>> FWIW an alternative approach that speeds things up is to use model checkers
> > > >>> like Z3 or CBMC. On my laptop, using Z3 to validate tnum_add() against *all*
> > > >>> possible inputs takes less than 1.3 seconds[3] (based on code from [1]
> > > >>> paper, but I somehow lost the link to their GitHub repository).
> > > >>
> > > >> Found it. For reference, code used in "Sound, Precise, and Fast Abstract
> > > >> Interpretation with Tristate Numbers"[1] can be found at
> > > >> https://github.com/bpfverif/tnums-cgo22/blob/main/verification/tnum.py
> > > >>
> > > >> Below is a truncated form of the above that only check tnum_add(), requires
> > > >> a package called python3-z3 on most distros:
> > > >
> > > > Great! I'd be curious to see how range tracking logic can be encoded
> > > > using this approach, please give it a go!
> > >
> > > We have some recent work that applies formal verification approaches
> > > to the entirety of range tracking in the eBPF verifier. We posted a
> > > note to the eBPF mailing list about it sometime ago:
> > >
> > > [1] https://lore.kernel.org/bpf/SJ2PR14MB6501E906064EE19F5D1666BFF93BA@SJ2PR14MB6501.namprd14.prod.outlook.com/T/#u
> > 
> > Oh, I totally missed this, as I just went on a long vacation a few
> > days before that and declared email bankruptcy afterwards. I'll try to
> > give it a read, though I see lots of math symbols there and make no
> > promises ;)
> 
> Feels the same when I start reading their previous work, but I can vouch
> their work their work are definitely worth the read. (Though I had to admit
> I secretly chant "math is easier than code, math is easier than code" to
> convincing my mind to not go into flight mode when seeing math symbols ;D

Hari et al. did a great job at explaining the intuitions throughout the
paper. So even if you skip the math, you should be able to follow.

Having an understanding of abstract interpretation helps. The Mozilla
wiki has a great one [1] and I wrote a shorter BPF example of it [2].

1 - https://wiki.mozilla.org/Abstract_Interpretation
2 - https://pchaigno.github.io/abstract-interpretation.html

> 
> > > Our paper, also posted on [1], appeared at Computer Aided Verification (CAV)’23.
> > >
> > > [2] https://people.cs.rutgers.edu/~sn624/papers/agni-cav23.pdf
> > >
> > > Together with @Paul Chaignon and @Harishankar Vishwanathan (CC'ed), we
> > > are working to get our tooling into a form that is integrable into BPF
> > > CI. We will look forward to your feedback when we post patches.
> > 
> > If this could be integrated in a way that we can regularly run this
> > and validate latest version of verifier, that would be great. I have a
> > second part of verifier changes coming up that extends range tracking
> > logic further to support range vs range (as opposed to range vs const
> > that we do currently) comparisons and is_branch_taken, so having
> > independent and formal verification of these changes would be great!

The current goal is to have this running somewhere regularly (maybe
releases + manual triggers) in a semi-automated fashion. The two
challenges today are the time it takes to run verification (days without
parallelization) and whether the bit of conversion & glue code will be
maintanable long term.

I'm fairly optimistic on the first as we're already down to hours with
basic parallelization. The second is harder to predict, but I guess your
patches will be a good exercice :)

I've already ran the verification on v6.0 to v6.3; v6.4 is currently
running. Hari et al. had verified v4.14 to v5.19 before. I'll give it a
try on this patchset afterward.

> 
> +1 (from a quick skim) this work is already great as-is, and it'd be even
> better once it get's in the CI. From the paper there's this
> 
>   We conducted our experiments on ... a machine with two 10-core Intel
>   Skylake CPUs running at 2.20 GHz with 192 GB of memory...
> 
> I suppose the memory requirement comes from the vast amount of state space
> that the Z3 SMT solver have to go through, and perhaps that poses a
> challenge for CI integration?
> 
> Just wondering is there are some low-hanging fruit the can make things
> easier for the SMT solver.

This is how much memory the system had, but it didn't use it all :)
When running the solver on a single core, I saw around 1GB of memory
usage. With my changes to run on several cores, it can grow to a few
GBs depending on the number of cores.

--
Paul

