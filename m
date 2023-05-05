Return-Path: <bpf+bounces-150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5896F8AAA
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 23:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14FBF1C21905
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 21:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AB6D305;
	Fri,  5 May 2023 21:22:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD839C12D
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 21:22:17 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A46A3;
	Fri,  5 May 2023 14:22:10 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bc22805d3so3530081a12.1;
        Fri, 05 May 2023 14:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683321728; x=1685913728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9iSu+Yykp6XGckSvEiitdzG1woWv/JpoYcxey89suLQ=;
        b=VD5uT5M9IjT9ROk4WPIHEMcVdkhE8+7NWpHk/h9xbqRUtJ8PWIX+bspAlxGvU6UrL8
         30d8m+tjMsEcXZhA1bB+XnUnfBj89Q3v+Mmmo454J40Om2cCTMQtmAfpS2ADjo/JN4Ke
         6VxuOnkulrMrsrzzRRETm4vSf723x0QsSuYp/MATl3/9aTTDqe0MMGVsi5Zaj50lSyoU
         HYKfDsJq/J8Q5BnWfTubDpYBfDhhUWlkc3SLKKle1dLhJnHiQgauhZpmM4YhcwA8WOZm
         UvhNmrt+zoEiMxn2sMFW+/ylg/QH9i5ewSp84IQBkXtlpfUHBTJw3OrQRzfCbwIF7sAf
         Tlfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683321728; x=1685913728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9iSu+Yykp6XGckSvEiitdzG1woWv/JpoYcxey89suLQ=;
        b=CdDYj20Heil5vTUshcyFfk18pfOzpRw6cO6PmIDKz/MbwSxBStmp+ghNujwfok6uET
         dbsQCcMfuka1KbqFcVMqjcXZFRvloYb/+0jrMBLvI49omSPt8WsjDv14vO/fWW4U9HoM
         U+dXyA/pyjRH4T+QerOcF953uG1YV/TbT+IJSccSa+jKvfRLQOVYqG6ET8wSkujFL+yM
         E9SLgj/I4UvyWxuben+u5JQiY0gkBDEaeQkzTbrecO1o7kljKCRi5KOWGP5wa3EfKr9x
         qoPasmx5KNdVRD30CnFwCEuuf95iPM7lIUQSY7vAdwAWurbL8TsKPI1u2wM1tqedLpP7
         ZzhQ==
X-Gm-Message-State: AC+VfDy2UyuST2ibWobvZz3qj7QvsfJSSlh9UA+dfXyj5s4GtzA/xMPt
	rMwxUYgFwOuvPa0YaIRzCs3kGwq0imr7v/YOzFc=
X-Google-Smtp-Source: ACHHUZ4inE3IFmp7bzuGEVS9Lf1HC1e+A+ZBT+X3hlIu9RP95DVNBSVhf7tY2gHk8Lj67faiequkP5UAeZL5hcCO15M=
X-Received: by 2002:a17:906:fd83:b0:94a:845c:3529 with SMTP id
 xa3-20020a170906fd8300b0094a845c3529mr2580529ejb.9.1683321728433; Fri, 05 May
 2023 14:22:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzaUU9vZU6R_020ru5ct0wh-p1M3ZFet-vYqcHvb9bW1Cw@mail.gmail.com>
 <ZFQCccsx6GK+gY0j@kernel.org> <ZFQoQjCNtyMIulp+@kernel.org>
 <CAP-5=fU8HQorW+7O6vfEKGs1mEFkjkzXZMVPACzurtcMcRhVzQ@mail.gmail.com>
 <ZFQ5sjjtfEYzvHNP@krava> <ZFUFmxDU/6Z/JEsi@kernel.org> <ZFU1PJrn8YtHIqno@kernel.org>
 <CAP-5=fWfmmMCRnEmzj_CXTKacp6gjrzmR49Ge_C5XRyfTegRjg@mail.gmail.com>
 <ZFVqeKLssg7uzxzI@krava> <CAP-5=fVgJdBvjV8S2xKswAFiSZvyCcUvZTO1bsLyUf-wQ0pBuw@mail.gmail.com>
 <ZFVyAap3R9RZ+P6u@krava>
In-Reply-To: <ZFVyAap3R9RZ+P6u@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 May 2023 14:21:56 -0700
Message-ID: <CAEf4BzYYnpD6+GSg+wfL1wUY5YasbN2-9NPJ3QkGZ9o963uYdA@mail.gmail.com>
Subject: Re: [PATCH RFC/RFT] perf bpf skels: Stop using vmlinux.h generated
 from BTF, use subset of used structs + CO-RE. was Re: BPF skels in perf .Re:
 [GIT PULL] perf tools changes for v6.4
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Namhyung Kim <namhyung@kernel.org>, 
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, May 5, 2023 at 2:15=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Fri, May 05, 2023 at 01:46:30PM -0700, Ian Rogers wrote:
> > On Fri, May 5, 2023 at 1:43=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> w=
rote:
> > >
> > > On Fri, May 05, 2023 at 10:04:47AM -0700, Ian Rogers wrote:
> > > > On Fri, May 5, 2023 at 9:56=E2=80=AFAM Arnaldo Carvalho de Melo <ac=
me@kernel.org> wrote:
> > > > >
> > > > > Em Fri, May 05, 2023 at 10:33:15AM -0300, Arnaldo Carvalho de Mel=
o escreveu:
> > > > > > Em Fri, May 05, 2023 at 01:03:14AM +0200, Jiri Olsa escreveu:
> > > > > > That with the preserve_access_index isn't needed, we need just =
the
> > > > > > fields that we access in the tools, right?
> > > > >
> > > > > I'm now doing build test this in many distro containers, without =
the two
> > > > > reverts, i.e. BPF skels continue as opt-out as in my pull request=
, to
> > > > > test build and also for the functionality tests on the tools usin=
g such
> > > > > bpf skels, see below, no touching of vmlinux nor BTF data during =
the
> > > > > build.
> > > > >
> > > > > - Arnaldo
> > > > >
> > > > > From 882adaee50bc27f85374aeb2fbaa5b76bef60d05 Mon Sep 17 00:00:00=
 2001
> > > > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > > Date: Thu, 4 May 2023 19:03:51 -0300
> > > > > Subject: [PATCH 1/1] perf bpf skels: Stop using vmlinux.h generat=
ed from BTF,
> > > > >  use subset of used structs + CO-RE
> > > > >
> > > > > Linus reported a build break due to using a vmlinux without a BTF=
 elf
> > > > > section to generate the vmlinux.h header with bpftool for use in =
the BPF
> > > > > tools in tools/perf/util/bpf_skel/*.bpf.c.
> > > > >
> > > > > Instead add a vmlinux.h file with the structs needed with the fie=
lds the
> > > > > tools need, marking the structs with __attribute__((preserve_acce=
ss_index)),
> > > > > so that libbpf's CO-RE code can fixup the struct field offsets.
> > > > >
> > > > > In some cases the vmlinux.h file that was being generated by bpft=
ool
> > > > > from the kernel BTF information was not needed at all, just inclu=
ding
> > > > > linux/bpf.h, sometimes linux/perf_event.h was enough as non-UAPI
> > > > > types were not being used.
> > > > >
> > > > > To keep te patch small, include those UAPI headers from the trimm=
ed down
> > > > > vmlinux.h file, that then provides the tools with just the struct=
s and
> > > > > the subset of its fields needed for them.
> > > > >
> > > > > Testing it:
> > > > >
> > > > >   # perf lock contention -b find / > /dev/null
> > >
> > > I tested perf lock con -abv -L rcu_state sleep 1
> > > and needed fix below
> > >
> > > jirka
> >
> > I thought this was fixed by:
> > https://lore.kernel.org/lkml/20230427234833.1576130-1-namhyung@kernel.o=
rg/
> > but I think that is just in perf-tools-next.
>
> ah ok, missed that one

Please try validating with veristat to check if all of perf's .bpf.o
files are successful. Veristat is part of selftests and can be built
with just `make -C tools/testing/selftests/bpf veristat`. After that;

 sudo ~/bin/veristat tools/perf/util/bpf_skel/.tmp/*.bpf.o

This is a surer way to check that BPF object files are ok at least on
your currently running kernel, than trying to exercise each BPF
program through perf commands.

>
> thanks,
> jirka

