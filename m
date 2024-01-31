Return-Path: <bpf+bounces-20813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBF8843C0C
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 11:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC4C71F2E1DA
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 10:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F060669D3A;
	Wed, 31 Jan 2024 10:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mP47x4tn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921A169DE7
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 10:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706696249; cv=none; b=sbis+gFdfwz/Vf2X5oD6cRaRQqeE/8e2pOpmaalmmobR27PBYqU+cqCfGWhQYTwITl3SttItdWenWgM5pTamblnB2whrv0bnsJmdXDRKGOW4glxR75WH3UG0WXh25CnaIdMU8vD7CkRYCewi5e4fgsbvR8nVC4ZK5fymVuXIw6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706696249; c=relaxed/simple;
	bh=yUuz6hebVSeXiFkSKnqASjz3I83BWvGCzggabipw4cs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2PctjXOIkT6qpnUG2RJS2OYsXgJXsNcekZFlMCDM+OBCdFwlQ5JSWFoPZ/UEldTZ49ViOY7Dehtdd12UpYdWfhXJfWXiD0BHFGjb6kML+5pXKCyRigUmWbyUIl1VoJJINRUkPBCbNhJ2fsty9GBz3UK0kQyAsZ1T+/UcyuSWD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mP47x4tn; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a318ccfe412so460651866b.1
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 02:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706696246; x=1707301046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0em8U0+0sl6De9HDgjEakS243y8mn+HEizRX4jBipog=;
        b=mP47x4tnvnnRnLSIJK9yuicMY9LN8SxTr55B2WY7lyvfkTzdryhgYN6RtCuj313buf
         qz82Rt7rW5sn1Hh4V0RYnj1D8DReIU+abhgDAoIizYcQr08Cw/8rStsTKoWnq2dNUE9h
         ft4/TCWiHbTZzl9454weZUB/0EvQLbLYbU4uKMJGrcPN2Qa8lM8zD7rqgNYUNgMTxpPF
         QB2bSLHno7La6Xw6/crpGh1qN6Crwn6HhKQqQvEhCHRA15JydqS/2Cj53HcS3l2IcYnL
         A5QrwA/lTX0Y8e1XUjR5oKEoVpj6m8Ru6hAH1Ph+hOrNPfoBUMe/SZ5bZkCBHCjiu+F1
         Gz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706696246; x=1707301046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0em8U0+0sl6De9HDgjEakS243y8mn+HEizRX4jBipog=;
        b=hWV3xKmhY0I33jSVFpbiMaRVzcIWdRnSKrDg1K5mstWdn6TgbxlCqVLcRz0cPkmqlL
         dj76FpPP0xWKP4lwarGACRZ/ye//919XjMjgAgWrpYtX3Ar24HD1OZWSeYrOmBQhfH5a
         nzWoOFVuekkEoDey3WjE33Svd99UpAkqxUSV0TwK7yp+lnyiX15uI8XKgjkB/9hrrlZJ
         R70yxLdc42Rhx148vSYMu3UprhDHcI+Us2t+g8iQ4FCjkrgRyUybTzFDAzqD5//u9HoL
         nLfLGHuH9bxFj966uIWucS++u1c5ukTAj0eaml5JM6TLPBcrEP8fbabSqjwmYOi6gPj7
         o0pg==
X-Gm-Message-State: AOJu0YwrNUYawl7fwqnz85uAUC6n2OlRUkihJ3WUJz677ap3//ZXU3pu
	i83qI8gOAUwRBP2pi5ggBBbGBO/hNCLJY/RE2JcoX9w/q6ooLWMW
X-Google-Smtp-Source: AGHT+IHt+xwJs1YtbjDk1NtAjOtpmDY1ZLfyc8gV2zOeOomn+NRfZT6NLkpbmGTFf2K2i+VJpUABOQ==
X-Received: by 2002:a17:906:1b16:b0:a2d:9c52:bc2 with SMTP id o22-20020a1709061b1600b00a2d9c520bc2mr815938ejg.18.1706696245516;
        Wed, 31 Jan 2024 02:17:25 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVSKrL4HlEJO1owEmRxHf5jGrz1aCM9LrTj7Jhidomw0wzNaD7HjLAaViiZdsq8kgNLRssQfhVBBYCyR9DlNLhuXDbUuoK2vCbKxYYZUSE7/SD3vZ2aetFceT2opGYhbvuJuGAuZfmshVz6BtCeVESx8n8i1OqJYG843oy6LaK+KH2JOVy95vaCaBZHhymtMc5hSzH8p814dsYhDQ==
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id r26-20020a170906c29a00b00a35cb514aaesm2904715ejz.82.2024.01.31.02.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 02:17:25 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 31 Jan 2024 11:17:23 +0100
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: acme@kernel.org, quentin@isovalent.com, andrii.nakryiko@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v3] pahole: Inject kfunc decl tags into BTF
Message-ID: <ZboeMyIvGChjaBLY@krava>
References: <0f25134ec999e368478c4ca993b3b729c2a03383.1706491733.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f25134ec999e368478c4ca993b3b729c2a03383.1706491733.git.dxu@dxuuu.xyz>

On Sun, Jan 28, 2024 at 06:30:19PM -0700, Daniel Xu wrote:
> This commit teaches pahole to parse symbols in .BTF_ids section in
> vmlinux and discover exported kfuncs. Pahole then takes the list of
> kfuncs and injects a BTF_KIND_DECL_TAG for each kfunc.
> 
> Example of encoding:
> 
>         $ bpftool btf dump file .tmp_vmlinux.btf | rg "DECL_TAG 'bpf_kfunc'" | wc -l
>         121
> 
>         $ bpftool btf dump file .tmp_vmlinux.btf | rg 56337
>         [56337] FUNC 'bpf_ct_change_timeout' type_id=56336 linkage=static
>         [127861] DECL_TAG 'bpf_kfunc' type_id=56337 component_idx=-1
> 
> This enables downstream users and tools to dynamically discover which
> kfuncs are available on a system by parsing vmlinux or module BTF, both
> available in /sys/kernel/btf.
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> 
> ---
> Changes from v2:
> * More reliably detect kfunc membership in set8 by tracking set addr ranges
> * Rename some variables/functions to be more clear about kfunc vs func
> 
> Changes from v1:
> * Fix resource leaks
> * Fix callee -> caller typo
> * Rename btf_decl_tag from kfunc -> bpf_kfunc
> * Only grab btf_id_set funcs tagged kfunc
> * Presort btf func list
> 
>  btf_encoder.c | 347 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 347 insertions(+)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index fd04008..4f742b1 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -34,6 +34,11 @@
>  #include <pthread.h>
>  
>  #define BTF_ENCODER_MAX_PROTO	512
> +#define BTF_IDS_SECTION		".BTF_ids"
> +#define BTF_ID_FUNC_PFX		"__BTF_ID__func__"
> +#define BTF_ID_SET8_PFX		"__BTF_ID__set8__"
> +#define BTF_SET8_KFUNCS		(1 << 0)
> +#define BTF_KFUNC_TYPE_TAG	"bpf_kfunc"
>  
>  /* state used to do later encoding of saved functions */
>  struct btf_encoder_state {
> @@ -79,6 +84,7 @@ struct btf_encoder {
>  			  gen_floats,
>  			  is_rel;
>  	uint32_t	  array_index_id;
> +	struct gobuffer   btf_funcs;

why does this need to be stored in encoder?

>  	struct {
>  		struct var_info vars[MAX_PERCPU_VAR_CNT];
>  		int		var_cnt;
> @@ -94,6 +100,17 @@ struct btf_encoder {
>  	} functions;
>  };
>  

SNIP

> +/* Returns if `sym` points to a kfunc set */
> +static int is_sym_kfunc_set(GElf_Sym *sym, const char *name, Elf_Data *idlist, size_t idlist_addr)
> +{
> +	int *ptr = idlist->d_buf;
> +	int idx, flags;
> +	bool is_set8;
> +
> +	/* kfuncs are only found in BTF_SET8's */
> +	is_set8 = !strncmp(name, BTF_ID_SET8_PFX, sizeof(BTF_ID_SET8_PFX) - 1);
> +	if (!is_set8)
> +		return false;
> +
> +	idx = sym->st_value - idlist_addr;
> +	if (idx >= idlist->d_size) {
> +		fprintf(stderr, "%s: symbol '%s' out of bounds\n", __func__, name);
> +		return false;
> +	}
> +
> +	/* Check the set8 flags to see if it was marked as kfunc */
> +	idx = idx / sizeof(int);
> +	flags = ptr[idx + 1];
> +	return flags & BTF_SET8_KFUNCS;

I wonder it'd be easier to read/follow if we bring struct btf_id_set8
declaration in here and use it to get the flags field

> +}
> +
> +/*
> + * Parse BTF_ID symbol and return the func name.
> + *
> + * Returns:
> + *	Caller-owned string containing func name if successful.
> + *	NULL if !func or on error.
> + */
> +

SNIP

> +	/* Cannot resolve symbol or .BTF_ids sections. Nothing to do. */
> +	if (symbols_shndx == -1 || idlist_shndx == -1) {
> +		err = 0;
> +		goto out;
> +	}
> +
> +	if (!gelf_getshdr(symscn, &shdr)) {
> +		elf_error("Failed to get ELF symbol table header");
> +		goto out;
> +	}
> +	nr_syms = shdr.sh_size / shdr.sh_entsize;
> +
> +	err = btf_encoder__collect_btf_funcs(encoder);
> +	if (err) {
> +		fprintf(stderr, "%s: failed to collect BTF funcs\n", __func__);
> +		goto out;
> +	}
> +
> +	/* First collect all kfunc set ranges.
> +	 *
> +	 * Note we choose not to sort these ranges and accept a linear
> +	 * search when doing lookups. Reasoning is that the number of
> +	 * sets is ~O(100) and not worth the additional code to optimize.
> +	 */

I think we could event add gobuffer interface/support to sort and search
quickly the data (we use it in other place), but that can be done as follow
up when it will become a problem as you pointed out

> +	for (i = 0; i < nr_syms; i++) {
> +		struct btf_kfunc_set_range range = {};
> +		const char *name;
> +		GElf_Sym sym;
> +
> +		if (!gelf_getsym(symbols, i, &sym)) {
> +			elf_error("Failed to get ELF symbol(%d)", i);
> +			goto out;
> +		}
> +
> +		if (sym.st_shndx != idlist_shndx)
> +			continue;
> +
> +		name = elf_strptr(elf, strtabidx, sym.st_name);
> +		if (!is_sym_kfunc_set(&sym, name, idlist, idlist_addr))
> +			continue;
> +
> +		range.start = sym.st_value;
> +		range.end = sym.st_value + sym.st_size;
> +		gobuffer__add(&btf_kfunc_ranges, &range, sizeof(range));
> +	}
> +
> +	/* Now inject BTF with kfunc decl tag for detected kfuncs */
> +	for (i = 0; i < nr_syms; i++) {
> +		const struct btf_kfunc_set_range *ranges;
> +		unsigned int ranges_cnt;
> +		char *func, *name;
> +		GElf_Sym sym;
> +		bool found;
> +		int err;
> +		int j;
> +
> +		if (!gelf_getsym(symbols, i, &sym)) {
> +			elf_error("Failed to get ELF symbol(%d)", i);
> +			goto out;
> +		}
> +
> +		if (sym.st_shndx != idlist_shndx)
> +			continue;
> +
> +		name = elf_strptr(elf, strtabidx, sym.st_name);
> +		func = get_func_name(name);
> +		if (!func)
> +			continue;
> +
> +		/* Check if function belongs to a kfunc set */
> +		ranges = gobuffer__entries(&btf_kfunc_ranges);
> +		ranges_cnt = gobuffer__nr_entries(&btf_kfunc_ranges);
> +		found = false;
> +		for (j = 0; j < ranges_cnt; j++) {
> +			size_t addr = sym.st_value;

missing newline after declaration

> +			if (ranges[j].start <= addr && addr < ranges[j].end) {
> +				found = true;
> +				break;
> +			}
> +		}
> +		if (!found)

leaking func

jirka

> +			continue;
> +
> +		err = btf_encoder__tag_kfunc(encoder, func);
> +		if (err) {
> +			fprintf(stderr, "%s: failed to tag kfunc '%s'\n", __func__, func);
> +			free(func);
> +			goto out;
> +		}
> +		free(func);
> +	}
> +
> +	err = 0;
> +out:
> +	__gobuffer__delete(&btf_kfunc_ranges);
> +	if (elf)
> +		elf_end(elf);
> +	if (fd != -1)
> +		close(fd);
> +	return err;
> +}
> +
>  int btf_encoder__encode(struct btf_encoder *encoder)
>  {
>  	int err;
> @@ -1366,6 +1704,14 @@ int btf_encoder__encode(struct btf_encoder *encoder)
>  	if (btf__type_cnt(encoder->btf) == 1)
>  		return 0;
>  
> +	/* Note vmlinux may already contain btf_decl_tag's for kfuncs. So
> +	 * take care to call this before btf_dedup().
> +	 */
> +	if (btf_encoder__tag_kfuncs(encoder)) {
> +		fprintf(stderr, "%s: failed to tag kfuncs!\n", __func__);
> +		return -1;
> +	}
> +
>  	if (btf__dedup(encoder->btf, NULL)) {
>  		fprintf(stderr, "%s: btf__dedup failed!\n", __func__);
>  		return -1;
> @@ -1712,6 +2058,7 @@ void btf_encoder__delete(struct btf_encoder *encoder)
>  
>  	btf_encoders__delete(encoder);
>  	__gobuffer__delete(&encoder->percpu_secinfo);
> +	__gobuffer__delete(&encoder->btf_funcs);
>  	zfree(&encoder->filename);
>  	btf__free(encoder->btf);
>  	encoder->btf = NULL;
> -- 
> 2.42.1
> 

