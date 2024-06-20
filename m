Return-Path: <bpf+bounces-32600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B177991093A
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 17:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B2471F24743
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 15:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9461A1AF6A1;
	Thu, 20 Jun 2024 15:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="hVD1FHm7"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718041ACE94;
	Thu, 20 Jun 2024 15:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895847; cv=none; b=obr7RXXVZhLhXe0dKp0IYU7ZRhIPciTtmBNiNUa8KFkAmBqhZfjcsYya2wjOcx+L7e17P42aKBn9nKvY58uXZTfFECmUkLFyDIckm3mpYe2IeC0Xqnm1m2uGRpFEuSG0fVlAdlsfgRhSPuiyjosWkumiGLLl3CSIA2eyf5dNQMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895847; c=relaxed/simple;
	bh=WuKsR5UCbBJdInJyClNe/aw+42aigHkyrGRbdfRklW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LW59T9PYXC69U6ExGHONud7sAhADj0Gk3ATKgHzHE/wpSTGpayWmC/kt6K/rdvnDVsZpqveHjZyM0Sfy55gYYJYUGiA7nkCaETDjrweiGpMYcuoZsVct3w+p8StKSjO8y5FZNDPpoTnAsMHjqNlpLO3wc3yGwiaT58vCs2DP9OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=hVD1FHm7; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1718895833;
	bh=WuKsR5UCbBJdInJyClNe/aw+42aigHkyrGRbdfRklW0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hVD1FHm7pxjswQzkufkpU1KL8KIbfAHlzLTn63xzLlja4Ii/JWN+UcyZVGQRTiuMB
	 nvl3LSV7SRiOLsTXRgJiRearwY8pWFi0tb94QqS7axqABRoMzObOcROuqdpoy42pZG
	 Cp6h73cn05YOSfJHPQu8mlshaOq7l7AD/8l101dHjIt/fjBOkWbUWdb9PoEjsuX5qc
	 opcv40oOcqq2WAtV43C0XX3tpybKo2IOXHLvSIj1bdn7vr5eMxPGQD7urEotYxVfSz
	 pkVlIjRO5yJbQZHAa1ytpUXwg7TL3AvRP4O6z1Qjv5A/g+mjn89ljZ878wfTEgR1n4
	 cU2jMPTVAPENQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4W4kK45BBTz16rQ;
	Thu, 20 Jun 2024 11:03:52 -0400 (EDT)
Message-ID: <10158845-ecbf-491e-bcde-a40453f8b94c@efficios.com>
Date: Thu, 20 Jun 2024 11:04:53 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] tracing/ftrace: Add support for faultable
 tracepoints
To: Peter Zijlstra <peterz@infradead.org>,
 Michael Jeanson <mjeanson@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
 "Paul E . McKenney" <paulmck@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>
References: <20231120205418.334172-1-mathieu.desnoyers@efficios.com>
 <20231120205418.334172-3-mathieu.desnoyers@efficios.com>
 <20231120221524.GD8262@noisy.programming.kicks-ass.net>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20231120221524.GD8262@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-11-20 17:15, Peter Zijlstra wrote:
> On Mon, Nov 20, 2023 at 03:54:15PM -0500, Mathieu Desnoyers wrote:
>> @@ -380,8 +415,8 @@ static inline notrace int trace_event_get_offsets_##call(		\
>>   
[...]
> 
> I think something like the below (which is on top of the cleanup patch
> in tip/locking/core) might just do...

[ guard stuff ]

Yes, we will apply those suggestions, thanks!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


