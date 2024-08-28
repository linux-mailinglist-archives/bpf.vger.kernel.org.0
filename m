Return-Path: <bpf+bounces-38275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0919696296C
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 15:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A59C1C23C83
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 13:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E813D187FE5;
	Wed, 28 Aug 2024 13:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="sYMNH8Fj"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCE9166F12;
	Wed, 28 Aug 2024 13:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724853345; cv=none; b=j279QQllSulbOQifc1KV7ISZwnqtmqL+rC57tKd1Rb9XhDVa/cUkdvFtfk+3s416caMfXnJspAQFGvqu70zEgkN8jNauqTpLxPvWVVbnn2Yz0lOaR16Z+PEV9gnqCm5r5ULiXhGgZ84aD0htZWWL+ln9hryA0iJFD2iOFGqv5wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724853345; c=relaxed/simple;
	bh=FmCYspisTCQpwHF/NurpB9RXdm79uGq+/21JQtFsC0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ufmlyp8JOkhvPaMqjw7xw4kb0d/wjl8TqgTIWI6U9XSKE50+wP8H9UH4A1w3vWj61bTNT92AzQ60NZ19uhAVk1ESENY1aQ5uZBL+Y3chIkD3mSNS9g5+K+zv2xtmZHzSUMYbfGyzbcuHPIEswr3nuFK29gVs8vnC+pHYeck/z4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=sYMNH8Fj; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1724853342;
	bh=FmCYspisTCQpwHF/NurpB9RXdm79uGq+/21JQtFsC0E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sYMNH8FjXRdmYJf8C85acwyKBmhv3U91GbRv9Cvzaf7ypCQ2ccHq1GvNMvm7FWFyw
	 xerl4zaXhfidrAlIOtWHGdCPltZMyXzZvzB0YCYRbPfIAtIFO08N+bs9a7A0aPu5zq
	 CvcfmH5uDHzLZqXo2N56IJ4uIaRm28jtfNDxul/eKlpgQl1drU9vBE4zN5qfgF0dVl
	 37ypjZ9oi/kdXDftXBxSSWm0eZAwYo7q3/18M36+HPxXwRccOg1ErYYeiCXHymnaGT
	 u7iA97OSzu3vZ1WnpNUL3bg5YAgTgDKRRYWEw80mUpjsoVQC97mnhOb4AN94XncMic
	 3s8F2cyFjwuHg==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Wv5XZ06TQz1JcM;
	Wed, 28 Aug 2024 09:55:41 -0400 (EDT)
Message-ID: <d83bdff2-2665-4dcb-ab1d-c102bde7b46a@efficios.com>
Date: Wed, 28 Aug 2024 09:55:17 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/8] tracing/bpf-trace: Add support for faultable
 tracepoints
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>,
 Michael Jeanson <mjeanson@efficios.com>
References: <20240626185941.68420-1-mathieu.desnoyers@efficios.com>
 <20240626185941.68420-7-mathieu.desnoyers@efficios.com>
 <20240702090202.bc000b44890fe16d9b757b40@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20240702090202.bc000b44890fe16d9b757b40@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-07-02 02:02, Masami Hiramatsu (Google) wrote:
> On Wed, 26 Jun 2024 14:59:39 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> @@ -2443,9 +2443,15 @@ static int __bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *
>>   	if (prog->aux->max_tp_access > btp->writable_size)
>>   		return -EINVAL;
>>   
>> -	return tracepoint_probe_register_prio_flags(tp, (void *)btp->bpf_func,
>> -						    prog, TRACEPOINT_DEFAULT_PRIO,
>> -						    TRACEPOINT_MAY_EXIST);
>> +	if (tp->flags & TRACEPOINT_MAY_FAULT) {
>> +		return tracepoint_probe_register_prio_flags(tp, (void *)btp->bpf_func,
>> +							    prog, TRACEPOINT_DEFAULT_PRIO,
>> +							    TRACEPOINT_MAY_EXIST | TRACEPOINT_MAY_FAULT);
>> +	} else {
>> +		return tracepoint_probe_register_prio_flags(tp, (void *)btp->bpf_func,
>> +							    prog, TRACEPOINT_DEFAULT_PRIO,
>> +							    TRACEPOINT_MAY_EXIST);
>> +	}
> 
> nit: you can also just pass the flag directly,
> 
> 		return tracepoint_probe_register_prio_flags(tp, (void *)btp->bpf_func,
> 							    prog, TRACEPOINT_DEFAULT_PRIO,
> 							    TRACEPOINT_MAY_EXIST | (tp->flags & TRACEPOINT_MAY_FAULT));
> 

I'll do that for both the ftrace and the bpf patches and eliminate this
odd duplication. That's a good idea.

I'll add your Reviewed-by to all the "tracing/*" patches.

Thanks,

Mathieu

> But others looks good to me.
> 
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Thank you,
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


