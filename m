Return-Path: <bpf+bounces-27978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C77948B40BE
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 22:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C3A328381D
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 20:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CA022EF8;
	Fri, 26 Apr 2024 20:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Wp0H7bO/"
X-Original-To: bpf@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0160208AF;
	Fri, 26 Apr 2024 20:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714162753; cv=none; b=T1LO8f9bFLiTB5bdQRBkQa18+uiUvLTnMN+mMNWQsvK1y9fVOWRzD3WfRbP6+STcMvWHGOVVDi6VKD/LAlQN0Xm8kD3KXW2qyU20hcPy8a9kOnOSFNrBwi6T1+RSEJNSW/ZjvtCo9WfinagS6vZKEdQ206FppzRWP+W41xO8X/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714162753; c=relaxed/simple;
	bh=6VdUJV20l4I0zrwsUBPpqBuj20IIVfh/k/cJj3StQ00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RH6NV9wR2h1k6SQc/lf9iEP8+Gy/aCq5F+EOjrmmDv10oTFMhWwwwpyqqtQBE6e7chgcMwBZh/Mted3N5ySwJlBQDPJPsgyLNng6GbMO3VWtG+h25oOiwvlVz9DRiglFOx9kHlmTSr76Xg1WZ4k0Q/AdqVIy3kGQ0F/7M7jfZec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Wp0H7bO/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=N90b3/SSxbLK/a2YSgJGW777fnEwBjaan+amMbxn+pM=; b=Wp0H7bO/DEtI8f43tFDIxMMax3
	wXthZokbrCCYVe2Sgom7cGaHFGTpfFDIDiWNvs3QsrRbJHyVuiHUrFHymToW3eIuRpGYJkX41SULU
	SDxRUHfroNxbfysEJqySWQvmh51CG3yEBG5qy+OZktOG4FETduammudLfKTJ4+WL2rN7+yvQlhcB0
	XIXHk/VcBXihUdNnvc5ZSLChwK24CV0gE12Ckbwu595jh3YW6KxEsi4y5I39QtpG/D/6tsEcUJLIB
	OVkcWkEIXxUEzy1nPSy1SFxBYoGqASVywCyIYq6F4mPvY7jrIG1o9CQ7MsbivSljLnP1HRbtscsPS
	d7NSruqg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s0S2A-005PJi-1D;
	Fri, 26 Apr 2024 20:19:02 +0000
Date: Fri, 26 Apr 2024 21:19:02 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, davem@davemloft.net,
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] tcp_bbr: replace lambda expression with bitwise
 operation for bit flip
Message-ID: <20240426201902.GQ2118490@ZenIV>
References: <20240426152011.37069-1-richard120310@gmail.com>
 <CANn89iKenW5SxMGm753z8eawg+7drUz7oZcTR06habjcFmdqVg@mail.gmail.com>
 <Zivd4agQ8D6rUKvt@vaxr-BM6660-BM6360>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zivd4agQ8D6rUKvt@vaxr-BM6660-BM6360>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Apr 27, 2024 at 01:01:21AM +0800, I Hsin Cheng wrote:

> I see, thanks for your explanation.
> I thought the compilers behavior might alters due to different 
> architecture or different compilers.
> So would you recommend on the proposed changes or we should stick to
>  the original implementation? 
> Personally I think my version or your proposed change are both more 
> understandable and elegant than the lambda expression.

Out of curiosity, where do you see any lambda expressions in the entire
thing?

