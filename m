Return-Path: <bpf+bounces-30321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9805B8CC617
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 20:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A9331F24D05
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 18:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFCE145B13;
	Wed, 22 May 2024 18:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YDLxfVDa"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DD2145B18
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 18:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716401223; cv=none; b=rCrgQ5guYLcGpNBUk4O/orrjUibYMxtfgO1T+WRZ/KP/MYD+dl+nJzYAmble1emvqp76auRz4N+eEPtFjb3tfAxkBnsA5AWFtZqpu5HSwxG7xnMMyrl05qmDnLSJGBMHa+3DEeZv4Rh75FpQzqH8+4l0Kchk7BUpliJuOZ5vQy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716401223; c=relaxed/simple;
	bh=GU8k2vrFW+Q4a/IHpA1Mu25rvdH1d6fbCEzT2f3UlOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nAJsKx4ZYtH9vm2a6aKQlLrY+a7HJ9s8WuITDcR+ar871wzoO+DCu4c+sAnPpInJedSnRcxFK0jAe8ty0Jm8mZXOE+/atmD8HCrYLD7v9sEphuqYrGlS11cqtEWVXwUboQ8N9YSgr687rErhXM6m1CzD3ivpXd+xkn/+mhOQRt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YDLxfVDa; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: vadim.fedorenko@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716401219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vN94hhCUux7lWv/u/7hkM4s28VGi4FGo6zfEFadi2pM=;
	b=YDLxfVDavrKOKyqurlR2dOjLLqB6dTPLuJtY9wbZ+pYLw8rC4rF9bBQ4n+TiXP0k0r+atE
	8PE3mKZoxjri7nbAHABDvWY2xiptyRv9AgDJ0w3Hg6cS5tqPaozFUIEs0ci87OZFh8pfje
	WdbHzxlobtXiz0yQ6+cL7Y4LLULXO/A=
X-Envelope-To: eddyz87@gmail.com
X-Envelope-To: kuba@kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: mykolal@fb.com
X-Envelope-To: andrii@kernel.org
X-Envelope-To: bpf@vger.kernel.org
Message-ID: <140aff14-0977-43ed-82d6-0afedc024556@linux.dev>
Date: Wed, 22 May 2024 11:06:51 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 0/4] bpf: make trusted args nullable
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org
References: <20240510122823.1530682-1-vadfed@meta.com>
 <4c8a90dbdc4677b57b19bc0d8b4109e3b6537aec.camel@gmail.com>
 <912ac775-1505-468b-9030-88cbbf8e30f2@linux.dev>
 <836e4a4ca07872fed42c0b2327dddecf47c572c0.camel@gmail.com>
 <20db6269-80cb-47f9-8d36-5a3443680450@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20db6269-80cb-47f9-8d36-5a3443680450@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/22/24 9:34 AM, Vadim Fedorenko wrote:
> On 22/05/2024 16:23, Eduard Zingerman wrote:
>> On Wed, 2024-05-22 at 13:35 +0100, Vadim Fedorenko wrote:
>>
>> [...]
>>
>>> I'm not really sure how I can test it without fully replicating crypto
>>> tests. We don't have any other kfuncs with nullable dynptrs yet to test,
>>> maybe we should revisit this part once we have more functions with
>>> nullable parameters.
>>
>> kfuncs for testing could be defined in
>> tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:bpf_testmod.c,
>> e.g. see bpf_testmod_test_mod_kfunc().
> 
> alright, thanks for the pointer, I'll add some tests with kfuncs.
> 
+1

pw-bot: cr

