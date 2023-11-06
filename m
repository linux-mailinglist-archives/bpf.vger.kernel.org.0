Return-Path: <bpf+bounces-14340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3D67E318F
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 00:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B604A280DFE
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 23:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B7E2FE23;
	Mon,  6 Nov 2023 23:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Uo2+nLFF"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD6527452;
	Mon,  6 Nov 2023 23:44:39 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B958F;
	Mon,  6 Nov 2023 15:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=tTRXSb5yDpYYXh61it1fVTSb5GgfoqgJPrGpV5LUfTg=; b=Uo2+nLFFtj3kf3LQ9XHtnsySQs
	Urp4Z3VItQAOTQ1QQp3KwNo1xw0T7FvBc4tbHYId5QCueUGooC728dBubP8PsQ3bVE6XsE7JGZ7pC
	psVNxpdMA3vxBWKNPof2yObIn6aJoNzcmzlyHy3OwCF+TgLRuN8iS2KEp5aQHfht9GMfysy3v8SjY
	u0/SHrwm1FL/Jd02mWXFpZBWBbtu401YlnU+ZvtzgPZN3nnfQUafWlPNp+g1qsC5WWAwbZRV3Fcol
	tRz7WlyJyOAdBF/cI1ltSeEMbL/0f04yP6oYeF/DnAZe2tayTZVqPkbOvhkiMhjs7Wia+rlNLO9Y3
	lGphUOgg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1r09Gl-000CPq-MH; Tue, 07 Nov 2023 00:44:35 +0100
Received: from [194.230.147.75] (helo=localhost.localdomain)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1r09Gl-000MYv-5A; Tue, 07 Nov 2023 00:44:35 +0100
Subject: Re: [PATCH bpf 4/6] bpf, netkit: Add indirect call wrapper for
 fetching peer dev
To: Jakub Kicinski <kuba@kernel.org>
Cc: martin.lau@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 Nikolay Aleksandrov <razor@blackwall.org>
References: <20231103222748.12551-1-daniel@iogearbox.net>
 <20231103222748.12551-5-daniel@iogearbox.net>
 <20231106133250.0d49a487@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <b2e12d85-4a45-e6a9-ac3f-aa932c5cf79b@iogearbox.net>
Date: Tue, 7 Nov 2023 00:44:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231106133250.0d49a487@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27085/Mon Nov  6 23:37:38 2023)

On 11/6/23 10:32 PM, Jakub Kicinski wrote:
> On Fri,  3 Nov 2023 23:27:46 +0100 Daniel Borkmann wrote:
>> ndo_get_peer_dev is used in tcx BPF fast path, therefore make use of
>> indirect call wrapper and therefore optimize the bpf_redirect_peer()
>> internal handling a bit. Add a small skb_get_peer_dev() wrapper which
>> utilizes the INDIRECT_CALL_1() macro instead of open coding.
> 
> Why don't we kill the ndo and put the pointer in struct net_device?

I can take a stab at this some time after LPC and probably makes sense
also after Coco's cacheline optimizations landed.

Thanks,
Daniel

