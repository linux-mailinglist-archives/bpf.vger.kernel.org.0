Return-Path: <bpf+bounces-59823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A8FACFB43
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 04:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4031718985C1
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 02:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6355C3B1A4;
	Fri,  6 Jun 2025 02:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w+6KgyMH"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A622029A9
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 02:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749177095; cv=none; b=LGh8/izssjEn2KOMOPXBdY/4JYSL+EkiY5O9aNwJp2hoqxroQL/ep3RHTo+Kuur8UfHwKCudjfee2Sx5Hr66eQawl/XYfCqrxCFZdFRTmZv8cXnBZKVuCSJNxMTbuw4Mpk3VcqBdfj7fxy8p5Bz2+pbklU8YXpWRRDHEKRje92Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749177095; c=relaxed/simple;
	bh=NHbJRMovU5g1h1phG6fHk9x/84oGG3tK+HK1g+xz/uU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o3rGTPV+BUzZMm+XfyXM1LKcO6JtsXrRIFVCS5MvLKNqlFeob5vDKHUB2YKLAaFwojLVptnOoL5EZ2uQsZumu4oqVIxm5pVX9A05CKy/6CaaawCo+2wcPpH2ROPKnPA2NLgxcWQZcYDARKT4DtP2PHApT7Cxp+KVCsgk2UGuoEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w+6KgyMH; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <29d26dea-a0c1-4b1d-adf5-6161c4b16c0d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749177088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aaVf2/WsdO7AkFVReBhXK3K/lsQylWvH/nAD0ji5RbE=;
	b=w+6KgyMHLmbfykr6belYApv97m3vg6x8PktJwYUoVSdbsyV7dxs71UUiGd69gjYyFL4bCp
	LgV09goKUHkelW7RmTjxjysj/rZMTMGMxRzqk7DKfCufLfSPLE74mZBZauIq2BCekkUnRA
	XFneJ4rzQAQ/ehA7V+FmXNGb27dWspk=
Date: Fri, 6 Jun 2025 10:31:15 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Add show_fdinfo for perf_event
To: Jiri Olsa <olsajiri@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250604163723.3175258-1-chen.dylane@linux.dev>
 <aEIR8SBXrV9PgQ0L@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <aEIR8SBXrV9PgQ0L@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/6/6 05:53, Jiri Olsa 写道:
> On Thu, Jun 05, 2025 at 12:37:22AM +0800, Tao Chen wrote:
> 
> SNIP
> 
>> +static void bpf_perf_link_fdinfo_uprobe(const struct perf_event *event,
>> +					struct seq_file *seq)
>> +{
>> +	const char *name;
>> +	int err;
>> +	u32 prog_id, type;
>> +	u64 offset, addr;
>> +	unsigned long missed;
>> +
>> +	err = bpf_get_perf_event_info(event, &prog_id, &type, &name,
>> +				      &offset, &addr, &missed);
> 
> hi,
> addr now gets ref_ctr_offset:
>    823153334042 bpf: Add support to retrieve ref_ctr_offset for uprobe perf link
> 
> so let's display that
> 

will add it in v2, thanks.

> thanks,
> jirka
> 
> 
> 
>> +	if (err)
>> +		return;
>> +
>> +	if (type == BPF_FD_TYPE_URETPROBE)
>> +		type = BPF_PERF_EVENT_URETPROBE;
>> +	else
>> +		type = BPF_PERF_EVENT_UPROBE;
>> +
>> +	seq_printf(seq,
>> +		   "name:\t%s\n"
>> +		   "offset:\t%llu\n"
>> +		   "event_type:\t%u\n"
>> +		   "cookie:\t%llu\n",
>> +		   name, offset, type, event->bpf_cookie);
>> +
>> +}
>>   #endif
>>   
> 
> SNIP


-- 
Best Regards
Tao Chen

