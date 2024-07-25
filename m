Return-Path: <bpf+bounces-35616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DB293BFB1
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 12:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9812B2217F
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 10:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07292198A3B;
	Thu, 25 Jul 2024 10:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="eWAox3aU"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D28198A10;
	Thu, 25 Jul 2024 10:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721901999; cv=none; b=F35e6QZNg6yGWw4SlCbiHtIqQhz7Sjf1MrvPLNc4I8NTAsoZmnXjO3tPsPLRQJvrmwldiVVIdCkx5wAoc2naH021CjMEcKCzUYaEkJrjOBA8jwZ/Ch2fN6T6JPyuMhCE5eAWRQSiHmVe8ayae4ID9WYcmBM5W7jFMA8NDAtCoDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721901999; c=relaxed/simple;
	bh=y3SzuDLuN3SD8cshoI2kRhdkI0fGgKaJMvIy2WeNvfk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=c7gWB7zF2coguFOo+x1GMaVsXSib3HuEwpP1zkPJmCtJKwZFZf/2Q4ZPbIa+Y73Q+0iNHWr7W7xrGVdXUYqUPKsI+OaiG1X/Nfj2KGgHarhhia8QHeiBG/mK7NUVFpc7bIsOgLjdsjmOo4iWK2o2KWgWASN8TKSyaVoT6NI7VVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=eWAox3aU; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=twcHJYaQHj1ZnBWPjAKSfpapMe9QUdtveRxFV8eT7Dc=; b=eWAox3aUtXVRJFodtyRK1M6ZOQ
	JUqMdY4UxE4si5ShUPxnUh+gYILcPaVZsvaSIGh1QkiTXoIvVues91ffLqzFYSYBULK5bm2YsRI6B
	tkoUF9CAm8LqUTrkKX6uFubkUtG+ykmrBnCudhnl+vcxtoHsmnrBlHSyAO7eJyNU+sEe1HbWAyF7M
	trgJiW8s70mlxuUcwk+90ONx4uEn+VhjJJe0I9jmZgqL85m0Szv4F5vR2oBPlNIGyJQSByJpsArDM
	pNYPGtbFhAHNb2dRaLh8knXBfTnyhVjZpZg3F/za4ZvwRMrlz7s4CiEZyT0WZ1SUSiQC8MgXAPRew
	XmcgjHNw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sWvMe-000PiP-Nd; Thu, 25 Jul 2024 12:06:24 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sWvMe-000C4y-0t;
	Thu, 25 Jul 2024 12:06:23 +0200
Subject: Re: [PATCH bpf 0/3] xsk: require XDP_UMEM_TX_METADATA_LEN to actuate
 tx_metadata_len
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Stanislav Fomichev <sdf@fomichev.me>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, Julian Schindel
 <mail@arctic-alpaca.de>, Magnus Karlsson <magnus.karlsson@gmail.com>
References: <20240713015253.121248-1-sdf@fomichev.me> <ZqEcim8E0qK8MRQO@boxer>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f30e6532-28e3-dca8-1274-e6b31531b84e@iogearbox.net>
Date: Thu, 25 Jul 2024 12:06:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZqEcim8E0qK8MRQO@boxer>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27347/Thu Jul 25 10:27:42 2024)

On 7/24/24 5:23 PM, Maciej Fijalkowski wrote:
> On Fri, Jul 12, 2024 at 06:52:50PM -0700, Stanislav Fomichev wrote:
>> Julian reports that commit 341ac980eab9 ("xsk: Support tx_metadata_len")
>> can break existing use cases which don't zero-initialize xdp_umem_reg
>> padding. Fix it (while still breaking a minority of new users of tx
>> metadata), update the docs, update the selftest and sprinkle some
>> BUILD_BUG_ONs to hopefully catch similar issues in the future.
>>
>> Thank you Julian for the report and for helping to chase it down!
>>
>> Reported-by: Julian Schindel <mail@arctic-alpaca.de>
>> Cc: Magnus Karlsson <magnus.karlsson@gmail.com>
> 
> For the content series,
> 
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> However I was not sure about handling patch 3/3.

Ok, then I'm taking in the first two for now as they seem to actually
address the fix and the 3rd seems like an improvement which could also
get routed via bpf-next. In either case, if one of you could follow-up
on the latter, that would be great.

Thanks,
Daniel

