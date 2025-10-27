Return-Path: <bpf+bounces-72364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAD8C10A9B
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 20:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AE341A27436
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 19:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5412F328634;
	Mon, 27 Oct 2025 19:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpNZaHmt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BB131BC91
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 19:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761591995; cv=none; b=FiAcs9Qu++1uA7+AAFvwH1JdReg+k7+IICEA/L+8E9ZTUnQOv9pwbL7KKuQQQO4EPPx1VYzDXbnW/UpHFkDZThzDL2WlIO96GR/BP7PzHfIXCzPtC1+h+0fcJ2q44yMbT2/qhRQKTzimJrvRZhoD6aT04S42pteTPq2ePde6jVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761591995; c=relaxed/simple;
	bh=Ojab5OSl+WBm4Mxevged5V2m1wa5Eh7wWc+uU4tFvHo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UvZzfTmO79qdzIqn+zFglo+kUXKfNqEHLnf996rA9Z3jUZ3XT17GSXv+JJzVQO5VioB2hx3i2Nl5f5dWTjVfHC/+1U8pilPTnAArYmG9ziR9nFN2xiQmTPw9J6z6Cpf/0ZyfpJygG/mLYmfmjqdjHKFesQJxMz0F9KJ0eg9FGV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpNZaHmt; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-290aaff555eso46613535ad.2
        for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 12:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761591994; x=1762196794; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H0gDu/cEgextMGhJSkPKVqZRF+SRP309HWbX9UskMTw=;
        b=FpNZaHmt0odBOsrqTv+Trwtyb6bLCm/w8nEropD4Wq4StY/vEzeYELnNe9dhMWBIQ8
         hZQ4t9Cx491q8xoQeGVGteQy+dY0u70s/MBx1io3zMeGnti5HohIjwQCshVTJJaJBboU
         tLVHHzFBJFaPXX0OMBUprr2DRhLQxr4pau22spnX1ejsbp+Yu45f1JAKVdhw3keMYis+
         Q8WtdeSiEN5qg6TJ172XK9hr8+QVuSMVN+FtLO8eYmslAqHiXaCz7imP/HusMJTxh3Cr
         ueNrHeABVtXTenkUx4n3g654xHye+UQOpU7VFWB5syHKc2QjWHZPm32Cz1YvF/SiJkue
         g3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761591994; x=1762196794;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H0gDu/cEgextMGhJSkPKVqZRF+SRP309HWbX9UskMTw=;
        b=snIvt5mImz79E+bZxqGlzLf+WgKedgGHeY9e14jY0ptossKij75Lx8eVMx3LOPj9gd
         xICE3cI3u0Ta8jw5obxiheV4xfU9fuM704i478WDwhIU1af17m+qUfPF/n01eugI1AMf
         r8cuDTBWIBbBc1fWFR5tHCenjvM7ghnmwYK6KzIdYVqD8FaN0l8WaxjiwOv9k3+6aWI9
         QQ/clCToMoD5c7ySFXRbYfxXLpQxtnC1UBwtPTp9kUiHsw8sGPtnePFmvEWoGuYnOIei
         UZ155zpnj4ZzsGC5gzb8Ra1oaAIGj/g3kEqnfbiip5abynOQJCcuIVnCfIGTwWoUCrjH
         rf8A==
X-Forwarded-Encrypted: i=1; AJvYcCUgBo98Cx2kKGf0FCEX+5P/Pg9TB4TDw+RVn17e0OCgSmZNZaj8hAS0I36aFTglKaLFhlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YycRKWLGyQLNAtxmpwCIcerxriNl7EzCF4H3A4eD+rk1YObWHWh
	l+ItoxdCQ+Mh/I1I1wTJp2WPxwg50N+6GOg+bJME13o+jP1FUj9UxgLu
X-Gm-Gg: ASbGnctAHsF7Br5Ck303XKTpGg9KbsPVTzbcKSTqhkO+D2DeeePV8Cxd05eXvqz8OR2
	+MSegY+EmWd/iZGHHM3iHqAoVTY6MFDCNfUpppe+W+Piw30xYGHGDzyio/ctKqYts+udJrHow00
	ApH2OimvLE6HvEmi1X9ZayLUy6FcqQrNyihRHY+a1PWA7oBCVOE4wR7EF4L95ZrMfWno62owoEZ
	YUqEoDwHsdxfTfIzvR0sOsT7g/O/LOdXo3GTZE6/PXQZ6KuUhYhv11ToKo6dvfht7ZuOBslMm9y
	HjGJ3IriCwwSiuX/Dxyr41VpnZUBv5h+N7YgYQ4AqfGcRtFNAaKYzXKjp5hcGYNPUa7dreBbL1B
	QBiMuo3HcMe0xC9HBzxkRVuF5Bl655V+UPsZleRWZulhQ2sfDh7kEdvzlZoi+FfUJB+0VlvlN9o
	ULOv/7ZVPJ
X-Google-Smtp-Source: AGHT+IFWIi8PKVygJ7gwEknuigRMUvmTlJAQjGlxiILEK6ZS4jJsAMvu5S/hQi+KS+QRppuNDN8ALA==
X-Received: by 2002:a17:902:d50c:b0:24c:965a:f97e with SMTP id d9443c01a7336-294cb395b49mr10271245ad.2.1761591993581;
        Mon, 27 Oct 2025 12:06:33 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed81ca93sm9366998a91.19.2025.10.27.12.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 12:06:33 -0700 (PDT)
Message-ID: <6e7ef94cb4e2d7fbc82676b2af1a165cac620aae.camel@gmail.com>
Subject: Re: [RFC PATCH v3 1/3] btf: implement BTF type sorting for
 accelerated lookups
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, Andrii Nakryiko
	 <andrii.nakryiko@gmail.com>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Alan Maguire
	 <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, pengdonglin
	 <pengdonglin@xiaomi.com>
Date: Mon, 27 Oct 2025 12:06:30 -0700
In-Reply-To: <20251027135423.3098490-2-dolinux.peng@gmail.com>
References: <20251027135423.3098490-1-dolinux.peng@gmail.com>
	 <20251027135423.3098490-2-dolinux.peng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-27 at 21:54 +0800, Donglin Peng wrote:

[...]

Question to Andrii, I think.
It looks a bit asymmetrical, that there is btf_check_sorted() in
libbpf, but library does not provide comparison or sorting function.
Wdyt?

> +static void btf_check_sorted(struct btf *btf, int start_id)
> +{
> +	const struct btf_type *t;
> +	int i, n, nr_sorted_types;
> +
> +	n =3D btf__type_cnt(btf);
> +	if (btf->nr_types < BTF_CHECK_SORT_THRESHOLD)
> +		return;
> +
> +	n--;
> +	nr_sorted_types =3D 0;
> +	for (i =3D start_id; i < n; i++) {
> +		int k =3D i + 1;
> +
> +		if (btf_compare_type_kinds_names(&i, &k, btf) > 0)
> +			return;
> +
> +		t =3D btf_type_by_id(btf, k);
> +		if (!str_is_empty(btf__str_by_offset(btf, t->name_off)))
> +			nr_sorted_types++;
> +	}
> +
> +	t =3D btf_type_by_id(btf, start_id);
> +	if (!str_is_empty(btf__str_by_offset(btf, t->name_off)))
> +		nr_sorted_types++;
> +
> +	if (nr_sorted_types < BTF_CHECK_SORT_THRESHOLD)
> +		return;

Nit: Still think that this is not needed.  It trades a couple of CPU
     cycles for this check and a big comment on the top, about why
     it's needed.

> +
> +	btf->nr_sorted_types =3D nr_sorted_types;
> +}

[...]

