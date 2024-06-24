Return-Path: <bpf+bounces-32959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91788915AB5
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 01:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 124E2B21249
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 23:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCA91A2C01;
	Mon, 24 Jun 2024 23:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4GF3rqE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E3217BA7;
	Mon, 24 Jun 2024 23:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719272230; cv=none; b=N0iTsABHAeuZNJGt9WIv/dXQ7ObFTaiMQvNWgqStQo40iAuu26PBe8Ph6j8JuNcN0pJhmJub2aywLysNKhO9HQ2oR1fGiK+0RokWWN5bYBT2CG61E4aWCbFsCxm0A7uhdd9A9BZ2tepYv8yd8A4XHjaDaPXjLoNgDblBFUf1pjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719272230; c=relaxed/simple;
	bh=gDfZ6jZvYAE6Q6/O4e2/JMAPIQCAiJhqsjPmH7V3IPs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YNgPWLGrqwqQAnH4Fkh4GXI/gPG6QxAtora6sZrHmxgnnblryry5LRcCfT2D516fOjEKVPv0eiSqtoAZk8LPBmK8JtUQJJdqz8nJwA+xsBsqY53Kt742NoZUFKbJDg9Fg+QwEhlkwbpy/E8KZWlfLv4n46Dgoz60rUD/0PAX0mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4GF3rqE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B13FC2BBFC;
	Mon, 24 Jun 2024 23:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719272229;
	bh=gDfZ6jZvYAE6Q6/O4e2/JMAPIQCAiJhqsjPmH7V3IPs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B4GF3rqEf98t9NFWty5M9/ZrfqKjr1pVRvhbUKWR8y2Sxd21K6026NXR7MJ87ofUp
	 eC05vcLcI7JxpKcuVzZYakgGJpZpz1T/gyX4A/gGh06Ns98jsKADpZne389hvqdGf+
	 o+iNRq5IgHTKcb9IiiMWa637rDdqhdd/oe4L00OjV7WyzD/b+T5ViEv9kHWZmoc4L/
	 W1U9vXPA/fEO6pAbszfLiy/jD/egkRfUOo30TnEE6NV11o47W5Blw8HRKrqXIUZwqA
	 YjLvfoWGUVhoxp7XLQOvrD0Ko2Sx6fIHZp8+KlnlDSGGz48mEJ9FGLyUZzGR+wSOPL
	 NNTc+PBV2dmuQ==
Date: Mon, 24 Jun 2024 16:37:07 -0700
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
Message-ID: <20240624163707.1850c113@kernel.org>
In-Reply-To: <20240624072611.wnKkoUW9@linutronix.de>
References: <20240620132727.660738-1-bigeasy@linutronix.de>
	<20240620132727.660738-15-bigeasy@linutronix.de>
	<20240621190840.4da4b775@kernel.org>
	<20240624072611.wnKkoUW9@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jun 2024 09:26:11 +0200 Sebastian Andrzej Siewior wrote:
> > > +	p->bpf_net_context =  NULL;  
> > 
> > nit: double space after =
> > 
> > Out of curiosity, do we actually have to clear this pointer?  
> 
> I don't think so. We never clone a thread within a redirect section so
> this can probably go away.

Perhaps delete this one as follow up, too?

