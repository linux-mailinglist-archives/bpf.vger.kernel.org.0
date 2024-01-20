Return-Path: <bpf+bounces-19966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 890A08333F2
	for <lists+bpf@lfdr.de>; Sat, 20 Jan 2024 12:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC0301C212AB
	for <lists+bpf@lfdr.de>; Sat, 20 Jan 2024 11:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5328DF57;
	Sat, 20 Jan 2024 11:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVPgGS25"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50646EAC0;
	Sat, 20 Jan 2024 11:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705751628; cv=none; b=BF/vXr1baSnneQv0YfzUAX7xUdXvmon4qO6jcgweh73xxed5+klA5EVdZlG7jzMa1XdY4ofYwrTRVBe0qBS/+8PrceyjiCf2D3GkSF7I8rVySJhxU3tASNIRFuj0G0ERko3Kl8MshhThZZy6aHVkoWS1KXsNppuYm0I6D7lZc4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705751628; c=relaxed/simple;
	bh=h67AGv+FNXNrQzYDfRzBnkw8TczwwZeIqb6H6msqznM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5y6QXAVqj12tGtvN8hmld82yruTfs1ngL+p/w/vllAaZZuzn2XlKVJMCrYOIafO7J+w89aCXu7tduJrJBkVX2rvyoLiRmm3XOcD3grVHp3c7mIC97FqyBk9WdMWUoT1PqYVKvskw22DsMdP85hiuGWl+yLNVWDjL9EMWud83qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVPgGS25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C92C433C7;
	Sat, 20 Jan 2024 11:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705751627;
	bh=h67AGv+FNXNrQzYDfRzBnkw8TczwwZeIqb6H6msqznM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AVPgGS25GVL4+3dPNg/aFvLs9imkvzIelHcrYqNbeoah2Yzwz5G+Q57Z4oXej/d/j
	 8F7Baf4BBHKV1qfplPfwWcYWXQKO/uB4h1RR9yzAua6y/Bo4x72L3VGudZhBohRrGC
	 XRUukhs234I0sxuHCh/ZTAyMbEcX9zOothgSHzAp4uoEyvkB0osOCv2dyOKHxQeadO
	 Ttk0f0K69HnTCHbDq7fLzzeCnHZ5qfTnxNBZhVq3YSD/+dGmY+18PSjdI7wH+fSlee
	 1MjbW64BslledfDFWccKPS35ppNw7qdLnOXYvhkHolEbRN0qZ8WYQqi5zLtKHaEFa6
	 j+TGmEA5iI9Aw==
Date: Sat, 20 Jan 2024 11:53:42 +0000
From: Simon Horman <horms@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next] xdp: Remove usage of the deprecated
 ida_simple_xx() API
Message-ID: <20240120115342.GD110624@kernel.org>
References: <8e889d18a6c881b09db4650d4b30a62d76f4fe77.1705734073.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e889d18a6c881b09db4650d4b30a62d76f4fe77.1705734073.git.christophe.jaillet@wanadoo.fr>

On Sat, Jan 20, 2024 at 08:02:20AM +0100, Christophe JAILLET wrote:
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> Note that the upper limit of ida_simple_get() is exclusive, but the one of
> ida_alloc_range() is inclusive. So a -1 has been added when needed.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

## Form letter - net-next-closed

[adapted from text by Jakub]

The merge window for v6.8 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens on or after 22nd January.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
--
pw-bot: defer

