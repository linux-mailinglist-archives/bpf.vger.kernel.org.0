Return-Path: <bpf+bounces-53108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6004A4CBE2
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 20:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D93973A1FC3
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 19:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8103D23875D;
	Mon,  3 Mar 2025 19:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GvxUaHPs"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7EA23496F
	for <bpf@vger.kernel.org>; Mon,  3 Mar 2025 19:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741029303; cv=none; b=UaYUQZ5RtLmJNbWyU03ApIohp/NvxZSZRDj50YJo1+20NbRdIjqG34xKFNoQjFJLE+NJSAIHefCKChwNV1b3B6QolDBGy3mKkw6pOxpFjwGoe0tizqg6DYj6igXBBnnY8J1zd5d93v1hDc3m8/GqgZTevvSeppBk9LgXg7n5P8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741029303; c=relaxed/simple;
	bh=XnHjLNvgZ49fyxIIcJw06UuCoQ7Q3MePO65vocQnuv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QJhUf7zlnnUH6mVycvV8EG0TsiYhJiIwdRysDsTBttv5P3jcZCJQ0bApPiPGpf8Vl4WMS3N7HW2Gz6eebUophmKv1BgeYWN7OlXzvgcIZQxNZ7E5i8KavY3hQ6PfppDEyvu+B7tZTA5nJlNnm0K2eS1qMXAUScaXx6/B4nFM1UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GvxUaHPs; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <36637c9d-b6bc-4b8c-a2fd-9800c5a7a6dc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741029298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cQ4P4ZNa0gRDrd3ZEQQVaYQ3JFD9hJeR/pJyq8cQwHU=;
	b=GvxUaHPs6GqC7cfMVvsf6C3AMlP9alzOVFjEyMdJro4yzifSrMtpL4KuTdpSYK0yXn5ach
	I0r3KfN27h4+3kOTZqZKccMpc+2jbsZHSs3BoG0keJtqmmCYt8/RHyTnDJZ9OyrvskwX0u
	/GiYrXMt6FZ8CfQ7umFIPDnbrIAewhw=
Date: Mon, 3 Mar 2025 11:14:53 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: add get_netns_cookie helper to tracing
 programs
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, ast@kernel.org,
 andrii@kernel.org, jolsa@kernel.org, bpf@vger.kernel.org,
 Network Development <netdev@vger.kernel.org>
References: <20250227182830.90863-1-mahe.tardy@gmail.com>
 <96dbd7df-1fa7-4caa-a52c-372d696e0f38@linux.dev>
 <Z8WBIR72Zu5x50N9@MTARDY-M-GJC6>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <Z8WBIR72Zu5x50N9@MTARDY-M-GJC6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/3/25 2:14 AM, Mahe Tardy wrote:
> On Thu, Feb 27, 2025 at 12:32:43PM -0800, Martin KaFai Lau wrote:
>> On 2/27/25 10:28 AM, Mahe Tardy wrote:
>>> This is needed in the context of Cilium and Tetragon to retrieve netns
>>> cookie from hostns when traffic leaves Pod, so that we can correlate
>>> skb->sk's netns cookie.
>>>
>>> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
>>> ---
>>> This is a follow-up of c221d3744ad3 ("bpf: add get_netns_cookie helper
>>> to cgroup_skb programs") and eb62f49de7ec ("bpf: add get_netns_cookie
>>> helper to tc programs"), adding this helper respectively to cgroup_skb
>>> and tcx programs.
>>>
>>> I looked up a patch doing a similar thing c5dbb89fc2ac ("bpf: Expose
>>> bpf_get_socket_cookie to tracing programs") and there was an item about
>>> "sleepable context". It seems it indeed concerns tracing and LSM progs
>>> from reading 1e6c62a88215 ("bpf: Introduce sleepable BPF programs"). Is
>>> this needed here?
>>
>> Regarding sleepable, I think the bpf_get_netns_cookie_sock is only reading,
>> should be fine.
> 
> Ok thank you.
> 
>> The immediate question is whether sock_net(sk) must be non-NULL for tracing.
> 
> We discussed this offline with Daniel Borkmann and we think that it
> might not be the question. The get_netns_cookie(NULL) call allows us to
> compare against get_netns_cookie(sock) to see whether the sock's netns
> is equal to the init netns and thus dispatch different logic.

bpf_get_netns_cookie(NULL) should be fine.

I meant to ask if sock_net(sk) may return NULL for a non NULL sk. Please check.

> 
> Given we (in Tetragon) historically used tracing programs when no
> appropriate network hook was available on older kernels I can foresee
> how it can still be useful in such programs.
> 


