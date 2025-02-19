Return-Path: <bpf+bounces-51900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8A2A3B008
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 04:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45FC61896426
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 03:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383BF19D8A9;
	Wed, 19 Feb 2025 03:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImRq4q1K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DDA17BA5;
	Wed, 19 Feb 2025 03:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739935555; cv=none; b=ak+Yx6pfinA3hZ8f2CAIBzZaVjDQnoIM1EMTMhUvD1FhxCPqiq5gXPofDjIc3ygo7KIqSroxrew8m/7rCTM7agaTOylokntyg7z0plhWkqj2GnTrnxK1p6zue3xaI8GO7/aqzkd/eWPRBVrcofrpkEXeYjE+6UEgWeSZDgyfyTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739935555; c=relaxed/simple;
	bh=MaaRbMsd/SMoOsb8lghfhLA2YiRhcJNBHAyoYnOWDr0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N2/cuek1gUN1tzDrFxtolL75x9jIEOtnIGjkgtmP90GBz79MtJvS8PvFSGZlX4+76xUP5COftO3GHmVyFt6K5y5kRofag3wUwV50xn/zdik9ZL5wN9XFgRo2kBtoV1zRt/+qSEB/w222QaaCxEOiZCv9UruOsQih0aThtcLOvF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImRq4q1K; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220ca204d04so85512515ad.0;
        Tue, 18 Feb 2025 19:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739935553; x=1740540353; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VsHh2UfYIF5c9plwhNmEbGRU56oyLElJLZiPhtm6R4A=;
        b=ImRq4q1KLye1v2T6R7iCplBDN/V+qrTZ5iHTWtCf+4xwjy1K/TnWBsFZccAPLsBNI0
         x7mNVJ1VdqtpVxqQqrR4SfWk6qrmJ4A9zirWu9+3+uVmH+FQGdqtypKD1mXAvwaH81+o
         UX1rLXTOfHwPt2wy8kmP2h2hmON8sInE/n3Sa4cvCD9HX/YtfkxwzYnhMUz0N5wf5qvu
         zViq5/2onk+hoSACRabABP/Rz6h3dS+oJT7EDfv/gefPmbLs7DrgNNDJY7hsqwY4sd6U
         9/MJBfRF/seECjrx65Jitr3IxC3G73ynWVnajqIwQLQieIta6yQ666ut9LdhXXy7rY4W
         Yh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739935553; x=1740540353;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VsHh2UfYIF5c9plwhNmEbGRU56oyLElJLZiPhtm6R4A=;
        b=HFvfd3XoDDZX40dHMKJ76/kxqVWocJGRyb6GDz4SYfp5RfN4wR/AZA89xnlw6C5Mjn
         XGlV6f3o9OZi6V7FbmA2mj9iyYaLOvYcPI/ULWIyFsWOVp+u1edQCVpYE7DI8t4UjSD0
         V9y8RMR1dKJlVrIjbK6GLo4F/38UyT3YYJRrAbrx5CoM7zrkt5ee/QT0kEbYseyCKzV5
         Yq6Z3oNyhzV0iWB8RpiqLq3FTsLEBhzl6z5wUNwQgi+PoCRgYQYe0FhAWr6XBMIR4juH
         zciNuw0mQfTE+PeAwSrnQXhJAuRCGmeWi3fdweFukGfGzG7XcSDcKeOJkvRKc6txzQVC
         Oj+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWgCb1p4ydcz3lAa8jvc3GEKxNSf+gAs2I16SJqqepfe9a008BuAwGDLxv0YS2FGWmi7e8=@vger.kernel.org, AJvYcCX1H5sS1B5cPYmPC2lgUyanKZBclCg+Z6ezHg0s2dtFrrSy1l18r2DIU2nmVqw75YS34Q9UMgyXMw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEHDfLzPWN8LyrNmcr6E9crIlyCibNUgHKdqOFKL5BqE6z/0zs
	/CDMeFIWHDAKssThOVw8f/rm89MjmMn5Jr9UoFvulX7AepTKFdDS
X-Gm-Gg: ASbGncvBk5ykmNhLWZJWJd8W7oCtIy8/GkqXgMi35Ucs+QsZcNAN3a4F3AQq8Gvl+T2
	FDgBJm9O2cOJ+Rl+IvIqYYJCX4UvZEfAAw1yDkFMGyn+BE8SBiAYjUzKEGMiypbeJlv56C+0AU4
	XsNFP/EZckWxffLWRH7EOKZQ5Yh+uRYMfQFR6klKkNRh6xC4AIKFSqSdHJPYhIckELvGrQFqLzK
	xmFDggXs2t8J9i26uAg+L9bhlz2oiFQ8AE0z2DbhbgmTABzhby9Bu4Lo6I/8MhDgj01YixtTa9x
	JwYo45FF+07g
X-Google-Smtp-Source: AGHT+IHF6Y+irsLKHTt7tog2nw7DSLlfODnoCNYpD5zKT13flMlg9d4Gprni6OBJCAmP8kcWJDMLgQ==
X-Received: by 2002:a17:903:32c5:b0:21b:d105:26b9 with SMTP id d9443c01a7336-22170968905mr34171455ad.16.1739935553522;
        Tue, 18 Feb 2025 19:25:53 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55866f9sm94936535ad.230.2025.02.18.19.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 19:25:53 -0800 (PST)
Message-ID: <3717ee0f4ce384311ac551825a455ada6479f16e.camel@gmail.com>
Subject: Re: [PATCH v2 dwarves 1/4] btf_encoder: refactor
 btf_encoder__tag_kfuncs()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves@vger.kernel.org, 
	bpf@vger.kernel.org
Cc: acme@kernel.org, alan.maguire@oracle.com, ast@kernel.org,
 andrii@kernel.org, 	mykolal@fb.com, kernel-team@meta.com
Date: Tue, 18 Feb 2025 19:25:48 -0800
In-Reply-To: <20250212201552.1431219-2-ihor.solodrai@linux.dev>
References: <20250212201552.1431219-1-ihor.solodrai@linux.dev>
	 <20250212201552.1431219-2-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-02-12 at 12:15 -0800, Ihor Solodrai wrote:
> btf_encoder__tag_kfuncs() is a post-processing step of BTF encoding,
> executed right before BTF is deduped and dumped to the output.
>=20
> Rewrite btf_encoder__tag_kfuncs() into btf_encoder__collect_kfuncs().
> Now it only reads the .BTF_ids section of the ELF, collecting kfunc
> information and adding it to corresponding elf_function structs. It is
> executed in btf_encoder__new() if tag_kfuncs flag is set. This way
> kfunc information is available within entire lifetime of the
> btf_encoder.
>=20
> BTF decl tags for kfuncs are added immediately after the function is
> added to BTF in btf_encoder__add_func(). It's done by btf__tag_kfunc()
> factored out from the btf_encoder__tag_kfunc().
>=20
> As a result btf_encoder__tag_kfuncs(), its subroutines and struct

Nit: btf_encoder__collect_btf_funcs() is the one removed,
     btf_encoder__tag_kfuncs is renamed.

> btf_func type are deleted, as they are no longer necessary.
>=20
> Link: https://lore.kernel.org/dwarves/3782640a577e6945c86d6330bc8a05018a1=
e5c52.camel@gmail.com/
>=20
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

>  btf_encoder.c | 192 +++++++++++++++-----------------------------------
>  1 file changed, 57 insertions(+), 135 deletions(-)
>=20
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 511c1ea..965e8f0 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c

[...]

> @@ -1199,6 +1230,16 @@ static int32_t btf_encoder__add_func(struct btf_en=
coder *encoder,
>  		       name, btf_fnproto_id < 0 ? "proto" : "func");
>  		return -1;
>  	}
> +
> +	if (func->kfunc && encoder->tag_kfuncs && !encoder->skip_encoding_decl_=
tag) {
> +		err =3D btf__tag_kfunc(encoder->btf, func, btf_fn_id);
> +		if (err < 0) {
> +			fprintf(stderr, "%s: failed to tag kfunc '%s': %d\n",
> +				__func__, func->name, err);

Nit: btf__tag_kfunc() already prints to stderr in case of an error,
     this printf is unnecessary.

> +			return err;
> +		}
> +	}
> +
>  	if (state->nr_annots =3D=3D 0)
>  		return 0;
> =20

[...]


