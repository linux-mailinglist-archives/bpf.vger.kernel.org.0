Return-Path: <bpf+bounces-45188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BE49D2878
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 15:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8964D1F231AC
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 14:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42491C4608;
	Tue, 19 Nov 2024 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tqzdF9pW"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CA512B93
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732027571; cv=none; b=hEcbDpbZRjJucqlC8qMJm96VePEO1+lz+WzVAdAFpKwrb3FyfwIPX9MCiaW/EvmE1P7N8wRwcq7A9pOGTp5ItETOxiW2614dqFLqqHCVkZgMIttrl/eZICKIHxENqnceDC7nhKvx13/ilT15KOH1vm4/J+iRO/FSzrlOLNnHYfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732027571; c=relaxed/simple;
	bh=SSIKxmB2fh1W69s26nybQf6B+XQvQkwxPHdKhXyUFK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hgmopEcT/AG58ktqUHnyib0Q1J78ChDXFPFoDC2Jra5Nw2Wnk8UlvgP4nmkLKpqCRTy9MyihI7hd3cfQOykFJArMzKtItz0oLQ2/hd6OcD63awISk7VirZtn5eWoIEQszNata4b1F1eWb/HBBAx8hj+TrbLniP09w0mIJ0AkNJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tqzdF9pW; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <de9a2138-39ee-46ce-9838-f6d6a4dde747@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732027561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FF/T4hhTCAKYsTlyXmjfOHtqpoESmMEYBoYdcHTjVxo=;
	b=tqzdF9pW1OALLcKZA9JQwyYaNmPmHSWppFHMEO6brUcSikR/JK2fE/6Qe/d7GP/PLIz2I+
	cD4KTsQtz4VLfAJzYl0njvPlh8JvDZetYEvbYMnSTGj4mffZPbj1ILXBkokLDsVuQGBNdw
	nxRTbFSnhGtiJnS8O0YgqsKE3dkWEPI=
Date: Tue, 19 Nov 2024 06:45:57 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 4/4] selftests/bpf: add usage example for cpu
 cycles kfuncs
To: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Yonghong Song <yonghong.song@linux.dev>, Mykola Lysenko <mykolal@fb.com>,
 x86@kernel.org, bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>
References: <20241118185245.1065000-1-vadfed@meta.com>
 <20241118185245.1065000-5-vadfed@meta.com>
 <20241119114714.GD2328@noisy.programming.kicks-ass.net>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241119114714.GD2328@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 19/11/2024 03:47, Peter Zijlstra wrote:
> On Mon, Nov 18, 2024 at 10:52:45AM -0800, Vadim Fedorenko wrote:
> 
>> +int bpf_cpu_cycles(void)
>> +{
>> +	struct bpf_pidns_info pidns;
>> +	__u64 start;
>> +
>> +	start = bpf_get_cpu_cycles();
>> +	bpf_get_ns_current_pid_tgid(0, 0, &pidns, sizeof(struct bpf_pidns_info));
>> +	cycles = bpf_get_cpu_cycles() - start;
>> +	ns = bpf_cpu_cycles_to_ns(cycles);
>> +	return 0;
>> +}
> 
> Oh, the intent is to use that cycles_to_ns() on deltas. That wasn't at
> all clear.

Yep, that's the main use case, it was discussed in the previous
versions of the patchset.

> 
> Anyway, the above has more problems than just bad naming. TSC is
> constant and not affected by DVFS, so depending on the DVFS state of
> things your function will return wildly different readings.

Why should I care about DVFS? The use case is to measure the time spent
in some code. If we replace it with bpf_ktime_get_ns(), it will also be
affected by DVFS, and it's fine. We will be able to see the difference
for different DVFS states.

> Why do you think you need this?


