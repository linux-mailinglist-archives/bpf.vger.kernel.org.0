Return-Path: <bpf+bounces-10656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B75EF7ABAFA
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 23:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E0C322820CB
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 21:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41DE4736F;
	Fri, 22 Sep 2023 21:18:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D12436A1
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 21:18:44 +0000 (UTC)
Received: from out-202.mta1.migadu.com (out-202.mta1.migadu.com [95.215.58.202])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEFCE8
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 14:18:43 -0700 (PDT)
Message-ID: <344b5439-f63f-fb87-2691-d1d9d241e89b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1695417521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d9MibbhxqQffuXQcjojjzWAWBa+orkMA/7cRIgdhSWE=;
	b=tXaeqdEIBiJb/GugUySvz1cNDsCSAGgvy3EdbDqO+8HY/ATlsI5j+y30EpCkHoAq62+E8P
	ZRkCEWsALWDQNSG+whNisxJqzAPYrmooQa+s3FvL/BTfyN1pXm13VQ8bLia+bPNn5zXX53
	BuY9PUdjH8HTLrel1JfpyoTgR2LAmno=
Date: Fri, 22 Sep 2023 14:18:34 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 4/9] bpf: Implement cgroup sockaddr hooks for
 unix sockets
Content-Language: en-US
To: Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: kernel-team@meta.com, netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20230921120913.566702-1-daan.j.demeyer@gmail.com>
 <20230921120913.566702-5-daan.j.demeyer@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230921120913.566702-5-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/21/23 5:09 AM, Daan De Meyer wrote:
> These hooks allows intercepting connect(), getsockname(),
> getpeername(), sendmsg() and recvmsg() for unix sockets. The unix
> socket hooks get write access to the address length because the
> address length is not fixed when dealing with unix sockets and
> needs to be modified when a unix socket address is modified by
> the hook. Because abstract socket unix addresses start with a
> NUL byte, we cannot recalculate the socket address in kernelspace
> after running the hook by calculating the length of the unix socket
> path using strlen().
> 
> These hooks can be used when users want to multiplex syscall to a
> single unix socket to multiple different processes behind the scenes
> by redirecting the connect() and other syscalls to process specific
> sockets.
> 
> We do not implement support for intercepting bind() because when
> using bind() with unix sockets with a pathname address, this creates
> an inode in the filesystem which must be cleaned up. If we rewrite
> the address, the user might try to clean up the wrong file, leaking
> the socket in the filesystem where it is never cleaned up. Until we
> figure out a solution for this (and a use case for intercepting bind()),
> we opt to not allow rewriting the sockaddr in bind() calls.
> 
> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>

[ ... ]

> diff --git a/net/core/filter.c b/net/core/filter.c
> index bd1c42b28483..956f413e98a3 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -7829,6 +7829,7 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>   		switch (prog->expected_attach_type) {
>   		case BPF_CGROUP_INET4_CONNECT:
>   		case BPF_CGROUP_INET6_CONNECT:
> +		case BPF_CGROUP_UNIX_CONNECT:
>   			return &bpf_bind_proto;

Similar to no bind hook supported in this series, the bpf_bind helper should not 
be needed also.

[ ... ]

> @@ -2744,6 +2773,11 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
>   			DECLARE_SOCKADDR(struct sockaddr_un *, sunaddr,
>   					 state->msg->msg_name);
>   			unix_copy_addr(state->msg, skb->sk);
> +
> +			BPF_CGROUP_RUN_PROG_UNIX_RECVMSG_LOCK(sk,
> +						              state->msg->msg_name,
> +						              &state->msg->msg_namelen);
> +

make sense to have recvmsg hook support for connected stream, it will be useful 
to mention the reason in the commit message in case we need to look back a few 
months later why only recvmsg is supported but not sendmsg for connected stream.


