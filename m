Return-Path: <bpf+bounces-22294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BAF85B6BB
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 10:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CB831F21B1E
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 09:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649A86026A;
	Tue, 20 Feb 2024 09:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="GkFzu5YG"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26AE633F3;
	Tue, 20 Feb 2024 09:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420008; cv=none; b=fsUCk6U+7unox/l4LzF3MDn7gSfxrPrBJhK7ofHwaQc0SR6LgsF07veB35YS8Bq6QZFic+qzbWGvHw2S2/colZ8K81xAltcV5JzRhcOKKNXq/Ac/YlHNMEgMeSJdPyHnmIOTBwFK9XGuR0XYwbWMvTz9oM/x7ILr8QXqKP8oi8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420008; c=relaxed/simple;
	bh=cvhXSUZzYtAquyy7IVqv19DJhQ95zlRptthqpZ19eXU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pPXlpT0A+ReXEJpA4slx22horAXemEyAog85KxsVizlhgpooLwGyBVuyJXJX9a0NRYhqBOLYJEV+6Qj0d5GXDawzXeH0YbZonjk4VcLMOHPZel2Bmp61WNMzDBIqGBBAxU2i4RAjvVfSjhcp9eUTZWovPdLE723592TIHMU7AJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=GkFzu5YG; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=y8XdzEEuGgjqwZiE3EjP2jTZ4oyvCpo6Ky1hbRKKRsI=; b=GkFzu5YG5jr/cmOSwDIzO2J4g7
	siKQ9HsaxhWxSVPfyz9s0/9TW36RIAxP+TwGoW1iZve1fJG+dVJr+DEFcoe9Srrh30/q5dDTAwwOk
	o8+Dvf67KKJozTmmU6H0VsucI6lx5c6cHoyaGxWXYQ8lRVZoM2m3gBYZs+bNn3O5mVZHo7BVEBBE2
	uG/fvXDQCBqRC3wqpDoS2GJl8u3B3Qp3+CFKYMtUcS3UC+xdTRruqCuWgokQV4MIsbkjffig7fjIx
	vXzgK8qWc426NvCIbQ29vE2WmbN4gxOgJyPi1tvwXhuuDwrrjn5ddyO6abdILIRdsOYIze7jqi0DA
	yiP2ZCtA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rcM5B-000LSG-St; Tue, 20 Feb 2024 10:06:33 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rcM5A-000MBB-NU; Tue, 20 Feb 2024 10:06:32 +0100
Subject: Re: [PATCH net-next 3/3] bpf: test_run: Fix cacheline alignment of
 live XDP frame data structures
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
 <20240215132634.474055-4-toke@redhat.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <e64a5c7b-4de3-761c-ec21-7e09a43ac440@iogearbox.net>
Date: Tue, 20 Feb 2024 10:06:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240215132634.474055-4-toke@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27190/Mon Feb 19 10:24:27 2024)

On 2/15/24 2:26 PM, Toke Høiland-Jørgensen wrote:
> The live XDP frame code in BPF_PROG_RUN suffered from suboptimal cache
> line placement due to the forced cache line alignment of struct
> xdp_rxq_info. Rearrange things so we don't waste a whole cache line on
> padding, and also add explicit alignment to the data_hard_start field in
> the start-of-page data structure we use for the data pages.
> 
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>

Acked-by: Daniel Borkmann <daniel@iogearbox.net>


