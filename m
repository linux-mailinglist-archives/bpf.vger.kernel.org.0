Return-Path: <bpf+bounces-18507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3A381B059
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 09:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2A0328566C
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 08:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C3A168D3;
	Thu, 21 Dec 2023 08:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUrnWPrA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EA4156D6
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 08:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-54c77e0835bso646089a12.2
        for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 00:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703147723; x=1703752523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k/egtQUfhnH8HhwF4ZJdZxXBgbO9sY0ZJxQtjF0wxek=;
        b=HUrnWPrARDBwc6f4Ie2r6dANs+1BIj3u7WL41jHispUawPjhWqiq/6zAV9z8Fnx1Pa
         RdkFeM8sHzUpGGOdkzy6CKjc+R4iy8LDrwnZkF2AU2hKRf94k0hfAPfZASb3sr1SXIsg
         Uw/ZZng+aryrC0iJ+7+J8DBrRDBssbS1EiMpfdgc5/OzXIQRyIU5CKOKzAVmJFKIEfVv
         BzWcBx3l15kB/pW+kewpZRs0DdZpsyFqqyDHukUN6zmFocSJ51JgG+F4QcueXnp2QBVA
         M6+dbLx6jJOFwgGgAJpvaFro2/jdClTt16dQHSIvaUHEYsA7fa5hiVDEZr7K1pbVnZO+
         Fvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703147723; x=1703752523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/egtQUfhnH8HhwF4ZJdZxXBgbO9sY0ZJxQtjF0wxek=;
        b=b/DGXgPs2E/uqXeZDsT8FwlfqidvBH8VGjC0NRJFxuAKHqyT+9zA6fO+BOnmml4COZ
         tpnopC/1OZTmdHrzkTfdfo9hMADtwiMTEK82OwhSUe55YK+2dvZUtg6GiqLTbtaI3IZX
         sulp969B8AsKwvfdmoohptBkuBNkIjXzE4J2hTQ+6/nBF0fDr5pLHLPVYre+qF7OW49M
         L84orDhLQdxYRtB8XKrN3pFZ3mMIzn4QW9kXlNYG8StFxjVIyFvvrCIKq22detsWWY1+
         pjiYx/aZ+PL8RCbHn3A/DCeL9VJGakD6s+XeV21A2jJnlBBaToLHG34DgmCY0ElFS5Mn
         Hepw==
X-Gm-Message-State: AOJu0Yz4f2Wp0djriKljnPfsMLmLV3Dm3zWT5dYfeq27dbSONteP5vvl
	3gX9d/C8cSgreZIQ2LLdILk=
X-Google-Smtp-Source: AGHT+IEBCIrx3tlp3bZr0BgPAQxv3C7yhzOjSICYArmw/xB1EB/ykLiL2jQM7/8lDDyeWFJP7ihZuw==
X-Received: by 2002:a17:906:2dc5:b0:a26:89fc:1904 with SMTP id h5-20020a1709062dc500b00a2689fc1904mr1644989eji.5.1703147722478;
        Thu, 21 Dec 2023 00:35:22 -0800 (PST)
Received: from krava ([83.240.62.111])
        by smtp.gmail.com with ESMTPSA id w6-20020a170906480600b00a2693a66d03sm692415ejq.160.2023.12.21.00.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 00:35:22 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 21 Dec 2023 09:35:20 +0100
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: acme@kernel.org, quentin@isovalent.com, andrii.nakryiko@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves] pahole: Inject kfunc decl tags into BTF
Message-ID: <ZYP4yK4qg2iJfTSx@krava>
References: <421d18942d6ad28625530a8b3247595dc05eb100.1703110747.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421d18942d6ad28625530a8b3247595dc05eb100.1703110747.git.dxu@dxuuu.xyz>

On Wed, Dec 20, 2023 at 03:19:52PM -0700, Daniel Xu wrote:
> This commit teaches pahole to parse symbols in .BTF_ids section in
> vmlinux and discover exported kfuncs. Pahole then takes the list of
> kfuncs and injects a BTF_KIND_DECL_TAG for each kfunc.
> 
> This enables downstream users and tools to dynamically discover which
> kfuncs are available on a system by parsing vmlinux or module BTF, both
> available in /sys/kernel/btf.
> 
> Example of encoding:
> 
>         $ bpftool btf dump file .tmp_vmlinux.btf | rg DECL_TAG | wc -l
>         388
> 
>         $ bpftool btf dump file .tmp_vmlinux.btf | rg 68940
>         [68940] FUNC 'bpf_xdp_get_xfrm_state' type_id=68939 linkage=static
>         [128124] DECL_TAG 'kfunc' type_id=68940 component_idx=-1
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>

SNIP

> +
> +static int btf_encoder__tag_kfunc(struct btf_encoder *encoder, const char *kfunc)
> +{
> +	int nr_types, type_id, err = -1;
> +	struct btf *btf = encoder->btf;

could we store the kuncs in sorted array (by name) and iterate all IDs
just once while doing the bsearch for the name over the kfuncs array

> +
> +	nr_types = btf__type_cnt(btf);
> +	for (type_id = 1; type_id < nr_types; type_id++) {
> +		const struct btf_type *type;
> +		const char *name;
> +
> +		type = btf__type_by_id(btf, type_id);
> +		if (!type) {
> +			fprintf(stderr, "%s: malformed BTF, can't resolve type for ID %d\n",
> +				__func__, type_id);
> +			goto out;
> +		}
> +
> +		if (!btf_is_func(type))
> +			continue;
> +
> +		name = btf__name_by_offset(btf, type->name_off);
> +		if (!name) {
> +			fprintf(stderr, "%s: malformed BTF, can't resolve name for ID %d\n",
> +				__func__, type_id);
> +			goto out;
> +		}
> +
> +		if (strcmp(name, kfunc))
> +		    continue;
> +
> +		err = btf__add_decl_tag(btf, BTF_KFUNC_TYPE_TAG, type_id, -1);
> +		if (err < 0) {
> +			fprintf(stderr, "%s: failed to insert kfunc decl tag for '%s': %d\n",
> +				__func__, kfunc, err);
> +			goto out;
> +		}
> +
> +		err = 0;
> +		break;
> +	}
> +
> +out:
> +	return err;
> +}
> +
> +static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
> +{
> +	const char *filename = encoder->filename;
> +	GElf_Shdr shdr_mem, *shdr;
> +	int symbols_shndx = -1;
> +	int idlist_shndx = -1;
> +	Elf_Scn *scn = NULL;
> +	Elf_Data *symbols;
> +	int fd, err = -1;
> +	size_t strtabidx;
> +	Elf *elf = NULL;
> +	size_t strndx;
> +	char *secname;
> +	int nr_syms;
> +	int i = 0;
> +
> +	fd = open(filename, O_RDONLY);
> +	if (fd < 0) {
> +		fprintf(stderr, "Cannot open %s\n", filename);
> +		goto out;
> +	}
> +
> +	if (elf_version(EV_CURRENT) == EV_NONE) {
> +		elf_error("Cannot set libelf version");
> +		goto out;
> +	}
> +
> +	elf = elf_begin(fd, ELF_C_READ, NULL);
> +	if (elf == NULL) {
> +		elf_error("Cannot update ELF file");
> +		goto out;
> +	}

SNIP

> +		}
> +		free(kfunc);
> +	}
> +
> +	err = 0;
> +out:

leaking fd and elf object (elf_end)

jirka

> +	return err;
> +}
> +
>  int btf_encoder__encode(struct btf_encoder *encoder)
>  {
>  	int err;
> @@ -1366,6 +1563,11 @@ int btf_encoder__encode(struct btf_encoder *encoder)
>  	if (btf__type_cnt(encoder->btf) == 1)
>  		return 0;
>  
> +	if (btf_encoder__tag_kfuncs(encoder)) {
> +		fprintf(stderr, "%s: failed to tag kfuncs!\n", __func__);
> +		return -1;
> +	}
> +
>  	if (btf__dedup(encoder->btf, NULL)) {
>  		fprintf(stderr, "%s: btf__dedup failed!\n", __func__);
>  		return -1;
> -- 
> 2.42.1
> 

