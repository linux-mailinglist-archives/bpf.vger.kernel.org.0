Return-Path: <bpf+bounces-146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 079636F8A5F
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 22:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45B251C21710
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 20:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB60D2F5;
	Fri,  5 May 2023 20:49:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310422F33
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 20:49:06 +0000 (UTC)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37E71984;
	Fri,  5 May 2023 13:49:04 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-b9d8730fe5aso3052293276.1;
        Fri, 05 May 2023 13:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683319744; x=1685911744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDe8ZfXyzW9pc+3/vB3tIdG+hkI+ElgK80U8Mo8x89U=;
        b=C0GWICo+QwGWEBLx61rPsZD5DVSfcL2xBbN8ZAQlJ1X3Cry9gd/KO3aRIMb/UzDfyP
         XcxlYTIq6yIf7/n+26+oAfw/dU418f2FhsrzTgNd/+UYuL/MNAz24V7gOYmVgXqA/tiO
         0flb7FMNp9GfWY3hHa+etbwAZHkLvdn9ZOEP7HMaw7ULQyC6THmvW7XlfZlXWZdFamFU
         wowIM+R1aI1AcfiwnEh8a4uwqieAcDSBkwxFU3Jb1WZneYp7w3PjqK/aOI1akTy+UbQi
         60fRBMcLRNMU3kxqJ7VHLB2A21gCTZUJGaCbmAGNw4DbcdAy1Kx0RGdVgncMdkw2C/xw
         bt/Q==
X-Gm-Message-State: AC+VfDwtO/Zb54OdLOTZhEpcxunkyvQrqstnSsOkvAvCx8WyicivbJIw
	JxX1QbqSptQKxOIJqJNdqra+67/gKQym4O7E7+o=
X-Google-Smtp-Source: ACHHUZ6/g3H45+NO2l/LcXgWKIrU0eM72lDJycRhXIiWCPy1FeZCU0gud3grVcNGXU2Cx0wweHr2bOb3pztjimFmm3Y=
X-Received: by 2002:a25:e092:0:b0:b9e:4d05:1f97 with SMTP id
 x140-20020a25e092000000b00b9e4d051f97mr3070988ybg.41.1683319743912; Fri, 05
 May 2023 13:49:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wgv1sKTdLWPC7XR1Px=pDNrDPDTKdX-T_2AQOwgkpWB2A@mail.gmail.com>
 <ZFPw0scDq1eIzfHr@kernel.org> <CAEf4BzaUU9vZU6R_020ru5ct0wh-p1M3ZFet-vYqcHvb9bW1Cw@mail.gmail.com>
 <ZFQCccsx6GK+gY0j@kernel.org> <ZFQoQjCNtyMIulp+@kernel.org>
 <CAP-5=fU8HQorW+7O6vfEKGs1mEFkjkzXZMVPACzurtcMcRhVzQ@mail.gmail.com>
 <ZFQ5sjjtfEYzvHNP@krava> <ZFUFmxDU/6Z/JEsi@kernel.org> <ZFU1PJrn8YtHIqno@kernel.org>
 <CAP-5=fWfmmMCRnEmzj_CXTKacp6gjrzmR49Ge_C5XRyfTegRjg@mail.gmail.com>
 <ZFVqeKLssg7uzxzI@krava> <CAP-5=fVgJdBvjV8S2xKswAFiSZvyCcUvZTO1bsLyUf-wQ0pBuw@mail.gmail.com>
In-Reply-To: <CAP-5=fVgJdBvjV8S2xKswAFiSZvyCcUvZTO1bsLyUf-wQ0pBuw@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 5 May 2023 13:48:52 -0700
Message-ID: <CAM9d7cjrZ-sHhO1ErqVdrN8Vv-ocCmsONc443yoPiCvnoiXj9A@mail.gmail.com>
Subject: Re: [PATCH RFC/RFT] perf bpf skels: Stop using vmlinux.h generated
 from BTF, use subset of used structs + CO-RE. was Re: BPF skels in perf .Re:
 [GIT PULL] perf tools changes for v6.4
To: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Song Liu <song@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Clark Williams <williams@redhat.com>, 
	Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	Changbin Du <changbin.du@huawei.com>, Hao Luo <haoluo@google.com>, 
	James Clark <james.clark@arm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Roman Lozko <lozko.roma@gmail.com>, Stephane Eranian <eranian@google.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Yang Jihong <yangjihong1@huawei.com>, 
	Mark Rutland <mark.rutland@arm.com>, Paul Clarke <pc@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, May 5, 2023 at 1:46=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Fri, May 5, 2023 at 1:43=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wro=
te:
> >
> > On Fri, May 05, 2023 at 10:04:47AM -0700, Ian Rogers wrote:
> > > On Fri, May 5, 2023 at 9:56=E2=80=AFAM Arnaldo Carvalho de Melo <acme=
@kernel.org> wrote:
> > > >
> > > > Em Fri, May 05, 2023 at 10:33:15AM -0300, Arnaldo Carvalho de Melo =
escreveu:
> > > > > Em Fri, May 05, 2023 at 01:03:14AM +0200, Jiri Olsa escreveu:
> > > > > That with the preserve_access_index isn't needed, we need just th=
e
> > > > > fields that we access in the tools, right?
> > > >
> > > > I'm now doing build test this in many distro containers, without th=
e two
> > > > reverts, i.e. BPF skels continue as opt-out as in my pull request, =
to
> > > > test build and also for the functionality tests on the tools using =
such
> > > > bpf skels, see below, no touching of vmlinux nor BTF data during th=
e
> > > > build.
> > > >
> > > > - Arnaldo
> > > >
> > > > From 882adaee50bc27f85374aeb2fbaa5b76bef60d05 Mon Sep 17 00:00:00 2=
001
> > > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > Date: Thu, 4 May 2023 19:03:51 -0300
> > > > Subject: [PATCH 1/1] perf bpf skels: Stop using vmlinux.h generated=
 from BTF,
> > > >  use subset of used structs + CO-RE
> > > >
> > > > Linus reported a build break due to using a vmlinux without a BTF e=
lf
> > > > section to generate the vmlinux.h header with bpftool for use in th=
e BPF
> > > > tools in tools/perf/util/bpf_skel/*.bpf.c.
> > > >
> > > > Instead add a vmlinux.h file with the structs needed with the field=
s the
> > > > tools need, marking the structs with __attribute__((preserve_access=
_index)),
> > > > so that libbpf's CO-RE code can fixup the struct field offsets.
> > > >
> > > > In some cases the vmlinux.h file that was being generated by bpftoo=
l
> > > > from the kernel BTF information was not needed at all, just includi=
ng
> > > > linux/bpf.h, sometimes linux/perf_event.h was enough as non-UAPI
> > > > types were not being used.
> > > >
> > > > To keep te patch small, include those UAPI headers from the trimmed=
 down
> > > > vmlinux.h file, that then provides the tools with just the structs =
and
> > > > the subset of its fields needed for them.
> > > >
> > > > Testing it:
> > > >
> > > >   # perf lock contention -b find / > /dev/null
> >
> > I tested perf lock con -abv -L rcu_state sleep 1
> > and needed fix below
> >
> > jirka
>
> I thought this was fixed by:
> https://lore.kernel.org/lkml/20230427234833.1576130-1-namhyung@kernel.org=
/
> but I think that is just in perf-tools-next.

Right, but we might still need the empty rq definition.

Thanks,
Namhyung

