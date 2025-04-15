Return-Path: <bpf+bounces-55961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE802A8A27A
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 17:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3A7A189996F
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 15:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1C1233728;
	Tue, 15 Apr 2025 15:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="Y1QqhTjb"
X-Original-To: bpf@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC93018FC92;
	Tue, 15 Apr 2025 15:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744729935; cv=none; b=O/JSX9EIJFA2rKUX3vwbFKIAk6hpfoHZpn67V6cniHjoKZf8LgpT6k/4ovtW7RV8J9SgYlVVg3T8pdvy5ZsT98vhnTXT6viIbZFuSEc9qeTF3ikXHZa3rETs+v+QAvKA3+k3+NZak3PCz3lw/1+5tSCQS79FBhMU26sS1F+pAOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744729935; c=relaxed/simple;
	bh=BTqIgXr+Yk9rkST+E3Ko1YtNFF2i9GrhXbC7U+/B8h4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eT2GfA2vOKcn1Q7txd4s2QCu9zHKojjR7tLLcHT2fDEFxLZM0EXnAXawu+Ph/qDlPNTKJObEkEHLJnJ0wyaaYekDtSvB0PtLZouJ6LG18HCXm+yKmrAJ/3ePMXageM+pq/tHu+0JyyJz4M5tHE8MwERC+muJySTyaxlfiKPA1/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=Y1QqhTjb; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.58] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 6276E200C240;
	Tue, 15 Apr 2025 17:12:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 6276E200C240
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1744729929;
	bh=lCX6bkU2x9M/JL3rBv7BNAyNe+Lg0ZQXby7iFBmcET4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y1QqhTjbijNtbDjNRxiNwWrLFEINcKXucg/O7Rfd1mrBHdgBMjq5Dy6dbht+XwDBF
	 p3Fp76/7FQCKRPTUYJsdscoBO+wyLV0rN9WyKE5LPCOprhwC323SN/Maa1TBFVSohC
	 NXTmQgOlNX+EVLn40NeB/RTxlEJpK/GkCRfrvrr2S+SzKrV6b3O9dahgdqyBVSOWFc
	 RdSFAief4AseOltkNUo6TpfUNAmNUl6UjP0JCs2E5Aqre753tNSykhPrtMDXrUBhmC
	 QKZkQDrycAy5FNMgqVaA4dGymfz7pBRDrhS9hL1s0Hx6/H8qsmOwO8XLWtGmdbwZwW
	 GuFExF6OSd5kg==
Message-ID: <0b281dae-3d94-4ac4-ab53-eff6d51a5135@uliege.be>
Date: Tue, 15 Apr 2025 17:12:09 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: lwtunnel: disable preemption when required
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Sebastian Sewior <bigeasy@linutronix.de>,
 Stanislav Fomichev <stfomichev@gmail.com>,
 Network Development <netdev@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, bpf <bpf@vger.kernel.org>,
 Stefano Salsano <stefano.salsano@uniroma2.it>,
 Paolo Lungaroni <paolo.lungaroni@uniroma2.it>
References: <20250403083956.13946-1-justin.iurman@uliege.be>
 <Z-62MSCyMsqtMW1N@mini-arch> <cb0df409-ebbf-4970-b10c-4ea9f863ff00@uliege.be>
 <CAADnVQLiM5MA3Xyrkqmubku6751ZPrDk6v-HmC1jnOaL47=t+g@mail.gmail.com>
 <20250404141955.7Rcvv7nB@linutronix.de>
 <85eefdd9-ec5d-4113-8a50-5d9ea11c8bf5@uliege.be>
 <CAADnVQK7vNPbMS7T9TUOW7s6HNbfr4H8CWbjPgVXW7xa+ybPsw@mail.gmail.com>
 <d326726d-7050-4e88-b950-f49cf5901d34@uliege.be>
 <20250415025416.0273812f0322a6b1728d9c7b@uniroma2.it>
 <3cee5141-c525-4e83-830e-bf21828aed51@uliege.be>
 <20250415073818.06ea327c@kernel.org>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <20250415073818.06ea327c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/15/25 16:38, Jakub Kicinski wrote:
> On Tue, 15 Apr 2025 11:10:01 +0200 Justin Iurman wrote:
>>> However, there is my opinion an issue that can occur: between the check on
>>> in_softirq() and the call to local_bh_disable(), the task may be scheduled on
>>> another CPU. As a result, the check on in_softirq() becomes ineffective because
>>> we may end up disabling BH on a CPU that is not the one we just checked (with
>>> if (in_softirq()) { ... }).
> 
> The context is not affected by migration. The context is fully defined
> by the execution stack.
> 
>> Hmm, I think it's correct... good catch. I went for this solution to (i)
>> avoid useless nested BHs disable calls; and (ii) avoid ending up with a
>> spaghetti graph of possible paths with or without BHs disabled (i.e.,
>> with single entry points, namely lwtunnel_xmit() and lwtunnel_output()),
>> which otherwise makes it hard to maintain the code IMO.
>>
>> So, if we want to follow what Alexei suggests (see his last response),
>> we'd need to disable BHs in both ip_local_out() and ip6_local_out().
>> These are the common functions which are closest in depth, and so for
>> both lwtunnel_xmit() and lwtunnel_output(). But... at the "cost" of
>> disabling BHs even when it may not be required. Indeed, ip_local_out()
>> and ip6_local_out() both call dst_output(), which one is usually not
>> lwtunnel_output() (and there may not even be a lwtunnel_xmit() to call
>> either).
>>
>> The other solution is to always call local_bh_disable() in both
>> lwtunnel_xmit() and lwtunnel_output(), at the cost of disabling BHs when
>> they were already. Which was basically -v1 and received a NACK from Alexei.
> 
> I thought he nacked preempt_disable()

I think I wasn't clear enough, sorry. Alexei explicitly NACK'ed the 
initial patch (the one with preempt_disable()) -- you're right. I think 
he also (implicitly) NACK'ed the other solution I proposed (see [1]) by 
reading his reply. Alexei can clarify if I'm mistaken. He seems to 
prefer the solution that disables BHs on specific paths (see [2] for the 
other proposal) instead of inside lwtunnel_xmit() and lwtunnel_output().

So, basically, we have a choice to make between [1] and [2], where [1] 
IMO is better for the following reasons: (i) no nested calls to disable 
BHs, (ii) disable BHs only when they're not already, and (iii) code 
clarity, i.e., not overly complexifying the graph of paths w/ or w/o BHs 
disabled. While with [2], BHs will be disabled even when not required on 
the xmit/output path, and also resulting in an even more complex graph 
of paths regarding BHs.

   [1] 
https://lore.kernel.org/netdev/20250415073818.06ea327c@kernel.org/T/#m5a4e6a56206d9d110a5e4d664ab4ea09e7e9b33e
   [2] 
https://lore.kernel.org/netdev/20250415073818.06ea327c@kernel.org/T/#m3a88de38eceb0a53e2d173dc3675ecaa37e9d0b4

