Return-Path: <bpf+bounces-15999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7677FAAB5
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 20:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B4582819D3
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 19:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D4C45968;
	Mon, 27 Nov 2023 19:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="IPNyHH5D"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B39B8;
	Mon, 27 Nov 2023 11:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=usS9ox2nXZXsH1MHThmvBPqOo6Cn1A8VfOfzHEuSBCU=; b=IPNyHH5DVernwQo2dHdugSKaWr
	qX1TEm19k6V/StzJsj/0BT5J8JuuYHgcnSsxg5jTVrI0KbFOQznlJMCZBLoq9s62tgHUkHuixk9RK
	IOaoMCdR7fleCO4rLH+MsyrsFULBI3S0y4HG/wISdC5QBcHf53pE4FeAbraquZA9rL1cL3LIXLrPa
	Imw1QFeXsT2EC80ZuK/jFsDl6sjPlUvQH7u3S9wL+wuL6JI1CCtxql/cawOUD799nR3N2M2seVM6a
	aNM6Q00ulBDIbGOku1Wq+QRy+PGggsPRlrmO8pmj+G3BHjlHC3tFdLBG7QmR6d9W2txPtDkFRRUIV
	hrSTY7zQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1r7hjL-0008hw-FH; Mon, 27 Nov 2023 20:57:19 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1r7hjL-000Nq3-61; Mon, 27 Nov 2023 20:57:19 +0100
Subject: Re: [PATCH bpf] netkit: Reject IFLA_NETKIT_PEER_INFO in
 netkit_change_link
To: Jakub Kicinski <kuba@kernel.org>
Cc: martin.lau@linux.dev, razor@blackwall.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20231127134311.30345-1-daniel@iogearbox.net>
 <20231127102224.2b43b14f@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <64a86595-0b4f-35ef-b3a2-6ca6422f4b91@iogearbox.net>
Date: Mon, 27 Nov 2023 20:57:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231127102224.2b43b14f@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27106/Mon Nov 27 09:39:12 2023)

On 11/27/23 7:22 PM, Jakub Kicinski wrote:
> On Mon, 27 Nov 2023 14:43:11 +0100 Daniel Borkmann wrote:
>> +	if (data[IFLA_NETKIT_PEER_INFO]) {
>> +		NL_SET_ERR_MSG_ATTR(extack, data[IFLA_NETKIT_PEER_INFO],
>> +				    "netkit peer info cannot be changed after device creation");
>> +		return -EACCES;
>> +	}
> 
> Why EACCES? It doesn't have much to do with permissions and all netlink
> validation errors use EINVAL. IMO this is a basic case of "attribute
> not defined in the policy", NLA_REJECT, so EINVAL..

Ok, sounds good, will use EINVAL instead in a v2.

