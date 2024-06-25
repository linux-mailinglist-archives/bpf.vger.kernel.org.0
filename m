Return-Path: <bpf+bounces-33027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8439091604A
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 09:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B43C01C22084
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 07:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE21147C7F;
	Tue, 25 Jun 2024 07:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Kj/GokB3"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C0F1459F1;
	Tue, 25 Jun 2024 07:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719301616; cv=none; b=umWP1L2ElbhaRnylNH/mkFS9mC6PRAtAbmk87C16PyTgOqsFmTGb4RvADqazSKzmcYaNHbUb66r6a+RWOE1ZEpqfPTApyVDhuO0IhNKAbY+vH4w681B2x+Zi9AMhXjbuemav/mt0hS96kRLZTFh9mz0x/cNhcLalbQtIdhvsx/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719301616; c=relaxed/simple;
	bh=BD8/Ei64+i+bfhdQKuz6XDa7OaSkSlG/6wY6L3GttBM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Aii5wOfgdljEhCW+754BQeMGuGDExgsuhVGEvfVTS0cmxwGNzffp3L4IyEoc6ZfYw4xLn5OYvpSF7jZuxkPnRhQD1OMXWRuAY92LBlhtgHPiafbD9U5MSA7VUUYALI9p+IBPWk+9TH29KgAy2bcWNxnZAFuCk2l2A9eL2oXq8xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Kj/GokB3; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Kqt2HW3DF4THvQrzoJ54QdPTPzFW/ucTd0Pmt1RUFE4=; b=Kj/GokB33PoK0iEPvjrBTzyCGh
	ZhNu1yBWvyMpy/Jh3+4MnNZf7k8F7RiN8gR6ZgpLCG1vYWNNV8hl67OVTZDY3VKGR5QTuY2uz69do
	6aL0HNC2GhMs4DvAQPyjmXwiklM5863HmVk/yygbHgs7w2Qu5/NHeJ2macCHFOfJ7QTEawpMMbrAm
	s1UuZl3qJ46jbbIwJbHfJOoTz3zbK21EbKsvztWx0HNwp3nPk9plP/7f1yLVn3hu6odBTTX2vubfG
	TbybTHyb9wNAVjXm2rYPM57cl7iZJCUyqInftcdKMeWTlg/IobkxUZ70QL9rz0r5xr85Me7XoHN2Z
	KIjiKJig==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sM0sy-000GZj-AL; Tue, 25 Jun 2024 09:46:40 +0200
Received: from [178.197.249.38] (helo=linux.home)
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sM0sx-0009sP-1c;
	Tue, 25 Jun 2024 09:46:39 +0200
Subject: Re: pull-request: bpf 2024-06-24
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20240624124330.8401-1-daniel@iogearbox.net>
 <20240624184126.33322abe@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c2119e37-4ce4-bf9b-61c2-1728c7c2b0ce@iogearbox.net>
Date: Tue, 25 Jun 2024 09:46:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240624184126.33322abe@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27316/Mon Jun 24 10:26:29 2024)

On 6/25/24 3:41 AM, Jakub Kicinski wrote:
> On Mon, 24 Jun 2024 14:43:30 +0200 Daniel Borkmann wrote:
>> The following changes since commit 143492fce36161402fa2f45a0756de7ff69c366a:
>>
>>    Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue (2024-06-14 19:05:38 -0700)
>>
>> are available in the Git repository at:
>>
>>    ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev
> 
> Bot seems to not be responding, so: pulled, thanks!
> 
> BTW was the ssh link intentional? 

Yes at least from what I read at users@k.o the recommendation / preference is
to use the gitolite link so that you as kernel.org user do not get artificially
throttled when pulling.

Thanks,
Daniel

