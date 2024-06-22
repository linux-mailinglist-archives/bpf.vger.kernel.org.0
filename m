Return-Path: <bpf+bounces-32791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E98913186
	for <lists+bpf@lfdr.de>; Sat, 22 Jun 2024 04:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5904CB23923
	for <lists+bpf@lfdr.de>; Sat, 22 Jun 2024 02:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6086FD3;
	Sat, 22 Jun 2024 02:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzjDPZqP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388773D72;
	Sat, 22 Jun 2024 02:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719022123; cv=none; b=ETjVDouIxvtIDKbkslvm9AyQwk1FhTIdt6NYV/0txO13viFY2yHLiuIm9dq7TbVV7weK66YYj1H4L7kIWG+8/lXwNS3c5azcqoyCEmRGZZ7O8Vcla42z4ybEuxMl9uCP5Zp5H4gKrYIq55tcd09YKJmT7u7RAP/jLfK6DBKgoXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719022123; c=relaxed/simple;
	bh=r7OYybDxPi3mY0P6pNIwWR6FEcC6soMGwyUETbsHeHg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bysBeXM/Mx7wDkG80iasxpO4grIHhnOZaIqSEa45cBWBduczbYOxDUi+w9LczaIhhwpjo5cIkg3FdA6LB8WmIuFF/yRUcxEPsd/R0TLxN+7nNYbJLPpdAs1ifseNvh2RGgkXPx+jOW1Gumw+3WMZmt5pPoyU8Wpcu3G/NzRXEzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzjDPZqP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7397C2BBFC;
	Sat, 22 Jun 2024 02:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719022122;
	bh=r7OYybDxPi3mY0P6pNIwWR6FEcC6soMGwyUETbsHeHg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MzjDPZqPafkfvLMEpwicO1BHXS2+g65ZMTgiXSGtFGT8lfmSlNeREeVbhgFMF7r9Y
	 Et50Hd7Rznx2wdyUgWd8/hvmGlZNgSprNLiSbTaSTMTfXu/3xAJkSJxFPd/o+HzQ4+
	 QnrNOV8tQl52PwS3g3v15wWC8A0Tv+ftIYmSj1beCzcjRIdh94YelPPQSbsBeAjRQR
	 rgavnSaxAPxHgteexCKQo5dWPEpFQKRjZx3BUFUBSdEgz7khnqhojoKz8p5XcAo/KJ
	 jIvbeB8+4HXf7sqC781dyAPXd3/p4K/kS2XoXW8JI6cVB4mgTLPfwUQRIVvDgwguLK
	 KXeZRVDZKbn9w==
Date: Fri, 21 Jun 2024 19:08:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Daniel Bristot de Oliveira <bristot@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Eric Dumazet <edumazet@google.com>, Frederic Weisbecker
 <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, Paolo Abeni
 <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Waiman Long <longman@redhat.com>, Will Deacon
 <will@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Hao Luo
 <haoluo@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Stanislav Fomichev <sdf@google.com>, Toke
 =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>, Yonghong Song
 <yonghong.song@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH v9 net-next 14/15] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
Message-ID: <20240621190840.4da4b775@kernel.org>
In-Reply-To: <20240620132727.660738-15-bigeasy@linutronix.de>
References: <20240620132727.660738-1-bigeasy@linutronix.de>
	<20240620132727.660738-15-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jun 2024 15:22:04 +0200 Sebastian Andrzej Siewior wrote:
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 99076dbe27d83..f314bdd7e6108 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2355,6 +2355,7 @@ __latent_entropy struct task_struct *copy_process(
>  	RCU_INIT_POINTER(p->bpf_storage, NULL);
>  	p->bpf_ctx = NULL;
>  #endif
> +	p->bpf_net_context =  NULL;

nit: double space after =

Out of curiosity, do we actually have to clear this pointer?

