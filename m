Return-Path: <bpf+bounces-31414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B78498FC331
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 07:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74C442871EC
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 05:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B38521C186;
	Wed,  5 Jun 2024 05:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fbhHvtKG"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741BA5916B
	for <bpf@vger.kernel.org>; Wed,  5 Jun 2024 05:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717566952; cv=none; b=N1I9UImDwRi0+mNbB559Zz/gqL4U5yhf3wI9yzQL7JjiaZX5XZ9yYDm5NVctHuJazocEHFAoMCkQm1ugG6x4lGO4gHrg7YNtXPkVeCtftOxrmqbCx5wbhYHhjLPbtR5kHDq638r03UHxM7eQYhIXOchhkYSt55F9rR4p+0JVGp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717566952; c=relaxed/simple;
	bh=jP2VmZAIxg6arQTu+H17SXinjd225KCaRBiWXBUTUnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NRs9C90OECdD7Pozrx/4ln1ZBFRhKKV7Q4jqCmgKOp8PU8O/po69Z3gmlq9dwYf47dfK3R7RmevDoza9HSWzkT59NfuWhIGu47DckZV9kFDUCdBHNBXQl9iD+6GlofQJMc5Ddb4P/7ns2pdi0V8n/fvn1zMequH48tlV1sZVltk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fbhHvtKG; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: tony.ambardar@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717566947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZTFJhYbp3QouwWqGosOcUstUo0ISbCMKBrTKIflNJy0=;
	b=fbhHvtKGNYWgfTthVheNINNNT91baJKVWerKU++HXoNWbL+T5tTF1grWwIP04EU4gLzNvL
	Rq+0luSn3c2GRIqUAA2a6uq1StsP7nnRLw/bcwSF47N6DMMd64+u9QezD0023U1Dxj4IWR
	XAvf3LVYbF+czUQa70+Q6OUI3DtxQzU=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: andrii@kernel.org
X-Envelope-To: martin.lau@linux.dev
X-Envelope-To: eddyz87@gmail.com
X-Envelope-To: song@kernel.org
X-Envelope-To: john.fastabend@gmail.com
X-Envelope-To: kpsingh@kernel.org
X-Envelope-To: sdf@google.com
X-Envelope-To: haoluo@google.com
X-Envelope-To: jolsa@kernel.org
X-Envelope-To: ojeda@kernel.org
X-Envelope-To: stable@vger.kernel.org
Message-ID: <7540222d-92e0-47f7-a880-7c4440671740@linux.dev>
Date: Tue, 4 Jun 2024 22:55:39 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 1/2] compiler_types.h: Define __retain for
 __attribute__((__retain__))
Content-Language: en-GB
To: Tony Ambardar <tony.ambardar@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 stable@vger.kernel.org
References: <cover.1717413886.git.Tony.Ambardar@gmail.com>
 <cover.1717477560.git.Tony.Ambardar@gmail.com>
 <b31bca5a5e6765a0f32cc8c19b1d9cdbfaa822b5.1717477560.git.Tony.Ambardar@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <b31bca5a5e6765a0f32cc8c19b1d9cdbfaa822b5.1717477560.git.Tony.Ambardar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/3/24 10:23 PM, Tony Ambardar wrote:
> Some code includes the __used macro to prevent functions and data from
> being optimized out. This macro implements __attribute__((__used__)), which
> operates at the compiler and IR-level, and so still allows a linker to
> remove objects intended to be kept.
>
> Compilers supporting __attribute__((__retain__)) can address this gap by
> setting the flag SHF_GNU_RETAIN on the section of a function/variable,
> indicating to the linker the object should be retained. This attribute is
> available since gcc 11, clang 13, and binutils 2.36.
>
> Provide a __retain macro implementing __attribute__((__retain__)), whose
> first user will be the '__bpf_kfunc' tag.
>
> Link: https://lore.kernel.org/bpf/ZlmGoT9KiYLZd91S@krava/T/
> Cc: stable@vger.kernel.org # v6.6+
> Signed-off-by: Tony Ambardar <Tony.Ambardar@gmail.com>
> ---
>   include/linux/compiler_types.h | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
>
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 93600de3800b..f14c275950b5 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -143,6 +143,29 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
>   # define __preserve_most
>   #endif
>   
> +/*
> + * Annotating a function/variable with __retain tells the compiler to place
> + * the object in its own section and set the flag SHF_GNU_RETAIN. This flag
> + * instructs the linker to retain the object during garbage-cleanup or LTO
> + * phases.
> + *
> + * Note that the __used macro is also used to prevent functions or data
> + * being optimized out, but operates at the compiler/IR-level and may still
> + * allow unintended removal of objects during linking.
> + *
> + * Optional: only supported since gcc >= 11, clang >= 13
> + *
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-retain-function-attribute
> + * clang: https://clang.llvm.org/docs/AttributeReference.html#retain
> + */
> +#if __has_attribute(__retain__) && \
> +	(defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || \
> +	 defined(CONFIG_LTO_CLANG))

Could you explain why CONFIG_LTO_CLANG is added here?
IIUC, the __used macro permits garbage collection at section
level, so CLANG_LTO_CLANG without
CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
shuold not change final section dynamics, right?

> +# define __retain			__attribute__((__retain__))
> +#else
> +# define __retain
> +#endif
> +
>   /* Compiler specific macros. */
>   #ifdef __clang__
>   #include <linux/compiler-clang.h>

