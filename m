Return-Path: <bpf+bounces-21036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC12A846D32
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 11:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3076AB2D5E8
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 10:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2657177F3E;
	Fri,  2 Feb 2024 10:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nmq+yQKg"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC79F60BBD
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 10:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706868009; cv=none; b=c/WwptG7I/R9j5JmsqCdAZlVPJkdEvjdT4cOLHwVZAglv6HnzBUgB3NDYbOHzQCkhEV/BzwwzXS1QNJEbZtLfhOWw9u6rFJwhUnah4PejYgZ4bScz7Wvm/MwKZAQMCZegiPvPfqjlrpTeHHHWU9Ije+gPSwHivV/oTnem4aY/Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706868009; c=relaxed/simple;
	bh=b7X+G7W08e4Qe0pfnxiD3W1bfrtrJWHYHZzwZT2qGOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y2FB9jvkNmTRY8X8cr4AWHNaWHgc80xCSEcLNhmoCPE3fDyLrVgFi3nbDhnQZAYd9gdWl5juQmRknWEZQsw1JqpxWVgjsRx/4H9qBD7zopR/MqiOy9qTYmmLVzopbVVZy5mayzuEVQzk93u9ZDE5T9OUILrD9wJq7OPNqmG1VK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nmq+yQKg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706867998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6fKw7nt6H502DDjjzIIGwifNst1RfeOcGHiqbg8k39U=;
	b=Nmq+yQKgdeMqg5scKs7MeUnKfKcaM1rK14bng92fey06f+R0YqUFBGC/iRWFgAbOkOnAyr
	UXAbkL1hT1cpuKNPeF9NITU381tP0zriqIFPk58pTP43YbFFMyfag5m/qAGB6BlW9EboC/
	4wEgQpuBBG8bWkLr+iymsPLLaCdI1pw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-pu6gdxkrOTO8cmx8F90YDA-1; Fri, 02 Feb 2024 04:59:57 -0500
X-MC-Unique: pu6gdxkrOTO8cmx8F90YDA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a3120029877so319301766b.1
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 01:59:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706867995; x=1707472795;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6fKw7nt6H502DDjjzIIGwifNst1RfeOcGHiqbg8k39U=;
        b=YaEFH1PFek65Rg+8B5WTbju9REhx3itZY6OYPplKK7X40I/Al5ZEdDo1DLXNZ6An6x
         bn5Wmok5i+MeL0RSdcV40JK+VtDC99vw3tWU7QSNsu72UT0VP4XRnschDgxQd6xwY+sp
         1h58BgG2ulKssXXPYNzar5x9iUo5JaRT5klJDb49nwp+DMJyA1SRDiMKKjrYTOwSHJai
         K+TeeOw7jBuUuULAYDNbWxF+4SD7AF190o8wSjeuU/xRryoCXqRGEQpKJt++zK7k9Krr
         +CdNyH9Yy+/TqBHXDyK+/8LpzOoDWPqiIadRfBL2LjJVQ9ccRJ2qLmGu1KrsSF2fu/aT
         MobA==
X-Gm-Message-State: AOJu0Yy9zRlWuZaeUDwAwpA4JtylWzCKKqy8I/tgGrG2ZFu3qiMo3e/f
	RklehksTyZY85x9TgkBLNkGv/xYwpy1AU8PRQMTvZYym8IWLPDAZGQVBIgyobHYhDVjiAIVViLH
	ffcaAS7epA9SfhkFaeoVoPPkR2ZHZNXOKCoV/GvG9Pmxuc3aBmrS8oqVYRbnwmw==
X-Received: by 2002:a17:906:6d8:b0:a36:a8bb:28fd with SMTP id v24-20020a17090606d800b00a36a8bb28fdmr1405747ejb.1.1706867995704;
        Fri, 02 Feb 2024 01:59:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLFE2l+X9+oh8ubAlmnT6a3ENGZgOi0Z6NW2zJX6qx8QCG/6JdqPzA0MgGGHyBLXbLiZMgew==
X-Received: by 2002:a17:906:6d8:b0:a36:a8bb:28fd with SMTP id v24-20020a17090606d800b00a36a8bb28fdmr1405715ejb.1.1706867995326;
        Fri, 02 Feb 2024 01:59:55 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV7r3NSuhQ8I3rG/Bm0VhimJWQWooTVW72fMeuIzcFo2T6dUZoQ5AH8SK+x76fT9I0rG9s4lHWU7XThGr72k8K0t+nZxsak8bB35ZEO9G314heHrlnPcmcfGVm1HKVsSWypTOce9PZZ66Z7ZFJIHP2l3wRJc/V78p4ULJ7xNg1/OJLNFf+P6ybjiWqF4FvJEVaGI5rKlUDBnZOh/PGR2ak7GOhhAS8Ee43OdywGFuP2JP0h0uOkVZfMQR0oFjBbCMLDlMJdBNLXZmkY7CRtc58faOzNrm3kS+rbxprIss+89YzteMMI5UzNT54z/kB5i9yCJ6t2HNvCtIZgcU+u2+IgFcy4eeKbp1WbdWIGxlg1su2XyjgNu3vNnAencVfVYWt8ttMoWf6rIQQ9/1UYRd/VP7c+G9+byq7havSv3ugdwZTMxzSwD6njeMwzYlkO
Received: from ?IPV6:2a02:ab04:333f:7c00:568:cf09:e97e:e96? (2a02-ab04-333f-7c00-0568-cf09-e97e-0e96.dynamic.v6.chello.sk. [2a02:ab04:333f:7c00:568:cf09:e97e:e96])
        by smtp.gmail.com with ESMTPSA id fe9-20020a056402390900b0055d312732dbsm658743edb.5.2024.02.02.01.59.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 01:59:54 -0800 (PST)
Message-ID: <694fc7f5-fdd9-48f2-abce-4a346488ace8@redhat.com>
Date: Fri, 2 Feb 2024 10:59:53 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/2] tools/resolve_btfids: fix
 cross-compilation to non-host endianness
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <cover.1706717857.git.vmalik@redhat.com>
 <64f6372c75a44d5c8d00db5c5b7ca21aa3b8bd77.1706717857.git.vmalik@redhat.com>
 <a9b408bf-4b4b-b0ce-1f2f-193c0fcfd3ff@iogearbox.net>
From: Viktor Malik <vmalik@redhat.com>
In-Reply-To: <a9b408bf-4b4b-b0ce-1f2f-193c0fcfd3ff@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/1/24 17:36, Daniel Borkmann wrote:
> On 1/31/24 5:24 PM, Viktor Malik wrote:
>> The .BTF_ids section is pre-filled with zeroed BTF ID entries during the
>> build and afterwards patched by resolve_btfids with correct values.
>> Since resolve_btfids always writes in host-native endianness, it relies
>> on libelf to do the translation when the target ELF is cross-compiled to
>> a different endianness (this was introduced in commit 61e8aeda9398
>> ("bpf: Fix libelf endian handling in resolv_btfids")).
>>
>> Unfortunately, the translation will corrupt the flags fields of SET8
>> entries because these were written during vmlinux compilation and are in
>> the correct endianness already. This will lead to numerous selftests
>> failures such as:
>>
>>      $ sudo ./test_verifier 502 502
>>      #502/p sleepable fentry accept FAIL
>>      Failed to load prog 'Invalid argument'!
>>      bpf_fentry_test1 is not sleepable
>>      verification time 34 usec
>>      stack depth 0
>>      processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
>>      Summary: 0 PASSED, 0 SKIPPED, 1 FAILED
>>
>> Since it's not possible to instruct libelf to translate just certain
>> values, let's manually bswap the flags in resolve_btfids when needed, so
>> that libelf then translates everything correctly.
>>
>> Fixes: ef2c6f370a63 ("tools/resolve_btfids: Add support for 8-byte BTF sets")
>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>> ---
>>   tools/bpf/resolve_btfids/main.c | 27 ++++++++++++++++++++++++++-
>>   1 file changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
>> index 7badf1557e5c..d01603ef6283 100644
>> --- a/tools/bpf/resolve_btfids/main.c
>> +++ b/tools/bpf/resolve_btfids/main.c
>> @@ -652,13 +652,23 @@ static int sets_patch(struct object *obj)
>>   	Elf_Data *data = obj->efile.idlist;
>>   	int *ptr = data->d_buf;
>>   	struct rb_node *next;
>> +	GElf_Ehdr ehdr;
>> +	int need_bswap;
>> +
>> +	if (gelf_getehdr(obj->efile.elf, &ehdr) == NULL) {
>> +		pr_err("FAILED cannot get ELF header: %s\n",
>> +			elf_errmsg(-1));
>> +		return -1;
>> +	}
>> +	need_bswap = (__BYTE_ORDER == __LITTLE_ENDIAN) !=
>> +		     (ehdr.e_ident[EI_DATA] == ELFDATA2LSB);
>>   
>>   	next = rb_first(&obj->sets);
>>   	while (next) {
>>   		unsigned long addr, idx;
>>   		struct btf_id *id;
>>   		void *base;
>> -		int cnt, size;
>> +		int cnt, size, i;
>>   
>>   		id   = rb_entry(next, struct btf_id, rb_node);
>>   		addr = id->addr[0];
>> @@ -686,6 +696,21 @@ static int sets_patch(struct object *obj)
>>   			base = set8->pairs;
>>   			cnt = set8->cnt;
>>   			size = sizeof(set8->pairs[0]);
>> +
>> +			/*
>> +			 * When ELF endianness does not match endianness of the
>> +			 * host, libelf will do the translation when updating
>> +			 * the ELF. This, however, corrupts SET8 flags which are
>> +			 * already in the target endianness. So, let's bswap
>> +			 * them to the host endianness and libelf will then
>> +			 * correctly translate everything.
>> +			 */
>> +			if (need_bswap) {
>> +				for (i = 0; i < cnt; i++) {
>> +					set8->pairs[i].flags =
>> +						bswap_32(set8->pairs[i].flags);
>> +				}
>> +			}
>>   		}
>>   
> 
> Could we improve that somewhat, e.g. gathering endianness could be moved into
> elf_collect() and the test could also be simplified (if I'm not missing sth) ?
> 
> Like the below (not even compile-tested ...) :

Thanks for the suggestion, that looks nicer than my version. I'll use
the below, it should work pretty much out of the box.

Viktor

> 
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> index 7badf1557e5c..7b5f592fe79c 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -90,6 +90,14 @@
> 
>   #define ADDR_CNT	100
> 
> +#if __BYTE_ORDER == __LITTLE_ENDIAN
> +# define ELFDATANATIVE	ELFDATA2LSB
> +#elif __BYTE_ORDER == __BIG_ENDIAN
> +# define ELFDATANATIVE	ELFDATA2MSB
> +#else
> +# error "Unknown machine endianness!"
> +#endif
> +
>   struct btf_id {
>   	struct rb_node	 rb_node;
>   	char		*name;
> @@ -117,6 +125,7 @@ struct object {
>   		int		 idlist_shndx;
>   		size_t		 strtabidx;
>   		unsigned long	 idlist_addr;
> +		int		 encoding;
>   	} efile;
> 
>   	struct rb_root	sets;
> @@ -320,6 +329,7 @@ static int elf_collect(struct object *obj)
>   {
>   	Elf_Scn *scn = NULL;
>   	size_t shdrstrndx;
> +	GElf_Ehdr ehdr;
>   	int idx = 0;
>   	Elf *elf;
>   	int fd;
> @@ -351,6 +361,13 @@ static int elf_collect(struct object *obj)
>   		return -1;
>   	}
> 
> +	if (gelf_getehdr(obj->efile.elf, &ehdr) == NULL) {
> +		pr_err("FAILED cannot get ELF header: %s\n", elf_errmsg(-1));
> +		return -1;
> +	}
> +
> +	obj->efile.encoding = ehdr.e_ident[EI_DATA];
> +
>   	/*
>   	 * Scan all the elf sections and look for save data
>   	 * from .BTF_ids section and symbols.
> @@ -649,6 +666,7 @@ static int cmp_id(const void *pa, const void *pb)
> 
>   static int sets_patch(struct object *obj)
>   {
> +	bool need_bswap = obj->efile.encoding != ELFDATANATIVE;
>   	Elf_Data *data = obj->efile.idlist;
>   	int *ptr = data->d_buf;
>   	struct rb_node *next;
> @@ -658,7 +676,7 @@ static int sets_patch(struct object *obj)
>   		unsigned long addr, idx;
>   		struct btf_id *id;
>   		void *base;
> -		int cnt, size;
> +		int cnt, size, i;
> 
>   		id   = rb_entry(next, struct btf_id, rb_node);
>   		addr = id->addr[0];
> @@ -686,6 +704,21 @@ static int sets_patch(struct object *obj)
>   			base = set8->pairs;
>   			cnt = set8->cnt;
>   			size = sizeof(set8->pairs[0]);
> +
> +			/*
> +			 * When ELF endianness does not match endianness of the
> +			 * host, libelf will do the translation when updating
> +			 * the ELF. This, however, corrupts SET8 flags which are
> +			 * already in the target endianness. So, let's bswap
> +			 * them to the host endianness and libelf will then
> +			 * correctly translate everything.
> +			 */
> +			if (need_bswap) {
> +				for (i = 0; i < cnt; i++) {
> +					set8->pairs[i].flags =
> +						bswap_32(set8->pairs[i].flags);
> +				}
> +			}
>   		}
> 
>   		pr_debug("sorting  addr %5lu: cnt %6d [%s]\n",


