Return-Path: <bpf+bounces-50472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43101A2817D
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 02:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A78B93A8138
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 01:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEB020E316;
	Wed,  5 Feb 2025 01:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iep4/hb5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E391525A647;
	Wed,  5 Feb 2025 01:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738720667; cv=none; b=eCTCcHtX3Bz2gNffrUPdzGaTnSB7icHkheg7EL8oAbz/tPOcvcI8SCoGhax9gl4uNcW5kzWb1rHeKJKM9dDO6Fk6YiEBzNaiauLH9eG+0bLFTGKx4ZQ2whIUBftJxDY2khIAvh3T7PyYtaWPXQs9TJzxR0Osx3F5igFjSvGoD8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738720667; c=relaxed/simple;
	bh=NCHRxNFaax6UpmkiT79K6Z728htXf+Duy37o3WreZZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FMZ5A3uJ9k87MzXMq4MD2Dxl6OxQIcRpMgAtNkGB2EBg5QhgUaDmINH5X1A4DHhBXzAgBlAxtCcGRpmF03M5uGjab4Xre31gzQb0Zjc+Tlu5V1bkDQb9SvnI8Vpg7LX6VA+6O37pIbPbmMxMURYrhTtGQN0ubjYOW3J28sXO+y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iep4/hb5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409C8C4CEE4;
	Wed,  5 Feb 2025 01:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738720666;
	bh=NCHRxNFaax6UpmkiT79K6Z728htXf+Duy37o3WreZZ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iep4/hb5amqN6IYzEsEnLNr7ftbQ5oBIETopmxqwmozkx5eBVoryFnMfaR47Q/wdJ
	 j3/9Ce/qe6F6XSMSexmYgR23T8/4RgvpAV++3o1596VaYxztstkM90fKgDYdxJ3Ph9
	 UTiDoTFDoGvMwQjo6NfEtPD8669ti0H0JuEEazWc+Gey9Swk81dqnrkcDDbCztmVT0
	 JnAsC3IM+jJ939FEjaYrNC45i7O6psUN1Gr6y6jdFay9NtbLu7T1m0KvdH4yDygOLR
	 nY29h56AnZQb9YsyvYYskdrv4CYIXIvGvYQRxr1wx8B/Ijs6AKf+bN/JGUZ5dTkuWD
	 W7Ug2fYYVj/ig==
Date: Tue, 4 Feb 2025 17:57:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 dsahern@kernel.org, willemdebruijn.kernel@gmail.com, willemb@google.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, horms@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v8 10/12] bpf: make TCP tx timestamp bpf
 extension work
Message-ID: <20250204175744.3f92c33e@kernel.org>
In-Reply-To: <20250204183024.87508-11-kerneljasonxing@gmail.com>
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
	<20250204183024.87508-11-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Feb 2025 02:30:22 +0800 Jason Xing wrote:
> +	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
> +	    SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING) && skb) {
> +		struct skb_shared_info *shinfo = skb_shinfo(skb);
> +		struct tcp_skb_cb *tcb = TCP_SKB_CB(skb);
> +
> +		tcb->txstamp_ack_bpf = 1;
> +		shinfo->tx_flags |= SKBTX_BPF;
> +		shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
> +	}

If BPF program is attached we'll timestamp all skbs? Am I reading this
right?

Wouldn't it be better to let BPF_SOCK_OPS_TS_SND_CB return whether it's
interested in tracing current packet all the way thru the stack?

