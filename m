Return-Path: <bpf+bounces-30495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C478CE707
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 16:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 792D8B211B7
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 14:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9251C12C47A;
	Fri, 24 May 2024 14:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="SyKRYPXt"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C12B85268;
	Fri, 24 May 2024 14:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716561036; cv=none; b=VqvHZv7LVUidyM6lqzFhzhjWyXTed4e3dNNUAQBVGoXp8KhMJyZDduOdrSWUnABGLwtOUXzd2AJ8yAZcCHoQ1DwiwupF+UOTWGBH2wx9+gWcv06j8vJg1ftIk9tmrXtlJE8NHThrvuqxJy+kBOQdCGSHY25RjNiZaq4l0cTe3SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716561036; c=relaxed/simple;
	bh=qFRZhnD/p+pLSzPnbjviQjaEYa6hMFFXlAZTDb+RQxI=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=W8sl5dcqgjxmZCXDY9E0CW8ZaCIRdPq3xs1YV8WJh/qvcOQ0OYJjCvE0IjivOtod/e2xIOJlM7lZ2YIBzra68jptSGv9JrC2tStZewXAHjUq22G82fh/rJkwhp3ppNfDKmRy79S6qkg5tkPFVmvgBpDdfX/cYDccuHd2r4ihKIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=SyKRYPXt; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=6NBTN3gP3XRC5yswrkvPve4S2HuHh2J1YMADcEHnH60=; b=SyKRYPXtSci/rwupCzQlINgP9T
	kF4JVznumiUoZygiZAAzfcEkbtRuuqhKjt1OSU2ogHKR4AQp/1KvAyuud7IZxpXpWf1ZDlUyCGUZQ
	Ao1CqnDPIWouyI6gscH0RKwnWJcQhb5L1zK80Kd6MJWpKe2zq3CZV0cyOM7pFoE2A4NmNaBEyqP0+
	OkgYy7dwg2qxpawBp2Yud7h8K1HBzDhtw6f22sKwpqizv0p1tNA8TupR0qGkcykAHX533gWzq7B0W
	dVfNEFu9OBV7hN4I3qZax0FZgNghx6J3d2cJ7XaPyf7u3oUXgneyeVSsp5ijtlU/851/2eTIZNMKI
	83mG55qA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sAVwF-0005YE-Sl; Fri, 24 May 2024 16:30:31 +0200
Received: from [178.197.248.14] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sAVwF-0006Pc-2e;
	Fri, 24 May 2024 16:30:31 +0200
Subject: Re: [PATCH bpf 3/5] netkit: Fix syncing peer device mtu with primary
From: Daniel Borkmann <daniel@iogearbox.net>
To: Nikolay Aleksandrov <razor@blackwall.org>, martin.lau@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, Joe Stringer <joe@cilium.io>
References: <20240524130115.9854-1-daniel@iogearbox.net>
 <20240524130115.9854-3-daniel@iogearbox.net>
 <984f7580-890d-4644-b8ad-144505a882e4@blackwall.org>
 <b6465a83-0aae-72be-5050-f9de85d3bf31@iogearbox.net>
Message-ID: <36e9b554-96d1-641f-d521-245dc8a7463f@iogearbox.net>
Date: Fri, 24 May 2024 16:30:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b6465a83-0aae-72be-5050-f9de85d3bf31@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27285/Fri May 24 10:30:55 2024)

On 5/24/24 4:20 PM, Daniel Borkmann wrote:
> On 5/24/24 4:15 PM, Nikolay Aleksandrov wrote:
>> On 5/24/24 16:01, Daniel Borkmann wrote:
>>> Implement the ndo_change_mtu callback in netkit in order to align the MTU
>>> to the primary device. This is needed in order to sync MTUs to the latter
>>> from the control plane (e.g. Cilium) which does not have access into the
>>> Pod's netns.
>>>
>>> Fixes: 35dfaad7188c ("netkit, bpf: Add bpf programmable net device")
>>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>>> Cc: Joe Stringer <joe@cilium.io>
>>> ---
>>>   drivers/net/netkit.c | 20 ++++++++++++++++++++
>>>   1 file changed, 20 insertions(+)
>>>
>>
>> This one has unexpected behaviour IMO. If the app sets the MTU and we
>> silently overwrite, then it may continue working and thinking the MTU
>> was changed leading to unexpected problems. I think it'd be better to
>> keep the MTU synced explicitly (e.g. when set on main device, then
>> set it on peer as well) and error out when trying to set it without
>> the proper capabilities.
> 
> Makes sense, I'll look into this, thanks Nik!

I'll drop this one for now, and have a future extension on nk device
creation to lock such attributes or not so its flexible.

Thanks,
Daniel

