Return-Path: <bpf+bounces-38044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E54095E78A
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 06:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C59A4B214E3
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 04:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D9374055;
	Mon, 26 Aug 2024 04:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZkoQRTdX"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949168C1F
	for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 04:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724645133; cv=none; b=npU5eEjOSrh/6dxwEVeZeZSU+tOBJfkBvJwAyaU1/ZM9P3mrqYflVVRFvPXfgHVpxXySQjU/UOuatZRUUWd3hqukW2gxxzMUcv9Vmde+4pBVRvHDum6Ks24HpMw4R4xYzzDcTMQQ5mJmHbbhU1/PqjqXl78GSuW1LlWTtRXqLQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724645133; c=relaxed/simple;
	bh=P7pkvocGjCUi4oDZDHORsy7qFuaIh9Gro0pnbZXyMDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EhDIy2ad/hxeT4buXp19cvuZabB9GGRCQu46RVGHvo6nWvrW7pnm2dGPXjvBxG2BXoH+wejHmfn3jD3Pt8z5vsl2TKBdLQYTvtppTIaRpWcgHFPSScaUxtCYsDsMOGPCKN3bXesk/yFcDC5H/dqdtMcujsPSElD2737i+OIwXOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZkoQRTdX; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dee07a8c-aed2-4125-a4f0-1bd76ca1e4ac@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724645127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P7pkvocGjCUi4oDZDHORsy7qFuaIh9Gro0pnbZXyMDg=;
	b=ZkoQRTdXydQjcRgl6MvaTBSrwgG91rMtf45oAabydvvNO1qpwgvBQt/pUNJVs0WsSNpvNi
	NznfAsjPz9/jfFuVAB6qVYdRaAtepVC/gI315LlXLgQEhzyR4D7Yoaljp/beA9YlhIaUl9
	ZyWq1CXuCQ0jSVcTofppeHkzgY1g774=
Date: Sun, 25 Aug 2024 21:05:19 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Allow error injection for
 update_socket_protocol
Content-Language: en-GB
To: Gang Yan <gang_yan@foxmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org
References: <tmcxv429u9-tmgrokbfbm@nsmail7.0.0--kylin--1>
 <tencent_EB51CDCA4E189E271032DFEC7E042B752008@qq.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <tencent_EB51CDCA4E189E271032DFEC7E042B752008@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 8/25/24 8:29 PM, Gang Yan wrote:
> Hi Alexei:
> It's my honor to recieve your reply. The response to your concerns is attached below
> for your review.
> On Mon, Aug 26, 2024 at 10:57:12AM +0800, Gang Yan wrote:
>> On Thu, Aug 22, 2024 at 8:33 AM Jakub Kicinski wrote:
>>> On Thu, 22 Aug 2024 14:08:57 +0800 Gang Yan wrote:
>>>> diff --git a/net/socket.c b/net/socket.c
>>>> index fcbdd5bc47ac..63ce1caf75eb 100644
>>>> --- a/net/socket.c
>>>> +++ b/net/socket.c
>>>> @@ -1695,6 +1695,7 @@ __weak noinline int update_socket_protocol(int family, int type, int protocol)
>>>> {
>>>> return protocol;
>>>> }
>>>> +ALLOW_ERROR_INJECTION(update_socket_protocol, ERRNO);
>>> IDK if this falls under BPF or directly net, but could you explain
>>> what test will use this? I'd prefer not to add test hooks into the
>>> kernel unless they are exercised by in-tree tests.
>> This looks unnecessary.
>> update_socket_protocol is already registered as fmodret.
>> There is even selftest that excises this feature:
>> tools/testing/selftests/bpf/progs/mptcpify.c
>>
>> It doesn't need to be part of the error-inject.
> The 'update_socket_protocol' is a BPF interface designed primarily to
> fix the socket protocol from TCP protocol to MPTCP protocol without
> requiring modifications to user-space application codes. However,
> when attempting to achieve this using the BCC tool in user-space,
> the BCC tool doesn't support 'fmod_ret'. Therefore, this patch aims to
> further expand capabilities, enabling the 'kprobe' method can overriding
> the update_socket_protocol interface.

Gang Yan, could you explore to add fmod_ret support in bcc? It should be
similar to kfunc/kretfunc support. I am happy to review your patches.

Thanks,
Yonghong

>
> As a Python developer, the BCC tool is a commonly utilized instrument for
> interacting with the kernel. If the kernel could permit the use of an
> error-inject method to modify the `update_socket_protocol`, it would significantly
> benefit the subsequent promotion and development of MPTCP applications.
> Thank you for considering this enhancement.
>
> Best wishes!
> Gang Yan
>
>

