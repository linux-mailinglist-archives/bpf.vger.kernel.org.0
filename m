Return-Path: <bpf+bounces-7403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0D1776BA7
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 00:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C83B3281CCA
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 22:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD4B1DDD6;
	Wed,  9 Aug 2023 22:02:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A67D1DA50
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 22:02:47 +0000 (UTC)
Received: from out-71.mta1.migadu.com (out-71.mta1.migadu.com [IPv6:2001:41d0:203:375::47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0941FE
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 15:02:45 -0700 (PDT)
Message-ID: <afd0c815-e32f-6b57-a72b-4bcd46b78136@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691618564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qMJv6ufpqtknR1yGk38bAZzuEUJ6prfve1gllA06oPM=;
	b=T2KggH/EwPTITIwBwhHFSVHu4zjoW1l0wILdp1Zu6fK4jEvQccACra3z4KxIbDv3+Ow2Dh
	IMKV7G5YVbJvmBBCsVFiIRdzD/qGLH8oB/+x/i2fVsfKZ4fMzFbR2BJM7b2vU0Tb/iDjZM
	dyAfTOoZhxSCpuHuipwPY+XSm1MKepk=
Date: Wed, 9 Aug 2023 15:02:31 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 8/8] io_uring/cmd: BPF hook for setsockopt cmd
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, io-uring@vger.kernel.org, kuba@kernel.org,
 pabeni@redhat.com, sdf@google.com, axboe@kernel.dk, asml.silence@gmail.com,
 willemdebruijn.kernel@gmail.com
References: <20230808134049.1407498-1-leitao@debian.org>
 <20230808134049.1407498-9-leitao@debian.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230808134049.1407498-9-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/8/23 6:40 AM, Breno Leitao wrote:
> Add support for BPF hooks for io_uring setsockopts command.
> 
> This implementation follows a similar approach to what
> __sys_setsockopt() does, but, operates only on kernel memory instead of
> user memory (which is also possible, but not preferred since the kernel
> memory is already available)
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>   io_uring/uring_cmd.c | 23 +++++++++++++++++++++--
>   1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
> index 3693e5779229..b7b27e4dbddd 100644
> --- a/io_uring/uring_cmd.c
> +++ b/io_uring/uring_cmd.c
> @@ -205,23 +205,42 @@ static inline int io_uring_cmd_setsockopt(struct socket *sock,
>   {
>   	void __user *optval = u64_to_user_ptr(READ_ONCE(cmd->sqe->optval));
>   	int optname = READ_ONCE(cmd->sqe->optname);
> +	sockptr_t optval_s = USER_SOCKPTR(optval);
>   	int optlen = READ_ONCE(cmd->sqe->optlen);
>   	int level = READ_ONCE(cmd->sqe->level);
> +	char *kernel_optval = NULL;
>   	int err;
>   
>   	err = security_socket_setsockopt(sock, level, optname);
>   	if (err)
>   		return err;
>   
> +	if (!in_compat_syscall()) {
> +		err = BPF_CGROUP_RUN_PROG_SETSOCKOPT(sock->sk, &level,
> +						     &optname,
> +						     USER_SOCKPTR(optval),
> +						     &optlen,
> +						     &kernel_optval);
> +		if (err < 0)
> +			return err;
> +		if (err > 0)
> +			return 0;
> +
> +		/* Replace optval by the one returned by BPF */
> +		if (kernel_optval)
> +			optval_s = KERNEL_SOCKPTR(kernel_optval);
> +	}
> +
>   	if (level == SOL_SOCKET && !sock_use_custom_sol_socket(sock))
>   		err = sock_setsockopt(sock, level, optname,
> -				      USER_SOCKPTR(optval), optlen);
> +				      optval_s, optlen);
>   	else if (unlikely(!sock->ops->setsockopt))
>   		err = -EOPNOTSUPP;
>   	else
>   		err = sock->ops->setsockopt(sock, level, optname,
> -					    USER_SOCKPTR(koptval), optlen);
> +					    optval_s, optlen);

The bpf side changes make sense. Thanks.

With all the bpf pieces in place, __sys_{get,set}sockopt() is looking very 
similar to io_uring_cmd_{get,set}sockopt(). There are small differences like one 
takes fd and another already has a sock ptr, and io_uring_cmd_getsockopt() is 
SOL_SOCKET only. In general, can they be refactored somehow such that future 
changes don't have to be made in multiple places?


