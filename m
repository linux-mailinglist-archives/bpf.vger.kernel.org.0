Return-Path: <bpf+bounces-37342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1204A953E01
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 01:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 957501F234C9
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 23:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A30C155742;
	Thu, 15 Aug 2024 23:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KlLhStgh"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55620156677
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 23:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723765315; cv=none; b=gpEZL3iffeWuWGb89DYNZu0IFTFBSCowLDBHcqTzRUf9mN/r4v+O5sQufgDo9b8ZhI3MSFLh6FxnTunrojcfPLh4Rpupznin+lAf0IbhN9EQTZ9tIR4jbISNYPhMtuuZLyQUdCcXMIr0Mgsk/TLP1mhSOPhOC5Sbh0scYpBPD5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723765315; c=relaxed/simple;
	bh=oJgmQqxWShAcgDDvNfCAEv5ftfCPMmoMHVmUh88qlYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sDCjK4RWVufK3Y8P66EMCpxSFOj6k46gUMtY3g196pmKtSjy87Cs5tA2xGuysrt432YDjHvWDsamBLVkG3+mPt7xGmTUIGeAZFxRSObKfxH3SiDi3CrkKyHCwveLoYeo4Cu9tWFay/7kd+Cfi8O1SJComd1w29XI5zHc8mmBKtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KlLhStgh; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0625a342-887c-4c27-a7a7-9f0eadc31b9d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723765310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ma00N1RDf3VAZQQbX4zGMErJIyOjZdXU5hWvn6AQPw=;
	b=KlLhStghcqhfew0oSzidBxzUa7YMYeRvZQ4RRN5C7Xnw+w+TpbmZ42jYiXProvadyA3W7g
	/ZtMhcCIF8hAtmghjWqvhgASM2SUSNaqagYGz3XHydMkBzK09JsJxOSPZAdjpxKA0CJtrn
	ST/msjuwpBhVtDg+g4ixHVikAUNtCrw=
Date: Thu, 15 Aug 2024 16:41:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 3/6] selftests/test: test gen_prologue and
 gen_epilogue
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Yonghong Song <yonghong.song@linux.dev>, Amery Hung <ameryhung@gmail.com>,
 kernel-team@meta.com, bpf@vger.kernel.org
References: <20240813184943.3759630-1-martin.lau@linux.dev>
 <20240813184943.3759630-4-martin.lau@linux.dev>
 <b9fc529dbe218419820f1055fed6567e2290201c.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <b9fc529dbe218419820f1055fed6567e2290201c.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/14/24 1:48 PM, Eduard Zingerman wrote:
> Hi Martin,
> 
> Please note that after changes for struct_ops map autoload by libbpf,
> test_loader could be use to test struct_ops related changes.
> Also, test_loader now supports __xlated macro which allows to verify
> rewrites applied by verifier.
> For example, the sample below works:
> 
>      struct st_ops_args;
>      
>      struct bpf_testmod_st_ops {
>      	int (*test_prologue)(struct st_ops_args *args);
>      	int (*test_epilogue)(struct st_ops_args *args);
>      	int (*test_pro_epilogue)(struct st_ops_args *args);
>      	struct module *owner;
>      };
>      
>      __success
>      __xlated("0: *(u64 *)(r10 -8) = r1")
>      __xlated("1: r0 = 0")
>      __xlated("2: r1 = *(u64 *)(r10 -8)")
>      __xlated("3: r1 = *(u64 *)(r1 +0)")
>      __xlated("4: r6 = *(u32 *)(r1 +0)")
>      __xlated("5: w6 += 10000")
>      __xlated("6: *(u32 *)(r1 +0) = r6")
>      __xlated("7: r6 = r1")
>      __xlated("8: call kernel-function")
>      __xlated("9: r1 = r6")
>      __xlated("10: call kernel-function")
>      __xlated("11: w0 *= 2")
>      __xlated("12: exit")

It is appealing to be able to check at the xlated instruction level for 
.gen_pro/epilogue.

>      SEC("struct_ops/test_epilogue")
>      __naked int test_epilogue(void)
>      {
>      	asm volatile (
>      	"r0 = 0;"

I also want to test a struct_ops prog making kfunc call, e.g. the 
BPF_PROG(test_epilogue_kfunc) in this patch. I have never tried this in asm, so 
a n00b question. Do you know if there is an example how to call kfunc?

>      	"exit;"
>      	::: __clobber_all);
>      }
>      
>      SEC(".struct_ops.link")
>      struct bpf_testmod_st_ops st_ops = {
>      	.test_epilogue = (void *)test_epilogue,
>      };
> 
> (Complete example is in the attachment).
> test_loader based tests can also trigger program execution via __retval() macro.
> The only (minor) shortcoming that I see, is that test_loader would
> load/unload st_ops map multiple times because of the following
> interaction:
> - test_loader assumes that each bpf program defines a test;
> - test_loader re-creates all maps before each test;
> - libbpf struct_ops autocreate logic marks all programs referenced
>    from struct_ops map as autoloaded.

If I understand correctly, there are redundant works but still work?

Potentially the test_loader can check all the loaded struct_ops progs of a 
st_ops map at once which is an optimization.

Re: __retval(), the struct_ops progs is triggered by a SEC("syscall") prog. 
Before calling this syscall prog, the st_ops map needs to be attached first. I 
think the attach part is missing also? or there is a way?

