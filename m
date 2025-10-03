Return-Path: <bpf+bounces-70349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9930BB837A
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 23:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CB141B2195A
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 21:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5685264A8D;
	Fri,  3 Oct 2025 21:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hD8Ol9cT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC97725EFBE
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 21:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759527315; cv=none; b=bsD2K5ZWRxzPGgnWPMJMV9+U/GfnxHlDJWNcmglVEX0fHYYlP+llltkxXaDVIIppPP2J9fwltoO5mkyTSa2dp+66P+7reHwPG1J2kQnIr/IO++PgnO/tme3C7+C3SQhw5iyLzHQWRVxw63y1i0ccru5JJfECSqC6nSOMuZ+7VEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759527315; c=relaxed/simple;
	bh=5+BINWhdnvJAHFzTTEx9Ws/Y1uTzSopZJXP4Qc6ZngA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GQvyXjTGgUJInNuyhEff9C7p2Jmt/Oji6E/YLSvnPTAu9S9oTLmr78vk0c5BVhRDpbsd0k6wJ/SYQbs52sbNQgHZhPvW6kY7J6hz8JP1JyaZzL2VLcEh+0NYPg4xE8JbYg6xMqIO+APH6lgKBJh6Nd1g94XONPZV+vMOe2wZk10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hD8Ol9cT; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3322e63602eso3877554a91.0
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 14:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759527313; x=1760132113; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3YFqSY+agF3otVGylT6YJ/ErNJSk3yzbvNng0L/Me1s=;
        b=hD8Ol9cTpneasO5OQXnxqVE8cBjOxEF545T0doSxAPqq+HcYu15AE7qRPxPMhLCtu2
         Z86O5n7q+Z92NlxFSmvhT1yeaUWaR/3LRyBIiVAxagIetAYPjAQjO/h2ApG/ezviKOXm
         2WiXFIyjSItBpZsjp9tIJXIL3+LmxG3dFMtz1YT4B3rOI71bnRBh+Y2YovV90sjv9ek5
         5oYA7qM5vXOnaZevs+bkFQMy0FmCcW7WSrj7uRv21nUHYIHIzzy+T0jFKis1ypDPV97t
         zeiPvnjvBeHQeK7Mrvwv6aU7Vu6qgBlnwKI5LK2u04OwRAFTS+3BQl0VUIIJ8ddjZoiE
         iddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759527313; x=1760132113;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3YFqSY+agF3otVGylT6YJ/ErNJSk3yzbvNng0L/Me1s=;
        b=eT/N201HdteMuD1jdMbGL7bRSksC7snJRnlHwPMtOWSD0l8FRHIH+rB8B3RJuKE4dn
         t1ppGUZOaBp6O3XkHW3D+v51E23Izp8baAvee90ZdJq0aWb6zi6+fYCWVAHkWEpKp8oJ
         jwX0qECZ0D6xc46bpdHTxysCbfQvvChgCgkJY5hn3GlYlOg1L2yJOJgMPlfIH4hrIs8k
         ghOV2zgu8AWAFeRT9paoBezTGFJZoUqBAzTsNrgH/lvNXCebmhKZKU398ueJMCkj11yG
         lKAB+FS1+4KrKbfIBkLvaoUWTGirDGiAVWPUB1TkuSGtbAACd8O2/BkcAomhxwSrtaek
         i3aw==
X-Forwarded-Encrypted: i=1; AJvYcCVS18ZPGMSPoS518Rf62vS1F0KmERyYcPIT19bBHrhXyiOh9kTbUUXJ3bAKqtimgOns29Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX2Oj95RkKmmzCK8qxHziTcuJOddCf68IplUiBI/iZGfNztkKj
	SbptoqKqGbizkkbdnXzbsVkYdNLnCRLe/lOMP6jMjiw7rOIY/4TS+Aqe
X-Gm-Gg: ASbGncu4Fy7YNdD7AZ8Oj539hZZ4SnBjAhQefFwJelhspuAn2Lv1PRUGxUgM/8+rGF/
	k17g0rpE2BjEM+6bYthod76o3+2QCbqK3+dsYxIQxHWw1wqvvLijr7vCs/wBBxXaqcGx+TuAlg2
	Xl55JZeAXhaxaffgESpY3+nX1ud26pbGEorGGXq8VdtSP9ALpKn8laBdclJYtS8xxR6LL8L+8wL
	wlDylMsvt9KgrOxWeRitlsCiCS9yaWdS7vt5AkZ5bzYUZhmkMSio6qMq5W6HVwJaso3p+FgD7NZ
	sI3Vqqx/2cWwEPfA6xXyti+NJVvvjPNp+7jBEkzvMyv6puNorD44Zno37Ft7CIZd1DBK9OHqJGc
	Gs00tI/MH1wMbP7Yui8LuyaMabFr6jdx8PS5ElcMGJCoCR3wQ47F4+38FTEaoSe2B7kSmPE+KjO
	lJvxUS7/8=
X-Google-Smtp-Source: AGHT+IFeJSB7h1UNMckHqlufjcRLU/D3Wq7ijqcAhpxFyuHpEmzWlBlkaxgN9ZDkOjRCfqYk3j/0fg==
X-Received: by 2002:a17:903:1ac8:b0:27e:f201:ec94 with SMTP id d9443c01a7336-28e9a59574fmr53362235ad.18.1759527313020;
        Fri, 03 Oct 2025 14:35:13 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2a3b:74c8:31da:d808? ([2620:10d:c090:500::4:e149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1280a1sm59842925ad.51.2025.10.03.14.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 14:35:12 -0700 (PDT)
Message-ID: <706964d19f99777ae76c1cb930fd0a30f979e23f.camel@gmail.com>
Subject: Re: [RFC PATCH v1 07/10] bpf: add kfuncs and helpers support for
 file dynptrs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Fri, 03 Oct 2025 14:35:11 -0700
In-Reply-To: <20251003160416.585080-8-mykyta.yatsenko5@gmail.com>
References: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com>
	 <20251003160416.585080-8-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-03 at 17:04 +0100, Mykyta Yatsenko wrote:

[...]

> @@ -1702,6 +1733,25 @@ int bpf_dynptr_check_size(u64 size)
>  	return size > DYNPTR_MAX_SIZE ? -E2BIG : 0;
>  }
> =20
> +static int bpf_file_fetch_bytes(struct bpf_dynptr_file_impl *df, u64 off=
set, void *buf, u64 len)
> +{
> +	const void *ptr;
> +
> +	if (!buf || len =3D=3D 0)
> +		return -EINVAL;
> +
> +	df->freader.buf =3D buf;
> +	df->freader.buf_sz =3D len;
> +	ptr =3D freader_fetch(&df->freader, offset + df->offset, len);

What will happen, if file does not have enough data to read `len` bytes?
Will freader_fetch() return NULL?

> +	if (!ptr)
> +		return df->freader.err;
> +
> +	if (ptr !=3D buf) /* Force copying into the buffer */
> +		memcpy(buf, ptr, len);
> +
> +	return 0;
> +}
> +
>  void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
>  		     enum bpf_dynptr_type type, u32 offset, u32 size)
>  {

[...]

