Return-Path: <bpf+bounces-37381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 199C1954FFC
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 19:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8BB2282810
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 17:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A751C2300;
	Fri, 16 Aug 2024 17:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WhOZ0qP3"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B492A1BE225
	for <bpf@vger.kernel.org>; Fri, 16 Aug 2024 17:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723829241; cv=none; b=NmqjcRidWdVCtsRPaz53IKMBDPCJ++vQWduthacV1/WpduEsfw8U0b5ifXbCKzeNbJAhni8AbwYWRJP6WtWfbR/3xkK1jYV/726K32pJ5uHvMfihgg2lCCQS+FNIZWQF0/f+PL9jn35ILvqogj0Svs6528NFyy3ZnOY1LZEQ54M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723829241; c=relaxed/simple;
	bh=XogxXYJWI8MBKYniMoyICuykW+OgcEyYpGrHmcQwQhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mFr7rLAHtpHbLPl08ON7kopvGPzmCcNrT7YL0TJVAfHkKLXY00lLZZUnA7Ajzswa/04IZN9HI9mtfm1jrPVJAWXP6P8BRVapqLdRRaa4RVyjKaSI5d7/B9//KscUy/EBwZx2EoGBVSISo/IZqHQKZq5eWItUx1WKQo6LBGYQvo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WhOZ0qP3; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <13f4dee5-845a-4eae-95e3-27c340261098@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723829236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ats88NcNYhMFY/zqsGORP/5JYzcdGqWPX9yq49izuH0=;
	b=WhOZ0qP3oR+cC7tGdSb5DBM00VCHCxnbKzeW1aOOvU1WmkPc+qLTjKtbuKMMtERyYu4x5L
	pP+1UK8oDD5DFh8FPhF8GNT81bbjGYGrB6B3P2+TsbxFu6Ncfw9v5iztDacWzobQ/WzXib
	X51IAK84vxWIn3eEAFfMX1i4s1fFpHc=
Date: Fri, 16 Aug 2024 10:27:11 -0700
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
 <0625a342-887c-4c27-a7a7-9f0eadc31b9d@linux.dev>
 <92f724366153f2fbd7d9e92b6ba6f82408970dd7.camel@gmail.com>
 <2e86ab640b6acbe8e21af826ccfeeac6c055bc69.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <2e86ab640b6acbe8e21af826ccfeeac6c055bc69.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/15/24 6:50 PM, Eduard Zingerman wrote:
> On Thu, 2024-08-15 at 17:23 -0700, Eduard Zingerman wrote:
> 
> [...]
> 
>>> Re: __retval(), the struct_ops progs is triggered by a SEC("syscall") prog.
>>> Before calling this syscall prog, the st_ops map needs to be attached first. I
>>> think the attach part is missing also? or there is a way?
>>
>> I think libbpf handles the attachment automatically, I'll double check and reply.
>>
> 
> In theory, the following addition to the example I've sent already should work:
> 
>      struct st_ops_args;
>      int bpf_kfunc_st_ops_test_prologue(struct st_ops_args *args) __ksym;
>   
>      SEC("syscall")
>      __retval(0)
>      int syscall_prologue(void *ctx)
>      {
>      	struct st_ops_args args = { -42 };
>      	bpf_kfunc_st_ops_test_prologue(&args);
>      	return args.a;
>      }
> 
> However, the initial value of -42 is not changed, e.g. here is the log:
> 
>      $ ./test_progs -vvv -t struct_ops_epilogue/syscall_prologue
>      ...
>      libbpf: loaded kernel BTF from '/sys/kernel/btf/vmlinux'
>      libbpf: extern (func ksym) 'bpf_kfunc_st_ops_test_prologue': resolved to bpf_testmod [104486]
>      libbpf: struct_ops init_kern st_ops: type_id:44 kern_type_id:104321 kern_vtype_id:104378
>      libbpf: struct_ops init_kern st_ops: func ptr test_prologue is set to prog test_prologue from data(+0) to kern_data(+0)
>      libbpf: struct_ops init_kern st_ops: func ptr test_epilogue is set to prog test_epilogue from data(+8) to kern_data(+8)
>      libbpf: map 'st_ops': created successfully, fd=5
>      run_subtest:PASS:unexpected_load_failure 0 nsec
>      VERIFIER LOG:
>      =============
>      ...
>      =============
>      do_prog_test_run:PASS:bpf_prog_test_run 0 nsec
>      run_subtest:FAIL:837 Unexpected retval: -42 != 0
>      #321/3   struct_ops_epilogue/syscall_prologue:FAIL
>      #321     struct_ops_epilogue:FAIL
> 
> So, something goes awry in bpf_kfunc_st_ops_test_prologue():
> 
>      __bpf_kfunc int bpf_kfunc_st_ops_test_prologue(struct st_ops_args *args)
>      {
>      	int ret = -1;
>      
>      	mutex_lock(&st_ops_mutex);
>      	if (st_ops && st_ops->test_prologue)

Thanks for checking!

I think the bpf_map__attach_struct_ops() is not done such that st_ops is NULL.

It probably needs another tag in the SEC("syscall") program to tell which st_ops 
map should be attached first before executing the "syscall" program.

I like the idea of using the __xlated macro to check the patched prologue, ctx 
pointer saving, and epilogue. I will add this test in the respin. I will keep 
the current way in this patch to exercise syscall and the ops/func in st_ops for 
now. We can iterate on it later and use it as an example on what supports are 
needed on the test_loader side for st_ops map testing. On the repetitive-enough 
to worth test_loader refactoring side, I suspect some of the existing st_ops 
load-success/load-failure tests may be worth to look at also. Thoughts?

>      		ret = st_ops->test_prologue(args);
>      	mutex_unlock(&st_ops_mutex);
>      
>      	return ret;
>      }
> 
> Either st_ops is null or st_ops->test_prologue is null.
> However, the log above shows:
> 
>      libbpf: struct_ops init_kern st_ops: type_id:44 kern_type_id:104321 kern_vtype_id:104378
>      libbpf: struct_ops init_kern st_ops: func ptr test_prologue is set to prog test_prologue from data(+0) to kern_data(+0)
>      libbpf: struct_ops init_kern st_ops: func ptr test_epilogue is set to prog test_epilogue from data(+8) to kern_data(+8)
> 
> Here libbpf does autoload for st_ops map and populates it, so st_ops->test_prologue should not be null.
> Will have some time tomorrow to debug this (or you can give it a shot if you'd like).
> 



