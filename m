Return-Path: <bpf+bounces-46124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF8C9E482F
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 23:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A83E2809AE
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 22:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C102391AD;
	Wed,  4 Dec 2024 22:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpW9QQN8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CB11B3955;
	Wed,  4 Dec 2024 22:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733352938; cv=none; b=AMFIqyQev0c+2XPP6BwsShvCs75SgImiV5MxHzCnOreJK5S+sthHhWtPG108gC8ZRSbEFVdGD78YZFlqLpy8Z6J4KhWjAchaw3cCVXUypPyqkow9UMAoonfw3kC+NGP4N5TaGWnW1VjNecHe/6yj6pJ79p2jpL3+tCXkqdivl7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733352938; c=relaxed/simple;
	bh=+Q45rMcj/Fj7beQEwYwmqYRFo5yImuTS1FBU1UB/mj0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iloH3d7xO718U4gpfJwUZjZIWp3F7slzjoDMF4r88WwPoZIykpNcPUXynbhFcIeba5g372kU8GdbOHfXNWlwADDZBjYNgYM7PiU40LToBoiBfsTPJ0OAoD6R79tgyu6PssBqX2DFqFNw9LDaXlep74sKe3KUvhCsDWHV5PeBRX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpW9QQN8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CFEC4CECD;
	Wed,  4 Dec 2024 22:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733352937;
	bh=+Q45rMcj/Fj7beQEwYwmqYRFo5yImuTS1FBU1UB/mj0=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=fpW9QQN8bXNpNBx5eqf+nU+gDjqK42IVHeUmo06lbiIaDIgBAMVXSH97AR2VV2Bq0
	 by7j6CwsL5T9O21yWDLhuqtkqiPR0ZgxJOB/7N/WyiUelSNaECAv3iR5IW88hYU07A
	 S/hjHARwttPbuMLxZKjmcuc+5HC7OiTJP1dTyvQ8KzCXNMSyNVY/NGQBHZ2JbvHlmJ
	 vzo3Nrxxt0yI2c2Cc9QxVW/zF6UohJ4YTtYHpn/QANoYWYxtU9HQAl/Ev39ym3PxsA
	 L+AdbKSbXh+lq3AqHy+kfhIbncEQuDikdQwDi9221ewP1n+VzNUeubGoHomRQXHXPY
	 Gm7Yfe24J4RzA==
Message-ID: <d4d5e80d-1a95-4ef7-a83f-1303563a91eb@kernel.org>
Date: Wed, 4 Dec 2024 22:55:32 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH] bpftool: Fix failure with static linkage
To: Namhyung Kim <namhyung@kernel.org>
Cc: Leo Yan <leo.yan@arm.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Nick Terrell <terrelln@fb.com>,
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mahe Tardy <mahe.tardy@gmail.com>
References: <20241204213059.2792453-1-leo.yan@arm.com>
 <Z1DLYCha0-o1RWkF@google.com>
 <bf5da4d3-c317-4616-ac68-0d49bb5815c2@kernel.org>
 <Z1DW1aJ4rYlMI6S1@google.com>
Content-Language: en-GB
In-Reply-To: <Z1DW1aJ4rYlMI6S1@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-12-04 14:25 UTC-0800 ~ Namhyung Kim <namhyung@kernel.org>
> Hello,
> 
> On Wed, Dec 04, 2024 at 10:08:15PM +0000, Quentin Monnet wrote:
>> 2024-12-04 13:36 UTC-0800 ~ Namhyung Kim <namhyung@kernel.org>
>>> Hi Leo,
>>>
>>> On Wed, Dec 04, 2024 at 09:30:59PM +0000, Leo Yan wrote:
>>>> When building perf with static linkage:
>>>>
>>>>   make O=/build LDFLAGS="-static" -C tools/perf VF=1 DEBUG=1
>>>>   ...
>>>>   LINK    /build/util/bpf_skel/.tmp/bootstrap/bpftool
>>>>   /usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/13/../../../x86_64-linux-gnu/libelf.a(elf_compress.o): in function `__libelf_compress':
>>>>   (.text+0x113): undefined reference to `ZSTD_createCCtx'
>>>>   /usr/bin/ld: (.text+0x2a9): undefined reference to `ZSTD_compressStream2'
>>>>   /usr/bin/ld: (.text+0x2b4): undefined reference to `ZSTD_isError'
>>>>   /usr/bin/ld: (.text+0x2db): undefined reference to `ZSTD_freeCCtx'
>>>>   /usr/bin/ld: (.text+0x5a0): undefined reference to `ZSTD_compressStream2'
>>>>   /usr/bin/ld: (.text+0x5ab): undefined reference to `ZSTD_isError'
>>>>   /usr/bin/ld: (.text+0x6b9): undefined reference to `ZSTD_freeCCtx'
>>>>   /usr/bin/ld: (.text+0x835): undefined reference to `ZSTD_freeCCtx'
>>>>   /usr/bin/ld: (.text+0x86f): undefined reference to `ZSTD_freeCCtx'
>>>>   /usr/bin/ld: (.text+0x91b): undefined reference to `ZSTD_freeCCtx'
>>>>   /usr/bin/ld: (.text+0xa12): undefined reference to `ZSTD_freeCCtx'
>>>>   /usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/13/../../../x86_64-linux-gnu/libelf.a(elf_compress.o): in function `__libelf_decompress':
>>>>   (.text+0xbfc): undefined reference to `ZSTD_decompress'
>>>>   /usr/bin/ld: (.text+0xc04): undefined reference to `ZSTD_isError'
>>>>   /usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/13/../../../x86_64-linux-gnu/libelf.a(elf_compress.o): in function `__libelf_decompress_elf':
>>>>   (.text+0xd45): undefined reference to `ZSTD_decompress'
>>>>   /usr/bin/ld: (.text+0xd4d): undefined reference to `ZSTD_isError'
>>>>   collect2: error: ld returned 1 exit status
>>>>
>>>> Building bpftool with static linkage also fails with the same errors:
>>>>
>>>>   make O=/build -C tools/bpf/bpftool/ V=1
>>>>
>>>> To fix the issue, explicitly link libzstd.
>>>
>>> I was about to report exactly the same. :)
>>
>> Thank you both. This has been reported before [0] but I didn't find the
>> time to look into a proper fix.
>>
>> The tricky part is that static linkage works well without libzstd for
>> older versions of elfutils [1], but newer versions now require this
>> library. Which means that we don't want to link against libzstd
>> unconditionally, or users trying to build bpftool may have to install
>> unnecessary dependencies. Instead we should add a new probe under
>> tools/build/feature (Note that we already have several combinations in
>> there, libbfd, libbfd-liberty, libbfd-liberty-z, and I'm not sure what's
>> the best approach in terms of new combinations).
> 
> I think you can use pkg-config if available.
> 
>   $ pkg-config --static --libs libelf
>   -lelf -lz -lzstd -pthread 
> 


That's another dependency that I'd like to avoid if I can :)

Quentin

