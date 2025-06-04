Return-Path: <bpf+bounces-59649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4121DACE27A
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 18:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B5E83A6843
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 16:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F971F1534;
	Wed,  4 Jun 2025 16:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QISdxq67"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3578A1F12E9
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749056079; cv=none; b=h6lDjvoubWBloXyJFqvmCSqx6mZSpfyfd/FHJYr3j+0kij2sxrqYMOLDIa/nPQXQd+JKHOaMJ36FHexThpt0+wTsSFacQ4HvqYiE98xDQyoOlcP7ekgnP9+jxpUK1NBxQnQ0iXmPFGPgoWdJdut4K2XD/ANbhjRx/dH+QQ0T1lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749056079; c=relaxed/simple;
	bh=tcd0Zzewl9fyLQbRjA4EgreSr8MAtbggVIRO6sDPbgk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uho5gfGP56OkF1Q5DnGrtmixUAm7XDxX4+UnGrMli1ldPTUfwUrtVXDHRVXcyk79gS0gz2kI8OEWW0Nc85KcCq8s0FbHWScbhDhkqUeD90JuyEc+u0OPSEL+UbPF9Uvp8mHDzPFStsvVh3WtnPOcuNwQWfPvac73/QZ+RtYWUZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QISdxq67; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749056077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tcd0Zzewl9fyLQbRjA4EgreSr8MAtbggVIRO6sDPbgk=;
	b=QISdxq67AFUs5gNJT+AVva6r/mR/zXicxjheX8rCMsDk8w+NkNEiJJzhTrrRNXWQcouGez
	r+EZgpXg4cC2D29hu5htcX9ujQj9QNA58W7H0TR4GhWGI/A1udVtfrB+lw1O5UKzFgqq0X
	43PAb2mfRUGFU/7gnyytr+XPlNwxN7E=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-saNKtBpeMD2dZd6FeCc7Tg-1; Wed, 04 Jun 2025 12:54:36 -0400
X-MC-Unique: saNKtBpeMD2dZd6FeCc7Tg-1
X-Mimecast-MFC-AGG-ID: saNKtBpeMD2dZd6FeCc7Tg_1749056075
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ad51ceda1d9so110212866b.1
        for <bpf@vger.kernel.org>; Wed, 04 Jun 2025 09:54:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749056075; x=1749660875;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tcd0Zzewl9fyLQbRjA4EgreSr8MAtbggVIRO6sDPbgk=;
        b=H44UPlpDZieeQdFSmM9tXv+5V7VUsJLxgX3AwVS4zQuwcWyUtomAX4Eo6HHntAJIzb
         KoxFgXpVcGXvmerGIY1qVReG25pWNJODoAxMBA9EPWhuW2+FICNs/kOeNzWxPFw0Y7ux
         +HZuf9UUBmjsUEAsxoGaCD18kAYEUYRClHl/aIotJ6JnDPtBiUgNDzeKPCJc4mpbkz/m
         E/bdJ4svrfFSiIrXYJi0V1cbfDzQ6tnrjeJdkwzOpM6g5daTisxx/VHwrrw4Q6NdfAHp
         3gZYelQJXa9PLOWcRvg3/wPL0jT/NFxlki8jUd7x66TctmuJPpYD48a6P6l3JeRZrPw0
         StJw==
X-Forwarded-Encrypted: i=1; AJvYcCXxlB9ULFnNDGY2SxksQpDALMB04PFgo3BFNdyL5oAvWuhBTApG4XzwRPeV3x0WhyIjLCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqjsSX7T8RGaFHVUYOrQ4ckiizvyKi8RQhY3VGePP/dX731pr2
	2ruhqf1fey3DHQkWnxwmJkAdaF+SzWDrmY1fBQb38ip9ufTcVsNhkbUkryZCqS/nR6w1N/yD5oj
	bRdxW65THq5S29wJ1AxRWJbaSgfLMMU99c1wyfdw9GLXQZJQ+QA4NDA==
X-Gm-Gg: ASbGncvZAppbMY2HKCKvuSQoVZTnkHFqao3ijtbv13RiazE0j7NwNj81QxlhA+YzWqv
	JnjzxEtQNnIkyAtztyCW72wLTuZD+PWQx7m5mdjA4OzP7b40D92D+FWgbC0HL6RbTadDRk//jPo
	BvhmCXYNniBx2sEjMavBMbpRQbe87ypJuCzDsDTJq05txZbMY9qD0Yo+0NJn8X4q95KvcFX8Pht
	RU++reQkaJuHV/24DKxb1VOEkxkIA48iPL/fEyZp7204F14GPShfsq0BzErqgQnz4FX5gdpbg6X
	yXWBYw8sp7AKIE6SU8w=
X-Received: by 2002:a17:907:1c18:b0:ad5:6cfc:e519 with SMTP id a640c23a62f3a-ade076092d0mr26465566b.11.1749056063774;
        Wed, 04 Jun 2025 09:54:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+FyEzbRQ7ljsnYaqZEY9RyRG/Pit4hUmUJvWYN4/otGwuEi027SbI5iZa7eBk4SkzaaVb2g==
X-Received: by 2002:a17:907:72c7:b0:ad8:93a3:29c2 with SMTP id a640c23a62f3a-ade077dafb1mr27934766b.14.1749056049265;
        Wed, 04 Jun 2025 09:54:09 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada6ad6abc2sm1124547566b.173.2025.06.04.09.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 09:54:08 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 9A0E71AA9158; Wed, 04 Jun 2025 18:54:07 +0200 (CEST)
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
Subject: Re: [RFC v4 03/18] page_pool: use netmem alloc/put APIs in
 __page_pool_alloc_page_order()
In-Reply-To: <20250604025246.61616-4-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-4-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Jun 2025 18:54:07 +0200
Message-ID: <874iwvwiq8.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> Use netmem alloc/put APIs instead of page alloc/put APIs and make it
> return netmem_ref instead of struct page * in
> __page_pool_alloc_page_order().
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


