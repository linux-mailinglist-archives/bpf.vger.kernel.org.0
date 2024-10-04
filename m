Return-Path: <bpf+bounces-40909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A5598FBF2
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 03:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD491C2248C
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 01:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CBB11CBD;
	Fri,  4 Oct 2024 01:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ht5UvNmu"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A31D29E;
	Fri,  4 Oct 2024 01:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728005773; cv=none; b=hoS+a4oRF1gf7QqqQ6JXnagb+9Ps/r8lgXLIV4qS8cE/cq4I6nVBePh4dG2kNj5rB1l/ZqWp6aaK57pve/Y+nKZgtkE8Ib7RCkFlj9KxQk57WBnVjTCFf8k59JjvGvXDcUptMK975+5GCveI/SzvFbSA63xTPn5OqTdfhbicyfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728005773; c=relaxed/simple;
	bh=a/aPymda4W16ux4IAgQFTKgKS+k2ZBZVZpG58sBbX3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uV480I2fokB5wrx57sQ0paNyrk8ETQY6braaie85BYNVAr+/0ojdMKvFPxvBgnKrNPlOmjfw08uk+S1PkPA71rAMKnf18RWjD3BfQ8MV59eBLvTXA16NVdjxAiJheQNODEMoG7UCx7aD855rYiMtRIaucrTq2mTXe/OC6LXUJDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=ht5UvNmu; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728005770;
	bh=a/aPymda4W16ux4IAgQFTKgKS+k2ZBZVZpG58sBbX3o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ht5UvNmuWkSbel9GpM5PTnZ1574PNVLSEmXbBOuIQPVC5PPs6LLSumUvuOuMnB5qf
	 ASvn3zH0Clr4MFFHvcCm6G2tJCNqRQeZDxxa4O05E2cYXbT9s3iMNs9T/uJnaaPtgt
	 AkpVOYdUrLtP8Meh+6OLgFJ5pGW6mQqnvqhOseSZlIswfwY3iRssS6caUix+jTAsab
	 Iv9PR+kZWiwM7AxRAiFA+4u8R77PAhZqpqOpy0bLTDYyiwKvRXJ2P14Y7a2u3DeoAi
	 dmBbiCi8GdzecIW70crYt5/9gBUcsYfgfqNvAoaaWWo5qZhmhP3easpqSgH8MM2k+X
	 STLxF1ZKFrHYQ==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XKWNB4PcdzCCk;
	Thu,  3 Oct 2024 21:36:10 -0400 (EDT)
Message-ID: <58ecf4b1-28af-495e-9f9e-f9fb2dc67f7e@efficios.com>
Date: Thu, 3 Oct 2024 21:34:09 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/8] tracing: Declare system call tracepoints with
 TRACE_EVENT_SYSCALL
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
References: <20241003151638.1608537-1-mathieu.desnoyers@efficios.com>
 <20241003151638.1608537-2-mathieu.desnoyers@efficios.com>
 <20241003173225.7670a4f0@gandalf.local.home>
 <ecd8a2fe-22f4-4340-a80b-5bf7ccd74815@efficios.com>
 <20241003210636.497cbb61@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20241003210636.497cbb61@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-04 03:06, Steven Rostedt wrote:
> On Thu, 3 Oct 2024 20:15:25 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>>> Feel free to rebase on top of this patch:
>>>
>>>     https://lore.kernel.org/all/20241003173051.6b178bb3@gandalf.local.home/
>>>    
>>
>> I will. But you realize that you could have done all this SRCU and
>> rcuidle nuking on top of my own series rather than pull the rug
>> under my feet and require me to re-do this series again ?
> 
> I thought I was doing you a favor! It's removing a lot of code and would
> make your code simpler. ;-)

The rebase was indeed not so bad.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


