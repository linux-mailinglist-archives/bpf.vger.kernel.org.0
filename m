Return-Path: <bpf+bounces-60509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7317CAD7AB5
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 21:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E62913B1020
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 19:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1DF2D8DC5;
	Thu, 12 Jun 2025 19:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A4L79eJ5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2212D4B54
	for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 19:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749754862; cv=none; b=NxpzFelX20IlC2pO5JGJW338ylqqbNwsfTnc2friiKsIxUnG2C5Mnji2YkzARt9hvGNSf9Sm9v91ItQKRR3NjcBypHoll3L96PtWe9lrwLCMeqvwlI2n5wOFyeNA6y93uo88nTSNDz6NFItxAxtzWOhFKDF6wunYUp057+FCGcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749754862; c=relaxed/simple;
	bh=ZwlMsaTHjZOtEXv/YqtnnEPbYBwwh6k+wD4c3F2kUr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ba5XxZpDFgmhb8OfdG+ZoidbDUe43wxP/wQzr93g1lJU99McyT9AjT12qQDxfsSHCbNHZi9ml44Ux/Iig32zPZ82TUw3zz8qARdRypxuaaDVRPyKSOHE05n4nRqgWsDVen1qJrkhOazlyHJOahv6zNb+Hf99iUmM3wAQNBisyHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A4L79eJ5; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2357c61cda7so30695ad.1
        for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 12:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749754860; x=1750359660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwlMsaTHjZOtEXv/YqtnnEPbYBwwh6k+wD4c3F2kUr0=;
        b=A4L79eJ54S8X/R6hdBRCGJERy7H+zrEjPyMVVBDEq73jX4tDGzH3TXGyFFeViSYU5x
         IGzAXqwuH26ZZPVqh2BTD5c3EpOFjYyeo1I9HO28R5rcfjJlc2TAXXEdCVOvI8HMDWfp
         M7wJn59bo/R0KEjXzu89S81WRPMoZVOOhkc21AJp4jsxBc+Z1Ovope1S+Euh07I4obrz
         XE0AA8khB6StZ406/4PRkf1tmhWHpT5xPcwwyRiaVgrHj8YsHyvkoiansK9tWjlLAHxI
         FYIg/BMQu0jDDqJ66Tbft8Y7n2iHJ/TnY54dW18edX+W/DKljg8uhbbwI+IRKCUqSyD8
         Ja2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749754860; x=1750359660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwlMsaTHjZOtEXv/YqtnnEPbYBwwh6k+wD4c3F2kUr0=;
        b=jx7UOHMLZWlCg2pKES/56HTr7k0BZmmbwAbJlt1eb0nuWAmEfJjS9656YsAArEVpoj
         ZwhUx8gwqdsBymGeRd9PYSZThelxl4fu3t7F+q47saY9+VY2yb2+eVgI1hVo1RgxeemV
         GI3wvyQ1veNsCBliL9V2SuRRYRRdYA9PJ0tICDRkYN2A4OWucJPCQeVGqRw7QP2sC8jg
         5AU5ErzfmFnfKEAaID9/+lxf4UQpX1oOaXDvFsyIwhvTL7hBkAdC3fTQspjTL2SK6P97
         5ro3YOp2kbUEGyfTyPJUmCxw1IjpUVEf55pkf03+QnUKWxz2mrge5UB/ixQZN3Vcxqi8
         4tPA==
X-Forwarded-Encrypted: i=1; AJvYcCU4zpniO2z5KPj/dWjnE+zS3WHthlShVgcd6mdMJJ/J27HpGeOD+Dc9CyXz0126tgmyXqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNaQlJbuQ4VYrJ6Dl9UMv8o17cAZ5Pws+A+P5rPd8KS12pI6pI
	R9CH0Avh9tPkcvhOG+1teJaVKPRIdGwTHft97/cehxW07IX1uTlSTW408u06kKWR0GumsUNUfVh
	Gul5jf26ItnSn1uqltI61ud7dIndEfE8PqgStVjLd
X-Gm-Gg: ASbGncuubMwKy/iLH3C1B8c3rMalYvcqCSNmCgt5ktZV5FjgrJDyIoMMvFcSRcUE+3A
	y2RcscZdvZ7EyyqHBjMV/5lc8xpdjHbffOSi7/dJJjqqZi19oV4bMrQuWyqORCQOdN2HCTGynCt
	bZjCXDoeAlIeUlimA1sfbXTECfeZxRpATPva92I03jWfFy+T/VpjVAdu/5Z61jAV64GO/Td4fff
	g==
X-Google-Smtp-Source: AGHT+IF+DrhTdw1EVP33Lsxs8pEmeKyxPiFeWCjxcFQq5i+dtpZuy+WTSh+WvsQ3zeAWf1tAffKMVahMPLgaOisNCFA=
X-Received: by 2002:a17:902:d54a:b0:235:e1d6:5339 with SMTP id
 d9443c01a7336-2365e950001mr97625ad.26.1749754859927; Thu, 12 Jun 2025
 12:00:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612154648.1161201-1-mbloch@nvidia.com> <20250612154648.1161201-4-mbloch@nvidia.com>
In-Reply-To: <20250612154648.1161201-4-mbloch@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 12 Jun 2025 12:00:45 -0700
X-Gm-Features: AX0GCFs8bIh3dxPetT87B5xeJSISXmwVqrXxvRLSdCTJ2AOZNbM701RU8f8TtdA
Message-ID: <CAHS8izNe_g9o92C0RbOe6vtbSfBMbJJJc4K1HubpozN4xwrcuA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 03/12] page_pool: Add page_pool_dev_alloc_netmems
 helper
To: Mark Bloch <mbloch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, saeedm@nvidia.com, 
	gal@nvidia.com, leonro@nvidia.com, tariqt@nvidia.com, 
	Leon Romanovsky <leon@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Richard Cochran <richardcochran@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 8:52=E2=80=AFAM Mark Bloch <mbloch@nvidia.com> wrot=
e:
>
> From: Dragos Tatulea <dtatulea@nvidia.com>
>
> This is the netmem counterpart of page_pool_dev_alloc_pages() which
> uses the default GFP flags for RX.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>

Thank you!

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

