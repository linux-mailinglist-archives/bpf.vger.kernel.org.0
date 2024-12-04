Return-Path: <bpf+bounces-46120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6989E477C
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 23:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59936163949
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 22:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742F019DF98;
	Wed,  4 Dec 2024 22:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cusyRzWA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A31194C94;
	Wed,  4 Dec 2024 22:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733350102; cv=none; b=mVnXHnGSo5MpOHgrgBro3P2LWznKztMHSgSN6pql1aN+L32i+n70v3j26Q1xhpbG8x6rpOFpL97U5MxCMExdg9QRkKLgYquHG2ZlXe1KeQKW6Xet82vctJNaRk1pAMhvgmqEv7O8X5q7qRROPqFuMYowUMIZbeG5AvWDJnAOPzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733350102; c=relaxed/simple;
	bh=dDeGdNCjF74KwY0MX07HSBQzSKPMdTi2G/auzevOK+I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rZS1bUPIRRCbkdzP7QvAZ0AHQDVEfWXUqsiIr0yQPLaMgHK2cVimPmSCcl+YOqQHev7XFAON7QWdOEK0IqMbWrga5za89b860w5Im/E7kfyp0nRwlfCr1rHrd0dP36Ly25ZEQN1c37hbd+zaiVM4OCjaJ9NXub81MeHF8+GC67U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cusyRzWA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99EA5C4CECD;
	Wed,  4 Dec 2024 22:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733350101;
	bh=dDeGdNCjF74KwY0MX07HSBQzSKPMdTi2G/auzevOK+I=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=cusyRzWAIEmcpZ0qfrqMrrm1qz6iXPcNDcbx73p+i6CtBHrI4DDRGy1/3gG4zXL5Q
	 vsmIpPlXA8BLXIQ7PcYu4+bJqpvR8tAy49YlL7Zvfec0PPEYiBWIjpfe4Kk7D0Ekeq
	 PB87JtdeC8/vbWFfuAo0N2SNzLz5BHCW4H35QtRoKqB5Kr3OPeipbkDdZT55X43Mdd
	 IP/viasKusOA8tVgh48TfLJp/VUHgOwg8dJFo8wjW8uKBVfM+YUbDoQv2ZI+UjhkGS
	 piq2q0Op1SsG96oGaM3wN4Odq8hQRGJTlE/Dh3ldECmrCrk/CapdHH8shup78eV9D0
	 mEBKVj1MJcHtg==
Message-ID: <bf5da4d3-c317-4616-ac68-0d49bb5815c2@kernel.org>
Date: Wed, 4 Dec 2024 22:08:15 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH] bpftool: Fix failure with static linkage
To: Namhyung Kim <namhyung@kernel.org>, Leo Yan <leo.yan@arm.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
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
Content-Language: en-GB
In-Reply-To: <Z1DLYCha0-o1RWkF@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-12-04 13:36 UTC-0800 ~ Namhyung Kim <namhyung@kernel.org>
> Hi Leo,
> 
> On Wed, Dec 04, 2024 at 09:30:59PM +0000, Leo Yan wrote:
>> When building perf with static linkage:
>>
>>   make O=/build LDFLAGS="-static" -C tools/perf VF=1 DEBUG=1
>>   ...
>>   LINK    /build/util/bpf_skel/.tmp/bootstrap/bpftool
>>   /usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/13/../../../x86_64-linux-gnu/libelf.a(elf_compress.o): in function `__libelf_compress':
>>   (.text+0x113): undefined reference to `ZSTD_createCCtx'
>>   /usr/bin/ld: (.text+0x2a9): undefined reference to `ZSTD_compressStream2'
>>   /usr/bin/ld: (.text+0x2b4): undefined reference to `ZSTD_isError'
>>   /usr/bin/ld: (.text+0x2db): undefined reference to `ZSTD_freeCCtx'
>>   /usr/bin/ld: (.text+0x5a0): undefined reference to `ZSTD_compressStream2'
>>   /usr/bin/ld: (.text+0x5ab): undefined reference to `ZSTD_isError'
>>   /usr/bin/ld: (.text+0x6b9): undefined reference to `ZSTD_freeCCtx'
>>   /usr/bin/ld: (.text+0x835): undefined reference to `ZSTD_freeCCtx'
>>   /usr/bin/ld: (.text+0x86f): undefined reference to `ZSTD_freeCCtx'
>>   /usr/bin/ld: (.text+0x91b): undefined reference to `ZSTD_freeCCtx'
>>   /usr/bin/ld: (.text+0xa12): undefined reference to `ZSTD_freeCCtx'
>>   /usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/13/../../../x86_64-linux-gnu/libelf.a(elf_compress.o): in function `__libelf_decompress':
>>   (.text+0xbfc): undefined reference to `ZSTD_decompress'
>>   /usr/bin/ld: (.text+0xc04): undefined reference to `ZSTD_isError'
>>   /usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/13/../../../x86_64-linux-gnu/libelf.a(elf_compress.o): in function `__libelf_decompress_elf':
>>   (.text+0xd45): undefined reference to `ZSTD_decompress'
>>   /usr/bin/ld: (.text+0xd4d): undefined reference to `ZSTD_isError'
>>   collect2: error: ld returned 1 exit status
>>
>> Building bpftool with static linkage also fails with the same errors:
>>
>>   make O=/build -C tools/bpf/bpftool/ V=1
>>
>> To fix the issue, explicitly link libzstd.
> 
> I was about to report exactly the same. :)

Thank you both. This has been reported before [0] but I didn't find the
time to look into a proper fix.

The tricky part is that static linkage works well without libzstd for
older versions of elfutils [1], but newer versions now require this
library. Which means that we don't want to link against libzstd
unconditionally, or users trying to build bpftool may have to install
unnecessary dependencies. Instead we should add a new probe under
tools/build/feature (Note that we already have several combinations in
there, libbfd, libbfd-liberty, libbfd-liberty-z, and I'm not sure what's
the best approach in terms of new combinations).

Thanks,
Quentin


[0] https://github.com/libbpf/bpftool/issues/152
[1] https://github.com/libbpf/bpftool/issues/152#issuecomment-2343131810

