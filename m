Return-Path: <bpf+bounces-45011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E04219CFCAC
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 05:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8387B235D6
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 04:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5ED190678;
	Sat, 16 Nov 2024 04:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rYDxJ4Yq"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803DC4C8F
	for <bpf@vger.kernel.org>; Sat, 16 Nov 2024 04:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731731958; cv=none; b=JPV3Y4dj2MRVeZn9KbmNYkHQRS/wze28BEbtVfnNpQpQfh8lkq5P1to87kLX01LvW8cL8hA+CS67qsEgxZKDzKSZ9A2QrUGy/MfOGzG2pqrMa9zXJnxi42inFm8FBzvYmBLHTHAIR1YNJvhXaD5/Ap/m3U4Anls3aRdze+i0sp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731731958; c=relaxed/simple;
	bh=69MZ8Ux8IkZqMWGRsmB7MCdRWg8x1R/Dz0onrATp1W0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kC2/e+j412Ormg68jI3o79u/SkklFl1vGiOyduCbc72GnK8qN7EEBD9ZbZmbaw3/OBJEWjbaPza9tdTOTPtmepGMWO/S3VjGOk0G1e5qFGxazdutG21vdSf+X7gKl6M2rsETj9gahaF1FbC087UNg9vjKEu9XxYwTbxWMWBh7jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rYDxJ4Yq; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <42a9055c-0bca-4bc6-acbf-f177de1ba2d3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731731953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WWnTWY4YXgpRmGyy+EQ9ceBcONiKOcY+50P7u3fv6vE=;
	b=rYDxJ4YqJyJf7VsBX+kohbyNdUNz8ofwc/zEzO2rGhTBFN6hjO7+hDCToSvwycexeDcLmp
	zpCTwqbKV6vovi74tHtVCXBiq2LFCaWLKUn7WY/uY3WaIF8jiHSsHBc+UM2HcxaEGVV2oZ
	9jfUYez4RnUHh2t9cumlgp+TyC0Oofk=
Date: Fri, 15 Nov 2024 20:39:05 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH] libbpf: Change hash_combine parameters from long to
 __u32
Content-Language: en-GB
To: Sidong Yang <sidong.yang@furiosa.ai>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241115103422.55040-1-sidong.yang@furiosa.ai>
 <CAEf4BzYape9gtc7k1NQMD5BrfakzDXV_9SHNqZeamcaSKn744Q@mail.gmail.com>
 <Zzfo8YCeNkbCQDTg@sidongui-MacBookPro.local>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <Zzfo8YCeNkbCQDTg@sidongui-MacBookPro.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT




On 11/15/24 4:36 PM, Sidong Yang wrote:
> On Fri, Nov 15, 2024 at 11:57:24AM -0800, Andrii Nakryiko wrote:
>> On Fri, Nov 15, 2024 at 2:51 AM Sidong Yang <sidong.yang@furiosa.ai> wrote:
>>> The hash_combine() could be trapped when compiled with sanitizer like "zig cc".
>>> This patch changes parameters to __u32 to fix it.
>> Can you please elaborate? What exactly are you fixing? "Undefined"
>> signed integer overflow? I can consider changing long to unsigned
>> long, but I don't think we should downgrade from long all the way to
>> 32-bit u32. I'd rather keep all those 64 bits for hash.
> Hi, Andrii.
>
> Actually I'm using libbpf-rs with maturin build that makes python package for
> rust. It seems that it uses zig cc for cross compilation. It compiles libbpf
> like this command.
>
> CC="zig cc" make CFLAGS="-fsanitize-trap"
>
> And hash_combine's result is like below.
>
> 0000000000063860 <hash_combine>:
>     63860:       55                      push   %rbp
>     63861:       48 89 e5                mov    %rsp,%rbp
>     63864:       48 89 7d f8             mov    %rdi,-0x8(%rbp)
>     63868:       48 89 75 f0             mov    %rsi,-0x10(%rbp)
>     6386c:       b8 1f 00 00 00          mov    $0x1f,%eax
>     63871:       48 0f af 45 f8          imul   -0x8(%rbp),%rax
>     63876:       48 89 45 e8             mov    %rax,-0x18(%rbp)
>     6387a:       0f 90 c0                seto   %al
>     6387d:       34 ff                   xor    $0xff,%al
>     6387f:       a8 01                   test   $0x1,%al
>     63881:       0f 85 05 00 00 00       jne    6388c <hash_combine+0x2c>
> -> 63887:       67 0f b9 40 0c          ud1    0xc(%eax),%eax
>     6388c:       48 8b 45 e8             mov    -0x18(%rbp),%rax
>     63890:       48 03 45 f0             add    -0x10(%rbp),%rax
>     63894:       48 89 45 e0             mov    %rax,-0x20(%rbp)
>     63898:       0f 90 c0                seto   %al
>     6389b:       34 ff                   xor    $0xff,%al
>     6389d:       a8 01                   test   $0x1,%al
>     6389f:       0f 85 04 00 00 00       jne    638a9 <hash_combine+0x49>
>     638a5:       67 0f b9 00             ud1    (%eax),%eax
>     638a9:       48 8b 45 e0             mov    -0x20(%rbp),%rax
>     638ad:       5d                      pop    %rbp
>     638ae:       c3                      ret
>     638af:       90                      nop
>
> When I'm using libbpf-rs, it receives SIGILL for ud1 instruction.
> It seems more appropriate to use u64 instead of u32, doesn't it?
> I'll work on it.

Yes, this is due to potential integer overflow.

I tried with clang with additional flags
    -fsanitize=signed-integer-overflow -fsanitize-trap=all
and disable inlining for hash_combine().
The asm code (the code is compiled with -O2)

0000000000007cb0 <hash_combine>:
     7cb0: 48 6b c7 1f                   imulq   $0x1f, %rdi, %rax
     7cb4: 70 06                         jo      0x7cbc <hash_combine+0xc>
     7cb6: 48 01 f0                      addq    %rsi, %rax
     7cb9: 70 06                         jo      0x7cc1 <hash_combine+0x11>
     7cbb: c3                            retq
     7cbc: 67 0f b9 40 0c                ud1l    0xc(%eax), %eax
     7cc1: 67 0f b9 00                   ud1l    (%eax), %eax
     7cc5: 66 66 2e 0f 1f 84 00 00 00 00 00      nopw    %cs:(%rax,%rax)

Here 'jo' means 'jump if overflow'.
So if overflow happens, 'ud1l' will execute and dump error.

Changing 'long' type to 'unsigned long' should fix the problem.

>
> Thanks,
> Sidong
>> pw-bot: cr
>>
>>> Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
>>> ---
>>>   tools/lib/bpf/btf.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>>> index 8befb8103e32..11ccb5aa4958 100644
>>> --- a/tools/lib/bpf/btf.c
>>> +++ b/tools/lib/bpf/btf.c
>>> @@ -3548,7 +3548,7 @@ struct btf_dedup {
>>>          struct strset *strs_set;
>>>   };
>>>
>>> -static long hash_combine(long h, long value)
>>> +static __u32 hash_combine(__u32 h, __u32 value)
>>>   {
>>>          return h * 31 + value;
>>>   }
>>> --
>>> 2.42.0
>>>
>>>


