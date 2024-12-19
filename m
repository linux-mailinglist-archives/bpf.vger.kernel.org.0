Return-Path: <bpf+bounces-47320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6339F7D70
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 15:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8294216152D
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 14:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894B022579E;
	Thu, 19 Dec 2024 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rp/JiS3F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FA641C64;
	Thu, 19 Dec 2024 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734620311; cv=none; b=RoSNULJiTVqV7UGpcp2+kQkEOHRrx4VYFSiReQyeIFOR1XUwZe42PgbY2ompQlXE5opz8i0MKUBZJ6wFgPE6sQfIw7pE04X3Lm//zmLm7ccMrDdoTiuBI2FmBONoHyLlYWrqPibPCq66EcPyuUBqLgZdpwqYV7RG85yEUBMS5R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734620311; c=relaxed/simple;
	bh=Cvk713Y+TsdtS0NykAwWaYS66PZ6sRxgz6M9+BvPcDQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKNwPg8F8rL8tMjZdLajnlsNYrfYj8PKaGIBiU03+3CM53oSsF0Jpqat81DfZ/rrrqHKJNj//8ys+eM/HH61iL+ZrTTl0Ka1EjL2+3QCKOrZXx0JZizKpBzYZqqooOCMRINAjaBJBlwb6F9vN2Zl/gTBEHe1Siac/LhrS6DNFC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rp/JiS3F; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d7e3f1fc01so1630060a12.2;
        Thu, 19 Dec 2024 06:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734620308; x=1735225108; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XzC4AdUPYq6pM84BxIHabNL75lLAYilzMKWURHGhqZ4=;
        b=Rp/JiS3FYPK6OPD2gHlZd46PAqndfOe1uhag0U+2BML0J4zX2RTu0j5KmIlN/iKxsb
         DN64rmExiKAn7zx7szeQGWB4QqVrVBfdq1fX89OQcjnEoZSDGOwiKX6JD2hU/AlB7fOu
         AEgRulSrSoVsjD/Pzzca4RFA1SIJYTEW9ODuHojxIs1kVvAgloS7qCVPAZKpaqOJcmuJ
         0JdHytcCOIDWXNVVF7dttVvH3q0XE/YNjsfIiBToKoyJt2C+4cwFQupqSnIcSUG4wYFF
         +R8rClgQtAvX0MgEsefrcXvgSQWeJebMoBkc3ta5L4AJC2RzHGDEB2vH7cA8GF5CxkQj
         iORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734620308; x=1735225108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzC4AdUPYq6pM84BxIHabNL75lLAYilzMKWURHGhqZ4=;
        b=eTYb5NnaJ2b8c/gxo+NQULwRUgFanOOEMn5fekzuM6uh4QTAjg2EjG9kIiqINa+yYa
         SvW+S5eHjib7W6IOj/711fNpj84yMT6ssM2fEPR12zYhEUbpWOlIolTPZ6f4efpwJ0QZ
         XLUIqD+ZUrllLbjh5gvqcnWo17IxOABNdg2Tq/gaL64OSASO4uOijJkPUZpkhSjr29fP
         E/O1nCkXEZ+KMjWn8To1KuW6F3PL6MWvnoKOco+IY/Vcxp2UxYVH2zveuSDPaS7mMTMe
         lvlb6BoHKN+TZvkgDwR6AtFW1GKMdbusIrq8CM3Unxryo4TV1A/2tEhZAH4ez+omNQW6
         fK8g==
X-Forwarded-Encrypted: i=1; AJvYcCVxyfbn2oaGuEVqWQIZyDG9+EL0TY1QH2CM++gCxqWZJJ6CUlwxwpEu7t+lEOfuQNNqrRA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza5UejvYVSTc/CMczJAagTwKsnKF/8vaefyXDJuRusk1pkMC06
	An64/b4DMFsuBx/3zoCWRnKzxNTKETDxrtvqB8Zow2scGYu/cp9BVTw/Lw==
X-Gm-Gg: ASbGncujDj7PRjPhccVqD3F3UHgDgNCu9kcjQw3HTQkpNMe2NaQClsofz4OQaCR4B3J
	cMFgO8fjsb6gvEd1D09LV+UDpzsu7OY1b3cLhjHkFOH1vNvrW9Cr5coNyywgYHES5G49JIw3ptv
	CPRpq+kf6MBdZl8m4vZjQbxyYxTLymXPBrZMSVNyyy5pOXMW7lrU1kCcNWC7EGOJ4GU519xWpVW
	8Kjops0l10wRCJZVf/OYCxn5meH8hwh5o6yIv102bZZ5zuWB53mv4avvH975N+OJf2ezPUuM0Mo
	pf3kJy9UOQXjboTb5UoTLCvzOWrkew==
X-Google-Smtp-Source: AGHT+IFJl1dY8LCInKrpG0t/ugaFCQduOCM0IQtrpCON7HamS7WXV4HNh21lNQMbqMd0h13ZzhaKrg==
X-Received: by 2002:a05:6402:2688:b0:5d3:fb9d:3f69 with SMTP id 4fb4d7f45d1cf-5d8026618cdmr2570981a12.21.1734620307349;
        Thu, 19 Dec 2024 06:58:27 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d806fedb05sm756834a12.68.2024.12.19.06.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 06:58:26 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 19 Dec 2024 15:58:24 +0100
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com,
	eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com,
	bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v2 06/10] btf_encoder: switch to shared
 elf_functions table
Message-ID: <Z2Q0kBEHvLV11Fne@krava>
References: <20241213223641.564002-1-ihor.solodrai@pm.me>
 <20241213223641.564002-7-ihor.solodrai@pm.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213223641.564002-7-ihor.solodrai@pm.me>

On Fri, Dec 13, 2024 at 10:37:13PM +0000, Ihor Solodrai wrote:

SNIP

> @@ -2116,9 +2128,6 @@ int btf_encoder__encode(struct btf_encoder *encoder)
>  	int err;
>  	size_t shndx;
>  
> -	/* for single-threaded case, saved funcs are added here */
> -	btf_encoder__add_saved_funcs(encoder);
> -
>  	for (shndx = 1; shndx < encoder->seccnt; shndx++)
>  		if (gobuffer__size(&encoder->secinfo[shndx].secinfo))
>  			btf_encoder__add_datasec(encoder, shndx);
> @@ -2477,14 +2486,13 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>  			goto out_delete;
>  		}
>  
> -		encoder->symtab = elf_symtab__new(NULL, cu->elf);
> +		encoder->functions = elf_functions__get(cu->elf);

elf_functions__get should always return != NULL right? should we add assert call for that?

SNIP

> diff --git a/pahole.c b/pahole.c
> index 17af0b4..eb2e71a 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -3185,13 +3185,16 @@ static int pahole_threads_collect(struct conf_load *conf, int nr_threads, void *
>  	if (error)
>  		goto out;
>  
> -	btf_encoder__add_saved_funcs(btf_encoder);
> +	err = btf_encoder__add_saved_funcs(btf_encoder);
> +	if (err < 0)
> +		goto out;
> +
>  	for (i = 0; i < nr_threads; i++) {
>  		/*
>  		 * Merge content of the btf instances of worker threads to the btf
>  		 * instance of the primary btf_encoder.
>                  */
> -		if (!threads[i]->btf)
> +		if (!threads[i]->encoder || !threads[i]->btf)

is this related to this change? seems like separate fix

>  			continue;
>  		err = btf_encoder__add_encoder(btf_encoder, threads[i]->encoder);
>  		if (err < 0)
> @@ -3846,6 +3849,9 @@ try_sole_arg_as_class_names:
>  			exit(1);
>  		}
>  
> +		if (conf_load.nr_jobs <= 1 || conf_load.reproducible_build)
> +			btf_encoder__add_saved_funcs(btf_encoder);

should we check the return value here as well?

thanks,
jirka

> +
>  		err = btf_encoder__encode(btf_encoder);
>  		btf_encoder__delete(btf_encoder);
>  		if (err) {
> -- 
> 2.47.1
> 
> 
> 

