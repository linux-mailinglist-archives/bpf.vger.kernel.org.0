Return-Path: <bpf+bounces-34742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DF7930742
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 22:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 046341C20C02
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 20:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C9614430C;
	Sat, 13 Jul 2024 20:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="rfoJMwMq"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B9C13BADF
	for <bpf@vger.kernel.org>; Sat, 13 Jul 2024 20:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720901786; cv=none; b=GrgpN8vBlaHRE+Xo1LMNupLiV5yOCqkxwaGZjpT0GeMn9n2r9aXzh3JyjUPTkD1qOBbCw/WsjVVfMtwGgeBxng2FNdcFtGpffpLogxo5r9AK5LilZqwQGjgRK6B4+yOJLGFtJozQ99Dh2jVfYl+SHDJLjcJ04Vpj0uYEn0lmhZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720901786; c=relaxed/simple;
	bh=ClZ7AG4xU4Ukp4yEHDHUKc5DNptZw99THQHfpiQrTlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GRQAV+kb4+hZ89awmCz08UlEJfZkJ0oOPrRFPZf15fOo2tyRMyrQjTMVI3GdUC2b+BM+IotBlKR2VfkfiVKguc5i/VX2ICQFT8dCyGZCLYp2g+qCeGKbRB6sC9YZQ5kbTO9IAjbZ36ukMpjhEybmDPMmGsuqiFbvRzHvU4rR00E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=rfoJMwMq; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sSjAK-00FckX-7Y; Sat, 13 Jul 2024 22:16:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=4dkLoAp97793/6ouq//wGoeXYxq0DtNAndwdu6P9s90=; b=rfoJMwMqgx4CfBIkcifRcZcpXB
	GUhz96/FS+12OATdB1TDgZqPzxDpNPAm+bcd8zCTR5SLzUrf2BnI+CTQV/YIK7veAT8WeLZjKaVTj
	yDD2l03cZvjgiP2akL/Q4X6trOySB0MqrnrLNi4XzCyDLRUCoPYDwZdRJ5pxFfbP8W/T/vER3/gM0
	WCYbgnXzB9Y1dHpk6naLtAT7I6BGpaZ1yaVgCQQOTbqE/2JJUoJl/MQ22gWiI19Kq3wlEO/CnfpwX
	fIm9PFp9rxAVgTcpTP851YCfP+m1L1bAngF9XbXlp5mgtNiQv+4wEz24jiavx7SceZeJzeTQTbb6V
	fAmRqN3w==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sSjAI-0007oq-PZ; Sat, 13 Jul 2024 22:16:18 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sSjAC-00Fu18-M6; Sat, 13 Jul 2024 22:16:12 +0200
Message-ID: <a4edd3d6-4cad-4312-bd20-2fb8d3738ad6@rbox.co>
Date: Sat, 13 Jul 2024 22:16:11 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 2/4] selftest/bpf: Support SOCK_STREAM in
 unix_inet_redir_to_connected()
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 john.fastabend@gmail.com, kuniyu@amazon.com, Rao.Shoaib@oracle.com,
 cong.wang@bytedance.com
References: <20240707222842.4119416-1-mhal@rbox.co>
 <20240707222842.4119416-3-mhal@rbox.co> <87zfqqnbex.fsf@cloudflare.com>
 <fb95824c-6068-47f2-b9eb-894ea9182ede@rbox.co>
 <87ikx962wm.fsf@cloudflare.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <87ikx962wm.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/13/24 11:45, Jakub Sitnicki wrote:
> On Thu, Jul 11, 2024 at 10:33 PM +02, Michal Luczaj wrote:
>> And looking at that commit[1], inet_unix_redir_to_connected() has its
>> @type ignored, too.  Same treatment?
> 
> That one will not be a trivial fix like this case. inet_socketpair()
> won't work for TCP as is. It will fail trying to connect() a listening
> socket (p0). I recall now that we are in this state due to some
> abandoned work that began in 75e0e27db6cf ("selftest/bpf: Change udp to
> inet in some function names").

I've assumed @type applies to AF_UNIX. So I've meant to keep
inet_socketpair() with SOCK_DGRAM hardcoded (like it is in
unix_inet_redir_to_connected()), but let the socketpair(AF_UNIX, ...)
accept @type (like this patch does).

> If we bundle stuff together then it takes more energy to push it through
> (iterations, reviews). I find it easier to keep the scope down to
> minimum for a series.

Sure, here's a respin keeping number of patches to a minimum:
https://lore.kernel.org/netdev/20240713200218.2140950-1-mhal@rbox.co/

