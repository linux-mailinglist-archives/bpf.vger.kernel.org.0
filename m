Return-Path: <bpf+bounces-77031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D868CCD6A4
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 20:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7688C302378A
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 19:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636BB33A6F5;
	Thu, 18 Dec 2025 19:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8KUGsI2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B13285CAE
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 19:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766086696; cv=none; b=UYDdNZ2z98UzBx1gCVswJXP7+7WCw62DhCIuYxsYePt52U4PGzTVZLIpWKaYRy1l6Aespkr4QOMhVVL00SJKJT7/Z3pT8ps5UMPMNjlkJBJZs6tdPB3ZNB/L8bPqes0wIZ3rp5iGo//wiJ6n9eYJHf4nsatA8c1gVPMt7KKvN5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766086696; c=relaxed/simple;
	bh=5h0AowYEtSWnYJc+RxiBXfZsRExtzQ5Sx5ovC4kUWcA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LiEIGXf3oyixkB3mOz+WmUU+xWLJ818OqeKUK15CZOupYZDHfXzw+VWt8Gi2KSsH1puxjhv+Xevd7EBHQxrZS26d2Y908xEu/d5tIWByAW9p18d59p4cNp2/YXGK8zMo58RziC9qrTBj/HhLAOh5h4gTjmob3EUJufENAmEdiPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8KUGsI2; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7e2762ad850so1132647b3a.3
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 11:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766086694; x=1766691494; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OBzN6e1JmHzI9Ntr8wqKmXMkJ04vwDzSW2NsDrN2KXY=;
        b=d8KUGsI2JuqeYCYNKFSSu9KQWXbCFPiwNhxrOx3gCYKtRfp/cJAjYaEkFNBZhHb4pa
         QxzSfQDuEvdCc6UHMSUXztRp5QriQB677EWRmZub76TOYzkyJ+QRN45Hgpf8deInTHYY
         YdQI/DoAR6FR3ryDOeLvX3VrHLk0dQx4pkvMzzkuhHNJBbBgvFuPm6ext217e2HKB3Db
         JHFOkc/n9zVnNdabg8e7nZQ6xRZ9WlrsxWIHVT1vfBSWLcQpiQDkacVk3JykIa85nNlB
         8pe38OMT2AYSVLCsLsFaCYoqgNn7rDGh+oFu6Nk0oCwezLc2nz0zTZv3sPHfExMsbJiO
         Qqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766086694; x=1766691494;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OBzN6e1JmHzI9Ntr8wqKmXMkJ04vwDzSW2NsDrN2KXY=;
        b=haCaKx2Iy+A8CfMbDGpIcp6srtKJnSenv0ZSwne6euWr+fAxgGieTekBCV7A0lLpPd
         UolnBln+xAP7cirhZxWJrZTBnmhneEyhlv7iGbzV07g2kjCB/yFPO/nrXnzDjIwTdgos
         G3lVbyzRXlt2aaycSzhRp0Z843Smfj3m17LB8FV1JpPTSDOsDkYIywJms933Ybtq/4uK
         xVovmaKc+D55nXInujMmo8XeQrv4hFf2PkcyZr+CzzFr6oEUzYjKmOQA9Ve/lF4ZqUUS
         et4IQXFkDuT4jQwZqRcXVMtPPUkOZNyG7Vp3Vm2dBLT+MYd2TOSft+BoYKaSMS1fIlR6
         HokQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7pAC1LHjuDVAMiS78VIpBkccLk6/3GgvcQ0xNgD53n9kZhFzspVpCRI2WPsju85AnwS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YznZeOxKenj5CZijMCvNSX9obaHnFbskYCcJ6Qcg0tTqBrbsZAH
	r+oLP7nSugpb7e6wo9a07/CVw8MfEzdsz2SyYNeb8OioD4wMeXIwH0td
X-Gm-Gg: AY/fxX5KXFYplB1YKtlG+pOkMzkx7FpqE47zKeHyYD/oBHLqHiOCSk90Z9lokqDIS5C
	AJtok/NryF/kZa4rcZPAND1xKnW3kaYNO96/usAmwfkNf9Uso3+Ggz6zxcU91gGaUo4oTZnDE2E
	pRIIGyXZH6ozZTMbezNkV8bn/ozKbO7g6okgKsGSDMVpOqrlF56wlcRMwDohx6Zxvk18qPgTm8O
	c8gzEt4mrITGvoJGWZ91smUxcHFzdqb8F7M4d3CnNPB8iPc4JTnSYple3mSfysRkJApg0Cf1S4E
	5xiu3kpP3uicSWVy+RrgUsH/XsoIVQBFnEExBCY8rmhAzZ1QoU/TGJZq9ijxVM+5VkO+Py7C1Xq
	QECNZxLeh78PIjZ59VGhC6KQoo6dLijIuXHDiG959kh2/9SOXIo28CREKjsmm7l0hKO4VX+iMgQ
	KF8QAZZxz0ubsLYHqEwrySGfjC7GS845tXzHHu
X-Google-Smtp-Source: AGHT+IGc5WkRdcmid4aFhKtQxoJVAZauOcrQ5OraZEtCkKY6m/Dwd0JR2NvgGpX86zBPDlb3pofYZA==
X-Received: by 2002:a05:6a00:4c09:b0:7a2:84df:23dc with SMTP id d2e1a72fcca58-7ff64ecc3a7mr453656b3a.28.1766086694331;
        Thu, 18 Dec 2025 11:38:14 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:d912:2088:c593:6daa? ([2620:10d:c090:500::7:e642])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e589b0csm102950b3a.56.2025.12.18.11.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 11:38:14 -0800 (PST)
Message-ID: <1970cb006e56500c8937e62a8a79042990fb152d.camel@gmail.com>
Subject: Re: [PATCH bpf-next v10 05/13] libbpf: Verify BTF Sorting
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, 
	andrii.nakryiko@gmail.com
Cc: zhangxiaoqin@xiaomi.com, ihor.solodrai@linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, pengdonglin
	 <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Date: Thu, 18 Dec 2025 11:38:12 -0800
In-Reply-To: <20251218113051.455293-6-dolinux.peng@gmail.com>
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
	 <20251218113051.455293-6-dolinux.peng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-12-18 at 19:30 +0800, Donglin Peng wrote:
> From: pengdonglin <pengdonglin@xiaomi.com>
>=20
> This patch checks whether the BTF is sorted by name in ascending
> order. If sorted, binary search will be used when looking up types.
>=20
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> ---

(But could you please fix the btf_compare_type_names() prototype?)

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>  tools/lib/bpf/btf.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>=20
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 2facb57d7e5f..c63d46b7d74b 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -899,6 +899,46 @@ int btf__resolve_type(const struct btf *btf, __u32 t=
ype_id)
>  	return type_id;
>  }
> =20
> +/*
> + * Assuming that types are sorted by name in ascending order.
> + */
> +static int btf_compare_type_names(__u32 *a, __u32 *b, const struct btf *=
btf)

Nit: still no need for 'a' and 'b' to be pointers.

> +{
> +	struct btf_type *ta =3D btf_type_by_id(btf, *a);
> +	struct btf_type *tb =3D btf_type_by_id(btf, *b);
> +	const char *na, *nb;
> +
> +	na =3D btf__str_by_offset(btf, ta->name_off);
> +	nb =3D btf__str_by_offset(btf, tb->name_off);
> +	return strcmp(na, nb);
> +}

[...]

