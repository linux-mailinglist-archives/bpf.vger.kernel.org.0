Return-Path: <bpf+bounces-32790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5719C913182
	for <lists+bpf@lfdr.de>; Sat, 22 Jun 2024 04:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2F821F23142
	for <lists+bpf@lfdr.de>; Sat, 22 Jun 2024 02:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE36A63D5;
	Sat, 22 Jun 2024 02:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+EfYuK8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C14D8F5D;
	Sat, 22 Jun 2024 02:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719021961; cv=none; b=exuFRewh0TVNOLxlrFK+ZsNmXMQVwRBAk5+lu1neBHQDDOHF8I8rEyNkPE/wP7pNPYQWdSqMtSDgh6bm/FLcvHekGq+A3Rb2+NnHpFlKrdWBSnBrZBaZ/SvDu2ZfVhkrLvxtb3A7IpGpTyaO3T/DYFcyhuCj2cEUo7WIgz9Jh7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719021961; c=relaxed/simple;
	bh=zTg822l4VjJCDrdBAaQFPxBmNa6vqsABfh8rmtt+b2w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eLs0RvEaI3rrIv9voxdMbOoFaCvdB9mfGYzpXrlIIAGrcGCbbiswhC3mQEHKue1g4Ei5GflUxCn71b5ytZsJtfiTc5kKziTTPgaNlEZhXGljCO0Z/puOtgUQawvLien63n+lqWrf7ZqyQ2gpNjWNSPhQt0FuifY1eCtEO31a5i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+EfYuK8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9440AC2BBFC;
	Sat, 22 Jun 2024 02:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719021960;
	bh=zTg822l4VjJCDrdBAaQFPxBmNa6vqsABfh8rmtt+b2w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E+EfYuK8WxK66OXHiMfQtIlBGiEX4lQ1FEYunTYDmYkwoF9bmegzYMXnxoDVjTEZA
	 FrlmnM4ZvT3bz0O3YQNDgDdv7dBAJnt+we2/gmUT9tphyuedBOm9o25tH1wFkVFshQ
	 iBVUws0vgDt4QRoHMcEyPvVj/wsGsZ1Crr1FvWnl7KCiEVfpBfCSypfQl6OVD5+U3B
	 Uda0xqcIm5wdg59X2uy8fWoKtWx/ycd1BFM0ebCtS6iGKZhKOuTPcf5ENj2CRdFB46
	 Z+qBd9Sg5yH3CfhF6THlwXUz9o5ha/QwEEP2/FJIvcn5yP7DFZm1xihdO7AeqOqC+N
	 rGh0dEs8FoRIw==
Date: Fri, 21 Jun 2024 19:05:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Daniel Bristot de Oliveira <bristot@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Eric Dumazet <edumazet@google.com>, Frederic Weisbecker
 <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, Paolo Abeni
 <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Waiman Long <longman@redhat.com>, Will Deacon
 <will@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Jiri Olsa <jolsa@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Jonathan Lemon
 <jonathan.lemon@gmail.com>, KP Singh <kpsingh@kernel.org>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, Magnus Karlsson
 <magnus.karlsson@intel.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Stanislav Fomichev <sdf@google.com>, Toke
 =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>, Yonghong Song
 <yonghong.song@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH v9 net-next 15/15] net: Move per-CPU flush-lists to
 bpf_net_context on PREEMPT_RT.
Message-ID: <20240621190558.409d778c@kernel.org>
In-Reply-To: <20240620132727.660738-16-bigeasy@linutronix.de>
References: <20240620132727.660738-1-bigeasy@linutronix.de>
	<20240620132727.660738-16-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jun 2024 15:22:05 +0200 Sebastian Andrzej Siewior wrote:
>  void __cpu_map_flush(void)
>  {
> -	struct list_head *flush_list = this_cpu_ptr(&cpu_map_flush_list);
> +	struct list_head *flush_list = bpf_net_ctx_get_cpu_map_flush_list();
>  	struct xdp_bulk_queue *bq, *tmp;
>  
>  	list_for_each_entry_safe(bq, tmp, flush_list, flush_node) {

Most of the time we'll init the flush list just to walk its (empty)
self. It feels really tempting to check the init flag inside
xdp_do_flush() already. Since the various sub-flush handles may not get
inlined - we could save ourselves not only the pointless init, but
also the function calls. So the code would potentially be faster than
before the changes?

Can be a follow up, obviously.

