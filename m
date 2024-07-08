Return-Path: <bpf+bounces-34163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD19C92AC4B
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 00:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5833C1F230A5
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 22:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF811514DD;
	Mon,  8 Jul 2024 22:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJfeQ9qq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F81A56452
	for <bpf@vger.kernel.org>; Mon,  8 Jul 2024 22:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720479288; cv=none; b=tx/YAhcHc+oEhMHZ1ZGZ4pJvLFiBmMQY2hV0cCoKaOW+sEjvjAS7qWCUxVUFiGXbXmrte1E6fVPNWFs0JXraVnRmJ8jL52j7m30G4fgQeH/bafjnlJDOyHxmVHkRXP1uN7I//s5KCqotc980WkoI1HJYpzamb/pMQX4wXF8PyAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720479288; c=relaxed/simple;
	bh=J9QRlCZOHyqlev9VP3/zG6yX0+BQmufJbHJiD+wIjC8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nlo/fZxjzGrJuMKbhWyl5zB2SZBTjm8oGmelymXTiJF1q1Aqly2swjWzpEQQ3tZvY1xdSrxdP0s+v2k8GP0zFQa/jWrCvVhQuZ2Hbbb1vuoaRCVZZi9nJHtHhP4zvcK6haRYxsdqq+AYOBvHK6Vo2kXcHFlx1zlXy8g4e7maLHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJfeQ9qq; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fb3cf78fa6so25024775ad.1
        for <bpf@vger.kernel.org>; Mon, 08 Jul 2024 15:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720479286; x=1721084086; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uAfSHxhvx+x6cHOa/VG29qByFhfPwRPLOzh6DsREAkQ=;
        b=RJfeQ9qq2TMJLP0GYTWtOOhTUNREibwfSdj0e39+68zr1/TYpEOkBjrkKZDwDkxeFg
         vakcgMGB7q4IMf7C9zcSyLKbRtX5nUMAan+xRdux1zjjoX8zc19dDmyyCJAYP83uOFRL
         k8n8f27EMrsEFBJT2saZwShVgUPBtCI4DNzYl0SNvNQFy62JZDsRJj4RbFU9PRjeq9/I
         VRzlEWXomt3lx0zKep7PuuxiyFgplCMPaL2bGzahj8roVwP2PRf/8DexlkcnbBFXUIea
         Rk1+H9P8C5IN2FU1MVy3DNiqvDaUuWuynzCA/QMM+rqEjM0EBBAe4BEGqAC5fpFPZasp
         Vx6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720479286; x=1721084086;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uAfSHxhvx+x6cHOa/VG29qByFhfPwRPLOzh6DsREAkQ=;
        b=N6PHcpQdNlfikLMQiONi5tlbxGUk3IFtRW6pGL94hn3nA2XPT1DzNPuwHSVyRXqeDp
         XX7Qg+oeUWUKQZB+E67dgqxMhAWCtVV1I2lIONxWcjDP7EfMZfQnUrjFWB02Okk83IfX
         m1FbSNYf8ehXkph7BzuYu8Y/MYj4VgY76HNlgmDlNUgC3lmppLKaqRko3uJXJVLG6JuV
         qZQ+57wkZ0IVpcwP/mruapx4ElKBz1orBeRJK9nmUj78bzYsqIUEE/80u1fefCPz1qEk
         jk5/6EgprImB1Ua7MGJCZ7mLMeIDYFBhsVEFS6Fa00R0KayaHh97VgcmUe08fMB7/Yeq
         sbWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWY6hmAiIGOdkRY4DIsffM6KEJIythpnzUIDxINDjOajOqB+P5j4glzKYTXA9AxNe8LwqBA1rrrMc7S/WYIBl5y0f2T
X-Gm-Message-State: AOJu0YxgVEILvnHZR310yZXK2oVqeHCcYblG4ATxVY47pidLQeobDsny
	3diaeCWu2RATdCjmySELiUexTN3zWWA5kf6UZ92xXG7ZcqsZD7p4
X-Google-Smtp-Source: AGHT+IGy8YqsXo+QHVTDaTZtR8HV4GMP+x4bkOiY/Ia3gZxCfZ4fYYK2aIJe3saHkTvMaZmQzHe9iA==
X-Received: by 2002:a17:903:2442:b0:1f7:11dd:6d8e with SMTP id d9443c01a7336-1fbb6ee18bfmr8889525ad.48.1720479286315;
        Mon, 08 Jul 2024 15:54:46 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab79e6sm3758975ad.141.2024.07.08.15.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 15:54:45 -0700 (PDT)
Message-ID: <9c48d70561d2e7334c17d0c79816b987660c5c84.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/3] bpftool: improve skeleton backwards
 compat with old buggy libbpfs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com, Quentin Monnet <qmo@kernel.org>, Mykyta Yatsenko
	 <yatsenko@meta.com>
Date: Mon, 08 Jul 2024 15:54:41 -0700
In-Reply-To: <20240708204540.4188946-2-andrii@kernel.org>
References: <20240708204540.4188946-1-andrii@kernel.org>
	 <20240708204540.4188946-2-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-08 at 13:45 -0700, Andrii Nakryiko wrote:

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
                                                                 ^^^^
                                             nit: this still prints extra w=
hite space

[...]

