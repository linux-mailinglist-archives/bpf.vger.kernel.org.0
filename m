Return-Path: <bpf+bounces-10438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FE17A73A2
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 09:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 905E8281894
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 07:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3702B8494;
	Wed, 20 Sep 2023 07:04:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD33653AC;
	Wed, 20 Sep 2023 07:04:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22F5C433CA;
	Wed, 20 Sep 2023 07:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695193472;
	bh=63k/p/+gW9Dz6wOhRcJZeOVhcS6BwsEFxWn9/zo05ME=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=K/QAr4+eZDL9AAAs/FnZTfOGD/2bLGvHZ7G4C7rjd9AblbVWZ7MB6ebDmF5TRTi/E
	 q8hWF7TmVhIM71tRCPXNKAZR5M9uDj4KFV7Kb8OW0aQtSXE7EecQ7iMtm99B7EWjhP
	 xJkSmwWMIww7O1y4NUJ9Yxf7s/7bIKqB4/v7zKkzc9C5SNyk+J/b2hRlRqV/B4vyqb
	 Ph1UlGeK16ArFfOFJ6LuRIwEJnS0bNKUmGpXx3GKzk3NPwVmcR5aJhirAdQ8VSUybn
	 AYE9UIIkyjhRQm4eNLIYvxm2dP/VlIwcKgvIBxul9bbIQY5XIJ0iufqAgpdq7S1ezC
	 vsvHCiiJIJNrg==
Message-ID: <cb2f7931-5ae5-8583-acff-4a186fed6632@kernel.org>
Date: Wed, 20 Sep 2023 09:04:27 +0200
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
Subject: Re: [PATCH net v2 0/3] Add missing xdp_do_flush() invocations.
Content-Language: en-US
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20230918153611.165722-1-bigeasy@linutronix.de>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20230918153611.165722-1-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Sebastian,


On 18/09/2023 17.36, Sebastian Andrzej Siewior wrote:
> Hi,
> 
> I've been looking at the drivers/ XDP users and noticed that some
> XDP_REDIRECT user don't invoke xdp_do_flush() at the end.

I'm wondering if we could detect (and WARN) in the net core e.g.
net_rx_action() that a driver is missing a flush?

The idea could be to check the per CPU (struct) bpf_redirect_info.
Or check (per CPU) dev_flush_list.

If some is worried about performance implications, then we can hide this
under CONFIG_DEBUG_NET.

> v1…v2: https://lore.kernel.org/all/20230908135748.794163-1-bigeasy@linutronix.de
>    - Collected tags.
>    - Dropped the #4 patch which was touching cpu_map_bpf_prog_run()
>      because it is not needed.
> 

For the fixes in this set:

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

Thanks for fixing these! - at it can lead to strange to debug cases.
--Jesper

