Return-Path: <bpf+bounces-60348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF05AD5C6E
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 18:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74CCD3A453D
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 16:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B813C1FCFE2;
	Wed, 11 Jun 2025 16:35:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB4518D63A;
	Wed, 11 Jun 2025 16:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749659752; cv=none; b=m6fP9LGxw0yxhsNOPJtKB0SAMQpoioS/5Z3Kdf4k3AzrMqKqmz7tCS3XV0XQM/SJE5tKEHZXn3aojjst22Vec/gryASTwRgc+G4NtzUheVifuRoAUtijx0hZHSKlvgRGcRsKZN/4+3G2cCiftm8IIVFcioR0aGeK9dpqRVhorN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749659752; c=relaxed/simple;
	bh=yRWiyKzTZIwYVSICMOESJzF/0ezgw16gZI784NSkC9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhmLnkxNCTpwOGYEPYo3YqNo/1qKuwyKCttmYcDHyvciKMA6Cw90fEgbzgcoRitWR8t59GlnjWtFj8xAPC19stGBW1ER5TzEd4k1G4O4R9EgrZQfQbYAmwhfQC1s5ExLwwWyJrUyvRbAYdTQluI9YfmC1m+3iiuBRCvLgGjeMQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ad8a8da2376so1524266b.3;
        Wed, 11 Jun 2025 09:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749659749; x=1750264549;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yRWiyKzTZIwYVSICMOESJzF/0ezgw16gZI784NSkC9c=;
        b=ok4DBTMHEXjbEJlkG9z9IzBXKRiZVFmRyLw3B6hTB+RzfUFhCgfkTBB2Mwp5Aia++2
         lgLICZYLjm0ROja7umFaGuCx6n7TDQnzhg35HapHOOhUydx7+E2E6ArDiTo1T3pxLxnt
         XNUsWf/2GkXWS25qWvVJHepMFuh8zSWY/aHM5JEfVRg61hVrvoawfBTSrN3CiAv2ul+9
         aZbjLNi0kC3GtU4bub3f1wSO/t89ThEnEPhiJN36vceAQSdBR/RlutdBTUAVjm2KrHg3
         ICbTutWhmc4W986qnH3w3/Sum/Ze45fk+o2Vhn2tI3lWGRZvKYxPal2doNRbj9ModiV1
         mF4g==
X-Forwarded-Encrypted: i=1; AJvYcCUsqPoYqQa3bVlf8ePplX3oHEYa2j/hUHrQ6toXJxWIiLyREiLlQxMzU029YUkGg+yJI1Q=@vger.kernel.org, AJvYcCVUaQkO0oxLG+okw6YilhrAh+Tt8og598ngmIjWO7OjOryIjXpl9HqG8WbfJr5Q5rA3DN8nrWUzrMWWBQ==@vger.kernel.org, AJvYcCVxZMQUpxknwaGFoyqqVWBar4eZjBUfuI1AwPtmflNGrQTUfUU3XiYn4CaX+XlKJcV3qUgYORv5@vger.kernel.org
X-Gm-Message-State: AOJu0YzcastT6IjGVTSC485Bt5/Iqp3J82KqwOiNv/N0ETqImbf5nYu2
	ipCfrZUci8neOwK7F0kNE0qEiQJyR+GgWGeecPKA1E9JtAhwtOt2I9BI
X-Gm-Gg: ASbGncvJ3EXidBI8eeKHARpM9qizLwGTSzqRxuaiqa6zurkJGxfsDBCGowKg9l9WrQE
	AyhTxes5cARgk6mtHWl7sNsYtMLF+uOdMaf+C25s4mHqKmxyOGZwGCGTAHl2afLitf8FpdZPDZn
	rxQkEUoUE74KGPiqx9R3Wo7iqSSITIEcMQupCYk7MTW7cgLLjc4WiwMuEXB+ymv/UpCoQbeqrQ0
	m40dxYRlGcNN4H9g6DWoMMu5mAgb7r0nlKIIIcIfKCsucI9FuRYXOykJJwU0O4+WpOf+3RXiqvr
	Edv0YBHS20NQsU2B+yJwCsnbRSTc7kXxxNV2SW0MjA3u3KcX2axx
X-Google-Smtp-Source: AGHT+IH8800fbrEqV/iLLY12BMrBiMpvGEluYR//L52df8OeajstZoqRP5d+Y/gWnB/DDPCfo8cCXw==
X-Received: by 2002:a17:907:6d08:b0:add:ee2c:7313 with SMTP id a640c23a62f3a-ade894c18edmr316262166b.22.1749659748826;
        Wed, 11 Jun 2025 09:35:48 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc1c788sm923016766b.101.2025.06.11.09.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 09:35:48 -0700 (PDT)
Date: Wed, 11 Jun 2025 09:35:45 -0700
From: Breno Leitao <leitao@debian.org>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mina Almasry <almasrymina@google.com>,
	Yonglong Liu <liuyonglong@huawei.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Matthew Wilcox <willy@infradead.org>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-rdma@vger.kernel.org, linux-mm@kvack.org,
	Qiuling Ren <qren@redhat.com>, Yuying Ma <yuma@redhat.com>,
	gregkh@linuxfoundation.org, sashal@kernel.org
Subject: Re: [PATCH net-next v9 2/2] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
Message-ID: <aEmwYU/V/9/Ul04P@gmail.com>
References: <20250409-page-pool-track-dma-v9-0-6a9ef2e0cba8@redhat.com>
 <20250409-page-pool-track-dma-v9-2-6a9ef2e0cba8@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250409-page-pool-track-dma-v9-2-6a9ef2e0cba8@redhat.com>

Hello Toke,

On Wed, Apr 09, 2025 at 12:41:37PM +0200, Toke Høiland-Jørgensen wrote:
> Fixes: ff7d6b27f894 ("page_pool: refurbish version of page_pool code")

Do you have plan to backport this fix to LTS kernels? I am getting some
of these crashes on older kernel, and I am curious if there are plans to
backport this to LTS kernels.

--breno

