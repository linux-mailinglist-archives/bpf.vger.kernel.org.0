Return-Path: <bpf+bounces-75566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E81DC88F3E
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 10:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 915304E3696
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 09:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACD5313551;
	Wed, 26 Nov 2025 09:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iujxercK"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FC72D6619
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 09:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764149377; cv=none; b=MAlUWPrJBeNmMCiKoCQailEQSe9cGaqkhg3epDd+dd+tI3W5QAOtn4+eQDupz8QQz64k1YQH0NNhB541V8VvN9zb7QeV066+5eE/uFPGSGKgWuonp5cNLgFxyjAlvuaLycwgz2TKh/PT06ds6OhCrvAT4Fy2QdyeLK1hcPcIcSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764149377; c=relaxed/simple;
	bh=GC99hb77UWnEnm28EUGHOhrCiQq3dsAhYdNfjDaBqx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=clNuSWy/u6bS8OVj8wjwF3XNN309owtInzFZO3d1NnpN/0ioRVZqF6o+YaLHZseAsQJIF5yeEzzRLDS+6zJQIItPNR9CXVunE1nbu3OK/CAKJFeDglf5ItTX3RLVH8FCfQWGu/VsMYnCzBAz3gmjFggW++p3MHaDOKHo2Nb2/zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iujxercK; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7b82e322-eab7-4fc2-9de1-d10ad8251378@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764149363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyvxBUAQtvL7MLXjozd2sOG3RxdZ5x/jz3IM+iSQnko=;
	b=iujxercKX5myW8jvCC8bZIszUqjIHqFuuXCfZjhQ8/+ltO/GjfcaRJ6V8trg2t1uq7E7sP
	8G7UBYks3QUmsLj5geyeMrer1ubOHYsgrP6jPhERvCivkZzS5lm36sZmrIBr8Xma1wRpxE
	gfrwCFP5qCS2u5sRXUMNVj0qC+Yb9H0=
Date: Wed, 26 Nov 2025 17:29:12 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 2/2] bpf: Hold the perf callchain entry until
 used completely
To: Yonghong Song <yonghong.song@linux.dev>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20251112163148.100949-1-chen.dylane@linux.dev>
 <20251112163148.100949-3-chen.dylane@linux.dev>
 <c41372ad-1591-4f2b-a786-bc0e19f8425c@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <c41372ad-1591-4f2b-a786-bc0e19f8425c@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/11/14 00:01, Yonghong Song 写道:
> 
> 
> On 11/12/25 8:31 AM, Tao Chen wrote:
>> As Alexei noted, get_perf_callchain() return values may be reused
>> if a task is preempted after the BPF program enters migrate disable
>> mode. The perf_callchain_entres has a small stack of entries, and
>> we can reuse it as follows:
>>
>> 1. get the perf callchain entry
>> 2. BPF use...
>> 3. put the perf callchain entry
>>
>> And Peter suggested that get_recursion_context used with preemption
>> disabled, so we should disable preemption at BPF side.
>>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> 
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> 

Hi eBPF maintainers,

This patch appears to have missed the eBPF maintainers on the list, 
please review it again, thanks.

-- 
Best Regards
Tao Chen

