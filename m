Return-Path: <bpf+bounces-18875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B05E8231B9
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 17:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BE731C22781
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 16:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CB61C6B0;
	Wed,  3 Jan 2024 16:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEM/AUoh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A1D1C68A;
	Wed,  3 Jan 2024 16:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3600902871fso32251825ab.2;
        Wed, 03 Jan 2024 08:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704301063; x=1704905863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Zktb3+Qs2SqoLUYke6ed9z4x6XW8ZCraFvAIiNm+fM=;
        b=mEM/AUohvxVPGyv9bQMWyuDGAoLSEPsDLyDaoMjQiGIAy425OnrkJGcHC3ZnTfKCm2
         ct/3LPxXEF3JflgNrIhmoCRzqG5St0gNNLHkfJgre/YV65/iMNiBW5knzAk+NeMCiHsz
         6fe7p/WiSMNamyKkCc1WEiaSphi4aPqjrmjrmm5LY/nZM8pQ+QHXTmcuPiOrb5Zposk3
         EODh2t5dn6wTcsBWqCwRIkzDLG0Unx6oSDWwUbl21kDQW344XBwsN5ZxhGkhCvE6HDuh
         z6XVz7KAZKPk7JbyaL+pcMA3ORcyPoPsbluW22PhV0X9fY48N9pO1p09lJBLsU+U9aWw
         7avw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704301063; x=1704905863;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Zktb3+Qs2SqoLUYke6ed9z4x6XW8ZCraFvAIiNm+fM=;
        b=cRM5X+aMEdBv4uZjlgKhRsZAWPsUoh+nniQwOzF9pin8koARO7NF4cnQqREHO+7KnR
         s4a3pn9ZW1B3k2ThoJqy9eeWgfEBNOeVNzktfyCugyb/kh+SC7ImtRFXDfcrW+TPWke9
         9SKC0lBYSvZ/8clZcm4HI/cTp1Ufls3LJWgT27VucJeG3PP6zGVgwkOl3ql+2fdtbiqk
         t2+7blQYwah7WfcVo/rWCDutLIaiPYyxrfE1REDdADQxRJKOyT+H+n+1ju2Ojbh/coYM
         nnY63O+MIPAgfcUcG0CJTzPDLeoRYofn3VUO9bLXDI5byA2ig/PFMEgzKPC9TcYFrqbK
         Pjww==
X-Gm-Message-State: AOJu0YyXs82hOP1nG7wGxhV3Sia641zvHEeQBeiS3Yb+584+QQOfH68P
	Pxm/Pc7uuPTj+OdWwjwFcaV1SwJF1aM=
X-Google-Smtp-Source: AGHT+IHX9q+d4uOUIeL2jtln8G6aLe/9MWYxTXL8k6VY7y3MB4GVEpFMubr8CvgGH/0TQZhIuy3WtA==
X-Received: by 2002:a05:6e02:17c5:b0:35f:e1da:e15f with SMTP id z5-20020a056e0217c500b0035fe1dae15fmr15096614ilu.73.1704301060972;
        Wed, 03 Jan 2024 08:57:40 -0800 (PST)
Received: from localhost ([98.97.37.198])
        by smtp.gmail.com with ESMTPSA id f25-20020a631f19000000b0056606274e54sm22418321pgf.31.2024.01.03.08.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 08:57:40 -0800 (PST)
Date: Wed, 03 Jan 2024 08:57:36 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Barret Rhoden <brho@google.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>
Cc: mattbobrowski@google.com, 
 bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <65959200a747b_2384720814@john.notmuch>
In-Reply-To: <20240103153307.553838-2-brho@google.com>
References: <20240103153307.553838-1-brho@google.com>
 <20240103153307.553838-2-brho@google.com>
Subject: RE: [PATCH bpf-next 1/2] libbpf: add helpers for mmapping maps
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Barret Rhoden wrote:
> bpf_map__mmap_size() was internal to bpftool.  Use that to make wrappers
> for mmap and munmap.
> 
> Signed-off-by: Barret Rhoden <brho@google.com>
> ---
>  tools/bpf/bpftool/gen.c  | 16 +++-------------
>  tools/lib/bpf/libbpf.c   | 23 +++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h   |  6 ++++++
>  tools/lib/bpf/libbpf.map |  4 ++++
>  4 files changed, 36 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index ee3ce2b8000d..a328e960c141 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -453,16 +453,6 @@ static void print_hex(const char *data, int data_sz)
>  	}
>  }
>  
> -static size_t bpf_map_mmap_sz(const struct bpf_map *map)
> -{
> -	long page_sz = sysconf(_SC_PAGE_SIZE);
> -	size_t map_sz;
> -
> -	map_sz = (size_t)roundup(bpf_map__value_size(map), 8) * bpf_map__max_entries(map);
> -	map_sz = roundup(map_sz, page_sz);
> -	return map_sz;
> -}
> -
>  /* Emit type size asserts for all top-level fields in memory-mapped internal maps. */
>  static void codegen_asserts(struct bpf_object *obj, const char *obj_name)
>  {
> @@ -641,7 +631,7 @@ static void codegen_destroy(struct bpf_object *obj, const char *obj_name)
>  		if (bpf_map__is_internal(map) &&
>  		    (bpf_map__map_flags(map) & BPF_F_MMAPABLE))
>  			printf("\tskel_free_map_data(skel->%1$s, skel->maps.%1$s.initial_value, %2$zd);\n",
> -			       ident, bpf_map_mmap_sz(map));
> +			       ident, bpf_map__mmap_size(map));
>  		codegen("\
>  			\n\
>  				skel_closenz(skel->maps.%1$s.map_fd);	    \n\
> @@ -723,7 +713,7 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
>  					goto cleanup;			    \n\
>  				skel->maps.%1$s.initial_value = (__u64) (long) skel->%1$s;\n\
>  			}						    \n\
> -			", ident, bpf_map_mmap_sz(map));
> +			", ident, bpf_map__mmap_size(map));
>  	}
>  	codegen("\
>  		\n\
> @@ -780,7 +770,7 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
>  			if (!skel->%1$s)				    \n\
>  				return -ENOMEM;				    \n\
>  			",
> -		       ident, bpf_map_mmap_sz(map), mmap_flags);
> +		       ident, bpf_map__mmap_size(map), mmap_flags);
>  	}
>  	codegen("\
>  		\n\
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index ebcfb2147fbd..171a977cb5fd 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9830,6 +9830,29 @@ void *bpf_map__initial_value(struct bpf_map *map, size_t *psize)
>  	return map->mmaped;
>  }

It seems libbpf.c has its own bpf_map_mmap_sz() as well.

 static size_t bpf_map_mmap_sz(unsigned int value_sz, unsigned int max_entries)                  
 {                                                                                
        const long page_sz = sysconf(_SC_PAGE_SIZE);                                         
        size_t map_sz;                                                                                
                                                                                    
        map_sz = (size_t)roundup(value_sz, 8) * max_entries;
        map_sz = roundup(map_sz, page_sz);                                                  
        return map_sz;                                                              
 }  

Can we consolidate these a bit. Seems we don't want/need to
have both bpf_map__mmap_size and bpf_map_mmap_sz() floating
around. 

Should bpf_map__mmap_size just calls bpf_map_mmap_sz with
the correct sz and max_entries?

>  
> +size_t bpf_map__mmap_size(const struct bpf_map *map)
> +{
> +	long page_sz = sysconf(_SC_PAGE_SIZE);
> +	size_t map_sz;
> +
> +	map_sz = (size_t)roundup(bpf_map__value_size(map), 8) *
> +		bpf_map__max_entries(map);
> +	map_sz = roundup(map_sz, page_sz);
> +	return map_sz;
> +}
> +
> +void *bpf_map__mmap(const struct bpf_map *map)
> +{
> +	return mmap(NULL, bpf_map__mmap_size(map),
> +		    PROT_READ | PROT_WRITE, MAP_SHARED,
> +		    bpf_map__fd(map), 0);
> +}
> +
> +int bpf_map__munmap(const struct bpf_map *map, void *addr)
> +{
> +	return munmap(addr, bpf_map__mmap_size(map));
> +}
> +
>  bool bpf_map__is_internal(const struct bpf_map *map)
>  {
>  	return map->libbpf_type != LIBBPF_MAP_UNSPEC;
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 6cd9c501624f..148f4c783ca7 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -996,6 +996,12 @@ LIBBPF_API int bpf_map__set_map_extra(struct bpf_map *map, __u64 map_extra);
>  LIBBPF_API int bpf_map__set_initial_value(struct bpf_map *map,
>  					  const void *data, size_t size);
>  LIBBPF_API void *bpf_map__initial_value(struct bpf_map *map, size_t *psize);
> +/* get the mmappable size of the map */
> +LIBBPF_API size_t bpf_map__mmap_size(const struct bpf_map *map);
> +/* mmap the map */
> +LIBBPF_API void *bpf_map__mmap(const struct bpf_map *map);
> +/* munmap the map at addr */
> +LIBBPF_API int bpf_map__munmap(const struct bpf_map *map, void *addr);
>  
>  /**
>   * @brief **bpf_map__is_internal()** tells the caller whether or not the
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 91c5aef7dae7..9e44de4fbf39 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -411,4 +411,8 @@ LIBBPF_1.3.0 {
>  } LIBBPF_1.2.0;
>  
>  LIBBPF_1.4.0 {
> +	global:
> +		bpf_map__mmap_size;
> +		bpf_map__mmap;
> +		bpf_map__munmap;
>  } LIBBPF_1.3.0;
> -- 
> 2.43.0.472.g3155946c3a-goog
> 
> 



