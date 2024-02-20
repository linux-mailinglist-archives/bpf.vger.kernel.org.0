Return-Path: <bpf+bounces-22293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4D485B6B1
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 10:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13835B23FA3
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 09:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B265FBA3;
	Tue, 20 Feb 2024 09:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="En/wnu1E"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267685F875;
	Tue, 20 Feb 2024 09:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419982; cv=none; b=kLx8wo79RSoC4KYQnB48OsNLY5C8Gr2jpOd+BiQzQGuRFuiHTV7EQFGyoY+gIAb13FW0lw8nxtyR2HV4iVFZpVL5iFDPzMPk2NV72TtLypkYtSs1DPb45omvAJRXou4aUbv+ML3HuRiw8vd9L1z72H4ApmS8TwFV+zS0gm49gxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419982; c=relaxed/simple;
	bh=6RnZV5JaPVcvJu5WhPrNW8qv/DVeUebkVpf0WfFjPZc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=CdNOtSRbPZtTtBZxeb3khLd4RVVt2ZXx6NbOCAA6OuRXKjfpDDccr75W4fqlWKDom+F05OLzUf/oC+geYQHHHgJSu5MA6rRaZR1ozewrZdwCChesupp8IIEpWOFfD3LKMnF8Ea5UPBGYckSn5XjOaVkEATlzbfoDaxpkIEFb6qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=En/wnu1E; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=BDptlSaoFR1fqvCYKlpZfXslbyaszT1ArL8Ho3h3hDI=; b=En/wnu1E5tTjj2E4ZZyoio/MMu
	8poq1UCP0DJ1QoxF/KlY16tr9/NWCp4bjwp5mdCiaCGon00X244x6rRiCOv4Il9W5yuB0BJY/XqxL
	j24YlQva09DhSJQwLzT57rkSthUF7ChC151yO5o4uCJlL7Z74ZIs4GomUjlIh6wvnW9NSDxWqp+0R
	Z3gY+zqJ/ScPSqkdV2Mp6Z6P3xsW9zt3jgEZBw2fyyAzlsDr4rshzYXYYv6b8OwXZOyrMus9KTLlJ
	jiB9oDO3s4lqKvq4NSi/NbLtmMeeP4+ve2hCRWWlxrxMpmWKWa/xvZfyxAKmOJpMDoOF1YNBvpar9
	W0jFf4KQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rcM4i-000LM1-GF; Tue, 20 Feb 2024 10:06:04 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rcM4h-000JQr-Be; Tue, 20 Feb 2024 10:06:03 +0100
Subject: Re: [PATCH net-next 2/3] bpf: test_run: Use system page pool for XDP
 live frame mode
To: =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20240215132634.474055-1-toke@redhat.com>
 <20240215132634.474055-3-toke@redhat.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <59c022bf-4cc4-850f-f8ab-3b8aab36f958@iogearbox.net>
Date: Tue, 20 Feb 2024 10:06:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240215132634.474055-3-toke@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27190/Mon Feb 19 10:24:27 2024)

On 2/15/24 2:26 PM, Toke Høiland-Jørgensen wrote:
> The BPF_TEST_RUN code in XDP live frame mode creates a new page pool
> each time it is called and uses that to allocate the frames used for the
> XDP run. This works well if the syscall is used with a high repetitions
> number, as it allows for efficient page recycling. However, if used with
> a small number of repetitions, the overhead of creating and tearing down
> the page pool is significant, and can even lead to system stalls if the
> syscall is called in a tight loop.
> 
> Now that we have a persistent system page pool instance, it becomes
> pretty straight forward to change the test_run code to use it. The only
> wrinkle is that we can no longer rely on a custom page init callback
> from page_pool itself; instead, we change the test_run code to write a
> random cookie value to the beginning of the page as an indicator that
> the page has been initialised and can be re-used without copying the
> initial data again.
> 
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>

[...]
> -
>   	/* We create a 'fake' RXQ referencing the original dev, but with an
>   	 * xdp_mem_info pointing to our page_pool
>   	 */
>   	xdp_rxq_info_reg(&xdp->rxq, orig_ctx->rxq->dev, 0, 0);
> -	xdp->rxq.mem.type = MEM_TYPE_PAGE_POOL;
> -	xdp->rxq.mem.id = pp->xdp_mem_id;
> +	xdp->rxq.mem.type = MEM_TYPE_PAGE_POOL; /* mem id is set per-frame below */
>   	xdp->dev = orig_ctx->rxq->dev;
>   	xdp->orig_ctx = orig_ctx;
>   
> +	/* We need a random cookie for each run as pages can stick around
> +	 * between runs in the system page pool
> +	 */
> +	get_random_bytes(&xdp->cookie, sizeof(xdp->cookie));
> +

So the assumption is that there is only a tiny chance of collisions with
users outside of xdp test_run. If they do collide however, you'd leak data.
Presumably the 64 bit cookie might suffice.. nit, perhaps makes sense to
explicitly exclude zero cookie?

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

Thanks,
Daniel

