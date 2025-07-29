Return-Path: <bpf+bounces-64626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E02BB14E0B
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 15:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C12C3AA6A6
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 13:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7D6145B3E;
	Tue, 29 Jul 2025 13:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjhV/PyY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E76D1758B;
	Tue, 29 Jul 2025 13:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753794281; cv=none; b=mIwgH9WHYprngDe9ccbrUS2prsycV31MZKDnEeL7Hj56hX5YMCLB6R80Yy1pfCZtaKN4/8lrOBJuLbTTvvxbZMOdbyRn+GHkTdK4N8Oqkjw6MIHr+7THChQ9P8zhCWLl9mu1udsOIm7wEFqpUWuArzjA/VfLfor36rBpnwuF0QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753794281; c=relaxed/simple;
	bh=q9XcOaXmn9wB9mHkwgwnoVjDE+ud+VPbABLrXLB26og=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpspPuaeHHwLM1FvvOSYsx6U/X+schBMH+lFtnOgp40cC3q4TlmoePuCtQwkzY3vciI1WbiMME1RRblHCpkrax4g1J5jioTUAjsRfqjVu1AeHZ/GUkTo17xtiibodREbu15FiW/yudGUsoQLM3QLYCwwrRRkTuv/cP+wrs077mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjhV/PyY; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-451d3f72391so51465385e9.3;
        Tue, 29 Jul 2025 06:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753794277; x=1754399077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ix14CESA9kHg0m61f4E3nGpbISmReGVmm6+MjRVF5hM=;
        b=PjhV/PyYJv6b9F1v64aWxLyumI9j9lxYlkqbp9ne3nO34zrMVNKqSfgxHQgl2diqlz
         eq/WR5xy5KHg7ZpT5dqSV6Q1ayakkb7hwfOmvmufQz6ASQm3Lr4qkGogqijGH2dSzbY6
         vGbJyLFteCT2k2TF310y9RhAdMdmuznEf//lXu10HDFT5Mgcy1hU2hrgWnDGLs0MLCNa
         DvOFY5Crn8F4hY+nTniOs5rz4VFTa6r0RR1z7/rjeFNmVOSJ7/KbJiuBCipvUjIJ1viF
         7ygAKPX1ZSNku+u19QxV7rNev4/Kz/lWrH/ARO+8BbswRAM5naLr0gkjJ09HFr5LiO/d
         qK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753794277; x=1754399077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ix14CESA9kHg0m61f4E3nGpbISmReGVmm6+MjRVF5hM=;
        b=SN8gQPySlX1MrUk958haufSij5O3CFQ3nfAU4rnh0p3qajhMQWbXrwX7CIuTgHEyow
         2JuwDMvpOA0pFMj+U63cJpEfIiPao1RiOxHr9J01BQCkRtBcTr4aY43f8bNskpdhIk60
         WDgtoTJDmUjZpp0tBb+RkUzDRqHPdhyAj9pS/k30jFdFldpshcypZxTxtSEl8a8T5E8U
         jR73Y0uEr0YeOB4ehExLxQ833SVDqFM/pfuh/WcrqHu/qdN5vWiqpzZtZmmH5iT3aNXk
         BsoEGHALtVI3a09i55b2k2rX8KiOsccNJGjnuNVq1Not0RW9xzCmG2D+snqVZkOiZXiX
         NSpw==
X-Forwarded-Encrypted: i=1; AJvYcCVqa6Ku7uyM+27EZF99qjNVk2ynF28pMGtSKBdPZFrMhy2EqONr/+grPs70VRpBoFlQvBM=@vger.kernel.org, AJvYcCW8jG0oY1NyjK4TqKE/LRk0SVVac1m5CJBhHvHxmYn2wJwPMO1OjGJY45Wk537H86NU3KbxZCz++w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAJye8tJg0LHX0HJp7I00BHNHocTskkDpSOfcNsbaNRK1+6tkU
	S5NJwSkbhzMlx2PBgZLnFc+Rw2i/61mPYYCxpGz73WQy7VsrLaUxTNRU
X-Gm-Gg: ASbGnctoZr5Ivh7m899m9PC3TVNQCwtqyaRJQemAH8+GoOtNdTZWiif4Yp5ZgTWlReK
	A+ECmPAr1bUXB1F7uzoqIxyQ47Jtyv4+hqmONW8TIG1+k5YZSaj+Lb3Gsn48USPa+h8/+KaSGYu
	ah9jsZzRqfpn2pAlTAf22Jqoknv/yMC/1A9cQzYZ0XGhauB5NUAhpsHxA+bxXWokxA5QPyOSTHB
	n5IQp0ei7ob5sYubE2LbKQoTBV7R3usabfeuNZZVAl2WA3BQ6f21ysDK2wMrHmrjlNtVZIpfllE
	g76m4Kt9e2HOibYYFiGtJnA85YAciz3dj+AGf8FYch4tK1T2qkvVj9HNhv+71hS8ZGCBFmh1O7t
	VYqG50XxmuQ==
X-Google-Smtp-Source: AGHT+IF+DR3PyvqH8kcTTECuIOvI8t45eIIaw39S1Hsw+BgCKJs/pdqIGXADQlm7IdG0IdpyCpFEqg==
X-Received: by 2002:a05:600c:8b11:b0:456:1d34:97a with SMTP id 5b1f17b1804b1-4587631561fmr143174525e9.9.1753794276870;
        Tue, 29 Jul 2025 06:04:36 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778eb27besm12308757f8f.9.2025.07.29.06.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 06:04:36 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 29 Jul 2025 15:04:34 +0200
To: ihor.solodrai@linux.dev
Cc: alan.maguire@oracle.com, olsajiri@gmail.com, dwarves@vger.kernel.org,
	bpf@vger.kernel.org, acme@kernel.org, andrii@kernel.org,
	ast@kernel.org, eddyz87@gmail.com, menglong8.dong@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH dwarves v2] btf_encoder: group all function ELF syms by
 function name
Message-ID: <aIjG4q6oirhi4pN1@krava>
References: <20250729020308.103139-1-isolodrai@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729020308.103139-1-isolodrai@meta.com>

On Mon, Jul 28, 2025 at 07:03:08PM -0700, Ihor Solodrai wrote:
> btf_encoder collects function ELF symbols into a table, which is later
> used for processing DWARF data and determining whether a function can
> be added to BTF.
> 
> So far the ELF symbol name was used as a key for search in this table,
> and a search by prefix match was attempted in cases when ELF symbol
> name has a compiler-generated suffix.
> 
> This implementation has bugs [1][2], causing some functions to be
> inappropriately excluded from (or included into) BTF.
> 
> Rework the implementation of the ELF functions table. Use a name of a
> function without any suffix - symbol name before the first occurrence
> of '.' - as a key. This way btf_encoder__find_function() always
> returns a valid elf_function object (or NULL).
> 
> Collect an array of symbol name + address pairs from GElf_Sym for each
> elf_function when building the elf_functions table.
> 
> Introduce ambiguous_addr flag to the btf_encoder_func_state. It is set
> when the function is saved by examining the array of ELF symbols in
> elf_function__has_ambiguous_address(). It tests whether there is only
> one unique address for this function name, taking into account that
> some addresses associated with it are not relevant:
>   * ".cold" suffix indicates a piece of hot/cold split
>   * ".part" suffix indicates a piece of partial inline
> 
> When inspecting symbol name we have to search for any occurrence of
> the target suffix, as opposed to testing the entire suffix, or the end
> of a string. This is because suffixes may be combined by the compiler,
> for example producing ".isra0.cold", and the conclusion will be
> incorrect.
> 
> In saved_functions_combine() check ambiguous_addr when deciding
> whether a function should be included in BTF.
> 
> Successful CI run: https://github.com/acmel/dwarves/pull/68/checks
> 
> I manually spot checked some of the ~200 functions from vmlinux (BPF
> CI-like kconfig) that are now excluded: all of those that I checked
> had multiple addresses, and some where static functions from different
> files with the same name.

in my config the change removed 464, did the same check and all of them
had more different addresses

couple nits below, but feel free to ignore

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


> 
> [1] https://lore.kernel.org/bpf/2f8c792e-9675-4385-b1cb-10266c72bd45@linux.dev/
> [2] https://lore.kernel.org/dwarves/6b4fda90fbf8f6aeeb2732bbfb6e81ba5669e2f3@linux.dev/
> 
> v1: https://lore.kernel.org/dwarves/98f41eaf6dd364745013650d58c5f254a592221c@linux.dev/
> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
> ---
>  btf_encoder.c | 250 ++++++++++++++++++++++++++++++++------------------
>  1 file changed, 162 insertions(+), 88 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 0bc2334..0aa94ae 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -87,16 +87,22 @@ struct btf_encoder_func_state {
>  	uint8_t optimized_parms:1;
>  	uint8_t unexpected_reg:1;
>  	uint8_t inconsistent_proto:1;
> +	uint8_t ambiguous_addr:1;
>  	int ret_type_id;
>  	struct btf_encoder_func_parm *parms;
>  	struct btf_encoder_func_annot *annots;
>  };
>  
> +struct elf_function_sym {
> +	const char *name;
> +	uint64_t addr;
> +};
> +
>  struct elf_function {
> -	const char	*name;
> -	char		*alias;
> -	size_t		prefixlen;
> -	bool		kfunc;
> +	char		*name;
> +	struct elf_function_sym *syms;
> +	uint8_t 	sym_cnt;

should we make this bigger, or at least check the overflow

256 dups are probably not possible, but with all those different
suffixes we might get close soon ;-)

> +	uint8_t		kfunc:1;
>  	uint32_t	kfunc_flags;
>  };
>  
> @@ -115,7 +121,6 @@ struct elf_functions {
>  	struct elf_symtab *symtab;
>  	struct elf_function *entries;
>  	int cnt;
> -	int suffix_cnt; /* number of .isra, .part etc */
>  };
>  
>  /*
> @@ -161,10 +166,18 @@ struct btf_kfunc_set_range {
>  	uint64_t end;
>  };
>  
> +static inline void elf_function__free_content(struct elf_function *func) {

elf_function__clear ?

> +	free(func->name);
> +	if (func->sym_cnt)
> +		free(func->syms);
> +	memset(func, 0, sizeof(*func));
> +}
> +
>  static inline void elf_functions__delete(struct elf_functions *funcs)
>  {
> -	for (int i = 0; i < funcs->cnt; i++)
> -		free(funcs->entries[i].alias);
> +	for (int i = 0; i < funcs->cnt; i++) {
> +		elf_function__free_content(&funcs->entries[i]);
> +	}
>  	free(funcs->entries);
>  	elf_symtab__delete(funcs->symtab);
>  	list_del(&funcs->node);
> @@ -981,8 +994,7 @@ static void btf_encoder__log_func_skip(struct btf_encoder *encoder, struct elf_f
>  
>  	if (!encoder->verbose)
>  		return;
> -	printf("%s (%s): skipping BTF encoding of function due to ",
> -	       func->alias ?: func->name, func->name);
> +	printf("%s : skipping BTF encoding of function due to ", func->name);
>  	va_start(ap, fmt);
>  	vprintf(fmt, ap);
>  	va_end(ap);
> @@ -1176,6 +1188,48 @@ static struct btf_encoder_func_state *btf_encoder__alloc_func_state(struct btf_e
>  	return state;
>  }
>  
> +/* some "." suffixes do not correspond to real functions;
> + * - .part for partial inline
> + * - .cold for rarely-used codepath extracted for better code locality
> + */
> +static bool str_contains_non_fn_suffix(const char *str) {
> +	static const char *skip[] = {
> +		".cold",
> +		".part"
> +	};
> +	char *suffix = strchr(str, '.');
> +	int i;
> +
> +	if (!suffix)
> +		return false;
> +	for (i = 0; i < ARRAY_SIZE(skip); i++) {
> +		if (strstr(suffix, skip[i]))
> +			return true;
> +	}
> +	return false;
> +}
> +
> +static bool elf_function__has_ambiguous_address(struct elf_function *func) {
> +	struct elf_function_sym *sym;
> +	uint64_t addr;
> +
> +	if (func->sym_cnt <= 1)
> +		return false;
> +
> +	addr = 0;
> +	for (int i = 0; i < func->sym_cnt; i++) {
> +		sym = &func->syms[i];
> +		if (!str_contains_non_fn_suffix(sym->name)) {
> +			if (addr && addr != sym->addr)
> +				return true;
> +			else
> +			 	addr = sym->addr;

nit extra space ' '    ^^^

> +		}
> +	}
> +
> +	return false;
> +}
> +

SNIP

