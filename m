Return-Path: <bpf+bounces-44990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9479CF621
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 21:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22F17283B0E
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 20:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300D51D88D7;
	Fri, 15 Nov 2024 20:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dXepBwnf"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6811C18734F
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 20:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731702644; cv=none; b=Yw65yji2FTLJiSX7YX8Mjc8skqbbsHgCdofCDVGE55wNmKyFAhVEL7IgIxjF91bVuY3zAWQEhpRMkSOWphJypBp3e9IEBUZat0hHGFyhCxgzLU2W9wF9usY0wEz9mds5lrl9eWcCBzmeGx2Ny3+7PZld66Yik12Ujzq6Coi6PZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731702644; c=relaxed/simple;
	bh=CM84SrJezuzmOpN6LVe9EgX27jckeqPDN1QXT5XjgHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pXSoiZyDv7g5SuT/dmDbq4ncIOVCGUtJWySqbXOMfTf8ymrE/VrFfhV84OOEppKENeQXLZ+zenpU1AoqNupisBxZFb9pDdP+3qd8WwzvcYpY0+Ua9N/5pX6oCFSm8mC1fEHGYBRrSn8m4/WzASqDxfIOZ3mCY2y/GWTOT0c55Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dXepBwnf; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d4b9a5ef-47f6-42bb-8fcf-2accdd9a90fe@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731702639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fIaHfkZG4XX9n401199GqVU1XpMrpvgjm3qMWzCodUI=;
	b=dXepBwnfvqgWpuVg2HhYAq4BqZ23a8QPjbe0LbIsYnfVGTez7/Si/HeSv7U5PcUUa1mXj1
	GVIsf0LnXSp3L7oQjOv370mj+H0VNErPhqLBKE1Bh5gveznLwu28e5F67L4TQlK5+wJl3z
	H2InwL5jBQy/Y+wUJ9kpwR6Bg6dAAQ0=
Date: Fri, 15 Nov 2024 20:30:32 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 0/4] bpf: add cpu cycles kfuncss
To: Borislav Petkov <bp@alien8.de>, Vadim Fedorenko <vadfed@meta.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Mykola Lysenko <mykolal@fb.com>, x86@kernel.org, bpf@vger.kernel.org,
 Martin KaFai Lau <martin.lau@linux.dev>
References: <20241115194841.2108634-1-vadfed@meta.com>
 <20241115201554.GBZzer-s-_-k6aLlJ9@fat_crate.local>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241115201554.GBZzer-s-_-k6aLlJ9@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 15/11/2024 20:15, Borislav Petkov wrote:
> On Fri, Nov 15, 2024 at 11:48:37AM -0800, Vadim Fedorenko wrote:
>>   arch/x86/net/bpf_jit_comp.c                   |  60 ++++++++++
>>   arch/x86/net/bpf_jit_comp32.c                 |  33 ++++++
>>   include/linux/bpf.h                           |   6 +
>>   include/linux/filter.h                        |   1 +
>>   kernel/bpf/core.c                             |  11 ++
>>   kernel/bpf/helpers.c                          |  32 ++++++
>>   kernel/bpf/verifier.c                         |  41 ++++++-
>>   .../bpf/prog_tests/test_cpu_cycles.c          |  35 ++++++
>>   .../selftests/bpf/prog_tests/verifier.c       |   2 +
>>   .../selftests/bpf/progs/test_cpu_cycles.c     |  25 +++++
>>   .../selftests/bpf/progs/verifier_cpu_cycles.c | 104 ++++++++++++++++++
>>   11 files changed, 344 insertions(+), 6 deletions(-)
>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/test_cpu_cycles.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/test_cpu_cycles.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/verifier_cpu_cycles.c
> 
> For your whole set:
> 
> s/boot_cpu_has/cpu_feature_enabled/g

thanks, will change it for the next version
> 
> Thx.
> 


