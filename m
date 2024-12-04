Return-Path: <bpf+bounces-46067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BDC9E3834
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 12:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 732E3B2A9D9
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 10:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C991B0F04;
	Wed,  4 Dec 2024 10:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QlBqhEPm"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E7E187555
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 10:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733309353; cv=none; b=J1Wv8M9CodK/1uyuwkVTQI5T4S/KZmCnKB4MsXtk01RfJvthk972jb7VI+ZVakU/c4vjxohrQPljx/um0vF75haR9LHJc2gTRWVogLbXRBEqNhJMGlFIyXrdzNQgeNDObTaBw1xbiPNX6M71q7bl6hyaRVTFizFTb0YuNVI2u/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733309353; c=relaxed/simple;
	bh=bGyB4438J81jRH4x6gWKO6BpBH8blrXI02fUkyoMcgo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E/zW5YLKORmQIQDKeYy1wbUwi3IkSEPjwMask4tLR9BuAx35Ww6z1CmxhjN64ko90UZ3BBlVFmUPYxHUAcw7gTstq9Dm7ZOZgFoRpmr2N9Btl1QZFksFehQFdhvwXdkihhSTsSLxRtm57Nhp07rY3ICqdhLzKOMWMU8mUH4aebU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QlBqhEPm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733309350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gTz3waxgahN3oOX83LVGcoQz1BmDfZdx8p5FTeZL4LM=;
	b=QlBqhEPm0NUTb3yckpTh8NGoPILe9/EHp7w+EavenDMF6sElumwUSso6EMTJxqliq59ug4
	YZmWkxqrsyzRfBb3nvTO5JRjwC5PbUvF1EH/+VKGfJppdDUr8NqC9M20S42guOQ0Q+eSOb
	LrkfRezmv4LdlAV0CtJ+BuH9VzBMea8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-Nm9ADa1qNFatIVVXEcF6yw-1; Wed, 04 Dec 2024 05:49:09 -0500
X-MC-Unique: Nm9ADa1qNFatIVVXEcF6yw-1
X-Mimecast-MFC-AGG-ID: Nm9ADa1qNFatIVVXEcF6yw
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385d52591d6so336491f8f.1
        for <bpf@vger.kernel.org>; Wed, 04 Dec 2024 02:49:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733309348; x=1733914148;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gTz3waxgahN3oOX83LVGcoQz1BmDfZdx8p5FTeZL4LM=;
        b=Lw6l1fb8l54kifU481dkDJ+knFTTerlwD3BulUBDbZI1VZR0CvjRL9uJPflL82sUw6
         lnl9xMxMHm+CAg71vr37zhn3n8LoFdDAlU/jMgdwydVK5nqvAkqwR28+0MzXA35Ue6mW
         rxM3bEbjJPpehZveOqsp2alDL79Dp/XIP8lbA0UzuaynNVOn14/Suar++/YiJsjbOJhN
         1OWgBrcPQsT+gPO2o31hZNj00tZcZFjCwaLP/A38h59/Q1gUb77yAIgXHOLnJVICn0Dp
         A0YH+5NmWVCifXEo+5yb7lZ0HH12zu1e4xQveYVr1LQ0l9eHfi6ifBFgDGU7zCN9bp8U
         96bw==
X-Forwarded-Encrypted: i=1; AJvYcCXEqK9ItF2VAMgG+W3lDjdPl95huldMO5TWijCTZmEAbdSqHaEwAj/dYHk5gPecdMbLcr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUk4sx68rAE7VCBMEULpj/o10DbJPg6vRxvTU6Pfgc7To+k1/u
	tDySDCXx8UBjpwjLNLnOzxI99QMz4VMRGBem/s/CoHhbkMQqo+PHz6aGJbLV8MNrMIqZvr/TDLg
	CRYrY/ih5ZEMKsm+xrjeQD7v6tmCaBHOOhjqqbeoyszNg7glSwQ==
X-Gm-Gg: ASbGncs7xoQ7ceyfy9xk5b2TETZgNqZ0j3dY2ysMcA8EFdv5gXUzNKdkqrqq5tAo6I7
	WwtnzT9hUx64htQ+sQs/nIKGsdYLv3pe6i9fiQbVCKFSiF8O+FPBa1QAnh7X3V4KxPIniJOZbp6
	gMhESmji5uuBBvkoRTHJKSpLPZe9cDwsMhW46/+5IXIRUcK8xfhVRUsomgVSaetJRF6WqRwWhUS
	hjfMo5AYKSxegFxxPaqClHyHMCUm5j4mZADB2vEiECCpKI=
X-Received: by 2002:a05:6000:401f:b0:385:ef14:3b55 with SMTP id ffacd0b85a97d-385fd9abb87mr4384226f8f.19.1733309348365;
        Wed, 04 Dec 2024 02:49:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcEgMypYhXM56G/nD3wm0gwci3A8/obXgJv7EiRTyM21DWn6RxvvWTZKFaMDEAHFySbGhZ5A==
X-Received: by 2002:a05:6000:401f:b0:385:ef14:3b55 with SMTP id ffacd0b85a97d-385fd9abb87mr4384198f8f.19.1733309348033;
        Wed, 04 Dec 2024 02:49:08 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd36b80sm17799002f8f.29.2024.12.04.02.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 02:49:07 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 8C43016BD10C; Wed, 04 Dec 2024 11:49:06 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 07/10] netmem: add a couple of page helper
 wrappers
In-Reply-To: <20241203173733.3181246-8-aleksander.lobakin@intel.com>
References: <20241203173733.3181246-1-aleksander.lobakin@intel.com>
 <20241203173733.3181246-8-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Dec 2024 11:49:06 +0100
Message-ID: <87ttbjafkt.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> Add the following netmem counterparts:
>
> * virt_to_netmem() -- simple page_to_netmem(virt_to_page()) wrapper;
> * netmem_is_pfmemalloc() -- page_is_pfmemalloc() for page-backed
> 			    netmems, false otherwise;
>
> and the following "unsafe" versions:
>
> * __netmem_to_page()
> * __netmem_get_pp()
> * __netmem_address()
>
> They do the same as their non-underscored buddies, but assume the netmem
> is always page-backed. When working with header &page_pools, you don't
> need to check whether netmem belongs to the host memory and you can
> never get NULL instead of &page. Checks for the LSB, clearing the LSB,
> branches take cycles and increase object code size, sometimes
> significantly. When you're sure your PP is always host, you can avoid
> this by using the underscored counterparts.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Makes sense to have these as helpers, spelling out the constraints

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


