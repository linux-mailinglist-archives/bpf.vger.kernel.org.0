Return-Path: <bpf+bounces-45373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2BF9D4EBB
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 15:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC8BAB21535
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 14:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BC51D86F1;
	Thu, 21 Nov 2024 14:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i8zE/duj"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6824B5C1
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 14:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732199751; cv=none; b=MCpJRiULYJoVsoGsHVIM2bn9aaWAWLRhpi3as1sfOhZe4Kofl9VCDM3AgrESeGerUPoHS06MNJX6Ko3vE4+1VaFkN5GmZOS3Dn5Es9SKUZJuBwfoVOwlBK9HKjwdmBzs3Cc8hWdU/XRIE7zb4TWEiIOX2NcS2Fn3NXHscETGO0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732199751; c=relaxed/simple;
	bh=JyXn7wkLQ9cW9EoTUjDG3LcTdk6DayhCTptVALhR8b8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hobjWBuUWMafPjh5/k7PqbBMzSI/iiMuTG/NSdT44ggllVPGgMwnvDqmc9uFc/c4yJVd74UGWhTJdKQHAX/1JEsnf7JDzWlXQicLUyrOdnXpymqwCLHyNXqkpcd1lbGG32vuZbniWyxApzm+UC3dGXFaLi7h89AkfyGrCck+QvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i8zE/duj; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <482d32d5-2caa-4759-b3b1-765678ac42a2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732199746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZWqqTQ7QvVcKRBwBn1GBC6WXLakVcFHdgjYGfXvoGLw=;
	b=i8zE/dujqOMycxCOzjPkioZQLlPtVn/qMO1wR8Zsq1SZFhcKrEw9JWBvTPnrNz4BBZm2yN
	KQUxqz7D1a8ie4H9yIK5bNWHcfQSo20KZxrCUwdtuPraykSshcRQQXN42SGGq60pQaIs6u
	aSvC8CEORxMJIjEBR1KO+LKGZzdocvw=
Date: Thu, 21 Nov 2024 06:35:39 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 1/4] bpf: add bpf_get_cpu_time_counter kfunc
To: Peter Zijlstra <peterz@infradead.org>, Vadim Fedorenko <vadfed@meta.com>
Cc: Borislav Petkov <bp@alien8.de>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Yonghong Song <yonghong.song@linux.dev>, Mykola Lysenko <mykolal@fb.com>,
 x86@kernel.org, bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>
References: <20241121000814.3821326-1-vadfed@meta.com>
 <20241121000814.3821326-2-vadfed@meta.com>
 <20241121113202.GG24774@noisy.programming.kicks-ass.net>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241121113202.GG24774@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 21/11/2024 03:32, Peter Zijlstra wrote:
> On Wed, Nov 20, 2024 at 04:08:11PM -0800, Vadim Fedorenko wrote:
>> New kfunc to return ARCH-specific timecounter. For x86 BPF JIT converts
>> it into rdtsc ordered call. Other architectures will get JIT
>> implementation too if supported. The fallback is to
>> __arch_get_hw_counter().
> 
> Still not a single word as to *WHY* and what you're going to do with
> those values.
> 
> NAK

Did you have a chance to read cover letter?

