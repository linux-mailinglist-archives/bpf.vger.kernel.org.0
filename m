Return-Path: <bpf+bounces-62860-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A837AFF53B
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 01:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 692B84E80BC
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 23:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CBE259C85;
	Wed,  9 Jul 2025 23:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J29jRA+r"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7318633F
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 23:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752102596; cv=none; b=uNIdORvT5DYYG7R7BGANvg5nKzZ4QGX9vrk7kJj9DVJ89tFXaP8uDIkUG0w7UUsAn+S9R81gU2PaeC447Zl5b2zr8YEMlssqS5jGctfPW0XfDu0htHENoNeq+tihV2MAVQ7L82/vQiP4K36WRpmLGqY3ey7pqTJ8hBt//yblfJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752102596; c=relaxed/simple;
	bh=N1zlXBq1Jb5heLjqAfCtop54adYOtSeOQaYllWx59bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QAvAWecKUWsaYgc7HGzXx2Wag0iu9w9vi4wT0TJXhBgKTvtrTmJpx99EA7vewhR+sFZNWPbwMpz+EKN0+KL4e2gxxQI5YTODuM22xhXMUrmVYXRYn0NGVfFLLUvcEdtId9RsKqhPRm4745yfoCykNBLeytLtZsLs1HsvR4TWpJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J29jRA+r; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d41cbad6-a31e-464e-b2e3-b74acbf42b48@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752102592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nef7QYR71KCDjwk1E/LxxSXSLdDgwcee/SwaJxkAYmI=;
	b=J29jRA+r8P/uakMbrAouN2HF6/2u5z+h+nfnxqxSmkmxgfhHhGcNzgvnYnAKzs4jL5tNtV
	RsoCEMNLHv2ta/GzNaeCX8vbpMVLSEh3nFLtS69Zd1Stg/4hUgVYLTYz1zu/+Z7kjiI/BU
	TFkZX0B3ndFsmPphIvyWYzDPPvI209I=
Date: Wed, 9 Jul 2025 16:09:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Range analysis test case for
 JSET
Content-Language: en-GB
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>
References: <75b3af3d315d60c1c5bfc8e3929ac69bb57d5cea.1752099022.git.paul.chaignon@gmail.com>
 <9e72d9b0e793c85362c86727911e36a087fe3044.1752099022.git.paul.chaignon@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <9e72d9b0e793c85362c86727911e36a087fe3044.1752099022.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/9/25 3:27 PM, Paul Chaignon wrote:
> This patch adds coverage for the warning detected by syzkaller and fixed
> in the previous patch. Without the previous patch, this test fails with:
>
>    verifier bug: REG INVARIANTS VIOLATION (false_reg1): range bounds
>    violation u64=[0x0, 0x0] s64=[0x0, 0x0] u32=[0x1, 0x0] s32=[0x0, 0x0]
>    var_off=(0x0, 0x0)(1)
>
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---
>   .../selftests/bpf/progs/verifier_bounds.c     | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> index 6f986ae5085e..2232bce1bdce 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> @@ -2,6 +2,7 @@
>   /* Converted from tools/testing/selftests/bpf/verifier/bounds.c */
>   
>   #include <linux/bpf.h>
> +#include <../../../include/linux/filter.h>
>   #include <bpf/bpf_helpers.h>
>   #include "bpf_misc.h"
>   
> @@ -1532,4 +1533,22 @@ __naked void sub32_partial_overflow(void)
>   	: __clobber_all);
>   }
>   
> +SEC("socket")
> +__description("dead branch on jset, does not result in invariants violation error")
> +__success __log_level(2)
> +__retval(0) __flag(BPF_F_TEST_REG_INVARIANTS)
> +__naked void jset_range_analysis(void)
> +{
> +	asm volatile ("						\
> +	call %[bpf_get_netns_cookie];				\
> +	if r0 == 0 goto l0_%=;					\
> +	.8byte %[jset]; /* if r0 & 0xffffffff goto +0 */	\

why not just use 'if r0 & 0xffffffff goto +0'? It will be equivelant to
BPF_JMP_IMM(BPF_JSET, BPF_REG_0, 0xffffffff, 0).

> +l0_%=:	r0 = 0;							\
> +	exit;							\
> +"	:
> +	: __imm(bpf_get_netns_cookie),
> +	  __imm_insn(jset, BPF_JMP_IMM(BPF_JSET, BPF_REG_0, 0xffffffff, 0))
> +	: __clobber_all);
> +}
> +
>   char _license[] SEC("license") = "GPL";


