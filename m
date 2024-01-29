Return-Path: <bpf+bounces-20588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED517840650
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 14:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 806C01F260EB
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 13:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D81627FE;
	Mon, 29 Jan 2024 13:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iTJFAb49"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C686612C1
	for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 13:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706533669; cv=none; b=WCiYGfmyUs16k7z00yayIxQ/Fp0IwNkpMFHpkhgwTbVfS4hbtEOrw3NV2VbY6fwRX0mSBLgxFb47+ZZfrVRwcjNU1EkJOzdmS9B1PS+ghL+2DzrhMDqhPHroNvCJ2xke/k8d9wQZ06Q4u1m++qC9dbkqWKZnQDy5bghgWk8cCYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706533669; c=relaxed/simple;
	bh=v3pFngetfRn5EzEB1NDrmSiNevTrv4qOYrVy9TnfCEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvMCKN6qlbaPQd+2/MQUg2hGTfUvXtOFLRgdE8GOl1fUn+uot9WXAWesbyRlTYWraHu4GAcskGMIKg0c58DP8/VA7AqsHTTUioIOUjwVihs6g4+VkpeAWjUOxOUhFoN7czkwQPdd9oM2RGKQv+RuO23AUS0zYrjqYR+VQEzvwJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iTJFAb49; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706533666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v3pFngetfRn5EzEB1NDrmSiNevTrv4qOYrVy9TnfCEg=;
	b=iTJFAb498qVdLQEKNRchLTQjla9cFKXvCvzBKqLIR9RMrXSwVESR+3XSeh/mU/UIv6yIE/
	2Bx4nzqLdVAgcoSDIPDJG7QRfIlIyktsizjMOCYGKkmlTHJiNcZyIhoKbnx/cLYIP6o2YC
	jM461/sx/2d+YsgyZm1RGw/GJ7UZz3o=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-CjbKWlhcNYGOXYGKaPsi5A-1; Mon, 29 Jan 2024 08:07:45 -0500
X-MC-Unique: CjbKWlhcNYGOXYGKaPsi5A-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2cf4166eb82so17207911fa.0
        for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 05:07:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706533661; x=1707138461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3pFngetfRn5EzEB1NDrmSiNevTrv4qOYrVy9TnfCEg=;
        b=ohs9nDc/HyY/FqGYMkRQ63ONHSOasyZUxphOXZA+ftpHhbiq1Nr/ndclz2EYnkwm/l
         kH2N7hsmAX1Hy4gGNxKy/BbG8y/IjOWBUcCQz+1kzKF0PZHpj6ZPnWaSARqTq9BODyXv
         3lD1LBWYNp1J5+dGb0OrhcRhV/zt4I54q1ZqG06tYduJJEnil9CIIRz/BkAgg3b+zXSh
         uXenleGqehL4M+IRbR/NhOAx6Dr9uIS4w3do6fn5tCq+uYeSBoFy2+lUTJZ5clv8aJTn
         y9zvIahuHoDOtO5ZgiRoMBdhC5maSf9HvX2wCg+BHBBSAzydi1sFYNZjB/H9ATS60Oz/
         tTkg==
X-Gm-Message-State: AOJu0YwX8eAb0RpS6JfNK095TxBIDf4PEutsmU4im3vkR5Y3cW24YS8g
	AkbCm4cjR+gCBRhcC63ySSC7o2CXEUVeRxM8r4I3NXGh9nwnG3okcF2K7XDqGUiosUQ0nI5yRyP
	OkBYhR3ETu94dINPNzVuuCv6/jo67Wx2+o/HlrpYg3uLu6vRE/w==
X-Received: by 2002:a2e:bcc6:0:b0:2d0:48d8:1eb1 with SMTP id z6-20020a2ebcc6000000b002d048d81eb1mr2470665ljp.0.1706533660953;
        Mon, 29 Jan 2024 05:07:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGT6crec8m2HFtDOFEy6UU3Q+re1aM0TkHBbsF0YbVqzKDq3z0zInecTZ5NC19BoPwU3uhdSg==
X-Received: by 2002:a2e:bcc6:0:b0:2d0:48d8:1eb1 with SMTP id z6-20020a2ebcc6000000b002d048d81eb1mr2470646ljp.0.1706533660644;
        Mon, 29 Jan 2024 05:07:40 -0800 (PST)
Received: from localhost (net-93-71-3-198.cust.vodafonedsl.it. [93.71.3.198])
        by smtp.gmail.com with ESMTPSA id v1-20020a5d59c1000000b0033aeab6f75fsm3757049wry.79.2024.01.29.05.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 05:07:40 -0800 (PST)
Date: Mon, 29 Jan 2024 14:07:38 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, bpf@vger.kernel.org, toke@redhat.com,
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	sdf@google.com, hawk@kernel.org, ilias.apalodimas@linaro.org
Subject: Re: [PATCH v6 net-next 4/5] net: page_pool: make stats available
 just for global pools
Message-ID: <ZbejGhc8K4J4dLbL@lore-desk>
References: <cover.1706451150.git.lorenzo@kernel.org>
 <9f0a571c1f322ff6c4e6facfd7d6d508e73a8f2f.1706451150.git.lorenzo@kernel.org>
 <bc5dc202-de63-4dee-5eb4-efd63dcb162b@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BeQHw7o9DS5E/2ZF"
Content-Disposition: inline
In-Reply-To: <bc5dc202-de63-4dee-5eb4-efd63dcb162b@huawei.com>


--BeQHw7o9DS5E/2ZF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 2024/1/28 22:20, Lorenzo Bianconi wrote:
> > Move page_pool stats allocation in page_pool_create routine and get rid
> > of it for percpu page_pools.
>=20
> Is there any reason why we do not need those kind stats for per cpu
> page_pool?
>=20

IIRC discussing with Jakub, we decided to not support them since the pool i=
s not
associated to any net_device in this case.

Regards,
Lorenzo

--BeQHw7o9DS5E/2ZF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZbejGgAKCRA6cBh0uS2t
rI41AP4sSIQMPOWj4JFrRlg5LcvVBxuM5EAt5SBxiXNrjgBk4QEApBgcPYTRp1vi
j4kOlOCJa8v6tQa5d3cn6j/hLr4xSQc=
=EGVm
-----END PGP SIGNATURE-----

--BeQHw7o9DS5E/2ZF--


