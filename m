Return-Path: <bpf+bounces-38881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B821D96BEE6
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 15:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E970B1C24901
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 13:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074221DB557;
	Wed,  4 Sep 2024 13:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Q64chWw4"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483301DB548;
	Wed,  4 Sep 2024 13:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457342; cv=none; b=jw93kN8ae8pNRrMM/xDxv4D+VeKvx+TOyylNndZjEjGE/EpRYO8gc5RKBnVyxAoIR8iw4jP8vKQQYIWJo0cXefLdTtC0HExrDPyWi21ppd8M6a5fS8nStfr9krzG0mzNJBzcA83IDxB1R3j0G7v//UDcJ0nV2Oj5GmBZ1/IlB6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457342; c=relaxed/simple;
	bh=/ASzd69U6wRR3J6nwKrp2KtuXXCDimEVnLY/BH6+n0I=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GhumZCG3mjBow4Cg8IEEgvzPS/3dFYPYmqZvrPe1Gy0bWudFmo2tOKrYma7Or1LDY91jy/evQ93dFNt+iAXCxRRLo5zsJtxg7noZSQ+zafuyz+WARJRnue3e9tTgxsJNr5iZxgYcO36n6MJqNIbmGO7reNj/NWhqen2qu2hvvbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Q64chWw4; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=fSkK2piQ4rboJn90vKCg9mac7yDzQYDkwnHIjj5VeI0=; b=Q64chWw4NrXidkFd4ARo43LdHS
	cwubMw14ms9a0Fxxy6ib7X7oL2i9DNFJeSHWTECAAzZz12i9YM6ATYn1Kxk27zyJpK4AYvrKn1/ct
	QKLqn50uAi+/vB+9xan7zyG74DG1ZiEY3HwNSND1vuFxyQtiVwhDLthk1J4cF2ogxW6hP7cXl/o5i
	4Gb0TmV49UocWt7RRMzmylGQ2OWvk022XcrD8wVH/8o7YBzgULFKNi6HZoGadLQkhfW4VD4xcyupU
	bEcsLP9cZ+exfAfnWznAhT6gYdqUWHReV5uJIcLyLYT2Pe12mlNcArlSWhWWlcs3MAN291Vjp6YVc
	dwM/ja1Q==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1slqGi-000781-9J; Wed, 04 Sep 2024 15:41:56 +0200
Received: from [178.197.248.23] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1slqGh-0005Zy-36;
	Wed, 04 Sep 2024 15:41:55 +0200
Subject: Re: linux-next: manual merge of the bpf-next tree with the net-next
 tree
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, bpf <bpf@vger.kernel.org>,
 Networking <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240904120221.54e6cfcb@canb.auug.org.au>
 <4ede8b00-aab9-4be6-a589-98cc0d98b929@intel.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2444df33-cd03-a929-9ce8-3cf1376d3f78@iogearbox.net>
Date: Wed, 4 Sep 2024 15:41:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4ede8b00-aab9-4be6-a589-98cc0d98b929@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27388/Wed Sep  4 10:40:46 2024)

On 9/4/24 3:16 PM, Alexander Lobakin wrote:
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Wed, 4 Sep 2024 12:02:21 +1000
> 
>> Hi all,
>>
>> Today's linux-next merge of the bpf-next tree got a conflict in:
>>
>>    drivers/net/netkit.c
>>
>> between commit:
>>
>>    00d066a4d4ed ("netdev_features: convert NETIF_F_LLTX to dev->lltx")
>>
>> from the net-next tree and commit:
>>
>>    d96608794889 ("netkit: Disable netpoll support")
>>
>> from the bpf-next tree.
>>
>> I fixed it up (see below) and can carry the fix as necessary. This
>> is now fixed as far as linux-next is concerned, but any non trivial
>> conflicts should be mentioned to your upstream maintainer when your tree
>> is submitted for merging.  You may also want to consider cooperating
>> with the maintainer of the conflicting tree to minimise any particularly
>> complex conflicts.
> 
> Your fix is technically correct, but maybe swap the lines?
> 
>   	dev->priv_flags |= IFF_NO_QUEUE;
> +	dev->priv_flags |= IFF_DISABLE_NETPOLL;
> +	dev->lltx = true;
> 
> Looks more natural I'd say...

Yep, 100%, we'll use that as merge conflict resolution when flushing the
next PR, thanks!

