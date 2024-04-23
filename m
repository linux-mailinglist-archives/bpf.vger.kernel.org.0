Return-Path: <bpf+bounces-27591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECBC8AF806
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 22:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D4891C22519
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 20:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5788513E02C;
	Tue, 23 Apr 2024 20:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f/VzhVMx"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B591F95E
	for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 20:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713904401; cv=none; b=bZnavCc9uzygtlmFAHfmtUh2GrRJw9B03WMXGZVQDDVDlI+OcYvKfklLcxVrZHYdmVcoywaefjw8idH41lnVZguYp3tyuae9RRoCdQ7BPx2geDfJ+ne1MgthhFd1SfCQ+kSTqjOMSQitrrGyspvNAa1JRnQF3Xd9YTsAx9IGyWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713904401; c=relaxed/simple;
	bh=M8wFQq0T4aBeeAbFjMvAwjOipUKHQiA02FXx//LnwHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c5Jr74y2uhM2dqdNRva2QIPfnGM3STrp9rCuz6j0Sj8a/mAHGkWien3Uz/lAB+fvLO3z4ycrnokKPI8Sst8zorKWIewYDPomi5RGyITpDdImn6JKH/sTTGfbtUmVORpy9wq51aLYiHjHqVOM9Z4rbKNYlM6jdVTeIOJcBBNi8Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f/VzhVMx; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4ab9edca-6c3c-42df-877b-075ac33e4441@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713904397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hR5OKHW3iOzSja6YVmYVpLsys3mIBlnQGAhoIQPBgqI=;
	b=f/VzhVMx/r2YnwUSPd0NdhXrakOwPB4vyaVbs4kh0U/e3iMljfVwGQ+iGvY1M/QOs3ICaZ
	UZBqNsU79Qntfl/tWd74Q7Q6i69fj7VuFEC8wxSnfO/oU+nEPUQt6k1SD7PeF7fsUWgjqj
	i6S9Jk0whpZhF97p6qzN0ZDzY+XdYuc=
Date: Tue, 23 Apr 2024 13:33:13 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 3/5] selftests/bpf: XOR and OR range
 computation tests.
Content-Language: en-GB
To: Cupertino Miranda <cupertino.miranda@oracle.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 David Faust <david.faust@oracle.com>,
 Elena Zannoni <elena.zannoni@oracle.com>
References: <20240417122341.331524-1-cupertino.miranda@oracle.com>
 <20240417122341.331524-4-cupertino.miranda@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240417122341.331524-4-cupertino.miranda@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/17/24 5:23 AM, Cupertino Miranda wrote:

Please add proper commit message.

> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: David Faust <david.faust@oracle.com>
> Cc: Jose Marchesi <jose.marchesi@oracle.com
> Cc: Elena Zannoni <elena.zannoni@oracle.com>
> ---
>   .../selftests/bpf/progs/verifier_bounds.c     | 64 +++++++++++++++++++
>   1 file changed, 64 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> index ec430b71730b..e3c867d48664 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> @@ -885,6 +885,70 @@ l1_%=:	r0 = 0;						\
>   	: __clobber_all);
>   }
>   
> +SEC("socket")
> +__description("bounds check for reg32 <= 1, 0 xor (0,1)")
> +__success __failure_unpriv
> +__msg_unpriv("R0 min value is outside of the allowed memory range")
> +__retval(0)
> +__naked void t_0_xor_01(void)
> +{
> +	asm volatile ("					\
> +	call %[bpf_get_prandom_u32];                    \
> +	r6 = r0;                                        \
> +	r1 = 0;						\
> +	*(u64*)(r10 - 8) = r1;				\
> +	r2 = r10;					\
> +	r2 += -8;					\
> +	r1 = %[map_hash_8b] ll;				\
> +	call %[bpf_map_lookup_elem];			\
> +	if r0 != 0 goto l0_%=;				\
> +	exit;						\
> +l0_%=:	w1 = 0;						\
> +	r6 >>= 63;					\
> +	w1 ^= w6;					\
> +	if w1 <= 1 goto l1_%=;				\
> +	r0 = *(u64*)(r0 + 8);				\
> +l1_%=:	r0 = 0;						\
> +	exit;						\
> +"	:
> +	: __imm(bpf_map_lookup_elem),
> +	  __imm_addr(map_hash_8b),
> +	  __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("bounds check for reg32 <= 1, 0 or (0,1)")
> +__success __failure_unpriv
> +__msg_unpriv("R0 min value is outside of the allowed memory range")
> +__retval(0)
> +__naked void t_0_or_01(void)
> +{
> +	asm volatile ("					\
> +	call %[bpf_get_prandom_u32];                    \
> +	r6 = r0;                                        \
> +	r1 = 0;						\
> +	*(u64*)(r10 - 8) = r1;				\
> +	r2 = r10;					\
> +	r2 += -8;					\
> +	r1 = %[map_hash_8b] ll;				\
> +	call %[bpf_map_lookup_elem];			\
> +	if r0 != 0 goto l0_%=;				\
> +	exit;						\
> +l0_%=:	w1 = 0;						\
> +	r6 >>= 63;					\
> +	w1 |= w6;					\
> +	if w1 <= 1 goto l1_%=;				\
> +	r0 = *(u64*)(r0 + 8);				\
> +l1_%=:	r0 = 0;						\
> +	exit;						\
> +"	:
> +	: __imm(bpf_map_lookup_elem),
> +	  __imm_addr(map_hash_8b),
> +	  __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
>   SEC("socket")
>   __description("bounds checks after 32-bit truncation. test 1")
>   __success __failure_unpriv __msg_unpriv("R0 leaks addr")

