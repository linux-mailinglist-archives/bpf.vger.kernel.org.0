Return-Path: <bpf+bounces-73688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CE4C375B6
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 19:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 036604E4514
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 18:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFA9287247;
	Wed,  5 Nov 2025 18:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzaObCME"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09352836B5;
	Wed,  5 Nov 2025 18:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762367993; cv=none; b=u2FvasBcr6ao1W5kpwxCaa2hszfDnTTkq8R0V1urVAMUKZ0p6wOY9zCpEfoixMk6DAjd2JbyYLMlyzYXSPOMelCtfI4YNvI9vzBob0oXxMRXVH+qZ35qgAiRzWE4f3+tfIY/V3FP8QbEnSDdxbeFkeNKg+3aXSlSsMT3+Wvh7pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762367993; c=relaxed/simple;
	bh=7XDa5X5lmbUNgOnKU7PfOdgy4Ch0ycidqr0WWTqABIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mSJbFXxdeEnDFa9yAqmm1YcasgtkJtm56oiTo8s4WBwG6WW7APOBsANWGJFmWg+4wn75W1jAuUqX8IpNSG3r9AbBNrHrt0G7xOshTeMMiVx9/1mF2yg3oZM1xJ3xVr4nnQs7mNPq4V04K9SZY79aG9obyKZv1W59we0m+xLdH+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzaObCME; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFFAC116B1;
	Wed,  5 Nov 2025 18:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762367991;
	bh=7XDa5X5lmbUNgOnKU7PfOdgy4Ch0ycidqr0WWTqABIM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AzaObCMEOkPNWJblHA+XSNBv8eioXE7D8HzTI2sm196GLWUIiEcS91trLrbe8+TCw
	 mmczy+qAGnYGNXI+E91lp6PYT05/h9ksu1TUPQ2WnXPXkukQBbar6P9/4pk3Hx8jcU
	 sppIEtathxPvwGx0gbog6vaQYLXUvB/YTjXAR1ErNg8N1a66qdefkRZjUL268+4Wor
	 i7xdIfCDfegfOAq4nbsR2zXmjnSmjp7uAJ7+9GKfMBfDv8oJiNkVySX/y7j6Q1DJ7W
	 O56MmI771hr6UYprL0WYfRK++tM3cuVPl+P9FVqCgZkjp7UQLFtTaeHJma12GagMAH
	 fF1XhXlwBjk3Q==
Message-ID: <49edb9fa-56be-4853-aced-429f5b40b4be@kernel.org>
Date: Wed, 5 Nov 2025 19:39:46 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 bpf 1/2] xdp: introduce xdp_convert_skb_to_buff()
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 netdev@vger.kernel.org, magnus.karlsson@intel.com,
 aleksander.lobakin@intel.com, ilias.apalodimas@linaro.org, toke@redhat.com,
 lorenzo@kernel.org, syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Octavian Purdila <tavip@google.com>
References: <20251029221315.2694841-1-maciej.fijalkowski@intel.com>
 <20251029221315.2694841-2-maciej.fijalkowski@intel.com>
 <20251029165020.26b5dd90@kernel.org> <aQNWlB5UL+rK8ZE5@boxer>
 <20251030082519.5db297f3@kernel.org> <aQPJCvBgR3d7lY+g@boxer>
 <20251030190511.62575480@kernel.org> <aQSfgQ9+Jc8dkdhg@boxer>
 <20251031114952.37d1cb1f@kernel.org> <aQidBn22H1UVxST5@boxer>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <aQidBn22H1UVxST5@boxer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/11/2025 13.16, Maciej Fijalkowski wrote:
> On Fri, Oct 31, 2025 at 11:49:52AM -0700, Jakub Kicinski wrote:
>> On Fri, 31 Oct 2025 12:37:37 +0100 Maciej Fijalkowski wrote:
>>>>> would be fine for you? Plus AI reviewer has kicked me in the nuts on veth
>>>>> patch so have to send v6 anyways.
>>>>
>>>> The veth side unfortunately needs more work than Mr Robot points out.
>>>> For some reason veth tries to turn skb into an xdp_frame..
>>>
>>> That is beyond the scope of the fix that I started doing as you're
>>> undermining overall XDP support in veth, IMHO.
>>>
>>> I can follow up on this on some undefined future but right now I will
>>> have to switch to some other work.
>>>
>>> If you disagree and insist on addressing skb->xdp_frame in veth within
>>> this patchset then I'm sorry but I will have to postpone my activities
>>> here.
>>
>> Yeah, I understand. A lot of the skb<>XDP integration is a steaming
>> pile IMO, as mentioned elsewhere. I'd like to keep the core clean
>> tho, so if there's some corner cases in veth after your changes
>> I'll live. But I'm worried that the bugs in veth will make you
>> want to preserve the conditional in xdp_convert_skb_to_buff() :(
> 
> Probably the conditional would cover these corner cases, but I am not
> insisting on it. skb_pp_cow_data() is called under certain circumstances
> in veth but I have never seen a case on my side where it was skipped,
> mostly because of headroom size being too small.

This reminds me that we should change/increase veth
net_device.needed_headroom when there is an XDP prog attached.
As you said, today all SKB will basically get mem reallocated.

--Jesper

