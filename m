Return-Path: <bpf+bounces-55975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 926EEA8A51E
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 19:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A510F442E97
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 17:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6AE21D5A1;
	Tue, 15 Apr 2025 17:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="U0oaPyX6"
X-Original-To: bpf@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6410721CA18;
	Tue, 15 Apr 2025 17:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744737161; cv=none; b=cnL+7vw7aOTlA817duk7vKgXZBNI+l5azPvGgP1dwYvO+HjQ5naUhops2+2Ut3mjpgkpsy6y+EzZsiRc2R0xlcPFqxBZENfBXffsrUMwaLtsyRk43nmJX0XKcIaAJqHw9G8rWwvfuX2b60Uujx/5ZJILtl8HzgKLKafLxtSe6oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744737161; c=relaxed/simple;
	bh=PvYkn3NqN8CtR8wkR2NnBRGoz2vx5sJ6WpV+4u1A6+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L0of2qaQqNY68Jb7J4DHJKOwby0kv67ADOq+/FFdbFMQpEB/FAlElayWkAUJojqnGEohH1iWQAhSO2ucta0B/FJA51V+qf7VVucdfnlsFEtRvM2wO06+ijBYgE60gEePNtlKmbg7hbmbAGkoH29reAsZ+B0JC/qsSmV99OLDvGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=U0oaPyX6; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.58] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 01968200A8CB;
	Tue, 15 Apr 2025 19:12:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 01968200A8CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1744737156;
	bh=7KnAY+WDQY1bFCmEbQGwVA9XP9qD4quyOGjF3MMWiew=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U0oaPyX6PMM+uD8fWGdj1U2k2T3HHIJP6hbZQPg29hdFTRYb9GBeuEqLduecAUdmX
	 XXt4Y9+cDj508oJRW9RVVVnxD29ZEdydhDnjAc+K0HSeOUff8DQuJufl+eRNhkaJVL
	 cIEQu09fjeOdgM69UtS0HOfR3hHhVYE9tofiDuWy9rBkKton6OlmY7sD6S+xVx5DuG
	 iqsSE8FdDm0l2TvC3oxm1wAJ00dVXPD5EaHfEBwx3JWuJLWHuVKiOrnlZtwZo0+oxz
	 k0mWVBrHJAzulLhrAUpLoCBEwDD7PATnuz23ohuFniEzrsPyPpciHyeprrjSLfLHAN
	 W0MSbOYnkmWJQ==
Message-ID: <ca95bab8-5805-4c33-8318-72d618bf0a95@uliege.be>
Date: Tue, 15 Apr 2025 19:12:35 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: lwtunnel: disable preemption when required
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>,
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
 <CAADnVQ+of2aBgmOFGNfixtqgp-spYdvZwHyw_=77S5T_+LXCBw@mail.gmail.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <CAADnVQ+of2aBgmOFGNfixtqgp-spYdvZwHyw_=77S5T_+LXCBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/15/25 17:12, Alexei Starovoitov wrote:
> On Tue, Apr 15, 2025 at 7:38 AM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Tue, 15 Apr 2025 11:10:01 +0200 Justin Iurman wrote:
>>>> However, there is my opinion an issue that can occur: between the check on
>>>> in_softirq() and the call to local_bh_disable(), the task may be scheduled on
>>>> another CPU. As a result, the check on in_softirq() becomes ineffective because
>>>> we may end up disabling BH on a CPU that is not the one we just checked (with
>>>> if (in_softirq()) { ... }).
>>
>> The context is not affected by migration. The context is fully defined
>> by the execution stack.
>>
>>> Hmm, I think it's correct... good catch. I went for this solution to (i)
>>> avoid useless nested BHs disable calls; and (ii) avoid ending up with a
>>> spaghetti graph of possible paths with or without BHs disabled (i.e.,
>>> with single entry points, namely lwtunnel_xmit() and lwtunnel_output()),
>>> which otherwise makes it hard to maintain the code IMO.
>>>
>>> So, if we want to follow what Alexei suggests (see his last response),
>>> we'd need to disable BHs in both ip_local_out() and ip6_local_out().
>>> These are the common functions which are closest in depth, and so for
>>> both lwtunnel_xmit() and lwtunnel_output(). But... at the "cost" of
>>> disabling BHs even when it may not be required. Indeed, ip_local_out()
>>> and ip6_local_out() both call dst_output(), which one is usually not
>>> lwtunnel_output() (and there may not even be a lwtunnel_xmit() to call
>>> either).
>>>
>>> The other solution is to always call local_bh_disable() in both
>>> lwtunnel_xmit() and lwtunnel_output(), at the cost of disabling BHs when
>>> they were already. Which was basically -v1 and received a NACK from Alexei.
>>
>> I thought he nacked preempt_disable()
> 
> +1.
> 
> imo unconditional local_bh_disable() in tx path is fine.
> I didn't like the addition of local_bh_disable() in every lwt related
> function without doing home work whether it's needed there or not.
> Like input path shouldn't need local_bh_disable

Ack, sorry for the confusion. I'll post -v2 with that solution.

