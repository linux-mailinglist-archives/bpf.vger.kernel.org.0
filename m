Return-Path: <bpf+bounces-22313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190EA85B957
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 11:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DA81B222A8
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 10:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE387627FF;
	Tue, 20 Feb 2024 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+4/430e"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747E43EA88;
	Tue, 20 Feb 2024 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708425783; cv=none; b=LsHnCi6JlPaz0y31sKZ6gqOlKD1IaytLSGBUsWgqnKydHvgot0qIa540NnlFF2WTNIGfu4QFlziw5BR42QE6pRJsf+pLieaLnFz6SGW9qa5uTYjXER95toc5PYULJJZMvK9GLTOHJKZAc0N0VCOWBjZEalMYS/OhH5d/1iV6u6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708425783; c=relaxed/simple;
	bh=KN/9eAsuetSnf1YuKZN74PDoEk4+o0nerLs+2e8yZPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JLdxE4HNH6AJw1nqEjpDbYEXZ1sbXF577Jb5RYud1MCs9OVCZ8rZy2+vvXMynTFeSXyL/d7oTynRJvgo0EBbVKxylbhWE1WOD5j74fWzeJLjDXxmf62Ucr/70fBMRMb+CJ5KG+IaCCwqOQvCLFIXpSsE+5yL9mNMxcmhNSjGJVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+4/430e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE66C433C7;
	Tue, 20 Feb 2024 10:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708425782;
	bh=KN/9eAsuetSnf1YuKZN74PDoEk4+o0nerLs+2e8yZPI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a+4/430eZDxmfKGa3jFXyElOroI2LT61/iEsQicEw/czIXo097yQbHPUngAWwdI0w
	 W69qqkzFxu+pIPzRF0UcaqtBrlP3p9Fi+FxaV1d0peQk48+3T3gndymN4btydDDGQQ
	 MUZd1BCXhNupQqBylfWlwEzXD+d9yz+bR5KRd1EvXuVkcuRAGS3aSArphIxADIQ5i3
	 sMAWgM81x34qJeOuvQ/LsR9BXRGHi2S43/kG0E/c5DqiATyyHWFO5tGxOv0prHofuL
	 De2f7LzsObrMkG7z+7oShdb4ohUuwreXwx7VGIA763arifZtVfS6A9njQA9STRYB2q
	 6vZ1ATIJKSbxw==
Message-ID: <0b1c8247-ccfb-4228-bd64-53583329aaa7@kernel.org>
Date: Tue, 20 Feb 2024 11:42:57 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 1/2] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
Content-Language: en-US
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <66d9ee60-fbe3-4444-b98d-887845d4c187@kernel.org>
 <20240214121921.VJJ2bCBE@linutronix.de> <87y1bndvsx.fsf@toke.dk>
 <20240214142827.3vV2WhIA@linutronix.de> <87le7ndo4z.fsf@toke.dk>
 <20240214163607.RjjT5bO_@linutronix.de> <87jzn5cw90.fsf@toke.dk>
 <20240216165737.oIFG5g-U@linutronix.de> <87ttm4b7mh.fsf@toke.dk>
 <04d72b93-a423-4574-a98e-f8915a949415@kernel.org>
 <20240220101741.PZwhANsA@linutronix.de>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20240220101741.PZwhANsA@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 20/02/2024 11.17, Sebastian Andrzej Siewior wrote:
> On 2024-02-20 10:17:53 [+0100], Jesper Dangaard Brouer wrote:
>>
>>
>> On 19/02/2024 20.01, Toke Høiland-Jørgensen wrote:
>>> may be simpler to use pktgen, and at 10G rates that shouldn't become a
>>> bottleneck either. The pktgen_sample03_burst_single_flow.sh script in
>>> samples/pktgen in the kernel source tree is fine for this usage.
>>
>> Example of running script:
>>   ./pktgen_sample03_burst_single_flow.sh -vi mlx5p1 -d 198.18.1.1 -m
>> ec:0d:9a:db:11:c4 -t 12
>>
>> Notice the last parameter, which is number threads to start.
>> If you have a ixgbe NIC driver, then I recommend -t 2 even if you have more
>> CPUs.
> 
> I get
> | Summary                 8,435,690 rx/s                  0 err/s

This seems low...
Have you remembered to disable Ethernet flow-control?

  # ethtool -A ixgbe1 rx off tx off
  # ethtool -A i40e2 rx off tx off


> | Summary                 8,436,294 rx/s                  0 err/s

You want to see the "extended" info via cmdline (or Ctrl+\)

  # xdp-bench drop -e eth1


> 
> with "-t 8 -b 64". I started with 2 and then increased until rx/s was
> falling again. I have ixgbe on the sending side and i40e on the

With ixgbe on the sending side, my testlab shows I need -t 2.

With -t 2 :
Summary                14,678,170 rx/s                  0 err/s
   receive total        14,678,170 pkt/s        14,678,170 drop/s 
         0 error/s
     cpu:1              14,678,170 pkt/s        14,678,170 drop/s 
         0 error/s
   xdp_exception                 0 hit/s

with -t 4:

Summary                10,255,385 rx/s                  0 err/s
   receive total        10,255,385 pkt/s        10,255,385 drop/s 
         0 error/s
     cpu:1              10,255,385 pkt/s        10,255,385 drop/s 
         0 error/s
   xdp_exception                 0 hit/s

> receiving side. I tried to receive on ixgbe but this ended with -ENOMEM
> | # xdp-bench drop eth1
> | Failed to attach XDP program: Cannot allocate memory
> 
> This is v6.8-rc5 on both sides. Let me see where this is coming from…
> 

Another pitfall with ixgbe is that it does a full link reset when
adding/removing XDP prog on device.  This can be annoying if connected
back-to-back, because "remote" pktgen will stop on link reset.

--Jesper

