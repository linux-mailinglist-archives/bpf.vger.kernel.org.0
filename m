Return-Path: <bpf+bounces-51510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CEEA35497
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 03:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7E0216CDCF
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 02:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4F013DDAA;
	Fri, 14 Feb 2025 02:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EjtcrC+L"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DCD8634A
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 02:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739499268; cv=none; b=LS2xLXujdCdC6C+wbAAKu/tm+qpdDdASdoSgCWiEpJxbyhM8Iv5rREjyASFdhLOl4Mp7NvJ21lWSrztnrxnzqml/0SmPTNRdKRkBI6JiFo/TuGufMMJWUqrkx9ZEeuI6pqF7LICr/sVUOMfnvioyw49wngRAIc3KRmw4sskNgxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739499268; c=relaxed/simple;
	bh=87pZ5rFe8MHrMwq7rkNVMdR/BnR+HLoPdg3Wde6NOSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m2eXaobRnLdkUt6cMgDCP3uejnNXTuLDs/FJjTqs/1chcX2vT5aIee9xQeMX4y34+QgXiIaglEg+sVsmA8cp7TB1GSyBhDQGMYg+7s31stqyL9gMSUvWcilcjFN5Ri7nrs2ki8KNOmqp73Xx16VX+OzQJmvpKw/KH/c3fn+r4nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EjtcrC+L; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <039bfa0d-3d61-488e-9205-bef39499db6e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739499254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kUI9Bv66f7rqMNMsUao4OmvHx74KK1NJdkGJyf1O3zQ=;
	b=EjtcrC+LxW+broS+TEqETetEfgnwuNcmZWVIaBbf+Ixj7eXqpY0SpAYO1cXn/K4vSVL2i2
	VE5nzB6CmemwC3oGsyxv/qLXrk6jVv2iNowjcdEQ2/g0mf+gzUXRB1WTErxKcFezxVCfYG
	fdzKKvlvtTi7kXLL/Qs8F7tLEv2zqag=
Date: Thu, 13 Feb 2025 18:14:06 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/3] bpf: add TCP_BPF_RTO_MAX for bpf_setsockopt
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 horms@kernel.org, ncardwell@google.com, kuniyu@amazon.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250213004355.38918-1-kerneljasonxing@gmail.com>
 <20250213004355.38918-3-kerneljasonxing@gmail.com>
 <Z66DL7uda3fwNQfH@mini-arch>
 <CAL+tcoATv6HX5G6wOrquGyyj8C7bFgRZNnWBwnPTKD1gb4ZD=g@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAL+tcoATv6HX5G6wOrquGyyj8C7bFgRZNnWBwnPTKD1gb4ZD=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/13/25 3:57 PM, Jason Xing wrote:
> On Fri, Feb 14, 2025 at 7:41 AM Stanislav Fomichev<stfomichev@gmail.com> wrote:
>> On 02/13, Jason Xing wrote:
>>> Support bpf_setsockopt() to set the maximum value of RTO for
>>> BPF program.
>>>
>>> Signed-off-by: Jason Xing<kerneljasonxing@gmail.com>
>>> ---
>>>   Documentation/networking/ip-sysctl.rst | 3 ++-
>>>   include/uapi/linux/bpf.h               | 2 ++
>>>   net/core/filter.c                      | 6 ++++++
>>>   tools/include/uapi/linux/bpf.h         | 2 ++
>>>   4 files changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
>>> index 054561f8dcae..78eb0959438a 100644
>>> --- a/Documentation/networking/ip-sysctl.rst
>>> +++ b/Documentation/networking/ip-sysctl.rst
>>> @@ -1241,7 +1241,8 @@ tcp_rto_min_us - INTEGER
>>>
>>>   tcp_rto_max_ms - INTEGER
>>>        Maximal TCP retransmission timeout (in ms).
>>> -     Note that TCP_RTO_MAX_MS socket option has higher precedence.
>>> +     Note that TCP_BPF_RTO_MAX and TCP_RTO_MAX_MS socket option have the
>>> +     higher precedence for configuring this setting.
>> The cover letter needs more explanation about the motivation.

+1

I haven't looked at the patches. The cover letter has no word on the use case. 
Using test_tcp_hdr_options.c as the test is unnecessarily complicated just for 
adding a new optname support. setget_sockopt.c is the right test to reuse.


> I am targeting the net-next tree because of recent changes[1] made by
> Eric. It probably hasn't merged into the bpf-next tree.

There is the bpf-next/net tree. It should have the needed changes.

pw-bot: cr

