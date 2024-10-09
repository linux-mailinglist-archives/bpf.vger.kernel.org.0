Return-Path: <bpf+bounces-41318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D72995C76
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 02:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99CA9B21EA6
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 00:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0AEBA53;
	Wed,  9 Oct 2024 00:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="PzJNVlEo"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0F23C39;
	Wed,  9 Oct 2024 00:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728435106; cv=none; b=p/qOSxpzOG4B8V8I1mcfyGAo+YZm3sOQsPmvz+bA3tWFmoqtbiPC1V90K+8c058GbqklY1+95dTFYAe6xVAej0MFmISGgdRryrGjhFHUOi7Lt6H5UcgxTYN1/M5iNLsDK4c4OZ0YYnGSAcWL9iSvRMpZow/5BQQBAPQLSWT6FvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728435106; c=relaxed/simple;
	bh=1XfTTdw5dQ3fF+V6PcEuPOr8WlFewqaZxrEX7tEQlPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FtleL6MWBpTNqUdeL9uvVTWsQF39iQjXp+5X1SNbl3+zGFI+hT/vkmZLPuiItUxjln1Vr22iCulCItYH/bfL8lYTnEmW9pP+Bm3xRY31ioriFzrz50EmRZkoyQe9HV5lAlxzIBnhJ0hE7z1Nnqzs8/+Q12vE4rC35i/p3yM+WYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=PzJNVlEo; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728435101;
	bh=1XfTTdw5dQ3fF+V6PcEuPOr8WlFewqaZxrEX7tEQlPA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PzJNVlEouMt6HNBOUo3QVQL3MlE4zwmQSabtdOsnLfFoDNUOq3YW8Qwo/1TUwiL0H
	 8pxQQKGGOUXw/UamEbOIxadr0BngBmubpWM5HygCA4uoFVs4SITlsi8Q9qX93e8mUY
	 zTIyogVfk1oeSZdCD3lkTOY8b/xHKCs3EhpjVLXpYWjSUCvjxW6es6soOntpM/vKMC
	 SpiFVvSlxg557I1zyP706eW5Ve4vOc9LJpzlSnWn04+RKYkgNuu0iCDPvZ1xC2yvyj
	 7+IxB59DAUR03NmVg13y6ayrUlxT3801qoqPSYTghbtPqe3Xbm8kUGreuAnJqQI6bs
	 y6aob3kuK5hlA==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XNZ8Y4Kx5zRwV;
	Tue,  8 Oct 2024 20:51:41 -0400 (EDT)
Message-ID: <cbd40019-9034-4aad-a632-f63f16a9c9e3@efficios.com>
Date: Tue, 8 Oct 2024 20:49:43 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] tracing/ftrace: guard syscall probe with
 preempt_notrace
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Namhyung Kim <namhyung@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>, linux-trace-kernel@vger.kernel.org,
 Michael Jeanson <mjeanson@efficios.com>
References: <20241004145818.1726671-1-mathieu.desnoyers@efficios.com>
 <20241004145818.1726671-3-mathieu.desnoyers@efficios.com>
 <20241008191957.6cb66fa2@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20241008191957.6cb66fa2@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-09 01:19, Steven Rostedt wrote:
> On Fri,  4 Oct 2024 10:58:12 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> +		      PARAMS(assign), PARAMS(print))			\
>> +static notrace void							\
>> +trace_event_raw_event_##call(void *__data, proto)			\
>> +{									\
>> +	guard(preempt_notrace)();					\
>> +	do_trace_event_raw_event_##call(__data, args);			\
>> +}
>> +
> 
> Do we really need to use "guard()" for a single line function? Why make the
> compiler do more work?
> 
> static notrace void							\
> trace_event_raw_event_##call(void *__data, proto)			\
> {									\
> 	preempt_disable_notrace();					\
> 	do_trace_event_raw_event_##call(__data, args);			\
> 	preempt_enable_notrace();					\
> }
> 
> Is more readable.

I don't care. I'll do it your way (for all 3 patches).

Thanks,

Mathieu

> 
> -- Steve

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


