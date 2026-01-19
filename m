Return-Path: <bpf+bounces-79393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80342D39C1A
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 02:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25291300C0D1
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 01:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7193E288D2;
	Mon, 19 Jan 2026 01:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoUDXfYd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B569417AE11
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 01:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768787140; cv=none; b=EHaQ5fIDtC7+Xwp9gshRZQl6cNeXZq/vCd4daELioVGPw4XMUeG/Jf2Zp9I1ZcU0QorGcJe5lEkpZxMXEKZXmRhzuUsxd+RPqfHvkEfELz3iYQqVbsbobmrXjOppfUzoppccDaSRBoaNBhIEl5a1HW1fCiuUb26V0Uf/Q4rsTbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768787140; c=relaxed/simple;
	bh=7ZLTOzeksxEPo2l2v3dDm/2Abty3Gbxin0k2GNGZEeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ififUlyV3U8hpFJECVmDceXvgdgxcrI3sc2prwwmKkuoznrOiHAxmyKRAmP76sQmQw96jsRyNXWzbgELFUy9TNj8AFv0RX+BWhTvRRqqnD5Xnjm5Vi9bkIdu9Op4OyJP8lDP+eDF8anaNuRt2Hrws+vjLbBLXaH7Y2wFAe4hAo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IoUDXfYd; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-123320591a4so3567095c88.1
        for <bpf@vger.kernel.org>; Sun, 18 Jan 2026 17:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768787138; x=1769391938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aLNuYLeQh7kmecjdwrL3iJaysp/c6/WIw7e3NiVC8xs=;
        b=IoUDXfYdAJ24BvCs+j7zrAr0cYnUFJGwKihgNt1fuPQHpykI3AfeY5GUVxf8IaagRI
         eK1m2h7HYdeTZ7JCxpzy5cmEctL+Th1gRTP78I1seUivIwQbTG3ElndybC45NYtc+Whi
         +uqXP6zfjqaNl/M0e49u36zXU4OKWAVl0BOUyuzoiwaUg0vH6a8quEnHdujyxhIdRYKq
         ci0eu2dpw0AM/bdEPq9w7WfdBgQEBI1pJnbpDTOQokbpXryKqhqsOMWhhOmPk2gtCNOr
         p11Kzvx6gX1wvDC2PF53Kpum9KRv7lHFukRiZh+Lz8rRlqxWDAPKe4Mt6Rw9u6Rrk0HB
         qkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768787138; x=1769391938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLNuYLeQh7kmecjdwrL3iJaysp/c6/WIw7e3NiVC8xs=;
        b=XCV5ZPZmpvCrtAJXiKzyyrV9jvjBcqzVypN8emowqxB383s5Uc1e+NYDaKgAmfq3gK
         fd1xEDUIvBsA+d74z4VTZlic96S17qNNQezwFAK2VW8ZILJYH4maryDOuk4T1CYRzdPk
         1MVQcdtYGldo9aJNW/7F0KRD99PeQPG7k2Yg3d3zcrWo+9r1Wj3uyHvmpJYhviV4uaWG
         vBFOPzxOKhHjtQ/tbSzJl/HOGi4fFD7L465n31H7QzPZYnnXGXlfyOnZ4dORRwcDn0pS
         IUiwHvQNRp7lEwBzA7cgBJyqBoXI0tccW3rNhgVET1DDf/K9nb0AijasZYROGGg30DLj
         kQ3A==
X-Forwarded-Encrypted: i=1; AJvYcCUdpHIjfG6KWfFIuP1f0K9h3yRd/9l99K8pl9j3I5QaRIWQYDtUnnoYwwernmNMUbRsWWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwynMINiMkzsgw03zpjamzX2/tdtWNqHUQ07rCvxIfgjxEbzVBl
	XTkfOaf4/IahKHsE7HE+x83gt7ynJK6+yhzHBNyzbrbP5GweqtBUlB0=
X-Gm-Gg: AY/fxX7yhz7ZraMWK7/esrDjqjEuswg3QjQCwrjrgao/LyS4zt+qXbMmWDOKVhbbG4z
	OsXpCZ7UXS/EX3uxsn+OleZL9oabKy9gaAivy/G0wLusYNS0e9IvXw60z266Roxu9bjDm8c0X2P
	otdryU7LpXTGphWSRPY3B307lci+snkr5Tz3WvSNA9IpmqbpGm4mf6leQ7OMxU7TA5WNxowgeUI
	3lGJPzrwbsZFa8av9KrBNCkPApZrwiSd8YTnT0uw7NOjYVkrH/vyELuPK+dIvJkM23Jt/5WXJ5Y
	5JexdSgw6iPS2FlMSOJlkeFhmfyht6YyAXKXD3VdIvKPvbQpIOq06Kr9SpO/mbVQbR5+8i7tMNl
	Ni2iKpq8QLeraUb9WGyhrz0RZEruRxmjkkFlPXLGa1NdczMl1qx6cDy6GBIpKF7PuCRgqQQBGOO
	8OnO8SoyhZAr229bAaTHuRhxwZWlroFep1oneUYOA5JXfvb5xfo+HMbtMjQFKZ9yB1r8t9+m17L
	moTbw==
X-Received: by 2002:a05:7022:b98:b0:11a:273c:dd98 with SMTP id a92af1059eb24-1244a724cacmr7685802c88.20.1768787137840;
        Sun, 18 Jan 2026 17:45:37 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244aefa7c5sm14340229c88.10.2026.01.18.17.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 17:45:37 -0800 (PST)
Date: Sun, 18 Jan 2026 17:45:36 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v7 08/16] xsk: Proxy pool management for leased
 queues
Message-ID: <aW2MwPYcBosCvdg6@mini-arch>
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-9-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260115082603.219152-9-daniel@iogearbox.net>

On 01/15, Daniel Borkmann wrote:
> Similarly to the net_mp_{open,close}_rxq handling for leased queues, proxy
> the xsk_{reg,clear}_pool_at_qid via netif_get_rx_queue_lease_locked such
> that in case a virtual netdev picked a leased rxq, the request gets through
> to the real rxq in the physical netdev. The proxying is only relevant for
> queue_id < dev->real_num_rx_queues since right now its only supported for
> rxqs.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

