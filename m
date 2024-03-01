Return-Path: <bpf+bounces-23116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D7886DBCB
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 08:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A6351F261AA
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 07:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C6E6931D;
	Fri,  1 Mar 2024 07:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RTpWJTxJ"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232C169302
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 07:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709276565; cv=none; b=UfHTTpOoOE8eO8t52YcEEK/1A4h9cW7mtGfMK1VG8TloTosTaVgkntWPf2pSReKIQ+G1mizR49rlecqdukQzSIJYJjbCDQYz21UH+Wg+msp9vW2pta36R9tuKluGBGXJIrIIqM1Fel1loZdHIiu9PgYID1SPnGYDWYtKLBNREHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709276565; c=relaxed/simple;
	bh=eeYjzCOa3IHlOQ8XQgZ9V2FFRichH88AUSu1oEmFwlQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Z2aiyX/kMVqt9I2mi25Ct2TTQAmeyEeNkRraNFrmt8b9/YME3c3prt9+VgIMD8uo72Udkoc1A+6ahAFSOm3mwLign0w6xWpZzJEDg12jNQDi10+Y1V9Auqw4gE+xQc118ihCY+7Rp57WEY/vZOLNBX8NzwJCPP8vrb5XXP0jfdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RTpWJTxJ; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <332c7a04-edc8-40bd-9e8f-69c5d297e845@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709276561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q+R57nlgNYlzh5ejQpgKXMR5auAQmldU7vEvlXc/LJs=;
	b=RTpWJTxJA5PpIDyFqQhsIHUDBP6OBgyYRlRjbhnVmTPzQqTU98gEk7vq02aXlOeh0aS8eP
	0UcavUVdrAOe9EDraWCo/YT3cRL4fMh+NYf9fNTEQKDYoYpLq2kBEb70+PNrBqSRvmGw6D
	69BzLaH0iLLwV+gxwbo0MsBXUDhvVFY=
Date: Thu, 29 Feb 2024 23:02:31 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [PATCH net-next v12 00/15] Introducing P4TC (series 1)
To: John Fastabend <john.fastabend@gmail.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>
Cc: deb.chatterjee@intel.com, anjali.singhai@intel.com,
 namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com,
 Mahesh.Shirshyad@amd.com, Vipin.Jain@amd.com, tomasz.osinski@intel.com,
 jiri@resnulli.us, xiyou.wangcong@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, vladbu@nvidia.com,
 horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, daniel@iogearbox.net,
 victor@mojatatu.com, pctammela@mojatatu.com, dan.daly@intel.com,
 andy.fingerhut@gmail.com, chris.sommers@keysight.com, mattyk@nvidia.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20240225165447.156954-1-jhs@mojatatu.com>
 <65df6935db67e_2a12e2083b@john.notmuch>
Content-Language: en-US
In-Reply-To: <65df6935db67e_2a12e2083b@john.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/28/24 9:11 AM, John Fastabend wrote:
>   - The kfuncs are mostly duplicates of map ops we already have in BPF API.
>     The motivation by my read is to use netlink instead of bpf commands. I

I also have similar thought on the kfuncs (create/update/delete) which is mostly 
bpf map ops. It could have one single kfunc to allocate a kernel specific p4 
entry/object and then store that in a bpf map. With the bpf_rbtree, bpf_list, 
and other recent advancements, it should be able to describe them in a bpf map. 
The reply in v9 was that the p4 table will also be used in the future HW 
piece/driver but the HW piece is not ready yet, bpf is the only consumer of the 
kernel p4 table now and this makes mimicking the bpf map api to kfuncs not 
convincing. bpf "tc / xdp" program uses netlink to attach/detach and the policy 
also stays in the bpf map.

When there is a HW piece that consumes the p4 table, that will be a better time 
to discuss the kfunc interface.

>     don't agree with this, optimizing for some low level debug a developer
>     uses is the wrong design space. Actual users should not be deploying
>     this via ssh into boxes. The workflow will not scale and really we need
>     tooling and infra to land P4 programs across the network. This is orders
>     of more pain if its an endpoint solution and not a middlebox/switch
>     solution. As a switch solution I don't see how p4tc sw scales to even TOR
>     packet rates. So you need tooling on top and user interact with the
>     tooling not the Linux widget/debugger at the bottom.


