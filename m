Return-Path: <bpf+bounces-29743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BD38C61B4
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 09:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F067E1F21BDA
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 07:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64EC43ABE;
	Wed, 15 May 2024 07:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xh2faG3h"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5895441C84;
	Wed, 15 May 2024 07:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715758228; cv=none; b=TedT4SAywu6mWbOPmp/mnOGg4SMuAFQiSkvyNHbh3lGh/56eLY7q9X64LY4A4zQgfA6pc2LNwv0+5ptR/KniQzKkD+xqkozwDNEOQXPxfZCwiyGWSYyY5+d2CZECGilLcL9Nzp1LTBD6Y1hZMPzzJ6YRKL9nyE75HiSHJmz8tTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715758228; c=relaxed/simple;
	bh=4Sw9r9IaQ9piAZf8eAgQ6uBiXEBgKY9ym1El13VaNBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCEQh+FsFEpj6FNtzoYCPYyvZBEJugPUTbl1WOwTayt/exXcfQKJxaHY4/VFJufg3ysN86lRxTZEwB5VTthsYxLvSfWiRaPBZLhuCnaV2DRJtiAD1dmvzECGPTsnp4TxCc91WvEYrQunBpTNaEte7iJdSeBOiVUTtzvv/Ei/O0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xh2faG3h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC34C116B1;
	Wed, 15 May 2024 07:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715758227;
	bh=4Sw9r9IaQ9piAZf8eAgQ6uBiXEBgKY9ym1El13VaNBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xh2faG3hif2o2CkZgGE0bUsJZhPPLYPG1uMYMaVG9Xer+dLmqEYU7KbEIhhGRAi/K
	 3cM7jqkEWObOoEq49CxC8iJs6x7PtOYbNihROG/0Y98cZJMOMdyH06B0aennauQ0G9
	 RgLIQf8HtCOxLsvWQA+wAJlVLjxirXr7Hb2lvk3M=
Date: Wed, 15 May 2024 09:30:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: John Fastabend <john.fastabend@gmail.com>
Cc: stable@vger.kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
	dhowells@redhat.com, kuba@kernel.org
Subject: Re: [PATCH stable, 6.1 1/2] tcp_bpf: Inline do_tcp_sendpages as it's
 now a wrapper around tcp_sendmsg
Message-ID: <2024051500-underage-unfixed-5d28@gregkh>
References: <20240507174757.260478-1-john.fastabend@gmail.com>
 <20240507174757.260478-2-john.fastabend@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507174757.260478-2-john.fastabend@gmail.com>

On Tue, May 07, 2024 at 10:47:56AM -0700, John Fastabend wrote:
> From: David Howells <dhowells@redhat.com>
> 
> [ Upstream commit ebf2e8860eea66e2c4764316b80c6a5ee5f336ee ]
> 
> do_tcp_sendpages() is now just a small wrapper around tcp_sendmsg_locked(),
> so inline it.  This is part of replacing ->sendpage() with a call to
> sendmsg() with MSG_SPLICE_PAGES set.
> 
> Fixes: 04919bed948dc ("tcp: Introduce tcp_read_skb()")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: John Fastabend <john.fastabend@gmail.com>
> cc: Jakub Sitnicki <jakub@cloudflare.com>
> cc: David Ahern <dsahern@kernel.org>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/ipv4/tcp_bpf.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)

You too need to sign off on a patch you forward to someone else, that's
what the DCO means :)

Please fix up and resend.

thanks,

greg k-h

