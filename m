Return-Path: <bpf+bounces-19203-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E878278AE
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 20:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48AF51C21CC1
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 19:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D452A53810;
	Mon,  8 Jan 2024 19:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vve015L6"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4F55380C
	for <bpf@vger.kernel.org>; Mon,  8 Jan 2024 19:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9ef37508-39d6-4b8a-81c9-5e5b788cdc7f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704742856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h3nVCpc5OapJePtEPDuuDf6kvgUHMzrvjWYW4gLcJrk=;
	b=vve015L6czvkPmuVy8BuG1fKbdGOe3IcRxf5OHuMCvqoZRcAmIBm0gMYDRWufdfIOIXv/y
	f58yZBx0A/3TsEgXf8gcVNFW1SLGDeBaX0+UUSV8FY6laqCJZQDUYIDgUzNKMJOjH0jQ0c
	RfTRma3lX8J2YaUCYcQ9/0xGXtOGShU=
Date: Mon, 8 Jan 2024 11:40:49 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Track aligned st store as imprecise
 spilled registers
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Martin KaFai Lau <kafai@fb.com>
References: <20240103232617.3770727-1-yonghong.song@linux.dev>
 <f4c1ebf73ccf4099f44045e8a5b053b7acdffeed.camel@gmail.com>
 <cbff1224-39c0-4555-a688-53e921065b97@linux.dev>
 <69410e766d68f4e69400ba9b1c3b4c56feaa2ca2.camel@gmail.com>
 <CAEf4Bzb0LdSPnFZ-kPRftofA6LsaOkxXLN4_fr9BLR3iG-te-g@mail.gmail.com>
 <67a4b5b8bdb24a80c1289711c7c156b6c8247403.camel@gmail.com>
 <CAEf4BzZ8tAXQtCvUEEELy8S26Wf7OEO6APSprQFEBND7M_FXrQ@mail.gmail.com>
 <ddc70b06-9fde-412f-88c0-3097e967dc6a@linux.dev>
 <5e31a6835b648fae9880f6bfbc40801539b2d143.camel@gmail.com>
 <07d7d6e0-d090-47e6-9f17-0b083aeaa7af@linux.dev>
 <ec2758667b5a286dd48ebaaa8cfafa1112699735.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ec2758667b5a286dd48ebaaa8cfafa1112699735.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/8/24 11:06 AM, Eduard Zingerman wrote:
> On Mon, 2024-01-08 at 10:59 -0800, Yonghong Song wrote:
> [...]
>
>> I guess one way could be doing backtracking with "... = arr[i]"
>> is to have four ranges, [-32, -24), [-24, -16), [-16, -8), [-8, 0).
>> Later, when we see arr[i] = r0 and i has range [-32, 0). Since it covers [-32, -24), etc.,
>> precision marking can proceed with 'r0'. But I guess this can potentially
>> increase verifier backtracking states a lot and is not scalable. Conservatively
>> doing precision marking with 'r0' (in arr[i] = r0) is a better idea.
> In theory it should be possible to collapse this range to min/max pair.
> But it is a complication, and I'd say it shouldn't be implemented
> unless we have evidence that it significantly improves verification
> performance.

Ack. We do not need to introduce this yet as the variable index range
should be much much less common.

>
>> Andrii has similar comments in
>>     https://lore.kernel.org/bpf/CAEf4Bzb0LdSPnFZ-kPRftofA6LsaOkxXLN4_fr9BLR3iG-te-g@mail.gmail.com/
>>

