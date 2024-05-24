Return-Path: <bpf+bounces-30494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF318CE6DB
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 16:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F5941F22322
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 14:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC3112C47D;
	Fri, 24 May 2024 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="D/ehsvyZ"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4559012C473;
	Fri, 24 May 2024 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716560406; cv=none; b=GnOO6XeqZyEH97Hc2pXjxA0cgM8RkyfnBAt1L0NzNxESeLgyy71TQD+0JZESTpTFSv55u/WFffVja7kGpWJxFTUUmTRUJVIDQ35/cyC/EC2mH4a8zTtcr0rzU3RjAaoVTqLFPK0DRPv5ACJZwJ9ix2Qi4gTWdN0frG3uNvgrnH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716560406; c=relaxed/simple;
	bh=xDvkWO2zOKOZa7ZogYE51qFX9WRrCSDbeOfVyv5r/Fk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=AbTEqfC9DvKW0kKcO8AfhoEeSHCT0x2GFmBy1wKDvr6e/SGWOlj9TQUigEMfcxRGBhFtaum8DWUtJPD/6yI1pT/2c9Xg1LKD6tcRL4QsgqyUymGX1s5cIiF74dEj+bZ+cIWd2GZEUxVaUgYoCIIlXr+jxh5LNPZuQnQauBsIT5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=D/ehsvyZ; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=MEhEUf/tPGvwFQpNcJhjrz+DUNR9MzrDWYPgGAIfhSw=; b=D/ehsvyZSXTGsfhOLSec4WnbOt
	VBL73dBoIyN6RSR4OWhbRfW8gcM7p7YRKKjqZq2vu9oNba5w0YnvmLMpqPpb7hw63t/gBmMrINKR/
	jNGpa93bSDsn8kuWkH6oIxG0wEsaQa7SL4S2EwHjxdHEtu4PzF61DeEoU7IZrdBIUAHQSnUosS7G1
	3zc95spJIh0UOG4FQnJ9RrwJLdwI3Zi9FQri7BGpNUDecNSgDdhFMox3wqzBn5LX54R3vU04P1BXS
	/e20lGmHG9GXEfGye5DK6jskYAaYJ3MrrYKiOQbVN//u42slAg0zZCeIArT645N67BI/3Mpu+YfBd
	nNfIMxOg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sAVm5-0004KG-Kl; Fri, 24 May 2024 16:20:01 +0200
Received: from [178.197.248.14] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sAVm5-000OOy-0J;
	Fri, 24 May 2024 16:20:01 +0200
Subject: Re: [PATCH bpf 3/5] netkit: Fix syncing peer device mtu with primary
To: Nikolay Aleksandrov <razor@blackwall.org>, martin.lau@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, Joe Stringer <joe@cilium.io>
References: <20240524130115.9854-1-daniel@iogearbox.net>
 <20240524130115.9854-3-daniel@iogearbox.net>
 <984f7580-890d-4644-b8ad-144505a882e4@blackwall.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <b6465a83-0aae-72be-5050-f9de85d3bf31@iogearbox.net>
Date: Fri, 24 May 2024 16:20:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <984f7580-890d-4644-b8ad-144505a882e4@blackwall.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27285/Fri May 24 10:30:55 2024)

On 5/24/24 4:15 PM, Nikolay Aleksandrov wrote:
> On 5/24/24 16:01, Daniel Borkmann wrote:
>> Implement the ndo_change_mtu callback in netkit in order to align the MTU
>> to the primary device. This is needed in order to sync MTUs to the latter
>> from the control plane (e.g. Cilium) which does not have access into the
>> Pod's netns.
>>
>> Fixes: 35dfaad7188c ("netkit, bpf: Add bpf programmable net device")
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>> Cc: Joe Stringer <joe@cilium.io>
>> ---
>>   drivers/net/netkit.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
> 
> This one has unexpected behaviour IMO. If the app sets the MTU and we
> silently overwrite, then it may continue working and thinking the MTU
> was changed leading to unexpected problems. I think it'd be better to
> keep the MTU synced explicitly (e.g. when set on main device, then
> set it on peer as well) and error out when trying to set it without
> the proper capabilities.

Makes sense, I'll look into this, thanks Nik!

