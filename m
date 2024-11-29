Return-Path: <bpf+bounces-45898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1519DED80
	for <lists+bpf@lfdr.de>; Sat, 30 Nov 2024 00:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D710B214FB
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 23:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31E0198E6D;
	Fri, 29 Nov 2024 23:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oei1bURD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2636A13BAEE;
	Fri, 29 Nov 2024 23:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732921964; cv=none; b=AQEwA+RxWD2V2MIYSL/hgJe2yug0Ndztj7ARGUo5opmkDJYNaY7HzHfLmWIqe45t8XFq/bC1JhYf5enGU6Nbu5xj5/bSitMQeQPSgOJXXTCQncKd71tZQPXiRbtG1TBLV0Vr6LaWKTKd5inOoWkSf3dZxgf2e3M32qyle4EtUmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732921964; c=relaxed/simple;
	bh=5LSR8MEDDjsn4Vd6Hsv9lfmFU1uL3HPRpy/0Lp10y7g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=muzeV00qPOgTTEXZaX1zM06Qnqz+QESm3JfiSUFbHUQ7k4FKxOkCt1l06mNyKQvHXjrj6LgbRxC50rVuBAvbfAXydT58w44gBB64+VljgJrGnjPHM9cfUbYS6JM/WzCKbWzmwdNAKEuifa8JyENFjjW3GRfuLux++00tvDF7eNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oei1bURD; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2eb1433958dso1562136a91.2;
        Fri, 29 Nov 2024 15:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732921962; x=1733526762; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AwzwPxTauSo9ww8n/2YHOkT3g1m1i87bT4+NGvH7Xb4=;
        b=Oei1bURDfdmPQCebAuD0iqSxArCHBFkSQFNz3zwK4uNdFCMZV5YPuQlHi/PiQ2HqNe
         NLWFVTlY/QTSxkmpAmhE+jNnLaDdg2WKcs1vmjGAQkUe8Cr8+CpAHlcq1BzifwtsgJAl
         F6FKuktMN5gp3b0mshQfESDUt68v5TLYF3nU9b8PfE7W0RKC/TGgKd7XVpgrR5Pq678P
         t3dHK46qABiXnZ0luVAmGzM68WvFCahHA/PVop44BjhSa3nBnb4ihwggHcP/+/k+4iQ4
         Y4me1N3m1vmWXsL715q/cH6tg/yWYlwTWMEkpcUYhURtjnlf6ABIQRtXIQ+ykh+tH9QH
         g6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732921962; x=1733526762;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AwzwPxTauSo9ww8n/2YHOkT3g1m1i87bT4+NGvH7Xb4=;
        b=mmYzEEHRTUV3YHNOjDlS3rQtUla9a++aVaUg+9hKj9A48ixijpbeP2ksmQo0HyWlSj
         +4DtCVNoXpW/MCS8dPKJpF17+MJvSbT0xZBoV/GFyMcSNOAnuZ/Ei4YpqeSBLZ5JUYmN
         7IbFnGXF5Jv0FwBZbt4EnStArx8x2v7WuPPMUHOleeRGwnUzaP3L78Xn9OrraYh1MkFv
         gp9q7CE9IhoM6DpJl7PSgWUrp8Z4Jx2o1Sfj+AmiTR2i29OTPgJyvwSaZaHNc7MRtPn2
         dtNmZv0elgxfUG+MTzlF79DZSK/B2c8XVtlk2cKjgGwPiHSNRXtp0F3hKGkI1BVGSSaZ
         mrcA==
X-Forwarded-Encrypted: i=1; AJvYcCVreU24aUiH1YMlgv9yiCDHqHqajRZLvtnWqnZiLOo2YyKAdcrtJweht8XEpGiDE3IdUcJN/3ap@vger.kernel.org
X-Gm-Message-State: AOJu0YxnmE4K+aep9nvRIWo2PPm5cW9RJkbEW0cKN+H3gz7NSyqtT017
	iMrJeW8IYPCReBzZQbi+t9Bw/tCzlKsGz4Nmpe4NR56PUCdCJfCP
X-Gm-Gg: ASbGncsSj2NjKKC7+eHEC991QgdhAitYUji5LWfXTHjtz5pu7wvFgPuATGLZj4+ECq0
	jyVR/WgMcDtoezqH06DsUaefsNVEwNRlhnHvYeqjuT7sqLX0gfhiOKApzkMUycs5/VNyZ8CSSUQ
	JgJNrU4pLduFrqcJylt1EBXxjo25lCNH9pHCfOq84n2Ctg09rDvc6nmt5e1WMjNlt1xCTJ/9qkE
	t+W1tkBCx2YkiOrQj9sFNgcwkGEXsYUBjArENkP2VOo39c=
X-Google-Smtp-Source: AGHT+IH9TRH0iBbeTBD0ms711gLCgCgCufH1nWTOni9XCYfESUYimTuM0CV0Kb/15Wdm5IJBrnciZg==
X-Received: by 2002:a17:90b:1d11:b0:2ee:8008:b583 with SMTP id 98e67ed59e1d1-2ee8008b80bmr666391a91.16.1732921962388;
        Fri, 29 Nov 2024 15:12:42 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee2b007b5bsm4198966a91.21.2024.11.29.15.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 15:12:41 -0800 (PST)
Message-ID: <e1df45360963d265ea5e0b3634f0a3dae0c9c343.camel@gmail.com>
Subject: Re: [RFC PATCH 8/9] btf_encoder: introduce btf_encoding_context
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>, dwarves@vger.kernel.org, 
	acme@kernel.org
Cc: bpf@vger.kernel.org, alan.maguire@oracle.com, andrii@kernel.org, 
	mykolal@fb.com
Date: Fri, 29 Nov 2024 15:12:37 -0800
In-Reply-To: <20241128012341.4081072-9-ihor.solodrai@pm.me>
References: <20241128012341.4081072-1-ihor.solodrai@pm.me>
		 <20241128012341.4081072-9-ihor.solodrai@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-28 at 01:24 +0000, Ihor Solodrai wrote:

Note, after applying this patch I see the following report from
address sanitizer:

Direct leak of 3640 byte(s) in 1 object(s) allocated from:
    #0 0x7f12d2ac2290 in calloc (/lib64/libasan.so.8+0xc2290) (BuildId: ...=
)
    #1 0x478775 in btf_encoder__new /home/eddy/work/dwarves-fork/btf_encode=
r.c:2562
    #2 0x416f98 in pahole_stealer /home/eddy/work/dwarves-fork/pahole.c:325=
7
    #3 0x49f9b9 in cu__finalize /home/eddy/work/dwarves-fork/dwarf_loader.c=
:3263

Which points to line:

    encoder->secinfo =3D calloc(encoder->seccnt, sizeof(*encoder->secinfo))=
;

(when compiled with the following flags:
 -fsanitize=3Dundefined,address -fsanitize-recover=3Daddress -fno-omit-fram=
e-pointer)


[...]

> @@ -1355,19 +1400,15 @@ int btf_encoder__add_saved_funcs(struct btf_encod=
er *encoder)

Nit: should probably remove 'encoder' parameter and replace it with
     bool skip_encoding_inconsistent_proto
     (in one of the earlier patches, just noticed this).

>  		list_for_each_entry(s, &e->func_states, node)
>  			nr_saved_fns++;
>  	}
> -	/* Another thread already did this work */
> -	if (nr_saved_fns =3D=3D 0) {
> -		printf("nothing to do for encoder...\n");
> +
> +	if (nr_saved_fns =3D=3D 0)
>  		return 0;
> -	}
> =20
> -	printf("got %d saved functions...\n", nr_saved_fns);
>  	saved_fns =3D calloc(nr_saved_fns, sizeof(*saved_fns));
>  	btf_encoders__for_each_encoder(e) {
>  		list_for_each_entry(s, &e->func_states, node)
>  			saved_fns[i++] =3D s;
>  	}
> -	printf("added %d saved fns\n", i);
>  	qsort(saved_fns, nr_saved_fns, sizeof(*saved_fns), saved_functions_cmp)=
;
> =20
>  	for (i =3D 0; i < nr_saved_fns; i =3D j) {

[...]



