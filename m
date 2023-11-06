Return-Path: <bpf+bounces-14339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 794F47E318D
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 00:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0327AB20A80
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 23:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348822FE20;
	Mon,  6 Nov 2023 23:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Uldeom9t"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEE72D7AA;
	Mon,  6 Nov 2023 23:42:59 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713F08F;
	Mon,  6 Nov 2023 15:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=BTUeLiuzdbs4XyP6RoSnx/kD75A9eOAk1vJ41lNfUyY=; b=Uldeom9t4dNnZOGcm6fow1VjFp
	hS0b4IHzefVPaSXyitgheR2FnoUptUSPTyOycsgz0b7C6oYnyI3jheZA5yA4835AKNf+SauOjLGSA
	zCeVtkkHlBFYl06VtEyNCS0Vbvo4LsyKPwSMCEsNfCVQR1bk6ASJnvTrWDP/YejDWnFJ8pc8MFa1+
	WSeiOD884IVGAcPNlNIJpq8Q5a2zRh+lplZR6O1lGJYTc7uctafeohiMS1XRaO7fk+cNouvMMyqo8
	7PuNhUOVVFYqRolIHK8tJXNXTUMPsc9gRWHHAEJAnIHjiO1MjlAJeyndoxIgbfD0bt6n57lxlBOke
	hg2kgCEQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1r09F9-000CHN-0z; Tue, 07 Nov 2023 00:42:55 +0100
Received: from [194.230.147.75] (helo=localhost.localdomain)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1r09F8-000Fgk-IJ; Tue, 07 Nov 2023 00:42:54 +0100
Subject: Re: [PATCH bpf 1/6] netkit: Add tstats per-CPU traffic counters
To: Jakub Kicinski <kuba@kernel.org>
Cc: martin.lau@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 Nikolay Aleksandrov <razor@blackwall.org>
References: <20231103222748.12551-1-daniel@iogearbox.net>
 <20231103222748.12551-2-daniel@iogearbox.net>
 <20231106132845.6356bc72@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <fcacfa7a-6c10-3d76-01b7-c0613306f913@iogearbox.net>
Date: Tue, 7 Nov 2023 00:42:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231106132845.6356bc72@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27085/Mon Nov  6 23:37:38 2023)

On 11/6/23 10:28 PM, Jakub Kicinski wrote:
> On Fri,  3 Nov 2023 23:27:43 +0100 Daniel Borkmann wrote:
>> Add dev->tstats traffic accounting to netkit. The latter contains per-CPU
>> RX and TX counters.
>>
>> The dev's TX counters are bumped upon pass/unspec as well as redirect
>> verdicts, in other words, on everything except for drops.
>>
>> The dev's RX counters are bumped upon successful __netif_rx(), as well
>> as from skb_do_redirect() (not part of this commit here).
>>
>> Using dev->lstats with having just a single packets/bytes counter and
>> inferring one another's RX counters from the peer dev's lstats is not
>> possible given skb_do_redirect() can also bump the device's stats.
> 
> sorry for the delay in replying, I'll comment here instead of on:
> 
> https://lore.kernel.org/all/6d5cb0ef-fabc-7ca3-94b2-5b1925a6805f@iogearbox.net/
> 
> What I had in mind was to have the driver just set the type of stats.
> That way it doesn't have to bother with error handling either
> (allocation failure checking, making sure free happens in the right
> spot etc. all happen in the core). Here's a completely untested diff:

Ah perfect, thanks! I'll take a look and integrate this into a v2 this
week if that's okay with you. And add sth to bail out if the ndo is in
place and NETDEV_PCPU_STAT_TSTAT not selected for the time being.

Thanks,
Daniel

