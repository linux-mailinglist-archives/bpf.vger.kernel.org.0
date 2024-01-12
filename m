Return-Path: <bpf+bounces-19460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E82582C363
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 17:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28D16284F7D
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 16:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7321745C2;
	Fri, 12 Jan 2024 16:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSl4rx+7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154F473198
	for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 16:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a28fb463a28so709633066b.3
        for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 08:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705076170; x=1705680970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hmuV5seH1dbVeb9pl0ynaF3sxwCfuU6XNZ21G7d48tA=;
        b=KSl4rx+7nPc9zRNHLSVh2eLT+vbokxyTix/4Et1tUmzybvBykNYmngjh/5VKCVY6fj
         tkZ86+7hQYFHQMWWmqtuSpiH7AnLHA2s/COOw3fFBNx0Wp9v4+yZvOwPltfKMSfbcrMT
         k/CVJlPT3DQhGl9aBbuQsPPFGPA+ay/bVepNE7CZMVjWMAq2kXj+z1shCvuwfVn2QGb2
         2m9wYm2A28qk2Q02zNskrj9IaxgxBtX3+SNk3fGlZtWunb0QTArW+OV+165/+Ngjv9eE
         81xf9+QdPcoWYvV2z/Kij3Ccn2INlYToL5qqYHJi9AjbP0GD3ncNkAHUgxTOfph0gfNZ
         3T3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705076170; x=1705680970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmuV5seH1dbVeb9pl0ynaF3sxwCfuU6XNZ21G7d48tA=;
        b=TygfGgLS8ngm/GEtapuG459fz1958sqU+i4v4drZZydjie37kk8s/1/zi6Z8jptuLs
         sgYqhv+pVpPifJxo/QOoOJHz1LbFV8VA0u4iD9jPQfaBc3UrOv5prUqjofRXUjVUEBwU
         ynGOKaU9qafGBKXZtFz/zQ8N3g37z3DHy3nN3ewgTMMkEWkgj+K9u9mAqt2tSOm3srkM
         PFedGvmZJUbfO3a/zP4iijY22ms+moYglK8ArzWp/tpMVC5K9wFSLJQcyuJmKhZVFD7m
         ywYF9ViELZFsOqJX1PQ+3ucMHvx0rejCqyASsrKUOekorTo6uIlOEG9W9Mqsj2WBT9ac
         Uehw==
X-Gm-Message-State: AOJu0Yy9CKBJZ5Pxun8g+xJVJZxeqVp8oOojuQu+zzSGDAE4F6B15p5s
	tHMybONb9crRVqDR/J4tiwUg85bQDV4=
X-Google-Smtp-Source: AGHT+IFEtPGIvB5StLImxb7KwJsJykiFAMvEslYQPDZjo6YUY5mcQhPutqmSuDeSTAdecHqPehdjcA==
X-Received: by 2002:a17:907:d504:b0:a2c:e1a6:cb31 with SMTP id wb4-20020a170907d50400b00a2ce1a6cb31mr488579ejc.102.1705076170194;
        Fri, 12 Jan 2024 08:16:10 -0800 (PST)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id h16-20020a170906399000b00a28a66028bcsm1951177eje.91.2024.01.12.08.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 08:16:09 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 12 Jan 2024 17:16:07 +0100
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: acme@kernel.org, quentin@isovalent.com, andrii.nakryiko@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v2] pahole: Inject kfunc decl tags into BTF
Message-ID: <ZaFlx89aXd7eEO1P@krava>
References: <85caea4c48659502544329e6cd8b41c12ab50dfc.1704929857.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85caea4c48659502544329e6cd8b41c12ab50dfc.1704929857.git.dxu@dxuuu.xyz>

On Wed, Jan 10, 2024 at 06:14:25PM -0700, Daniel Xu wrote:

SNIP

> +
> +static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
> +{
> +	const char *filename = encoder->filename;
> +	Elf_Scn *symscn = NULL;
> +	int symbols_shndx = -1;
> +	int fd = -1, err = -1;
> +	int idlist_shndx = -1;
> +	Elf_Scn *scn = NULL;
> +	size_t idlist_addr;
> +	Elf_Data *symbols;
> +	Elf_Data *idlist;
> +	size_t strtabidx;
> +	Elf *elf = NULL;
> +	int set_cnt = 0;
> +	GElf_Shdr shdr;
> +	size_t strndx;
> +	char *secname;
> +	int nr_syms;
> +	int i = 0;

smooth ;-)

SNIP

> +
> +	nr_syms = shdr.sh_size / shdr.sh_entsize;
> +	for (i = 0; i < nr_syms; i++) {
> +		char *kfunc, *name;
> +		int new_set_cnt;
> +		GElf_Sym sym;
> +		int err;
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
> +		new_set_cnt = get_kfunc_set_cnt(&sym, name, idlist, idlist_addr);
> +		if (new_set_cnt < 0) {
> +			err = new_set_cnt;
> +			goto out;
> +		} else if (new_set_cnt) {
> +			if (set_cnt)
> +				fprintf(stderr, "%s: warning: overlapping set8 '%s'\n",
> +					__func__, name);
> +			set_cnt = new_set_cnt;
> +			continue;
> +		}
> +
> +		if (!set_cnt)
> +			continue;
> +		set_cnt--;
> +
> +		kfunc = get_kfunc_name(name);
> +		if (!kfunc)
> +			continue;
> +
> +		err = btf_encoder__tag_kfunc(encoder, kfunc);

are .BTF_ids records guaranteed to be sorted by address? so we are
sure that the set will be followed by its records?

I thought we'd need to find size for each set and then check each
.BTF_ids record if it belongs to the set

jirka


> +		if (err) {
> +			fprintf(stderr, "%s: failed to tag kfunc '%s'\n", __func__, kfunc);
> +			free(kfunc);
> +			goto out;
> +		}
> +		free(kfunc);
> +	}
> +
> +	err = 0;
> +out:
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
> @@ -1366,6 +1681,14 @@ int btf_encoder__encode(struct btf_encoder *encoder)
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
> @@ -1712,6 +2035,7 @@ void btf_encoder__delete(struct btf_encoder *encoder)
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

