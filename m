Return-Path: <bpf+bounces-18375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E710819E93
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 13:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFAAD1C225B6
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 12:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578F321A1B;
	Wed, 20 Dec 2023 12:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgIg06XV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA734219EE;
	Wed, 20 Dec 2023 12:00:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CAC2C433C8;
	Wed, 20 Dec 2023 12:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703073648;
	bh=ngOvTFdwplz311q8i+5a5XP8onKcx4SXEJszH5Ve/cw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pgIg06XV2CmE8Q86sr4EYNMpsdPqjjiTPPg+EDtoR6Iq02olVGpradZwV7M3f6fxO
	 jM8nDnd/SMcHoGFWfOAPmweHGomZ3uxjL0ApHuClUvi/XIcERDMClWrg8J2Fhb3+AJ
	 SUv3tbTKHEYGUtqI5ojv0vTwX2/3GJ6uMpOcAhUCoWubNej6C+Z3fI6JQ8YGjcv5c7
	 22OcG+Ktrq0DnOy6mYeufJgZaAMMegmjtTJhrWtl+nKhWLtrTWnmHbRXXjYWrN9hE3
	 8zmtbGnx7lL37uIEGLyNZL3uIzxM7f00A8kWytmLt6I7H2ekYhnJYtI2mDB0vFQ8Bo
	 LQFCeXIQ3RHqQ==
Message-ID: <33bbb170-afdd-477f-9296-a9cede9bc2f2@kernel.org>
Date: Wed, 20 Dec 2023 13:00:42 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 1/3] net: introduce page_pool pointer in
 softnet_data percpu struct
To: Paolo Abeni <pabeni@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, kuba@kernel.org,
 Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 willemdebruijn.kernel@gmail.com, toke@redhat.com, davem@davemloft.net,
 edumazet@google.com, bpf@vger.kernel.org, lorenzo.bianconi@redhat.com,
 sdf@google.com, jasowang@redhat.com
References: <cover.1702563810.git.lorenzo@kernel.org>
 <b1432fc51c694f1be8daabb19773744fcee13cf1.1702563810.git.lorenzo@kernel.org>
 <c49124012f186e06a4a379b060c85e4cca1a9d53.camel@redhat.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <c49124012f186e06a4a379b060c85e4cca1a9d53.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19/12/2023 16.23, Paolo Abeni wrote:
> On Thu, 2023-12-14 at 15:29 +0100, Lorenzo Bianconi wrote:
>> Allocate percpu page_pools in softnet_data.
>> Moreover add cpuid filed in page_pool struct in order to recycle the
>> page in the page_pool "hot" cache if napi_pp_put_page() is running on
>> the same cpu.
>> This is a preliminary patch to add xdp multi-buff support for xdp running
>> in generic mode.
>>
>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> ---
>>   include/linux/netdevice.h       |  1 +
>>   include/net/page_pool/helpers.h |  5 +++++
>>   include/net/page_pool/types.h   |  1 +
>>   net/core/dev.c                  | 39 ++++++++++++++++++++++++++++++++-
>>   net/core/page_pool.c            |  5 +++++
>>   net/core/skbuff.c               |  5 +++--
>>   6 files changed, 53 insertions(+), 3 deletions(-)
> 
> @Jesper, @Ilias: could you please have a look at the pp bits?
> 

I have some concerns... I'm still entertaining the idea, but we need to
be aware of the tradeoffs we are making.

(1)
Adding PP to softnet_data means per CPU caching 256 pages in the
ptr_ring (plus likely 64 in the alloc-cache).   Fortunately, PP starts
out empty, so as long as this PP isn't used they don't get cached. But
if used, then PP don't have a MM shrinker that removes these cached
pages, in case system is under MM pressure.  I guess, you can argue that
keeping this per netdev rx-queue would make memory usage even higher.
This is a tradeoff, we are trading memory (waste) for speed.


(2) (Question to Jakub I guess)
How does this connect with Jakub's PP netlink stats interface?
E.g. I find it very practical that this allow us get PP stats per
netdev, but in this case there isn't a netdev.


(3) (Implicit locking)
PP have lockless "alloc" because it it relies on drivers NAPI context.
The places where netstack access softnet_data provide similar protection
that we can rely on for PP, so this is likely correct implementation
wise.  But it will give people like Sebastian (Cc) more gray hair when
figuring out how PREEMPT_RT handle these cases.

(4)
The optimization is needed for the case where we need to re-allocate and
copy SKB fragments.  I think we should focus on avoiding this code path,
instead of optimizing it.  For UDP it should be fairly easy, but for TCP
this is harder.

--Jesper

