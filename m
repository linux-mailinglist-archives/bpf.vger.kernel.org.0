Return-Path: <bpf+bounces-13255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF35F7D71F0
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 18:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99C9C281D98
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 16:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353B528E08;
	Wed, 25 Oct 2023 16:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Gacs860e"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAAD1F61C
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 16:54:38 +0000 (UTC)
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ba])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F5112A
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 09:54:37 -0700 (PDT)
Message-ID: <f6357d19-9bd9-e9f4-6e9d-97a73f61560d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698252875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1VjGtvE6jtbr5u1nLIKOL6cl+2iks3m9+SCIpFYs+VU=;
	b=Gacs860eaS4L0ykk1HnCBk/ZE4n4Uu54FUxSYgBxkbPK0ph5ye0RL9TkBPAcJU8wmp2jvs
	4ggag2n5NOIpStz5CIMNbh5i4rKyggqdlrkE4URaodVKdwb25J1EOMxTXUdJdhGsCcdKH3
	3jvRV/NHcaq27fWHLDDEDhUCLQCsk4A=
Date: Wed, 25 Oct 2023 09:54:27 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 0/7] Add bpf programmable net device
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, razor@blackwall.org, ast@kernel.org,
 andrii@kernel.org, john.fastabend@gmail.com, sdf@google.com,
 toke@kernel.org, kuba@kernel.org, andrew@lunn.ch
References: <20231024214904.29825-1-daniel@iogearbox.net>
 <169819142514.13417.3415333680978363345.git-patchwork-notify@kernel.org>
 <ZTk5MErTKAK96nO3@nanopsycho>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <ZTk5MErTKAK96nO3@nanopsycho>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/25/23 8:50 AM, Jiri Pirko wrote:
> Wed, Oct 25, 2023 at 01:50:25AM CEST, patchwork-bot+netdevbpf@kernel.org wrote:
>> Hello:
>>
>> This series was applied to bpf/bpf-next.git (master)
>> by Martin KaFai Lau <martin.lau@kernel.org>:
> 
> Interesting, applied within 2 hours after send. You bpf people don't
> care about some 24h timeout?

24hr? The v1 was posted to both netdev and bpf list on 9/25. It was 10/24 
yesterday. The part you commented in patch 1 had not been changed much since v1, 
so there was a month of time. netdev is always on the cc list. Multiple people 
(Andrew, Jakub...etc) had already helped to review and Daniel had addressed the 
comments. The change history had been diminishing from v1 to v4 and v4 changes 
was mostly nit-picking already.


