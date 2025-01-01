Return-Path: <bpf+bounces-47737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE359FF4A6
	for <lists+bpf@lfdr.de>; Wed,  1 Jan 2025 17:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE6203A1A35
	for <lists+bpf@lfdr.de>; Wed,  1 Jan 2025 16:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63821E284B;
	Wed,  1 Jan 2025 16:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enVNLSQj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C001E25E4;
	Wed,  1 Jan 2025 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735750600; cv=none; b=QwCpFxVFvEQHdh+datsTwBlNERJbGGiYD+3lpSBjYuLw2clNHRDwumg6DnZ9vsuEaX0xm09KH75yIfQ4FT9xVoPRc1HRZQfXTEPrJlNo22BCYOLw1HMbsxIx3JHFF8C1qnYBqyPIZ1HWYemO6j173PcaGeHVm64H6v+7G+DyHkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735750600; c=relaxed/simple;
	bh=aELZyPJi0BfxaGsmT5p/362suEMdiC8angLtvKZN8oQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHtyfvj0qkAE2lj6rxBeFWJ4seljGryNtNMRr3dgaBCSEJLQVGSu9ejUE845eZtlQLZ+KpocpBCK2l8FZj2u9AwqTEryl8ZRot3DGCoWJSocSLG7loEidrdQSRTraSKUnvSW0qdpc4/fuaLEG89CT6ijngXU1R8urkfC6O22/eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enVNLSQj; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3e9f60bf4so18471635a12.3;
        Wed, 01 Jan 2025 08:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735750597; x=1736355397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yDyQxpwaTa1CU6hL48LF11VakYGEcJu7kScqwUzEewk=;
        b=enVNLSQjNi+ZgBMvUWRxcuGXSQQOfQSffbGRO+DZ59rkQdmrGFbz1nlF4QYJjdJuC/
         mTBIYFYs4hHqxt1uOFZS8j9p+/yXc5uVXws3rB0pCaGX2dfotOOCWEkj3tHmgDabFP1u
         gnmaw+FNzLolnzquFFgLr1EBZIkh9+bzb+tECzZMm7/NjzpjfiLIGMywyohcemmllYkJ
         mGWxBkF/O1DMSi1+ZX6nnM7HE8bHj2SnyAUpCpxkylTLkLuBfBGKUzMg6eOFNuJKbZk7
         p2QxuUBNZNKJOzyz3puA66e6TipzP2tHrEYqRUzChyB2HDY9MApU8AeUjr9DSQlkcd0h
         pSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735750597; x=1736355397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDyQxpwaTa1CU6hL48LF11VakYGEcJu7kScqwUzEewk=;
        b=w8wUIXL7vKko+f4E2jc+65kdDrBjQh7/xhXyLI2hIjlgv9myp7afG/eTceNsiRt1E0
         mZEAOHcK5wV5RQcQlLBxr3f8ctnHSgsNAmYcRyiYeCkGZR1Gd4e78awoIPJli2mQkSGO
         ltkIOAqXO+ivJT8YT89/FXg92muk+HAQUGcGb55MLiHI9vqNECdeHjsgHa/ceO/RTQLw
         y9gfjIphhrweQBw6StTqpO1ecD7CpcZKzmaKZkRtn2xXFPnyR7EgNVvXOpHz0XMdZdTV
         Ha03RGJ5v9KKTRyi5LdnbkjAEuB9Z4nYtKgON3yZJhqSsh8DKufw+lDVhUDOchnqOqYo
         5hiA==
X-Forwarded-Encrypted: i=1; AJvYcCX5RGN856ffLTtl+xRIl+odxrLCNF1871amx94/vc5+yESjVVEpEauROZSx4AgiNI0g19M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+ctsRPLUQ4xdxuCktvvIDMQwkfT3z7Juf/qrDM4IZeMPWTIsa
	jvRHqUPkWxgP92jg2TGksdyca/fIdTJGDcn1kiha2xYC+TqRnLUr
X-Gm-Gg: ASbGncvSnFQXzgXrxyoAc6FgdjrKLhnrib64XsLLS1RiiGpjPLTAZslxjChe+O1GOY6
	Q3ehukmYhtHgxRrSa6HouXnPN+vU3rlaG+ox3vWDvang6Mn2k9ao0QtRrcGy4LSyDDo759rnfee
	zBvMVXHjwUn+H/x4qBWbw6z3YyXlGhxmVeBLnGteOiyUCjdKMvCPI7l8oVkIwej7vJd8T5Jlkh4
	Z67t65PICTKEPU3Nvu9qsG586iEbm8y4ackC59kvSnVBtWDnmNs1S57By85j04=
X-Google-Smtp-Source: AGHT+IF6JZVHFV57AufkieL/1LDs7eilwzPv0engqVNrEweuGPm2s97MZ6DzDfo5SfeaNxkwcktohw==
X-Received: by 2002:a05:6402:5109:b0:5d3:e766:6140 with SMTP id 4fb4d7f45d1cf-5d81de22cb7mr37260840a12.24.1735750596641;
        Wed, 01 Jan 2025 08:56:36 -0800 (PST)
Received: from krava (85-193-35-38.rib.o2.cz. [85.193.35.38])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80701bf20sm17316005a12.83.2025.01.01.08.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2025 08:56:36 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 1 Jan 2025 17:56:34 +0100
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com,
	eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com,
	bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v3 3/8] btf_encoder: introduce elf_functions
 struct type
Message-ID: <Z3VzwnXfKIKMi5TX@krava>
References: <20241221012245.243845-1-ihor.solodrai@pm.me>
 <20241221012245.243845-4-ihor.solodrai@pm.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241221012245.243845-4-ihor.solodrai@pm.me>

On Sat, Dec 21, 2024 at 01:23:10AM +0000, Ihor Solodrai wrote:

SNIP

> -static int btf_encoder__collect_function(struct btf_encoder *encoder, GElf_Sym *sym)
> +static void elf_functions__collect_function(struct elf_functions *functions, GElf_Sym *sym)
>  {
> -	struct elf_function *new;
> +	struct elf_function *func;
>  	const char *name;
>  
>  	if (elf_sym__type(sym) != STT_FUNC)
> -		return 0;
> -	name = elf_sym__name(sym, encoder->symtab);
> -	if (!name)
> -		return 0;
> +		return;
>  
> -	if (encoder->functions.cnt == encoder->functions.allocated) {
> -		new = reallocarray_grow(encoder->functions.entries,
> -					&encoder->functions.allocated,
> -					sizeof(*encoder->functions.entries));
> -		if (!new) {
> -			/*
> -			 * The cleanup - delete_functions is called
> -			 * in btf_encoder__encode_cu error path.
> -			 */
> -			return -1;
> -		}
> -		encoder->functions.entries = new;
> -	}
> +	name = elf_sym__name(sym, functions->symtab);
> +	if (!name)
> +		return;
>  
> -	memset(&encoder->functions.entries[encoder->functions.cnt], 0,
> -	       sizeof(*new));
> -	encoder->functions.entries[encoder->functions.cnt].name = name;
> +	func = &functions->entries[functions->cnt];
> +	func->name = name;
>  	if (strchr(name, '.')) {
>  		const char *suffix = strchr(name, '.');
> -

nit, let's keep that new line after declaration

> -		encoder->functions.suffix_cnt++;
> -		encoder->functions.entries[encoder->functions.cnt].prefixlen = suffix - name;
> +		functions->suffix_cnt++;
> +		func->prefixlen = suffix - name;
>  	} else {
> -		encoder->functions.entries[encoder->functions.cnt].prefixlen = strlen(name);
> +		func->prefixlen = strlen(name);
>  	}
> -	encoder->functions.cnt++;
> -	return 0;
> +
> +	functions->cnt++;
>  }
>  
>  static struct elf_function *btf_encoder__find_function(const struct btf_encoder *encoder,
> @@ -2126,26 +2103,56 @@ int btf_encoder__encode(struct btf_encoder *encoder)
>  	return err;
>  }
>  
> -
> -static int btf_encoder__collect_symbols(struct btf_encoder *encoder)
> +static int elf_functions__collect(struct elf_functions *functions)
>  {
> -	uint32_t sym_sec_idx;
> +	uint32_t nr_symbols = elf_symtab__nr_symbols(functions->symtab);
> +	struct elf_function *tmp;
> +	Elf32_Word sym_sec_idx;
>  	uint32_t core_id;
>  	GElf_Sym sym;
> +	int err;
>  
> -	elf_symtab__for_each_symbol_index(encoder->symtab, core_id, sym, sym_sec_idx) {
> -		if (btf_encoder__collect_function(encoder, &sym))
> -			return -1;
> +	/* We know that number of functions is less than number of symbols,
> +	 * so we can overallocate temporarily.
> +	 */
> +	functions->entries = calloc(nr_symbols, sizeof(*functions->entries));
> +	if (!functions->entries) {
> +		err = -ENOMEM;
> +		goto out_free;

you could just return -ENOMEM here

> +	}
> +
> +	functions->cnt = 0;
> +	elf_symtab__for_each_symbol_index(functions->symtab, core_id, sym, sym_sec_idx) {
> +		elf_functions__collect_function(functions, &sym);
>  	}
>  
> -	if (encoder->functions.cnt) {
> -		qsort(encoder->functions.entries, encoder->functions.cnt, sizeof(encoder->functions.entries[0]),
> +	if (functions->cnt) {
> +		qsort(functions->entries,
> +		      functions->cnt,
> +		      sizeof(*functions->entries),
>  		      functions_cmp);

nit, why not keep the single line?

> -		if (encoder->verbose)
> -			printf("Found %d functions!\n", encoder->functions.cnt);
> +	} else {
> +		err = 0;
> +		goto out_free;
> +	}
> +
> +	/* Reallocate to the exact size */
> +	tmp = realloc(functions->entries, functions->cnt * sizeof(struct elf_function));
> +	if (tmp) {
> +		functions->entries = tmp;
> +	} else {
> +		fprintf(stderr, "could not reallocate memory for elf_functions table\n");
> +		err = -ENOMEM;
> +		goto out_free;
>  	}
>  
>  	return 0;
> +
> +out_free:
> +	free(functions->entries);
> +	functions->entries = NULL;
> +	functions->cnt = 0;
> +	return err;
>  }
>  
>  static bool ftype__has_arg_names(const struct ftype *ftype)
> @@ -2406,6 +2413,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>  				printf("%s: '%s' doesn't have symtab.\n", __func__, cu->filename);
>  			goto out;
>  		}
> +		encoder->functions.symtab = encoder->symtab;

I was wondering if we need to keep both symtab pointers, but it's sorted
out in the next patch ;-)
 
thanks,
jirka

>  
>  		/* index the ELF sections for later lookup */
>  
> @@ -2444,7 +2452,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>  		if (!found_percpu && encoder->verbose)
>  			printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->filename, PERCPU_SECTION);
>  
> -		if (btf_encoder__collect_symbols(encoder))
> +		if (elf_functions__collect(&encoder->functions))
>  			goto out_delete;
>  
>  		if (encoder->verbose)
> @@ -2476,7 +2484,7 @@ void btf_encoder__delete(struct btf_encoder *encoder)
>  	encoder->btf = NULL;
>  	elf_symtab__delete(encoder->symtab);
>  
> -	encoder->functions.allocated = encoder->functions.cnt = 0;
> +	encoder->functions.cnt = 0;
>  	free(encoder->functions.entries);
>  	encoder->functions.entries = NULL;
>  
> -- 
> 2.47.1
> 
> 
> 

