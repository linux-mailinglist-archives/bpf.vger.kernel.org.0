Return-Path: <bpf+bounces-43553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F81A9B6645
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 15:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF7EB1F21CBF
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 14:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6C91F4711;
	Wed, 30 Oct 2024 14:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="wbith0Z4"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F56B1EF92C;
	Wed, 30 Oct 2024 14:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730299465; cv=none; b=HWmmM05+9vDhN9tZfk9T/CXNCz3ZkRymCGmUsnTlnuBBiywifbCuPbSo2DtmJQzK1pkFGXzJpWhZpzqfBU+NrmhxaD6YndRGoiB2vJ+cmD3RxW6cDMMnd5Zz8n/g1am/311dYgED+stgjyFu/uZGnHGQZyOKOMLIQ9rqWk6ef3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730299465; c=relaxed/simple;
	bh=z5b+ZJLDzyjbUCMVAcP4EsLW34usezSkpLXV0vWtgss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eGtEEWBz4noW2rpPQBQvZKU5X6XipMtlw1BkFV4oFKd8krnFN57wUXbkv29mpjHbNhn/rMqqK5KH/MkGedQKFFnmVmo5HV57i93HQji7/sB680LP5/YGLubcKJAmjzZ1yw/HepJFupu0e/Aayl6H0j9HI18jg/71S4/uR7obQVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=wbith0Z4; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1730299461;
	bh=z5b+ZJLDzyjbUCMVAcP4EsLW34usezSkpLXV0vWtgss=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=wbith0Z4ftepVN0kCdg9O/W0pDd3JcQdljZaB6qkH6obhaFEKfuhp125U2avoTKSG
	 OB8Pn/GZm2UuGB5jFCEPCG57ilPqnzZaF6MD71nxfPriebNOIEHcgwArJLxosQd8AQ
	 bppx4fNLPvzefwxyOdJBrpxOuuRNZw7LYVlDvRykUW5CD6HW+VaJExdiGnx5n6ZX5W
	 VLq7ZbnntsYU8JzGXcyMSUiuAqGoW8aBEF5PRsRFnbFiaJZZMHT8YSa8+qK+NZ3kb5
	 KqktJYsssOopVwBfdNmqOZzqLR/+hsE4r7XhWNeQaFDKYTMwYEo3QvbJouMhXF9iA9
	 RaxMRQcfpkF1A==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Xdqdc68yXzL14;
	Wed, 30 Oct 2024 10:44:20 -0400 (EDT)
Message-ID: <91b9202c-6124-44ec-9d44-4556fa21dd41@efficios.com>
Date: Wed, 30 Oct 2024 10:42:43 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 4/4] tracing: Add might_fault() check in
 __DO_TRACE() for syscall
To: Jordan Rife <jrife@google.com>
Cc: acme@kernel.org, alexander.shishkin@linux.intel.com,
 andrii.nakryiko@gmail.com, ast@kernel.org, bpf@vger.kernel.org,
 joel@joelfernandes.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com,
 mhiramat@kernel.org, mingo@redhat.com, mjeanson@efficios.com,
 namhyung@kernel.org, paulmck@kernel.org, peterz@infradead.org,
 rostedt@goodmis.org, tglx@linutronix.de, yhs@fb.com
References: <CADKFtnT59wzKxob03OOOfvVh67MQkpWvzvfmzv3D-_bGeM=rJA@mail.gmail.com>
 <20241029002814.505389-1-jrife@google.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20241029002814.505389-1-jrife@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-28 20:28, Jordan Rife wrote:
>> I can test this later today. Considering there needs to be a fix on
>> the BPF side to fully resolve the use-after-free issue reported by
>> syzbot, I may combine your v4 patch with the bandaid fix which chains
>> call_rcu->call_rcu_tasks_trace I made earlier while running the
>> reproducer locally.
> 
> Testing this way, the series LGTM. Here's what I did starting from
> linux-next tag next-20241028.
[...]
> Tested-by: Jordan Rife <jrife@google.com>
> 

Thanks! I'll add your tested-by tags and send a v5 non-RFC.

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


