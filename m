Return-Path: <bpf+bounces-45935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D76A9E041C
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 14:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1D582825AA
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 13:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F82F202F9E;
	Mon,  2 Dec 2024 13:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSOMsu+s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB474201265;
	Mon,  2 Dec 2024 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733147758; cv=none; b=m+rleTmRH+RHfG3ep/xgPasFFYbEbEw4RpzA8sFztCnB4E1vymuAWsLUiZ90wNrpYdzfY2guN66Oy9leJ28LZ9O0leVB8LmzD/Wz3Nu9Q/k8HyZBj9DkrEMgqDFXpWytq3R1sVIrzs1AzNa984YDEIbLn/vZ+eaoT+NMgUwyzA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733147758; c=relaxed/simple;
	bh=jBFtkxNV/SeGmQPXnVgoHAyuVLdE0fNIsFyD0DlTDFY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyS8WNWKcLskyCWErgjgUoV4z6zXMwH+ES4wDwuv3THY0jEMiFdYMZmJ/Fdk5R41VkMe9lv9Z9DPlE3vNft/EmiUPjiUiPnpHPliOvickoE6XFVNE0/gE1HGt9aHmdWXEJWOQWHorC7f7EeeQiZPS4gs9Lb09HPMgrBou4VxWO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSOMsu+s; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa5500f7a75so697033166b.0;
        Mon, 02 Dec 2024 05:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733147755; x=1733752555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Heuwt48jt97EbY1jCS6nEuveU51+h9FQyBFv0IgStX8=;
        b=aSOMsu+sPLyGerHjEHdyBEarQS260L6l52OYJEY0HRLmNqVgbANl8aKsiHadobry2z
         oKu0OozCzz3Xqs3D2TKB7B8P6CiglIxx9UNOfXvNCNOmysT5yP9HrK2p9mXbm9miHbLk
         ky68mR/D1ImkikhpnZ0h/+6+PZRx6dbxa+F94WSYS6q8AjOT9ij5MjjNK+atdTBI5mZG
         aiPnBgomG57adAUxR4sC0/LpzVcbtKarwoi0/Js7qMZzwmZdWsJJdjkt4nXwBubFaSdI
         KL9/q++8x3wR8oTUx8RAo0N6HNrbMFYHeJd7YZa5qxXoQerwy+K2fWJvvBoq71IdQKdR
         2ueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733147755; x=1733752555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Heuwt48jt97EbY1jCS6nEuveU51+h9FQyBFv0IgStX8=;
        b=AWEn4yNxfxpHm0QifhQ+TglnnKuWjtvs+lqWdO79HvGPvVQ7OiV/vM+tcK5ng6GGhm
         +MTELZvSIPQa8GSaxrlqUFHJj8P7yxF71Ja7Zbw70PT6+YYAjTro1VqGkMhhO8WjD1Sn
         xAb7+eBdvB5SnIwWcXmWG+/wBL1+PIgcAnVuKtS44SolGsevjwJlOScuyouXE2WvZl2K
         aypVZlEqW8KWdtFug4yzqdIoFq9OFR1CZybsaysnKtaArIeyAwffI/yd2XkyW6AQgmEA
         qnUSSp2UvKk+2T+kdkBkgjIyHC1ixD6xosbFvGrbVQuu85rvfPvExtGgMQod63qq3l0Z
         0Bfg==
X-Forwarded-Encrypted: i=1; AJvYcCV+Uw9G+sY1YBnOeyjkFP28gftSRCNZKcksJ+5dKFOafBLajToT0YrVstUpTtSH2FUSaDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCYRQZ1Be+GxQUBnlVIwqDsFRzrvFZ23DI3XsyVS4iGW+g609e
	PhANTIA4pfuEJUYRynLOFVMaDsgCXm4u2xQEYWNCtO27K0YTBpkN
X-Gm-Gg: ASbGncvph90Jcd7sEPsQj0XOCzOZ9OOD+7SbgI37ihlVECG2Y0e8T9RnAfBuFDlz5Dt
	cpDN2YpVQ4daazx25LKekXyLbn59DzMcHmEfVR1c3XlAALQIuDOZwNbKDepvzV/lq3c9F/nsz5I
	PMd6s455Zv1cAwdpVkdVfZveLbFa8HHQHXnqMOAjeRTzbBArv9qml4EYBxsGqj8kzWaXPsq8WSL
	qKtgvcDYiKsxmm+V8qxXyNL6zU9NODH/gv3RnRAk0HWvEpx6N2cQaV+zAsRC377Koohc8Hy1xVC
	AuRjuqUzxIdNVdtQHgnd0vs=
X-Google-Smtp-Source: AGHT+IGb//ZqyWFk+mdOfp75/B8BxcU+ZLDX6uoBbDe/+GQGxbsc6TsUOskXrvIkDodFUvJSzNYAiA==
X-Received: by 2002:a17:907:7751:b0:aa1:f9dc:f9bf with SMTP id a640c23a62f3a-aa580eee484mr2157104366b.10.1733147754832;
        Mon, 02 Dec 2024 05:55:54 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996c0ed4sm513599266b.30.2024.12.02.05.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 05:55:54 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 2 Dec 2024 14:55:52 +0100
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, acme@kernel.org, bpf@vger.kernel.org,
	alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org,
	mykolal@fb.com
Subject: Re: [RFC PATCH 1/9] btf_encoder: simplify function encoding
Message-ID: <Z028aH1rFOGbCEnD@krava>
References: <20241128012341.4081072-1-ihor.solodrai@pm.me>
 <20241128012341.4081072-2-ihor.solodrai@pm.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128012341.4081072-2-ihor.solodrai@pm.me>

On Thu, Nov 28, 2024 at 01:23:49AM +0000, Ihor Solodrai wrote:
> From: Alan Maguire <alan.maguire@oracle.com>
> 
> Currently we have two modes of function encoding; one adds functions
> based upon the first instance found and ignores inconsistent
> representations.  The second saves function representations and later
> finds inconsistencies.  The mode chosen is determined by
> conf_load->skip_encoding_btf_inconsistent_proto.
> 
> The knock-on effect is that we need to support two modes in
> btf_encoder__add_func(); one for each case.  Simplify by using
> the "save function" approach for both cases; only difference is
> that we allow inconsistent representations if
> skip_encoding_btf_inconsistent_proto is not set (it is set by default
> for upstream kernels and has been for a while).
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  btf_encoder.c | 79 +++++++++++++++++----------------------------------
>  1 file changed, 26 insertions(+), 53 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index e1adddf..98e4d7d 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -88,7 +88,6 @@ struct btf_encoder_func_state {
>  struct elf_function {
>  	const char	*name;
>  	char		*alias;
> -	bool		 generated;
>  	size_t		prefixlen;
>  	struct btf_encoder_func_state state;
>  };
> @@ -120,6 +119,7 @@ struct btf_encoder {
>  			  force,
>  			  gen_floats,
>  			  skip_encoding_decl_tag,
> +			  skip_encoding_inconsistent_proto,
>  			  tag_kfuncs,
>  			  gen_distilled_base;
>  	uint32_t	  array_index_id;
> @@ -1165,18 +1165,18 @@ out:
>  	return err;
>  }
>  
> -static int32_t btf_encoder__add_func(struct btf_encoder *encoder, struct function *fn,
> +static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
>  				     struct elf_function *func)
>  {
> +	struct btf_encoder_func_state *state = &func->state;
>  	int btf_fnproto_id, btf_fn_id, tag_type_id = 0;
>  	int16_t component_idx = -1;
>  	const char *name;
>  	const char *value;
>  	char tmp_value[KSYM_NAME_LEN];
> +	uint16_t idx;
>  
> -	assert(fn != NULL || func != NULL);
> -
> -	btf_fnproto_id = btf_encoder__add_func_proto(encoder, fn ? &fn->proto : NULL, func);
> +	btf_fnproto_id = btf_encoder__add_func_proto(encoder, NULL, func);
>  	name = func->alias ?: func->name;
>  	if (btf_fnproto_id >= 0)
>  		btf_fn_id = btf_encoder__add_ref_type(encoder, BTF_KIND_FUNC, btf_fnproto_id,
> @@ -1186,40 +1186,23 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder, struct functio
>  		       name, btf_fnproto_id < 0 ? "proto" : "func");
>  		return -1;
>  	}
> -	if (!fn) {
> -		struct btf_encoder_func_state *state = &func->state;
> -		uint16_t idx;
> -
> -		if (state->nr_annots == 0)
> -			return 0;
> +	if (state->nr_annots == 0)
> +		return 0;
>  
> -		for (idx = 0; idx < state->nr_annots; idx++) {
> -			struct btf_encoder_func_annot *a = &state->annots[idx];
> +	for (idx = 0; idx < state->nr_annots; idx++) {
> +		struct btf_encoder_func_annot *a = &state->annots[idx];
>  
> -			value = btf__str_by_offset(encoder->btf, a->value);
> -			/* adding BTF data may result in a mode of the
> -			 * value string memory, so make a temporary copy.
> -			 */
> -			strncpy(tmp_value, value, sizeof(tmp_value) - 1);
> -			component_idx = a->component_idx;
> -
> -			tag_type_id = btf_encoder__add_decl_tag(encoder, tmp_value,
> -								btf_fn_id, component_idx);
> -			if (tag_type_id < 0)
> -				break;
> -		}
> -	} else {
> -		struct llvm_annotation *annot;
> -
> -		list_for_each_entry(annot, &fn->annots, node) {
> -			value = annot->value;
> -			component_idx = annot->component_idx;
> +		value = btf__str_by_offset(encoder->btf, a->value);
> +		/* adding BTF data may result in a mode of the
> +		 * value string memory, so make a temporary copy.
> +		 */
> +		strncpy(tmp_value, value, sizeof(tmp_value) - 1);
> +		component_idx = a->component_idx;
>  
> -			tag_type_id = btf_encoder__add_decl_tag(encoder, value, btf_fn_id,
> -								component_idx);
> -			if (tag_type_id < 0)
> -				break;
> -		}
> +		tag_type_id = btf_encoder__add_decl_tag(encoder, tmp_value,
> +							btf_fn_id, component_idx);
> +		if (tag_type_id < 0)
> +			break;
>  	}
>  	if (tag_type_id < 0) {
>  		fprintf(stderr,
> @@ -1277,8 +1260,9 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder)
>  		 * just do not _use_ them.  Only exclude functions with
>  		 * unexpected register use or multiple inconsistent prototypes.
>  		 */
> -		if (!state->unexpected_reg && !state->inconsistent_proto) {
> -			if (btf_encoder__add_func(encoder, NULL, func))
> +		if (!encoder->skip_encoding_inconsistent_proto ||
> +		    (!state->unexpected_reg && !state->inconsistent_proto)) {
> +			if (btf_encoder__add_func(encoder, func))
>  				return -1;
>  		}
>  		state->processed = 1;
> @@ -2339,6 +2323,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>  		encoder->force		 = conf_load->btf_encode_force;
>  		encoder->gen_floats	 = conf_load->btf_gen_floats;
>  		encoder->skip_encoding_decl_tag	 = conf_load->skip_encoding_btf_decl_tag;
> +		encoder->skip_encoding_inconsistent_proto = conf_load->skip_encoding_btf_inconsistent_proto;
>  		encoder->tag_kfuncs	 = conf_load->btf_decl_tag_kfuncs;
>  		encoder->gen_distilled_base = conf_load->btf_gen_distilled_base;
>  		encoder->verbose	 = verbose;
> @@ -2544,7 +2529,6 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
>  
>  	cu__for_each_function(cu, core_id, fn) {
>  		struct elf_function *func = NULL;
> -		bool save = false;
>  
>  		/*
>  		 * Skip functions that:
> @@ -2566,15 +2550,8 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
>  
>  			/* prefer exact function name match... */
>  			func = btf_encoder__find_function(encoder, name, 0);
> -			if (func) {
> -				if (func->generated)
> -					continue;
> -				if (conf_load->skip_encoding_btf_inconsistent_proto)
> -					save = true;
> -				else
> -					func->generated = true;
> -			} else if (encoder->functions.suffix_cnt &&
> -				   conf_load->btf_gen_optimized) {
> +			if (!func && encoder->functions.suffix_cnt &&
> +			    conf_load->btf_gen_optimized) {
>  				/* falling back to name.isra.0 match if no exact
>  				 * match is found; only bother if we found any
>  				 * .suffix function names.  The function
> @@ -2585,7 +2562,6 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
>  				func = btf_encoder__find_function(encoder, name,
>  								  strlen(name));
>  				if (func) {
> -					save = true;
>  					if (encoder->verbose)
>  						printf("matched function '%s' with '%s'%s\n",
>  						       name, func->name,
> @@ -2603,10 +2579,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
>  		if (!func)
>  			continue;
>  
> -		if (save)
> -			err = btf_encoder__save_func(encoder, fn, func);
> -		else
> -			err = btf_encoder__add_func(encoder, fn, func);
> +		err = btf_encoder__save_func(encoder, fn, func);
>  		if (err)
>  			goto out;
>  	}
> -- 
> 2.47.0
> 
> 

