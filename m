Return-Path: <bpf+bounces-12921-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA98D7D2104
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 06:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C802B1C209E7
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 04:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A302ECD;
	Sun, 22 Oct 2023 04:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCl+gpCc"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC3B36A
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 04:43:00 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34155B4
	for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 21:42:59 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99de884ad25so326584666b.3
        for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 21:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697949777; x=1698554577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slgTn7f6Evho6VfvPT/cmrwLs1CTQFl+4z80cmbj4a4=;
        b=lCl+gpCcE3LXbTxF24SkTJLKZonYFfXvDifh3A56AWf3tA4wAvjWbJbFHlww3qvXwi
         mmBuOEhQhVoXM+cwCuiLiOqAkiqVWKrtPaGZwvNkraUXurMj+6aYCfEMO0QqTiVgMeA9
         IRS2tKszu+Tq9ssntLOo3rXizCrwHeL/ejeB5ff1LIiRwksFTsAXCSlnKJGZU5y+NBZc
         DYybthMKFP91TEFDU5S+Cu/QZcZwj3stWDLNJuGa9gSeS4baFAtt3jq7QCcoXiN1jbRz
         pH6fKclU4jwcQ2EzH62orXkySYQCw1jOt4Umf8Us+IKFWHjAvFcI568ELcAFatbCeCpx
         38TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697949777; x=1698554577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slgTn7f6Evho6VfvPT/cmrwLs1CTQFl+4z80cmbj4a4=;
        b=GjQKPT59o6KEmwBKFzz9uPgoTzhR4hSU7HyOF3M6pyn+/X/leJBQJg7NUdkjikMf4a
         4NNkHMOnSFteHnCaRaksF9lwsXOPwtyP4u2f+6eZG7e/CtflXaQxW5Sosp1O4KN7kx9u
         CVpIcCcUHj8jPWqh5u7+4rZw3LDC9zTI5Om6zDsnKGhcUvHWJ7FrVGCSSlbhUxEmaaYi
         qBXK5efHOPdAqEzi/9PXhQptjgOD2NTAJAj/a5UfGO29lcmWXpaD64bAOLsRQ3ELHkIu
         eqCSr1s3wwaR2YTHxJgv63eKP2ekX6FstVecz7svvjlICuA4yCC80DaFzBb8f6OKPsoR
         8QsA==
X-Gm-Message-State: AOJu0YyvoKdmYVMACMlvdARpKS6bLR3fVugERxILGSQp6MdtUhp27FSR
	lnw2T7WRhcW5yeG9je4QzKlUGawcN7lS3by6BLQ=
X-Google-Smtp-Source: AGHT+IG/kyFPf1NMsmfhCaoQTVzT9znnlMB3pxFURjYytgao4fKaVPbRAi7/NaWXgqd1jCn/9y1YzSbd71H7ipZLVoM=
X-Received: by 2002:a17:907:25c3:b0:9bf:a614:9a2e with SMTP id
 ae3-20020a17090725c300b009bfa6149a2emr4920990ejc.61.1697949777314; Sat, 21
 Oct 2023 21:42:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231019042405.2971130-1-andrii@kernel.org> <20231019042405.2971130-8-andrii@kernel.org>
 <ZTDbGWHu4CnJYWAs@u94a> <ZTDgIyzBX9oZNeFw@u94a> <CAEf4BzYgJR6SAjbvd0uZ6w8D37Sy=Wjd2TROOGEAZDiEq7xb2g@mail.gmail.com>
 <1DA1AC52-6E2D-4CDA-8216-D1DD4648AD55@cs.rutgers.edu>
In-Reply-To: <1DA1AC52-6E2D-4CDA-8216-D1DD4648AD55@cs.rutgers.edu>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Sat, 21 Oct 2023 21:42:46 -0700
Message-ID: <CAEf4BzbFhA585gSN1YfaDaeEmmUvWSdpMY605fmV_RvSQ7+xeQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 7/7] selftests/bpf: BPF register range bounds tester
To: Srinivas Narayana Ganapathy <sn624@cs.rutgers.edu>
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Langston Barrett <langston.barrett@gmail.com>, 
	Srinivas Narayana <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte <sn349@cs.rutgers.edu>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "martin.lau@kernel.org" <martin.lau@kernel.org>, 
	"kernel-team@meta.com" <kernel-team@meta.com>, 
	Harishankar Vishwanathan <harishankar.vishwanathan@rutgers.edu>, 
	Matan Shachnai <m.shachnai@rutgers.edu>, Paul Chaignon <paul@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 10:37=E2=80=AFAM Srinivas Narayana Ganapathy
<sn624@cs.rutgers.edu> wrote:
>
> Hi all,
>
> Thanks, @Shung-Hsi, for bringing up this conversation about
> integrating formal verification approaches into the BPF CI and testing.
>
> > On 19-Oct-2023, at 1:34 PM, Andrii Nakryiko <andrii.nakryiko@gmail.com>=
 wrote:
> >
> > On Thu, Oct 19, 2023 at 12:52=E2=80=AFAM Shung-Hsi Yu <shung-hsi.yu@sus=
e.com> wrote:
> >>
> >> On Thu, Oct 19, 2023 at 03:30:33PM +0800, Shung-Hsi Yu wrote:
> >>> On Wed, Oct 18, 2023 at 09:24:05PM -0700, Andrii Nakryiko wrote:
> >>>> Add tests that validate correctness and completeness of BPF verifier=
's
> >>>> register range bounds.
> >>>
> >>> Nitpick: in abstract-interpretation-speak, completeness seems to mean
> >>> something different. I believe what we're trying to check here is
> >>> soundness[1], again, in abstraction-interpretation-speak), so using
> >>> completeness here may be misleading to some. (I'll leave explanation =
to
> >>> other that understand this concept better than I do, rather than maki=
ng an
> >>> ill attempt that would probably just make things worst)
> >>>
> >>>> The main bulk is a lot of auto-generated tests based on a small set =
of
> >>>> seed values for lower and upper 32 bits of full 64-bit values.
> >>>> Currently we validate only range vs const comparisons, but the idea =
is
> >>>> to start validating range over range comparisons in subsequent patch=
 set.
> >>>
> >>> CC Langston Barrett who had previously send kunit-based tnum checks[2=
] a
> >>> while back. If this patch is merged, perhaps we can consider adding
> >>> validation for tnum as well in the future using similar framework.
> >>>
> >>> More comments below
> >>>
> >>>> When setting up initial register ranges we treat registers as one of
> >>>> u64/s64/u32/s32 numeric types, and then independently perform condit=
ional
> >>>> comparisons based on a potentially different u64/s64/u32/s32 types. =
This
> >>>> tests lots of tricky cases of deriving bounds information across
> >>>> different numeric domains.
> >>>>
> >>>> Given there are lots of auto-generated cases, we guard them behind
> >>>> SLOW_TESTS=3D1 envvar requirement, and skip them altogether otherwis=
e.
> >>>> With current full set of upper/lower seed value, all supported
> >>>> comparison operators and all the combinations of u64/s64/u32/s32 num=
ber
> >>>> domains, we get about 7.7 million tests, which run in about 35 minut=
es
> >>>> on my local qemu instance. So it's something that can be run manuall=
y
> >>>> for exhaustive check in a reasonable time, and perhaps as a nightly =
CI
> >>>> test, but certainly is too slow to run as part of a default test_pro=
gs run.
> >>>
> >>> FWIW an alternative approach that speeds things up is to use model ch=
eckers
> >>> like Z3 or CBMC. On my laptop, using Z3 to validate tnum_add() agains=
t *all*
> >>> possible inputs takes less than 1.3 seconds[3] (based on code from [1=
]
> >>> paper, but I somehow lost the link to their GitHub repository).
> >>
> >> Found it. For reference, code used in "Sound, Precise, and Fast Abstra=
ct
> >> Interpretation with Tristate Numbers"[1] can be found at
> >> https://github.com/bpfverif/tnums-cgo22/blob/main/verification/tnum.py
> >>
> >> Below is a truncated form of the above that only check tnum_add(), req=
uires
> >> a package called python3-z3 on most distros:
> >
> > Great! I'd be curious to see how range tracking logic can be encoded
> > using this approach, please give it a go!
> >
>
> We have some recent work that applies formal verification approaches
> to the entirety of range tracking in the eBPF verifier. We posted a
> note to the eBPF mailing list about it sometime ago:
>
> [1] https://lore.kernel.org/bpf/SJ2PR14MB6501E906064EE19F5D1666BFF93BA@SJ=
2PR14MB6501.namprd14.prod.outlook.com/T/#u
>

Oh, I totally missed this, as I just went on a long vacation a few
days before that and declared email bankruptcy afterwards. I'll try to
give it a read, though I see lots of math symbols there and make no
promises ;)

> Our paper, also posted on [1], appeared at Computer Aided Verification (C=
AV)=E2=80=9923.
>
> [2] https://people.cs.rutgers.edu/~sn624/papers/agni-cav23.pdf
>
> Together with @Paul Chaignon and @Harishankar Vishwanathan (CC'ed), we
> are working to get our tooling into a form that is integrable into BPF
> CI. We will look forward to your feedback when we post patches.

If this could be integrated in a way that we can regularly run this
and validate latest version of verifier, that would be great. I have a
second part of verifier changes coming up that extends range tracking
logic further to support range vs range (as opposed to range vs const
that we do currently) comparisons and is_branch_taken, so having
independent and formal verification of these changes would be great!

>
> Thanks,
>
> --
> Srinivas
> The fastest algorithm can frequently be replaced by one that is almost as=
 fast and much easier to understand.
>

