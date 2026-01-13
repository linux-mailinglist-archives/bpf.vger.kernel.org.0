Return-Path: <bpf+bounces-78656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 756BBD1690E
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 04:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 668F3302EA1C
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 03:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E62730AABC;
	Tue, 13 Jan 2026 03:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arMfPHWA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2336D308F3D;
	Tue, 13 Jan 2026 03:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768276439; cv=none; b=IKl6+EKgUl3+SdJ2S5tWZSSEWezd133PwhFUlq5AW9mIk0mn5p0PE0qELxOpOuQnpra17B/Sk8zhnRjczjYH4ytsOQSpYcYt3V17goIvkbITMoWfkrNmpw0MUjsLLvtfH6nrKIJ/ETi9jtPDVvzHOZ2zCGxcquoAI5VBRuBAim4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768276439; c=relaxed/simple;
	bh=BW7uKjiVxwuHSxcWF5TrcbXInN61SNCbm7vJWu9mXzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ok9EeAsna52mwJs/LJt/T45T4VLTdjmt1dmAXjK+KRHSYVk0D3kXbsClql+6hwjOZdF8dQDzzo/XReMxcXdbUIo9LK9w6CvW4wYyzw7IeVv2NV70CuPS6dEFOICzcJZdSqr7c/5RJPX0GZbHsl4v+xKcCkWyKbKSCeLXPpTFvWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arMfPHWA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D82C116C6;
	Tue, 13 Jan 2026 03:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768276438;
	bh=BW7uKjiVxwuHSxcWF5TrcbXInN61SNCbm7vJWu9mXzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=arMfPHWA88eGaBqamCOBG1nAl5oSJsIOD56uaWS7mmB5walVIyCPUvUzOC1O/evsW
	 sGHXosq9+CxDg6xeozDdMikQ9g0Y8FATvz9uVGjfSFiAWhlSCuW/dMpSzq7NM+0LKb
	 BzT+5N/8v85WYsbuLfuW8xQ8z2l/v94w8iYAosNw2x48sFDKpNTKpDdYwJ3tkJHZg0
	 qNF/MzGd1C6hf4WrIIxaKCKqVYttM5SETw1gEf1QpL/IJoIXjOz47Nt6nksSkuS9NQ
	 PRdCtGy2+SWiTpBYYn1Gz2NZXGrdNKV1zGjo/OObZ52xU7kdEocaKSp0acSQ0/3zdg
	 C+MBMZNuY8vlQ==
From: Jakub Kicinski <kuba@kernel.org>
To: daniel@iogearbox.net
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	jordan@jrife.io,
	maciej.fijalkowski@intel.com,
	willemb@google.com,
	yangzhenze@bytedance.com,
	razor@blackwall.org,
	dw@davidwei.uk,
	pabeni@redhat.com,
	sdf@fomichev.me,
	wangdongdong.6@bytedance.com,
	john.fastabend@gmail.com,
	martin.lau@kernel.org,
	magnus.karlsson@intel.com,
	toke@redhat.com,
	davem@davemloft.net
Subject: Re: [net-next,v5,03/16] net: Add lease info to queue-get response
Date: Mon, 12 Jan 2026 19:53:53 -0800
Message-ID: <20260113035353.405418-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109212632.146920-4-daniel@iogearbox.net>
References: <20260109212632.146920-4-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least pausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
    net: Add lease info to queue-get response

This commit populates nested lease info in the queue-get response, returning
the ifindex, queue id with type, and optionally the netns id if the device
resides in a different network namespace.

> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index cd4dc4eef029..002d68f62131 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c

[ ... ]

> @@ -410,6 +413,37 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
>  		if (nla_put_napi_id(rsp, rxq->napi))
>  			goto nla_put_failure;
>
> +		if (netif_rx_queue_lease_get_owner(&netdev, &lease_q_idx)) {
> +			struct net *net, *peer_net;
> +
> +			nest_lease = nla_nest_start(rsp, NETDEV_A_QUEUE_LEASE);
> +			if (!nest_lease)
> +				goto nla_put_failure;
> +			nest_queue = nla_nest_start(rsp, NETDEV_A_LEASE_QUEUE);
> +			if (!nest_lease)
                            ^^^^^^^^^^

Should this check nest_queue instead of nest_lease? The assignment is to
nest_queue but the check is on nest_lease. If nla_nest_start() fails for
NETDEV_A_LEASE_QUEUE and returns NULL, the check passes because nest_lease
is non-NULL from the previous successful call. This would lead to
nla_nest_end(rsp, nest_queue) being called with a NULL pointer, causing a
NULL pointer dereference when accessing start->nla_len.

> +				goto nla_put_failure;

[ ... ]
-- 
pw-bot: cr

