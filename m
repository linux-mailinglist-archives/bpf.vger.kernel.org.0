Return-Path: <bpf+bounces-71973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9666C03FA9
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 02:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52190189340D
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 00:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A087317332C;
	Fri, 24 Oct 2025 00:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tt0P0Ljs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24492D531;
	Fri, 24 Oct 2025 00:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761267083; cv=none; b=iv2dq3DDz+j7HAyGgZky/OJL5EHzGzp4JUJIHPrNQi96rO7z86HOJ8+FvfiDNeESjcw/gy0YQToGM7ghHuKECrRzPq2KY5a5UhCCMI6x2xRnLizG0lT9fPmx+9Sg/d5/naIl14iMOA8NNlMDZIQh8Ts247m03U8FtNtlTHflghc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761267083; c=relaxed/simple;
	bh=oPQyCu2DoTiorLQwblo0d65fpGXmOp1ueh4Tr5T66js=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ktoLCt1FPd4A0QtUqcgGCiQ7MC4yiFY+zLoo585r9dWe8+yZ83L5qp/SqKouHXOY2FbhiUnh2ItIAVmfiPQlAYMvXCcFhnHC05/d9sw6P9QQZqMoHafpD3i5izYzVEGV3BrySOI0vkl09MZd0XZNUrFB3gPe8mgW5cGQAC7IsBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tt0P0Ljs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AEBC4CEE7;
	Fri, 24 Oct 2025 00:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761267081;
	bh=oPQyCu2DoTiorLQwblo0d65fpGXmOp1ueh4Tr5T66js=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tt0P0LjsA781/aI5C+q4CpNgYO8lFV5QuMnRtEbZKTsaWPrXm+HgP49wYztjwqse4
	 xj6ZqQTuDE6f3VPLaj6QA1sk6127TXWiGs3s6w5tkhbFMOfB3kWu/kNQRie0YcPhOU
	 aWejPOWl+55gW8Rt56SPT6aAClVc6AoExa8bcadVOZVs6KAcKe9fG/s39dW1aDwWmn
	 0kSYq+6G6Djq+9Tt4V+pg7HbdX5Zp6xzhpId2rBnbd6AyIgdFFPFslwSg0LJ06eO4T
	 tGFqOw46EnuKUDfRy47EeyqmkPenM8SIvwJ7BA0hfEgMxlGt1xBUNM6+c3YKNjito0
	 fH2hHb2uOrT9g==
Date: Thu, 23 Oct 2025 17:51:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>,
 netdev@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next v2 01/15] net: Preserve metadata on
 pskb_expand_head
Message-ID: <20251023175119.62785270@kernel.org>
In-Reply-To: <20251019-skb-meta-rx-path-v2-1-f9a58f3eb6d6@cloudflare.com>
References: <20251019-skb-meta-rx-path-v2-0-f9a58f3eb6d6@cloudflare.com>
	<20251019-skb-meta-rx-path-v2-1-f9a58f3eb6d6@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 19 Oct 2025 14:45:25 +0200 Jakub Sitnicki wrote:
> pskb_expand_head() copies headroom, including skb metadata, into the newly
> allocated head, but then clears the metadata. As a result, metadata is lost
> when BPF helpers trigger an skb head reallocation.

True, then again if someone is reallocating headroom they may very well
push a header after, shifting metadata into an uninitialized part of
the headroom. Not sure we can do much about that, but perhaps worth
being more explicit in the commit msg?

