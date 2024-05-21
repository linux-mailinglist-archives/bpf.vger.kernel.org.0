Return-Path: <bpf+bounces-30146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD328CB354
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 20:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59AE1F2195A
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 18:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EC377105;
	Tue, 21 May 2024 18:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMnoAYWO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F8723775
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 18:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716315157; cv=none; b=TobtCvY14HsBgemJRKWjJtLHqnylRbObq56pkUT6c9UPCJzTKivw23HFfrX12Y80Gg5ycqfARM7z0zF7qHZOVWUMH9DPSn4aBf4vzSBlDppVdjYM2w/hz1oBqLNtg9+owJaRyVGmDlc2mZvP5VrGqElgqdkn96QPLggfhW4dFqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716315157; c=relaxed/simple;
	bh=1q9N46WgUuz/Iq+LEmrQd52SrMNZQ87M02qKpBlCpeA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PNP7XZdG9+nUVMAh8ermn+0TNqJ10YYp3Q277p6BuscnGQSxQr1+OoU58GlA36hDiqp3MJE3LeFEVH2hBBLBNKY4Wk/g9RjMjGfI8wy0amgJZhvzslh6qMtyo1J8jhdc2SUmBDFd9R67o7jG68GmPBNDEYPlW20/l2TrYlrBGUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMnoAYWO; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5b680c1fdd4so31888eaf.1
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 11:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716315155; x=1716919955; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hqGj0NVKmsBcxWG0qGqxc0yjzcLmiDiFgDjBeYfYTWA=;
        b=nMnoAYWOai2YC2qXy31HfJAmxwyHugyOE1fWXi+tKK3gvIjUCLTZ89rd+R0zajUQ82
         NUKRxbMokYc9yl2Qewivwx9109vqvaPKiYE3eHVCLy5IhFEDRt9nOGD7lvSJ1G5wTXbq
         bLRiVlSC/4Eq6NiBRtTyyHExw+yj4UPGlh0tRJ2aI49eDNe7hiAo3yEsEpkW1YwZttzD
         ly6jNzdWWPYRB0Bd5UGkr/UShneaq0fHcb8ChbHz96mY/pVq1Ia7XYMANVug21yTKIVl
         V5nflU0lssXjlBReJEZHJ9nCOusig+UqYTR/LI76W/phAbMIS71naQA+cxPx3DmxUNuo
         6P3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716315155; x=1716919955;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hqGj0NVKmsBcxWG0qGqxc0yjzcLmiDiFgDjBeYfYTWA=;
        b=ePfQJlRD4fH/R1orQszY2DISmdQ+/NEFGKun2pYpoeo/sxECfwcIynSYC9tGXOb6NO
         ygRsEI4JEeOGnFTonhmAiFP/ck6J3exq69VK1SlH66nXQUqN7soy7HDgSltM1LoOn3VM
         FcuhE9py0u94s7gzWaFiVIdCl8oj5ij9zhSODXalake5lgzXcxty12PrW0gJr9DQJ80l
         6PTTw7wxgpI3FJX0aw2UKFVUslO8lsKj9By7DoV6oufyMnPtmbr61vy+zUqt4nMq5EE+
         vvTCmJcpR67QMuWTliPux6rnOSD0ibPgR6FfuWBVlrXT1jIAgIv61wi38DOga1dR3z+E
         uOmQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2AUcrN4NzM3nAzNd6tMeFrzQxe/3l6NLDWwiS9nS6WBpVCkItaPeyasoh1JRRBJxitudTPo8+t9veINF+xUvbQG4l
X-Gm-Message-State: AOJu0YxT+2p4osNQltYwZw/6WboPXQxTqcujiTk9tqUvFpdwVAhcI4Zw
	ZMx6Q7OzpTF1JO17IWOSH+NFg+JxhM0WROYUNyrDSK0VR5/7FmBu
X-Google-Smtp-Source: AGHT+IGsmSaKB6VqM3Zrrxnn6+NC7wKwMZIqANf0RMuG1nLmynQqUK35bX+EqnJkco1okhIUxlRMbQ==
X-Received: by 2002:a05:6358:914e:b0:183:4d1d:dcae with SMTP id e5c5f4694b2df-193bb2dc8d6mr3564857255d.28.1716315155261;
        Tue, 21 May 2024 11:12:35 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-65b3e32b3bdsm9102100a12.29.2024.05.21.11.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 11:12:34 -0700 (PDT)
Message-ID: <6266baf6b48afb63df4789cb932dfee713029988.camel@gmail.com>
Subject: Re: [PATCH bpf-next v6 5/9] bpf: look into the types of the fields
 of a struct type recursively.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org,  martin.lau@linux.dev, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
Cc: sinquersw@gmail.com, kuifeng@meta.com
Date: Tue, 21 May 2024 11:12:34 -0700
In-Reply-To: <20240520204018.884515-6-thinker.li@gmail.com>
References: <20240520204018.884515-1-thinker.li@gmail.com>
	 <20240520204018.884515-6-thinker.li@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-05-20 at 13:40 -0700, Kui-Feng Lee wrote:
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

> +	/* Look into variables of struct types */
> +	if ((field_type =3D=3D BPF_KPTR_REF || !field_type) &&
> +	    __btf_type_is_struct(var_type)) {

This code would have looked nicer (handled inside the same switch as
all other branches) if we had BPF_NESTED_FIELD in `btf_field_type` or
something like that. But that's probably be an overkill.

> +		sz =3D var_type->size;
> +		if (expected_size && expected_size !=3D sz * nelems)
> +			return 0;
> +		ret =3D btf_find_nested_struct(btf, var_type, off, nelems, field_mask,
> +					     &info[0], info_cnt);
> +		return ret;
> +	}

[...]

