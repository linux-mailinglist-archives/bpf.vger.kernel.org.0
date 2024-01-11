Return-Path: <bpf+bounces-19376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 229B182B516
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 20:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2986B22E8E
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 19:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE2854FA7;
	Thu, 11 Jan 2024 19:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HlXtVpC7"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ACC54BDD
	for <bpf@vger.kernel.org>; Thu, 11 Jan 2024 19:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5d3f90bc-2758-43a4-bf13-45dc50301758@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705000136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6/NOYoU+LUOUqJLd81XHq9wdDo8rni0Mt1jqw8IVF7s=;
	b=HlXtVpC7oNwCNfKYfn4lrobrxYRbVhTP+UvEWQLO92SuUef76NNwgDU1+WYgHaMNdjYdmX
	QHgw3aXdYpzCj5jRy+clZBDzUA47uKjQ+Y5Fshw1+A5X75Femwdb3775To4lFcxucpMQKZ
	4N0S7S0nBakV7IxNEdlFyg1CeqEppyQ=
Date: Thu, 11 Jan 2024 11:08:49 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC bpf-next] bpf, selftests/bpf: Support PTR_MAYBE_NULL for
 struct_ops arguments.
Content-Language: en-US
To: Kui-Feng Lee <sinquersw@gmail.com>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, davemarchevsky@meta.com,
 dvernet@meta.com, Yonghong Song <yonghong.song@linux.dev>
References: <20240110221750.798813-1-thinker.li@gmail.com>
 <55ada30c-039d-4121-a4d2-efda578f600f@linux.dev>
 <0dd5949b-b6f8-4d88-88ba-cc079096ce32@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <0dd5949b-b6f8-4d88-88ba-cc079096ce32@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/10/24 5:50 PM, Kui-Feng Lee wrote:
> 
> 
> On 1/10/24 15:44, Martin KaFai Lau wrote:
>> On 1/10/24 2:17 PM, thinker.li@gmail.com wrote:
>>> The proposed solution here is to add PTR_MAYBE_NULL annotations to
>>> arguments
>>
>> [ ... ]
>>
>>> == Future Work ==
>>>
>>> We require an improved method for annotating arguments. Initially, we
>>> anticipated annotating arguments by appending a suffix to argument names,
>>> such as arg1__maybe_null. However, this approach does not function for
>>> function pointers due to compiler limitations. Nevertheless, it does work
>>> for functions. To resolve this, we need compiler support to enable the
>>> inclusion of argument names in the DWARF for function pointer types.
>>
>> After reading the high level of the patch,
>> while it needs compiler work to support decl tagging (or arg name) in a 
>> struct_ops's func_proto, changing the info->reg_type of a struct_ops's 
>> argument have been doable in the ".is_valid_access" without new kernel code 
>> change in verifier/btf.c.
> 
> btf_ctx_access() mentioned in the original message is a help function
> called by the implementation of .is_valid_access. So, just like you
> said, they definitely can be handled by .is_valid_access it-self.
> 
> Do you prefer to let developers to handle it by themself instead of
> handling by the helpers?

I would prefer one way to do the same thing. ".is_valid_access" should be more 
flexible and straightforward. e.g. "bpf_tcp_ca_is_valid_access" can promote all 
"struct sock" pointers to "struct tcp_sock" without needing to specify them func 
by func.

It would be nice to eventually have both compilers support tagging in the 
struct_ops's func_proto. I was trying to say ".is_valid_access" can already add 
PTR_MAYBE_NULL now while waiting for the compiler support.

If the sched_ext adds PTR_MAYBE_NULL in its ".is_valid_access", what else is 
missing in the verifier.c and btf.c? I saw the patch has the following changes 
in verifier.c. Is it needed?

 > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
 > index 60f08f468399..190735f3eaf5 100644
 > --- a/kernel/bpf/verifier.c
 > +++ b/kernel/bpf/verifier.c
 > @@ -8200,6 +8200,7 @@ static int check_reg_type(struct bpf_verifier_env *env, 
u32 regno,
 >   	case PTR_TO_BTF_ID | PTR_TRUSTED:
 >   	case PTR_TO_BTF_ID | MEM_RCU:
 >   	case PTR_TO_BTF_ID | PTR_MAYBE_NULL:
 > +	case PTR_TO_BTF_ID | PTR_MAYBE_NULL | PTR_TRUSTED:
 >   	case PTR_TO_BTF_ID | PTR_MAYBE_NULL | MEM_RCU:
 >   	{
 >   		/* For bpf_sk_release, it needs to match against first member


