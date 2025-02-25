Return-Path: <bpf+bounces-52569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16061A44E0C
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 21:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3729188D4F9
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 20:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7341F4164;
	Tue, 25 Feb 2025 20:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NuJ7t/RE"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B63DF59
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 20:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740516820; cv=none; b=hKLQQxIreC0dhD1vVYVtGKdoiEl5UTb/POTW45AEJXpK8a7bnCU4wJLK25/oYDTuV+mvcHk7HZ5DGeMloKpqAP0Pb2iSHqpqMsEcUvnjuDaHHkBxqyn2KFElSfcynadXFhWmJlqIZ2aRpAjV2Y9To9qAPriucMrAaxv2gewHOdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740516820; c=relaxed/simple;
	bh=GVA54mWbzq0mqaRYdkbPHl66a66l2isdp69Xp1JKYuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lw8GFO/iGG7wmj6I8omCp4mE50Y+RviHiecbooSOxF0FZQUbuUwYhrt3K5kmQ129mXNYNYF44psMoNWSAhw/++fU3S+T/y6Hanha42eGeR7jcfiI9XCgmJSZ+6LU9etI7e3GjGl+TDkcnNHLdeAQ5X71/jJ4DiUBJJ1LCqbSNZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NuJ7t/RE; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a53a4ae7-304c-4409-a273-09b85ac65b68@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740516816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9jbjY1f/ZwBuEF7UZXm4OFc1g96I/soufo9nDTOB1TM=;
	b=NuJ7t/REf6hHGgj343yui7BoR9sU+ITJ1UQlcYhMjfUkEYQP9CXZ9csBT2hKHNtT2k1Byd
	caMJX/UUq0tVI1hKqYXuVdNWylAAijXS/6XK+H6FUlWYkPye0pfTSyUoFyaOuveGF3cQai
	vyD+Dh7m/M0+rlC944DTohYgfMOQSKU=
Date: Tue, 25 Feb 2025 12:53:31 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Test gen_pro/epilogue that
 generate kfuncs
To: Amery Hung <ameryhung@gmail.com>
Cc: daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com,
 martin.lau@kernel.org, eddyz87@gmail.com, kernel-team@meta.com,
 bpf@vger.kernel.org
References: <20250221164721.1794729-1-ameryhung@gmail.com>
 <20250221164721.1794729-2-ameryhung@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250221164721.1794729-2-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/21/25 8:47 AM, Amery Hung wrote:
> +static int st_ops_gen_epilogue_with_kfunc(struct bpf_insn *insn_buf, const struct bpf_prog *prog,
> +					  s16 ctx_stack_off)
> +{
> +	struct bpf_insn *insn = insn_buf;
> +
> +	/* r1 = 0;
> +	 * r0 = bpf_cgroup_from_id(r1);
> +	 * if r0 != 0 goto pc+6;
> +	 * r1 = stack[ctx_stack_off]; // r1 will be "u64 *ctx"
> +	 * r1 = r1[0]; // r1 will be "struct st_ops *args"
> +	 * r6 = r1->a;
> +	 * r6 += 10000;
> +	 * r1->a = r6;
> +	 * goto pc+2
> +	 * r1 = r0;
> +	 * bpf_cgroup_release(r1);
> +	 * r0 = r6;

I think r6 is not initialized on the "r0 != 0" case.

Others lgtm.


