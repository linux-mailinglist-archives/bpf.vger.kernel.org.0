Return-Path: <bpf+bounces-35456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5221893AA33
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 02:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11CBE2841B4
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 00:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962F04C84;
	Wed, 24 Jul 2024 00:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w6vNZxGB"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8EA23B1;
	Wed, 24 Jul 2024 00:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721781186; cv=none; b=L9dEqM7MVYZf9hwgW9vouFOV21oAdhRZwRCUYQ9GwwTJjd35BESkf9NvHwo2s3jitiuTIpQdiWK7+m6jbN72i0vZfXrkUqt4EZZ7bDN3tJ1mAbt9MpHZmFuDO5VLHZzYBSBgfAomgZmT/mDYVoGJDORZmEw0wqhQnc9MeBRU9nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721781186; c=relaxed/simple;
	bh=MNq2a778QohB8u9SoQR/mOmBElCnffGtM8CIsaagQKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QsjuPWPXwsBSgs8diBd0oLzi45Dr14qOH+vmZpaNPnVeffHOxe3azv918iLMqiXDh3xH+ogsXTwDRm4PX4J0vr/F/RxS1RL472sghx9NeBGZL6mniyJFvJ/xWvE46hneTrm1FTRu1xNpr4VeBeUvT2uML++kgwoZ6QoXj/Yred4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w6vNZxGB; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <907f24f2-0f33-415e-85c6-0400ab67f896@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721781179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TCT91E1eRzxG8rexfmpqMMMWaNL34yKAenUpT4TZC5g=;
	b=w6vNZxGBFpXMQ0FtHcmxL4jbpqagZ5gdyuPKyHUtV18m+MnxUhjtzSte8jpgso5HMFL5kX
	znh0tzWbcX4dxKtuLvF9V+boSWALCD+3vfgfDAv363aMy7w7HP+48N1atHyH6milIRGjsd
	wYMM1J9uS6pVL/r6REAKM4CjNUyuGKM=
Date: Tue, 23 Jul 2024 17:32:49 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v9 01/11] bpf: Support getting referenced kptr from
 struct_ops argument
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, yangpeihao@sjtu.edu.cn,
 daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com,
 martin.lau@kernel.org, sinquersw@gmail.com, toke@redhat.com,
 jhs@mojatatu.com, jiri@resnulli.us, sdf@google.com,
 xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
References: <20240714175130.4051012-1-amery.hung@bytedance.com>
 <20240714175130.4051012-2-amery.hung@bytedance.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240714175130.4051012-2-amery.hung@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/14/24 10:51 AM, Amery Hung wrote:
> @@ -21004,6 +21025,13 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
>   		mark_reg_known_zero(env, regs, BPF_REG_1);
>   	}
>   
> +	if (env->prog->type == BPF_PROG_TYPE_STRUCT_OPS) {
> +		ctx_arg_info = (struct bpf_ctx_arg_aux *)env->prog->aux->ctx_arg_info;
> +		for (i = 0; i < env->prog->aux->ctx_arg_info_size; i++)
> +			if (ctx_arg_info[i].refcounted)
> +				ctx_arg_info[i].ref_obj_id = acquire_reference_state(env, 0);
> +	}
> +

I think this will miss a case when passing the struct_ops prog ctx (i.e. "__u64 
*ctx") to a global subprog. Something like this:

__noinline int subprog_release(__u64 *ctx __arg_ctx)
{
	struct task_struct *task = (struct task_struct *)ctx[1];
	int dummy = (int)ctx[0];

	bpf_task_release(task);

	return dummy + 1;
}

SEC("struct_ops/subprog_ref")
__failure
int test_subprog_ref(__u64 *ctx)
{
	struct task_struct *task = (struct task_struct *)ctx[1];

	bpf_task_release(task);

	return subprog_release(ctx);;
}

SEC(".struct_ops.link")
struct bpf_testmod_ops subprog_ref = {
	.test_refcounted = (void *)test_subprog_ref,
};

A quick thought is, I think tracking the ctx's ref id in the env->cur_state may 
not be the correct place.

[ Just want to bring up what I have noticed so far. I will stop at here for 
today and will continue. ]

