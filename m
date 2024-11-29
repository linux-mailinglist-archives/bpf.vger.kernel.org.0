Return-Path: <bpf+bounces-45860-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD5E9DC055
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 09:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C5C9B21DA1
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 08:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D378159565;
	Fri, 29 Nov 2024 08:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRu6Z0Q2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A841C14F12D;
	Fri, 29 Nov 2024 08:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732868201; cv=none; b=jt5MePDbeRiQuZ4hZnsglkchHkcDpbP3CNHWBYWUPCekzxZyDJfX0DM/y9GyELScycUhinm9xIP96Nmy4xV09UDjzj2UAinDXsGDyBAMXuE5OS+fbsZ/V4fTTL+E4R1H00T4JeAIN7INlDkhuAtXEJobnIrrZMTB6T3ghK/TwCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732868201; c=relaxed/simple;
	bh=sLtlfFCbNt0XrwspyvnENUYy890b0HsZOxzZQFY4lg4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gIM2ecKXjQUBedotCA7peERK8bW8Wo6jESeIy0sP7uhcgm2nPHdVxVHS4+c+d9Y+DQFWQ3fGzamMBZfHrr8AFYhfB1WKsAdss8zs5SPEfXOiF7hANJBkyXL72B0uPJF9g1C1ZKQOhItiMO36Gr7eZGikbt4s6ROOhk2vuf5DFT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRu6Z0Q2; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2153e642114so4269145ad.0;
        Fri, 29 Nov 2024 00:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732868199; x=1733472999; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nJxv4xzfbT+55JaLtX3ltOe8eox/MIJ6AI8blZUYHWc=;
        b=lRu6Z0Q2RbrHWB3m7j95bP9Il21On2Xns5JSB09G9j79D3etARgRcOm4HcXAzwEIIF
         07zunfastHFrzBjpkQMB7W4N7f0emGqxhX+a8lKAOaCEas+VDkgJOc2OIPBdrnCy3w+h
         I/EZGOqp/qISkvk685wfWsbQmruMJYWfnuWmFl5XaNhmiZmpGYJjA1iNRYfSj6us5EBr
         QcXkH+joQHEC8qfF0zDrXc/cdStl6IKs+5c1lm9wqexKl180gKph0ZoVCTU9anfW2Fk8
         7SKwEdOAbpSPQKfuKxNh0CWPirzceu4KBzueNf5meQmY+UC5Adn+Wj7jrzNu0MtjFPTe
         87DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732868199; x=1733472999;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nJxv4xzfbT+55JaLtX3ltOe8eox/MIJ6AI8blZUYHWc=;
        b=AHC7vMy/ROHnPug9GX05jnZolNNNejwG/ze/5RmZhx5ceWGLfwa/UmmqgmAr6by7qZ
         CNTcfbb4qyLOjVR4EfVIK3UFm7vD59qJ7ELlLXoXlSuwJ2YKokKHJOyyTnXhldhIwaVF
         OODqe/m2OW06yd6XDs6xVNBxn5HBdziDD6eTQ4OQL9BLV4oHkyFCQQ2GqjVa9Ms0S7Y7
         nHAEGxdCCde6iKxflYMpRJo75hEgq5pBrCARZ3kpX5vvfdPNeWSBoh1DxM1h4+vHsNWM
         8FmH91co9OcMBnMYlCSl4s/3Ay0jsRX6D1bm+pZsYs+I9WzZml8Xzc3SO+TQQu7hGqtu
         8Fmg==
X-Forwarded-Encrypted: i=1; AJvYcCVVUZERLB3eZZJuz/RHbgLrClccGXFM64THwytDjjUZ9BmEJ/daeNWfJfrEqhVXHdjtKX4cQs5p@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt5S3FdxJiN3Ch6k/choRkiCnxgNMIG8qs29cyuNqDIs9HD/UI
	2opBy+cDwGupfE+9XrItDIygtUvxjQsS3dJxBHZcn4iKWdkwHzxt
X-Gm-Gg: ASbGncsnIPDokJ5UNiWQcDFHRyRoO2+kFuPXt17odwNPsr+XEMvP0Rm9k00KriP52dG
	IIBBIt/IJVwEUuS6SJ+MQL3nxkD4fsn0wjMTN87gpARn0mQUj2PwScZ2oTuAHNtatzgDbRnS5Th
	/qtwd6LRmqMvS84r33NoJ2ca0ur9x8UuiwAOWuWC61TlVoFrvxZbDt8zhEpZw2QGpDF5hcCtnoH
	X+bCjGH5O+fI3xMhFBQpk4my7zLVBThLkL7FRQjIk2QXBk=
X-Google-Smtp-Source: AGHT+IEHgcfh/ESCg325Gyvrd/6CwyDl/ViG7IGCYGqv9qR3tp/TSR7UHi7+HEKdhvNLoTBWGGLIBA==
X-Received: by 2002:a17:903:986:b0:20b:8776:4902 with SMTP id d9443c01a7336-21501b63d3dmr145111105ad.38.1732868198995;
        Fri, 29 Nov 2024 00:16:38 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417fbffasm2976319b3a.103.2024.11.29.00.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 00:16:38 -0800 (PST)
Message-ID: <e8d4d8a68bff841fb24e2982fa92bd6455562867.camel@gmail.com>
Subject: Re: [RFC PATCH 1/9] btf_encoder: simplify function encoding
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>, dwarves@vger.kernel.org, 
	acme@kernel.org
Cc: bpf@vger.kernel.org, alan.maguire@oracle.com, andrii@kernel.org, 
	mykolal@fb.com
Date: Fri, 29 Nov 2024 00:16:33 -0800
In-Reply-To: <20241128012341.4081072-2-ihor.solodrai@pm.me>
References: <20241128012341.4081072-1-ihor.solodrai@pm.me>
	 <20241128012341.4081072-2-ihor.solodrai@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-28 at 01:23 +0000, Ihor Solodrai wrote:
> From: Alan Maguire <alan.maguire@oracle.com>
>=20
> Currently we have two modes of function encoding; one adds functions
> based upon the first instance found and ignores inconsistent
> representations.  The second saves function representations and later
> finds inconsistencies.  The mode chosen is determined by
> conf_load->skip_encoding_btf_inconsistent_proto.
>=20
> The knock-on effect is that we need to support two modes in
> btf_encoder__add_func(); one for each case.  Simplify by using
> the "save function" approach for both cases; only difference is
> that we allow inconsistent representations if
> skip_encoding_btf_inconsistent_proto is not set (it is set by default
> for upstream kernels and has been for a while).
>=20
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


