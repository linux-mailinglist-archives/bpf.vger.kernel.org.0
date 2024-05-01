Return-Path: <bpf+bounces-28311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 925478B837C
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 02:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04714284D72
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 00:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE71C7E6;
	Wed,  1 May 2024 00:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5Zv9hn+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B08163
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 00:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714522076; cv=none; b=Ob01bYNhxonCSEq653kl5b3Q5UJjN917pxSJKF2U3eM/hlnaePuCiHx/GwtGFuqxS382yb48WU7UC3UXRk3MJdoz8Re+ZB5zE5uQ1IkS19ShVgB8v+L5+SxMubPrVNaVCtN9TE/c4P1Nv4G9RSrceNZLsYEijjyMFZ1/uD1TM9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714522076; c=relaxed/simple;
	bh=SMHtT8jc00mCD1akgETdppXAin9dtuqpb3k7IAjzuXc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c4EUo9TT0qe/MNzp9j3HXvQ9yFoxA+a/QNkcsO2z1+eKBhEn0XwfOsQfF+sbFQs113qBFLtVyMPC8F7usVLsBtp+Hq1CISI8BqDrW1jnXTd7ywwYnAb6IemiUDkGW7NR3DP/oEw8QqMG9jX6NaHZ4N0/XAh5Y/99bm7IzbZ7h8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5Zv9hn+; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ec486198b6so10734675ad.1
        for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 17:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714522074; x=1715126874; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y10623V5ycT0e8WjgWKkrw9YelTCtB/WyFVhGRJQv80=;
        b=X5Zv9hn+fdaxlxYBD3I7qRrJfyk17LkQEQ+EW5etZrX4gehZk2nr4gNNIe7z7L96wR
         GG/tMP740wOvASoRqhuVFd8D451/XCfVHqt2AgneFu2nc36NaPxAb859kEeJEqnLCPAS
         iUJCudvmvGpuIjQNv+seJIxWFPOF3rBA60Oso/IJ1sodCa1e3Hlqvg6bRdEKKcmvu54/
         qn0vbhjVRW0ygnyT6xbZCGZbJWyKbhOVoj4LAOk4uIAAxS4yx1W9u96WrEGgAk1YYdRH
         B7wv6JdFOK0ifyyGt/KGlPRGtSnp26lLd1u5BDFApkZxGLO9VfSgFoLH95OKfqC4XxJh
         60/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714522074; x=1715126874;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y10623V5ycT0e8WjgWKkrw9YelTCtB/WyFVhGRJQv80=;
        b=cH3T5EwFp3cvkAdwp2LxiabxmJ5aivufMyf82nhAXYGDFLk3jaf7j339LI0mzTvbLJ
         chRnP9xZolD2tS5vRtkkbdHzYqIKuMhN6F7NSo3Han+HSoDQ1RKNafLvVJwMPXake4GU
         x8JUnoaIS8ulB5ZHOoKEOR0Prz2I3LOT80cnmiX4UxTJaPIj4X046nN3ATv0aw9dm9rn
         XdjLx8feV9aKrqCRgk6tu5hamEkckIjSCIIwCznboeZOPYxn8UkMdvnDMASHCVVrKv7s
         8JzafzOZC7s762cENafhr+0V/QNv+aZCEa5MdxAxwn4jExrM+6ZuOOtG68l/kJsk+HkH
         zDJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQBjgBgTD+iGOdrrFBHV+f67BPYPfsvp6yJROn5v0WdcsSWUpN8zBDHHSYATxEPmwhZaD93pHEvh8DDsGhvFPr0ZYY
X-Gm-Message-State: AOJu0YyP78RDKzqOcbgIYJ8fsWcKZlLdvwkFzlqg4KsIFBoJAazHuSth
	a/vEIfPkrrVi3wL/fj2N3LIbmYpU52Zghbg+nv9SwaV6oucerBdi
X-Google-Smtp-Source: AGHT+IFnstaBrEKISJS+iMBnkPaA7cnhOS4PwyU5TtiivEiLuEveKLLVGPuUVFB/HyBd7/+c4qjJfQ==
X-Received: by 2002:a17:902:7008:b0:1ec:3c71:eae7 with SMTP id y8-20020a170902700800b001ec3c71eae7mr865523plk.47.1714522074166;
        Tue, 30 Apr 2024 17:07:54 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160:313a:f4fd:13d2:b9eb? ([2604:3d08:6979:1160:313a:f4fd:13d2:b9eb])
        by smtp.gmail.com with ESMTPSA id l14-20020a170903120e00b001e555697361sm22999060plh.220.2024.04.30.17.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 17:07:53 -0700 (PDT)
Message-ID: <92c14d14a455650e46089c6858e810a63aad0587.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 04/13] libbpf: add btf__parse_opts() API for
 flexible BTF parsing
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org, ast@kernel.org
Cc: jolsa@kernel.org, acme@redhat.com, quentin@isovalent.com,
 mykolal@fb.com,  daniel@iogearbox.net, martin.lau@linux.dev,
 song@kernel.org,  yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org,  sdf@google.com, haoluo@google.com, houtao1@huawei.com,
 bpf@vger.kernel.org,  masahiroy@kernel.org, mcgrof@kernel.org,
 nathan@kernel.org
Date: Tue, 30 Apr 2024 17:07:52 -0700
In-Reply-To: <20240424154806.3417662-5-alan.maguire@oracle.com>
References: <20240424154806.3417662-1-alan.maguire@oracle.com>
	 <20240424154806.3417662-5-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-04-24 at 16:47 +0100, Alan Maguire wrote:

[...]

> @@ -1301,23 +1302,42 @@ static struct btf *btf_parse(const char *path, st=
ruct btf *base_btf, struct btf_
>  	if (btf_ext)
>  		*btf_ext =3D NULL;
> =20
> -	btf =3D btf_parse_raw(path, base_btf);
> -	err =3D libbpf_get_error(btf);
> -	if (!err)
> -		return btf;
> -	if (err !=3D -EPROTO)
> -		return ERR_PTR(err);
> -	return btf_parse_elf(path, base_btf, btf_ext);
> +	if (!btf_elf_sec) {
> +		btf =3D btf_parse_raw(path, base_btf);
> +		err =3D libbpf_get_error(btf);
> +		if (!err)
> +			return btf;
> +		if (err !=3D -EPROTO)
> +			return ERR_PTR(err);
> +	}
> +	if (!btf_elf_sec)
> +		btf_elf_sec =3D BTF_ELF_SEC;
> +
> +	return btf_parse_elf(path, btf_elf_sec, base_btf, btf_ext);
> +}
> +
> +struct btf *btf__parse_opts(const char *path, struct btf_parse_opts *opt=
s)
> +{
> +	struct btf *base_btf;
> +	const char *btf_sec;
> +	struct btf_ext **btf_ext;
> +
> +	if (!OPTS_VALID(opts, btf_parse_opts))
> +		return libbpf_err_ptr(-EINVAL);
> +	base_btf =3D OPTS_GET(opts, base_btf, NULL);
> +	btf_sec =3D OPTS_GET(opts, btf_sec, NULL);
> +	btf_ext =3D OPTS_GET(opts, btf_ext, NULL);
> +	return libbpf_ptr(btf_parse(path, btf_sec, base_btf, btf_ext));
>  }
> =20

I think that btf_parse() should be inlined into btf__parse_opts() and remov=
ed.
As a proxy for passing btf_parse_opts fields as parameters it does not
make much sense.

[...]

