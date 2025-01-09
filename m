Return-Path: <bpf+bounces-48420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AD5A07ECB
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 18:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70B8C1643E9
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 17:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCFE18C91F;
	Thu,  9 Jan 2025 17:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ILDrE8nN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1917518CBF2
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 17:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736443934; cv=none; b=bXmj9TTFt+nigxF8JXs7m3tr+zIyq2Hmae/Lg+qaVCdR63qj71GuHaLFHzRfB11xC81TSXe9SwUGUJvsWUi5RwJufqmLP1vDTJTViBggx9hs1HK15YrlUp4hZALm+2doQ95a1c7r2ADO4/UrPj7Xm2SMTqx1Vqlg+EES8mIAMno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736443934; c=relaxed/simple;
	bh=RHcvY5vh/w5Qf1apu2pIUveQ5r1BQ1uATyGEk7bzDHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPSOrcSKYzQSY/FJ3+nNU0+BItT9i8a42wQuLmXIJ3uZRJdNnypAwhgSl5amIbYJJpdhbkq3Fao29TJ9YKW0t3bH+tweOYJpUq8056mgKNyNqx3zlC3VxOQsntLEAw7SrgSeOdDAODk0qGyGtpbv9PxygGHWCUQ5WK4uh9EHi0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ILDrE8nN; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2164b1f05caso19877945ad.3
        for <bpf@vger.kernel.org>; Thu, 09 Jan 2025 09:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736443932; x=1737048732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2UNh3XSymBqQsn+VyrNiirXx9s/ikn0z5oyEbF5eRfg=;
        b=ILDrE8nNC0esu8HcD/pSJw/nIlQpS6AXjll9w4mZlCNtts4jdrMyPNp6sKHg+GQyc5
         dZfqEntRltSjM+4wzaZyfhf+8mJSl+U4hIzhiY2iGlErO/vf7oWaVAVVhMZE/dqbiO0T
         5ZVMkGQtujwtArCyuR0JgKSuC8MnS6ynW+Ei8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736443932; x=1737048732;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2UNh3XSymBqQsn+VyrNiirXx9s/ikn0z5oyEbF5eRfg=;
        b=F7yasuSpu9YKeSsHhaCGIKdOMZmOX1E9e5U0Uba28dQn9FA1vL9jAgpL9gqdRoG3qn
         rHuofvonbA3GefOuLdvewl4yxzpAJzAZxX9uQBUu6UaSQc+qszqrxEiILEefaJ14rgnt
         DN7vpM33LI1KmvTSI0J7txLhMjTT/nDthW+i54CT0xyB12ywXRi1ovGZ8t2C9E5j61iM
         HIG4HlCbBwSKv4K5so608qHIAifdEOW0tqZNHe1Yma3mnADT84+8/UpL2/hHXepxYDEl
         AmZ/OsH5rg7fPmvw+9ZHzvwdonIv0M6t0EjhfVc9JoOYaUOa3Gxes8lJ6L/YpNgIz+Pw
         9gVA==
X-Forwarded-Encrypted: i=1; AJvYcCWc++r70tSlWOWS7G+TLEZmEM++ZVnFcdGr2FteG4BP2j7JMWkvfp2RnIVPKAJcao1GLWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJsBMiniK/+i40pDyWYZv/QZHKz/zGrHVoSoWwSx2JiRakW7sv
	Kg5fqDPFvLDs4GRRodGl3cfcb50Ki3y1/jdBlM11vQlIzKQ5zqXuDQdnm8rN+UM=
X-Gm-Gg: ASbGncvLJe1QaJ0znCF2oIW3bz05CD2gX32cDF9DHl8Fl0921ALGZkPeWZTv9NoPSu4
	cbLqesfJcbuU3GZNhwcmzYF0q61xs/3SM9FxBoIbGDYalxI8XnjBhusiudyCdg/Dx6Ylmto3lHf
	u0OZ7heFhQLiDwxDXbym8DGT3EtZskVOHMxxR0SqEnIQ6+4vN58NGX1Mf6n5DhuC4w4xLECkwgT
	CKFJzlwA0toIJsXGWoDmIlkVhZtr4X0y3g/25sxwEkurg8ezvKgTEU/VIknQEbwV5vY/siJdcyg
	q28MuClp+DkDAZ9E/yAVcDA=
X-Google-Smtp-Source: AGHT+IG7/4G/oFkDNNnhgkJMtk6EtVQoD1RUklEhY7FF8vplHNOXWAQR/POf4R2MiUbUDfOIGJjYtA==
X-Received: by 2002:a17:902:f706:b0:216:69ca:773b with SMTP id d9443c01a7336-21a83f4b2bfmr119702625ad.5.1736443932488;
        Thu, 09 Jan 2025 09:32:12 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f21a7f1sm476895ad.124.2025.01.09.09.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 09:32:12 -0800 (PST)
Date: Thu, 9 Jan 2025 09:32:09 -0800
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, horms@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	mkarsten@uwaterloo.ca, alazar@nvidia.com
Subject: Re: [PATCH net] xsk: Bring back busy polling support
Message-ID: <Z4AIGWGVrEfk1yvE@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, horms@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	mkarsten@uwaterloo.ca, alazar@nvidia.com
References: <20250109003436.2829560-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109003436.2829560-1-sdf@fomichev.me>

On Wed, Jan 08, 2025 at 04:34:36PM -0800, Stanislav Fomichev wrote:
> Commit 86e25f40aa1e ("net: napi: Add napi_config") moved napi->napi_id
> assignment to a later point in time (napi_hash_add_with_id). This breaks
> __xdp_rxq_info_reg which copies napi_id at an earlier time and now
> stores 0 napi_id. It also makes sk_mark_napi_id_once_xdp and
> __sk_mark_napi_id_once useless because they now work against 0 napi_id.
> Since sk_busy_loop requires valid napi_id to busy-poll on, there is no way
> to busy-poll AF_XDP sockets anymore.
> 
> Bring back the ability to busy-poll on XSK by resolving socket's napi_id
> at bind time. This relies on relatively recent netif_queue_set_napi,
> but (assume) at this point most popular drivers should have been converted.
> This also removes per-tx/rx cycles which used to check and/or set
> the napi_id value.
> 
> Confirmed by running a busy-polling AF_XDP socket
> (github.com/fomichev/xskrtt) on mlx5 and looking at BusyPollRxPackets
> from /proc/net/netstat.

Thanks Stanislav for finding and fixing this.

I've CC'd Alex who reported a bug a couple weeks ago that might be
fixed by this change.

Alex: would you mind applying this patch to your tree to see if this
solves the issue you reported [1] ?

[1]: https://lore.kernel.org/netdev/DM8PR12MB5447837576EA58F490D6D4BFAD052@DM8PR12MB5447.namprd12.prod.outlook.com/

