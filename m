Return-Path: <bpf+bounces-55055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E33A77796
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 11:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE5391668FE
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 09:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803DB1EF0A6;
	Tue,  1 Apr 2025 09:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A1QF+/mA"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6033C1EF0AA
	for <bpf@vger.kernel.org>; Tue,  1 Apr 2025 09:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743499222; cv=none; b=Fsnx/d5qQarB0Z92dzvMaC7Fl+t1KZMBHIMiocIvlHcrrBQbE8WsngVwZJYZb52TEQ/9HAVVwfDL2fgrlKgM4V+r6XkDu3gVX6V50nXL/4oUjOUY45Y21AYYOHC1tLGsfnIb7w6sYbYI/kOzYHBU99RY43R0cfN9mTuehi9X9Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743499222; c=relaxed/simple;
	bh=gX/0To/6YtBCqwy2SgsC4Ii7GnI2MAJKI9nklFY1vT0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iBpaDUscJ+xHGFaGz4gwSKknHs4BwJGCEH1QG5gjLtk6tYnr2bs7lBRbWUzhnAHwfpQCJ9l/kpjSd98K8CIEz7fp1yVSPM4CJ3+7v1eifzTxURvG8EllVcpNx+h1UmCcAZtQEL8EjTu7Lq0ZJDYA0ttDte8oTZ26DK48kOxSnlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A1QF+/mA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743499219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=heGA+8Yin7XsohFnbU8J4lLXr8jl9xDIj/NCrhpNVe4=;
	b=A1QF+/mAvXMSRDXxgt9lWuCEg87Qdv+cyWKC83a/smkAsHb+DTxuq4jxUUQ1OF2iPghsPL
	gEtJiaijirqwOps85PT0UFX2h62Q3HxylHvdm6Ly72UtnLjr0euh4p0MRQWcWq+0bBh5Ea
	/9QXniezb3vPSE2fqNjFbaVwdFQiQsY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-9J7Zl8zEOZ6_lUibf1LHAg-1; Tue, 01 Apr 2025 05:20:17 -0400
X-MC-Unique: 9J7Zl8zEOZ6_lUibf1LHAg-1
X-Mimecast-MFC-AGG-ID: 9J7Zl8zEOZ6_lUibf1LHAg_1743499216
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-54b0e3136ddso1408103e87.0
        for <bpf@vger.kernel.org>; Tue, 01 Apr 2025 02:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743499216; x=1744104016;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=heGA+8Yin7XsohFnbU8J4lLXr8jl9xDIj/NCrhpNVe4=;
        b=p/PDp0L4V2UpZ8+/fJqMg4tqwD4ZrAHAk0b4gpt32Sg41jAo/LD45DfKoAECWEUCzD
         LNt9tUE3c4+K6gfLl+ARwkRSsWvHVVyK6V29HBoj4yhx9C93D1fy0gsLB6r5/RIDBho/
         e7Xc1scYqs7ocHOJomDW+taaE9/s8B+W+neJKVo6PwVlZlXytezlzEB0YHV6WelYQ9oz
         jSOwSBBqY1qsDu5a5cwtFdK9Mam6kwCciy0uCX//DdJRIzb5+1jmNPRyFmFIwU4Wv+I9
         sG87zQiknQpe7/BAQ/0PYDE5U6hF5xgk5vKV38Jmj/hZalReuS09I0+r5JLMcHaX2D64
         Xl1w==
X-Forwarded-Encrypted: i=1; AJvYcCXPPMeo6bDaqwlZfMm51AVrYSfEDM0/MTeepkd340yDh8yxJyOPpTmR9p5FS0k4oSxGEOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSDJu3pT6uXn2oCj11Ft5ORitladTQVe8VgPtE+W017n2A2eJV
	/TsGMKrt7eCsDDSa8RP4PGg4rBugR8rbui0mBHDZ5lT+IWb5lwfvkDQbdJoNQh3VbMUWmSCworZ
	TKBnc28Pf9RRim8kU9tpm4KploFz/eKTIUDrOAiqLcvSkB0iPrQ==
X-Gm-Gg: ASbGnct6t8EFRspDvuvRD4dIpmB9CNzJoEpYVmhBOqPI4mdz87Xpm2bwZ7sfZq+PJej
	Z4yLfZAar1qYzg/bfDdS+k7JiQQgfTpYDyz9pr9AxwCqo1m3wTovEkKQAq1elQ/J20vc/AafXCa
	11yamQDcPFH9dpvyunOe+ot4MSDsYZ6x2GTa1tQqkTFSLjpXnZI/7LF7qgqcxetBnB4qxa9Aqja
	6fsUI+Gdrq6MYM3d3cpGaGt01tYQsaAYQ3YCGUL19FXQom0Dt9fgNrKD2aM1DcMfztVIw0o2D/K
	EuWEDntjhvlYQlqhq/DKu/1+36UL59xRamGsgFRx
X-Received: by 2002:a05:6512:3f04:b0:54b:117f:686e with SMTP id 2adb3069b0e04-54b117f6902mr3637414e87.27.1743499216255;
        Tue, 01 Apr 2025 02:20:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmmFffSwB8Z29FU4ImF8MFszvFBnxPrac+wWziJPyVeOFUs+I7ScJdTpfzV4RapF89FKPnIA==
X-Received: by 2002:a05:6512:3f04:b0:54b:117f:686e with SMTP id 2adb3069b0e04-54b117f6902mr3637402e87.27.1743499215879;
        Tue, 01 Apr 2025 02:20:15 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54b094c1db9sm1297217e87.78.2025.04.01.02.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 02:20:15 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0BCA518FD259; Tue, 01 Apr 2025 11:12:36 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Mina Almasry
 <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>, Yunsheng
 Lin <linyunsheng@huawei.com>, Pavel Begunkov <asml.silence@gmail.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, Qiuling Ren <qren@redhat.com>, Yuying Ma
 <yuma@redhat.com>
Subject: Re: [PATCH net-next v5 2/2] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
In-Reply-To: <38b9af46-0d03-424d-8ecc-461b7daf216c@redhat.com>
References: <20250328-page-pool-track-dma-v5-0-55002af683ad@redhat.com>
 <20250328-page-pool-track-dma-v5-2-55002af683ad@redhat.com>
 <38b9af46-0d03-424d-8ecc-461b7daf216c@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 01 Apr 2025 11:12:35 +0200
Message-ID: <87y0wkmeik.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni@redhat.com> writes:

> On 3/28/25 1:19 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> @@ -463,13 +462,21 @@ page_pool_dma_sync_for_device(const struct page_po=
ol *pool,
>>  			      netmem_ref netmem,
>>  			      u32 dma_sync_size)
>>  {
>> -	if (pool->dma_sync && dma_dev_need_sync(pool->p.dev))
>> -		__page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
>> +	if (pool->dma_sync && dma_dev_need_sync(pool->p.dev)) {
>
> Lacking a READ_ONCE() here, I think it's within compiler's right do some
> unexpected optimization between this read and the next one. Also it will
> make the double read more explicit.

Right, good point; will respin!

-Toke


