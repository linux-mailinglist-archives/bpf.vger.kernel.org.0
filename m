Return-Path: <bpf+bounces-11516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C11BC7BB1E1
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 09:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 817B11C20A83
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 07:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D383A63AC;
	Fri,  6 Oct 2023 07:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lambda.lt header.i=@lambda.lt header.b="UD0mx94y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FQSbOWxk"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B7815C2;
	Fri,  6 Oct 2023 07:03:44 +0000 (UTC)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C32CA;
	Fri,  6 Oct 2023 00:03:40 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 1F9D75C0293;
	Fri,  6 Oct 2023 03:03:37 -0400 (EDT)
Received: from imap43 ([10.202.2.93])
  by compute6.internal (MEProxy); Fri, 06 Oct 2023 03:03:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lambda.lt; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1696575817; x=1696662217; bh=bt
	MfA+AQqdUf5qSGmnqHobgcF7LohSfluXzU2RCAbmA=; b=UD0mx94yiUdBcoPRmG
	KnBnHZh7oPw5w1wpinJhoq3iemyhVNiwJowaXOpWhKB9e34C1W9/qGv1ip7PDwmD
	hHKt9Qg4VXZQaxyDNugOGabBO1hHzk2yyTJEaEQczvQUVZqa+sjxxiYLkgYLTNeb
	kLM+p+ssGuYI4mZsv6/nqY6gYiq1ibUoUT2P8w+3ZxcqYS51z/P+MAuuXvEPwvPz
	9SufwIMXOf8lcuTD++bifWi9BzgKetDqBXdDJ8gTSEgpco1Uk5TUR7VNRTQXfUGm
	gmY98AukhI/QQvFa4CSLRwUUWeXQlXY0HuMOBluCY/uIDakekvI+moF5iUx+tj61
	N3JA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1696575817; x=1696662217; bh=btMfA+AQqdUf5
	qSGmnqHobgcF7LohSfluXzU2RCAbmA=; b=FQSbOWxkXWD8QalB/+/PfMmQ2EgJx
	e9/aaZ3iryQrb+mxgjnYcbKealqsufgqFS5YjD56S9lRRVHXohrIyxgl7Ws9zTIu
	21ZGTUqrWCVFavwR4CG0WWVBmT2JdjFi87wodCjX/DWjQkyTTYFG3BA1HcF68LFD
	guJ/HN793v/41ET5deYy8Ukj8nb99+5m6rdaeusOP2mfdLK4v7fshfMorlRTP5LU
	B/vCZ0bxW3Dbm7ZZMb64/7/0n9m7uAgE+h3fGQkZe2s1UNujsUDnKd/FNeZfg53W
	R1qfnYw0LFVNe6j+Uo4avfjarq/hxnWmV2VkzJ3NLV2TDE+e1glOkQsPw==
X-ME-Sender: <xms:SLEfZWwyWQnOaY7qEWIpHkGVRAjM6aQqCVUjvpzaao_x0NalzGd1WQ>
    <xme:SLEfZSSczYly4J1p6UusvHjaZIIGj587sXYnEki-xwi-xGPsg3jsRw5lrwDRRF5l7
    wU53XDgEo0i4do4xP8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgeehgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpeforghr
    thihnhgrshcuoehmsehlrghmsggurgdrlhhtqeenucggtffrrghtthgvrhhnpeduueekje
    effeejvdeitdevgfekjeegfeduueffveeikeeifeelffevieefueduieenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehlrghmsggurgdrlh
    ht
X-ME-Proxy: <xmx:SLEfZYUrZIc0uDooozAt42BArvy2EZHqhF-s_UXre5lzVHw1E6A33Q>
    <xmx:SLEfZchxP179WQgxFsLnWZIiSei9lAmMiKufbFTtl3I_lEpwuc04iA>
    <xmx:SLEfZYDm4LEJXW_ScSb9K03fruoMfNthSJLvlPBu9ooHokasCEeFzw>
    <xmx:SbEfZbNDciqu9QyiolMbMfie49Hj9GdctsXc4IFs31kFOjhPTUcO6A>
Feedback-ID: i215944fb:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A2BB32D43612; Fri,  6 Oct 2023 03:03:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <daa2a632-a100-4a34-9584-44506d6a39f0@app.fastmail.com>
In-Reply-To: <47294480-506a-e22e-7466-3cdc106c395e@linux.dev>
References: <20231003071013.824623-1-m@lambda.lt>
 <20231003071013.824623-2-m@lambda.lt>
 <5bef21a3-18c0-e335-d64e-bcd6f1e304a4@linux.dev>
 <e7b992e3-8059-4058-8561-cb017c200c8d@app.fastmail.com>
 <47294480-506a-e22e-7466-3cdc106c395e@linux.dev>
Date: Fri, 06 Oct 2023 09:03:01 +0200
From: Martynas <m@lambda.lt>
To: "Martin KaFai Lau" <martin.lau@linux.dev>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, netdev <netdev@vger.kernel.org>,
 "Nikolay Aleksandrov" <razor@blackwall.org>, bpf@vger.kernel.org
Subject: Re: [PATCH bpf v2 1/2] bpf: Derive source IP addr via bpf_*_fib_lookup()
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On Fri, Oct 6, 2023, at 8:29 AM, Martin KaFai Lau wrote:
> On 10/5/23 1:16 PM, Martynas wrote:
>>>> @@ -5992,6 +5995,19 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
>>>>    	params->rt_metric = res.f6i->fib6_metric;
>>>>    	params->ifindex = dev->ifindex;
>>>>    
>>>> +	if (flags & BPF_FIB_LOOKUP_SET_SRC) {
>>>> +		if (res.f6i->fib6_prefsrc.plen) {
>>>> +			*(struct in6_addr *)params->ipv6_src = res.f6i->fib6_prefsrc.addr;
>
> A nit. just noticed. Similar to the "*dst" assignment a few lines above:

SGTM.

>
> 			*src = res.f6i->fib6_prefsrc.addr;
>
>>>> +		} else {
>>>> +			err = ipv6_bpf_stub->ipv6_dev_get_saddr(net, dev,
>>>> +								&fl6.daddr, 0,
>>>> +								(struct in6_addr *)
>>>> +								params->ipv6_src);
>
> Same here. Use the "src".
>
>>>> +			if (err)
>>>> +				return BPF_FIB_LKUP_RET_NO_SRC_ADDR;
>>>
>>> This error also implies BPF_FIB_LKUP_RET_NO_NEIGH. I don't have a clean way of
>>> improving the API. May be others have some ideas.
>>>
>>> Considering dev has no saddr is probably (?) an unlikely case, it should be ok
>>> to leave it as is but at least a comment in the uapi will be needed. Otherwise,
>>> the bpf prog may use the 0 dmac as-is.
>> 
>> I expect that a user of the helper checks that err == 0 before using any of the output params.
>
> For example, the bpf prog gets BPF_FIB_LKUP_RET_NO_NEIGH and learns 
> neigh is not 
> available but ipv6_dst (and the optional ipv6_src) is still valid.
>
> If the bpf prog gets BPF_FIB_LKUP_RET_NO_SRC_ADDR, intuitively, only 
> ipv6_src is 
> not available. The bpf prog will continue to use the ipv6_dst and dmac 
> (which is 
> actually 0).
>

Thinking out loud, we could make BPF_FIB_LOOKUP_SRC to require BPF_FIB_LOOKUP_SKIP_NEIGH, but then for some cases a user would be required to call the helper twice. This is a no-go due perf and instruction count reasons.

Nothing betters comes than explicitly documenting the behavior in the uapi comments.

>> 
>>>
>>> I feel the current bpf_ipv[46]_fib_lookup helper is doing many things
>>> in one
>>> function and then requires different BPF_FIB_LOOKUP_* bits to select
>>> what/how to
>>> do. In the future, it may be worth to consider breaking it into smaller
>>> kfunc(s). e.g. the __ipv[46]_neigh_lookup could be in its own kfunc.
>>>
>> 
>> Yep, good idea. At least it seems that the neigh lookup could live in its own function.
>
> To be clear, it could be independent of this set.
>
> Thanks.

