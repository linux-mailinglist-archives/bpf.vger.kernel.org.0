Return-Path: <bpf+bounces-21768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB01851E95
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 21:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58E561F25238
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 20:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828C3482D4;
	Mon, 12 Feb 2024 20:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IA0NkTZj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807F647F7A
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 20:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707769349; cv=none; b=qo3wlyxyQ9yA0/1HVyATVa1/IVJLdnWBH8yuVNk7Bd430ddYP2tFIYHxxuQob19FFs6DwJif54Ykxhl+CJKAlQ9yNGHCElNmAuq/3hp+E14JJ8kLyrbWNeyJIK4pAHmZcLoXKBWDf1MFA6smo6BU95mi7G34meSmr6vzRkIFoZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707769349; c=relaxed/simple;
	bh=1jyb/LgyCJSFAs/iMDtWO35G1TCZMxoahITHRWxYqTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K7YKe7y2yIiyGp1HBlXkjeL6lY4rjgJxTmgxQCJnxPG0U42A5OWrvQ2uAzR1a9WX5qnUJ4ZoWBfQc9fstrbq/kN/WZQC7As7QyZct2K0NzZYNgFlhhgf32gdnpUGEaqGaYTQi7L6zIz6jQfBdj8SjaVACPGkpVp67N1lyrS98Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IA0NkTZj; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d5ce88b51cso46795ad.0
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 12:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707769347; x=1708374147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSkTVHBMewwnu8yq5IPAUhgGr9Iydcb2u3j6O+zxJnQ=;
        b=IA0NkTZjJMhGTstt/Tvf42VjN7kaIRSv+wWKUktiXc9GtE88Rvf1tWqWcxtb1n3+1X
         Wy2wIryxwznO4NRXMgQqRoBm3asizqsvcCaHUPq9mtq0W9MOrAgAn4mYKbr9qhaAlo5p
         zr9/Krv3x7p3FxkbZNHI2xEAma+l6SmxdkWPdxtB5JjaVD40v2EBW36wXUjais8rJDKd
         5/6mkmDLdwowRVcF+WLHTI3VsR9ByV2fTajyLtLsbLKfJcNiTepImBx7/NIDghG48Pkv
         W8XTDFT5M1+WhMW5OskVsNqdtnHTNPH8qlOJcGkFuD6zC7jCFvHIzes19JuC81mJOBUK
         QHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707769347; x=1708374147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CSkTVHBMewwnu8yq5IPAUhgGr9Iydcb2u3j6O+zxJnQ=;
        b=HQ6e7QRO7TSanxGOGywoPaty0Erddtwc/4R64i+kMuPSJb8RxmjZG4ttJv+b+C4efl
         r4XX3y3pT3kRAg5gT6lN/FByPGbWDgPm0s22S4OXVpxatelwvC1yGLQjYLBmeY1tepPl
         yxGT9CyjCdPZ3zWZEQ0n0RpcDvgE72hYEJEvTqaS+dev7pfw+x4XGNkqO+auQooyOATV
         Wu2jJ7X2uYMSBdEk5Dtes2bnN71H/g3M4MOWfC9dU0vWq5VQSqA7HbkKzcJRhUvBazLW
         BSFk2wJ0BGh1a0OccJRgHvzPZbbdJrCSYlZ6x0IVGh+TC0dZ31i0KmSv7/aOg/M6GEAd
         At1w==
X-Forwarded-Encrypted: i=1; AJvYcCW2Btrr3Fs4Fg/uA8ovHuWp8K7rFYQ41+lj9LP88uUsB3heamE5VkdL2AisU8v3+IvfXW/bs54VwJJm2b4zHyMy3xfb
X-Gm-Message-State: AOJu0YwuJYVecpM391CWli8OgXxbuaV2U1HcckqMfeKFtne7UDda/H8Z
	P2OjcXrhgu4/omA69FGIyGUECKj6LxSL9osXTkdmxAyeQuyTjvSEofSulloNAPr2p5ei6B5veXq
	nG/0tXPDWq0VlphaOX0mj+47BRUv99aF6nPhE
X-Google-Smtp-Source: AGHT+IE5+3kIF7GEm/jVEtuVk1CfrpPR482lIZqB7Gpm+RznoZw+6+B3gt0Ki+FE0pXZjN0hp8JTqOvZhK/qaYw6gao=
X-Received: by 2002:a17:902:cece:b0:1d8:d6bf:145b with SMTP id
 d14-20020a170902cece00b001d8d6bf145bmr341044plg.15.1707769346579; Mon, 12 Feb
 2024 12:22:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207223639.3139601-1-irogers@google.com> <CAM9d7chBixXozCQztM2WKGbfs_8C70vy6ROzKpwLSqq-upz5iQ@mail.gmail.com>
 <CAP-5=fUVkaq3dDoeMYYEN1N-ghnL-GiP8PV3N3pWpjQKpDTCHw@mail.gmail.com>
 <CAP-5=fXs8=HvjGpkLwuZBi0Hh8jtmz7=0Tp7HRgU8FOFN0GZvg@mail.gmail.com> <CAM9d7choe-CruqcdkLMPC1Eu4Oca0CBaaq-uiCd=csiLY60NBw@mail.gmail.com>
In-Reply-To: <CAM9d7choe-CruqcdkLMPC1Eu4Oca0CBaaq-uiCd=csiLY60NBw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 12 Feb 2024 12:22:15 -0800
Message-ID: <CAP-5=fXAkbnpKpkCM8soy7pHzCZZJ8VWYrd9ewFtZoaoA6vZnQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] maps memory improvements and fixes
To: Namhyung Kim <namhyung@kernel.org>
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

On Mon, Feb 12, 2024 at 12:10=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Sat, Feb 10, 2024 at 10:08=E2=80=AFAM Ian Rogers <irogers@google.com> =
wrote:
> >
> > On Fri, Feb 9, 2024 at 6:46=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> > >
> > > On Thu, Feb 8, 2024 at 9:44=E2=80=AFAM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > > >
> > > > Hi Ian,
> > > >
> > > > On Wed, Feb 7, 2024 at 2:37=E2=80=AFPM Ian Rogers <irogers@google.c=
om> wrote:
> > > > >
> > > > > First 6 patches from:
> > > > > https://lore.kernel.org/lkml/20240202061532.1939474-1-irogers@goo=
gle.com/
> > > > >
> > > > > v2. Fix NO_LIBUNWIND=3D1 build issue.
> > > > >
> > > > > Ian Rogers (6):
> > > > >   perf maps: Switch from rbtree to lazily sorted array for addres=
ses
> > > > >   perf maps: Get map before returning in maps__find
> > > > >   perf maps: Get map before returning in maps__find_by_name
> > > > >   perf maps: Get map before returning in maps__find_next_entry
> > > > >   perf maps: Hide maps internals
> > > > >   perf maps: Locking tidy up of nr_maps
> > > >
> > > > Now I see a perf test failure on the vmlinux test:
> > > >
> > > > $ sudo ./perf test -v vmlinux
> > > >   1: vmlinux symtab matches kallsyms                               =
  :
> > > > --- start ---
> > > > test child forked, pid 4164115
> > > > /proc/{kallsyms,modules} inconsistency while looking for
> > > > "[__builtin__kprobes]" module!
> > > > /proc/{kallsyms,modules} inconsistency while looking for
> > > > "[__builtin__kprobes]" module!
> > > > /proc/{kallsyms,modules} inconsistency while looking for
> > > > "[__builtin__ftrace]" module!
> > > > Looking at the vmlinux_path (8 entries long)
> > > > Using /usr/lib/debug/boot/vmlinux-6.5.13-1rodete2-amd64 for symbols
> > > > perf: Segmentation fault
> > > > Obtained 16 stack frames.
> > > > ./perf(+0x1b7dcd) [0x55c40be97dcd]
> > > > ./perf(+0x1b7eb7) [0x55c40be97eb7]
> > > > /lib/x86_64-linux-gnu/libc.so.6(+0x3c510) [0x7f33d7a5a510]
> > > > ./perf(+0x1c2e9c) [0x55c40bea2e9c]
> > > > ./perf(+0x1c43f6) [0x55c40bea43f6]
> > > > ./perf(+0x1c4649) [0x55c40bea4649]
> > > > ./perf(+0x1c46d3) [0x55c40bea46d3]
> > > > ./perf(+0x1c7303) [0x55c40bea7303]
> > > > ./perf(+0x1c70b5) [0x55c40bea70b5]
> > > > ./perf(+0x1c73e6) [0x55c40bea73e6]
> > > > ./perf(+0x11833e) [0x55c40bdf833e]
> > > > ./perf(+0x118f78) [0x55c40bdf8f78]
> > > > ./perf(+0x103d49) [0x55c40bde3d49]
> > > > ./perf(+0x103e75) [0x55c40bde3e75]
> > > > ./perf(+0x1044c0) [0x55c40bde44c0]
> > > > ./perf(+0x104de0) [0x55c40bde4de0]
> > > > test child interrupted
> > > > ---- end ----
> > > > vmlinux symtab matches kallsyms: FAILED!
> > >
> > > Ah, tripped over a latent bug summarized in this part of an asan stac=
k trace:
> > > ```
> > > freed by thread T0 here:
> > >    #0 0x7fa13bcd74b5 in __interceptor_realloc
> > > ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:85
> > >    #1 0x561d66377713 in __maps__insert util/maps.c:353
> > >    #2 0x561d66377b89 in maps__insert util/maps.c:413
> > >    #3 0x561d6652911d in dso__process_kernel_symbol util/symbol-elf.c:=
1460
> > >    #4 0x561d6652aaae in dso__load_sym_internal util/symbol-elf.c:1675
> > >    #5 0x561d6652b6dc in dso__load_sym util/symbol-elf.c:1771
> > >    #6 0x561d66321a4e in dso__load util/symbol.c:1914
> > >    #7 0x561d66372cd9 in map__load util/map.c:353
> > >    #8 0x561d663730e7 in map__find_symbol_by_name_idx util/map.c:397
> > >    #9 0x561d663731e7 in map__find_symbol_by_name util/map.c:410
> > >    #10 0x561d66378208 in maps__find_symbol_by_name_cb util/maps.c:524
> > >    #11 0x561d66377f49 in maps__for_each_map util/maps.c:471
> > >    #12 0x561d663784a0 in maps__find_symbol_by_name util/maps.c:546
> > >    #13 0x561d662093e8 in machine__find_kernel_symbol_by_name util/mac=
hine.h:243
> > >    #14 0x561d6620abbd in test__vmlinux_matches_kallsyms
> > > tests/vmlinux-kallsyms.c:330
> > > ...
> > > ```
> > > dso__process_kernel_symbol rewrites the kernel maps here:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/util/symbol-elf.c#n1378
> > > which resizes the maps_by_address array causing the maps__for_each_ma=
p
> > > iteration in frame 11 to be iterating over a stale/freed value.
> > >
> > > The most correct solutions would be to clone the maps_by_address arra=
y
> > > prior to iteration, or reference count maps_by_address and its size.
> > > Neither of these solutions particularly appeal, so just reloading the
> > > maps_by_address and size on each iteration also fixes the problem, bu=
t
> > > possibly causes some maps to be skipped/repeated. I think this is
> > > acceptable correctness for the performance.
>
> Can we move map__load() out of maps__for_each_map() ?
> I think the callback should just return the map and break the loop.
> And it can call the map__load() out of the read lock.

It would need a rewrite of map__find_symbol_by_name which is being
called by a callback from maps__find_symbol_by_name. Perhaps an
initial pass to ensure everything is loaded and a safe version of the
loop that copies the maps_by_address ahead of copying it. It'd be of a
scope that'd be worth its own patch set.

> >
> > An aside, shouldn't taking a write lock to modify the maps deadlock
> > with holding the read lock for iteration? Well no because
> > perf_singlethreaded is true for the test:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/rwsem.c#n17
> > Another perf_singlethreaded considered evil :-) Note, just getting rid
> > of perf_singlethreaded means latent bugs like this will pop up and
> > will need resolution.
>
> Yeah, maybe.  How about turning it on in the test code?

Agreed, but I think it should be a follow up.

Thanks,
Ian

> Thanks,
> Namhyung

