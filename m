Return-Path: <bpf+bounces-45707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7609DA758
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 13:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DC5F281418
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 12:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133471FA256;
	Wed, 27 Nov 2024 12:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ki6pGGeY"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508781FA179
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 12:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732709051; cv=none; b=cjfdBdWxX1xwf9PGktRjWGkN6kOOljFN9B/jbAZ66WogcQ+K8ShU3+aw5CGYiBacAk1doOI+QINDggrKvyDdr2ZGT/g4CRAmqcLmxlZx/MzxBd++16S8H4lpQ2WQxew1EVmuNQdWS7shPrJ+9OmZVJJ3zMUOVW0UhkJnngyrdyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732709051; c=relaxed/simple;
	bh=a55M5jYD6nlfdwoh5yvXg3C+1J5E09o6cCVEYDZ9enE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gxd5jPV0Qzj+VnXM3mALny5V+oy+yRD3pNtnYBwFfXVOpb1YMn3rT5jl1gldW2V8BbYiVYbCOtm4RarDAFA28JMtj/rbMxQZCjLQ81Y6omIKLeN8wWcMVY++g+mNXceTpO+AzwVHO0tm5NNNLGu8ttYld/8fXeysaMfV0qI7GfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ki6pGGeY; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6187706f-5c7f-4c22-9854-b3225b841385@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732709046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sIjGuwiYgUMxWRUDw+71/48WdEeHK2PJMmFg8dtJaIo=;
	b=Ki6pGGeY6GgSJGeMQYsrAL0EA+DTA+jV/yjzjaSNIz83NzR3kYHZXYhgObgP4gsUf/8SV3
	1BV+4ChBW2T5oa4jwBA5h6klKCpQAwpZle1BC+KsZUaWTWAiLJJS+nLbLgOcGOdwXpCTfh
	+EfqnoELsWpaIBv2jeqFkmJzY7W1qb4=
Date: Wed, 27 Nov 2024 12:03:59 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves v3 1/1] btf_encoder: handle .BTF_ids section
 endianness
To: Jiri Olsa <olsajiri@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>
Cc: dwarves@vger.kernel.org, arnaldo.melo@gmail.com, bpf@vger.kernel.org,
 kernel-team@fb.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 yonghong.song@linux.dev, Alan Maguire <alan.maguire@oracle.com>,
 Daniel Xu <dxu@dxuuu.xyz>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <20241127015006.2013050-1-eddyz87@gmail.com>
 <20241127015006.2013050-2-eddyz87@gmail.com> <Z0b7zLfaoodeWF6J@krava>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <Z0b7zLfaoodeWF6J@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 27/11/2024 11:00, Jiri Olsa wrote:
> On Tue, Nov 26, 2024 at 05:50:06PM -0800, Eduard Zingerman wrote:
>> btf_encoder__tag_kfuncs() reads .BTF_ids section to identify a set of
>> kfuncs present in the ELF file being processed.
>> This section consists of:
>> - arrays of uint32_t elements;
>> - arrays of records with the following structure:
>>    struct btf_id_and_flag {
>>        uint32_t id;
>>        uint32_t flags;
>>    };
>>
>> When endianness of a binary operated by pahole differs from the host
>> system's endianness, these fields require byte-swapping before use.
>> Currently, this byte-swapping does not occur, resulting in kfuncs not
>> being marked with declaration tags.
>>
>> This commit resolves the issue by using elf_getdata_rawchunk()
>> function to read .BTF_ids section data. When called with ELF_T_WORD as
>> 'type' parameter it does necessary byte order conversion
>> (only if host and elf endianness do not match).
>>
>> Cc: Alan Maguire <alan.maguire@oracle.com>
>> Cc: Andrii Nakryiko <andrii@kernel.org>
>> Cc: Daniel Xu <dxu@dxuuu.xyz>
>> Cc: Jiri Olsa <olsajiri@gmail.com>
>> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> Cc: Vadim Fedorenko <vadfed@meta.com>
>> Fixes: 72e88f29c6f7 ("pahole: Inject kfunc decl tags into BTF")
>> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
>> ---
>>   btf_encoder.c | 26 ++++++++++++++++++++------
>>   1 file changed, 20 insertions(+), 6 deletions(-)
>>
>> diff --git a/btf_encoder.c b/btf_encoder.c
>> index e1adddf..3754884 100644
>> --- a/btf_encoder.c
>> +++ b/btf_encoder.c
>> @@ -1904,18 +1904,32 @@ static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
>>   			goto out;
>>   		}
>>   
>> -		data = elf_getdata(scn, 0);
>> -		if (!data) {
>> -			elf_error("Failed to get ELF section(%d) data", i);
>> -			goto out;
>> -		}
>> -
>>   		if (shdr.sh_type == SHT_SYMTAB) {
>> +			data = elf_getdata(scn, 0);
>> +			if (!data) {
>> +				elf_error("Failed to get ELF section(%d) data", i);
>> +				goto out;
>> +			}
>> +
>>   			symbols_shndx = i;
>>   			symscn = scn;
>>   			symbols = data;
>>   			strtabidx = shdr.sh_link;
>>   		} else if (!strcmp(secname, BTF_IDS_SECTION)) {
>> +			/* .BTF_ids section consists of uint32_t elements,
>> +			 * and thus might need byte order conversion.
>> +			 * However, it has type PROGBITS, hence elf_getdata()
>> +			 * won't automatically do the conversion.
>> +			 * Use elf_getdata_rawchunk() instead,
>> +			 * ELF_T_WORD tells it to do the necessary conversion.
>> +			 */
>> +			data = elf_getdata_rawchunk(elf, shdr.sh_offset, shdr.sh_size, ELF_T_WORD);
> 
> looks good, I'm just curious about one thing..
> 
> so ELF_T_WORD enum has this comment: /* Elf32_Word, Elf64_Word, ... */
> 
> I did just quick check, ***so I might be easily wrong***, but I wonder the
> code in __elf_xfctstom (which I assume is the one called for conversion)
> chooses to swap 32/64 bits values based on elf->class .. so for 64bit ELF
> class we swap 64bit values? ... while .BTF_ids has always 32 bit values

Well according to the doc:

        ELF_T_WORD     Unsigned 32-bit words.
        ELF_T_XWORD    Unsigned 64-bit words.

It shouldn't use 64 bits swap:

const xfct_t __elf_xfctstom[EV_NUM - 1][EV_NUM - 1][ELFCLASSNUM - 
1][ELF_T_NUM] =
....
	[ELF_T_WORD]	= ElfW2(Bits, cvt_Word),			
	[ELF_T_XWORD]	= ElfW2(Bits, cvt_Xword),			
...

Are you looking somewhere else?

> 
> thanks,
> jirka
> 
>> +			if (!data) {
>> +				elf_error("Failed to get %s ELF section(%d) data",
>> +					  BTF_IDS_SECTION, i);
>> +				goto out;
>> +			}
>> +
>>   			idlist_shndx = i;
>>   			idlist_addr = shdr.sh_addr;
>>   			idlist = data;
>> -- 
>> 2.47.0
>>


