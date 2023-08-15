Return-Path: <bpf+bounces-7778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E31A77C466
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 02:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A1AE28130F
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 00:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241BDEDC;
	Tue, 15 Aug 2023 00:28:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FCE7F0
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 00:28:25 +0000 (UTC)
Received: from out-83.mta1.migadu.com (out-83.mta1.migadu.com [95.215.58.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E4310DE
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 17:28:24 -0700 (PDT)
Message-ID: <56dc2449-f01c-f0a7-e31b-cfe6cd157aaa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692059302; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V9eNO6JjvQj0ByPL21IfFJtDGmUHz1DxRIj4BcnYY1k=;
	b=KkjFL66OzJvGXerK8QNrx5LDGG6eqIKA1Z9KuOKo9fW5tq4f4dQz7m9q5M8pVIbTmQ/h15
	K882y9Cah03ThADs3M9GkNUU3ZiT01c5B9X+Kd+oRaMKxONZ5vpCnkSLN38OD5d2//nCIN
	8T6jOnWWoJIYlfLH7vdobLwCTicLNdU=
Date: Mon, 14 Aug 2023 17:28:14 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [RFC PATCH bpf-next 1/2] bpf: Add bpf_current_capable kfunc
Content-Language: en-US
To: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
 jolsa@kernel.org
Cc: bpf@vger.kernel.org
References: <20230814143341.3767-1-laoar.shao@gmail.com>
 <20230814143341.3767-2-laoar.shao@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230814143341.3767-2-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/14/23 7:33 AM, Yafang Shao wrote:
> Add a new bpf_current_capable kfunc to check whether the current task
> has a specific capability. In our use case, we will use it in a lsm bpf
> program to help identify if the user operation is permitted.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>   kernel/bpf/helpers.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index eb91cae..bbee7ea 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2429,6 +2429,11 @@ __bpf_kfunc void bpf_rcu_read_unlock(void)
>   	rcu_read_unlock();
>   }
>   
> +__bpf_kfunc bool bpf_current_capable(int cap)
> +{
> +	return has_capability(current, cap);
> +}

Since you are testing against 'current' capabilities, I assume
that the context should be process. Otherwise, you are testing
against random task which does not make much sense.

Since you are testing against 'current' cap, and if the capability
for that task is stable, you do not need this kfunc.
You can test cap in user space and pass it into the bpf program.

But if the cap for your process may change in the middle of
run, then you indeed need bpf prog to test capability in real time.
Is this your use case and could you describe in in more detail?

> +
>   __diag_pop();
>   
>   BTF_SET8_START(generic_btf_ids)
> @@ -2456,6 +2461,7 @@ __bpf_kfunc void bpf_rcu_read_unlock(void)
>   BTF_ID_FLAGS(func, bpf_task_under_cgroup, KF_RCU)
>   #endif
>   BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_current_capable, KF_RCU)
>   BTF_SET8_END(generic_btf_ids)
>   
>   static const struct btf_kfunc_id_set generic_kfunc_set = {

