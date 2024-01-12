Return-Path: <bpf+bounces-19472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FA082C54A
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 19:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F2C8B22EA8
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 18:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982582560F;
	Fri, 12 Jan 2024 18:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F4MC5owU"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949691AAA6
	for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 18:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ea5b102e-2a4e-4363-a1d4-28e050ac9e1a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705083280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZXPUjA5jmlLV84i28pzNX87fFQI8oKj4Ht8/iMnAZWY=;
	b=F4MC5owU5w/zN6r6sGVij/qbOli+/GjgKNy0uUoL5YLbLZ/ciK1Fls0v/NFxUQPWL1k+w8
	oYiaIAKqZt8UUgLQLjpjDtxhYbv52C7C/1OJ6a9B0V0wrQgKmxVi4kzzwoWWLUqQwNty5M
	k16nFsFDxW1YM3yQEIF38KRLY2XgLeE=
Date: Fri, 12 Jan 2024 10:14:36 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/2] selftests/bpf: Add tests for alu on
 PTR_TO_FLOW_KEYS
Content-Language: en-GB
To: Hao Sun <sunhao.th@gmail.com>, bpf@vger.kernel.org
Cc: willemb@google.com, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, linux-kernel@vger.kernel.org
References: <20240112152011.6264-1-sunhao.th@gmail.com>
 <20240112152011.6264-2-sunhao.th@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240112152011.6264-2-sunhao.th@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/12/24 7:20 AM, Hao Sun wrote:
> Add two cases for PTR_TO_FLOW_KEYS alu. One for rejecting alu with
> variable offset, another for fixed offset.
>
> Signed-off-by: Hao Sun <sunhao.th@gmail.com>
> ---
>   .../bpf/progs/verifier_value_illegal_alu.c    | 36 +++++++++++++++++++
>   1 file changed, 36 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c b/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
> index 71814a753216..3bcccb4cbc85 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
> @@ -146,4 +146,40 @@ l0_%=:	exit;						\
>   	: __clobber_all);
>   }
>   
> +SEC("flow_dissector")
> +__description("flow_keys illegal alu op with variable offset")
> +__failure __msg("R7 pointer arithmetic on flow_keys prohibited")
> +__naked void flow_keys_illegal_variable_offset_alu(void)
> +{
> +	asm volatile("					\
> +	r6 = r1;					\
> +	r7 = *(u64*)(r6 + %[flow_keys_off]);		\
> +	r8 = 8;						\
> +	r8 /= 1;					\
> +	r8 &= 8;					\
> +	r7 += r8;					\
> +	r0 = *(u64*)(r7 + 0);				\
> +	exit;						\
> +"	:
> +	: __imm_const(flow_keys_off, offsetof(struct __sk_buff, flow_keys))
> +	: __clobber_all);
> +}
> +
> +SEC("flow_dissector")
> +__description("flow_keys valid alu op with fixed offset")
> +__success
> +__naked void flow_keys_legal_fixed_offset_alu(void)
> +{
> +	asm volatile("					\
> +	r6 = r1;					\
> +	r7 = *(u64*)(r6 + %[flow_keys_off]);		\
> +	r8 = 8;						\
> +	r7 += r8;					\
> +	r0 = *(u64*)(r7 + 0);				\
> +	exit;						\
> +"	:
> +	: __imm_const(flow_keys_off, offsetof(struct __sk_buff, flow_keys))
> +	: __clobber_all);
> +}

Please remove the above '__success' case from this file. This file,
verifier_value_illegal_alu.c, only contains failure cases.

For the fixed offset, we already have C code to verify,
e.g., in bpf_flow.c.


