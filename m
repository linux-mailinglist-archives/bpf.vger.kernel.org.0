Return-Path: <bpf+bounces-11280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B867B6BA5
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 16:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id EB16C281BB0
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 14:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2163731A99;
	Tue,  3 Oct 2023 14:31:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A2B328C5;
	Tue,  3 Oct 2023 14:31:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346B1C433AB;
	Tue,  3 Oct 2023 14:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696343515;
	bh=lXhzkTduNuZuLROT+iBijIF0A95RJ4ufla0K1M+opJU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XWN4Rh+E9PDsO4VJBGGuVKpVRJYentIfOH5cUNSV4YsQXcxcfh+5TOv+KDW4/F2lX
	 GqyZ3M9cwIlXcaVvfnRmSsVr1jE95FEf4gmxD+5T3wMNlXxm7lGn0vXfOO7BA9OWai
	 nzhIKizki4ZClwnaUR9mWn983p4DbniY5CBrYQ9unOLpCcBF5vqTIBMHBsRqi5srM6
	 I73TD0/hZ75Elw4NNXIWRx5bOCQEJN5Nu7dhqLdqeuWjnVPgrLICR3WE+Bm/FJW+F0
	 CgM4x4BcujSNtF8YPbAq56KVmRw69vvzH9PiNnUWOxSA5Bp2n191ZC5Vf7/J2UpW03
	 dBShZRWhHputA==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1dd78b46995so573512fac.3;
        Tue, 03 Oct 2023 07:31:55 -0700 (PDT)
X-Gm-Message-State: AOJu0YxKDmBiLzM6XUAX5IeIEX/EBpifsXltFP7tG+pRMXCYmupMtiqT
	mG51/LKxcDsNPWIcZmT1pv8kWNQcPBxAiX5VtNM=
X-Google-Smtp-Source: AGHT+IHvgi3RUwAtU8o2TSnqWVl6ZIGHcXUxqTE98xQ5+4sN2wMbW6gAQ7JaGuG4c0k+cTUDcFcXo0d6wlrEHUEuV4A=
X-Received: by 2002:a05:6870:2314:b0:1c8:bfd1:ecc0 with SMTP id
 w20-20020a056870231400b001c8bfd1ecc0mr14691547oao.0.1696343514186; Tue, 03
 Oct 2023 07:31:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230923053515.535607-1-irogers@google.com> <20230923053515.535607-2-irogers@google.com>
 <CAKwvOdmHg_43z_dTZrOLGubuBBvmHdPxSFjOWa3oWkbOp2qWWg@mail.gmail.com>
 <CAP-5=fV6c1tWAd2GjMwn4PQN=3BXNQGz=vbonHSjRjQ3fbEL+g@mail.gmail.com> <ZRWMWcNKvZMgiAMR@bergen.fjasle.eu>
In-Reply-To: <ZRWMWcNKvZMgiAMR@bergen.fjasle.eu>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 3 Oct 2023 23:31:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNASuOWtd-iv2C3HLWr1oq9gD8BiP4B=8wRUo81CSK=g5Yw@mail.gmail.com>
Message-ID: <CAK7LNASuOWtd-iv2C3HLWr1oq9gD8BiP4B=8wRUo81CSK=g5Yw@mail.gmail.com>
Subject: Re: [PATCH v1 01/18] gen_compile_commands: Allow the line prefix to
 still be cmd_
To: Nicolas Schier <nicolas@fjasle.eu>
Cc: Ian Rogers <irogers@google.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ming Wang <wangming01@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Yuan Can <yuancan@huawei.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, James Clark <james.clark@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2023 at 11:26=E2=80=AFPM Nicolas Schier <nicolas@fjasle.eu>=
 wrote:
>
> On Mon, 25 Sep 2023 09:06:11 -0700, Ian Rogers wrote:
> > On Mon, Sep 25, 2023 at 8:49=E2=80=AFAM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > On Fri, Sep 22, 2023 at 10:35=E2=80=AFPM Ian Rogers <irogers@google.c=
om> wrote:
> > > >
> > > > Builds in tools still use the cmd_ prefix in .cmd files, so don't
> > > > require the saved part. Name the groups in the line pattern match s=
o
> > >
> > > Is that something that can be changed in the tools/ Makefiles?
> > >
> > > I'm fine with this change, just curious where the difference comes
> > > from precisely.
> > > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> > I agree. The savedcmd_ change came from Masahiro in:
> > https://lore.kernel.org/lkml/20221229091501.916296-1-masahiroy@kernel.o=
rg/
> > I was reluctant to change the build logic in tools/ because of the
> > potential to break things. Maybe Masahiro/Nicolas know of issues?
>
> I haven't seen any issues related to the introduction of savedcmd_; and
> roughly searching through tools/ I cannot find a rule that matches the
> pattern Masahiro described in commit 92215e7a801d ("kbuild: rename
> cmd_$@ to savedcmd_$@ in *.cmd files", 2022-12-29).  For consistency,
> I'd like to see the build rules in tools/ re-use the ones from scripts/
> but as of now I don't see any necessity to introduce savedcmd in
> tools/, yet.
>
> Kind regards,
> Nicolas


tools/build/Build.include mimics scripts/Kbuild.include

That should be changed in the same way.


--=20
Best Regards
Masahiro Yamada

