Return-Path: <bpf+bounces-40588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 304D798A9C5
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 18:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73F671F22469
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 16:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22236194120;
	Mon, 30 Sep 2024 16:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZRZUjFHK"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F6C192D82
	for <bpf@vger.kernel.org>; Mon, 30 Sep 2024 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727713795; cv=none; b=iJUhjcpII2paPYIGNo061SPX7dNifqes2Ug4e6fTH/6w4b8J2AQbvkusN2nQBekGK9eNPqD6mW0ZpV8gSXtbkIvRFm2thVXAPL8ac2Nn0m2UlzVHo+H1USdASxt1RbZZ4s9x3uJ4S04lZDCtM97M6SzHrUOlxMrGRYIYkJ//ons=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727713795; c=relaxed/simple;
	bh=muuFY/RQr/bOU0v4/s91wTg4gdxJw/bSNPuL2VpLnOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uOrA/wZPfTh7CoyyTRtqt10TLroqAy5RW2YMzEfw6yXCfjgFQyH/NN0IkE2JXHWvIr8zJdOf4Il95rxvysDf63C643Y1CuNuvJ0kSj0BT2stB/mT4gRn6Jeq4vxerPCEXOZB5lEY0FIyBy0fMz7YlYXf2s6OoaKBof5eO8LaTk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZRZUjFHK; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4c1a468b-c689-4e79-816b-57677065f4f8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727713792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oe/RR50AvyLjcyuRWGRrBbUh1LETKJI1ndjy+pL+nMI=;
	b=ZRZUjFHKStkEWumGqYzarQv0BNGdX5FovZcBPqhd4/rvg8U1cALRpmXvTwOzLNPOPCaSn+
	Dcw1sN9u2NKbtzMua4m8/f55u7dY1Yyq3zye+tce1LLj91kSRmdoEXrf1z2urZFyHPrPW/
	/qDQLvT8A8JXIEQ9jNkxQqaGu7gbNKc=
Date: Mon, 30 Sep 2024 09:29:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 4/5] bpf, x86: Add jit support for private
 stack
Content-Language: en-GB
To: kernel test robot <lkp@intel.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240926234526.1770736-1-yonghong.song@linux.dev>
 <202409291637.cuQ0jRdD-lkp@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <202409291637.cuQ0jRdD-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 9/29/24 1:31 AM, kernel test robot wrote:
> Hi Yonghong,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on bpf-next/master]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Yonghong-Song/bpf-Allow-each-subprog-having-stack-size-of-512-bytes/20240927-074744
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> patch link:    https://lore.kernel.org/r/20240926234526.1770736-1-yonghong.song%40linux.dev
> patch subject: [PATCH bpf-next v3 4/5] bpf, x86: Add jit support for private stack
> config: x86_64-randconfig-122-20240929 (https://download.01.org/0day-ci/archive/20240929/202409291637.cuQ0jRdD-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240929/202409291637.cuQ0jRdD-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202409291637.cuQ0jRdD-lkp@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
>>> arch/x86/net/bpf_jit_comp.c:1503:47: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *private_frame_ptr @@     got void [noderef] __percpu *[assigned] private_frame_ptr @@
>     arch/x86/net/bpf_jit_comp.c:1503:47: sparse:     expected void *private_frame_ptr
>     arch/x86/net/bpf_jit_comp.c:1503:47: sparse:     got void [noderef] __percpu *[assigned] private_frame_ptr

Okay, will make the change by adding __percpu to furnction parameter type.

>
> vim +1503 arch/x86/net/bpf_jit_comp.c
>
>    1442	
>    1443	#define __LOAD_TCC_PTR(off)			\
>    1444		EMIT3_off32(0x48, 0x8B, 0x85, off)
>    1445	/* mov rax, qword ptr [rbp - rounded_stack_depth - 16] */
>    1446	#define LOAD_TAIL_CALL_CNT_PTR(stack)				\
>    1447		__LOAD_TCC_PTR(BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack))
>    1448	
[...]

