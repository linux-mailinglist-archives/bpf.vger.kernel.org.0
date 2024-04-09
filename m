Return-Path: <bpf+bounces-26318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C25FA89E2B9
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 20:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E17E11C22B8F
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 18:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E62D157466;
	Tue,  9 Apr 2024 18:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdkMXkFO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00376156F51;
	Tue,  9 Apr 2024 18:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712688330; cv=none; b=OG9+ucRqhXGhW1YRfucFWmzGgNw4dfX/9iDACKZnLPFeO5vkJY9CKqmRqta2lbAMWHWcZwv8eJh2WkhWWJ0sJGYj2t3DevTtllH73L7gUy2dixf9rzgLIfSax3MKyKGFRFQRFDobiD5Ezt+2ZduRTSom73yuXwjyKM56Mjq6MCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712688330; c=relaxed/simple;
	bh=OqRRleEazBKgy7g4SN8piFb0+JbzzEDs+bjiofoNIcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdY+C7dWXseWfEJHsYIs/TNVO+Mvdd4d+djkgV3y0TWkoF0VWqNIe436lBoVPeo6WDsiQkKDORnchxzfsbc2VOU46RioB0tQC4Y1PaZH2w2MM9PLV2sfCwSiCbLgefAIgFkk+KHM8kGdV+5uNVhN8QMjxA6Rk3b6XmOEcZm68no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdkMXkFO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D17C43390;
	Tue,  9 Apr 2024 18:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712688329;
	bh=OqRRleEazBKgy7g4SN8piFb0+JbzzEDs+bjiofoNIcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pdkMXkFOnjxh1GfaaR9GL5oVUZhSEepCVs0qM+JXQZN7dwn8AAMOe4xX2G9ND2LZ/
	 2JOzeORd/qiKu5kTHN+mNfYI56qMboPlhm4iIfc4/tLo4eoQy9rLSZuWtuJ9vgX1HS
	 iC+bkC2rkoHIANVfqMsCf3DbJOkA7cNLug+kRy71eX5vv5zPY0adLB6DQKg7AG74mB
	 zj+hn0onANmBVwArdNYIncN0ld455Ka7owZyd4KXAG71v/0jnmG+G38fIdVEM9dtNM
	 ePGDAxWjeIyYUn8YYyJ5FbfGUepXtTWmvuNa+Avr2+THFyR9TjDqblGjgF16EPL9W2
	 KzmkdrPeRkb7A==
Date: Tue, 9 Apr 2024 15:45:26 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org,
	Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>, bpf <bpf@vger.kernel.org>,
	Kui-Feng Lee <kuifeng@fb.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [RFC/PATCHES 00/12] pahole: Reproducible parallel DWARF
 loading/serial BTF encoding
Message-ID: <ZhWMxu8Xq1oAUAoC@x1>
References: <20240402193945.17327-1-acme@kernel.org>
 <747816d2edd61a075d200ffa5da680d2cc2d6854.camel@gmail.com>
 <64bfcf02-030d-471a-871a-e7490d74ca28@oracle.com>
 <db6480e9378f59c367b03f7455372caf7b593348.camel@gmail.com>
 <CAADnVQKnkGVL3Snaa-E+EpG536rauWZmn_kZsgQK-oaESfjjQg@mail.gmail.com>
 <7a08fb6a8c37e58a56121c8536b9ab68405c049d.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a08fb6a8c37e58a56121c8536b9ab68405c049d.camel@gmail.com>

On Tue, Apr 09, 2024 at 06:01:08PM +0300, Eduard Zingerman wrote:
> On Tue, 2024-04-09 at 07:56 -0700, Alexei Starovoitov wrote:
> [...]
 
> > I would actually go with sorted BTF, since it will probably
> > make diff-ing of BTFs practical. Will be easier to track changes

What kind of diff-ing of BTFs from different kernels are you interested
in?

in pahole's repository we have btfdiff, that will, given a vmlinux with
both DWARF and BTF use pahole to pretty print all types, expanded, and
then compare the two outputs, which should produce the same results from
BTF and DWARF. Ditto for DWARF from a vmlinux compared to a detached BTF
file.

And also now we have another regression test script that will produce
the output from 'btftool btf dump' for the BTF generated from DWARF in
serial mode, and then compare that with the output from 'bpftool btf
dump' for reproducible encodings done using -j 1 ...
number-of-processors-on-the-machine. All have to match, all types, all
BTF ids.

We can as well use something like btfdiff to compare the output from
'pahole --expand_types --sort' for two BTFs for two different kernels,
to see what are the new types and the changes to types in both.

What else do you want to compare? To be able to match we would have to
somehow have ranges for each DWARF CU so that when encoding and then
deduplicating we would have space in the ID space for new types to fill
in while keeping the old types IDs matching the same types in the new
vmlinux.

While ordering all types we would have to have ID space available from
each of the BTF kinds, no?

I haven't looked at Eduard's patches, is that what it is done?

> > from one kernel version to another. vmlinux.h will become
> > a bit more sorted too and normal diff vmlinux_6_1.h vmlinux_6_2.h
> > will be possible.
> > Or am I misunderstanding the sorting concept?
 
> You understand the concept correctly, here is a sample:
 
>   [1] INT '_Bool' size=1 bits_offset=0 nr_bits=8 encoding=BOOL
>   [2] INT '__int128' size=16 bits_offset=0 nr_bits=128 encoding=SIGNED
>   [3] INT '__int128 unsigned' size=16 bits_offset=0 nr_bits=128 encoding=(none)
>   [4] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=(none)
>   [5] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
>   [6] INT 'long int' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED
>   [7] INT 'long long int' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED

The above: so far so good, probably there will not be something that
will push what is now BTF id 6 to become 7 in a new vmlinux, but can we
say the same for the more dynamic parts, like the list of structs?

A struct can vanish, that abstraction not being used anymore in the
kernel, so its BTF id will vacate and all of the next struct IDs will
"fall down" and gets its IDs decremented, no?

If these difficulties are present as I mentioned, then rebuilding from
the BTF data with something like the existing 'pahole --expand_types
--sort' from the BTF from kernel N to compare with the same output for
kernel N + 1 should be enough to see what changed from one kernel to the
next one?

- Arnaldo

>   ...
>   [15085] STRUCT 'arch_elf_state' size=0 vlen=0
>   [15086] STRUCT 'arch_vdso_data' size=0 vlen=0
>   [15087] STRUCT 'bpf_run_ctx' size=0 vlen=0
>   [15088] STRUCT 'dev_archdata' size=0 vlen=0
>   [15089] STRUCT 'dyn_arch_ftrace' size=0 vlen=0
>   [15090] STRUCT 'fscrypt_dummy_policy' size=0 vlen=0
>   ...
>   
> (Sort by kind, than by vlen, than by name because sorting by name is a
>  bit costly, then by member properties)

