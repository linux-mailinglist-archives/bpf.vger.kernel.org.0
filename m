Return-Path: <bpf+bounces-59656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE4AACE29E
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 18:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C1933A6C8B
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 16:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6B51F4631;
	Wed,  4 Jun 2025 16:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C21mvKqk"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2CF1EB5C2
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 16:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749056230; cv=none; b=PUTzukylz87ETZO0szbhmvanxE9x5EAgKXGM2BDBjiGRyPmrJllpGtIMiFfqpztLVSbtqa5b3KRW/4cQfgoZ5NexAHjTtwugFNC0OoKZAs/Z0V9SGlXmUosInBX5uGrZoK5Gv4AfcMfsBZiE2gsn7/aAnS9S3/QXudFbugcR82Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749056230; c=relaxed/simple;
	bh=Gw+d+3S7IYA06FhUQyd+hYu00sNtRnUnl76qT+h9VuM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J4SbxFsG7g+Ni4MoU00xxJp/D3AFCU7e6RzaqHbkw358F9Wgvtq5vBuVAYW6NxIdui/HkvwBJZxpjTC6DxZ1+DLGbhs0DZFZ5unytJ6yV1GKdenFBuJyVNG3NG+UF9ZRsUSeeS1YmqaEe1gWW1HXqdYWE9j/znx/P/vlNA6qcO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C21mvKqk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749056227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gw+d+3S7IYA06FhUQyd+hYu00sNtRnUnl76qT+h9VuM=;
	b=C21mvKqkLS0A/YrHS/EtdqzOYjc98nNuFpGO1bflNmzD7R9KSJTSTkheFTCtQV9dZaMjrM
	Ecd/InFBn1gFdVjXuNrYkzZAJvI3JnKs+tNejMEM3B2EKgMiKe36Qx53mxuQJ/tWlBmAAT
	IhvAPgpcB1SQ7LAncp3Q6sET49Iuczo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-Jq-d96cpPHud_rqsA_Ankw-1; Wed, 04 Jun 2025 12:57:06 -0400
X-MC-Unique: Jq-d96cpPHud_rqsA_Ankw-1
X-Mimecast-MFC-AGG-ID: Jq-d96cpPHud_rqsA_Ankw_1749056225
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ad5697c4537so12338566b.0
        for <bpf@vger.kernel.org>; Wed, 04 Jun 2025 09:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749056225; x=1749661025;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gw+d+3S7IYA06FhUQyd+hYu00sNtRnUnl76qT+h9VuM=;
        b=MI8qUq9JctgwwL7q2exB5DdEdGxPJQPsgfeFfzJ5MHDIhKy1Kwj6aqK2wBil82vBin
         0SMGAIJQTYiRxgWwjb9mA6ujdW+qCOIL14WVHf9YTmT52Apuu5UzjwhXwYDv4bHfiftw
         LfqEiErDZBD2K9TSdj7QD3uu6+Zs9Lasg2D7oPLSGCxcAZIYrTnp0JwApKbusvTpqznY
         jCYaXxBetf9VQG53+86Hp3zaNUNuRoUiYpINQxJUJil79N5WIF6p3fmb2dR06mofgckZ
         iovzkzTAuobkhctWaJjZ+2KOQHvzM6EBn3xpG1hPtddqbWP7aGBzpQ4wJoqjQEpfzgD9
         pjcw==
X-Forwarded-Encrypted: i=1; AJvYcCWH+lX8qeE3VxOQbT7HBWwfpWxvIkzbGO9ksO7ukoUlfDiblwfgVrKridp+EwBIj+pCsn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyChT/EZtSuigZ4FLYmTdCANQ8ttudUpFC36ZGarWQcuLgp13lh
	xoSEegsPQufZkh7MsCXxvZ3EIPyYuBQHomKGDvcH2kJkLAapKcAhk4/FgtRojjekkER/Rw2FbIT
	0UozIQi+pEmjSC0GlbOCcfzCWo/IBCu0ZCNN1Y0GIwYz7YFjqK2x1EQ==
X-Gm-Gg: ASbGncuRds+pT43gBFZG1KOQI/qvgKfksf4J44aZXMDl5HDw3wIEXtStieyG9EW4LbD
	m7CVyZWxlAism+BNZ+OT5Pja0Diq4VFBdBn03gPNj+bEam388Qkq5UzrDlXcxlkiLqNW/ivEpCB
	yiMTxeKhenHQXNx2GB5ZzJiPjlrkrRjiFuoJjSFCXX3eZYAsaifeyPdrMc3p5OGQPeWUL0Q8wD2
	IHONZMNbmyWN+K1O7qtRE+yfj+17EcLbAyCeyDhapbIvjWwqkPu3Xa5E6KYB5eGP9OPxejC1bvv
	ksGfHbIc
X-Received: by 2002:a17:907:1c26:b0:ad8:942b:1d53 with SMTP id a640c23a62f3a-ade078951c7mr24903466b.27.1749056225235;
        Wed, 04 Jun 2025 09:57:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqG4TOAjPvMml/YdZyEoQ+QahksC02aQ5Whxm4dNHjvxJYD+wb6qalU2zcWL3KxMHhCO06XA==
X-Received: by 2002:a17:907:1c26:b0:ad8:942b:1d53 with SMTP id a640c23a62f3a-ade078951c7mr24899166b.27.1749056224800;
        Wed, 04 Jun 2025 09:57:04 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada6ad6ab8esm1110204166b.185.2025.06.04.09.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 09:57:04 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 59CA91AA9166; Wed, 04 Jun 2025 18:57:03 +0200 (CEST)
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
Subject: Re: [RFC v4 14/18] page_pool: make page_pool_get_dma_addr() just
 wrap page_pool_get_dma_addr_netmem()
In-Reply-To: <20250604025246.61616-15-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-15-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Jun 2025 18:57:03 +0200
Message-ID: <87jz5rv40w.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> The page pool members in struct page cannot be removed unless it's not
> allowed to access any of them via struct page.
>
> Do not access 'page->dma_addr' directly in page_pool_get_dma_addr() but
> just wrap page_pool_get_dma_addr_netmem() safely.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


