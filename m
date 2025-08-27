Return-Path: <bpf+bounces-66694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BE0B3882E
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 19:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 179212016AF
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 17:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8D12F0671;
	Wed, 27 Aug 2025 17:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ArF2Yf+x"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612AA17D346
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 17:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756314244; cv=none; b=iXARsPaNIZIiPmY8Bv3fuNN4KxnorgYYOnp7iYcsrYN4q8o0v9C3b4VtCIw/FP8gk9Ohc3cFg3b8TyW5s5gBmsWjEEc/Tb5Aw/52im+ANLgsqpdnmg1r3rZ4thexY81SI9+cb9Jkq87MoTtztsz5vTQ0Spjx9ibMBHZdAE6anD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756314244; c=relaxed/simple;
	bh=IxPWfX7fllkOMqmCtLvOEA5rWlkd5skRdp9ZDGjBOKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hoqNmFjJ5VIBXWmLC0cSMt2p2fofw01XKfXj7+kkdCbEah7bPaIC9pa+LvqXgz5bYX/xeRsDp0lgdrybPDHtpwf5P/YyyLzUrqgzd+owQrINByGi21tag5HBJjwBJMpZb7XNhgqYKDNo6qgSF03UERGd9ftdzOcfGtVw9QFJkEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ArF2Yf+x; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <78d0a599-4917-4551-b4c1-2c3cab743b8c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756314240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ilWDzghUV8p8XvjK/q+a/zevObs7wVtB7N3UxxnufE=;
	b=ArF2Yf+xGlVV5zfxmXo+U4pzvRDA0rqSGmhbSN2qaPejq7VzHyCgN0K3b2RVb7pjQ2DnJ6
	pijxPZeBw8Zp1AfOc6JpbirfuMZ0GqjeVZWl48QbQ+AOHEbrwGzV2wtgSFji69Bls35WF1
	PsgJyanX0POXuDiHzR785jNUQfzulgU=
Date: Wed, 27 Aug 2025 10:03:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: Mark kfuncs as __noclone
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, Andrea Righi <arighi@nvidia.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, David Vernet <void@manifault.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250822140553.46273-1-arighi@nvidia.com>
 <86de1bf6-83b0-4d31-904b-95af424a398a@linux.dev>
 <45c49b4eedc6038d350f61572e5eed9f183b781b.camel@gmail.com>
 <aK6aiEbgYaI9K-pt@gpd4>
 <622cc7980bad96bb2c7ac8d23619da1374c794a4.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <622cc7980bad96bb2c7ac8d23619da1374c794a4.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/26/25 11:52 PM, Eduard Zingerman wrote:
> On Wed, 2025-08-27 at 07:41 +0200, Andrea Righi wrote:
>> On Tue, Aug 26, 2025 at 10:02:31PM -0700, Eduard Zingerman wrote:
>>> On Tue, 2025-08-26 at 13:17 -0700, Yonghong Song wrote:
>>>
>>> [...]
>>>
>>>> I tried with gcc14 and can reproduced the issue described in the above.
>>>> I build the kernel like below with gcc14
>>>>     make KCFLAGS='-O3' -j
>>>> and get the following build error
>>>>     WARN: resolve_btfids: unresolved symbol bpf_strnchr
>>>>     make[2]: *** [/home/yhs/work/bpf-next/scripts/Makefile.vmlinux:91: vmlinux] Error 255
>>>>     make[2]: *** Deleting file 'vmlinux'
>>>> Checking the symbol table:
>>>>      22276: ffffffff81b15260   249 FUNC    LOCAL  DEFAULT    1 bpf_strnchr.cons[...]
>>>>     235128: ffffffff81b1f540   296 FUNC    GLOBAL DEFAULT    1 bpf_strnchr
>>>> and the disasm code:
>>>>     bpf_strnchr:
>>>>       ...
>>>>
>>>>     bpf_strchr:
>>>>       ...
>>>>       bpf_strnchr.constprop.0
>>>>       ...
>>>>
>>>> So in symbol table, we have both bpf_strnchr.constprop.0 and bpf_strnchr.
>>>> For such case, pahole will skip func bpf_strnchr hence the above resolve_btfids
>>>> failure.
>>>>
>>>> The solution in this patch can indeed resolve this issue.
>>> It looks like instead of adding __noclone there is an option to
>>> improve pahole's filtering of ambiguous functions.
>>> Abstractly, there is nothing wrong with having a clone of a global
>>> function that has undergone additional optimizations. As long as the
>>> original symbol exists, everything should be fine.
>>>
>>> Since kfuncs are global, this should guarantee that the compiler does not
>>> change their signature, correct? Does this also hold for LTO builds?
>>> If so, when pahole sees a set of symbols like [foo, foo.1, foo.2, ...],
>>> with 'foo' being global and the rest local, then there is no real need
>>> to filter out 'foo'.
>>>
>>> Wdyt?
>> I think we should do both: fix resolve_btfids to ignore compiler
>> optimization suffixes (.isra., .constprop., .part., .cold, ...) and add
>> __noclone.
>>
>> This feels like the safest path IMHO. Fixing resolve_btfids alone works
>> with current compilers, but future compiler versions, under aggressive
>> IPA/LTO optimizations, might decide that the main global symbol is
>> redundant and drop it altogether, leading to similar issues.
>>
>> Basically, fixing the tool makes the BTF pipeline more robust, adding
>> __noclone also makes the exported symbols themselves more robust,
>> regardless of compiler optimizations.
> If we are being really paranoid about LTO builds, is __noclone sufficient?
> E.g. [1] does not imply that signature can't be changed.
> We currently apply only __retain__, here is a little test with both attributes:
>
>      $ cat foo.c
>      __attribute__((__noclone__, __retain__))
>      int foo(int a) {
>        return a;
>      }
>
>      $ cat main.c
>      int foo(int);
>
>      int main(int argc, char **argv) {
>        return foo(0);
>      }
>
>      $ gcc -O3 -Wall -flto foo.c main.c -o a.out

Currently kernel does not support LTO for gcc build.

>      $ nm a.out | grep foo
>      $ objdump -Sdr a.out | grep foo
>      $ objdump -Sdr a.out | less
>      $ nm a.out | grep foo | wc -l
>      0
>      $ objdump -Sdr a.out | grep foo | wc -l
>      0
>
> export.h:EXPORT_SYMBOL does the following trick:
>
>    extern typeof(cachemode2protval) cachemode2protval;
>    static void * __attribute__((__used__))
>           __attribute__((__section__(".discard.addressable")))
>           __UNIQUE_ID___addressable_cachemode2protval489 = (void *)(uintptr_t)&cachemode2protval;
>           asm(".section \".export_symbol\",\"a\" ;\
>                __export_symbol_cachemode2protval: ;\
>                .asciz \"\" ;\
>                .ascii \"\" \"\\0\" ;\
>                .balign 8 ;\
>                .quad cachemode2protval ;\
>                .previous");
>
> Should we employ something similar?
>
> [1] https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-noclone-function-attribute


