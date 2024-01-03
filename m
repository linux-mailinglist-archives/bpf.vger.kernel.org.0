Return-Path: <bpf+bounces-18918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 791758236DB
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 21:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 226182878BA
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 20:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43191D553;
	Wed,  3 Jan 2024 20:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTVs35K3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CB71D550
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 20:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cd1aeb1b02so8363761fa.2
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 12:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704315456; x=1704920256; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XNrzazuJq5yosnVwrmw0L3gsVsNd7R8WqviJE3FhP1c=;
        b=PTVs35K3wJJpUfOG8ZtA0KjkXcpB2uGV0jtsNNqkzWhcdQYbe0RwDjvFJt0GxZre9a
         0lpFG8AmiKVRYGhqiuGHP2iASVysbo3IaIYl0/ownsi7Izw0nYa54HMon04e3iB6qltH
         f0zl8vP9Ll9lLKwyBZ4nkB0ogWZHNwzLkbSBMvVsOISMGzthqS9F7XtBDvoor/Mm5ekv
         0K8wh6g+WGqoGmWoTJMqfY/i8/xxY4PcEs4ZJMQoGYlkvTqFnFF/O1dBTabJD8k7PoRd
         qBRC217v5rCSmcDQm5VK+wSl1+LdIHuhrA0JcrhXlw3Xc9K34auzLFEzmfgBjBlBWr1O
         em0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704315456; x=1704920256;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XNrzazuJq5yosnVwrmw0L3gsVsNd7R8WqviJE3FhP1c=;
        b=cDEunHhPvVAfpfrgzjOAX4D412fRcjimxf0ozLyoo7ekzWtlJiRJC3loRGfBTllp2D
         usjENyo/Yix3vIC4sC+Y3H3luff3ufVaXlyAdvvhMnzmmK4qOGNMIqXhh87oRYU2uqo1
         VVfv04W5oJKQRiF7OJJYukDGisotWme4ZEHedmRZxGdCnY+ygkA+P/wklxmK3P6SmzDC
         RYoNckuzZnVgmIAUu/Y7ZRJch51T7aPip3TNcH/EJMxw9bJRFHI+jDW/clzNLAL2nYAl
         iE7+ajaDqVaycRpKr/nPaMMLB2J8wH1jcCCjDfH3DyHlC0I85Oa2LS/pQMnI5NnIKz2P
         D6+A==
X-Gm-Message-State: AOJu0Yw5IFIirNIGcbMviWFP/bW3pKmjIOJ4x/UrFbNVNVvqnN845V3P
	nM22zrqGdwSZ8ua/ebMD1EA=
X-Google-Smtp-Source: AGHT+IGQoW1+MrsSwINwH96YeigfCMW4n474fsje3Jg0bx3rsES8bzn7irNtIlEv9e82Qs4zJ0fEmQ==
X-Received: by 2002:a2e:9d93:0:b0:2cc:d294:7df with SMTP id c19-20020a2e9d93000000b002ccd29407dfmr6656551ljj.49.1704315455516;
        Wed, 03 Jan 2024 12:57:35 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id u18-20020aa7db92000000b00554d6b46a3dsm13061433edt.46.2024.01.03.12.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 12:57:34 -0800 (PST)
Message-ID: <b40c235a580968400316d464e14a8a72f09d2013.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 5/9] libbpf: use stable map placeholder FDs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com, Jiri Olsa <jolsa@kernel.org>
Date: Wed, 03 Jan 2024 22:57:33 +0200
In-Reply-To: <20240102190055.1602698-6-andrii@kernel.org>
References: <20240102190055.1602698-1-andrii@kernel.org>
	 <20240102190055.1602698-6-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Tbh, it looks like calls to zclose(map->fd) were unnecessary
regardless of this patch, as all maps are closed at the end of
bpf_object_load() in case of an error.

[...]

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index f29cfb344f80..e0085aef17d7 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[...]

> @@ -5275,13 +5289,11 @@ static int bpf_object_create_map(struct bpf_objec=
t *obj, struct bpf_map *map, bo
>  		create_attr.btf_value_type_id =3D 0;
>  		map->btf_key_type_id =3D 0;
>  		map->btf_value_type_id =3D 0;
> -		map->fd =3D bpf_map_create(def->type, map_name,
> -					 def->key_size, def->value_size,
> -					 def->max_entries, &create_attr);
> +		map_fd =3D bpf_map_create(def->type, map_name,
> +					def->key_size, def->value_size,
> +					def->max_entries, &create_attr);
>  	}
> =20
> -	err =3D map->fd < 0 ? -errno : 0;
> -
>  	if (bpf_map_type_is_map_in_map(def->type) && map->inner_map) {
>  		if (obj->gen_loader)
>  			map->inner_map->fd =3D -1;
> @@ -5289,7 +5301,19 @@ static int bpf_object_create_map(struct bpf_object=
 *obj, struct bpf_map *map, bo
>  		zfree(&map->inner_map);
>  	}
> =20
> -	return err;
> +	if (map_fd < 0)
> +		return -errno;

Nit: this check is now placed after call to bpf_map_destroy(),
     which might call munmap(), which might overwrite "errno",
     set by some of the previous calls to bpf_map_create().

[...]

> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index b5d334754e5d..662a3df1e29f 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -555,6 +555,30 @@ static inline int ensure_good_fd(int fd)
>  	return fd;
>  }
> =20
> +static inline int create_placeholder_fd(void)
> +{
> +	int fd;
> +
> +	fd =3D ensure_good_fd(open("/dev/null", O_WRONLY | O_CLOEXEC));

Stupid question: is it ok to assume that /dev is always mounted?
Googling says that kernel chooses if to mount it automatically
depending on the value of CONFIG_DEVTMPFS_MOUNT option.
Another option might be memfd_create().

> +	if (fd < 0)
> +		return -errno;
> +	return fd;
> +}

[...]



