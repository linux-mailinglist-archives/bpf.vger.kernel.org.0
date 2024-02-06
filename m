Return-Path: <bpf+bounces-21306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEE484B58B
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 13:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B00C1C24A2C
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 12:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EA612FF94;
	Tue,  6 Feb 2024 12:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xb+zLmvN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EE312F5B0
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 12:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707223626; cv=none; b=Thda8t+5DBXJCTsfZj+hbNMxc2Gljpq/sQDOxhvaURdfaQFhNkKYoRlaHZaZUY7RxL/Wk9VPz8bqLZ5xEruEKOHVA93zVDnWxB2gajMNjp/9rSAZ6f6jy5mMjwYpkunD1jpI24xsIeNWPrPU1FeBpMLOpT6Pq9dY8b3ME09EwyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707223626; c=relaxed/simple;
	bh=LBcRlv+meBjJKzHuamnkobYyoZ5d8NEMzf8swJaw/pc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8ujpE8aJoPjrpf+EYjKY//PfsFIvSTagWBFBekMbHvxuo+1e9K0avPQZiPovCxjuWGmanIWm+KaLT9tKv/DgXOjPqb50Yol97CJrwJS7vjQxNqrYelNw4RERf0Ghd8EDwhKnET4XDpAPWNa9xS++wmmC4CnCUw02dfxDTF80qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xb+zLmvN; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3566c0309fso685853966b.1
        for <bpf@vger.kernel.org>; Tue, 06 Feb 2024 04:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707223622; x=1707828422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UT3FtpWOqJzSqNfkAULTWN9GDnuQODb2151IHTXsDfE=;
        b=Xb+zLmvNuEtMFr880kEuwHekVlZk5In8kjPH/rBYE+73L9Mwa2VdEHpb31LZktFlyR
         Nnx6ndO46M/zeaPGZvJ7AUXwCiM3qnruOsfuc6TzHIp5W1QSqpcolxqXTTeFLGAk5gfl
         7jnl18yxipUQFFrUojhL4KScArEXcUMtCz1munmFv4ZQ9McVYrX0d9FkPk42phFiKfYl
         VnjJ7hknEw86LKRnFobHQ5CxOIF0stvDryWN+BFYaTr2LXVTakJmo+TtoSXkwanCleEu
         Wwg7Cpf25V2E7jTDfM9c3BaB4rBNQRNpjyAfalw9zTEPNDWq9t124jLVBGlYbqaD21o8
         cLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707223622; x=1707828422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UT3FtpWOqJzSqNfkAULTWN9GDnuQODb2151IHTXsDfE=;
        b=Zel+H6QO/+ElYHTMfCeKkYC9GdfRwzibHvf09VHMQlby94Vi9zgszLbE3eHYQ09y88
         J6iSs4Yua0W6sReWpfvmzmIbJjT9QREuNJT2GQniK3p1nPdiVLRdxkLf4kJ9VQw+cfbZ
         /ir8WyfYGHsDb1lpS4CLhXdVR+b8Nh0XnndFWBnRnvIrpkK5EELovdgh/SK+q3QqAo3B
         Acyeo3yCS2tLQidPoLdYHV6Ud/eyA8m504avOuZDsKreODudPaXqIq1NZl2knvlu69Ju
         fiumOUp+6Tfks4tg4nxfzpmnFrCjP1pRhCKPkwZvpdpM+3kz2ZDuk1G/ajDes2+SlP5y
         iH/w==
X-Gm-Message-State: AOJu0Ywwn7/E4ghPyleKzVMasteFaOkWEfT90VLIYUmrz5MCP3SlRHMZ
	dAr0BNzTHDBaa8Nd8Jx/vwbEktq0/Wbyw0N1BCRhREeDJ7baG2WM
X-Google-Smtp-Source: AGHT+IHALQ0xhwWtPOHhAnwmX00JpgLyJ6BAfpQklM+oMsTjIH77vz/iM3dRtzVaYgPmSGh5rKaObQ==
X-Received: by 2002:a17:906:3087:b0:a37:7f72:574c with SMTP id 7-20020a170906308700b00a377f72574cmr1314383ejv.68.1707223622370;
        Tue, 06 Feb 2024 04:47:02 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWQEEIXRKCMS7b4srcLVHiF1mSMu+3Db1bxB/8AoDkicEj3NlQq5QGcDbPHzTt9IbeVyeSFZBIUtxllzLpnYGVfoNEreTTPz0cwn4yNgirju7os1pbLmVrnYOVYj/EaFHmE261bpp0xe6x9XzsqlUU5KPQJj/G9CFtHfu0q26UX42l3nKqtCbt+Gs7GvnWwh8N5OMlVqyALA3u7XTyZBsHhR7/SmZMINsWiNN/ic7ghDlxhsL4=
Received: from krava ([144.178.231.99])
        by smtp.gmail.com with ESMTPSA id ti12-20020a170907c20c00b00a36fa497a65sm1097026ejc.110.2024.02.06.04.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 04:47:02 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 6 Feb 2024 13:47:00 +0100
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: acme@kernel.org, quentin@isovalent.com, alan.maguire@oracle.com,
	andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v4 1/2] pahole: Add --btf_feature=decl_tag_kfuncs
 feature
Message-ID: <ZcIqRC1fOtZVv1Rk@krava>
References: <cover.1707071969.git.dxu@dxuuu.xyz>
 <bd8f705a5c11b14571563a63045416233f9d06f1.1707071969.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd8f705a5c11b14571563a63045416233f9d06f1.1707071969.git.dxu@dxuuu.xyz>

On Sun, Feb 04, 2024 at 11:40:37AM -0700, Daniel Xu wrote:
> Add a feature flag to guard tagging of kfuncs. The next commit will
> implement the actual tagging.
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  btf_encoder.c | 2 ++
>  dwarves.h     | 1 +
>  pahole.c      | 1 +
>  3 files changed, 4 insertions(+)

we should update man page as well

also we need to update the kernel's scripts/Makefile.btf with
the new option for the next pahole version (1.26 I guess)

jirka

> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index fd04008..e325f66 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -77,6 +77,7 @@ struct btf_encoder {
>  			  verbose,
>  			  force,
>  			  gen_floats,
> +			  tag_kfuncs,
>  			  is_rel;
>  	uint32_t	  array_index_id;
>  	struct {
> @@ -1642,6 +1643,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>  		encoder->force		 = conf_load->btf_encode_force;
>  		encoder->gen_floats	 = conf_load->btf_gen_floats;
>  		encoder->skip_encoding_vars = conf_load->skip_encoding_btf_vars;
> +		encoder->tag_kfuncs	 = conf_load->btf_decl_tag_kfuncs;
>  		encoder->verbose	 = verbose;
>  		encoder->has_index_type  = false;
>  		encoder->need_index_type = false;
> diff --git a/dwarves.h b/dwarves.h
> index 857b37c..996eb70 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -87,6 +87,7 @@ struct conf_load {
>  	bool			skip_encoding_btf_vars;
>  	bool			btf_gen_floats;
>  	bool			btf_encode_force;
> +	bool			btf_decl_tag_kfuncs;
>  	uint8_t			hashtable_bits;
>  	uint8_t			max_hashtable_bits;
>  	uint16_t		kabi_prefix_len;
> diff --git a/pahole.c b/pahole.c
> index 768a2fe..48c19b7 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -1278,6 +1278,7 @@ struct btf_feature {
>  	BTF_FEATURE(enum64, skip_encoding_btf_enum64, true),
>  	BTF_FEATURE(optimized_func, btf_gen_optimized, false),
>  	BTF_FEATURE(consistent_func, skip_encoding_btf_inconsistent_proto, false),
> +	BTF_FEATURE(decl_tag_kfuncs, btf_decl_tag_kfuncs, false),
>  };
>  
>  #define BTF_MAX_FEATURE_STR	1024
> -- 
> 2.42.1
> 

