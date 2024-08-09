Return-Path: <bpf+bounces-36764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9983894CD5B
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 11:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440591F21CD5
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 09:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E160191F9E;
	Fri,  9 Aug 2024 09:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7a004Lo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CDA1DA21;
	Fri,  9 Aug 2024 09:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723195936; cv=none; b=PmxQTkJKICHmRlgKxL2k8lZHjGirqQYKjrbI9fottg+/GQLSv8zwRDwrRQA+qc5IxnFkNNEJRYJy/12DLTNM0HbH6BZ/6fF0NQDNE9kU4x/6kH/chTH8Ja/vgyW57SOcGKCRFRAvILtRX+xvokAw2UzcTEPPUnHBKYSrQ/VegEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723195936; c=relaxed/simple;
	bh=MVW67Mp6oyQPKwlzFl2IfpyHSdwlY9XxfTNGLs7m2vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ghXiNOMJGlQJKRd/FVQrbM21BUDkKS8qsDnz1/2DHgQuJyCHfbB2YoEtGML6j1FRm3IsPHNu0n3zWYMtMVh1jO5a0fYxR6s3D+CryuVJfRP2sm5UAobaEqAz4ktMIawDL5uBAguGy75aK8wls2LrdL3BvrHv6i2l/MIltRa9k7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7a004Lo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA0CC4AF0E;
	Fri,  9 Aug 2024 09:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723195936;
	bh=MVW67Mp6oyQPKwlzFl2IfpyHSdwlY9XxfTNGLs7m2vo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D7a004LoAZdI95ADsRi0vcdIqffAGAkjPLox3g6k/rwFTXdG7EXX8UtBbDpbS6tJJ
	 hSDsZYrhZwCYwSJLfxMQRMIb+Aqphl9HORBkIhtokM4JXH9oxpFwIj4OOGedZEa/XX
	 hl72YD5ZL9J3hSgyzkt/q8qpqNxeggyOJXBtLNMOgyNOdTHXawRezsRS5Ax7SJc5uu
	 Y7K0/zbq+522du1NYaHwhjF7VtC3rqtCoH6DEUHTQnDr4jbKKUep1OGRNUNB8jeVoz
	 aWK1TFqU6r4SCdBTsl82kqa+zlno/6uJSijfpZ9ccDX5vP+FnsKG6xv3Z8MdffqhQO
	 xTLdx8khxKM3w==
Message-ID: <6e29dc64-672b-47ba-a874-420c5aa681cf@kernel.org>
Date: Fri, 9 Aug 2024 11:32:09 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC bpf-next 32/52] bpf, cpumap: switch to GRO from
 netif_receive_skb_list()
To: Daniel Xu <dxu@dxuuu.xyz>, Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: Alexander Lobakin <alexandr.lobakin@intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 Larysa Zaremba <larysa.zaremba@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, "toke@redhat.com"
 <toke@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 John Fastabend <john.fastabend@gmail.com>, Yajun Deng
 <yajun.deng@linux.dev>, Willem de Bruijn <willemb@google.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, xdp-hints@xdp-project.net,
 kernel-team <kernel-team@cloudflare.com>
References: <20220628194812.1453059-1-alexandr.lobakin@intel.com>
 <20220628194812.1453059-33-alexandr.lobakin@intel.com>
 <cadda351-6e93-4568-ba26-21a760bf9a57@app.fastmail.com>
 <ZrRPbtKk7RMXHfhH@lore-rh-laptop>
 <7e6c0c0d-886e-4144-a0f4-d0d6f0faa1e6@app.fastmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <7e6c0c0d-886e-4144-a0f4-d0d6f0faa1e6@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 08/08/2024 22.44, Daniel Xu wrote:
> Hi Lorenzo,
> 
> On Thu, Aug 8, 2024, at 12:54 AM, Lorenzo Bianconi wrote:
>>> Hi Alexander,
>>>
>>> On Tue, Jun 28, 2022, at 12:47 PM, Alexander Lobakin wrote:
[...]
>>>
>>> AFAICT the cpumap + GRO is a good standalone improvement. I think
>>> cpumap is still missing this.
>>>
>>> I have a production use case for this now. We want to do some intelligent
>>> RX steering and I think GRO would help over list-ified receive in some cases.
>>> We would prefer steer in HW (and thus get existing GRO support) but not all
>>> our NICs support it. So we need a software fallback.
>>>
I want to state that Cloudflare is also planning to use cpumap in
production, and (one) blocker is that CPUMAP doesn't support GRO.


>>> Are you still interested in merging the cpumap + GRO patches?
>>
>> Hi Daniel and Alex,
>>
>> Recently I worked on a PoC to add GRO support to cpumap codebase:
>> -
>> https://github.com/LorenzoBianconi/bpf-next/commit/a4b8264d5000ecf016da5a2dd9ac302deaf38b3e
>>    Here I added GRO support to cpumap through gro-cells.
>> -
>> https://github.com/LorenzoBianconi/bpf-next/commit/da6cb32a4674aa72401c7414c9a8a0775ef41a55
>>    Here I added GRO support to cpumap trough napi-threaded APIs (with a
>> some
>>    changes to them).
> 
> Cool!
> 
>>
>> Please note I have not run any performance tests so far, just verified it does
>> not crash (I was planning to resume this work soon). Please let me know if it
>> works for you.
> 
> I’ll try to run an A/B test on your two approaches as well as Alex’s. I’ve still
> got some testbeds with production traffic going thru them.
> 

It is awesome that both Olek and you are stepping up for testing this.
(I'm currently too busy on cgroup rstat lock related work, but more
people will be joining my team this month and I hope they have interest
in contributing to this effort).

--Jesper



