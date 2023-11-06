Return-Path: <bpf+bounces-14301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 638507E2BD4
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 19:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94CA61C20D30
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 18:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA1B2C87F;
	Mon,  6 Nov 2023 18:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="ef9sDlkz"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81612C86F;
	Mon,  6 Nov 2023 18:22:06 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D2FD47;
	Mon,  6 Nov 2023 10:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=sOSdsNqbyXmCuMzsqcDUCbUAESIaABwBAG5c+7hOL5U=; b=ef9sDlkzUa4rKcnKoM4Q/qAj+/
	It7D8kCrw7ieTwEoqluxKJjpnuB5GCIL1lu3Da0Yyhv/M0gl533WbQiWgH8TLdTWJyliMoqwFZ225
	3nhebqfvRrcMJJnR8VDbNepc/yP5aQb9XnWPIc9gbux+kQaMI13wpW/bPdHvLexOwXuAEUrJJKNIK
	TVQa2xn90LFhzQHc40bkYIcZhVtYma3J2fo9mmWdBrxhDg+Y5ocLJU4dpMOKQHTdVj5958oGTQdqH
	mbxEleMbOyN4lh2yubgbNJODbbtnmGlmarq84OlSKPqWRDD/VohjsQPBiluDTnkUXRAWnNmWYe+W+
	YgR+188w==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1r04Eb-000Oka-60; Mon, 06 Nov 2023 19:22:01 +0100
Received: from [194.230.147.75] (helo=localhost.localdomain)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1r04Ea-0003I6-Jz; Mon, 06 Nov 2023 19:22:00 +0100
Subject: Re: [PATCH bpf 4/6] bpf, netkit: Add indirect call wrapper for
 fetching peer dev
To: Stanislav Fomichev <sdf@google.com>
Cc: martin.lau@kernel.org, kuba@kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>
References: <20231103222748.12551-1-daniel@iogearbox.net>
 <20231103222748.12551-5-daniel@iogearbox.net> <ZUkgtxlK9MRGHx8v@google.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <0397a813-7e55-7a67-c876-b2274782805f@iogearbox.net>
Date: Mon, 6 Nov 2023 19:21:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZUkgtxlK9MRGHx8v@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27084/Mon Nov  6 09:39:04 2023)

On 11/6/23 6:21 PM, Stanislav Fomichev wrote:
[...]
>> +static struct net_device *skb_get_peer_dev(struct net_device *dev)
>> +{
>> +	const struct net_device_ops *ops = dev->netdev_ops;
>> +
>> +	if (likely(ops->ndo_get_peer_dev))
>> +		return INDIRECT_CALL_1(ops->ndo_get_peer_dev,
>> +				       netkit_peer_dev, dev);
> 
> nit: why not put both netkit and veth here under INDIRECT_CALL_2 ?
> Presumably should help with the veth deployments as well?

Yes, I'm also planning to add it there as well, it's a slightly larger
change since also a new header needs to be added, but I'll follow-up on it.

Thanks for review,
Daniel

