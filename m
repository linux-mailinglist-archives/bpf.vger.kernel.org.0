Return-Path: <bpf+bounces-42570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6533D9A597D
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 06:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 872EDB2180A
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 04:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FD81CF7BA;
	Mon, 21 Oct 2024 04:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XxTkm7qq"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2F933CFC
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 04:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729484591; cv=none; b=clclow1q16AoePOMpsumyg4DPcDkvWxnt8BekY635BlOBrenG2EndiJgwl9Dv40TWz83zUZMM06C6JqJRd/aZ/UbeGc4s3+y+VImkHeStJY+Yu9ly4n+PO+uldMudLp79L+AGderG3uWIpiVYxg4bXFqPSTmO/+9cBAklUa7AGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729484591; c=relaxed/simple;
	bh=wRRr0J/td9vVrh7fpjBB8e+eIGCl+zbqKghsE7rIc/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MZ2ly1YlDYD+km69GKNRyXZHVgBdRJPT6v17hZwxiWrpPJMO+1chpikB/dGUBKFg4GVJbh5gCcyQs3jDGPNVXZVKGfj09+jwUC8p2lgYAFK4rknFCfukrn2AWMhsT7h9jRYCmjbXPy9C1rVpdbQDZqRgeQgpX7QL4LxrdChUq/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XxTkm7qq; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cc444b4e-e7f5-45fe-be9e-1f0c4398d966@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729484584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WNyKVb+DwVu5KDJWI4WRYTlFXUkAe5SafOGjGJcQr0s=;
	b=XxTkm7qqdOv+g7FJ1pD8isG0bvziGyddwOIldsQOtXzoLdbcOLz6VY7+sgQoLmm4AARcaH
	5Hdjmm+F/PJ0Jno2gkjB6ad2X/VtvpKGcJZlveEZHQu3CT3wVtVjhDWM3uRuWg4KKLVvre
	KRmBy99MYl+pLFppZiJYPKwiAJDdKms=
Date: Sun, 20 Oct 2024 21:22:53 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 4/9] bpf: Mark each subprog with proper
 private stack modes
Content-Language: en-GB
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>,
 Tejun Heo <tj@kernel.org>
References: <20241020191341.2104841-1-yonghong.song@linux.dev>
 <20241020191405.2106256-1-yonghong.song@linux.dev> <ZxV9oMixusfz2YtC@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ZxV9oMixusfz2YtC@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 10/20/24 3:01 PM, Jiri Olsa wrote:
> On Sun, Oct 20, 2024 at 12:14:05PM -0700, Yonghong Song wrote:
>> Three private stack modes are used to direct jit action:
>>    NO_PRIV_STACK:        do not use private stack
>>    PRIV_STACK_SUB_PROG:  adjust frame pointer address (similar to normal stack)
>>    PRIV_STACK_ROOT_PROG: set the frame pointer
>>
>> Note that for subtree root prog (main prog or callback fn), even if the
>> bpf_prog stack size is 0, PRIV_STACK_ROOT_PROG mode is still used.
>> This is for bpf exception handling. More details can be found in
>> subsequent jit support and selftest patches.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   include/linux/bpf.h   |  9 +++++++++
>>   kernel/bpf/core.c     | 19 +++++++++++++++++++
>>   kernel/bpf/verifier.c | 29 +++++++++++++++++++++++++++++
>>   3 files changed, 57 insertions(+)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 376e43fc72b9..27430e9dcfe3 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1456,6 +1456,12 @@ struct btf_mod_pair {
>>   
>>   struct bpf_kfunc_desc_tab;
>>   
>> +enum bpf_priv_stack_mode {
>> +	NO_PRIV_STACK,
>> +	PRIV_STACK_SUB_PROG,
>> +	PRIV_STACK_ROOT_PROG,
>> +};
>> +
>>   struct bpf_prog_aux {
>>   	atomic64_t refcnt;
>>   	u32 used_map_cnt;
>> @@ -1472,6 +1478,9 @@ struct bpf_prog_aux {
>>   	u32 ctx_arg_info_size;
>>   	u32 max_rdonly_access;
>>   	u32 max_rdwr_access;
>> +	enum bpf_priv_stack_mode priv_stack_mode;
>> +	u16 subtree_stack_depth; /* Subtree stack depth if PRIV_STACK_ROOT_PROG, 0 otherwise */
>> +	void __percpu *priv_stack_ptr;
>>   	struct btf *attach_btf;
>>   	const struct bpf_ctx_arg_aux *ctx_arg_info;
>>   	struct mutex dst_mutex; /* protects dst_* pointers below, *after* prog becomes visible */
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index 14d9288441f2..aee0055def4f 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -1240,6 +1240,7 @@ void __weak bpf_jit_free(struct bpf_prog *fp)
>>   		struct bpf_binary_header *hdr = bpf_jit_binary_hdr(fp);
>>   
>>   		bpf_jit_binary_free(hdr);
>> +		free_percpu(fp->aux->priv_stack_ptr);
> this should be also put to the x86 version of the bpf_jit_free ?

Thanks for spotting this! Indeed, the x86 version of bpf_jit_free should
be used. Will fix in the next revision.

>
> jirka
>
>>   		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(fp));
>>   	}

[...]


