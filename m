Return-Path: <bpf+bounces-75960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1276C9E7E3
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 10:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34CD83A1FE3
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 09:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1281D2DC79C;
	Wed,  3 Dec 2025 09:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="inK4SRCw"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFA22D94A5
	for <bpf@vger.kernel.org>; Wed,  3 Dec 2025 09:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764754457; cv=none; b=HAVJkMaO/Y0k5ABNBiyppHlXm5NlUQe4FZqHQ98Jp7gXgFJqaqE+TbmWxO5HV03jeTevyPODAfu3C662/7s5Bsbm/eCIj3jz1XcB6K04atl7VCo2QL3P9Af7Gh27omkTjID3H8JV91Cm0XhiD1XiVR73X7QsJxloB0BCEYevOBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764754457; c=relaxed/simple;
	bh=0pUTBTrWOl8vMGRJx5bO7WE+waJ3ARqGwRgiHBOo3nQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XuXrtfYVj5eV+Gy/n2C4+0Ud8KW5Aw1zNYuOCxX/DQCfD9FmmqIXQA86FFq3v3UD2Gctj78tZwqD4fTn3StRNmt8kqQ8bNmgEpELw68emfPUOjzL5VjMvYCvXOfUIvg+sdktEHH782R4rJgTiD5wB4uFgb6hAAN1U7KdG/reqlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=inK4SRCw; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <42627219-fa33-441d-b8cb-eb48ab3230d6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764754443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ze5QiKE4t50u1X7fPBtOrmNysQ7fIpo2Qo0fD1u03Po=;
	b=inK4SRCwjrw64hrP/g8a9/GJoEI1Vv9gN9G74fIQeIia4xJdSo/MxKgtYqXg32Fd20jnVt
	YwBhbRhn9lx0T4TbPk2o3F257J3K9aRRrfEIFjPtFA25DVG7RXHqfk8+Qh4la02LT+lfMs
	JX+X9hRzcna6eE3xyyebb0jDPoIqLlU=
Date: Wed, 3 Dec 2025 17:33:29 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 2/2] bpf: Hold the perf callchain entry until
 used completely
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
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
 <7b82e322-eab7-4fc2-9de1-d10ad8251378@linux.dev>
In-Reply-To: <7b82e322-eab7-4fc2-9de1-d10ad8251378@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/11/26 17:29, Tao Chen 写道:
> 在 2025/11/14 00:01, Yonghong Song 写道:
>>
>>
>> On 11/12/25 8:31 AM, Tao Chen wrote:
>>> As Alexei noted, get_perf_callchain() return values may be reused
>>> if a task is preempted after the BPF program enters migrate disable
>>> mode. The perf_callchain_entres has a small stack of entries, and
>>> we can reuse it as follows:
>>>
>>> 1. get the perf callchain entry
>>> 2. BPF use...
>>> 3. put the perf callchain entry
>>>
>>> And Peter suggested that get_recursion_context used with preemption
>>> disabled, so we should disable preemption at BPF side.
>>>
>>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>>
>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>>
> 
> Hi eBPF maintainers,
> 
> This patch appears to have missed the eBPF maintainers on the list, 
> please review it again, thanks.
> 

ping...

-- 
Best Regards
Tao Chen

