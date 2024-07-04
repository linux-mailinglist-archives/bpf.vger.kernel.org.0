Return-Path: <bpf+bounces-33910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EAA927E4D
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 22:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9399C28661F
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 20:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4885913791C;
	Thu,  4 Jul 2024 20:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlKqX6Ae"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7059818AED
	for <bpf@vger.kernel.org>; Thu,  4 Jul 2024 20:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720125112; cv=none; b=GWAzmYKNdFRY5O+s9nca4ZbWrUo/5p/DPT/s0L3F8d0MsYDUkV3q9PWMVe/42VO6TqZnyZwTzr3pMvmNeh/rRtVPf+DiuJmh5ObPYowb2k6nP3yxUtNAMt0rKSJA9y81J2tY2VMG59dkkhE1RX9UMy6VeAcrHM8KFLRbkoy/2r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720125112; c=relaxed/simple;
	bh=fhyswLsE0t4x8Njg2oW2JBF/Gta7ZanyeMDmw4twCYA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jPxZA6basDriGhSVtCh9y6EAMwWOe7jh0Ln72v9ZQ433E6+lFp3I5Z2zCwliEV9K7XxqLte2hdu+xWhSoNRLUwIelBxM5N6ZGt1AWdMv0iMjZV8DQwuJQxjzE3cQ1L1TFOAFpuPULwbM2JJQIcaja4qFu2EEXIUFQ/Jiebhifh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlKqX6Ae; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5b9778bb7c8so526163eaf.3
        for <bpf@vger.kernel.org>; Thu, 04 Jul 2024 13:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720125110; x=1720729910; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aMqRN6QShO8s3H4b8s2c/ZzpQGNJGm7Ax/bSoDTITZs=;
        b=JlKqX6AeTbRoYKlZl/US1avzVAlmFe7JimQSL0G23sjDiur6PgyWEWzfz8/6QitV7m
         jXSmoo72LLCXId/+TCQsJJgKxe1yQatLM1vWvGtYaTF0HzcifOr5ugqTPR+PIeX47OMd
         iTCCk2DbsFCAasuZYbOcLNAyl1cvLQYVebfFGJgj4jXvSz/SnU+gYD468HkQytG19HfG
         vkL99O4j+V6pLfroVAIU0BKz6H6bxSn5e0E+rxz4f26lIK85LKk9u/0wK6fCBYR5gIEc
         dvn/Y3TdiFXEsQkH436Z/5jgs4bl29FeUSHIcOabsxA5kCavjGcDwfa9ilbwLiCIwVgb
         kl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720125110; x=1720729910;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aMqRN6QShO8s3H4b8s2c/ZzpQGNJGm7Ax/bSoDTITZs=;
        b=q2vFnkZ2q1LtMUguCqAijWEfO4n59EEmz0FsrDaSvjhHRTfd3X8qGiUovZhhq+vlCo
         AvfrJxeCiUkV1Yzccfe5Yo1mmETwzwjnjALw3MovzvkUTDnpdNcyreqZCMHvsCF2/MDK
         KX8O9bBNIKYBzJvgcS9GF6i597MIysZwwX/Po1L7EdZEjHxuoolkXX5m2MfD76hnSaoK
         VBowaipN4bSvohuTZYisxCV9gagRM14QG8q75Me8w2g97XS3QTidGX8Oxl+HKHY0CEyc
         lKwkbwXtfoqhJUtCELvGdOBLSNdNdYVRaP2ZZYlyypCuolkAbnvm5zxXhibnm2Pzd1ra
         5EZA==
X-Forwarded-Encrypted: i=1; AJvYcCUi/305JYnFchmx012WkeyTPvw+TbFkP3bKwNDe4n/D/RVJWo5hlBydIydBCOn3/pS1RVlVJ3q25d2TYgmPpCKdTjXP
X-Gm-Message-State: AOJu0YztqSVugbT/QgH5019B8Vs7BdvWb6SWF8sTt0gOyOqwpbjG7hiE
	cVj7dlLXwV/cYSr66yCVkJmbIJxCkiyT6ijxFHEeiTKEWW4ZWhol9yDvmQ==
X-Google-Smtp-Source: AGHT+IEumGe+dAOyv/6mAalJfWBip8DYA8q3jZTZ9f5+JztxC2uPilNTeZW45BD+1Wp55CBvsO1oYw==
X-Received: by 2002:a05:6358:949d:b0:1a6:a69b:b171 with SMTP id e5c5f4694b2df-1aa98c1f854mr250464955d.15.1720125110419;
        Thu, 04 Jul 2024 13:31:50 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6c8ebf1asm10141406a12.74.2024.07.04.13.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 13:31:49 -0700 (PDT)
Message-ID: <dbb10260a5c7df773f8205333e1433557a22d3c7.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpftool: improve skeleton backwards compat
 with old buggy libbpfs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com, Mykyta Yatsenko <yatsenko@meta.com>
Date: Thu, 04 Jul 2024 13:31:44 -0700
In-Reply-To: <20240704001527.754710-2-andrii@kernel.org>
References: <20240704001527.754710-1-andrii@kernel.org>
	 <20240704001527.754710-2-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-07-03 at 17:15 -0700, Andrii Nakryiko wrote:
> Old versions of libbpf don't handle varying sizes of bpf_map_skeleton
> struct correctly. As such, BPF skeleton generated by newest bpftool
> might not be compatible with older libbpf (though only when libbpf is
> used as a shared library), even though it, by design, should.
>=20
> Going forward libbpf will be fixed, plus we'll release bug fixed
> versions of relevant old libbpfs, but meanwhile try to mitigate from
> bpftool side by conservatively assuming older and smaller definition of
> bpf_map_skeleton, if possible. Meaning, if there are no struct_ops maps.
>=20
> If there are struct_ops, then presumably user would like to have
> auto-attaching logic and struct_ops map link placeholders, so use the
> full bpf_map_skeleton definition in that case.
>=20
> Co-developed-by: Mykyta Yatsenko <yatsenko@meta.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Silly question, here is a fragment of the profiler.skel.h generated
with bpftool build (tools/bpf/bpftool/profiler.skel.h):

static inline int
profiler_bpf__create_skeleton(struct profiler_bpf *obj)
{
	/* ... */

	map =3D (struct bpf_map_skeleton *)((char *)s->maps + 0 * s->map_skel_sz);
	map->name =3D "events";
	map->map =3D &obj->maps.events;

	/* ... 4 more like this ... */

	/* ... */

	s->progs[0].name =3D "fentry_XXX";
	s->progs[0].prog =3D &obj->progs.fentry_XXX;
	s->progs[0].link =3D &obj->links.fentry_XXX;

	s->progs[1].name =3D "fexit_XXX";
	s->progs[1].prog =3D &obj->progs.fexit_XXX;
	s->progs[1].link =3D &obj->links.fexit_XXX;

	/* ... */
}

Do we need to handle 'progs' array access in a same way as maps?

[...]

> @@ -878,23 +895,22 @@ codegen_maps_skeleton(struct bpf_object *obj, size_=
t map_cnt, bool mmaped, bool
> =20
>  		codegen("\
>  			\n\
> -									\n\
> -				s->maps[%zu].name =3D \"%s\";	    \n\
> -				s->maps[%zu].map =3D &obj->maps.%s;   \n\
> +								    \n\
> +				map =3D (struct bpf_map_skeleton *)((char *)s->maps + %zu * s->map_s=
kel_sz);\n\
> +				map->name =3D \"%s\";		    \n\
> +				map->map =3D &obj->maps.%s;	    \n\
>  			",
> -			i, bpf_map__name(map), i, ident);
> +			i, bpf_map__name(map), ident);
>  		/* memory-mapped internal maps */
>  		if (mmaped && is_mmapable_map(map, ident, sizeof(ident))) {
> -			printf("\ts->maps[%zu].mmaped =3D (void **)&obj->%s;\n",
> -				i, ident);
> +			printf("\tmap->mmaped =3D (void **)&obj->%s;  \n", ident);
                                                                  ^^
                                              nit: this generates extra whi=
te space
>  		}
> =20
>  		if (populate_links && bpf_map__type(map) =3D=3D BPF_MAP_TYPE_STRUCT_OP=
S) {
>  			codegen("\
>  				\n\
> -					s->maps[%zu].link =3D &obj->links.%s;\n\
> -				",
> -				i, ident);
> +					map->link =3D &obj->links.%s; \n\
> +				", ident);
>  		}
>  		i++;
>  	}

[...]

