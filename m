Return-Path: <bpf+bounces-38772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 282DC969EB2
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 15:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8B251F21D77
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 13:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E691CA692;
	Tue,  3 Sep 2024 13:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PRU2AiZQ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E8D1CA6BE
	for <bpf@vger.kernel.org>; Tue,  3 Sep 2024 13:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725368914; cv=none; b=V/5s+GT3GGU+5V2a/CTRKeJO2Ck6MEL8GJbzPHvAgld/OL4QIeGCslbAc7C82cqbiICyF0npzOpXLutYfug4HLByn5/NFbFbKmWFia2yNLOua//dkkeeTFuyzJGCnfo7ky3+dd3KtXj9XxBn7EXUBPKKZJLLUvYYmG1oJs/eRjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725368914; c=relaxed/simple;
	bh=iW2LUj1+L7l/4+2Xx0qZCDZpaw5qQb9IbSBZAt6oZ1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oJua1QVDQclt5d27UNsJ1Qp8mQ3g3SrRCCfiOB+45su0UoD6LuFbVOmUjMn7uQpOl3W/K/D9sTyMbEnZty8qjNxnxnBpl4JeCvWgF9vnDhNHSbkyxKb9Ee/gy9egiFFPpxHj+DIfw51MvvzFL9kqNq3+pK3qkN1mPYqU8jR4+sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PRU2AiZQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725368911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lQ/LW7QLxkTvTCkZmtBerhspj1T046EuiZTpMj6cyOs=;
	b=PRU2AiZQTsEwvmYNrp754Rxzv+2XVOkof645x0EOLvKMWHNsH0kegj4v1Wdd2dXn1dgHOv
	DVFvHgOBd9J2M0RU/m52Om9dfjk/mQk2uZ+3WbTBiv9qNKvP9oz6GoZHDuKxU1p5WqXpLU
	277II7UL6pen3YlbehOT21tDfS2QtnI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-FGcmAST5NX2UmRa2nJ50Kw-1; Tue, 03 Sep 2024 09:08:30 -0400
X-MC-Unique: FGcmAST5NX2UmRa2nJ50Kw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5c23fffa44eso2609113a12.1
        for <bpf@vger.kernel.org>; Tue, 03 Sep 2024 06:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725368908; x=1725973708;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lQ/LW7QLxkTvTCkZmtBerhspj1T046EuiZTpMj6cyOs=;
        b=VhYaLoqyC4fIdWPtm5wsBQ28eNIfxmPJCO19kbrmRJMUqDaHg8XeVa0F/t0w8lVVxJ
         IZADUFMtmUTW4qnK1xIQJ1Zhwi3QyvIfprmr/4amGPkYAE2JCnPUbeagORMRucKCSE1x
         0rlH01i09+sw6v2NkaRW6PA9H1m0D2W1x2Wm+86w2NC8ZTcOrxUBkqX1Yj2d6PE57Vop
         zqly2llqFHPF09KvSzIpxyuL74rqw0c7Y+R66tiRHwfbccX7WHVQSCab7oRzo3jOtDbc
         aW1e3patEK0kgULfS6sXozP68oNx9+QhkCcz+CcSZiE/w0U50OhuneOc/Exj7dd5KjhJ
         ANuQ==
X-Gm-Message-State: AOJu0YwQ86DZd5m+J1WAuDuX5K68YzkXI2K1jRmMihKru5pbPWUVtPOC
	mg+0ABKBgeIFV88f/N5xuuAMe+A0ZT7jAM9pWNz6uLPdSwGSWkjG9WnApBbMdrgzbYv7cf6pNTM
	sl5/957sfm/i8/Kpn3Dt2aYSQCAIiQEXQfA/GxqtKvy7xkYtHj7yh1W+dGms=
X-Received: by 2002:a05:6402:2317:b0:5c2:439e:d6cb with SMTP id 4fb4d7f45d1cf-5c2439ed784mr5694361a12.12.1725368908293;
        Tue, 03 Sep 2024 06:08:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgd3Bk2Hh3QcgP0Uq9UP3O7Bv5qOKwbKVGzq9XVwiOJEDtiU+B/weSGlghY8Y7rAVETKTqdQ==
X-Received: by 2002:a05:6402:2317:b0:5c2:439e:d6cb with SMTP id 4fb4d7f45d1cf-5c2439ed784mr5694316a12.12.1725368907131;
        Tue, 03 Sep 2024 06:08:27 -0700 (PDT)
Received: from [192.168.0.113] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c245c467e7sm4161618a12.50.2024.09.03.06.08.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 06:08:26 -0700 (PDT)
Message-ID: <19327b3c-efe0-4242-a8bc-5ede33570cf9@redhat.com>
Date: Tue, 3 Sep 2024 15:08:25 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 1/3] libbpf: Support aliased symbols in linker
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
References: <cover.1725016029.git.vmalik@redhat.com>
 <87e9970b63dede4a19ec62ec572e224eecc26fa3.1725016029.git.vmalik@redhat.com>
 <ZtbwBA8CG8s--8dt@krava>
Content-Language: en-US
From: Viktor Malik <vmalik@redhat.com>
In-Reply-To: <ZtbwBA8CG8s--8dt@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/24 13:16, Jiri Olsa wrote:
> On Mon, Sep 02, 2024 at 08:58:01AM +0200, Viktor Malik wrote:
>> It is possible to create multiple BPF programs sharing the same
>> instructions using the compiler `__attribute__((alias("...")))`:
>>
>>     int BPF_PROG(prog)
>>     {
>>         [...]
>>     }
>>     int prog_alias() __attribute__((alias("prog")));
>>
>> This may be convenient when creating multiple programs with the same
>> instruction set attached to different events (such as bpftrace does).
>>
>> One problem in this situation is that Clang doesn't generate a BTF entry
>> for `prog_alias` which makes libbpf linker fail when processing such a
>> BPF object.
> 
> this might not solve all the issues, but could we change pahole to
> generate BTF FUNC for alias function symbols?

I don't think that would work here. First, we don't usually run pahole
when building BPF objects, it's Clang which generates BTF for the "bpf"
target directly. Second, AFAIK, pahole converts DWARF to BTF and
compilers don't generate DWARF entries for alias function symbols either.

Viktor

> 
> jirka
> 
>>
>> This commits adds support for that by finding another symbol at the same
>> address for which a BTF entry exists and using that entry in the linker.
>> This allows to use the linker (e.g. via `bpftool gen object ...`) on BPF
>> objects containing aliases.
>>
>> Note that this won't be sufficient for most programs as we also need to
>> add support for handling relocations in the aliased programs. This will
>> be added by the following commit.
>>
>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>> ---
>>  tools/lib/bpf/linker.c | 68 +++++++++++++++++++++++-------------------
>>  1 file changed, 38 insertions(+), 30 deletions(-)
>>
>> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
>> index 9cd3d4109788..5ebc9ff1246e 100644
>> --- a/tools/lib/bpf/linker.c
>> +++ b/tools/lib/bpf/linker.c
>> @@ -1688,6 +1688,34 @@ static bool btf_is_non_static(const struct btf_type *t)
>>  	       || (btf_is_func(t) && btf_func_linkage(t) != BTF_FUNC_STATIC);
>>  }
>>  
>> +static Elf64_Sym *find_sym_by_name(struct src_obj *obj, size_t sec_idx,
>> +				   int sym_type, const char *sym_name)
>> +{
>> +	struct src_sec *symtab = &obj->secs[obj->symtab_sec_idx];
>> +	Elf64_Sym *sym = symtab->data->d_buf;
>> +	int i, n = symtab->shdr->sh_size / symtab->shdr->sh_entsize;
>> +	int str_sec_idx = symtab->shdr->sh_link;
>> +	const char *name;
>> +
>> +	for (i = 0; i < n; i++, sym++) {
>> +		if (sym->st_shndx != sec_idx)
>> +			continue;
>> +		if (ELF64_ST_TYPE(sym->st_info) != sym_type)
>> +			continue;
>> +
>> +		name = elf_strptr(obj->elf, str_sec_idx, sym->st_name);
>> +		if (!name)
>> +			return NULL;
>> +
>> +		if (strcmp(sym_name, name) != 0)
>> +			continue;
>> +
>> +		return sym;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>>  static int find_glob_sym_btf(struct src_obj *obj, Elf64_Sym *sym, const char *sym_name,
>>  			     int *out_btf_sec_id, int *out_btf_id)
>>  {
>> @@ -1695,6 +1723,7 @@ static int find_glob_sym_btf(struct src_obj *obj, Elf64_Sym *sym, const char *sy
>>  	const struct btf_type *t;
>>  	const struct btf_var_secinfo *vi;
>>  	const char *name;
>> +	Elf64_Sym *s;
>>  
>>  	if (!obj->btf) {
>>  		pr_warn("failed to find BTF info for object '%s'\n", obj->filename);
>> @@ -1710,8 +1739,15 @@ static int find_glob_sym_btf(struct src_obj *obj, Elf64_Sym *sym, const char *sy
>>  		 */
>>  		if (btf_is_non_static(t)) {
>>  			name = btf__str_by_offset(obj->btf, t->name_off);
>> -			if (strcmp(name, sym_name) != 0)
>> -				continue;
>> +			if (strcmp(name, sym_name) != 0) {
>> +				/* the symbol that we look for may not have BTF as it may
>> +				 * be an alias of another symbol; we check if this is
>> +				 * the original symbol and if so, we use its BTF id
>> +				 */
>> +				s = find_sym_by_name(obj, sym->st_shndx, STT_FUNC, name);
>> +				if (!s || s->st_value != sym->st_value)
>> +					continue;
>> +			}
>>  
>>  			/* remember and still try to find DATASEC */
>>  			btf_id = i;
>> @@ -2132,34 +2168,6 @@ static int linker_append_elf_relos(struct bpf_linker *linker, struct src_obj *ob
>>  	return 0;
>>  }
>>  
>> -static Elf64_Sym *find_sym_by_name(struct src_obj *obj, size_t sec_idx,
>> -				   int sym_type, const char *sym_name)
>> -{
>> -	struct src_sec *symtab = &obj->secs[obj->symtab_sec_idx];
>> -	Elf64_Sym *sym = symtab->data->d_buf;
>> -	int i, n = symtab->shdr->sh_size / symtab->shdr->sh_entsize;
>> -	int str_sec_idx = symtab->shdr->sh_link;
>> -	const char *name;
>> -
>> -	for (i = 0; i < n; i++, sym++) {
>> -		if (sym->st_shndx != sec_idx)
>> -			continue;
>> -		if (ELF64_ST_TYPE(sym->st_info) != sym_type)
>> -			continue;
>> -
>> -		name = elf_strptr(obj->elf, str_sec_idx, sym->st_name);
>> -		if (!name)
>> -			return NULL;
>> -
>> -		if (strcmp(sym_name, name) != 0)
>> -			continue;
>> -
>> -		return sym;
>> -	}
>> -
>> -	return NULL;
>> -}
>> -
>>  static int linker_fixup_btf(struct src_obj *obj)
>>  {
>>  	const char *sec_name;
>> -- 
>> 2.46.0
>>
> 


