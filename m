Return-Path: <bpf+bounces-53109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E33A4CBF7
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 20:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7EA07A30BE
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 19:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7636E231CB0;
	Mon,  3 Mar 2025 19:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GegXOxQO"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D68522D79C
	for <bpf@vger.kernel.org>; Mon,  3 Mar 2025 19:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741030138; cv=none; b=UJvPM0LFU3UEAR8owjORm3FiVc9+koZywb51OAiPUzpnabMptgz7ihUD9wMWlLu7ZtyN2K/uu+TX4NvNOTpN7QVmrexLcKytN0LKnoc3VF09W8OMtlG11QphlhssQa7kJKV5od/dnheWB2ef4Sn8Z7lkObCFyLsa2boc/gdG/Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741030138; c=relaxed/simple;
	bh=GrTUyx/IeJfdqo7iKYYR4uGFEkbDgD/G++8REVC7toM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QkhlPgOQpADmwBe1FtXIVIMhZuPg/Zz5PQFgav2YMI8i5sMCnT72jFIEyqBDEaRI+BSnGt9xldVKRlIFgJmuycIy0AosgT3sclgmfooP2tPqG77p0XxgHY9FspYWHwNdmECEDaoC0Fwc7DUxQEit/Xj1f46IpYwfPBFe455pnJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GegXOxQO; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <eb6f77f2-3518-4fa4-bdb8-7438cd708ad1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741030133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9U5IgeW+FuaLX038UuIvA2IE6lvvCpFaZI1MTKj94Hg=;
	b=GegXOxQO0A+ZajvVObN4wZmpn4po8WAFAUeYPFu/cTv67xV8+Xi+YT9pnoOSYriC3RsOKP
	gepGH3Uh5nhHzxOFe9t2zzCGy714V6APgsy3SYZflirByEWHsjfxmsEWSboIr3v1dIqRB/
	fkuh4w6j/QVWFAXQ6mMs2btM1PdJ95A=
Date: Mon, 3 Mar 2025 11:28:45 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/6] net: tun: enable transfer of XDP metadata
 to skb
To: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, hawk@kernel.org, Willem de Bruijn <willemb@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250227142330.1605996-1-marcus.wichelmann@hetzner-cloud.de>
 <20250227142330.1605996-3-marcus.wichelmann@hetzner-cloud.de>
 <090ede76-0c9f-4297-9d5a-7b75aa20ca27@linux.dev>
 <4b69bd2b-a0ad-44f6-9f43-070241bd8089@hetzner-cloud.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <4b69bd2b-a0ad-44f6-9f43-070241bd8089@hetzner-cloud.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 3/3/25 8:13 AM, Marcus Wichelmann wrote:
> Am 28.02.25 um 20:49 schrieb Martin KaFai Lau:
>> On 2/27/25 6:23 AM, Marcus Wichelmann wrote:
>>> When the XDP metadata area was used, it is expected that the same
>>> metadata can also be accessed from TC, as can be read in the description
>>> of the bpf_xdp_adjust_meta helper function. In the tun driver, this was
>>> not yet implemented.
>>>
>>> To make this work, the skb that is being built on XDP_PASS should know
>>> of the current size of the metadata area. This is ensured by adding
>>> calls to skb_metadata_set. For the tun_xdp_one code path, an additional
>>> check is necessary to handle the case where the externally initialized
>>> xdp_buff has no metadata support (xdp->data_meta == xdp->data + 1).
>>>
>>> More information about this feature can be found in the commit message
>>> of commit de8f3a83b0a0 ("bpf: add meta pointer for direct access").
>>>> Signed-off-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
>>> Reviewed-by: Willem de Bruijn <willemb@google.com>
>>> Acked-by: Jason Wang <jasowang@redhat.com>
>>> ---
>>>    drivers/net/tun.c | 25 ++++++++++++++++++++++---
>>>    1 file changed, 22 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>>> index 4ec8fbd93c8d..70208b3a2e93 100644
>>> --- a/drivers/net/tun.c
>>> +++ b/drivers/net/tun.c
>>
>> The changes have conflicts with the commit 2506251e81d1 ("tun: Decouple vnet handling").
>>
>> It is better to rebase the works onto the bpf-next/net,
>> i.e. the "net" branch instead of the "master" branch.
> 
> Alright, will do that. Should I send it as a v5 and still with "PATCH bpf-next"
> in the header or something else?

That should do. The bpf CI should pick up the bpf-next/net if it fails to apply 
to the bpf-next/master because of the conflict mentioned above.

For patch 3, it should help to avoid the future merge conflict if the 
open_tuntap() is added a few lines above in the network_helpers.h. For patch 6, 
the "test_ns_" naming is not in bpf-next/net yet. Other tests in the same file 
is doing netns_new. May be just do the same and cleanup all at once of this file 
later.


