Return-Path: <bpf+bounces-27997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 204FB8B42D2
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 01:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C982C1F234EE
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 23:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF943BBDE;
	Fri, 26 Apr 2024 23:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QM5riQ0k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B1F3839C
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 23:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714175276; cv=none; b=egNgzdfOshJMDVfGwJaEY5+/Ycq1RGiEh98q85cZOZ/U/7E3gGbbQeUwWU7TipZ7z4cg1BBUX4y9BULXPJp4TGh+RKZOOAlyyUpduOIJJjOZmZXOOMNKPgEnZMmEkWskVp6mj6mhKewCbQ36hQoJy1b0kyHb/iAx4Z96CxjdXkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714175276; c=relaxed/simple;
	bh=ZsWzIpaR9CSYq0CvpDzPnkeIOhd2hUKvD6r3f7GIRiI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=clB/GF40mHrD4gLuB5h/7b61/7soWJ+mTqdDqHBxmp9XUXXPNyLphoXVCr+lsMTYj6v7uFolzBuc5WDKx3eVudo5jdXb7rnsWywy4wTEXIcexLh8X3Ofy4Prd9pDRvhhsCPQ6hXxuH5LyGwg20/QGxv3mwki1ZoKITVPRSPV71I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QM5riQ0k; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ecec796323so2703999b3a.3
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 16:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714175275; x=1714780075; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iwcfQVICuUdFlm/Y2tOZu5c2YFwKEFgWTbc6zySzz8E=;
        b=QM5riQ0khnesRXlQoVFO8GqCRxgxZBC2IhFW39Jb9vQt8jLeHn8kDdKGLb59WnNN/v
         L+Jal8mytfOf2cEXJ3giLyOVMrH12Url8TIMJaBaJowI+IMU/9DaSdXD65xw0uuwNjiG
         vXhavXu2YXLp1UsktINkfcYazl4mUfKuv21BqzCEWo25Thni5Z0ftD9SUwqrt3Sz03ug
         FQnoyihdvH+9Qa4beSsV9cjmgFfKeEP9xN04wDUoVxAvVuixa21IV/PpX7KgN06TexPg
         1oakf5ekIbuQO68tJc7gpUHrPSEjQYNGzJn8HMRPmVrygMzHCBH0ICo77V3Cc+ipHhRh
         iAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714175275; x=1714780075;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iwcfQVICuUdFlm/Y2tOZu5c2YFwKEFgWTbc6zySzz8E=;
        b=J/ZI5zPCkhzm6jOrCJyzrTG7+ZsrX06rnODPs5bH6wD/akjsZrNQk8U5M0axFU4j6Y
         OM/AHOHMtJm+UQjncLXMX3dmlKGMrRyY+DuXdbbh/L5yB2SdxwOQu/1mFoRyH5HEm7Ic
         nIwkXOesYudlFVKJKlE8JOqQrr67BwVVVi5iVbxeuyp/m9JyjCtxG96qMhJszvffrwO6
         qfFHb85/11OROeCkyDhpEzIa4w0O+pGFTND/tFLdsWBiMeH2AKbmjauZcv1+POYbjZq1
         U/ptERoqvqvp8AcWIn/azSHqQpGf9Mut9kJEKNdGxk/KN8SX4dcPB/DBbgPSZxwI/h7t
         KIhA==
X-Forwarded-Encrypted: i=1; AJvYcCUjwRSXqX5pPskAsjUMTkD4ujlD+SeYziRYGPazQDGIOG76ve3pl2Syhmm8UCvvSTfrcZ6YYK+F5+D79PnFrc0gMdeU
X-Gm-Message-State: AOJu0YxHJc9DLIzmf6H2iHcdf8P97lCo882PIV7Sf76/GcOqBu+Pat2L
	GqznjCr8BhKJQ8nhjnJWgI1pj2ZU4svfnq142bvUl4E5GHbgTNqr
X-Google-Smtp-Source: AGHT+IGyr2ffcr8v4GNubmOHrFVOjfZTZ94e0Ld+pBXJDv4lG7AppGPvEKMPGNF+qCc5ThfJ2gyjNw==
X-Received: by 2002:a05:6a00:2384:b0:6e6:f9b6:4b1a with SMTP id f4-20020a056a00238400b006e6f9b64b1amr5405445pfc.11.1714175274752;
        Fri, 26 Apr 2024 16:47:54 -0700 (PDT)
Received: from ?IPv6:2604:3d08:9880:5900:89b8:4c93:e351:1831? ([2604:3d08:9880:5900:89b8:4c93:e351:1831])
        by smtp.gmail.com with ESMTPSA id a8-20020a62bd08000000b006ea81423c65sm15889706pff.148.2024.04.26.16.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 16:47:54 -0700 (PDT)
Message-ID: <40cce745854cf1fd0ea63b2e636828c87442a21d.camel@gmail.com>
Subject: Re: [PATCH dwarves v8 3/3] pahole: Inject kfunc decl tags into BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Xu <dxu@dxuuu.xyz>, acme@kernel.org, jolsa@kernel.org, 
	quentin@isovalent.com, alan.maguire@oracle.com
Cc: andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	bpf@vger.kernel.org
Date: Fri, 26 Apr 2024 16:47:53 -0700
In-Reply-To: <1f82795e9ae651a3d303d498e2ce71540170b781.1714091281.git.dxu@dxuuu.xyz>
References: <cover.1714091281.git.dxu@dxuuu.xyz>
	 <1f82795e9ae651a3d303d498e2ce71540170b781.1714091281.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-04-25 at 18:28 -0600, Daniel Xu wrote:
> This commit teaches pahole to parse symbols in .BTF_ids section in
> vmlinux and discover exported kfuncs. Pahole then takes the list of
> kfuncs and injects a BTF_KIND_DECL_TAG for each kfunc.
>=20
> Example of encoding:
>=20
>         $ bpftool btf dump file .tmp_vmlinux.btf | rg "DECL_TAG 'bpf_kfun=
c'" | wc -l
>         121
>=20
>         $ bpftool btf dump file .tmp_vmlinux.btf | rg 56337
>         [56337] FUNC 'bpf_ct_change_timeout' type_id=3D56336 linkage=3Dst=
atic
>         [127861] DECL_TAG 'bpf_kfunc' type_id=3D56337 component_idx=3D-1
>=20
> This enables downstream users and tools to dynamically discover which
> kfuncs are available on a system by parsing vmlinux or module BTF, both
> available in /sys/kernel/btf.
>=20
> This feature is enabled with --btf_features=3Ddecl_tag,decl_tag_kfuncs.
>=20
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Tested-by: Jiri Olsa <jolsa@kernel.org>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> Tested-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---

I tested this patch-set on current master with Makefile.btf modified
to have --btf_features=3D+decl_tag_kfuncs, the tests are passing.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
(But please fix get_func_name...)

[...]

> +static char *get_func_name(const char *sym)
> +{
> +	char *func, *end;
> +
> +	/* Example input: __BTF_ID__func__vfs_close__1
> +	 *
> +	 * The goal is to strip the prefix and suffix such that we only
> +	 * return vfs_close.
> +	 */
> +
> +	if (!strstarts(sym, BTF_ID_FUNC_PFX))
> +		return NULL;
> +
> +	/* Strip prefix and handle malformed input such as  __BTF_ID__func___ *=
/
> +	func =3D strdup(sym + sizeof(BTF_ID_FUNC_PFX) - 1);
> +	if (strlen(func) < 2) {
> +                free(func);
> +                return NULL;
> +        }
> +
> +	/* Strip suffix */
> +	end =3D strrchr(func, '_');
> +	if (!end || *(end - 1) !=3D '_') {

Sorry, I'm complaining about this silly function again...
This will do an invalid read for input like "__BTF_ID__func___a":
- 'func' would be a result of strdup("_a");
- 'end' would point to the first character of 'func';
- 'end - 1' would point outside of 'func'.

Here is a repro with valgrind report:
https://gist.github.com/eddyz87/dfd653ada6584b7b7563fbfe66355eae

> +		free(func);
> +		return NULL;
> +	}
> +	*(end - 1) =3D '\0';
> +
> +	return func;
> +}

[...]

