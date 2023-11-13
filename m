Return-Path: <bpf+bounces-14992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE5D7E9CB5
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 14:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07651F20F2E
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 13:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D161DDE9;
	Mon, 13 Nov 2023 13:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="gn59903S"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444331C6AB;
	Mon, 13 Nov 2023 13:04:21 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8CD171A;
	Mon, 13 Nov 2023 05:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=/Gb3y5AJkHr5bVZJk5oNYpmoITSyFTVmd+9XOWJkguc=; b=gn59903SZ3oCT38rYL2beWo3Gk
	lbKqsUaOF6UlnU4hF2p9pZhsJWbqK2pI81Ixd/OLLnJ/nsy7RqJyniZJfGSHV0aVPSjzLpLXUY1df
	JXy4cpFvhwzPLIXg+54A9EfKVsMeAS44mx/uJGqx7tOtksdOAihmoemJxmL63rOxxE05vfT4DJwSk
	jtHnGHeRmXzuSTexyk1eEMDLB0FTRhocmSMaBDfM635lwb48ATDz7vZysPu4vzBo0DHLVI2MXGCdW
	qcQStxrBsZ5L475mVOsNHCLp0cf9smVwRYHfAjZFBFfFzVxpuMxp4qT1GnFOlROmOcpRZ+xx8EWvS
	JVkkzJng==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1r2Wbs-0005tM-Oy; Mon, 13 Nov 2023 14:04:12 +0100
Received: from [194.230.158.57] (helo=localhost.localdomain)
	by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1r2Wbs-000X3e-3P; Mon, 13 Nov 2023 14:04:12 +0100
Subject: Re: [PATCH bpf v2 2/8] net: Move {l,t,d}stats allocation to core and
 convert veth & vrf
To: Simon Horman <horms@kernel.org>
Cc: martin.lau@kernel.org, kuba@kernel.org, razor@blackwall.org,
 sdf@google.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
 David Ahern <dsahern@kernel.org>
References: <20231112203009.26073-1-daniel@iogearbox.net>
 <20231112203009.26073-3-daniel@iogearbox.net>
 <20231113095744.GN705326@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2afc248b-4218-2812-77e8-926065fa647f@iogearbox.net>
Date: Mon, 13 Nov 2023 14:04:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231113095744.GN705326@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27092/Mon Nov 13 09:38:20 2023)

On 11/13/23 10:57 AM, Simon Horman wrote:
> On Sun, Nov 12, 2023 at 09:30:03PM +0100, Daniel Borkmann wrote:
>> Move {l,t,d}stats allocation to the core and let netdevs pick the stats
>> type they need. That way the driver doesn't have to bother with error
>> handling (allocation failure checking, making sure free happens in the
>> right spot, etc) - all happening in the core.
>>
>> Co-developed-by: Jakub Kicinski <kuba@kernel.org>
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>> Cc: David Ahern <dsahern@kernel.org>
> 
> ...
> 
>> @@ -2354,6 +2361,7 @@ struct net_device {
>>   	void				*ml_priv;
>>   	enum netdev_ml_priv_type	ml_priv_type;
>>   
>> +	enum netdev_stat_type		pcpu_stat_type:8;
> 
> Hi Daniel,
> 
> nit: Please consider adding documentation for this new field to
>       the kernel doc for net_device.
> 

Will add, thanks Simon!

