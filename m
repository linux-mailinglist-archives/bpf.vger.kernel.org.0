Return-Path: <bpf+bounces-20436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAEA83E62C
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 00:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B1F4286066
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 23:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957A15644F;
	Fri, 26 Jan 2024 23:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pK06Wj9q"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F87555E57
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 23:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706310324; cv=none; b=Nb4oquYfDZXN1mSdCPxkrUD+Oq3TUL4SCDR+n1ntcwF054sEPuP/o93SLgw/wIR87Jgpu3ewtLRUgC/1eT4cLM8BxbdameVWmFXqzTWvMfBWh4XqhqDRc4cGGlWVTsx3rhilqjcpxqP+jI62fui+w2AuGwS8dUCBrMC3HGvFgsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706310324; c=relaxed/simple;
	bh=gCVyaXCMfc4qwOc0ZMexDlmjhtIKfFZT4QVXXewcUvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nkg3C/1q0Snn0/EpjdLHhifOgvUGtAcrZZ2BfxeFE8i4KZMI5a4MvI54hTUQ3KEh8Ej38DHlQjq+DieAQfoTdYvJIQxKkWZUSsSKQ+QQWObsx9IUnX+2OrBdOVDVWLG+CwSnm2eFOV+FZciX61R6XF7+yCPoueqYOyEPJCg4bjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pK06Wj9q; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c62b94dc-cc23-4fd2-b86a-ca30786854ba@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706310319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ASb4+nG95B9q4IisO44fEIKwJWKr4X4hIGqUUfozBRI=;
	b=pK06Wj9qGlqIBe8oxAk/jOs46SXyrTXgF6WZnjbUCah1nwlMm/CgsOClMbju9A5lgQ3k7C
	KXl8GIh8vOEiJdWVbsCY9/b4YLUOxoFNgke/42XNaMntitzOhuvRFkZkyCHm7EB66Z2fE0
	CNqK/aWB8oa8wpTlUlUcrZn9+a/7KBY=
Date: Fri, 26 Jan 2024 15:05:12 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC bpf-next v3] bpf, selftests/bpf: Support PTR_MAYBE_NULL for
 struct_ops arguments.
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 davemarchevsky@meta.com, dvernet@meta.com
References: <20240122212217.1391878-1-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240122212217.1391878-1-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/22/24 1:22 PM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Allow passing a null pointer to the operators provided by a struct_ops
> object. This is an RFC to collect feedbacks/opinions.
> 
> The previous discussions against v1 came to the conclusion that the
> developer should did it in ".is_valid_access". However, recently, kCFI for
> struct_ops has been landed. We found it is possible to provide a generic
> way to annotate arguments by adding a suffix after argument names of stub
> functions. So, this RFC is resent to present the new idea.
> 
> The function pointers that are passed to struct_ops operators (the function
> pointers) are always considered reliable until now. They cannot be
> null. However, in certain scenarios, it should be possible to pass null
> pointers to these operators. For instance, sched_ext may pass a null
> pointer in the struct task type to an operator that is provided by its
> struct_ops objects.
> 
> The proposed solution here is to add PTR_MAYBE_NULL annotations to
> arguments and create instances of struct bpf_ctx_arg_aux (arg_info) for
> these arguments. These arg_infos will be installed at
> prog->aux->ctx_arg_info and will be checked by the BPF verifier when
> loading the programs. When a struct_ops program accesses arguments in the
> ctx, the verifier will call btf_ctx_access() (through
> bpf_verifier_ops->is_valid_access) to verify the access. btf_ctx_access()
> will check arg_info and use the information of the matched arg_info to
> properly set reg_type.



> 
> For nullable arguments, this patch sets an arg_info to label them with
> PTR_TO_BTF_ID | PTR_TRUSTED | PTR_MAYBE_NULL. This enforces the verifier to
> check programs and ensure that they properly check the pointer. The
> programs should check if the pointer is null before reading/writing the
> pointed memory.
> 
> The implementer of a struct_ops should annotate the arguments that can be
> null. The implementer should define a stub function (empty) as a
> placeholder for each defined operator. The name of a stub function should
> be in the pattern "<st_op_type>_stub_<operator name>". For example, for
> test_maybe_null of struct bpf_testmod_ops, it's stub function name should
> be "bpf_testmod_ops_stub_test_maybe_null". You mark an argument nullable by
> suffixing the argument name with "__nullable" at the stub function.  Here
> is the example in bpf_testmod.c.

Neat idea to reuse the cfi stub. Some high level comments.

bpf_struct_ops_desc_init is also collecting the details of each func_proto 
member. Check if this "__nullable" collection can be done in the same loop.

Simplify the implementation of the member_arg_info allocations. There is no need 
to compact everything in one continuous memory.


