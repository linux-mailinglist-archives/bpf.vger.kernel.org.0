Return-Path: <bpf+bounces-306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C6B6FE445
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 20:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C4F328153A
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 18:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6666D174EE;
	Wed, 10 May 2023 18:56:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5EE16411
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 18:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A18C433EF;
	Wed, 10 May 2023 18:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683745010;
	bh=hnjNpJ/WI6twjro0xk2Nr8Le9Sc2ewfqjnIfqLVYWXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ks6OQHE3+6zg0Buwwl+2k0aQIIxjKrtCGH4lX+coXTjtimmMBzqrljL1CJAw7IgPz
	 4Z0b765QPWea8zWV8ETgqugT94lYzmT10zVDrH6SDOzsR/8dyibSgvwHSfNc8mC6w3
	 jUs78Hm/crFMKmUJ9B7wvJhdD621dSUYW/+zwlNO62sGAINp8Cutt5dHcSFVd9ukTh
	 u2b7XX5pYsVemAfN5eLS2khUUeakfD4ajmrb1x/3ObSQKviBkkkM7mK/l+3olZAd15
	 sRUKEF2x/KQzZOoMq2WVL//g8cattukNRY582GDQcXHOzfUKIaM95L+xNfXKZCrB8R
	 4zpdawR8SzLyw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 558B7403B5; Wed, 10 May 2023 15:56:47 -0300 (-03)
Date: Wed, 10 May 2023 15:56:47 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <olsajiri@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Song Liu <song@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Changbin Du <changbin.du@huawei.com>, Hao Luo <haoluo@google.com>,
	James Clark <james.clark@arm.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Roman Lozko <lozko.roma@gmail.com>,
	Stephane Eranian <eranian@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Yang Jihong <yangjihong1@huawei.com>,
	Mark Rutland <mark.rutland@arm.com>, Paul Clarke <pc@us.ibm.com>
Subject: Re: [PATCH RFC/RFT] perf bpf skels: Stop using vmlinux.h generated
 from BTF, use subset of used structs + CO-RE. was Re: BPF skels in perf .Re:
 [GIT PULL] perf tools changes for v6.4
Message-ID: <ZFvo79pOroYOFC/I@kernel.org>
References: <ZFQCccsx6GK+gY0j@kernel.org>
 <ZFQoQjCNtyMIulp+@kernel.org>
 <CAP-5=fU8HQorW+7O6vfEKGs1mEFkjkzXZMVPACzurtcMcRhVzQ@mail.gmail.com>
 <ZFQ5sjjtfEYzvHNP@krava>
 <ZFUFmxDU/6Z/JEsi@kernel.org>
 <ZFU1PJrn8YtHIqno@kernel.org>
 <CAP-5=fWfmmMCRnEmzj_CXTKacp6gjrzmR49Ge_C5XRyfTegRjg@mail.gmail.com>
 <ZFVqeKLssg7uzxzI@krava>
 <CAP-5=fVgJdBvjV8S2xKswAFiSZvyCcUvZTO1bsLyUf-wQ0pBuw@mail.gmail.com>
 <CAM9d7cjrZ-sHhO1ErqVdrN8Vv-ocCmsONc443yoPiCvnoiXj9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cjrZ-sHhO1ErqVdrN8Vv-ocCmsONc443yoPiCvnoiXj9A@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Fri, May 05, 2023 at 01:48:52PM -0700, Namhyung Kim escreveu:
> On Fri, May 5, 2023 at 1:46 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Fri, May 5, 2023 at 1:43 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > On Fri, May 05, 2023 at 10:04:47AM -0700, Ian Rogers wrote:
> > > > On Fri, May 5, 2023 at 9:56 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > > >
> > > > > Em Fri, May 05, 2023 at 10:33:15AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > > > Em Fri, May 05, 2023 at 01:03:14AM +0200, Jiri Olsa escreveu:
> > > > > > That with the preserve_access_index isn't needed, we need just the
> > > > > > fields that we access in the tools, right?
> > > > >
> > > > > I'm now doing build test this in many distro containers, without the two
> > > > > reverts, i.e. BPF skels continue as opt-out as in my pull request, to
> > > > > test build and also for the functionality tests on the tools using such
> > > > > bpf skels, see below, no touching of vmlinux nor BTF data during the
> > > > > build.
> > > > >
> > > > > - Arnaldo
> > > > >
> > > > > From 882adaee50bc27f85374aeb2fbaa5b76bef60d05 Mon Sep 17 00:00:00 2001
> > > > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > > Date: Thu, 4 May 2023 19:03:51 -0300
> > > > > Subject: [PATCH 1/1] perf bpf skels: Stop using vmlinux.h generated from BTF,
> > > > >  use subset of used structs + CO-RE
> > > > >
> > > > > Linus reported a build break due to using a vmlinux without a BTF elf
> > > > > section to generate the vmlinux.h header with bpftool for use in the BPF
> > > > > tools in tools/perf/util/bpf_skel/*.bpf.c.
> > > > >
> > > > > Instead add a vmlinux.h file with the structs needed with the fields the
> > > > > tools need, marking the structs with __attribute__((preserve_access_index)),
> > > > > so that libbpf's CO-RE code can fixup the struct field offsets.
> > > > >
> > > > > In some cases the vmlinux.h file that was being generated by bpftool
> > > > > from the kernel BTF information was not needed at all, just including
> > > > > linux/bpf.h, sometimes linux/perf_event.h was enough as non-UAPI
> > > > > types were not being used.
> > > > >
> > > > > To keep te patch small, include those UAPI headers from the trimmed down
> > > > > vmlinux.h file, that then provides the tools with just the structs and
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
> > https://lore.kernel.org/lkml/20230427234833.1576130-1-namhyung@kernel.org/

Those are upstream already:

⬢[acme@toolbox perf-tools]$ git log --oneline torvalds/master | grep -m1 -B1 "perf lock contention: Fix struct rq lock access"
b9f82b5c63bf5390 perf lock contention: Rework offset calculation with BPF CO-RE
e53de7b65a3ca59a perf lock contention: Fix struct rq lock access
⬢[acme@toolbox perf-tools]$

> > but I think that is just in perf-tools-next.
 
> Right, but we might still need the empty rq definition.

Yeah, without the empty struct diff libbpf complains about a mismatch of
just a forward declaration as the type for 'runqueues' on the
lock_contention.bpf.c file while the kernel has a the type as 'struct
rq':

[root@quaco ~]# perf lock con -ab sleep 1
libbpf: extern (var ksym) 'runqueues': incompatible types, expected [95] fwd rq, but kernel has [55509] struct rq
libbpf: failed to load object 'lock_contention_bpf'
libbpf: failed to load BPF skeleton 'lock_contention_bpf': -22
Failed to load lock-contention BPF skeleton
lock contention BPF setup failed
[root@quaco ~]#

Adding:

struct rq {};

libbpf is happy:

[root@quaco ~]# perf lock con -ab sleep 1
 contended   total wait     max wait     avg wait         type   caller

         2     50.64 us     25.38 us     25.32 us     spinlock   tick_do_update_jiffies64+0x25
         1     26.18 us     26.18 us     26.18 us     spinlock   tick_do_update_jiffies64+0x25
[root@quaco ~]#

- Arnaldo

