Return-Path: <bpf+bounces-42890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1469ACA9F
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 14:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0C8DB23336
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 12:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4294C1AC43A;
	Wed, 23 Oct 2024 12:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpStjglZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7311AAE23
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 12:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729688077; cv=none; b=bNejoWG0fFM2gTqGzw6MHWGwrkbJJQ1KAyDlBrRIU2HQTsdne4vI/h0iBXsmUT8jDOs3nyOZOjGeNttEgBqcYxBBU7CePK46Y5Uzu1+xvT5DV5B1ldys6ZJZTpGNaS+7DMeVPJfBV1GBshO9fKDhS3zFcIUM5m1ITBls9UWbn64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729688077; c=relaxed/simple;
	bh=DGS0hrN5QdzR3LFM5o36ILZCm0qRwjM3JF/YqibUbKo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3BmY2ErpZMV/mwnM/AuEkus3dSmS3az+MLfyIt0X9arRP6SzWWRZdZ++Ss77sAJeyYuxGIFnPnfr4EdtHh62F0nI6OudMx8zf8NWpY5meTqXWfF6ZFJgyIyMEuGZVyQqTmPG0bz6GPJOK5j9PyYe/ufGkn0lQrUZ+8tGIg9GXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpStjglZ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a0f198d38so938410966b.1
        for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 05:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729688074; x=1730292874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HGasZv6LVylPpk2EuWgxlKpBJcpfMHQYvQdrZmin3ig=;
        b=BpStjglZeAj/dQat1OxmuabNjty70goz55MOZhdyp/J9NOyQvXBSB/tSYPiuhFy+lE
         ZglzPhCX0lTOtveHy6QRA27UmWPvhtsgOBvqdJqUTESHyOUdzDerfGK/WwGdwhHf5ocG
         qcwKx+twhEoBOaVIP973aYwP2ftY1buPalP8hzzI+YOKJ63s1Yv6PUNvx6eO6yrXdCMh
         TLbivShUaO96SM1F4l1WjQEfMkfoCmHNxecAujmxwcKg05ccyO+UfKyDSMxovqRDfE7k
         SzT4S2BTHCzQazWXoD0KWkvfR5WY8OXfmzBx6Bz1UVkMxBhAMUcalOvfP9OqtT4nMInr
         FFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729688074; x=1730292874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGasZv6LVylPpk2EuWgxlKpBJcpfMHQYvQdrZmin3ig=;
        b=UlYQKOwOYitMfrbETpC0hZlT3MXZu6iRTt0GdE9WLkpXYOW0F+wDLizhNRawPsFjj9
         zuy5hDeA6iiH+steuWmBeVtRNNW34dck8yQs8OfXNa36oz6KQx62/uqG0EAS8do4fFjK
         3WIqt0o4Japty/bBcAgYnEucAuEKOYD1L0bSQkMJ4sC2GYRbHHCZGKx5TkPhnyalMhTG
         M+2z5oarukt7Ko8KudbLS4Qp5aoGicwpG8sB1By3IVaqn4HQfqH1uR5YxuvmkGzWwm93
         ew+xshQRyCLf7DSlcwCwjWraVZklXPFnggxEgeLs63WhwtTwkBS6Ob+I0fWZiPT5SVxe
         EHbw==
X-Gm-Message-State: AOJu0YzfPEmiKDLpIWlvWBsVcAohihoGFzRkfYC03yUxBdrAASItJKwr
	x1Tx2uw+HcHC/qBazc22AJbzba6+jj1FSe4SRsPabR/bC6Tf6uhEpGkljA==
X-Google-Smtp-Source: AGHT+IEZzf5LPKqdb9y0rNmbZzinM2nECdXxLZTSSU23v7R+fejbvie5h57GQ9FMOFTdPyGY73aQAA==
X-Received: by 2002:a17:907:9411:b0:a99:762f:b298 with SMTP id a640c23a62f3a-a9abf94de80mr250056266b.41.1729688074176;
        Wed, 23 Oct 2024 05:54:34 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d68f7sm473962766b.1.2024.10.23.05.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 05:54:33 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 23 Oct 2024 14:54:32 +0200
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com,
	Alastair Robertson <ajor@meta.com>,
	Jonathan Wiepert <jwiepert@meta.com>
Subject: Re: [PATCH bpf-next 2/3] libbpf: move global data mmap()'ing into
 bpf_object__load()
Message-ID: <ZxjyCOWne0qXts5o@krava>
References: <20241023043908.3834423-1-andrii@kernel.org>
 <20241023043908.3834423-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023043908.3834423-3-andrii@kernel.org>

On Tue, Oct 22, 2024 at 09:39:07PM -0700, Andrii Nakryiko wrote:

SNIP

> @@ -5146,11 +5147,43 @@ bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
>  		if (err) {
>  			err = -errno;
>  			cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
> -			pr_warn("Error freezing map(%s) as read-only: %s\n",
> -				map->name, cp);
> +			pr_warn("map '%s': failed to freeze as read-only: %s\n",
> +				bpf_map__name(map), cp);
>  			return err;
>  		}
>  	}
> +
> +	/* Remap anonymous mmap()-ed "map initialization image" as
> +	 * a BPF map-backed mmap()-ed memory, but preserving the same
> +	 * memory address. This will cause kernel to change process'
> +	 * page table to point to a different piece of kernel memory,
> +	 * but from userspace point of view memory address (and its
> +	 * contents, being identical at this point) will stay the
> +	 * same. This mapping will be released by bpf_object__close()
> +	 * as per normal clean up procedure.
> +	 */
> +	mmap_sz = bpf_map_mmap_sz(map);
> +	if (map->def.map_flags & BPF_F_MMAPABLE) {
> +		void *mmaped;
> +		int prot;
> +
> +		if (map->def.map_flags & BPF_F_RDONLY_PROG)
> +			prot = PROT_READ;
> +		else
> +			prot = PROT_READ | PROT_WRITE;
> +		mmaped = mmap(map->mmaped, mmap_sz, prot, MAP_SHARED | MAP_FIXED, map->fd, 0);
> +		if (mmaped == MAP_FAILED) {
> +			err = -errno;
> +			pr_warn("map '%s': failed to re-mmap() contents: %d\n",
> +				bpf_map__name(map), err);
> +			return err;
> +		}
> +		map->mmaped = mmaped;
> +	} else if (map->mmaped) {
> +		munmap(map->mmaped, mmap_sz);
> +		map->mmaped = NULL;
> +	}

this caught my eye because we did not do that in bpf_object__load_skeleton,
makes sense, but why do we mmap *!*BPF_F_MMAPABLE maps in the first place?

jirka

> +
>  	return 0;
>  }
>  
> @@ -5467,8 +5500,7 @@ bpf_object__create_maps(struct bpf_object *obj)
>  				err = bpf_object__populate_internal_map(obj, map);
>  				if (err < 0)
>  					goto err_out;
> -			}
> -			if (map->def.type == BPF_MAP_TYPE_ARENA) {
> +			} else if (map->def.type == BPF_MAP_TYPE_ARENA) {
>  				map->mmaped = mmap((void *)(long)map->map_extra,
>  						   bpf_map_mmap_sz(map), PROT_READ | PROT_WRITE,
>  						   map->map_extra ? MAP_SHARED | MAP_FIXED : MAP_SHARED,
> @@ -13916,46 +13948,11 @@ int bpf_object__load_skeleton(struct bpf_object_skeleton *s)
>  	for (i = 0; i < s->map_cnt; i++) {
>  		struct bpf_map_skeleton *map_skel = (void *)s->maps + i * s->map_skel_sz;
>  		struct bpf_map *map = *map_skel->map;
> -		size_t mmap_sz = bpf_map_mmap_sz(map);
> -		int prot, map_fd = map->fd;
> -		void **mmaped = map_skel->mmaped;
> -
> -		if (!mmaped)
> -			continue;
> -
> -		if (!(map->def.map_flags & BPF_F_MMAPABLE)) {
> -			*mmaped = NULL;
> -			continue;
> -		}
>  
> -		if (map->def.type == BPF_MAP_TYPE_ARENA) {
> -			*mmaped = map->mmaped;
> +		if (!map_skel->mmaped)
>  			continue;
> -		}
> -
> -		if (map->def.map_flags & BPF_F_RDONLY_PROG)
> -			prot = PROT_READ;
> -		else
> -			prot = PROT_READ | PROT_WRITE;
>  
> -		/* Remap anonymous mmap()-ed "map initialization image" as
> -		 * a BPF map-backed mmap()-ed memory, but preserving the same
> -		 * memory address. This will cause kernel to change process'
> -		 * page table to point to a different piece of kernel memory,
> -		 * but from userspace point of view memory address (and its
> -		 * contents, being identical at this point) will stay the
> -		 * same. This mapping will be released by bpf_object__close()
> -		 * as per normal clean up procedure, so we don't need to worry
> -		 * about it from skeleton's clean up perspective.
> -		 */
> -		*mmaped = mmap(map->mmaped, mmap_sz, prot, MAP_SHARED | MAP_FIXED, map_fd, 0);
> -		if (*mmaped == MAP_FAILED) {
> -			err = -errno;
> -			*mmaped = NULL;
> -			pr_warn("failed to re-mmap() map '%s': %d\n",
> -				 bpf_map__name(map), err);
> -			return libbpf_err(err);
> -		}
> +		*map_skel->mmaped = map->mmaped;
>  	}
>  
>  	return 0;
> -- 
> 2.43.5
> 
> 

