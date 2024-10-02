Return-Path: <bpf+bounces-40760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F9F98DA39
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 16:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A3B928577E
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 14:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579861D0792;
	Wed,  2 Oct 2024 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMt5OhEK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6A71D1E68;
	Wed,  2 Oct 2024 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878474; cv=none; b=pOmhEbZ7VKKJJoLL/+9XNcwcZcToAXeJw9tJmEUgqzHl1f5YDpOSYIZ4UNUPIVJ3QmujN14a3OnDhmW7GflTcoPQbBJwhjLrz3m/AHbu3k+zOprla9MzlOKtP0DTOt9zI8519HoP2WA6nVEuPGggpylGZTMdf3AncPEa5KRQo8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878474; c=relaxed/simple;
	bh=xW3Zh7KGROyYhzfSfKy9wTG77VDn6qwnUcNhw/HNMQ0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rapEjskIAvQV9GMHsL6luK0u1hipRjVaPD51Mxm7qOKWBO+hjXkrMxcAnOf5/j6K+zxTcmHGnpZK1fnsYPu9S2hLOHrkZBMPNV2sejcABwhLMgXo/b7AF7Z+kw3MI7P2Xr/OvbsFtuRGGqdmxHCmMHmNA6tE/SMSwaH/SZ4rLk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMt5OhEK; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cb6f3a5bcso82949715e9.2;
        Wed, 02 Oct 2024 07:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727878471; x=1728483271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/cbEpBXYpBOfbVOEtMvTpdF23Rzw4cY22ly38cpzTg=;
        b=SMt5OhEKj9rM37IRaBTziCCmn0P6u/EvhdbqHx71RekxLe2I83E39ZrXuci6BYZyS2
         gkvAzhvr85H1FxJDR3KLn3RW+3TzptKoOOozaLm+Ie2uEB+eVDJLuh4nzIpyEdFjbNpm
         Ibz6IRnHMpElZ/s2vQCyCQTOSn+cwnvH6WP5/cjxwvmGHdScq2JkpaRV1IY/ycn+ffgz
         M+WmRNR1i1Vb/wvrn6DqgWqlxSAMU4rAvwHFv5NXD8eAyLX6AL9ouSsZ6LMLKO9ISJzF
         D2HJbUs4hoYtFboRkkErjtZwtpOIkwoqApVJihkmQjV1JqFLrmChiKmCAhIVQO5Hle+E
         dR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727878471; x=1728483271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/cbEpBXYpBOfbVOEtMvTpdF23Rzw4cY22ly38cpzTg=;
        b=F11w2hjp3at1XpSS792v2Q8uQGNN9XKmemhcvxa4IdnsSCyXlX8Yo+C7W0Bm+dD2Ws
         9nJeptwhPnfLZpxUjnM3zDHmz8ujmEjh7pCP2PslDV59B4f1Ldz1A2Ew9aw41All+3jj
         heEHaE5vinnM0U7E2zjOXNGdl5L53kCSG9f6kPkI57LMdq/wrcfvfagjolz6lfSS05T/
         TxqmI+UZLuuQT5XCArlZeySi3ieAeYXU9i51iT5jcYyUgtsDfJCP76VtimoFIj8OfL0Q
         1mbg4XH34tQ8+T7CXMX+B/mXAcMlIkubcyfCLN0XGGfSRC62DSiF/DtzrghRMYWKKKED
         l13w==
X-Forwarded-Encrypted: i=1; AJvYcCVqVo6t5w3iL5by1MNDFV6FOd+cKI8flZ5qb5DnOqdd9lOJ7JuHhGwaDgkMy0VMHEI6MVI=@vger.kernel.org, AJvYcCWS53BTVURDc+DTF8Q5Z/0MjEMkxvQ1STxKaNZ90c4Iou8OQhKZerqaRGJZZj65KqtpH5f8BwtUUGUJg3a0j852@vger.kernel.org, AJvYcCXIGoJR3lDlxnhLZ9n43rVQKGzTor5uUu+x5JQelzYwBRRDtJTHNSb+kMWVmrOCa2WLjri7Wh4vJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YygnVhgMkQlhPivGvUTiSURzRNV/WWExxjaBZ+Yokhj0LwhrjW2
	rmsF7kWX/nSyRF4Z9pHMPfOSI5nl6dwDFh3+rpiljA9VS1xXxMnH
X-Google-Smtp-Source: AGHT+IFhW9UvMl9/yKhX3tjHZSNEfnyIU2OexDqZxLP1NmwRq0I1K3z/xuQ0LnTyESnBAu6/4FyePQ==
X-Received: by 2002:a05:600c:1d88:b0:42c:a387:6a6f with SMTP id 5b1f17b1804b1-42f777c365fmr28413125e9.20.1727878470192;
        Wed, 02 Oct 2024 07:14:30 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79ff5a9asm19833685e9.34.2024.10.02.07.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 07:14:29 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 2 Oct 2024 16:14:27 +0200
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, bpf@vger.kernel.org,
	dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH dwarves v2 4/4] btf_encoder: add global_var feature to
 encode globals
Message-ID: <Zv1VQ0G_GpwCjjie@krava>
References: <20240920081903.13473-1-stephen.s.brennan@oracle.com>
 <20240920081903.13473-5-stephen.s.brennan@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920081903.13473-5-stephen.s.brennan@oracle.com>

On Fri, Sep 20, 2024 at 01:19:01AM -0700, Stephen Brennan wrote:
> Currently the "var" feature only encodes percpu variables. Add the
> ability to encode all global variables.
> 
> This also drops the use of the symbol table to find variable names and
> compare them against DWARF names. We simply rely on the DWARF
> information to give us all the variables.
> 
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> Tested-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  btf_encoder.c      | 347 +++++++++++++++++++++------------------------
>  btf_encoder.h      |   8 ++
>  dwarves.h          |   1 +
>  man-pages/pahole.1 |   8 +-
>  pahole.c           |  11 +-
>  5 files changed, 183 insertions(+), 192 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 97d35e0..d3a66a0 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -65,16 +65,13 @@ struct elf_function {
>  	struct btf_encoder_state state;
>  };
>  
> -struct var_info {
> -	uint64_t    addr;
> -	const char *name;
> -	uint32_t    sz;
> -};
> -
>  struct elf_secinfo {
>  	uint64_t    addr;
>  	const char *name;
>  	uint64_t    sz;
> +	bool        include;
> +	uint32_t    type;
> +	struct gobuffer secinfo;
>  };
>  
>  /*
> @@ -84,31 +81,24 @@ struct btf_encoder {
>  	struct list_head  node;
>  	struct btf        *btf;
>  	struct cu         *cu;
> -	struct gobuffer   percpu_secinfo;
>  	const char	  *source_filename;
>  	const char	  *filename;
>  	struct elf_symtab *symtab;
>  	uint32_t	  type_id_off;
>  	bool		  has_index_type,
>  			  need_index_type,
> -			  skip_encoding_vars,
>  			  raw_output,
>  			  verbose,
>  			  force,
>  			  gen_floats,
>  			  skip_encoding_decl_tag,
>  			  tag_kfuncs,
> -			  is_rel,
>  			  gen_distilled_base;
>  	uint32_t	  array_index_id;
>  	struct elf_secinfo *secinfo;
>  	size_t             seccnt;
> -	struct {
> -		struct var_info *vars;
> -		int		var_cnt;
> -		int		allocated;
> -		uint32_t	shndx;
> -	} percpu;
> +	int                encode_vars;
> +	uint32_t           percpu_shndx;
>  	struct {
>  		struct elf_function *entries;
>  		int		    allocated;
> @@ -735,46 +725,56 @@ static int32_t btf_encoder__add_var(struct btf_encoder *encoder, uint32_t type,
>  	return id;
>  }
>  
> -static int32_t btf_encoder__add_var_secinfo(struct btf_encoder *encoder, uint32_t type,
> -				     uint32_t offset, uint32_t size)
> +static int32_t btf_encoder__add_var_secinfo(struct btf_encoder *encoder, int shndx,
> +					    uint32_t type, unsigned long addr, uint32_t size)
>  {
>  	struct btf_var_secinfo si = {
>  		.type = type,
> -		.offset = offset,
> +		.offset = addr,
>  		.size = size,
>  	};
> -	return gobuffer__add(&encoder->percpu_secinfo, &si, sizeof(si));
> +	return gobuffer__add(&encoder->secinfo[shndx].secinfo, &si, sizeof(si));
>  }
>  
>  int32_t btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_encoder *other)
>  {
> -	struct gobuffer *var_secinfo_buf = &other->percpu_secinfo;
> -	size_t sz = gobuffer__size(var_secinfo_buf);
> -	uint16_t nr_var_secinfo = sz / sizeof(struct btf_var_secinfo);
> -	uint32_t type_id;
> -	uint32_t next_type_id = btf__type_cnt(encoder->btf);
> -	int32_t i, id;
> -	struct btf_var_secinfo *vsi;
> -
> +	int shndx;
>  	if (encoder == other)
>  		return 0;
>  
>  	btf_encoder__add_saved_funcs(other);
>  
> -	for (i = 0; i < nr_var_secinfo; i++) {
> -		vsi = (struct btf_var_secinfo *)var_secinfo_buf->entries + i;
> -		type_id = next_type_id + vsi->type - 1; /* Type ID starts from 1 */
> -		id = btf_encoder__add_var_secinfo(encoder, type_id, vsi->offset, vsi->size);
> -		if (id < 0)
> -			return id;
> +	for (shndx = 0; shndx < other->seccnt; shndx++) {
> +		struct gobuffer *var_secinfo_buf = &other->secinfo[shndx].secinfo;
> +		size_t sz = gobuffer__size(var_secinfo_buf);
> +		uint16_t nr_var_secinfo = sz / sizeof(struct btf_var_secinfo);
> +		uint32_t type_id;
> +		uint32_t next_type_id = btf__type_cnt(encoder->btf);
> +		int32_t i, id;
> +		struct btf_var_secinfo *vsi;
> +
> +		if (strcmp(encoder->secinfo[shndx].name, other->secinfo[shndx].name)) {
> +			fprintf(stderr, "mismatched ELF sections at index %d: \"%s\", \"%s\"\n",
> +				shndx, encoder->secinfo[shndx].name, other->secinfo[shndx].name);
> +			return -1;
> +		}
> +
> +		for (i = 0; i < nr_var_secinfo; i++) {
> +			vsi = (struct btf_var_secinfo *)var_secinfo_buf->entries + i;
> +			type_id = next_type_id + vsi->type - 1; /* Type ID starts from 1 */
> +			id = btf_encoder__add_var_secinfo(encoder, shndx, type_id, vsi->offset, vsi->size);
> +			if (id < 0)
> +				return id;
> +		}
>  	}
>  
>  	return btf__add_btf(encoder->btf, other->btf);
>  }
>  
> -static int32_t btf_encoder__add_datasec(struct btf_encoder *encoder, const char *section_name)
> +static int32_t btf_encoder__add_datasec(struct btf_encoder *encoder, int shndx)
>  {
> -	struct gobuffer *var_secinfo_buf = &encoder->percpu_secinfo;
> +	struct gobuffer *var_secinfo_buf = &encoder->secinfo[shndx].secinfo;
> +	const char *section_name = encoder->secinfo[shndx].name;
>  	struct btf *btf = encoder->btf;
>  	size_t sz = gobuffer__size(var_secinfo_buf);
>  	uint16_t nr_var_secinfo = sz / sizeof(struct btf_var_secinfo);
> @@ -1741,13 +1741,14 @@ out:
>  int btf_encoder__encode(struct btf_encoder *encoder)
>  {
>  	bool should_tag_kfuncs;
> -	int err;
> +	int err, shndx;
>  
>  	/* for single-threaded case, saved funcs are added here */
>  	btf_encoder__add_saved_funcs(encoder);
>  
> -	if (gobuffer__size(&encoder->percpu_secinfo) != 0)
> -		btf_encoder__add_datasec(encoder, PERCPU_SECTION);
> +	for (shndx = 0; shndx < encoder->seccnt; shndx++)
> +		if (gobuffer__size(&encoder->secinfo[shndx].secinfo))
> +			btf_encoder__add_datasec(encoder, shndx);
>  
>  	/* Empty file, nothing to do, so... done! */
>  	if (btf__type_cnt(encoder->btf) == 1)
> @@ -1797,111 +1798,18 @@ int btf_encoder__encode(struct btf_encoder *encoder)
>  	return err;
>  }
>  
> -static int percpu_var_cmp(const void *_a, const void *_b)
> -{
> -	const struct var_info *a = _a;
> -	const struct var_info *b = _b;
> -
> -	if (a->addr == b->addr)
> -		return 0;
> -	return a->addr < b->addr ? -1 : 1;
> -}
> -
> -static bool btf_encoder__percpu_var_exists(struct btf_encoder *encoder, uint64_t addr, uint32_t *sz, const char **name)
> -{
> -	struct var_info key = { .addr = addr };
> -	const struct var_info *p = bsearch(&key, encoder->percpu.vars, encoder->percpu.var_cnt,
> -					   sizeof(encoder->percpu.vars[0]), percpu_var_cmp);
> -	if (!p)
> -		return false;
> -
> -	*sz = p->sz;
> -	*name = p->name;
> -	return true;
> -}
> -
> -static int btf_encoder__collect_percpu_var(struct btf_encoder *encoder, GElf_Sym *sym, size_t sym_sec_idx)
> -{
> -	const char *sym_name;
> -	uint64_t addr;
> -	uint32_t size;
> -
> -	/* compare a symbol's shndx to determine if it's a percpu variable */
> -	if (sym_sec_idx != encoder->percpu.shndx)
> -		return 0;
> -	if (elf_sym__type(sym) != STT_OBJECT)
> -		return 0;
> -
> -	addr = elf_sym__value(sym);
> -
> -	size = elf_sym__size(sym);
> -	if (!size)
> -		return 0; /* ignore zero-sized symbols */
> -
> -	sym_name = elf_sym__name(sym, encoder->symtab);
> -	if (!btf_name_valid(sym_name)) {
> -		dump_invalid_symbol("Found symbol of invalid name when encoding btf",
> -				    sym_name, encoder->verbose, encoder->force);
> -		if (encoder->force)
> -			return 0;
> -		return -1;
> -	}
> -
> -	if (encoder->verbose)
> -		printf("Found per-CPU symbol '%s' at address 0x%" PRIx64 "\n", sym_name, addr);
> -
> -	/* Make sure addr is section-relative. For kernel modules (which are
> -	 * ET_REL files) this is already the case. For vmlinux (which is an
> -	 * ET_EXEC file) we need to subtract the section address.
> -	 */
> -	if (!encoder->is_rel)
> -		addr -= encoder->secinfo[encoder->percpu.shndx].addr;
> -
> -	if (encoder->percpu.var_cnt == encoder->percpu.allocated) {
> -		struct var_info *new;
> -
> -		new = reallocarray_grow(encoder->percpu.vars,
> -					&encoder->percpu.allocated,
> -					sizeof(*encoder->percpu.vars));
> -		if (!new) {
> -			fprintf(stderr, "Failed to allocate memory for variables\n");
> -			return -1;
> -		}
> -		encoder->percpu.vars = new;
> -	}
> -	encoder->percpu.vars[encoder->percpu.var_cnt].addr = addr;
> -	encoder->percpu.vars[encoder->percpu.var_cnt].sz = size;
> -	encoder->percpu.vars[encoder->percpu.var_cnt].name = sym_name;
> -	encoder->percpu.var_cnt++;
> -
> -	return 0;
> -}
>  
> -static int btf_encoder__collect_symbols(struct btf_encoder *encoder, bool collect_percpu_vars)
> +static int btf_encoder__collect_symbols(struct btf_encoder *encoder)
>  {
> -	Elf32_Word sym_sec_idx;
> +	uint32_t sym_sec_idx;
>  	uint32_t core_id;
>  	GElf_Sym sym;
>  
> -	/* cache variables' addresses, preparing for searching in symtab. */
> -	encoder->percpu.var_cnt = 0;
> -
> -	/* search within symtab for percpu variables */
>  	elf_symtab__for_each_symbol_index(encoder->symtab, core_id, sym, sym_sec_idx) {
> -		if (collect_percpu_vars && btf_encoder__collect_percpu_var(encoder, &sym, sym_sec_idx))
> -			return -1;
>  		if (btf_encoder__collect_function(encoder, &sym))
>  			return -1;
>  	}
>  
> -	if (collect_percpu_vars) {
> -		if (encoder->percpu.var_cnt)
> -			qsort(encoder->percpu.vars, encoder->percpu.var_cnt, sizeof(encoder->percpu.vars[0]), percpu_var_cmp);
> -
> -		if (encoder->verbose)
> -			printf("Found %d per-CPU variables!\n", encoder->percpu.var_cnt);
> -	}
> -
>  	if (encoder->functions.cnt) {
>  		qsort(encoder->functions.entries, encoder->functions.cnt, sizeof(encoder->functions.entries[0]),
>  		      functions_cmp);
> @@ -1923,75 +1831,128 @@ static bool ftype__has_arg_names(const struct ftype *ftype)
>  	return true;
>  }
>  
> +static int get_elf_section(struct btf_encoder *encoder, unsigned long addr)
> +{
> +	/* Start at index 1 to ignore initial SHT_NULL section */
> +	for (int i = 1; i < encoder->seccnt; i++)
> +		/* Variables are only present in PROGBITS or NOBITS (.bss) */
> +		if ((encoder->secinfo[i].type == SHT_PROGBITS ||
> +		     encoder->secinfo[i].type == SHT_NOBITS) &&
> +		    encoder->secinfo[i].addr <= addr &&
> +		    (addr - encoder->secinfo[i].addr) < encoder->secinfo[i].sz)
> +			return i;
> +	return -ENOENT;
> +}
> +
> +/*
> + * Filter out variables / symbol names with common prefixes and no useful
> + * values. Prefixes should be added sparingly, and it should be objectively
> + * obvious that they are not useful.
> + */
> +static bool filter_variable_name(const char *name)
> +{
> +	static const struct { char *s; size_t len; } skip[] = {
> +		#define X(str) {str, sizeof(str) - 1}
> +		X("__UNIQUE_ID"),
> +		X("__tpstrtab_"),
> +		X("__exitcall_"),
> +		X("__func_stack_frame_non_standard_")
> +		#undef X
> +	};
> +	int i;
> +
> +	if (*name != '_')
> +		return false;
> +
> +	for (i = 0; i < ARRAY_SIZE(skip); i++) {
> +		if (strncmp(name, skip[i].s, skip[i].len) == 0)
> +			return true;
> +	}
> +	return false;
> +}
> +
>  static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>  {
>  	struct cu *cu = encoder->cu;
>  	uint32_t core_id;
>  	struct tag *pos;
>  	int err = -1;
> -	struct elf_secinfo *pcpu_scn = &encoder->secinfo[encoder->percpu.shndx];
>  
> -	if (encoder->percpu.shndx == 0 || !encoder->symtab)
> +	if (!encoder->symtab)
>  		return 0;
>  
>  	if (encoder->verbose)
> -		printf("search cu '%s' for percpu global variables.\n", cu->name);
> +		printf("search cu '%s' for global variables.\n", cu->name);
>  
>  	cu__for_each_variable(cu, core_id, pos) {
>  		struct variable *var = tag__variable(pos);
> -		uint32_t size, type, linkage;
> -		const char *name, *dwarf_name;
> +		uint32_t type, linkage;
> +		const char *name;
>  		struct llvm_annotation *annot;
>  		const struct tag *tag;
> +		int shndx;
> +		struct elf_secinfo *sec = NULL;
>  		uint64_t addr;
>  		int id;
> +		unsigned long size;
>  
> +		/* Skip incomplete (non-defining) declarations */
>  		if (var->declaration && !var->spec)
>  			continue;
>  
> -		/* percpu variables are allocated in global space */
> -		if (variable__scope(var) != VSCOPE_GLOBAL && !var->spec)
> +		/*
> +		 * top_level: indicates that the variable is declared at the top
> +		 *   level of the CU, and thus it is globally scoped.
> +		 * artificial: indicates that the variable is a compiler-generated
> +		 *   "fake" variable that doesn't appear in the source.
> +		 * scope: set by pahole to indicate the type of storage the
> +		 *   variable has. GLOBAL indicates it is stored in static
> +		 *   memory (as opposed to a stack variable or register)
> +		 *
> +		 * Some variables are "top_level" but not GLOBAL:
> +		 *   e.g. current_stack_pointer, which is a register variable,
> +		 *   despite having global CU-declarations. We don't want that,
> +		 *   since no code could actually find this variable.
> +		 * Some variables are GLOBAL but not top_level:
> +		 *   e.g. function static variables
> +		 */
> +		if (!var->top_level || var->artificial || var->scope != VSCOPE_GLOBAL)
>  			continue;
>  
>  		/* addr has to be recorded before we follow spec */
>  		addr = var->ip.addr;
> -		dwarf_name = variable__name(var);
>  
> -		/* Make sure addr is section-relative. DWARF, unlike ELF,
> -		 * always contains virtual symbol addresses, so subtract
> -		 * the section address unconditionally.
> -		 */
> -		if (addr < pcpu_scn->addr || addr >= pcpu_scn->addr + pcpu_scn->sz)
> +		/* Get the ELF section info for the variable */
> +		shndx = get_elf_section(encoder, addr);
> +		if (shndx >= 0 && shndx < encoder->seccnt)
> +			sec = &encoder->secinfo[shndx];
> +		if (!sec || !sec->include)
>  			continue;
> -		addr -= pcpu_scn->addr;
>  
> -		if (!btf_encoder__percpu_var_exists(encoder, addr, &size, &name))
> -			continue; /* not a per-CPU variable */
> +		/* Convert addr to section relative */
> +		addr -= sec->addr;
>  
> -		/* A lot of "special" DWARF variables (e.g, __UNIQUE_ID___xxx)
> -		 * have addr == 0, which is the same as, say, valid
> -		 * fixed_percpu_data per-CPU variable. To distinguish between
> -		 * them, additionally compare DWARF and ELF symbol names. If
> -		 * DWARF doesn't provide proper name, pessimistically assume
> -		 * bad variable.
> -		 *
> -		 * Examples of such special variables are:
> -		 *
> -		 *  1. __ADDRESSABLE(sym), which are forcely emitted as symbols.
> -		 *  2. __UNIQUE_ID(prefix), which are introduced to generate unique ids.
> -		 *  3. __exitcall(fn), functions which are labeled as exit calls.
> -		 *
> -		 *  This is relevant only for vmlinux image, as for kernel
> -		 *  modules per-CPU data section has non-zero offset so all
> -		 *  per-CPU symbols have non-zero values.
> -		 */
> -		if (var->ip.addr == 0) {
> -			if (!dwarf_name || strcmp(dwarf_name, name))
> +		/* DWARF specification reference should be followed, because
> +		 * information like the name & type may not be present on var */
> +		if (var->spec)
> +			var = var->spec;
> +
> +		name = variable__name(var);
> +		if (!name)
> +			continue;
> +
> +		/* Check for invalid BTF names */
> +		if (!btf_name_valid(name)) {
> +			dump_invalid_symbol("Found invalid variable name when encoding btf",
> +					    name, encoder->verbose, encoder->force);
> +			if (encoder->force)
>  				continue;
> +			else
> +				return -1;
>  		}
>  
> -		if (var->spec)
> -			var = var->spec;
> +		if (filter_variable_name(name))
> +			continue;
>  
>  		if (var->ip.tag.type == 0) {
>  			fprintf(stderr, "error: found variable '%s' in CU '%s' that has void type\n",
> @@ -2003,9 +1964,10 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>  		}
>  
>  		tag = cu__type(cu, var->ip.tag.type);
> -		if (tag__size(tag, cu) == 0) {
> +		size = tag__size(tag, cu);
> +		if (size == 0) {
>  			if (encoder->verbose)
> -				fprintf(stderr, "Ignoring zero-sized per-CPU variable '%s'...\n", dwarf_name ?: "<missing name>");
> +				fprintf(stderr, "Ignoring zero-sized variable '%s'...\n", name ?: "<missing name>");
>  			continue;
>  		}
>  
> @@ -2035,13 +1997,14 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>  		}
>  
>  		/*
> -		 * add a BTF_VAR_SECINFO in encoder->percpu_secinfo, which will be added into
> -		 * encoder->types later when we add BTF_VAR_DATASEC.
> +		 * Add the variable to the secinfo for the section it appears in.
> +		 * Later we will generate a BTF_VAR_DATASEC for all any section with
> +		 * an encoded variable.
>  		 */
> -		id = btf_encoder__add_var_secinfo(encoder, id, addr, size);
> +		id = btf_encoder__add_var_secinfo(encoder, shndx, id, addr, size);
>  		if (id < 0) {
>  			fprintf(stderr, "error: failed to encode section info for variable '%s' at addr 0x%" PRIx64 "\n",
> -			        name, addr);
> +				name, addr);
>  			goto out;
>  		}
>  	}
> @@ -2068,7 +2031,6 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>  
>  		encoder->force		 = conf_load->btf_encode_force;
>  		encoder->gen_floats	 = conf_load->btf_gen_floats;
> -		encoder->skip_encoding_vars = conf_load->skip_encoding_btf_vars;
>  		encoder->skip_encoding_decl_tag	 = conf_load->skip_encoding_btf_decl_tag;
>  		encoder->tag_kfuncs	 = conf_load->btf_decl_tag_kfuncs;
>  		encoder->gen_distilled_base = conf_load->btf_gen_distilled_base;
> @@ -2076,6 +2038,11 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>  		encoder->has_index_type  = false;
>  		encoder->need_index_type = false;
>  		encoder->array_index_id  = 0;
> +		encoder->encode_vars = 0;
> +		if (!conf_load->skip_encoding_btf_vars)
> +			encoder->encode_vars |= BTF_VAR_PERCPU;
> +		if (conf_load->encode_btf_global_vars)
> +			encoder->encode_vars |= BTF_VAR_GLOBAL;
>  
>  		GElf_Ehdr ehdr;
>  
> @@ -2085,8 +2052,6 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>  			goto out_delete;
>  		}
>  
> -		encoder->is_rel = ehdr.e_type == ET_REL;
> -
>  		switch (ehdr.e_ident[EI_DATA]) {
>  		case ELFDATA2LSB:
>  			btf__set_endianness(encoder->btf, BTF_LITTLE_ENDIAN);
> @@ -2127,15 +2092,21 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>  			encoder->secinfo[shndx].addr = shdr.sh_addr;
>  			encoder->secinfo[shndx].sz = shdr.sh_size;
>  			encoder->secinfo[shndx].name = secname;
> -
> -			if (strcmp(secname, PERCPU_SECTION) == 0)
> -				encoder->percpu.shndx = shndx;
> +			encoder->secinfo[shndx].type = shdr.sh_type;
> +			if (encoder->encode_vars & BTF_VAR_GLOBAL)
> +				encoder->secinfo[shndx].include = true;
> +
> +			if (strcmp(secname, PERCPU_SECTION) == 0) {
> +				encoder->percpu_shndx = shndx;
> +				if (encoder->encode_vars & BTF_VAR_PERCPU)
> +					encoder->secinfo[shndx].include = true;
> +			}
>  		}
>  
> -		if (!encoder->percpu.shndx && encoder->verbose)
> +		if (!encoder->percpu_shndx && encoder->verbose)
>  			printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->filename, PERCPU_SECTION);
>  
> -		if (btf_encoder__collect_symbols(encoder, !encoder->skip_encoding_vars))
> +		if (btf_encoder__collect_symbols(encoder))
>  			goto out_delete;
>  
>  		if (encoder->verbose)
> @@ -2156,7 +2127,8 @@ void btf_encoder__delete(struct btf_encoder *encoder)
>  		return;
>  
>  	btf_encoders__delete(encoder);
> -	__gobuffer__delete(&encoder->percpu_secinfo);
> +	for (int i = 0; i < encoder->seccnt; i++)
> +		__gobuffer__delete(&encoder->secinfo[i].secinfo);
>  	zfree(&encoder->filename);
>  	zfree(&encoder->source_filename);
>  	btf__free(encoder->btf);
> @@ -2166,9 +2138,6 @@ void btf_encoder__delete(struct btf_encoder *encoder)
>  	encoder->functions.allocated = encoder->functions.cnt = 0;
>  	free(encoder->functions.entries);
>  	encoder->functions.entries = NULL;
> -	encoder->percpu.allocated = encoder->percpu.var_cnt = 0;
> -	free(encoder->percpu.vars);
> -	encoder->percpu.vars = NULL;
>  
>  	free(encoder);
>  }
> @@ -2321,7 +2290,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
>  			goto out;
>  	}
>  
> -	if (!encoder->skip_encoding_vars)
> +	if (encoder->encode_vars)
>  		err = btf_encoder__encode_cu_variables(encoder);
>  
>  	/* It is only safe to delete this CU if we have not stashed any static
> diff --git a/btf_encoder.h b/btf_encoder.h
> index f54c95a..5e4d53a 100644
> --- a/btf_encoder.h
> +++ b/btf_encoder.h
> @@ -16,7 +16,15 @@ struct btf;
>  struct cu;
>  struct list_head;
>  
> +/* Bit flags specifying which kinds of variables are emitted */
> +enum btf_var_option {
> +	BTF_VAR_NONE = 0,
> +	BTF_VAR_PERCPU = 1,
> +	BTF_VAR_GLOBAL = 2,
> +};
> +
>  struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool verbose, struct conf_load *conf_load);
> +
>  void btf_encoder__delete(struct btf_encoder *encoder);
>  
>  int btf_encoder__encode(struct btf_encoder *encoder);
> diff --git a/dwarves.h b/dwarves.h
> index 0fede91..fef881f 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -92,6 +92,7 @@ struct conf_load {
>  	bool			btf_gen_optimized;
>  	bool			skip_encoding_btf_inconsistent_proto;
>  	bool			skip_encoding_btf_vars;
> +	bool			encode_btf_global_vars;
>  	bool			btf_gen_floats;
>  	bool			btf_encode_force;
>  	bool			reproducible_build;
> diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
> index 0a9d8ac..4bc2d03 100644
> --- a/man-pages/pahole.1
> +++ b/man-pages/pahole.1
> @@ -230,7 +230,10 @@ the debugging information.
>  
>  .TP
>  .B \-\-skip_encoding_btf_vars
> -Do not encode VARs in BTF.
> +.TQ
> +.B \-\-encode_btf_global_vars
> +By default, VARs are encoded only for percpu variables. These options allow
> +to skip encoding them, or alternatively to encode all global variables too.
>  
>  .TP
>  .B \-\-skip_encoding_btf_decl_tag
> @@ -296,7 +299,8 @@ Encode BTF using the specified feature list, or specify 'default' for all standa
>  	encode_force       Ignore invalid symbols when encoding BTF; for example
>  	                   if a symbol has an invalid name, it will be ignored
>  	                   and BTF encoding will continue.
> -	var                Encode variables using BTF_KIND_VAR in BTF.
> +	var                Encode percpu variables using BTF_KIND_VAR in BTF.
> +	global_var         Encode all global variables in the same way.

hi,
I tried to test this but I'm not getting DATASEC sections in the BTF,
is the change below enough to enable this in kernel build?

thanks,
jirka


---
diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index b75f09f3f424..c88d9e526426 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -19,7 +19,7 @@ pahole-flags-$(call test-ge, $(pahole-ver), 125)	+= --skip_encoding_btf_inconsis
 else
 
 # Switch to using --btf_features for v1.26 and later.
-pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs
+pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs,global_var
 
 ifneq ($(KBUILD_EXTMOD),)
 module-pahole-flags-$(call test-ge, $(pahole-ver), 126) += --btf_features=distilled_base

