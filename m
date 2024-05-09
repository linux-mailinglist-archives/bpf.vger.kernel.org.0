Return-Path: <bpf+bounces-29332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C79F8C19D2
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 01:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E190E1F23E99
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 23:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B2612D770;
	Thu,  9 May 2024 23:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/e0ctJv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AFB1292E6
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 23:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715296439; cv=none; b=L7z2bvuVqUy7vlJ1PTfl2YvK+6D58Nn61EYmmdChWpBUFbCWB3hrpXwB7eX0pqeczRuc+ajSdaoz34ZwmZsk8GyzHoD5NNaqeLDmb40z6cQz4Iwr1P3e/QXGftyY8kvt42AShf4NW8QBbqeJFeHcKBMw9klRk+TYTL+sXRdt5CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715296439; c=relaxed/simple;
	bh=DBOWvSDbQwL5RND3iwiyhkHUCaI+OwAwCApYYvYN9jE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SO0ugH2Vszvj9dBZBIDmvrMShbPBgwBJfKjsosQ4kwmFdxL6DE7DqCQvaiRpXZmbGhu1q6SvOzhhr0lrGocbBkbasBH8V6DEAlMEDJhFvZiHbgXehu0S8I+MEtWv8qK4KGHNJq9cQ8PaOuH+Npm2QBpD0Plcu+8RCzLhcKVAtU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/e0ctJv; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ecd9a81966so18136295ad.0
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 16:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715296437; x=1715901237; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0qql1ogr5IIRa9ak717ivuWYerBsgokB9n9s+piuyvg=;
        b=c/e0ctJv3sFtVYUTQGdl3aCS+MYJGSSMOW1/TC91z2WcljW88R1Otq6CLYJZ3KVveY
         ELDD8twMDgEDTUp29g3wrpuZHXo/dubVdxMlXa4AnCWyPrYtuexZtOn5W+oH7T9AQTem
         dvx5iMutTnfWLDvz4MJIh3wI/YSDdIzBvPCQ6Swz3sWG80cJ1zhY0VHe+EjYKPEKXKod
         Nxo2zxnQBUL+Fe46sZHe++iu+5lkvVWMbkkvWSgUTR+IwdDPsPm9fczmgRAFqsjzi05h
         Ny7rcc7KFv7cOtLVWSfa/q99dtelq3r7EjiMVddGgEtjDFXDldL0ybeAolGteJa4dVLV
         Ix4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715296437; x=1715901237;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0qql1ogr5IIRa9ak717ivuWYerBsgokB9n9s+piuyvg=;
        b=MGpPyLkQKXv+6cBk7lzzn+JdJ/4aNYdxdY1NyHXX+8olquJDN58wWzgCDl7EyQ7wMY
         0ekYAz9dd51LLtxnmQqVhwuM/1+0SO53DTT/AWbbsZzOUYOO5GRDFZNxxVNEKYkbSCNh
         BbwktTw+RavbJMjqqz6PP9LVYnF7EVa3BYSy9/aj02ysaKQTe8n/hx0EI8Hb1YoexiRE
         F43bRSdsNaQzPrKPZvkT8kqI82jXOVHeCv1IKA78gRaMiAyeOQHdBDM08yAzY3lcd8kR
         DLMMC3pL+X2swoUZ5DosIIlPrqCreCih6uoB7vp7/V1D+piKbJRySTrRSLnA85KkqzRg
         gh+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVc7hNHaCjy8Ju+Vu2XtHoWrPrV77jBLYXm5jyhzp8KvJ+xbJmH2h/c2m2BIvG+U8ly0gZs22c2Qr7Br5jHDTTypoZx
X-Gm-Message-State: AOJu0YwiPkhqjJEDN6ROXBH5DDJx297B9PMUjigfHgUBGkAcx/zk6Ab8
	zF/NAej58bQQbqk4dfG+/n360sZ7rGhcl/DnUwGme2vzDuDmKq7l
X-Google-Smtp-Source: AGHT+IHTLZL1ggfL6DQGhcXp879G9uqnzCIOD2aN+FY/Sfd4hjfUCsjEvKqjRH4cLfrE4JcyzRFrEw==
X-Received: by 2002:a17:903:234c:b0:1e8:682b:7f67 with SMTP id d9443c01a7336-1ef432a0c85mr13816505ad.29.1715296437393;
        Thu, 09 May 2024 16:13:57 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c036d47sm19640935ad.182.2024.05.09.16.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 16:13:57 -0700 (PDT)
Message-ID: <61b492f9bc12f92b64bf5ce06363087ec828e991.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 4/9] bpf: create repeated fields for arrays.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org,  martin.lau@linux.dev, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
Cc: sinquersw@gmail.com, kuifeng@meta.com
Date: Thu, 09 May 2024 16:13:56 -0700
In-Reply-To: <20240508063218.2806447-5-thinker.li@gmail.com>
References: <20240508063218.2806447-1-thinker.li@gmail.com>
	 <20240508063218.2806447-5-thinker.li@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-07 at 23:32 -0700, Kui-Feng Lee wrote:
> The verifier uses field information for certain special types, such as
> kptr, rbtree root, and list head. These types are treated
> differently. However, we did not previously support these types in
> arrays. This update examines arrays and duplicates field information the
> same number of times as the length of the array if the element type is on=
e
> of the special types.
>=20
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -3504,6 +3539,19 @@ static int btf_find_field_one(const struct btf *bt=
f,
>  {
>  	int ret, align, sz, field_type;
>  	struct btf_field_info tmp;
> +	const struct btf_array *array;
> +	u32 i, nelems =3D 1;
> +
> +	/* Walk into array types to find the element type and the number of
> +	 * elements in the (flattened) array.
> +	 */
> +	for (i =3D 0; i < MAX_RESOLVE_DEPTH && btf_type_is_array(var_type); i++=
) {
> +		array =3D btf_array(var_type);
> +		nelems *=3D array->nelems;
> +		var_type =3D btf_type_by_id(btf, array->type);
> +	}

Nit: still think that error should be reported when i =3D=3D MAX_RESOLVE_DE=
PTH.

> +	if (nelems =3D=3D 0)
> +		return 0;
>
>  	field_type =3D btf_get_field_type(__btf_name_by_offset(btf, var_type->n=
ame_off),
>  					field_mask, seen_mask, &align, &sz);

[...]

