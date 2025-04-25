Return-Path: <bpf+bounces-56654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BB7A9BBDE
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 02:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C4BA4C280E
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 00:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C83C7483;
	Fri, 25 Apr 2025 00:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvNLdt9F"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43C31D555;
	Fri, 25 Apr 2025 00:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745540948; cv=none; b=tlXc3yj0Y4lu9uxr4YzFgAGgJvLpfYI15klDWfkYZJvQ59dCWVHscc8A/5gY5GqM1Zq75N9AjEf+OHpZt0lLfx6C/ty+yC63Imjg0eNANxtwY08ebCnk9MQiJmO/BlCrgiB3NwU2zQ/sw7uyySnmsvz1P8G5lZ8miltz6eJ0m+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745540948; c=relaxed/simple;
	bh=ugYHviq2GMOQ1AcvdkeyhC+Q2tttWJ+KSq0ZZKyk5hs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N9cksErsYXxIIAbKEh0SrGFNT32lvExi7LjA51TbZNS2TzQ5qPGKe8Rr0uv//AuZbWtQq2gzcDkXy03E6wqh6j12gfIQJ/h3oL9i/7G57syOI8HOyzlRC6+PnNRJBSHv6/Ch3RV3qlN4YJ2agnuitVTsV09f48wf5dbelxhhV2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvNLdt9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA6FC4CEE3;
	Fri, 25 Apr 2025 00:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745540947;
	bh=ugYHviq2GMOQ1AcvdkeyhC+Q2tttWJ+KSq0ZZKyk5hs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EvNLdt9FcbkwjBGBrOGYEbC/UDjCPMFoc6dEsDriUFcZy1TIcyRIO8mj4G513z5DU
	 JVgztTDJtRJAC7PQ5Tu2mtz0cGeWFzLnoJ9/rHjT0NzpdTUdmEDvL/YJpYXPkQ0RGL
	 5lt9js14mDKCN+7q26in1fMXVUwUf59dgFyjZuwfelKMXfMokKfW1jqaU+liL5M7Lv
	 4h6t0A6LLNi0yTHgQRNhH+wor7VkkN5e65zA5rc/Gs/qxily3xvOXKVZLWB+ThHyEe
	 rxfK27D/N5LWub0fZFAkmphfamx5PTnGnQQv5efXi6YlFemKDPGWEfSi0cY/EUYA75
	 xYUiD1oWTeqzA==
Date: Thu, 24 Apr 2025 17:29:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] xsk: respect the offsets when copying frags
Message-ID: <20250424172905.181af8be@kernel.org>
In-Reply-To: <20250423101047.31402-1-minhquangbui99@gmail.com>
References: <20250423101047.31402-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 17:10:47 +0700 Bui Quang Minh wrote:
> Add the missing offsets when copying frags in xdp_copy_frags_from_zc().
> 
> Fixes: 560d958c6c68 ("xsk: add generic XSk &xdp_buff -> skb conversion")
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>

I think the fix is right but I dislike the use of netmem here :(
Could we switch back to page_pool_dev_alloc() ?
Allocating a netmem to immediately call __netmem_address() is strange.
At least to me. Because netmem is supposed to be potentially unreadable.
And using normal page allocation will avoid the confusion and bug we're
dealing with now.

As Stanislav pointed out this function is not used anywhere today,
so let's target the rewrite to net-next and explain in the commit 
message where the bug comes from and why it doesn't need to be
backported (and drop the Fixes tag)?

