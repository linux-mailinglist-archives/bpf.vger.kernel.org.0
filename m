Return-Path: <bpf+bounces-54735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90267A71249
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 09:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FF1A18990C8
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 08:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A0D1A072C;
	Wed, 26 Mar 2025 08:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P0NReP7v"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE27B1A238A
	for <bpf@vger.kernel.org>; Wed, 26 Mar 2025 08:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742976769; cv=none; b=MnOCwm4b7NJGWRzagyiuIyy7qh7SWKJf8+JnUTgwEe8e0LbA53zLMiShTDnpi4kxx2kEyLZN8yRXxVuBQOgaVtGfLIdgcRqSuI2qR2yGDYqptauoUzEIxcht54TQCBiYxCKNolFjNz9SlbR2/rWEcWa4Uk7ojICJj5bO2Rutt9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742976769; c=relaxed/simple;
	bh=/i5+/BRMZy/oWIkpPBk5bPU1qjbR62bTRHV5eQdywzI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JTZCwIQHCkl9hsyO6bqD9Je8WCOe0e6v4iYYn3yEYpqz3BLhq96ieUabKXVcVpcnSdEE89gT6escSyVltxnKvkI9suz1R3eXTXvZRD7mum3u3rr39y6tRSMJrLDbpq/N+U58mDKbR8v3bw1U41aie1bqhWwwrZ6YmD2PqxCrEY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P0NReP7v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742976765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/i5+/BRMZy/oWIkpPBk5bPU1qjbR62bTRHV5eQdywzI=;
	b=P0NReP7v/lhkPLnTvGmEtLLG9t0fIvphPsiA1PoW0QnbLfb6W5jzCflwKKsQU+7fwzB3m0
	qQcn173bGSEyAbRp82mvja918bRkqz9jcQSgNo8zxkhlgf2BQ8ayPCYUcb64CU8i4u3Z4f
	u2SKcfpJpV13KD/WuyPvfadANYqHslw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-AOOh-A2DMuGWgsh-pTzr-Q-1; Wed, 26 Mar 2025 04:12:43 -0400
X-MC-Unique: AOOh-A2DMuGWgsh-pTzr-Q-1
X-Mimecast-MFC-AGG-ID: AOOh-A2DMuGWgsh-pTzr-Q_1742976762
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac2aa3513ccso505305866b.0
        for <bpf@vger.kernel.org>; Wed, 26 Mar 2025 01:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742976761; x=1743581561;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/i5+/BRMZy/oWIkpPBk5bPU1qjbR62bTRHV5eQdywzI=;
        b=AM+EBhbl7uy+iSXN44lOqv4MTIbYihfrT2hc3q61jHndBlHiu+pVxVnbbnbae+Cynv
         1Jz5NRYEosLbzZsDkJWyUhFoRKn2AEccHayf075MLM1QtaqzvlrcHRkSprtCb6AxU4wa
         AwtNz2EJOrIjYKmuTlKB6khmbGQiTftWC2Em48A4eUNEQNKKmblk8VNARedbDV2T0qk6
         VZqxm9dYNNWvJcQBVUMyy7COmrx+pKVEuUpATHxvqdSZVfQbJXrBJwTRDnRwQ9iqyzWn
         oupf8X+g1MPZ2PFYbk0mYM+/fvvKUNCkbW7g8Xo/k9vOaPkabpeJrD+lMrqElZkVkZkL
         WnHg==
X-Forwarded-Encrypted: i=1; AJvYcCXtdEOpsNm+UvYTGhCid6e+qgjoFUlYZdX/afMCBvZVBLrbVrAe0p8jH5ZW9kvrbsKbWpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtmlUNGZd4T4OKWpBMGoErZcpJ9YpeVvy/d3Y/a1PGVR4kVvrF
	VR36lwlULe6alli1uS5xFgi1nFyRHI5SeHU2ekYKh7XN/16SKUqGvwiNsXHUIFt78WcB5vVrLRe
	AgNu5lwL70uPp3UVvYprPVA/fVKbqaFQiInz00Z7bp2FmRcRQAw==
X-Gm-Gg: ASbGncv6Pq76kVB7/oWEkiVr0aPA3GAaWZYYqoPQbT12NAtx1/2Ul2/DxXXLShOLN/M
	51EPHe9MMfVGw8zZ1UwdFtb0ZICCvAJYUHThCj8OQKifVlHzgCaA22YdIgtb8HluILAM6xtQpU0
	unQAGJuu8CPJxaXsXsvuAG29Tgs7tRnqJf5ojSXL29U1ru2tLOfRO/feR0MNwwwPwveLU5nN4FM
	IpPPtPPmawFWP/pquFH73DJ0K/MdMABKXuc1CGyb0T9y6CsoXSZs4o6yb8kxmoblsP4DNeh2mdt
	rsYu26kt6kEb2CvE+2ijBGiR35eCX6xepSlvvQrU
X-Received: by 2002:a17:907:e84c:b0:ac4:751:5f16 with SMTP id a640c23a62f3a-ac407515fefmr1710095066b.30.1742976761511;
        Wed, 26 Mar 2025 01:12:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7tYXUyRnYRid7WXsc4ocXyKGAEp70GrWLAvLlsK1V4El27+8QO6/yVgb6O5atgR4hk9tmqw==
X-Received: by 2002:a17:907:e84c:b0:ac4:751:5f16 with SMTP id a640c23a62f3a-ac407515fefmr1710092166b.30.1742976761087;
        Wed, 26 Mar 2025 01:12:41 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efda474bsm988606066b.183.2025.03.26.01.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 01:12:40 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 305D018FC9C4; Wed, 26 Mar 2025 09:12:34 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon
 Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mina
 Almasry <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, Pavel Begunkov
 <asml.silence@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH net-next v2 2/3] page_pool: Turn dma_sync and
 dma_sync_cpu fields into a bitmap
In-Reply-To: <20250325151743.7ae425c3@kernel.org>
References: <20250325-page-pool-track-dma-v2-0-113ebc1946f3@redhat.com>
 <20250325-page-pool-track-dma-v2-2-113ebc1946f3@redhat.com>
 <20250325151743.7ae425c3@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 26 Mar 2025 09:12:34 +0100
Message-ID: <87cye4qkgd.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 25 Mar 2025 16:45:43 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Change the single-bit booleans for dma_sync into an unsigned long with
>> BIT() definitions so that a subsequent patch can write them both with a
>> singe WRITE_ONCE() on teardown. Also move the check for the sync_cpu
>> side into __page_pool_dma_sync_for_cpu() so it can be disabled for
>> non-netmem providers as well.
>
> Can we make them just bools without the bit width?
> Less churn and actually fewer bytes.

Ah! Didn't realise that was possible, excellent solution :)

> I don't see why we'd need to wipe them atomically.
> In fact I don't see why we're touching dma_sync_cpu, at all,
> it's driver-facing and the driver is gone in the problematic
> scenario.

No you're right, but it felt weird to change just one of them, so
figured I'd go with both. But keeping them both as bool, and just making
dma_sync a full-width bool works, so I'll respin with that and leave
dma_sync_cpu as-is.


