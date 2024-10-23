Return-Path: <bpf+bounces-42855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7A69ABADD
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 03:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70946B21E55
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 01:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0591B200A0;
	Wed, 23 Oct 2024 01:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="cJZZvQ2Z"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEE935280;
	Wed, 23 Oct 2024 01:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729645988; cv=none; b=XBvkhHDTgQTeZMBfC4klW/gxRbtlh2/8727Wo2R840iOORbKcu2WOAiSPHeiWEjp1bmlHBIQPn2eUQQw2sjJyumwzpt7vHKW+nBJ2ZImyrCloTHGHgSWiEeVa/RxzOn+AfW2cOUeXWF0bHqP7W5S3+2ilf6+S4+2QJGw1A+1o8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729645988; c=relaxed/simple;
	bh=ACHcwDC56L9952YIDkYI6k7t/jxIOgK1UbVm7HokZzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sdPqi3I6lFPAurrS9Vg/3+r7UhpdqaH0vdEGsd69zCAIM+D+DoK8H6WX9IbGJfMmj6obMhGerWdZALbyKnHvoUjdceysVKG0/OcEGU1fDi1eDoEiuqoIjgqKkAomhjm6B3ViJUyiB3qr6+4pr+7tb+hNFV0ywe8HJ953HOsvlY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=cJZZvQ2Z; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1729645984;
	bh=ACHcwDC56L9952YIDkYI6k7t/jxIOgK1UbVm7HokZzk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cJZZvQ2ZRZ6ebVGz0h5/YjJ250QOzZ4B//6WQZFJPahGsMKiweWuoWBUBCo6ux2Tl
	 sBDv3dyzDsqy11owTOKek5iDpH9PFveypBTHF7REtdho+60ZhjmP0uVptvTyq/J+p+
	 ILtxANbSSdVubaAwM5kH4aA4wM2/VOPXEPvtcY4iHr3Sj68Bh8CBr2zrN14h5Ffj1l
	 ysn4K8KNe31pD2By4w5SYqYiHWG8cIKiAyJdnL83GcK4hzxk4QcbDW3ZF+7iSquDr3
	 xgdgrb+lNPfbwyQkHPdI+oMIUoH4/fiCHYCBpLoiATWjLbm8vrgMBuz0GcVBjxo38y
	 CfUh/XJAqDfMw==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XY9ym0rFSzWhV;
	Tue, 22 Oct 2024 21:13:04 -0400 (EDT)
Message-ID: <134aa32a-f498-4111-940a-2f79af70878f@efficios.com>
Date: Tue, 22 Oct 2024 21:11:19 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tracing: Fix syscall tracepoint use-after-free
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Jordan Rife <jrife@google.com>, linux-kernel@vger.kernel.org,
 syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com,
 Michael Jeanson <mjeanson@efficios.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>
References: <20241022151804.284424-1-mathieu.desnoyers@efficios.com>
 <CADKFtnSGoSXm-r0cykucj4RyO5U7-HHBPx7LFkC6QDHtyPbMfQ@mail.gmail.com>
 <3362d414-4d6f-43a7-80af-1c72c5e66d70@efficios.com>
 <CAEf4BzYBR95uBY58Wk2R-h__m5-gV0FmbrxtDgfgxbA1=+u0BQ@mail.gmail.com>
 <1ab8fe0d-de92-49be-b10b-ebb5c7f5573a@efficios.com>
 <20241022202034.2f0b5d76@rorschach.local.home>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20241022202034.2f0b5d76@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-22 20:20, Steven Rostedt wrote:
> On Tue, 22 Oct 2024 16:04:49 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>>>
>>> That's just to say that I don't think that we need any BPF-specific
>>> fix beyond what Mathieu is doing in this patch, so:
>>>
>>> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>>
>> Thanks!
> 
> Does this mean I can pull this patch as is? I don't usually take RFCs.

It's only compile-tested on my end, so we should at least get a
Tested-by before I feel confident posting this as a non-RFC patch.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


