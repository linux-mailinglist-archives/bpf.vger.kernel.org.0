Return-Path: <bpf+bounces-69110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5489AB8CF03
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 20:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34E541B26E20
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 18:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB0331327D;
	Sat, 20 Sep 2025 18:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GX6KB4gn"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266193126AE
	for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 18:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758394233; cv=none; b=mucTZROdIyGra9YNWwTQfDfsZqqOTTJZqY4zCylJA3vJaBDonRg4FJZgzlAzKFeSVajNO1VMT0Su2G7kj6HDhC2jPJvgfEGyoWK2sZV5PYipLlOJ6Qv3ry+6GTyiW+zM7GjDQIXV7T+RFox7j1+taXHrddBlj2PWN1jUw5nGgyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758394233; c=relaxed/simple;
	bh=n2wqC0IGgkvLWgz5KVU5Y61pAoOG8M2NrtN+OM9gwyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qpjct/KWn0kaRmzgCLQCnpS82sLX7/5i5ONi5wLT8qR7SnelljMZA+ipB3u8Qj/4MnvhP1dqYQAU9BI5ZlHjI2p6nIZjsIxTCMjfT+4LZ1aqyb62SLjQlXQo8l0en0wcl3bPAbhmuztLrhyDxUdDvELgUikCgJ8htemtJ8r6Po4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GX6KB4gn; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9ba2b2fb-e92c-4b0d-bf39-d655ab8e9f1e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758394226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z8GYkezBpHIV3ba1SOFL8R/MLN47+ScSXn6gifOOr4E=;
	b=GX6KB4gnv6kvLFPBGtjUBgQwGUaBLByy8v5V8ZY0IZIwwRKPwHNeGrRxIp5GUEqG5rK8QN
	RU0qzKfK3KBLiKd8UfOzovBnjleql1yZycrjiSb6BmsiXsLS3Nk+/HGB+JcmzdYQXld3x7
	NhHalRJ8aBPGu1zGZrqqp9tHP3BVaOE=
Date: Sat, 20 Sep 2025 11:50:17 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] libbpf: Silence newly-added and unused sections
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20250920153531.3675700-1-yonghong.song@linux.dev>
 <CAADnVQJ-28Oy9OoKXtnDOZBxkDofuwfWS-cdSFHd1uqpOmNLmQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJ-28Oy9OoKXtnDOZBxkDofuwfWS-cdSFHd1uqpOmNLmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 9/20/25 8:56 AM, Alexei Starovoitov wrote:
> On Sat, Sep 20, 2025 at 8:35 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> With latest llvm22, when building bpf selftest, I got the following info
>> emitted by libbpf:
>>    ...
>>    libbpf: elf: skipping unrecognized data section(14) .comment
>>    libbpf: elf: skipping section(15) .note.GNU-stack (size 0)
>>    ...
>>
>> The reason is due to llvm patch [1]. Previously, bpf class BPFMCAsmInfo
>> inherits class MCAsmInfo. With [1], BPFMCAsmInfo inherits class
>> MCAsmInfoELF. Such a change added two more sections in the bpf binary, e.g.
>>    [Nr] Name              Type            Address          Off    Size   ES Flg Lk Inf Al
>>    ...
>>    [23] .comment          PROGBITS        0000000000000000 0035ac 00006d 01  MS  0   0  1
>>    [24] .note.GNU-stack   PROGBITS        0000000000000000 003619 000000 00      0   0  1
>>    ...
>>
>> Adding the above two sections in elf section ignore list can avoid the
>> above info dump during selftest build.
>>
>>    [1] https://github.com/llvm/llvm-project/commit/d9489fd073c0e100c6fbb1e5aef140b00cf62b81
> Can we revert this instead?
> Why do we need these sections if we're not doing anything with them?

I did further investigation and it looks like it is hard to revert.
To make things work at llvm level, we need to revert the following two llvm commits:
   https://github.com/llvm/llvm-project/commit/87c73f498d3e98c7b6471f81e25b7e08106053fe
and then
   https://github.com/llvm/llvm-project/commit/d9489fd073c0e100c6fbb1e5aef140b00cf62b81

The commit
   https://github.com/llvm/llvm-project/commit/d9489fd073c0e100c6fbb1e5aef140b00cf62b81
lets BPFMCAsmInfo derives from MCAsmInfoELF, and the commit
   https://github.com/llvm/llvm-project/commit/87c73f498d3e98c7b6471f81e25b7e08106053fe
push printSwitchToSection() to each variant of MCAsmInfo. The MCAsmInfo itself contains

+  virtual void printSwitchToSection(const MCSection &, uint32_t Subsection,
+                                    const Triple &, raw_ostream &) const {}

and
MCAsmInfoCOFF, MCAsmInfoDarwin and MCAsmInfoELF have their own specific
implementation.

So if just revert d9489fd073c0e100c6fbb1e5aef140b00cf62b81, then at BPF backend,
printSwitchToSection() will be a noop. This will miss a lot of '.seciton ...'
cases. For example, there are totally 89 llvm BPF selftest failures.

For example, for jump table support, all '.jumptables' section name will not in
asm code. Another example, '.BTF' section name will miss as well.

So to make the thing work, reverting both commits are necessary.
But tt will be hard to revert llvm commit 87c73f498d3e98c7b6471f81e25b7e08106053fe
since it contains lots of non-BPF changes.

So I recommend to fix the problem at libbpf level.

>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   tools/lib/bpf/libbpf.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 5161c2b39875..34aed7904039 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -3788,6 +3788,14 @@ static bool ignore_elf_section(Elf64_Shdr *hdr, const char *name)
>>          if (is_sec_name_dwarf(name))
>>                  return true;
>>
>> +       /* .comment section */
>> +       if (strcmp(name, ".comment") == 0)
>> +               return true;
>> +
>> +       /* .note.GNU-stack section */
>> +       if (strcmp(name, ".note.GNU-stack") == 0)
>> +               return true;
>> +
>>          if (str_has_pfx(name, ".rel")) {
>>                  name += sizeof(".rel") - 1;
>>                  /* DWARF section relocations */
>> --
>> 2.47.3
>>


