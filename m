Return-Path: <bpf+bounces-64162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FC9B0F112
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 13:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 507B67ABF23
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 11:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E508728137C;
	Wed, 23 Jul 2025 11:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WM4Pbaa3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5ED2AD3E;
	Wed, 23 Jul 2025 11:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753269730; cv=none; b=OI7/Jr/Lgk/r4sgdu5Ew6gfCb1Wb9rk0KyHVpll7Bzitjkqi0ir0YziY8PIGcdWmCa1WUs4YnIkPvUAwRGoTy92iofpARYQDHRRAelrL7rC2QfIkAFlJmK0YSDAcQwsD8ULZzL5NV8iMNNSgBMbhCBEjwdGBPhDhDr2bTZMVVDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753269730; c=relaxed/simple;
	bh=pxJ3pJd7nzPXoMJ6kq+2LBi2Mm/j1NrfF45b/CR9ArU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFmrW7SIqDs1UIs+V3vBCiHjj7Do/dYfVHXXcl1fIofnRmrwCGFTx2DkWoT7s8SdqmLA735bk5sRkfvigDc6MIaA8wgxbD0AnlU1EohuXWfKs9+72Ch+RDffOZMMU9Y8xTD/HQIrzYx/VTdeVYIOOTHa08Xc8jlgjlSEesmde/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WM4Pbaa3; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae0c4945c76so890790466b.3;
        Wed, 23 Jul 2025 04:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753269727; x=1753874527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WtqF6SYf/sU431PoBbxz3xgk14uzAc5hlJpUljy3fLY=;
        b=WM4Pbaa3PQ9Hcjhvs41YgtTMZFqy86UqygG/S8PVCCkBFEI+fvxbwyyzer07DFS8am
         xz7OSRcsubj57wpFte/jR+7foT74s13WNF3Gf2Bu7ZpwYTji6vImpCHwbVU5Ofl4FJDh
         WTL7n1l8pZjvBgBqQ9ptEWM9H7hJr47PxYLqk3wxXI6Ryr5gi1xaKWj7O2Q87tUHWj5p
         v5qfPgqWTuLZvAZAD3mG43CYetE9l58D9TtsdFndQYFwz9a03H5qmCO22Yg/iGga0nS/
         Y3zVWmWkYRKGlKhiNiyKCweIp+toxzNqAR/HxCF2JLiZMqMR5RCCe6pELNe3DPIr7cJd
         90hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753269727; x=1753874527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtqF6SYf/sU431PoBbxz3xgk14uzAc5hlJpUljy3fLY=;
        b=goFaiB/ypZhQiVCjnZQ9K3ZFigV1ck20k4rITOKlqSH39bAqWfKn+Y/eofoXzhme7S
         xjMGSPWzWYnF4E+/MJAk+PZbJ5IAH6JWWx55+hc8qf/LT9dYHO4IXyeHJNAwPckb8Y9Z
         8mKmjxbC+rQZYQ7XSJDEdxYE+8ZAshUt+mWfhmBvfQPhazTTq16DsixwOi/CcTJSGZTl
         sPeFVxdI44u8PblnjHbZLHAANXLYL6L0jDS//P3SYnZXHkF0qOrx6gKMNypGzyAQIKZV
         FwFG0Lp6KBrL29cqroRb60V5apkoVHEoW2hXkaRGzH+8Ywu+qTgZQriMg1nGHEWhFzHp
         ub4A==
X-Forwarded-Encrypted: i=1; AJvYcCV1mg2sx8fiU18q8GkJ4oxjf9FACeAKJYV49FmLtYQagH+2GLsXwp+ITH09n9WVU+ixaac=@vger.kernel.org, AJvYcCXEfHkgc6RkKoW5Xsd6alVVlEp80Pa4x/CZMQJTamz30YKtrcGmMPUUcbQe4V2CUTch3OARm+D/4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxkcEXWnjQNTFFDZ7Cs+qJEw6dCv6vJHNmUbKO3HLGSH2yq7Tv
	1tClTriJNeQSRsbjgA/C1mQqX//abE9W57d3GRzKZagThFAZtEDeRuJr
X-Gm-Gg: ASbGncsgOHpdZYcythaiebgD2hFTMwFqY9moM4d6WdFdy/FAr8BlzpNf5KOJ5OppyvI
	POZR99leSx82wQ2fZFilex9lGMgmwTiqjgsBUr25TY3QXKL27eRCcLJiq1cPEapcBxcR8Bn009G
	EpWYYue1SkY3XUJRa07Xus3+TYGenCDOXrElOOjufOES/flttCIUYlbC7pnnTWs1nx1qtPbuXxE
	WaNj+v23+qc6GDu4HEXFI74qmBKKPFNG7cWmb957ixNDKjdBQz3nc6apQusnp75bY6xnvaWUaGl
	vqoZYJ2RqCCUROfwjlb1hS9ACrCfqSi4aaK/IxO1G8pH8zzuXsvoULA3Bkq8RTFClbB9pL0P/E3
	KrpziTLQY
X-Google-Smtp-Source: AGHT+IH2hxV8D2GnQvgDqBUYoY4mbnfRLLmUtkCNUKWCdmmYIe1SpTqOYKlK2EbvWcfpzJmk+xWlfQ==
X-Received: by 2002:a17:907:3d0f:b0:ae3:696c:60a with SMTP id a640c23a62f3a-af2f66c5e04mr207505866b.8.1753269726359;
        Wed, 23 Jul 2025 04:22:06 -0700 (PDT)
Received: from krava ([173.38.220.33])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca2ffecsm1031723266b.82.2025.07.23.04.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 04:22:05 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 23 Jul 2025 13:22:03 +0200
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <olsajiri@gmail.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>, dwarves@vger.kernel.org,
	bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [RFC dwarves] btf_encoder: Remove duplicates from functions
 entries
Message-ID: <aIDFh26qdAURVL0u@krava>
References: <20250717152512.488022-1-jolsa@kernel.org>
 <e4fece83-8267-4929-b1aa-65a9e2882dd8@oracle.com>
 <aH5OW0rtSuMn1st1@krava>
 <6b4fda90fbf8f6aeeb2732bbfb6e81ba5669e2f3@linux.dev>
 <e88caa24-6bfa-457c-8e88-d00ed775ebd1@oracle.com>
 <98f41eaf6dd364745013650d58c5f254a592221c@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98f41eaf6dd364745013650d58c5f254a592221c@linux.dev>

On Tue, Jul 22, 2025 at 10:58:52PM +0000, Ihor Solodrai wrote:

SNIP

> @@ -1338,48 +1381,39 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
>  	return 0;
>  }
>  
> -static int functions_cmp(const void *_a, const void *_b)
> +static int elf_function__name_cmp(const void *_a, const void *_b)
>  {
>  	const struct elf_function *a = _a;
>  	const struct elf_function *b = _b;
>  
> -	/* if search key allows prefix match, verify target has matching
> -	 * prefix len and prefix matches.
> -	 */
> -	if (a->prefixlen && a->prefixlen == b->prefixlen)
> -		return strncmp(a->name, b->name, b->prefixlen);

nice to see this one removed ;-)

>  	return strcmp(a->name, b->name);
>  }
>  
> -#ifndef max
> -#define max(x, y) ((x) < (y) ? (y) : (x))
> -#endif
> -
>  static int saved_functions_cmp(const void *_a, const void *_b)
>  {
>  	const struct btf_encoder_func_state *a = _a;
>  	const struct btf_encoder_func_state *b = _b;
>  
> -	return functions_cmp(a->elf, b->elf);
> +	return elf_function__name_cmp(a->elf, b->elf);
>  }
>  
>  static int saved_functions_combine(struct btf_encoder_func_state *a, struct btf_encoder_func_state *b)
>  {
> -	uint8_t optimized, unexpected, inconsistent;
> -	int ret;
> +	uint8_t optimized, unexpected, inconsistent, ambiguous_addr;
> +
> +	if (a->elf != b->elf)
> +		return 1;
>  
> -	ret = strncmp(a->elf->name, b->elf->name,
> -		      max(a->elf->prefixlen, b->elf->prefixlen));
> -	if (ret != 0)
> -		return ret;
>  	optimized = a->optimized_parms | b->optimized_parms;
>  	unexpected = a->unexpected_reg | b->unexpected_reg;
>  	inconsistent = a->inconsistent_proto | b->inconsistent_proto;
> -	if (!unexpected && !inconsistent && !funcs__match(a, b))
> +	ambiguous_addr = a->ambiguous_addr | b->ambiguous_addr;
> +	if (!unexpected && !inconsistent && !ambiguous_addr && !funcs__match(a, b))
>  		inconsistent = 1;
>  	a->optimized_parms = b->optimized_parms = optimized;
>  	a->unexpected_reg = b->unexpected_reg = unexpected;
>  	a->inconsistent_proto = b->inconsistent_proto = inconsistent;
> +	a->ambiguous_addr = b->ambiguous_addr = ambiguous_addr;


I had to add change below to get the functions with multiple addresses out

diff --git a/btf_encoder.c b/btf_encoder.c
index fcc30aa9d97f..7b9679794790 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1466,7 +1466,7 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
 		 * just do not _use_ them.  Only exclude functions with
 		 * unexpected register use or multiple inconsistent prototypes.
 		 */
-		add_to_btf |= !state->unexpected_reg && !state->inconsistent_proto;
+		add_to_btf |= !state->unexpected_reg && !state->inconsistent_proto && !state->ambiguous_addr;
 
 		if (add_to_btf) {
 			err = btf_encoder__add_func(state->encoder, state);


other than that I like the approach

SNIP

> @@ -2153,18 +2191,75 @@ static int elf_functions__collect(struct elf_functions *functions)
>  		goto out_free;
>  	}
>  
> +	/* First, collect an elf_function for each GElf_Sym
> +	 * Where func->name is without a suffix
> +	 */
>  	functions->cnt = 0;
>  	elf_symtab__for_each_symbol_index(functions->symtab, core_id, sym, sym_sec_idx) {
> -		elf_functions__collect_function(functions, &sym);
> +
> +		if (elf_sym__type(&sym) != STT_FUNC)
> +			continue;
> +
> +		sym_name = elf_sym__name(&sym, functions->symtab);
> +		if (!sym_name)
> +			continue;
> +
> +		func = &functions->entries[functions->cnt];
> +
> +		const char *suffix = strchr(sym_name, '.');
> +		if (suffix) {
> +			functions->suffix_cnt++;

do we need suffix_cnt now?

thanks,
jirka


> +			func->name = strndup(sym_name, suffix - sym_name);
> +		} else {
> +			func->name = strdup(sym_name);
> +		}
> +		if (!func->name) {
> +			err = -ENOMEM;
> +			goto out_free;
> +		}
> +
> +		func_sym.name = sym_name;
> +		func_sym.addr = sym.st_value;
> +
> +		err = elf_function__push_sym(func, &func_sym);
> +		if (err)
> +			goto out_free;
> +
> +		functions->cnt++;
>  	}

SNIP

