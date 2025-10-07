Return-Path: <bpf+bounces-70521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24389BC2504
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 20:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1111B189FC18
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 18:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E242B20371E;
	Tue,  7 Oct 2025 18:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k+z+Hnud"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B8119EEC2
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759860101; cv=none; b=CDMF0s470sPjyf2dRXZW0NmGaTAHHU78T2M24qeRQTh/cy+vdSNrYJSS/jA0E7xglVvH4A2MJnrv0iH3JZ/3VbM+5yWox5mM43/CT4fLdMK43MKqxAJr2eDJnocaeb6QOoBWfRel2Y+paUBulrOhb6H05AQB8NRXvIElvW80KXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759860101; c=relaxed/simple;
	bh=9mWeOaQUOG+JLdkzivLMVt9Gb5hTB1Y4d/ewsnn+SPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2e8So/32KJ+8EkWUHYv50jb3JsAVCdcJqh6yUwfo1I7XfKFn9e/yuV6pIwxHj0JGJVdyGelyKCa67JJL0gtDxHqgjkjGHjGOnpNa2KMeC5wAfwKEK1kFmzAO+uuXHpGxTIjPktiV990CR9scGLZAd/KEHeyzxbrc3KRKNtEZpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k+z+Hnud; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <62e288f3-9917-4218-84f7-01e2eb27130c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759860096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d+A1GzZU+eL0nxEbo9nyKU0O1jUbfQqPs7fYsL1XxQs=;
	b=k+z+HnudTE4rXmGRXhmJzOk48Gi/ftMAhom3kOlSzSU6ps3ZSdddJeUL58rUR64yZQ686r
	xNNtYMHQY+QoJG0Lnb06Ru2FDzI+hAoex52XHyCXLDjQykhZShgQEWwdU6ZcAw4oAfpbEF
	IDdG3CrLnidFXlu3YXDUvezJtS1tG9w=
Date: Tue, 7 Oct 2025 11:01:32 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 5/5] selftests/bpf: Test direct packet access
 on non-linear skbs
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Amery Hung <ameryhung@gmail.com>,
 bpf@vger.kernel.org
References: <cover.1759843268.git.paul.chaignon@gmail.com>
 <302cd8554710d04986925df1737c787c09b5ff65.1759843268.git.paul.chaignon@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <302cd8554710d04986925df1737c787c09b5ff65.1759843268.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/7/25 6:38 AM, Paul Chaignon wrote:
> +#define access_test_non_linear(name, type, desc, retval, linear_sz, off)			\
> +	SEC(type)										\
> +	__description("direct packet access: " #name " (non-linear, " type ", " desc ")")	\
> +	__success __retval(retval)								\
> +	__linear_size(linear_sz)								\
> +	__naked void access_non_linear_##name(void)						\
> +	{											\
> +		asm volatile ("									\
> +		r2 = *(u32*)(r1 + %[skb_data]);							\
> +		r3 = *(u32*)(r1 + %[skb_data_end]);						\
> +		r0 = r2;									\
> +		r0 += %[offset];								\
> +		if r0 > r3 goto l0_%=;								\
> +		r0 = *(u8*)(r0 - 1);								\
> +		r0 = 0;										\
> +		exit;										\
> +	l0_%=:	r0 = 1;										\
> +		exit;										\
> +	"	:										\
> +		: __imm_const(skb_data, offsetof(struct __sk_buff, data)),			\
> +		  __imm_const(skb_data_end, offsetof(struct __sk_buff, data_end)),		\
> +		  __imm_const(offset, off)							\
> +		: __clobber_all);								\
> +	}
> +
> +access_test_non_linear(test31, "tc", "too short eth", 1, ETH_HLEN, 22);
> +access_test_non_linear(test32, "tc", "too short 1", 1, 1, 22);
> +access_test_non_linear(test33, "tc", "long enough", 0, 22, 22);
> +access_test_non_linear(test34, "cgroup_skb/ingress", "too short eth", 1, ETH_HLEN, 8);
> +access_test_non_linear(test35, "cgroup_skb/ingress", "too short 1", 1, 1, 8);
> +access_test_non_linear(test36, "cgroup_skb/ingress", "long enough", 0, 22, 8);
> +
> +SEC("tc")
> +__description("direct packet access: test36 (non-linear, linearized)")
> +__success __retval(0)
> +__linear_size(ETH_HLEN)
> +__naked void access_non_linear_linearized(void)
> +{
> +	asm volatile ("									\
> +	r6 = r1;									\
> +	r2 = 22;									\
> +	call %[bpf_skb_pull_data];							\
> +	r2 = *(u32*)(r6 + %[skb_data]);							\
> +	r3 = *(u32*)(r6 + %[skb_data_end]);						\
> +	r0 = r2;									\
> +	r0 += 22;									\
> +	if r0 > r3 goto l0_%=;								\
> +	r0 = *(u8*)(r0 - 1);								\
> +	exit;										\
> +l0_%=:	r0 = 1;										\
> +	exit;										\
> +"	:
> +	: __imm(bpf_skb_pull_data),
> +	  __imm_const(skb_data, offsetof(struct __sk_buff, data)),
> +	  __imm_const(skb_data_end, offsetof(struct __sk_buff, data_end))
> +	: __clobber_all);
> +}

Does it have to be in asm?


