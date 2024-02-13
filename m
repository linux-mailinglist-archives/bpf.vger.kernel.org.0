Return-Path: <bpf+bounces-21867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0736853904
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 18:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E5A428FCBF
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 17:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C93B604DA;
	Tue, 13 Feb 2024 17:53:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11F15FF1A;
	Tue, 13 Feb 2024 17:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846816; cv=none; b=CmyehDEm0Iyivi0RaJoSpi7FPMJr1qovghkDHICniYCfSDb0Vnx31EPhPqXq095Vx9z7STIa+1xvnaCEJ82eJiXaBMKN68i36dYa9lS+OkHEI159mT7ayiNFiAYCrSzfTKhcgnabLShQVspt8441zkO1VqTdqFrHNRVHv4tBOXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846816; c=relaxed/simple;
	bh=7WcguzORNUncVMI8yVHuEyVH6gHiNRJ99ytpWlcFL3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VFPulARuy5GG+2UZfnnTrY2phOCEqMJpJCPIPijJI1mFkHFIqdSUsa3NpJmDZI4kzngTrXt55TB+kJpEP/NJtC8vsJ4CeG6YEl+ecW0v7/cQFXJe7ae8pYICeeQJNLbgBLZq2CVrwWF6fC2Q5QbOnhZRLyENeM1uStXNsE56yeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso3560604a12.2;
        Tue, 13 Feb 2024 09:53:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707846814; x=1708451614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIAYX2by5VkQGQHZUnXlAIcJ91jHMtAdkIYxHslLShk=;
        b=GIOl3Sa7sIotJN2x0eqwE3AVPICmLFiM3IuAHdp0szAgWJybgpKNwLtzpCX2nBT/jk
         hTDJLZnuypxczgjgbDSorE2fRP1CMKQCDZ07gp/FqMbSCxfLW/Mwvf3crGP8lX+VuzLS
         +KWbJORmtQJe5ksx4GEUja99NXESkNTJPxSCUxunyAhEIKPemdUB10Ve3YNssZl3Guy7
         dZvqifJA4aPr6vuQf7hi5CUWT7uMPQi2IVCbZAv6REvKGZn+Zv1Uj8xZ40H5dnLLmVAk
         A6VMl50K50rC7FVBEV79KUeQAj0pXrOFcpSoQAVZXYKPG7vmTeeOz2YxTJZVTk/+mUTW
         8RlA==
X-Forwarded-Encrypted: i=1; AJvYcCUxVtfvAvV2MVOU4+TaJvC9BNjlSSzlN2uOdyqe0yKVT6XeOkXLapZ/npd0mq3Sw/8xAx5oTfShJLeiEWHKF1AUpivj4MmLCZY9O79JxzYKXk7UnTV5Pw6ejLSpZ0ibrI1rfFLLoccb89UfgjH0pXjjD1JmbnbLPDnuK8lNuxrpv032XA==
X-Gm-Message-State: AOJu0YzbsdCjDU4kRq5WbCWkbGvjys1rxzzc/4bieu9fa72P5tGAu6TE
	nj70df0MZOwFHTdENEViRwlVkEfXRdBzszyhPe1pebZZtbfk4hMQwgj9m4qQT6/prY34OkRMQHM
	P8kKOnM4GYL4fjoG635uXU7Og2Lw=
X-Google-Smtp-Source: AGHT+IG/7yPnHipxkvG4GDwHRmNgX66LCK7NFEi9SYooQTwor/KSzpLbexwipqs0oK/vZHTUoy/+Fp9QbVLRF1qnt4I=
X-Received: by 2002:a05:6a20:21ca:b0:19e:a9bf:d51a with SMTP id
 p10-20020a056a2021ca00b0019ea9bfd51amr272928pzb.32.1707846813997; Tue, 13 Feb
 2024 09:53:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207223639.3139601-1-irogers@google.com> <CAM9d7chBixXozCQztM2WKGbfs_8C70vy6ROzKpwLSqq-upz5iQ@mail.gmail.com>
 <CAP-5=fUVkaq3dDoeMYYEN1N-ghnL-GiP8PV3N3pWpjQKpDTCHw@mail.gmail.com>
 <CAP-5=fXs8=HvjGpkLwuZBi0Hh8jtmz7=0Tp7HRgU8FOFN0GZvg@mail.gmail.com>
 <CAM9d7choe-CruqcdkLMPC1Eu4Oca0CBaaq-uiCd=csiLY60NBw@mail.gmail.com> <CAP-5=fXAkbnpKpkCM8soy7pHzCZZJ8VWYrd9ewFtZoaoA6vZnQ@mail.gmail.com>
In-Reply-To: <CAP-5=fXAkbnpKpkCM8soy7pHzCZZJ8VWYrd9ewFtZoaoA6vZnQ@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 13 Feb 2024 09:53:21 -0800
Message-ID: <CAM9d7cgGGw20t+VqzCd31CDUqo4roihknyH=2+_7CHuFhHh5fQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] maps memory improvements and fixes
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Song Liu <song@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Liam Howlett <liam.howlett@oracle.com>, 
	Colin Ian King <colin.i.king@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Artem Savkov <asavkov@redhat.com>, Changbin Du <changbin.du@huawei.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 12:22=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Mon, Feb 12, 2024 at 12:10=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> >
> > On Sat, Feb 10, 2024 at 10:08=E2=80=AFAM Ian Rogers <irogers@google.com=
> wrote:
> > >
> > > On Fri, Feb 9, 2024 at 6:46=E2=80=AFPM Ian Rogers <irogers@google.com=
> wrote:
> > > >
> > > > On Thu, Feb 8, 2024 at 9:44=E2=80=AFAM Namhyung Kim <namhyung@kerne=
l.org> wrote:
> > > > >
> > > > > Hi Ian,
> > > > >
> > > > > On Wed, Feb 7, 2024 at 2:37=E2=80=AFPM Ian Rogers <irogers@google=
.com> wrote:
> > > > > >
> > > > > > First 6 patches from:
> > > > > > https://lore.kernel.org/lkml/20240202061532.1939474-1-irogers@g=
oogle.com/
> > > > > >
> > > > > > v2. Fix NO_LIBUNWIND=3D1 build issue.
> > > > > >
> > > > > > Ian Rogers (6):
> > > > > >   perf maps: Switch from rbtree to lazily sorted array for addr=
esses
> > > > > >   perf maps: Get map before returning in maps__find
> > > > > >   perf maps: Get map before returning in maps__find_by_name
> > > > > >   perf maps: Get map before returning in maps__find_next_entry
> > > > > >   perf maps: Hide maps internals
> > > > > >   perf maps: Locking tidy up of nr_maps
> > > > >
> > > > > Now I see a perf test failure on the vmlinux test:
> > > > >
> > > > > $ sudo ./perf test -v vmlinux
> > > > >   1: vmlinux symtab matches kallsyms                             =
    :
> > > > > --- start ---
> > > > > test child forked, pid 4164115
> > > > > /proc/{kallsyms,modules} inconsistency while looking for
> > > > > "[__builtin__kprobes]" module!
> > > > > /proc/{kallsyms,modules} inconsistency while looking for
> > > > > "[__builtin__kprobes]" module!
> > > > > /proc/{kallsyms,modules} inconsistency while looking for
> > > > > "[__builtin__ftrace]" module!
> > > > > Looking at the vmlinux_path (8 entries long)
> > > > > Using /usr/lib/debug/boot/vmlinux-6.5.13-1rodete2-amd64 for symbo=
ls
> > > > > perf: Segmentation fault
> > > > > Obtained 16 stack frames.
> > > > > ./perf(+0x1b7dcd) [0x55c40be97dcd]
> > > > > ./perf(+0x1b7eb7) [0x55c40be97eb7]
> > > > > /lib/x86_64-linux-gnu/libc.so.6(+0x3c510) [0x7f33d7a5a510]
> > > > > ./perf(+0x1c2e9c) [0x55c40bea2e9c]
> > > > > ./perf(+0x1c43f6) [0x55c40bea43f6]
> > > > > ./perf(+0x1c4649) [0x55c40bea4649]
> > > > > ./perf(+0x1c46d3) [0x55c40bea46d3]
> > > > > ./perf(+0x1c7303) [0x55c40bea7303]
> > > > > ./perf(+0x1c70b5) [0x55c40bea70b5]
> > > > > ./perf(+0x1c73e6) [0x55c40bea73e6]
> > > > > ./perf(+0x11833e) [0x55c40bdf833e]
> > > > > ./perf(+0x118f78) [0x55c40bdf8f78]
> > > > > ./perf(+0x103d49) [0x55c40bde3d49]
> > > > > ./perf(+0x103e75) [0x55c40bde3e75]
> > > > > ./perf(+0x1044c0) [0x55c40bde44c0]
> > > > > ./perf(+0x104de0) [0x55c40bde4de0]
> > > > > test child interrupted
> > > > > ---- end ----
> > > > > vmlinux symtab matches kallsyms: FAILED!
> > > >
> > > > Ah, tripped over a latent bug summarized in this part of an asan st=
ack trace:
> > > > ```
> > > > freed by thread T0 here:
> > > >    #0 0x7fa13bcd74b5 in __interceptor_realloc
> > > > ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:85
> > > >    #1 0x561d66377713 in __maps__insert util/maps.c:353
> > > >    #2 0x561d66377b89 in maps__insert util/maps.c:413
> > > >    #3 0x561d6652911d in dso__process_kernel_symbol util/symbol-elf.=
c:1460
> > > >    #4 0x561d6652aaae in dso__load_sym_internal util/symbol-elf.c:16=
75
> > > >    #5 0x561d6652b6dc in dso__load_sym util/symbol-elf.c:1771
> > > >    #6 0x561d66321a4e in dso__load util/symbol.c:1914
> > > >    #7 0x561d66372cd9 in map__load util/map.c:353
> > > >    #8 0x561d663730e7 in map__find_symbol_by_name_idx util/map.c:397
> > > >    #9 0x561d663731e7 in map__find_symbol_by_name util/map.c:410
> > > >    #10 0x561d66378208 in maps__find_symbol_by_name_cb util/maps.c:5=
24
> > > >    #11 0x561d66377f49 in maps__for_each_map util/maps.c:471
> > > >    #12 0x561d663784a0 in maps__find_symbol_by_name util/maps.c:546
> > > >    #13 0x561d662093e8 in machine__find_kernel_symbol_by_name util/m=
achine.h:243
> > > >    #14 0x561d6620abbd in test__vmlinux_matches_kallsyms
> > > > tests/vmlinux-kallsyms.c:330
> > > > ...
> > > > ```
> > > > dso__process_kernel_symbol rewrites the kernel maps here:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/util/symbol-elf.c#n1378
> > > > which resizes the maps_by_address array causing the maps__for_each_=
map
> > > > iteration in frame 11 to be iterating over a stale/freed value.
> > > >
> > > > The most correct solutions would be to clone the maps_by_address ar=
ray
> > > > prior to iteration, or reference count maps_by_address and its size=
.
> > > > Neither of these solutions particularly appeal, so just reloading t=
he
> > > > maps_by_address and size on each iteration also fixes the problem, =
but
> > > > possibly causes some maps to be skipped/repeated. I think this is
> > > > acceptable correctness for the performance.
> >
> > Can we move map__load() out of maps__for_each_map() ?
> > I think the callback should just return the map and break the loop.
> > And it can call the map__load() out of the read lock.
>
> It would need a rewrite of map__find_symbol_by_name which is being
> called by a callback from maps__find_symbol_by_name. Perhaps an
> initial pass to ensure everything is loaded and a safe version of the
> loop that copies the maps_by_address ahead of copying it. It'd be of a
> scope that'd be worth its own patch set.

Right, let's do it in a separate work.

>
> > >
> > > An aside, shouldn't taking a write lock to modify the maps deadlock
> > > with holding the read lock for iteration? Well no because
> > > perf_singlethreaded is true for the test:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/util/rwsem.c#n17
> > > Another perf_singlethreaded considered evil :-) Note, just getting ri=
d
> > > of perf_singlethreaded means latent bugs like this will pop up and
> > > will need resolution.
> >
> > Yeah, maybe.  How about turning it on in the test code?
>
> Agreed, but I think it should be a follow up.

Sounds good.

Thanks,
Namhyung

