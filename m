Return-Path: <bpf+bounces-65099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AC3B1BE40
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 03:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 762D518404F
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 01:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB11155322;
	Wed,  6 Aug 2025 01:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nUtsBIVy"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0909E17BA6
	for <bpf@vger.kernel.org>; Wed,  6 Aug 2025 01:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754443474; cv=none; b=h93bwprFiziHTOf/v0sXBwUlIyww0G0R2v7Dk+5MMgXDnOrzIKRxX7/dAAi5sOcVJB2xcIYTDqprcgMW8uuBKMykR1IO833OSmP1yVB5ZZedN028JF4XtN2RDvHN7sadezEXfyFivxjGFJJHLPIj02WP5qXwJMNnGXjyRViIHJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754443474; c=relaxed/simple;
	bh=sfSvyWmOkBnR8370DrNvAJn70vWjKwUFlaCNyyoPdIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F9K4l/1HFwEvivg/K0sYGxWFoWPC2w3MqOlEUkFWmS1wHc2zNamKfqPXyNftr2182kgCaFg+EYkDI9+511fwJGBIcyOHZ2L2MNLdONJMwzPJvP4+rE4ywOqZly0/YeYg/KAlQ0lkI2Gdqtq/Nuzj2NJYJEJQnMDyXNwVTV6Y8PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nUtsBIVy; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <baa409d6-e571-4380-b046-5ea54c0e613d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754443469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uAGMpisIdex9sFjMlYz87CxGsNXYPHq1X/TVZVKvP6M=;
	b=nUtsBIVydd2s9jJL4R2J8ImLxKViGWPDY1vRCu61zUoJv6Bz4eApXj5yrdv4mgRp7Hz13R
	MRosDlm6cBRHa/2drjHXvGRqsC7lKD113TPtMaF1RjvXzS96ASqPMNSR2I0h0iTyeKzfbC
	f6hKc/+RM7sDk+bnDtjkGhitKytwMqM=
Date: Tue, 5 Aug 2025 18:24:18 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next V2 0/7] xdp: Allow BPF to set RX hints for
 XDP_REDIRECTed packets
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Stanislav Fomichev <stfomichev@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <borkmann@iogearbox.net>,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, sdf@fomichev.me,
 kernel-team@cloudflare.com, arthur@arthurfabre.com, jakub@cloudflare.com,
 Jesse Brandeburg <jbrandeburg@cloudflare.com>,
 Andrew Rzeznik <arzeznik@cloudflare.com>
References: <b1873a92-747d-4f32-91f8-126779947e42@kernel.org>
 <aGvcb53APFXR8eJb@mini-arch> <aG427EcHHn9yxaDv@lore-desk>
 <aHE2F1FJlYc37eIz@mini-arch> <aHeKYZY7l2i1xwel@lore-desk>
 <20250716142015.0b309c71@kernel.org>
 <fbb026f9-54cf-49ba-b0dc-0df0f54c6961@kernel.org>
 <20250717182534.4f305f8a@kernel.org>
 <ebc18aba-d832-4eb6-b626-4ca3a2f27fe2@kernel.org>
 <20250721181344.24d47fa3@kernel.org> <aIdWjTCM1nOjiWfC@lore-desk>
 <20250728092956.24a7d09b@kernel.org>
 <b23ed0e2-05cf-454b-bf7a-a637c9bb48e8@kernel.org>
 <4eaf6d02-6b4e-4713-a8f8-6b00a031d255@linux.dev>
 <21f4ee22-84f0-4d5e-8630-9a889ca11e31@kernel.org>
 <20250801133803.7570a6fd@kernel.org>
 <de68b1d7-86cd-4280-af6a-13f0751228c4@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <de68b1d7-86cd-4280-af6a-13f0751228c4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/4/25 6:18 AM, Jesper Dangaard Brouer wrote:
> Do keep-in-mind that "moving skb allocation out of the driver" is not
> part of this patchset and a moonshot goal that will take a long time
> (but we are already "simulation" this via XDP-redirect for years now).

The XDP_PASS was first done in the very early days of BPF in 2016. The 
XDP-redirect then followed a similar setup. A lot has improved since then. A 
moonshot in 2016 does not necessarily mean it is still hard to do now. e.g. Loop 
is feasible. Directly reading/writing skb is also easier.

Let’s first quantify what the performance loss would be if the skb is allocated 
and field-set by the xdp prog (for the general XDP_PASS case and the 
redirect+cpumap case). If it’s really worth it, let’s see what it would take for 
the XDP program to achieve similar optimizations.

> Drivers should obviously not unconditionally populate the xdp_frame's
> rx_meta area.  It is first time to populate rx_meta, once driver reach

afaict, the rx_meta is reserved regardless though. The xdp prog cannot use that 
space for data_meta. The rx_meta will grow in time.

My preference is to allow xdp prog to decide what needs to write in data_meta 
and decides what needs to set in the skb directly. This is the general case it 
should support first and then optimize.


