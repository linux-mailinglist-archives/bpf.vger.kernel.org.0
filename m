Return-Path: <bpf+bounces-29430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCA38C1C73
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 04:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A7922818CC
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA06148FEC;
	Fri, 10 May 2024 02:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LttpO47x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC6F148FED
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 02:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715308609; cv=none; b=qTVhu+VuW/RtC6Asdy9WYg3xBZTrPrSE8YXLo2997krViahFxo3AkdtA6Tj7x2hIw3/3HNkXLJDn/+0p2PQDA4h4gm1ihBFUz96WeQvlDdO7uoT8m/znBAzUHuwPUdA2CdHKO5wnyVEwTAixXCzKYGYf0JIwwzxS/s3q3JQ3iME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715308609; c=relaxed/simple;
	bh=BazKg6kdvOWpi3sThSrdS2tQkJ3WiWEouGvPuG7WPl0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uDWJH8KUWcmx6ad7tNhbKkkzKAfFJFvxBSxipxYfieMYfhB0hJpUB9uAYLQFC/hsrZjXBgfYmHMrDFBiIlkj8tiFww9e9ONxCfBcVfYBRh7NqtFjUKBn9eDiO9OQbbpXkwKrFD8CXrRei9LA0IGuDUKMszM72993hBYjcUBd2zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LttpO47x; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f460e05101so1160142b3a.1
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 19:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715308607; x=1715913407; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0u9zuz177f026pbOUvgny+KKXphuj26JUvNsd2SYpGc=;
        b=LttpO47xUC//qBjM14eFgtAdvtNe+ZebeYTmGwagmSIUbbBZTNaKMxdc7TE5XUe4pA
         9dJiUMErpNbMSjebxzXCmp8w3eNsSLg/fz4WyGI9PgcPo4w0TGqrkkL3ykzuH/Lh8lUs
         +XXvj3XCy92WllxCSHKZaJkW5JFMHxEnlIUD1yFkSn5dVV5r/NeVI7DRIO2dgAExlUUz
         6e8h1NWdUOpy8x6dQFvOGcWdMYtcmKStd2TkAWXqGUaNHcjxTO2yK5DC9XObE0HR6KEl
         2XPPv/l1DB3qp5GXgaktgrhpu8PylnRd+b3WWGkWVaLn4zCyql7AIqr0QBkCfLibxE2+
         PHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715308607; x=1715913407;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0u9zuz177f026pbOUvgny+KKXphuj26JUvNsd2SYpGc=;
        b=o3q8MAlom2hFpbWnY4cXXIcs7m5O68xbrJ4BMXZsbNzYUZb7mYBpiAvi2dodZiq3fn
         laOov3YlOOqaipxKb9MXiz9czyRfiKi+/dRJLsWDx2LQe2XSRMXHwZjRUPN9NwHH6ahA
         s1/rRJ6PMlIac0I++dm+o+ITlJ+FwaYWElTATqbGzOP0eLhMWTdOq3h80GbGt0ve6F2j
         kvAMWiFGRvtfg4d5/ajuNe6S8dWLgRo/CpgrmhOqabQ2tq/pWAQu9094d8oBkRqXjjaX
         UhyGTpWLYiax1vYm0RTLvRExjJQ8RIacalB/UWo5XaEnt63BsLn/+cLo44s9L7ephIkP
         S80g==
X-Forwarded-Encrypted: i=1; AJvYcCU+BhF943SPgUfuB62LUkyVkdqjD13ns4jDwgErMcCmiAc0jF8aAxHAq6NF0ibjnYCnbtNYOe3lW3LaMVZ0D+vOOKzT
X-Gm-Message-State: AOJu0YxCVRQ4Ol5e1VwKuY+PpWlQbic7KMc9ZEHMTuUgcT0uONSXKJru
	cUisP0oPcUPW5gnFdfyT+daYu5ZWDU3KtjR3CB5Jq7zMtI4uI9K5
X-Google-Smtp-Source: AGHT+IGGAUgLnj1TdxdhMPqqHQqobQYg2V2qX3PearUBXFdsgrk7TMMaUmTd2JmFSvHcHnxCYrNKAQ==
X-Received: by 2002:a05:6a00:984:b0:6f3:e6c3:eadf with SMTP id d2e1a72fcca58-6f4df44ca45mr2266377b3a.15.1715308606779;
        Thu, 09 May 2024 19:36:46 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6341134705dsm2030863a12.85.2024.05.09.19.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 19:36:46 -0700 (PDT)
Message-ID: <164f53620337d23140d602a6e5a1aba00612143b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 5/9] bpf: look into the types of the fields
 of a struct type recursively.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org,  martin.lau@linux.dev, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
Cc: sinquersw@gmail.com, kuifeng@meta.com
Date: Thu, 09 May 2024 19:36:45 -0700
In-Reply-To: <20240508063218.2806447-6-thinker.li@gmail.com>
References: <20240508063218.2806447-1-thinker.li@gmail.com>
	 <20240508063218.2806447-6-thinker.li@gmail.com>
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
> The verifier has field information for specific special types, such as
> kptr, rbtree root, and list head. These types are handled
> differently. However, we did not previously examine the types of fields o=
f
> a struct type variable. Field information records were not generated for
> the kptrs, rbtree roots, and linked_list heads that are not located at th=
e
> outermost struct type of a variable.
>=20
> For example,
>=20
>   struct A {
>     struct task_struct __kptr * task;
>   };
>=20
>   struct B {
>     struct A mem_a;
>   }
>=20
>   struct B var_b;
>=20
> It did not examine "struct A" so as not to generate field information for
> the kptr in "struct A" for "var_b".
>=20
> This patch enables BPF programs to define fields of these special types i=
n
> a struct type other than the direct type of a variable or in a struct typ=
e
> that is the type of a field in the value type of a map.
>=20
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -3555,6 +3597,17 @@ static int btf_find_field_one(const struct btf *bt=
f,
> =20
>  	field_type =3D btf_get_field_type(__btf_name_by_offset(btf, var_type->n=
ame_off),
>  					field_mask, seen_mask, &align, &sz);
> +	/* Look into variables of struct types */
> +	if ((field_type =3D=3D BPF_KPTR_REF || !field_type) &&
> +	    __btf_type_is_struct(var_type)) {

Nit: this check looks a bit ugly, but I can't suggest a good
     refactoring for btf_get_field_type() at the moment.

> +		sz =3D var_type->size;
> +		if (expected_size && expected_size !=3D sz * nelems)
> +			return 0;
> +		ret =3D btf_find_nested_struct(btf, var_type, off, nelems, field_mask,
> +					     &info[0], info_cnt);
> +		return ret;
> +	}
> +
>  	if (field_type =3D=3D 0)
>  		return 0;
>  	if (field_type < 0)

