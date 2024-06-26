Return-Path: <bpf+bounces-33146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB74917DAC
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 12:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E8B81C2331B
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 10:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4CB17836D;
	Wed, 26 Jun 2024 10:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="SiB/4EjP"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E95716089A;
	Wed, 26 Jun 2024 10:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397173; cv=none; b=nlPWfHb9rormog5Ozh+l/FMNdcArCocyNjf5UXkuZXLCHYvVW1RWXOHx6fW7VXJevvnbYfIu6qh5uR7IZAxG0bHENlQwNW8p/iv8B8WeiTIsPe/6HJIebezBxTUmiLykQgc1V8jY1xthHsitaouGoPPlcfpfuA94hqDRAbI3El4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397173; c=relaxed/simple;
	bh=/oKe8DGBAK2zHKp8sBbK+/UsJGH4xJj88ToZotWEP54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QjAaayeygghs2EUdubqen8L35uffLjLgY2Auo1uL++54XR3PdM6edIzK0jwTw2BIxfi2njlcf9clR1B+1txRWjuS/wrPzq8QZX9AqmjglZPXHNcTpdbEUcYYOqtkJF4d+7Jv/lpYeunGC4Spgxx9G1aae+zlSECJAAtvZDaJdTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=SiB/4EjP; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sMPkC-0018TA-EY; Wed, 26 Jun 2024 12:19:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=Rd95deg4ws5WyPay06/NgAZyi672fmi49w8nadwDQC4=; b=SiB/4EjP+DKNQjZ7hJnCyWArQ6
	RgnQxKQkXayjrMgUMs+wRSovOg+xo+VOIc8U7ecL3lABcoNWojGqf0t9gXJNnptCDtwe48hNNmvuk
	6/vPA4HFqqKXmPT7nGkd1S1xjUfw4e7MpC8SPs/0StwZkSMFBW58ZJDH+oVIaAM91eFJPW3QP8/MF
	vf2cgaI+RshvGHVN0fHLW7JDGgcDpCdOKygXW7sVZA0cnG/v72H5ggVfc4uCT87EDZP1qcmUhwYAO
	xmLbhNvEBOqaBsIAtzLfUSj3KlZRG20TNzLlc5ELxyo0IE71Wt+vxOg+dHG30CbllxcDQ7nwI1Prw
	rv2Oc7IQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sMPkB-0005st-FC; Wed, 26 Jun 2024 12:19:15 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sMPjy-005moN-Dn; Wed, 26 Jun 2024 12:19:02 +0200
Message-ID: <2301f9fb-dab5-4db7-8e69-309e7c7186b7@rbox.co>
Date: Wed, 26 Jun 2024 12:19:01 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2] af_unix: Disable MSG_OOB handling for sockets in
 sockmap/sockhash
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 john.fastabend@gmail.com, kuniyu@amazon.com, Rao.Shoaib@oracle.com,
 Cong Wang <cong.wang@bytedance.com>
References: <20240622223324.3337956-1-mhal@rbox.co>
 <874j9ijuju.fsf@cloudflare.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <874j9ijuju.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/24/24 16:15, Jakub Sitnicki wrote:
> On Sun, Jun 23, 2024 at 12:25 AM +02, Michal Luczaj wrote:
>> AF_UNIX socket tracks the most recent OOB packet (in its receive queue)
>> with an `oob_skb` pointer. BPF redirecting does not account for that: when
>> an OOB packet is moved between sockets, `oob_skb` is left outdated. This
>> results in a single skb that may be accessed from two different sockets.
>>
>> Take the easy way out: silently drop MSG_OOB data targeting any socket that
>> is in a sockmap or a sockhash. Note that such silent drop is akin to the
>> fate of redirected skb's scm_fp_list (SCM_RIGHTS, SCM_CREDENTIALS).
>>
>> For symmetry, forbid MSG_OOB in unix_bpf_recvmsg().
>>
>> Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>> Fixes: 314001f0bf92 ("af_unix: Add OOB support")
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> ---
> 
> [+CC Cong who authored ->read_skb]
> 
> I'm guessing you have a test program that you're developing the fix
> against. Would you like to extend the test case for sockmap redirect
> from unix stream [1] to incorporate it?
> 
> Sadly unix_inet_redir_to_connected needs a fix first because it
> hardcodes sotype to SOCK_DGRAM.

Ugh, my last two replies got silently dropped by vger. Is there any way to
tell what went wrong?

So, again, sure, I'll extend the sockmap redirect test.

And regarding Rao's comment, I took a look and I think sockmap'ed TCP OOB
does indeed act the same way. I'll try to add that into selftest as well.

Thanks,
Michal


