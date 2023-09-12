Return-Path: <bpf+bounces-9739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DB679CE27
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 12:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B345F28239B
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 10:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA20179A0;
	Tue, 12 Sep 2023 10:23:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660F61775E;
	Tue, 12 Sep 2023 10:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA40BC433C8;
	Tue, 12 Sep 2023 10:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694514193;
	bh=Xd4kWhKvVI0ZVCSnrOAEcrgSuChgNak5Za7/ZeMfnoc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=sr8Tw+l8KRBrQQOkD1VdFpElMO6lgR4A5JKNMfYyeV6EaVQN+tZcu1SEY1lYJdgUl
	 i4xarypOtmyM05yBb+CknJQ3k5yuLoqazBVUNqiZxRGJf6w7a228umsQ0guTZFz3Vi
	 vwBRumTpb/x51I3FBq24eQIbclyOBKO/6GqE7wRvWb4DybFwm99jPQS4dUmwLe3s4V
	 Se9jl1xcirH4GIZKkBfii3oFWmjbuqDJ0FOTkQW3v7xIr5PLImTHC77k4JgYOoOJIi
	 aJbNVSQzgeb+1xjVX4y/pU3PaGZF2FL7jChG1VhXcL541Y7hLmcmUS3zOApEuJgbn4
	 MXDoOyNBSz0Xw==
Message-ID: <8730b2e2-8088-a8cf-11d7-72ee41c11d25@kernel.org>
Date: Tue, 12 Sep 2023 12:23:09 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: "David S. Miller" <davem@davemloft.net>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH net-next 2/2] bpf: Remove xdp_do_flush_map().
Content-Language: en-US
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20230908143215.869913-1-bigeasy@linutronix.de>
 <20230908143215.869913-3-bigeasy@linutronix.de>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20230908143215.869913-3-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/09/2023 16.32, Sebastian Andrzej Siewior wrote:
> xdp_do_flush_map() can be removed because there is no more user in tree.
> 
> Remove xdp_do_flush_map().
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---

Thanks for cleaning up :-)

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

