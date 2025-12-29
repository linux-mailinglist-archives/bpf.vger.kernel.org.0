Return-Path: <bpf+bounces-77489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC0ACE825E
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 21:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A3713001BDB
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 20:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1672D23A4;
	Mon, 29 Dec 2025 20:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PpooQzLL"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312B72C2340
	for <bpf@vger.kernel.org>; Mon, 29 Dec 2025 20:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767040825; cv=none; b=MZJF6nJJv0caWKM5rjHmQKMcYr4j0vB4R5XBHNtBOKbpc40pwzz7aTPvjckHKWp5fHXDSgE10vcfnj2Pd9DBiKECTMB2IGzY82/HthtOocd9QVZZ+kMk12wA3D7rvM7cietcsH6VHaX8dKYSjm5hT1FQG9xFfOph4yQIyDxU3Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767040825; c=relaxed/simple;
	bh=hYamOfS6TIAEu7pt2Unyg+Y5yMCwtDePRFhMJ+PirXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n/Wm/mez2APKbMgL6TFMTqK7JwRs5FEKM3vpUSzfWrIchn20vHhUMnu+Dw05WCiXsMPRrtQ9+ThUDISrzz/k5bYCEKr5wc5S/ZeohJQujr5AGLNKBhO9w5RgF5s3vClP7jDJ3BRgmxSEL8Lyjg37wptfinmwd/0mt84jKtEDAG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PpooQzLL; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <af906e9e-8f94-41f5-9100-1a3b4526e220@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767040821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9iSbqGt05qGCDVCyvYvl6leLwTAA8O7BjOn63M9MuBM=;
	b=PpooQzLLqFDI4KR7FlDd1BnjJOEKlyV4qFsWSGHiZXiozWIqhJkBgRhjpR3Mh2O4toPcF8
	4n1FPykGk7r/XlNHThX4W8xbgdt+AtYaP6OA7FtmIs9h4c7xFa/Ajs6Ng9+ixkZtrPvWmP
	bdTi6TLxIXa5Zt/IDdBQx5jPU/PpLwQ=
Date: Mon, 29 Dec 2025 12:40:10 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v1] module: Fix kernel panic when a symbol st_shndx is
 out of bounds
To: Yonghong Song <yonghong.song@linux.dev>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 bpf@vger.kernel.org, linux-kbuild@vger.kernel.org, llvm@lists.linux.dev
References: <20251224005752.201911-1-ihor.solodrai@linux.dev>
 <9edd1395-8651-446b-b056-9428076cd830@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <9edd1395-8651-446b-b056-9428076cd830@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 12/23/25 9:36 PM, Yonghong Song wrote:
> 
> 
> On 12/23/25 4:57 PM, Ihor Solodrai wrote:
>> [...]
>>
>> While this llvm-objcopy bug is not fixed, we can not trust it in the
>> kernel build pipeline. In the short-term we have to come up with a
>> workaround for .BTF_ids section update and replace the calls to
>> ${OBJCOPY} --update-section with something else.
>>
>> One potential workaround is to force the use of the objcopy (from
>> binutils) instead of llvm-objcopy when updating .BTF_ids section.

I think the simplest workaround is this one: use objcopy from binutils
instead of llvm-objcopy when doing --update-section.

There are just 3 places where that happens, so the OBJCOPY
substitution is going to be localized.

Also binutils is a documented requirement for compiling the kernel,
whether with clang or not [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/changes.rst?h=v6.18#n29

>>
>> Alternatively, we could just dd the .BTF_ids data computed by
>> resolve_btfids at the right offset in the target ELF file.
>>
>> Surprisingly I couldn't find a good way to read a section offset and
>> size from the ELF with a specified format in a command line. Both
>> readelf and {llvm-}objdump give a human readable output, and it
>> appears we can't rely on the column order, for example.
>>
>> We could still try parsing readelf output with awk/grep, covering
>> output variants that appear in the kernel build.
>>
>> We can also do:
>>
>>     llvm-readobj --elf-output-style=JSON --sections "$elf" | \
>>          jq -r --arg name .BTF_ids '
>>              .[0].Sections[] |
>>              select(.Section.Name.Name == $name) |
>>              "\(.Section.Offset) \(.Section.Size)"'
>>
>> ...but idk man, doesn't feel right.
>>
>> Most reliable way to determine the size and offset of .BTF_ids section
>> is probably reading them by a C program with libelf, such as
>> resolve_btfids. Which is quite ironic, given the recent
>> changes. Setting the irony aside, we could add smth like:
>>           resolve_btfids --section-info=.BTF_ids $elf
>>
>> Reverting the gen-btf.sh patch is also a possible workaround, but I'd
>> really like to avoid it, given that BPF features/optimizations in
>> development depend on it.
>>
>> I'd appreciate comments and suggestions on this issue. Thank you!
>> ---
>>   kernel/module/main.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>> index 710ee30b3bea..5bf456fad63e 100644
>> --- a/kernel/module/main.c
>> +++ b/kernel/module/main.c
>> @@ -1568,6 +1568,13 @@ static int simplify_symbols(struct module *mod, const struct load_info *info)
>>               break;
>>             default:
>> +            if (sym[i].st_shndx >= info->hdr->e_shnum) {
>> +                pr_err("%s: Symbol %s has an invalid section index %u (max %u)\n",
>> +                       mod->name, name, sym[i].st_shndx, info->hdr->e_shnum - 1);
>> +                ret = -ENOEXEC;
>> +                break;
>> +            }
>> +
>>               /* Divert to percpu allocation if a percpu var. */
>>               if (sym[i].st_shndx == info->index.pcpu)
>>                   secbase = (unsigned long)mod_percpu(mod);
> 
> I tried both llvm21 and llvm22 (where llvm21 is used in bpf ci).
> 
> Without KASAN, I can reproduce the failure for llvm19/llvm21/llvm22.
> I did not test llvm20 and I assume it may fail too.
> 
> The following llvm patch
>    https://github.com/llvm/llvm-project/pull/170462
> can fix the issue. Currently it is still in review stage. The actual diff is
> 
> diff --git a/llvm/lib/ObjCopy/ELF/ELFObject.cpp b/llvm/lib/ObjCopy/ELF/ELFObject.cpp
> index e5de17e093df..cc1527d996e2 100644
> --- a/llvm/lib/ObjCopy/ELF/ELFObject.cpp
> +++ b/llvm/lib/ObjCopy/ELF/ELFObject.cpp
> @@ -2168,7 +2168,11 @@ Error Object::updateSectionData(SecPtr &Sec, ArrayRef<uint8_t> Data) {
>                               Data.size(), Sec->Name.c_str(), Sec->Size);
>  
>    if (!Sec->ParentSegment) {
> -    Sec = std::make_unique<OwnedDataSection>(*Sec, Data);
> +    SectionBase *Replaced = Sec.get();
> +    SectionBase *Modified = &addSection<OwnedDataSection>(*Sec, Data);
> +    DenseMap<SectionBase *, SectionBase *> Replacements{{Replaced, Modified}};
> +    if (auto err = replaceSections(Replacements))
> +      return err;
>    } else {
>      // The segment writer will be in charge of updating these contents.
>      Sec->Size = Data.size();
> 
> I applied the above patch to latest llvm21 and llvm22 and
> the crash is gone and the selftests can run properly.

Hi Yonghong, thank you for confirming the issue.

Patching llvm-objcopy would be great, it should be done. But we are
still going to be stuck with making sure older LLVMs can build the kernel.
So even if they backport the fix to v21, it won't help us much, unfortunately.

> 
> With KASAN, everything is okay for llvm21 and llvm22.
> 
> Not sure whether the llvm patch
>    https://github.com/llvm/llvm-project/pull/170462
> can make into llvm21 or not as looks like llvm21 intends to
> freeze for now. See
>    https://github.com/llvm/llvm-project/pull/168314#issuecomment-3645797175
> the llvm22 will branch into rc mode in January.
> 
> I will try to see whether we can have a reasonable workaround
> for llvm21 llvm-objcopy (for without KASAN).
> 


