Return-Path: <bpf+bounces-65283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAE0B1F010
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 23:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18ACE16A037
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 21:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427D9288C08;
	Fri,  8 Aug 2025 20:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXVEeneb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9C82874E3;
	Fri,  8 Aug 2025 20:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754686776; cv=none; b=Fp6uWkeXkTEr9YHCpFh2YLg/qd28P7tGDkx2tvnHS1jHx/9pXRYRWK2LxiVGtQ6YtjXCkpyVILDKegaJwAJHQLN6/s2sbZ5rm1eUUHgIQSBGIPjwMA2BY+r8HYUeko8xGL3Kl1gCQDpAeZY+nAHXP0h5UqqWVMiDbYPzPdHHwCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754686776; c=relaxed/simple;
	bh=QmUVIta1+p++1Wleb22s+zPEf90RBjOE5hL1f0LmdcY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=H5pi/y77KnDJeb/bZKD0ODaswxu93vkfnARMt1eci/cnDeUFl9c3MczXqGUxX7m5TNJxGovfUpAJ7eTmXsFjzh830p1iWF9OE0JeABAGs78oQ2CUOp4sstszQVWiFJYP7am+fCR1qy601pGLCrc0w5Ho/vp4jzaSCitlV1HiZsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXVEeneb; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-af97c0290dcso474257466b.0;
        Fri, 08 Aug 2025 13:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754686772; x=1755291572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CYXUq1Act5U9SR2FQXbR4UwBnW/gUPtGDQ6X3Vy1kaE=;
        b=VXVEenebajmdtEsSBE4xQVHtPQmgpB2jRg098cgb9/mBqBhZanH6ePj8nmOwDKWdjG
         s6dPa1+9mgd6jds9VZ3CsjTAu1ogP2FGowhk6CCFrHvIjbw83F8L11VDesm9Cz5yS5Bp
         4fkjSMn9g/8REo/+OHXIsXPg6K3HCyLIT0JMXqkaYp52yRZxXS4MM94GhU731iFE7skV
         n260HiwuQZK60BWWZuuxCqtBjsCsvDK8Ze+t+FRRSARrGOY5ltnwHbX4ZMT5bc7VafA9
         HsYN5YG8m6Ust8k912lduBvXfEAleGw7AvFMV32Qa2Z2/LgjtsKmesr0aLiDUU+H2TUZ
         889g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754686772; x=1755291572;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CYXUq1Act5U9SR2FQXbR4UwBnW/gUPtGDQ6X3Vy1kaE=;
        b=RcDVjWrSCZ/X/743dVumtHWBIbRgZdmSfivF7udA0EAMxsSQk00BKUh1PQNSjOfINY
         c++g12MBkaUoAoyZhQ9IGtvT+gAhzzyrviuPwfUrGv7KDPkBrlZPLS8Cha27zx4ttLK2
         auB+KiJte96zplCNWWHLkvK2IgJgypb8gsYs09ub2bYjs+NikaIItD+T9m2aIc8khz8c
         qhTRRlNQmw9iy7flVldStGHKj5bCRxEIflZbvSKcjc5Td7vu5SYsp1HD07M/GwgJ0/gI
         DjnCjZBuUOMzE3Jm8rKTvZcP63qmlyGU+1k6ZqCeC6vjC/W9iutthJCw11ebcSAQg5e8
         5eKw==
X-Forwarded-Encrypted: i=1; AJvYcCW+W+laEtBnNF2NpmXW1JB65vM1j40DZRE1kSOSMenKEO73P/D7TjDON5fiXPxmtW2UZ0N4SO4LDg==@vger.kernel.org, AJvYcCWjZlc6NkTELe0qq1yC4ycGM8OaZCfSQfnjLSfr0ZwCRxsCve28zh8BiYHxnEADlufT9O0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrUc7g+7MSeBAn+iqcUoBuHio6I70vU/Ek1oAgbSynek20aS4i
	+qaSU0z7wegyvOHA7aB98owA828g0KlQBlOSEiO3A0eduWzYddmbfKazfUaiY49SwTarNg==
X-Gm-Gg: ASbGncvjlYYm6N6S99WvLPZPd8RcBINWWAxH0uXDDTm8duVTwH6dFfemEBQZ+w72jfh
	qLwVcf7kr0ZnxIZ5PBXmnh7Dile1x6rZ5bZw3JQPyzVvbVOVdtWw66jtCgznseMXuhKz2l2LOPV
	HB1rKvA6vK82IIk/1IqS59LZ4tGgDQyNmStzZXAB0oyxsBUNfLI4GXnznPr2NPkoHIjF1B393FC
	62MzIdxghxKI6JQ4Av32z9Hmt93Mmox3E0sawkKGiz1N8tkvzoxjTVBYbhQm1KTjaxSxTd2eY6X
	7f/jz2KG4hATNvS/90++8UWx723lh4XPJhhmGDwAuCsRl+9QWYowLY83IqtjHg3Htxn+4J+h5aA
	gy54+LsYbloLhKC3vYzfoJNGOaUpLO82H6mgelg==
X-Google-Smtp-Source: AGHT+IGcd2xPsafrbvhdTdOp3rXTKOhAX70bZkncfFgfvF9gJi9xUZu3H5qP1m9EK8YIyu1uqToJMw==
X-Received: by 2002:a17:907:3cc1:b0:af9:31e7:4632 with SMTP id a640c23a62f3a-af9c65e80e3mr406769466b.57.1754686771968;
        Fri, 08 Aug 2025 13:59:31 -0700 (PDT)
Received: from ehlo.thunderbird.net ([176.223.172.243])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0763e4sm1558232766b.1.2025.08.08.13.59.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 13:59:31 -0700 (PDT)
Date: Fri, 08 Aug 2025 17:59:26 -0300
From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, nick.alcock@oracle.com,
 Alan Maguire <alan.maguire@oracle.com>
CC: Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
 Kate Carcia <kcarcia@redhat.com>, dwarves <dwarves@vger.kernel.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 "Jose E. Marchesi" <jose.marchesi@oracle.com>,
 Namhyung Kim <namhyung@kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [RFC 0/4] BTF archive with unmodified pahole+toolchain
User-Agent: Thunderbird for Android
In-Reply-To: <0c4043615432db7067fa6e2abae21d18cf3fd2a1.camel@gmail.com>
References: <20250807182538.136498-1-acme@kernel.org> <CAADnVQ+cvvHN9CunLP03yRFKz2YJirmF0j80-fZ0A-8aVVopPg@mail.gmail.com> <b297444e23c42caeab254c90fa91f46f75212e29.camel@gmail.com> <8EEC78FB-CBFA-4DFD-827D-3D5E809ACA0F@gmail.com> <0c4043615432db7067fa6e2abae21d18cf3fd2a1.camel@gmail.com>
Message-ID: <BFD0FD45-5668-4095-B26F-6824D886AD75@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On August 8, 2025 5:15:34 PM GMT-03:00, Eduard Zingerman <eddyz87@gmail=2E=
com> wrote:
>On Fri, 2025-08-08 at 16:10 -0300, Arnaldo Carvalho de Melo wrote:
>
>[=2E=2E=2E]
>
>> > I'd like to second Alexei's question=2E
>> > In the cover letter Arnaldo points out that un-deduplicated BTF
>> > amounts for 325Mb, while total DWARF size is 365Mb=2E
>> > I tried measuring total amount of DWARF in my kernel building directo=
ry:
>
>[=2E=2E=2E]
>
>> > And it says 845M=2E
>> > The size of DWARF sections in the final vmlinux is comparable to your=
s: 307Mb=2E
>> > The total size of the generated binaries is 905Mb=2E
>> > So, unless the above calculations are messed up, the total gain here =
is:
>> > - save ~500Mb generated during build
>> > - save some time on pahole not needing to parse/convert DWARF
>>=20
>> Well, this 845M number includes modules, that I didn't take into
>> account in my quick calculation for both DWARF and BTF=2E
>
>Sorry about that=2E I have just a few in my config, for those about 6Mb
>of DWARF is generated=2E

Initial numbers, I'll try and have some more comprehensive way to collect =
the relevant numbers and be able to compare approaches=2E

>> > Is this is what you are trying to achieve?
>>=20
>> > In theory, having BTF handled completely by compiler and linker makes
>> > sense to me=2E =20
>>=20
>> It looks right, no? But it's not efficient as BTF, as you point out
>> in your next paragraph, can be generated from DWARF, so better do it
>> as a final step if we want to have DWARF _and_ BTF=2E

>Idk, I'd stick to a single way of generating BTF, either using an old
>scheme or a new scheme=2E Allowing both will add one more variable when
>debugging BPF/BTF related issues reported from distros=2E

Well, I understand the push to pool scarce developer resources to get one =
way of doing things, be it using pahole or the tool chain (compiler + linke=
r)=2E

But at the same time having multiple ways to do the same thing, like we ha=
ve with multiple compilers and linkers is a good thing (tm)=2E

With multiple ways, developed mostly independently in ways some camps thin=
k hackish, we can give the people working in CI systems more job sekurity, =
build in many ways and see if differences are bugs, i=2Ee=2E we want reliab=
le info for co-re, etc, so having multiple producers and continuously compa=
ring their results seems desirable=2E

Sure, at should see what's the fastest, most reliable by track record, che=
apest way to produce both DWARF and BTF and use it=2E

Right now, among the schemes being discussed, it's what we have in place=
=2E Good=2E

>> > However, pahole is already here and it does the job=2E
>> > So, I see several drawbacks:
>> > - As you note, there would be two avenues to generate BTF now:
>> >  - DWARF + pahole
>> >  - BTF + pahole (replaced by BTF + ld at some point?)
>> >  This is a potential source of bugs=2E
>> >  Is the goal to forgo DWARF+pahole at some point in the future?

>> I think the goal is to allow DWARF less builds, which can probably
>> save time even if we do use pahole to convert DWARF generated from
>> the compiler into BTF and right away strip DWARF=2E

>> This is for use cases where DWARF isn't needed and we want to for
>> example have CI systems running faster=2E

>Ack, thank you for clarification=2E

>> My initial interest was to do minimal changes to pave the way for
>> BTF generated for vmlinux directly from the compiler, but the
>> realization that DWARF still has a lot of mileage, meaning distros
>> will continue to enable it for the foreseeable future makes me think
>> that maybe doing nothing and continue to use the current method is
>> the sensible thing to do=2E

>> > - I assume that it is much faster to land changes in pahole compared
>> >  to changes in gcc, so future btf modifications/features might be a
>> >  bit harder to execute=2E Wdyt?

>> Right, that too, even if we enable generation of BTF for native =2Eo
>> files by the compiler we would still want to use pahole to augment
>> it with new features or to fixup compiler BTF generation bugs=2E And
>> maybe for generating tags that are only possible to have the
>> necessary info at the last moment=2E

>> So something that looked like a hack seems not to really be one=2E

>Agree=2E

>> Then there's Gentoo, the one that likes the idea of a DWARF less
>> build=2E=2E=2E I like that too, so will continue working on this 8-)
>
>Out of curiosity, w/o DWARF how do you debug issues when something
>goes wrong?

Well, modern tooling support BTF when debugging/tracing/etc the _kernel_, =
see drgn, perf, and now even ftrace=2E Look ma, no DWARF :-)

>> Now if we could have hooks in the linker associated with a given ELF
>> section name (=2EBTF) to use instead of just concatenating, and then
>> at the end have another hook that would finish the process by doing
>> the dedup, just like I do in this series, that would save one of
>> those linker calls=2E
>>=20
>> I did some quick research and couldn't find such infrastructure in
>> the linkers, I think this is a sensible path, use the minimal
>> changes in my patch series to have a =2Eso plugin to use with a linker
>> that supports this, but then this, again, would make sense only for
>> a BTF only build=2E

>LD documentation page mentions existence of plugins [1],
>but after a cursory look at the source code I'm unable to tell how
>easy/hard/possible is BTF modification from such a plugin=2E

Yeah, linking looked like something done with, no need for this kind of ex=
tensibility=2E Nope, we need it now=2E=20

- Arnaldo=20

>
>[1] https://sourceware=2Eorg/binutils/docs/ld=2Ehtml#Plugins

- Arnaldo 

