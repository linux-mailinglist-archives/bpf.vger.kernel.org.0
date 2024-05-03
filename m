Return-Path: <bpf+bounces-28532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA47E8BB2A6
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 20:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D7E41F20C96
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 18:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6F3158A04;
	Fri,  3 May 2024 18:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="mSnyl94K"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33901586F6;
	Fri,  3 May 2024 18:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714760197; cv=none; b=RqROgZQK3MBc6honKWDUl+ZyBpBEBpKLj4+oQ2/+QUw1Hnq3VDfBUHngppB0SjcSKq5/F9C5ORXJuUoKCbZeka/oxhuX5z0KxSjQOE/mw2vodZtsg74ig16F+Iw3beoKQ2zI0RqD4y9E+a3SVi2MNqmmPvtI4LV6Bj2jkrY+uWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714760197; c=relaxed/simple;
	bh=YuRgDwOFHo66SVl5+SCvwWeWto7Qk5nbfcwDz1O6UBQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RFgglWxf/c0/osCP90AF93s04VZ3iQFQrx+isbSJ3onNEJ21WYR/fLNYuObn1SHZUZ6OvnTPXoq9RJkt43QO/hs7kyGj7mIbafEHxPDdvKwuuNcKUun9DL9lez1I6NwR1lBn+G2fF/5H61HHS0ViBM28gUc4NBRoyNklkACEHYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=mSnyl94K; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=sAFxnK7BGsBGg9HqpwUU0A8H/9W2t7LhGrsEhpnHuUQ=; b=mSnyl94KADVMX7fkEMtww0mrBT
	wXrY6eSlsHmS9awY7x6ft0WGungL98FL6lOQu/CzKSt/GTZfo8/S/SuIZtuiTgboRcnF1y7m3KojY
	sOzwWW3pMS9xIh8+Y6NyKwYXFoLlLCfYncsmOneEZ1OPKfSAXQ3YJ3yuRr4ir2jssl10monTaRnG+
	LjsyvvAdAdastKuqnoSiEgk934ttWKywRo5s0f8PrbXZsBqlP8E7V6aNJ86+L+VUrYrLvQEgO88vk
	inTmAyfF0MU8H3yZNZdnGUcJzOjHEh6Ed7nyexoHZtXbtqV1ylCisVHF79pbqqfsRiX4uocKU+Y9b
	OtCMb6vA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1s2xRp-0008TC-H3; Fri, 03 May 2024 20:16:31 +0200
Received: from [178.197.249.41] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1s2xSQ-000HZz-1q;
	Fri, 03 May 2024 20:16:30 +0200
Subject: Re: [PATCH stable, 6.1] net: sockmap, fix missing MSG_MORE causing
 TCP disruptions
To: John Fastabend <john.fastabend@gmail.com>, stable@vger.kernel.org
Cc: bpf@vger.kernel.org, dhowells@redhat.com
References: <20240503164805.59970-1-john.fastabend@gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a84489f5-3336-e60a-02ac-5da05db53162@iogearbox.net>
Date: Fri, 3 May 2024 20:16:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240503164805.59970-1-john.fastabend@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27264/Fri May  3 10:24:33 2024)

On 5/3/24 6:48 PM, John Fastabend wrote:
> [ Upstream commit ebf2e8860eea66e2c4764316b80c6a5ee5f336ee]
> [ Upstream commit f8dd95b29d7ef08c19ec9720564acf72243ddcf6]
> 
> In the first patch,
> 
> ebf2e8860eea ("tcp_bpf: Inline do_tcp_sendpages as it's now a wrapper around tcp_sendmsg")
> 
> This block of code is added to tcp_bpf_push(). The
> tcp_bpf_push is the code used by BPF to submit messages into the TCP
> stack.
> 
>   if (flags & MSG_SENDPAGE_NOTLAST)
>       msghdr.msg_flags | MSG_MORE;
> 
> In the second patch,
> 
> f8dd95b29d7e ("tcp_bpf, smc, tls, espintcp, siw: Reduce MSG_SENDPAGE_NOTLAST usage")
> 
> this logic was further changed to,
> 
>    if (flags & MSG_SENDPAGE_NOTLAST)
>       msghdr.msg_flags |= MSG_MORE
> 
> This was done as part of an improvement to use the sendmsg() callbacks
> and remove the sendpage usage inside the various sub systems.
> 
> However, these two patches together fixed a bug. The issue is without
> MSG_MORE set we will break a msg up into many smaller sends. In some
> case a lot because the operation loops over the scatter gather list.
> Without the MSG_MORE set (the current 6.1 case) we see stalls in data
> send/recv and sometimes applications failing to receive data. This
> generally is the result of an application that gives up after calling
> recv() or similar too many times. We introduce this because of how
> we incorrectly change the TCP send pattern.
> 
> Now that we have both 6.5 and 6.1 stable kernels deployed we've
> observed a series of issues related to this in real deployments. In 6.5
> kernels all the HTTP and other compliance tests pass and we are not
> observing any other issues. On 6.1 various compliance tests fail
> (nginx for example), but more importantly in these clusters without
> the flag set we observe stalled applications and increased retries in
> other applications. Openssl users where we have annotations to monitor
> retries and failures observed a significant increase in retries for
> example.
> 
> For the backport we isolated the fix to the two lines in the above
> patches that fixed the code. With this patch we deployed the workloads
> again and error rates and stalls went away and 6.1 stable kernels
> perform similar to 6.5 stable kernels. Similarly the compliance tests
> also passed.
> 
> Cc: <stable@vger.kernel.org> # 6.1.x
> Fixes: 604326b41a6fb ("tcp_bpf, smc, tls, espintcp, siw: Reduce MSG_SENDPAGE_NOTLAST usage")
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

