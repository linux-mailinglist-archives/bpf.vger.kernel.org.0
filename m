Return-Path: <bpf+bounces-59660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 449ECACE2BA
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 19:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE5D73A61C3
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 17:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F001F4199;
	Wed,  4 Jun 2025 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/stcwcY"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4F47F477
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 17:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749056595; cv=none; b=C5NWBSWCzd4p/VuSGMdDhPleHrqjHunB7a1DQLxqdQVNw+sGSd04RqDKWMRsElhw7ZY3R7x/AdnN7QpuRRL2nVEFriHcLOo4V/a/IqRmg9+eI0+gKGttXH2Xza96YLwvGnmPSr/Gdf0pSFKOtr0zVo/p7rgYpnfPqGvlPNNMxJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749056595; c=relaxed/simple;
	bh=BdQGqhIQcXP7dsPfNkEdiTmcnCKK5h488sLxxJBhbs8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DTu8B5DzUuo79BlX864Y4h2PPf1VxfrWp015uaelQci8uEq/wuAZES5fUQArmFnx4NUS9x1zoRjH9QlqiAnGGNtkQPtRRRSIiYMYIih8NVgYd/Ghv3i1hv96zkWFfT+v1weBo85Q6ch1drJHrG+YWGhDxF1Ux5gIHy96elUofeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R/stcwcY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749056592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BdQGqhIQcXP7dsPfNkEdiTmcnCKK5h488sLxxJBhbs8=;
	b=R/stcwcY+WZZ4oU/te1L8MbJTeGtVVoIRH9Mpf5ifHCVKlc3AoM+XNyCAlB30RSodpCxCf
	/TDf6BwYPH8p9/pMXu0gAGghCxSz/U8FOhAAG5QdA/6oEqRUEs56CUPMM1N9Thub9YU/aT
	6kUUW4RG0XXn5bQzWJfQgWzYBgla6NI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-QZ5Q4mqMP6SEVf_qNh01LA-1; Wed, 04 Jun 2025 13:03:09 -0400
X-MC-Unique: QZ5Q4mqMP6SEVf_qNh01LA-1
X-Mimecast-MFC-AGG-ID: QZ5Q4mqMP6SEVf_qNh01LA_1749056588
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ad89c32a8a6so3462766b.3
        for <bpf@vger.kernel.org>; Wed, 04 Jun 2025 10:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749056588; x=1749661388;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BdQGqhIQcXP7dsPfNkEdiTmcnCKK5h488sLxxJBhbs8=;
        b=lG5lS/HkGSjUDxeO8Pi6L75YeKicr/F8ZN94viUfkNKGIpeoy+zVnMMzlUT/JN7xtm
         0j0CwZZGwOmipTfgBTvFdgGpqKtucQ+5yrrd5DrizPQlqDIYXS7hWYAUGooEPdfnWVwU
         6wh+A2jODjExfNABBlz6ddQOQiM8A7x/XDvtqeJFLjvJQ9wimFzG6UDGVF5d1pgx8umV
         zr5hLaBzihT/Ilek+yrBtVhV0/lmhrVINtJ5UmPF8imDSoE5xawaA6AwflzQ7AbowcIy
         lMuFSMpSb/mAZ8XB0kSLf9qbsStexi2heiZrPF0Phz1N3/nyBHQim10Ay4Ki3sA+mBPX
         gAFQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9JCZTdWTHBrmlPrxdLItJYcGnDMCj3POW0YEfeFQvoAgsN9ky+DpGgvN1hO2167TIpoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP3pQGKS9AoY9n0Tp2JaDhJde1/1urisl2zWhqnOQIK6YtK+i4
	bVT1WFwZ1a2UszABftEgR9t9AufzBSMTC8BNsvvYuDeFFBMdHRczy81eOKlPJiQidSBywQNSei0
	rKJgTfl0wEeueXM7zMcxEmK/mOJyjp6Y5N2ji0oxYabMG5UleeFcMcA==
X-Gm-Gg: ASbGncupRLqXRz8wUQswX49+lgj4Nmo2kxIOXbEBFfGIfdOx3nkBFDoCgax1cieuQkU
	MLiI8AxvAA6JxLNaheN9RZPM8URbXbwUU8zVJZjeGfCQKPBbzmr/qgABy/i8TVfE8rhaOI1DkGr
	ywZWv+3Db8hzRyHYkE2+nhrL6d4ao2rVTeD2MqQlsR5ATjjODk+BIJbI8T7jK7/edJiSPLfNIX+
	T0owfywX/JtcNmGCsfdjy2AaGowKtE+MqSEqfMrhETb2U+ljLPSx2vzthQsSPtMLRQXmq6IQKme
	AQ3EK+G5
X-Received: by 2002:a17:907:3fa6:b0:ad8:8c09:a51a with SMTP id a640c23a62f3a-addf8c30aefmr329525866b.4.1749056587554;
        Wed, 04 Jun 2025 10:03:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEts9xRj/XK3SRKIWyfVZvu6UAgFyS0hpnI7mT5nnKFo1hg8wg/AtXBkeW4IXe7ZmieN8tHNQ==
X-Received: by 2002:a17:907:3fa6:b0:ad8:8c09:a51a with SMTP id a640c23a62f3a-addf8c30aefmr329518466b.4.1749056587038;
        Wed, 04 Jun 2025 10:03:07 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5dd045edsm1116783966b.119.2025.06.04.10.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 10:03:06 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C8F371AA9171; Wed, 04 Jun 2025 19:03:05 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, asml.silence@gmail.com, tariqt@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
 leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Subject: Re: [RFC v4 06/18] page_pool: rename page_pool_return_page() to
 page_pool_return_netmem()
In-Reply-To: <20250604025246.61616-7-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-7-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Jun 2025 19:03:05 +0200
Message-ID: <878qm7v3qu.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> Now that page_pool_return_page() is for returning netmem, not struct
> page, rename it to page_pool_return_netmem() to reflect what it does.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


