Return-Path: <bpf+bounces-57312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64803AA85E4
	for <lists+bpf@lfdr.de>; Sun,  4 May 2025 12:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2180A189A624
	for <lists+bpf@lfdr.de>; Sun,  4 May 2025 10:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185E31A265E;
	Sun,  4 May 2025 10:24:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF32DA923;
	Sun,  4 May 2025 10:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.202.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746354277; cv=none; b=rzR4FBansk0TLtWO4l3uFy7uvbEiIXUJuWTp+8D43eyWMam6UO4CFUDirL5IplXj0Y5kMZtw9CpZzOLazwcB2EXKfta9YbQXyTHdbVXhA0Asxy5a95Gpy+XowNMOkMw/XlD7FzmGX1yZUZAToWyIC7nrHD/1AMD9y1mhz7hE5d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746354277; c=relaxed/simple;
	bh=Y6s+YCa9iFiGT4eVBBAezJ3E3VgNlItLt0N+jj37zow=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=cWVOGb2KROYlM5SVB4IF+6v1A7RJ+pG/jqRXxcm76CiPXNTfSiDfgR06b9N9cmpzoUAXRh563EFR+qTLeKYHUts4Zwfz2VID5LwCAEl5pcC8HtUp0mzdYjUcX6uwkWAHCljvWtLnqyEB+HnrEjgVHKn1AGyTIg4fywzcwjsP+SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=applied-asynchrony.com; arc=none smtp.client-ip=85.10.202.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied-asynchrony.com
Received: from tux.applied-asynchrony.com (p5b07e9b7.dip0.t-ipconnect.de [91.7.233.183])
	by mail.itouring.de (Postfix) with ESMTPSA id 0C2B9103765;
	Sun, 04 May 2025 12:24:26 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
	by tux.applied-asynchrony.com (Postfix) with ESMTP id B1C5C60187F0A;
	Sun, 04 May 2025 12:24:25 +0200 (CEST)
Subject: Re: [PATCH] bpftool: build bpf bits with -std=gnu11
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <20250502085710.3980-1-holger@applied-asynchrony.com>
 <7326223e-0cb9-4d22-872f-cbf1ff42227d@kernel.org>
 <913f66a8-6745-0e30-b5b8-96d23bf05b90@applied-asynchrony.com>
 <CAADnVQLpyNiyghWLMq5AxkBgZX4J9VfX5j4ToNh6UsrQ=4yndg@mail.gmail.com>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <2a8208af-bc4b-f1bd-af0b-f5db485ed1f0@applied-asynchrony.com>
Date: Sun, 4 May 2025 12:24:25 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQLpyNiyghWLMq5AxkBgZX4J9VfX5j4ToNh6UsrQ=4yndg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 2025-05-03 04:36, Alexei Starovoitov wrote:
> On Fri, May 2, 2025 at 2:53 AM Holger Hoffstätte
> <holger@applied-asynchrony.com> wrote:
>>
>> On 2025-05-02 11:26, Quentin Monnet wrote:
>>> On 02/05/2025 09:57, Holger Hoffstätte wrote:
>>>> A gcc-15-based bpf toolchain defaults to C23 and fails to compile various
>>>> kernel headers due to their use of a custom 'bool' type.
>>>> Explicitly using -std=gnu11 works with both clang and bpf-toolchain.
>>>>
>>>> Signed-off-by: Holger Hoffstätte <holger@applied-asynchrony.com>
>>>
>>> Thanks! I tested that it still works with clang.
>>>
>>> Acked-by: Quentin Monnet <qmo@kernel.org>
>>
>> Thanks!
>>
>>> I didn't manage to compile with gcc, though. I tried with gcc 15.1.1 but
>>> option '--target=bpf' is apparently unrecognised by the gcc version on
>>> my setup.
>>>
>>> Out of curiosity, how did you build using gcc for the skeleton? Was it
>>> enough to run "CLANG=gcc make"? Does it pass the clang-bpf-co-re build
>>> probe successfully?
>>
>> I'm on Gentoo where we have a gcc-14/15 based "bpf-toolchain" package,
>> which is just gcc configured & packaged for the bpf target.
>> Our bpftool package can be built with clang (default) or without, in
>> which case it depend on the bpf-toolchain. The idea is to gradually
>> allow bpf/xdp tooling to build/run without requiring clang.
>>
>> The --target definition is conditional and removed when not using clang:
>> https://gitweb.gentoo.org/repo/gentoo.git/tree/dev-util/bpftool/bpftool-7.5.0.ebuild?id=bf70fbf7b0dc97fbc97af579954ea81a8df36113#n94
>>
>> The bug for building with the new gcc-15 based toolchain where this
>> patch originated is here: https://bugs.gentoo.org/955156
> 
> So you're fixing this build error:
> 
> bpf-unknown-none-gcc \
>          -I. \
>          -I/var/tmp/portage/dev-util/bpftool-7.5.0/work/bpftool-libbpf-v7.5.0-sources/include/uapi/
> \
>          -I/var/tmp/portage/dev-util/bpftool-7.5.0/work/bpftool-libbpf-v7.5.0-sources/src/bootstrap/libbpf/include
> \
>          -g -O2 -Wall -fno-stack-protector \
>           -c skeleton/profiler.bpf.c -o profiler.bpf.o
> In file included from skeleton/profiler.bpf.c:3:
> ./vmlinux.h:5: warning: ignoring '#pragma clang attribute' [-Wunknown-pragmas]
>      5 | #pragma clang attribute push
> (__attribute__((preserve_access_index)), apply_to = record)
> ./vmlinux.h:9845:9: error: cannot use keyword 'false' as enumeration constant
>   9845 |         false = 0,
>        |         ^~~~~
> ./vmlinux.h:9845:9: note: 'false' is a keyword with '-std=c23' onwards
> ./vmlinux.h:31137:15: error: 'bool' cannot be defined via 'typedef'
> 31137 | typedef _Bool bool;
>        |               ^~~~
> 
> with -std=gnu11 flag and

Yes, correct. This is the same as all over the kernel or the bpf tests
for handling C23. I fully understand that this particular patch is only
one piece of the puzzle.

> ignoring an important warning ?

Nobody is (or was) ignoring the warning - it was under discussion when
I posted the patch. After reaching out to Oracle to verify, we have now
added the BPF_NO_PRESERVE_ACCESS_INDEX define when building with gcc-bpf;
this resolves the warning, just like in the bpf self-tests.

You are right that such an addition to the in-kernel bpftool build is
still missing. If you have a suggestion on how best to do that via the
existing Makefile I'm all ears.

As for the remaining warnings - we are also very aware of the ongoing
upstream work to support btf_type_tag:
https://gcc.gnu.org/pipermail/gcc-patches/2025-April/682340.html.

> End result: partially functional bpftool,
> and users will have no idea why some features of bpftool are not working.

First of all this is never shipped to any users; using gcc-bpf requires
active opt-in by developers or users, and now also warns that such a setup
may result in unexpected bugs due to ongoing work in both Linux and bpftool.
Like I said before, by default everyone builds with clang and that is also
true for our distributed binaries.

If you think adding the -std=gnu11 bit is inappropriate at this time then
just ignore this patch for now. Sooner or later the bpftool build will have
to be adapted with BPF_CFLAGS (liek in the selftests) and hopefuilly an
abstracted BPF_CC so that we no longer have to pretend to be clang when
using gcc.

cheers
Holger

