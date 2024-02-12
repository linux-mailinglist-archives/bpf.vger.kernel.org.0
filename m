Return-Path: <bpf+bounces-21762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA49851E76
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 21:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7F50286849
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 20:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C734481B4;
	Mon, 12 Feb 2024 20:10:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B4345C12;
	Mon, 12 Feb 2024 20:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707768655; cv=none; b=iqdAmT3OtkHLlXl3hfW/uZkfArOVWELlsPBByYxGMjQ3s8ORAK/6u6SUIifkjwYHIipHAzzsDJstT3EQEc4tRDZ4Z7jd4D+C7lv/En7GA43LiAkeuZzx+OB9u5Ybuz72ej2Yaj91VlPUNefmEQLhw6bS9jGMdRNee5OkiBYkvq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707768655; c=relaxed/simple;
	bh=ErAi3yiO2NiNGUJ00p6OoRPUZbYyjNagusL7Wg6tQAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JtL2SkQQPYxg7phNSMhO+IPyM4cAXze2eyEPr0Me9BxbKMQTrJ5W5wRwKVaUZ+h8M0KhH1o2lyp3eRDIitNK0erZcP4vS1e06Kylt6iS3cXpTEOa4W3grn3pYzXCNUO2IGp5qfkF58jc+8un7eEiY/Y5NSNaro/7QSgGlLdM57k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4c022adaa88so509882e0c.0;
        Mon, 12 Feb 2024 12:10:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707768652; x=1708373452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ilCu2b5Ljq7Q+kjgZF6WcxqcCWOVeMmlalciWaHgshQ=;
        b=CDcBhTgkjmNhJTTSQS+pzDLnlZQjIpk32jYSxGQp48wMHzFGBT2Y22McQV+7TMTSv6
         9B7OvmTitN2y3zSh0K+an5Jzvzo3/dSRohw1yA+nwJhjTfGVlVVHORsyHYvdBVLCMyPb
         rcqJeUdaX78idHBGy6DVkgTTRv8exr/gmh8rrB1WCE/SZnWEauw1KTyTAoPesnkS0GYW
         OPDdhH+tMdNgyTH8aZj2BX6+bGuzyIou75pS9qNmtdH1cVZQQxUom3dX5dKnjvz0sHEc
         POXMlkLR7E3+AYd8gxogqjqclYejxB6UHLs7DuwfsjY9f47l2qeeNRX7FvUIKWj1WEq6
         N2kA==
X-Forwarded-Encrypted: i=1; AJvYcCWNu7wTh9v+1/GvcyC0TZVHxwCIPWOTJjHny9uMNvSRQ2RAp9bx1L0GNNxru8dw++IrUj8dmSqcr93qWMyvVFYFXFsrxpiRNDC1OIu3eU6gdm72xcE5xEqWgXt62n9UnWjpUIdZ/HrqsHJRcVao95SGQYHktI68giqb+1C02BjZh2Xh7w==
X-Gm-Message-State: AOJu0YzjoZOtIHG4hjTiJX3j0UpB6uLJ+gOwXHZxQeoCQjVOJZKWTn48
	uaSWsyESKyJ/qNmrzJUOlNxkBfnO7Z3Viu0HNNccj479bDmutH1HzFQ2mqUrgqHHegPOqt8zeTJ
	o2MPsqVJMREMT0GCQ9Z73TFVHhEM=
X-Google-Smtp-Source: AGHT+IFdyK0b9LfmjD9apJkvOySy+8nJKDC3MgcssCbxCJV9YnLVV/y/qPM9egRkqXJCi4GvIepCsdReO/Tl0iragvQ=
X-Received: by 2002:a05:6122:4a02:b0:4c0:774b:e7b0 with SMTP id
 ez2-20020a0561224a0200b004c0774be7b0mr3110373vkb.13.1707768652111; Mon, 12
 Feb 2024 12:10:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207223639.3139601-1-irogers@google.com> <CAM9d7chBixXozCQztM2WKGbfs_8C70vy6ROzKpwLSqq-upz5iQ@mail.gmail.com>
 <CAP-5=fUVkaq3dDoeMYYEN1N-ghnL-GiP8PV3N3pWpjQKpDTCHw@mail.gmail.com> <CAP-5=fXs8=HvjGpkLwuZBi0Hh8jtmz7=0Tp7HRgU8FOFN0GZvg@mail.gmail.com>
In-Reply-To: <CAP-5=fXs8=HvjGpkLwuZBi0Hh8jtmz7=0Tp7HRgU8FOFN0GZvg@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 12 Feb 2024 12:10:16 -0800
Message-ID: <CAM9d7choe-CruqcdkLMPC1Eu4Oca0CBaaq-uiCd=csiLY60NBw@mail.gmail.com>
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

On Sat, Feb 10, 2024 at 10:08=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Fri, Feb 9, 2024 at 6:46=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > On Thu, Feb 8, 2024 at 9:44=E2=80=AFAM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> > >
> > > Hi Ian,
> > >
> > > On Wed, Feb 7, 2024 at 2:37=E2=80=AFPM Ian Rogers <irogers@google.com=
> wrote:
> > > >
> > > > First 6 patches from:
> > > > https://lore.kernel.org/lkml/20240202061532.1939474-1-irogers@googl=
e.com/
> > > >
> > > > v2. Fix NO_LIBUNWIND=3D1 build issue.
> > > >
> > > > Ian Rogers (6):
> > > >   perf maps: Switch from rbtree to lazily sorted array for addresse=
s
> > > >   perf maps: Get map before returning in maps__find
> > > >   perf maps: Get map before returning in maps__find_by_name
> > > >   perf maps: Get map before returning in maps__find_next_entry
> > > >   perf maps: Hide maps internals
> > > >   perf maps: Locking tidy up of nr_maps
> > >
> > > Now I see a perf test failure on the vmlinux test:
> > >
> > > $ sudo ./perf test -v vmlinux
> > >   1: vmlinux symtab matches kallsyms                                 =
:
> > > --- start ---
> > > test child forked, pid 4164115
> > > /proc/{kallsyms,modules} inconsistency while looking for
> > > "[__builtin__kprobes]" module!
> > > /proc/{kallsyms,modules} inconsistency while looking for
> > > "[__builtin__kprobes]" module!
> > > /proc/{kallsyms,modules} inconsistency while looking for
> > > "[__builtin__ftrace]" module!
> > > Looking at the vmlinux_path (8 entries long)
> > > Using /usr/lib/debug/boot/vmlinux-6.5.13-1rodete2-amd64 for symbols
> > > perf: Segmentation fault
> > > Obtained 16 stack frames.
> > > ./perf(+0x1b7dcd) [0x55c40be97dcd]
> > > ./perf(+0x1b7eb7) [0x55c40be97eb7]
> > > /lib/x86_64-linux-gnu/libc.so.6(+0x3c510) [0x7f33d7a5a510]
> > > ./perf(+0x1c2e9c) [0x55c40bea2e9c]
> > > ./perf(+0x1c43f6) [0x55c40bea43f6]
> > > ./perf(+0x1c4649) [0x55c40bea4649]
> > > ./perf(+0x1c46d3) [0x55c40bea46d3]
> > > ./perf(+0x1c7303) [0x55c40bea7303]
> > > ./perf(+0x1c70b5) [0x55c40bea70b5]
> > > ./perf(+0x1c73e6) [0x55c40bea73e6]
> > > ./perf(+0x11833e) [0x55c40bdf833e]
> > > ./perf(+0x118f78) [0x55c40bdf8f78]
> > > ./perf(+0x103d49) [0x55c40bde3d49]
> > > ./perf(+0x103e75) [0x55c40bde3e75]
> > > ./perf(+0x1044c0) [0x55c40bde44c0]
> > > ./perf(+0x104de0) [0x55c40bde4de0]
> > > test child interrupted
> > > ---- end ----
> > > vmlinux symtab matches kallsyms: FAILED!
> >
> > Ah, tripped over a latent bug summarized in this part of an asan stack =
trace:
> > ```
> > freed by thread T0 here:
> >    #0 0x7fa13bcd74b5 in __interceptor_realloc
> > ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:85
> >    #1 0x561d66377713 in __maps__insert util/maps.c:353
> >    #2 0x561d66377b89 in maps__insert util/maps.c:413
> >    #3 0x561d6652911d in dso__process_kernel_symbol util/symbol-elf.c:14=
60
> >    #4 0x561d6652aaae in dso__load_sym_internal util/symbol-elf.c:1675
> >    #5 0x561d6652b6dc in dso__load_sym util/symbol-elf.c:1771
> >    #6 0x561d66321a4e in dso__load util/symbol.c:1914
> >    #7 0x561d66372cd9 in map__load util/map.c:353
> >    #8 0x561d663730e7 in map__find_symbol_by_name_idx util/map.c:397
> >    #9 0x561d663731e7 in map__find_symbol_by_name util/map.c:410
> >    #10 0x561d66378208 in maps__find_symbol_by_name_cb util/maps.c:524
> >    #11 0x561d66377f49 in maps__for_each_map util/maps.c:471
> >    #12 0x561d663784a0 in maps__find_symbol_by_name util/maps.c:546
> >    #13 0x561d662093e8 in machine__find_kernel_symbol_by_name util/machi=
ne.h:243
> >    #14 0x561d6620abbd in test__vmlinux_matches_kallsyms
> > tests/vmlinux-kallsyms.c:330
> > ...
> > ```
> > dso__process_kernel_symbol rewrites the kernel maps here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/symbol-elf.c#n1378
> > which resizes the maps_by_address array causing the maps__for_each_map
> > iteration in frame 11 to be iterating over a stale/freed value.
> >
> > The most correct solutions would be to clone the maps_by_address array
> > prior to iteration, or reference count maps_by_address and its size.
> > Neither of these solutions particularly appeal, so just reloading the
> > maps_by_address and size on each iteration also fixes the problem, but
> > possibly causes some maps to be skipped/repeated. I think this is
> > acceptable correctness for the performance.

Can we move map__load() out of maps__for_each_map() ?
I think the callback should just return the map and break the loop.
And it can call the map__load() out of the read lock.

>
> An aside, shouldn't taking a write lock to modify the maps deadlock
> with holding the read lock for iteration? Well no because
> perf_singlethreaded is true for the test:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/=
tree/tools/perf/util/rwsem.c#n17
> Another perf_singlethreaded considered evil :-) Note, just getting rid
> of perf_singlethreaded means latent bugs like this will pop up and
> will need resolution.

Yeah, maybe.  How about turning it on in the test code?

Thanks,
Namhyung

