Return-Path: <bpf+bounces-33067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F742916D52
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 17:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A18E81C2104F
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 15:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AA516F919;
	Tue, 25 Jun 2024 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="oMyiIpDa"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A8016F910;
	Tue, 25 Jun 2024 15:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719330146; cv=none; b=ZV8C4mtVy2j+BpLRBm+n0AtLcKPnmoA/rOHVArUpQoAUOvt3raXUu9po2b0uj7+b6trTiwWSmO886utrHzFvM3Sn/7olOWgmjxtULrsEUY2v3It4APRcypbgol9ZVqW2STm4k0MNdaAURGY48V2UcBqtB6RFcK/joQtkwJJ1fzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719330146; c=relaxed/simple;
	bh=hz3w6Eklm/Nz6n7Vd/6BlWpMBvlf8tzDrXf5RlN6yME=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=SpDL0/lh12nms4V2OcYdxl2b6E+snPSmqKW0SdU0zHNnzWBYld7zen0HdK4NRdLqxqZLm3Rig13pCTdkGZ0fzUDdmZfnOKcNWnoUPNb+quzfyT2FOky12DCYLMa8MMeDHvW07iN9aVKOZsk7mjI0SV8q0QFHf/b+lpIKvaGnSwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=oMyiIpDa; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=wEMKFCkO5KHUbx0/Aw9+6F3ykpPS3mx2D9EjOcoDxSU=; b=oMyiIpDaZL1ih0W9bmC82tquRg
	tgBL6wkswu0lT3q7j9cwkhH9cpB4PJCMLWusSAutNFqXjNNEGJIgr9lLMoqFP3kaGe+ZXZdbQStxU
	jf7gsX0e31q76/7TFg2X4YV1/TloRbIT6IUYOHK+SFqhAnwBUNHnuNI4oN5zLfBp3pbgpYkYKsmML
	Q3T9tw7aJZHx1GwbjBe3Jh54xpcBfogTc/vXTvbbuwQg216lReVzyGB/eY9anrCiXzuoG5OKX022D
	obQASr9IhhUJz3SBWGkhqPxM62rmy4radGob1iEPboGNmdLbM0yNl2eeT4OebddPPgRRB7ENu0H9V
	78A7kBvA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sM8Iz-000OUR-KB; Tue, 25 Jun 2024 17:42:01 +0200
Received: from [178.197.249.38] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sM8Iz-000Mkz-20;
	Tue, 25 Jun 2024 17:42:01 +0200
Subject: Re: pull-request: bpf 2024-06-24
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20240624124330.8401-1-daniel@iogearbox.net>
 <20240624184126.33322abe@kernel.org>
 <c2119e37-4ce4-bf9b-61c2-1728c7c2b0ce@iogearbox.net>
 <20240625071314.00fdb459@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <3013a164-7cf7-0bdb-6248-58c0816a92c2@iogearbox.net>
Date: Tue, 25 Jun 2024 17:42:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240625071314.00fdb459@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27317/Tue Jun 25 10:26:12 2024)

On 6/25/24 4:13 PM, Jakub Kicinski wrote:
> On Tue, 25 Jun 2024 09:46:39 +0200 Daniel Borkmann wrote:
>> On 6/25/24 3:41 AM, Jakub Kicinski wrote:
>>> On Mon, 24 Jun 2024 14:43:30 +0200 Daniel Borkmann wrote:
>>>> The following changes since commit 143492fce36161402fa2f45a0756de7ff69c366a:
>>>>
>>>>     Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue (2024-06-14 19:05:38 -0700)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>     ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/for-netdev
>>>
>>> Bot seems to not be responding, so: pulled, thanks!
>>>
>>> BTW was the ssh link intentional?
>>
>> Yes at least from what I read at users@k.o the recommendation / preference is
>> to use the gitolite link so that you as kernel.org user do not get artificially
>> throttled when pulling.
> 
> Hm. Wasn't there some suggestion for people to locally have a rule to
> replace links if they want that? The SSH link is impossible for bots to
> pull. I guess I could sprinkle regexps in all the bots but that sounds
> like a pain. And TBH I've personally never experienced the throttling
> issues K mentioned, so I see no upside :(

Ok, no problem at all, next ones will go back to old url.

Thanks,
Daniel

