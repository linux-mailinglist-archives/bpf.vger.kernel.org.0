Return-Path: <bpf+bounces-32208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B03990945A
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 00:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52E522862A0
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 22:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B79186E5B;
	Fri, 14 Jun 2024 22:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5Wj+3G5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709F5186E47
	for <bpf@vger.kernel.org>; Fri, 14 Jun 2024 22:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718405406; cv=none; b=oevLxhiS7NkxR5JwGKrAd5gbpDzaLUUisG152GfOZjU1K7eUzcSUIz8nylS9PJM4MBMKQBEgtrXmjZGtYiUKnAUGoPJ7wPbHdUVA6bpPu0TDwTslSiKqyCE1wSAR6jlBdehRBKk7+vBVuQ+gk8eOQlFIQ/pGEEsCcN7EQiYTNis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718405406; c=relaxed/simple;
	bh=IeSfCgP9ZsIoBtXa9Hzt12ZvOsnH3qG7U+iVcqWICvM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TlALduQYYQsy94jjPQ8T0BS7nnj3XyjWb1DvCHgtfr68B/huDjNTQ9qZw7irAUw5wc6DjKi4rkI1GhAe6T7kP8IAULi6Pes77gPWClR6Wkt+Z+HjmYBCKEJCpemaRzHCIScqQFytSGYQM+/LLRmo6QCRUfRqhemzmuGzA6gMYVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5Wj+3G5; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3d21e00d9cfso1527820b6e.2
        for <bpf@vger.kernel.org>; Fri, 14 Jun 2024 15:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718405404; x=1719010204; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YavQizbymdorK4DE4IYojWHdCzRLoJRoki9aRg1EamE=;
        b=j5Wj+3G5xFZ1LGQB4TISt+eR7zztda6HqcVRoy11ia78vmXszYaDz/Ym0GdevD+mpi
         myVYUzBheiHsF3nDnJJhUe4TmP7vkbxzIceY9z3F+uo2yOv2atxrI1p/vV+xW+UshZwJ
         UVFVR9pP++lgGtQ12PHU4IkwxhAfLu054/XshpfXPVTNP6BxMuF/0S0Z4YCNEI900cVz
         M4h82Z6qcatglswe+CIyrwHus71lPs6aFgAWk4XipcJLeOmD6f94Q7Ni2KIXU8zjvmK+
         It/UaW78VMH3p2KYe514qZ3ogs4CxaCwByHZAFzSN+Fi7lOEuQVmwiah7Bs6vjuw1pHT
         soUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718405404; x=1719010204;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YavQizbymdorK4DE4IYojWHdCzRLoJRoki9aRg1EamE=;
        b=FLGTsCEMLPaE1kpz/hEqitJqcFMsu4DKlGw00A/mZhVPQ2imYii+TmTrff0ViL1zJb
         1ZP4Z1ts5nU5Z+kA2mvkWdqbMM9bgzAb6Ng3EPsbgPhfNXXvhdpO+GtFdODTNXgW4w81
         pjLIHyI2lWZ43fLaWa3xxA/4vYmrdKeZDM80Nqk9WWME2/dayGqT3Mzx8X0uP9RH3aHa
         a7cyeUxUspTGrQTS0XlX5eJEu6OZ1Fp5DC6rE3AWOv1h+9UTZWFh9tLi3Fty5c92uTSg
         rOlzrjv2vByqiQFC8zHjwqYBpXhS9ps+PoUDG6zPMf3cfU24fE8HSKHTytzu3D0ykqIX
         uPmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF7VPP9MZWTlV1NXvvdoKs/YVs1LeQBKMrVOX4VsALaEGg1Ppzl15Qw7Owtfldc4KrP3zfsFBskuHK6WsicHw19Hso
X-Gm-Message-State: AOJu0YzayY63K2hWUwbrapv+l0hFqZQwxFHk2OIgaV/ML+JQ8Z2/jiNY
	6ZlvJBArgnlfhDdrrmPINpSVeGFdOaUk9JEBUi60/yJjMJVIZ+B2
X-Google-Smtp-Source: AGHT+IEHWAHDXSKBz2T5IOSaDIvilUahiu5gbuiTh3AvWgb26tCTMgufpGrkOsvIwIfCOfK8e/TaEw==
X-Received: by 2002:a05:6870:a54d:b0:254:b1b1:7ebc with SMTP id 586e51a60fabf-25842be4ca2mr4742071fac.50.1718405404424;
        Fri, 14 Jun 2024 15:50:04 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb91b62sm3547495b3a.203.2024.06.14.15.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 15:50:03 -0700 (PDT)
Message-ID: <3a1dd525bee2875f370e73a0416d115018ed7e52.camel@gmail.com>
Subject: Re: [PATCH v6 bpf-next 8/9] libbpf,bpf: share BTF relocate-related
 code with kernel
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, mcgrof@kernel.org, 
	masahiroy@kernel.org, nathan@kernel.org, mykolal@fb.com, dxu@dxuuu.xyz, 
	bpf@vger.kernel.org
Date: Fri, 14 Jun 2024 15:49:58 -0700
In-Reply-To: <20240613095014.357981-9-alan.maguire@oracle.com>
References: <20240613095014.357981-1-alan.maguire@oracle.com>
	 <20240613095014.357981-9-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-13 at 10:50 +0100, Alan Maguire wrote:
> Share relocation implementation with the kernel.  As part of this,
> we also need the type/string iteration functions so add them to a
> btf_iter.c file that also gets shared with the kernel. Relocation
> code in kernel and userspace is identical save for the impementation
> of the reparenting of split BTF to the relocated base BTF and
> retrieval of BTF header from "struct btf"; these small functions
> need separate user-space and kernel implementations.
>=20
> One other wrinkle on the kernel side is we have to map .BTF.ids in
> modules as they were generated with the type ids used at BTF encoding
> time. btf_relocate() optionally returns an array mapping from old BTF
> ids to relocated ids, so we use that to fix up these references where
> needed for kfuncs.
>=20
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Hi Alan,

I've looked through this patch and all seems to look good,
two minor notes below.

Thanks,
Eduard

[...]

> @@ -8133,21 +8207,15 @@ static int btf_populate_kfunc_set(struct btf *btf=
, enum btf_kfunc_hook hook,
>  		goto end;
>  	}
> =20
> -	/* We don't need to allocate, concatenate, and sort module sets, becaus=
e
> -	 * only one is allowed per hook. Hence, we can directly assign the
> -	 * pointer and return.
> -	 */
> -	if (!vmlinux_set) {
> -		tab->sets[hook] =3D add_set;
> -		goto do_add_filter;
> -	}
> -

Is it necessary to adjust btf_free_kfunc_set_tab()? It currently skips
freeing tab->sets[*] for modules. I've added two printk's and it looks
like sets allocated for module here are leaking after insmod/rmmod.

>  	/* In case of vmlinux sets, there may be more than one set being
>  	 * registered per hook. To create a unified set, we allocate a new set
>  	 * and concatenate all individual sets being registered. While each set
>  	 * is individually sorted, they may become unsorted when concatenated,
>  	 * hence re-sorting the final set again is required to make binary
>  	 * searching the set using btf_id_set8_contains function work.
> +	 *
> +	 * For module sets, we need to allocate as we may need to relocate
> +	 * BTF ids.
>  	 */
>  	set_cnt =3D set ? set->cnt : 0;
> =20

[...]

> @@ -8451,6 +8522,13 @@ int register_btf_id_dtor_kfuncs(const struct btf_i=
d_dtor_kfunc *dtors, u32 add_c
>  	btf->dtor_kfunc_tab =3D tab;
> =20
>  	memcpy(tab->dtors + tab->cnt, dtors, add_cnt * sizeof(tab->dtors[0]));
> +
> +	/* remap BTF ids based on BTF relocation (if any) */
> +	for (i =3D tab_cnt; i < tab_cnt + add_cnt; i++) {
> +		tab->dtors[i].btf_id =3D btf_relocate_id(btf, tab->dtors[i].btf_id);
> +		tab->dtors[i].kfunc_btf_id =3D btf_relocate_id(btf, tab->dtors[i].kfun=
c_btf_id);

The register_btf_id_dtor_kfuncs() is exported and thus could to be
called from the modules, that's why you update it, right?
Do we want to add such call to bpf_testmod? Currently, with kernel
config used for selftests, I see only identity mappings.

> +	}
> +
>  	tab->cnt +=3D add_cnt;
> =20
>  	sort(tab->dtors, tab->cnt, sizeof(tab->dtors[0]), btf_id_cmp_func, NULL=
);

[...]

