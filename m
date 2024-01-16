Return-Path: <bpf+bounces-19691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C0182FD3B
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 23:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17561F2A61F
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 22:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F36667C49;
	Tue, 16 Jan 2024 22:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mPu6EAqc"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79A925621
	for <bpf@vger.kernel.org>; Tue, 16 Jan 2024 22:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705444694; cv=none; b=bSDYvv3laV9+g8oXjVzsJQOsHxqIkEZ8OD9JaVJL/f4lEFjmvnZSAXo/QWWAzlW384FqNZbJsi8gtR6M7Lz/7G3unAUoMJS37Uu91DaVQcpld9kZui/+GMJny3EdF5xVLbD3xKEidUPazeUPqKYqso6UukeaTIFQGL7tBncGJ2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705444694; c=relaxed/simple;
	bh=+Ol1TsVDaenjDAH1p/oZNW+kEXvXLkZpD2lLaJuDBX8=;
	h=Message-ID:DKIM-Signature:Date:MIME-Version:Subject:
	 Content-Language:X-Report-Abuse:From:To:Cc:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Migadu-Flow; b=hgUxkXA17ZNBYc+VDOE0KhOAPQQPFlYy1VrzC7fHL609I942nGLw/61pQZVt9VXfUtEE868qNNd8jf5CUgo7fwZdhP6/eh+0YDfmeIGzpkjTE3H0m8/BOf5K5I9HhDXE8CeJKTZfPJkEmV6DWOv3UglVd4xOhJk/+5zUJwZb4DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mPu6EAqc; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5ee27f31-aa11-4a3d-af78-7a79aa0a6440@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705444691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bD0JPp4KZ0vNqoprMhDUUwBhiZtz3k03zDOCY5Doans=;
	b=mPu6EAqcNTHIxEFlZaYQkBIx63ANWjrpOv1tDHoTz3mgYq9D8c4IVvt+chdWV4Rc7XkBAj
	f8g8aF3h0YmSxIuGuxnkdoyhazlNjn/fhpyADYJ+O+khhhIriZOPYar5P/c1ChOFBBTGIU
	6U/i/XpwcFNssUGqlsUvCCYTjNNUI4c=
Date: Tue, 16 Jan 2024 14:38:08 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: flaky tc_redirect/tc_redirect_dtime
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Martin KaFai Lau <martin.lau@kernel.org>, bpf <bpf@vger.kernel.org>
References: <CAADnVQJ_Xwk7xp-AybVC7dtSqRnbo1Lkw1Y+vQ+_w6UJTPvhKw@mail.gmail.com>
 <8af7e87c-1103-44b7-a0eb-1a28f52666a2@linux.dev>
In-Reply-To: <8af7e87c-1103-44b7-a0eb-1a28f52666a2@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 1/15/24 7:09 AM, Martin KaFai Lau wrote:
> On 1/13/24 1:09 PM, Alexei Starovoitov wrote:
>> Hi Martin,
>>
>> I remember you tried to fix tc_redirect/tc_redirect_dtime flakiness,
>> but it is still flaky.
>> Just running test_progs -t tc_redirect/tc_redirect_dtime
>> in a loop it will fail after 30-50 iterations in my VM and always with:
>>
>> test_inet_dtime:PASS:setns src 0 nsec
>> (network_helpers.c:253: errno: Operation now in progress) Failed to
>> connect to server

This is likely caused by the missing the accept() due to the new "goto again;". 
The acceptq is full, server drops the SYN, the second client connect() then 
becomes in-progress or timed out.

It is different from what usually happened in the CI: 
https://github.com/kernel-patches/bpf/actions/runs/7495413543/job/20406821195

2024-01-12T00:46:14.2454623Z (network_helpers.c:253: errno: No route to host) 
Failed to connect to server

"errno: No route to host" should be EHOSTUNREACH returned from the connect().

It is usually the very first connect(). The later connects to the same IPv6 
address are fine. It could be some delay in the routing entry or in the source 
address coming up but I don't spot anything useful now. I can't reproduce in my 
local environment. I will try a little harder. If I cannot find anything, I will 
post a patch to add some tracing to narrow it down further.

>> close_netns:PASS:setns 0 nsec
>> test_inet_dtime:FAIL:connect_to_fd unexpected connect_to_fd: actual -1
>> < expected 0
>>
>> I've added this hack:
>> +again:
>>          nstoken = open_netns(NS_SRC);
>>          if (!ASSERT_OK_PTR(nstoken, "setns src"))
>>                  goto done;
>> @@ -573,6 +575,11 @@ static void test_inet_dtime(int family, int type,
>> const char *addr, __u16 port)
>>          if (!ASSERT_GE(client_fd, 0, "connect_to_fd"))
>>                  goto done;
>>
>> +       if (i++ < 1000 && 0) {
>> +               printf("XXXX %d\n", i);
>> +               close(client_fd);
>> +               goto again;
>> +       }
>>
>> and realized that only the first connect can succeed.
>> The 2nd connect always fails.
>> So I suspect bpf prog sees first stray packet, acts on it,
>> but the actual connect request comes 2nd and it fails.
>>
>> I tried to understand what's going on inside bpf prog,
>> but the test is too complicated.
>> Please take a look when you have a chance.
>>
>> I also added:
>> @@ -857,7 +864,7 @@ static void test_tc_redirect_dtime(struct
>> netns_setup_result *setup_result)
>>                  goto done;
>>
>>          test_tcp_clear_dtime(skel);
>> -
>> +if (0) {
>>          test_tcp_dtime(skel, AF_INET, true);
>>          test_tcp_dtime(skel, AF_INET6, true);
>>          test_udp_dtime(skel, AF_INET, true);
>> @@ -878,7 +885,7 @@ static void test_tc_redirect_dtime(struct
>> netns_setup_result *setup_result)
>>          test_tcp_dtime(skel, AF_INET6, false);
>>          test_udp_dtime(skel, AF_INET, false);
>>          test_udp_dtime(skel, AF_INET6, false);
>> -
>> +}
>> to speed up a test a bit.
> 
> Thanks for the tips to reproduce it. I will look into it.
> 


