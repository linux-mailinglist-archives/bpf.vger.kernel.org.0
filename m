Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939C3376007
	for <lists+bpf@lfdr.de>; Fri,  7 May 2021 08:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbhEGGGU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 May 2021 02:06:20 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:36765 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEGGGT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 May 2021 02:06:19 -0400
Received: by mail-wm1-f41.google.com with SMTP id l24-20020a7bc4580000b029014ac3b80020so6466058wmi.1;
        Thu, 06 May 2021 23:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+auSOnJQ2CrA4YlqKVPbLrG0Z3GqrzFTzKF1Viv4fs0=;
        b=prpsnLH0w/4oUvMm+zy96vWz8Egwci52KXM91GyQMaj6p7rN+sJlAt+7XYmtVGFGgE
         0lxC1fgARyPQAglqapPFS81Y0+gS9OSuUV64fZne/EgfDLv3Vcf6/c/SOJctZ1/fxDJJ
         pB4uQ3BVhVG/h+pnHHl35f3gTRWYYywQ2jO7hpEQDVjMGC2fUTLXR2WW0RSV+LbPP7X/
         UCadMfZ7pv/+ZZlaWhcJSKT8MggF+WfRfQm2SIFNMm4ce5Qa02ZXN8Po/3zQs6iFtPpv
         x9fjcEgBolfEVeHaXjZ99YzVHwVweWpYFeOBgWayqkjmOPr00bmdp90N0qMtPStHLR/z
         w/pg==
X-Gm-Message-State: AOAM533M4tpSWFXH22GcKCjUOuMR1q0vb47WcHJJcG9ECup1Xux59c0h
        dbtClrG/UkibobMT0Xk84T8=
X-Google-Smtp-Source: ABdhPJyc+LSa7+hMqsBgaZ0Am+pclhbX/PaLgoKcWTatcsZ6vrU8yqw4RPLRBvriVcf45ppQ685P4g==
X-Received: by 2002:a05:600c:4ba3:: with SMTP id e35mr19449209wmp.16.1620367519389;
        Thu, 06 May 2021 23:05:19 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id u9sm6188083wmc.38.2021.05.06.23.05.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 23:05:18 -0700 (PDT)
Subject: Re: [PATCH v2 dwarves] btf: Remove ftrace filter
To:     Martin KaFai Lau <kafai@fb.com>, dwarves@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>, bpf@vger.kernel.org,
        kernel-team@fb.com, Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
References: <20210506205622.3663956-1-kafai@fb.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <bbf2d599-48d1-7470-2903-cbae5c14c24d@kernel.org>
Date:   Fri, 7 May 2021 08:05:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210506205622.3663956-1-kafai@fb.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 06. 05. 21, 22:56, Martin KaFai Lau wrote:
> BTF is currently generated for functions that are in ftrace list
> or extern.
> 
> A recent use case also needs BTF generated for functions included in
> allowlist.  In particular, the kernel
> commit e78aea8b2170 ("bpf: tcp: Put some tcp cong functions in allowlist for bpf-tcp-cc")
> allows bpf program to directly call a few tcp cc kernel functions. Those
> kernel functions are currently allowed only if CONFIG_DYNAMIC_FTRACE
> is set to ensure they are in the ftrace list but this kconfig dependency
> is unnecessary.
> 
> Those kernel functions are specified under an ELF section .BTF_ids.
> There was an earlier attempt [0] to add another filter for the functions in
> the .BTF_ids section.  That discussion concluded that the ftrace filter
> should be removed instead.
> 
> This patch is to remove the ftrace filter and its related functions.
> 
> Number of BTF FUNC with and without is_ftrace_func():
> My kconfig in x86: 40643 vs 46225
> Jiri reported on arm: 25022 vs 55812
> 
> [0]: https://lore.kernel.org/dwarves/20210423213728.3538141-1-kafai@fb.com/
> 
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>

Today, I missed you submission :). So:

Acked-by: Jiri Slaby <jirislaby@kernel.org>

> ---
> v2: Remove sym_sec_idx, last_idx, and sh. (Jiri Olsa)
> 
>   btf_encoder.c | 285 ++------------------------------------------------
>   1 file changed, 7 insertions(+), 278 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 80e896961d4e..c711f124b31e 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -27,17 +27,8 @@
>    */
>   #define KSYM_NAME_LEN 128
>   
> -struct funcs_layout {
> -	unsigned long mcount_start;
> -	unsigned long mcount_stop;
> -	unsigned long mcount_sec_idx;
> -};
> -
>   struct elf_function {
>   	const char	*name;
> -	unsigned long	 addr;
> -	unsigned long	 size;
> -	unsigned long	 sh_addr;
>   	bool		 generated;
>   };
>   
> @@ -64,12 +55,9 @@ static void delete_functions(void)
>   #define max(x, y) ((x) < (y) ? (y) : (x))
>   #endif
>   
> -static int collect_function(struct btf_elf *btfe, GElf_Sym *sym,
> -			    size_t sym_sec_idx)
> +static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
>   {
>   	struct elf_function *new;
> -	static GElf_Shdr sh;
> -	static size_t last_idx;
>   	const char *name;
>   
>   	if (elf_sym__type(sym) != STT_FUNC)
> @@ -91,257 +79,12 @@ static int collect_function(struct btf_elf *btfe, GElf_Sym *sym,
>   		functions = new;
>   	}
>   
> -	if (sym_sec_idx != last_idx) {
> -		if (!elf_section_by_idx(btfe->elf, &sh, sym_sec_idx))
> -			return 0;
> -		last_idx = sym_sec_idx;
> -	}
> -
>   	functions[functions_cnt].name = name;
> -	functions[functions_cnt].addr = elf_sym__value(sym);
> -	functions[functions_cnt].size = elf_sym__size(sym);
> -	functions[functions_cnt].sh_addr = sh.sh_addr;
>   	functions[functions_cnt].generated = false;
>   	functions_cnt++;
>   	return 0;
>   }
>   
> -static int addrs_cmp(const void *_a, const void *_b)
> -{
> -	const __u64 *a = _a;
> -	const __u64 *b = _b;
> -
> -	if (*a == *b)
> -		return 0;
> -	return *a < *b ? -1 : 1;
> -}
> -
> -static int get_vmlinux_addrs(struct btf_elf *btfe, struct funcs_layout *fl,
> -			     __u64 **paddrs, __u64 *pcount)
> -{
> -	__u64 *addrs, count, offset;
> -	unsigned int addr_size, i;
> -	Elf_Data *data;
> -	GElf_Shdr shdr;
> -	Elf_Scn *sec;
> -
> -	/* Initialize for the sake of all error paths below. */
> -	*paddrs = NULL;
> -	*pcount = 0;
> -
> -	if (!fl->mcount_start || !fl->mcount_stop)
> -		return 0;
> -
> -	/*
> -	 * Find mcount addressed marked by __start_mcount_loc
> -	 * and __stop_mcount_loc symbols and load them into
> -	 * sorted array.
> -	 */
> -	sec = elf_getscn(btfe->elf, fl->mcount_sec_idx);
> -	if (!sec || !gelf_getshdr(sec, &shdr)) {
> -		fprintf(stderr, "Failed to get section(%lu) header.\n",
> -			fl->mcount_sec_idx);
> -		return -1;
> -	}
> -
> -	/* Get address size from processed file's ELF class. */
> -	addr_size = gelf_getclass(btfe->elf) == ELFCLASS32 ? 4 : 8;
> -
> -	offset = fl->mcount_start - shdr.sh_addr;
> -	count  = (fl->mcount_stop - fl->mcount_start) / addr_size;
> -
> -	data = elf_getdata(sec, 0);
> -	if (!data) {
> -		fprintf(stderr, "Failed to get section(%lu) data.\n",
> -			fl->mcount_sec_idx);
> -		return -1;
> -	}
> -
> -	addrs = malloc(count * sizeof(addrs[0]));
> -	if (!addrs) {
> -		fprintf(stderr, "Failed to allocate memory for ftrace addresses.\n");
> -		return -1;
> -	}
> -
> -	if (addr_size == sizeof(__u64)) {
> -		memcpy(addrs, data->d_buf + offset, count * addr_size);
> -	} else {
> -		for (i = 0; i < count; i++)
> -			addrs[i] = (__u64) *((__u32 *) (data->d_buf + offset + i * addr_size));
> -	}
> -
> -	*paddrs = addrs;
> -	*pcount = count;
> -	return 0;
> -}
> -
> -static int
> -get_kmod_addrs(struct btf_elf *btfe, __u64 **paddrs, __u64 *pcount)
> -{
> -	__u64 *addrs, count;
> -	unsigned int addr_size, i;
> -	GElf_Shdr shdr_mcount;
> -	Elf_Data *data;
> -	Elf_Scn *sec;
> -
> -	/* Initialize for the sake of all error paths below. */
> -	*paddrs = NULL;
> -	*pcount = 0;
> -
> -	/* get __mcount_loc */
> -	sec = elf_section_by_name(btfe->elf, &btfe->ehdr, &shdr_mcount,
> -				  "__mcount_loc", NULL);
> -	if (!sec) {
> -		if (btf_elf__verbose) {
> -			printf("%s: '%s' doesn't have __mcount_loc section\n", __func__,
> -			       btfe->filename);
> -		}
> -		return 0;
> -	}
> -
> -	data = elf_getdata(sec, NULL);
> -	if (!data) {
> -		fprintf(stderr, "Failed to data for __mcount_loc section.\n");
> -		return -1;
> -	}
> -
> -	/* Get address size from processed file's ELF class. */
> -	addr_size = gelf_getclass(btfe->elf) == ELFCLASS32 ? 4 : 8;
> -
> -	count = data->d_size / addr_size;
> -
> -	addrs = malloc(count * sizeof(addrs[0]));
> -	if (!addrs) {
> -		fprintf(stderr, "Failed to allocate memory for ftrace addresses.\n");
> -		return -1;
> -	}
> -
> -	if (addr_size == sizeof(__u64)) {
> -		memcpy(addrs, data->d_buf, count * addr_size);
> -	} else {
> -		for (i = 0; i < count; i++)
> -			addrs[i] = (__u64) *((__u32 *) (data->d_buf + i * addr_size));
> -	}
> -
> -	/*
> -	 * We get Elf object from dwfl_module_getelf function,
> -	 * which performs all possible relocations, including
> -	 * __mcount_loc section.
> -	 *
> -	 * So addrs array now contains relocated values, which
> -	 * we need take into account when we compare them to
> -	 * functions values, see comment in setup_functions
> -	 * function.
> -	 */
> -	*paddrs = addrs;
> -	*pcount = count;
> -	return 0;
> -}
> -
> -static int is_ftrace_func(struct elf_function *func, __u64 *addrs, __u64 count)
> -{
> -	__u64 start = func->addr;
> -	__u64 addr, end = func->addr + func->size;
> -
> -	/*
> -	 * The invariant here is addr[r] that is the smallest address
> -	 * that is >= than function start addr. Except the corner case
> -	 * where there is no such r, but for that we have a final check
> -	 * in the return.
> -	 */
> -	size_t l = 0, r = count - 1, m;
> -
> -	/* make sure we don't use invalid r */
> -	if (count == 0)
> -		return false;
> -
> -	while (l < r) {
> -		m = l + (r - l) / 2;
> -		addr = addrs[m];
> -
> -		if (addr >= start) {
> -			/* we satisfy invariant, so tighten r */
> -			r = m;
> -		} else {
> -			/* m is not good enough as l, maybe m + 1 will be */
> -			l = m + 1;
> -		}
> -	}
> -
> -	return start <= addrs[r] && addrs[r] < end;
> -}
> -
> -static int setup_functions(struct btf_elf *btfe, struct funcs_layout *fl)
> -{
> -	__u64 *addrs, count, i;
> -	int functions_valid = 0;
> -	bool kmod = false;
> -
> -	/*
> -	 * Check if we are processing vmlinux image and
> -	 * get mcount data if it's detected.
> -	 */
> -	if (get_vmlinux_addrs(btfe, fl, &addrs, &count))
> -		return -1;
> -
> -	/*
> -	 * Check if we are processing kernel module and
> -	 * get mcount data if it's detected.
> -	 */
> -	if (!addrs) {
> -		if (get_kmod_addrs(btfe, &addrs, &count))
> -			return -1;
> -		kmod = true;
> -	}
> -
> -	if (!addrs) {
> -		if (btf_elf__verbose)
> -			printf("ftrace symbols not detected, falling back to DWARF data\n");
> -		delete_functions();
> -		return 0;
> -	}
> -
> -	qsort(addrs, count, sizeof(addrs[0]), addrs_cmp);
> -	qsort(functions, functions_cnt, sizeof(functions[0]), functions_cmp);
> -
> -	/*
> -	 * Let's got through all collected functions and filter
> -	 * out those that are not in ftrace.
> -	 */
> -	for (i = 0; i < functions_cnt; i++) {
> -		struct elf_function *func = &functions[i];
> -		/*
> -		 * For vmlinux image both addrs[x] and functions[x]::addr
> -		 * values are final address and are comparable.
> -		 *
> -		 * For kernel module addrs[x] is final address, but
> -		 * functions[x]::addr is relative address within section
> -		 * and needs to be relocated by adding sh_addr.
> -		 */
> -		if (kmod)
> -			func->addr += func->sh_addr;
> -
> -		/* Make sure function is within ftrace addresses. */
> -		if (is_ftrace_func(func, addrs, count)) {
> -			/*
> -			 * We iterate over sorted array, so we can easily skip
> -			 * not valid item and move following valid field into
> -			 * its place, and still keep the 'new' array sorted.
> -			 */
> -			if (i != functions_valid)
> -				functions[functions_valid] = functions[i];
> -			functions_valid++;
> -		}
> -	}
> -
> -	functions_cnt = functions_valid;
> -	free(addrs);
> -
> -	if (btf_elf__verbose)
> -		printf("Found %d functions!\n", functions_cnt);
> -	return 0;
> -}
> -
>   static struct elf_function *find_function(const struct btf_elf *btfe,
>   					  const char *name)
>   {
> @@ -620,23 +363,8 @@ static int collect_percpu_var(struct btf_elf *btfe, GElf_Sym *sym,
>   	return 0;
>   }
>   
> -static void collect_symbol(GElf_Sym *sym, struct funcs_layout *fl,
> -			   size_t sym_sec_idx)
> -{
> -	if (!fl->mcount_start &&
> -	    !strcmp("__start_mcount_loc", elf_sym__name(sym, btfe->symtab))) {
> -		fl->mcount_start = sym->st_value;
> -		fl->mcount_sec_idx = sym_sec_idx;
> -	}
> -
> -	if (!fl->mcount_stop &&
> -	    !strcmp("__stop_mcount_loc", elf_sym__name(sym, btfe->symtab)))
> -		fl->mcount_stop = sym->st_value;
> -}
> -
>   static int collect_symbols(struct btf_elf *btfe, bool collect_percpu_vars)
>   {
> -	struct funcs_layout fl = { };
>   	Elf32_Word sym_sec_idx;
>   	uint32_t core_id;
>   	GElf_Sym sym;
> @@ -648,9 +376,8 @@ static int collect_symbols(struct btf_elf *btfe, bool collect_percpu_vars)
>   	elf_symtab__for_each_symbol_index(btfe->symtab, core_id, sym, sym_sec_idx) {
>   		if (collect_percpu_vars && collect_percpu_var(btfe, &sym, sym_sec_idx))
>   			return -1;
> -		if (collect_function(btfe, &sym, sym_sec_idx))
> +		if (collect_function(btfe, &sym))
>   			return -1;
> -		collect_symbol(&sym, &fl, sym_sec_idx);
>   	}
>   
>   	if (collect_percpu_vars) {
> @@ -661,9 +388,11 @@ static int collect_symbols(struct btf_elf *btfe, bool collect_percpu_vars)
>   			printf("Found %d per-CPU variables!\n", percpu_var_cnt);
>   	}
>   
> -	if (functions_cnt && setup_functions(btfe, &fl)) {
> -		fprintf(stderr, "Failed to filter DWARF functions\n");
> -		return -1;
> +	if (functions_cnt) {
> +		qsort(functions, functions_cnt, sizeof(functions[0]),
> +		      functions_cmp);
> +		if (btf_elf__verbose)
> +			printf("Found %d functions!\n", functions_cnt);
>   	}
>   
>   	return 0;
> 


-- 
js
