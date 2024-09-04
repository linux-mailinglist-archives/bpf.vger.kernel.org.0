Return-Path: <bpf+bounces-38858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5D796B09E
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 07:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C4841F259FB
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 05:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA992824A0;
	Wed,  4 Sep 2024 05:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+0anCWd"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515A27F9
	for <bpf@vger.kernel.org>; Wed,  4 Sep 2024 05:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725428785; cv=none; b=fJXjPRnj8IQEIdcbTQpxt1EVxupIqX30jq/yUqTGwTY8uEAmj72zliyDr8yq432OpWle/J2ibgK8iTKEeoryANgxedxcb4qPYO1HHq9ajgQi9HfxXxzuTDhHBMnnb0yWLegj4qQE0kY51WGrfz6OZkfUTd4xjz6HeK7+5XPLDRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725428785; c=relaxed/simple;
	bh=zofKrUT4R2W+7aiLfecspLkcCNuy4w3sZW3bm17cYAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KwHFcf5iVCkQ43SZz0ffaNkb0dzQTYQ44bxm978cbCMPPLOs0DGdlPXmWGb2IV4J1k4eqnKUDDcSDSEvkVPoRI1aPf1kkdsPRYktP4teZX7txzDg7z1ryqN7X9+t1QmzS5IfAUdnoHvDEUTq/ausresQmpgKg9wmTfkjAaWM6wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A+0anCWd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725428782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ktRZUfe2C3zQhR/LY9Um6ilQOjXBs4CP6i/zkuHcWhE=;
	b=A+0anCWdvnBOFpEk+E779mOs6tzgphqTccYGq2Dv7zEgbXYwSN9fRPVivRuMhJM+ZQBuQD
	XmdQe+QmssDInVhIQ3WFHJs7PDbhg7AyquB0ILavEQogwQWf1jVKMXfx+AffkSyr66I8Ts
	v2xYot4k+49A+fWKNW8gArAbEGCLnL4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-pS7j82bFNSSfa-004TMCUg-1; Wed, 04 Sep 2024 01:46:19 -0400
X-MC-Unique: pS7j82bFNSSfa-004TMCUg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5c24b4a57b4so2468287a12.2
        for <bpf@vger.kernel.org>; Tue, 03 Sep 2024 22:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725428778; x=1726033578;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ktRZUfe2C3zQhR/LY9Um6ilQOjXBs4CP6i/zkuHcWhE=;
        b=U6uIVrfcCmv7BvPN9I7ANXTzZ4vDP2WdQPmZHJKSDKW5gEVtjYCBiJF3FVCGaftFAx
         jhGX9qxnoGXBU6R1MoJHp8xpuDu+GRRQcqn2kVSV161ec1H0m2an1bzqFwDRUPpCXrwr
         zUZh5c/vXlYpMfyd8OvFYoC6/csXY17cIGndAlHlCtpYaxKB7r2DF3RFVXUA1kGbCSUS
         fDU+LyD1iUkDTUVvKfvrCut5G9dh046a3Ay4iIqmeuJn1kV3dlv48NZ2k9OlupDPBgCb
         sEhOb5kEHEogX0AfQKNDnkD6/aE0IXujO+UMe6Z+3VadDH2S9GrHAfJQAwxIiy6FbpId
         DRaw==
X-Forwarded-Encrypted: i=1; AJvYcCXj6n9kevP/Glz70m3BFA1kKx5BkQdDLFojfz3SkKzj1+bIsEsZV0b4mQl7ADhP7RvPTaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqWPiZ691plJBmLadYatPQBxikxp8ZGqTJNCgLEveS5QtJD30m
	oU1QxBTvvXe3xQd/RydZltHYaYf3qWHU2LuhXHglmIECOgReRSc9KPHoRDc4Ag2z1yDWNEHD2AN
	paPxDcf1MzyeBLyncKm9hKDjsaC9qIMXWSzvu6SeqCIOAxrsu
X-Received: by 2002:a05:6402:3509:b0:5c3:c388:2e36 with SMTP id 4fb4d7f45d1cf-5c3c388304fmr297650a12.3.1725428778434;
        Tue, 03 Sep 2024 22:46:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkssd+WT+Cvf+iouYe5R4rPauNsKFAEVq7xlbPc3MQGFk/5vj2eu5tDga+tXlGPyAovVXBNg==
X-Received: by 2002:a05:6402:3509:b0:5c3:c388:2e36 with SMTP id 4fb4d7f45d1cf-5c3c388304fmr297606a12.3.1725428777100;
        Tue, 03 Sep 2024 22:46:17 -0700 (PDT)
Received: from [192.168.0.113] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226ccf2a0sm7137187a12.64.2024.09.03.22.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 22:46:16 -0700 (PDT)
Message-ID: <bb3fefa6-24ac-425b-983b-7c5ca70a7bb8@redhat.com>
Date: Wed, 4 Sep 2024 07:46:15 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 1/3] libbpf: Support aliased symbols in linker
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>
References: <cover.1725016029.git.vmalik@redhat.com>
 <87e9970b63dede4a19ec62ec572e224eecc26fa3.1725016029.git.vmalik@redhat.com>
 <ZtbwBA8CG8s--8dt@krava> <19327b3c-efe0-4242-a8bc-5ede33570cf9@redhat.com>
 <ZtcYdx8vZAbl_OVf@x1>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <ZtcYdx8vZAbl_OVf@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/24 16:08, Arnaldo Carvalho de Melo wrote:
> On Tue, Sep 03, 2024 at 03:08:25PM +0200, Viktor Malik wrote:
>> On 9/3/24 13:16, Jiri Olsa wrote:
>>> On Mon, Sep 02, 2024 at 08:58:01AM +0200, Viktor Malik wrote:
>>>> It is possible to create multiple BPF programs sharing the same
>>>> instructions using the compiler `__attribute__((alias("...")))`:
>>>>
>>>>     int BPF_PROG(prog)
>>>>     {
>>>>         [...]
>>>>     }
>>>>     int prog_alias() __attribute__((alias("prog")));
>>>>
>>>> This may be convenient when creating multiple programs with the same
>>>> instruction set attached to different events (such as bpftrace does).
>>>>
>>>> One problem in this situation is that Clang doesn't generate a BTF entry
>>>> for `prog_alias` which makes libbpf linker fail when processing such a
>>>> BPF object.
>>>
>>> this might not solve all the issues, but could we change pahole to
>>> generate BTF FUNC for alias function symbols?
>>
>> I don't think that would work here. First, we don't usually run pahole
>> when building BPF objects, it's Clang which generates BTF for the "bpf"
>> target directly. Second, AFAIK, pahole converts DWARF to BTF and
>> compilers don't generate DWARF entries for alias function symbols either.
> 
> So, pahole adds BTF info that doesn't come from DWARF, and it could read
> the BTF generated by clang for the bpf target and ammend/augment/add to
> it if that would allow us to have something we need and that isn't
> currently (or planned) to be supported by clang.
> 
> I.e. we have a BTF loader, we could pair it with the BPF encoder, in
> addition to the usual DWARF Loader + BPF encoder as what the loaders do
> is to generate internal representation that is then consumed by the
> pretty printer or the BTF encoder.
> 
> In this case the BTF encoder would use what is the internal
> representation, that it doesn't even know came from a BPF object
> generated by clang's BPF target, and would add this extra aliases, if we
> can get it from somewhere else.

Yes, that would be an option. We should be able to get the info about
aliases from the symbol table.

The problem here is that it would require an extra step of running
pahole when compiling BPF objects. Which should be ok for bpftrace,
though, as we control how we create BPF objects and can easily add the
extra step.

Viktor

> 
> - Arnaldo
>  
>> Viktor
>>
>>>
>>> jirka
>>>
>>>>
>>>> This commits adds support for that by finding another symbol at the same
>>>> address for which a BTF entry exists and using that entry in the linker.
>>>> This allows to use the linker (e.g. via `bpftool gen object ...`) on BPF
>>>> objects containing aliases.
>>>>
>>>> Note that this won't be sufficient for most programs as we also need to
>>>> add support for handling relocations in the aliased programs. This will
>>>> be added by the following commit.
>>>>
>>>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>>>> ---
>>>>  tools/lib/bpf/linker.c | 68 +++++++++++++++++++++++-------------------
>>>>  1 file changed, 38 insertions(+), 30 deletions(-)
>>>>
>>>> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
>>>> index 9cd3d4109788..5ebc9ff1246e 100644
>>>> --- a/tools/lib/bpf/linker.c
>>>> +++ b/tools/lib/bpf/linker.c
>>>> @@ -1688,6 +1688,34 @@ static bool btf_is_non_static(const struct btf_type *t)
>>>>  	       || (btf_is_func(t) && btf_func_linkage(t) != BTF_FUNC_STATIC);
>>>>  }
>>>>  
>>>> +static Elf64_Sym *find_sym_by_name(struct src_obj *obj, size_t sec_idx,
>>>> +				   int sym_type, const char *sym_name)
>>>> +{
>>>> +	struct src_sec *symtab = &obj->secs[obj->symtab_sec_idx];
>>>> +	Elf64_Sym *sym = symtab->data->d_buf;
>>>> +	int i, n = symtab->shdr->sh_size / symtab->shdr->sh_entsize;
>>>> +	int str_sec_idx = symtab->shdr->sh_link;
>>>> +	const char *name;
>>>> +
>>>> +	for (i = 0; i < n; i++, sym++) {
>>>> +		if (sym->st_shndx != sec_idx)
>>>> +			continue;
>>>> +		if (ELF64_ST_TYPE(sym->st_info) != sym_type)
>>>> +			continue;
>>>> +
>>>> +		name = elf_strptr(obj->elf, str_sec_idx, sym->st_name);
>>>> +		if (!name)
>>>> +			return NULL;
>>>> +
>>>> +		if (strcmp(sym_name, name) != 0)
>>>> +			continue;
>>>> +
>>>> +		return sym;
>>>> +	}
>>>> +
>>>> +	return NULL;
>>>> +}
>>>> +
>>>>  static int find_glob_sym_btf(struct src_obj *obj, Elf64_Sym *sym, const char *sym_name,
>>>>  			     int *out_btf_sec_id, int *out_btf_id)
>>>>  {
>>>> @@ -1695,6 +1723,7 @@ static int find_glob_sym_btf(struct src_obj *obj, Elf64_Sym *sym, const char *sy
>>>>  	const struct btf_type *t;
>>>>  	const struct btf_var_secinfo *vi;
>>>>  	const char *name;
>>>> +	Elf64_Sym *s;
>>>>  
>>>>  	if (!obj->btf) {
>>>>  		pr_warn("failed to find BTF info for object '%s'\n", obj->filename);
>>>> @@ -1710,8 +1739,15 @@ static int find_glob_sym_btf(struct src_obj *obj, Elf64_Sym *sym, const char *sy
>>>>  		 */
>>>>  		if (btf_is_non_static(t)) {
>>>>  			name = btf__str_by_offset(obj->btf, t->name_off);
>>>> -			if (strcmp(name, sym_name) != 0)
>>>> -				continue;
>>>> +			if (strcmp(name, sym_name) != 0) {
>>>> +				/* the symbol that we look for may not have BTF as it may
>>>> +				 * be an alias of another symbol; we check if this is
>>>> +				 * the original symbol and if so, we use its BTF id
>>>> +				 */
>>>> +				s = find_sym_by_name(obj, sym->st_shndx, STT_FUNC, name);
>>>> +				if (!s || s->st_value != sym->st_value)
>>>> +					continue;
>>>> +			}
>>>>  
>>>>  			/* remember and still try to find DATASEC */
>>>>  			btf_id = i;
>>>> @@ -2132,34 +2168,6 @@ static int linker_append_elf_relos(struct bpf_linker *linker, struct src_obj *ob
>>>>  	return 0;
>>>>  }
>>>>  
>>>> -static Elf64_Sym *find_sym_by_name(struct src_obj *obj, size_t sec_idx,
>>>> -				   int sym_type, const char *sym_name)
>>>> -{
>>>> -	struct src_sec *symtab = &obj->secs[obj->symtab_sec_idx];
>>>> -	Elf64_Sym *sym = symtab->data->d_buf;
>>>> -	int i, n = symtab->shdr->sh_size / symtab->shdr->sh_entsize;
>>>> -	int str_sec_idx = symtab->shdr->sh_link;
>>>> -	const char *name;
>>>> -
>>>> -	for (i = 0; i < n; i++, sym++) {
>>>> -		if (sym->st_shndx != sec_idx)
>>>> -			continue;
>>>> -		if (ELF64_ST_TYPE(sym->st_info) != sym_type)
>>>> -			continue;
>>>> -
>>>> -		name = elf_strptr(obj->elf, str_sec_idx, sym->st_name);
>>>> -		if (!name)
>>>> -			return NULL;
>>>> -
>>>> -		if (strcmp(sym_name, name) != 0)
>>>> -			continue;
>>>> -
>>>> -		return sym;
>>>> -	}
>>>> -
>>>> -	return NULL;
>>>> -}
>>>> -
>>>>  static int linker_fixup_btf(struct src_obj *obj)
>>>>  {
>>>>  	const char *sec_name;
>>>> -- 
>>>> 2.46.0
>>>>
>>>
> 


