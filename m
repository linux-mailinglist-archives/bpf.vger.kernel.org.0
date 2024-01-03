Return-Path: <bpf+bounces-18841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D4A82260E
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 01:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 430E0B20BBB
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 00:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A109B65E;
	Wed,  3 Jan 2024 00:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KKJsDdho"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229067EB
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 00:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fbdd0cc8-4078-40a7-9654-7e3c0cfce738@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704242702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UNxqBjSNC+XVDtC5glFYJ/tq+t6h6/t5//H1Q8s+pL4=;
	b=KKJsDdhotxh85o0sywTwAPjdm1DZdUYlbddqD/OVDC7XFK/S0OkuqC/rPNdNnsII5Y7lj7
	U0A806Pm7TqLQ396RAHIHDUXOlPXry5iDHSaRELM/jgK2geo0aDjAEN3tFAQJ4ZxkE+MiK
	BgqtULTxHorAXaQYB/gglx158GGh6nc=
Date: Tue, 2 Jan 2024 16:44:58 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 3/3] selftests/bpf: Test gotol with large offsets
Content-Language: en-GB
To: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
References: <20240102193531.3169422-1-iii@linux.ibm.com>
 <20240102193531.3169422-4-iii@linux.ibm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240102193531.3169422-4-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/2/24 11:30 AM, Ilya Leoshkevich wrote:
> Test gotol with offsets that don't fit into a short (i.e., larger than
> 32k or smaller than -32k).
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

It might be useful to explain why the test will fail
with unpriv mode (4K insn limit) just in case that
people are not aware of the reason.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   .../selftests/bpf/progs/verifier_gotol.c      | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_gotol.c b/tools/testing/selftests/bpf/progs/verifier_gotol.c
> index d1edbcff9a18..05a329ee45ee 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_gotol.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_gotol.c
> @@ -33,6 +33,25 @@ l3_%=:							\
>   	: __clobber_all);
>   }
>   
> +SEC("socket")
> +__description("gotol, large_imm")
> +__success __failure_unpriv __retval(40000)
> +__naked void gotol_large_imm(void)
> +{
> +	asm volatile ("					\
> +	gotol 1f;					\
> +0:							\
> +	r0 = 0;						\
> +	.rept 40000;					\
> +	r0 += 1;					\
> +	.endr;						\
> +	exit;						\
> +1:	gotol 0b;					\
> +"	:
> +	:
> +	: __clobber_all);
> +}
> +
>   #else
>   
>   SEC("socket")

