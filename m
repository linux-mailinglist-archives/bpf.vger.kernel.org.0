Return-Path: <bpf+bounces-9296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F158B793100
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 23:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC6E7281216
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 21:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345EC101C3;
	Tue,  5 Sep 2023 21:37:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE37DDB6;
	Tue,  5 Sep 2023 21:37:40 +0000 (UTC)
Received: from out-213.mta0.migadu.com (out-213.mta0.migadu.com [91.218.175.213])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FFDE4A;
	Tue,  5 Sep 2023 14:37:33 -0700 (PDT)
Message-ID: <76316157-7221-e1d6-4e3c-2f1efb6e6230@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1693949851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CgXDiSweGrzZb5uC0LdbKTUevgSBi9vuGJu5ieT3xL8=;
	b=kCW4UKlDbumIrbWAAWQLxz1Yi7bkqxK/PYWDB8G7QyxgwWbMdE3TsXa0BzSAgq9IEfWKQM
	6GBZ8oezNzpyIRbYXRUvgPuEnfWJvhyig3lWtCzFhtflqqjDWVdm/htLrn+LVQDJ0uIeC0
	mIK7DB6Dtj1iWLvVzl8qtWjQ2kweMcs=
Date: Tue, 5 Sep 2023 14:37:27 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 3/9] bpf: Add bpf_sock_addr_set_unix_addr() to
 allow writing unix sockaddr from bpf
Content-Language: en-US
To: Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: kernel-team@meta.com, netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20230831153455.1867110-1-daan.j.demeyer@gmail.com>
 <20230831153455.1867110-4-daan.j.demeyer@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230831153455.1867110-4-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/31/23 8:34 AM, Daan De Meyer wrote:
> As prep for adding unix socket support to the cgroup sockaddr hooks,
> let's add a kfunc bpf_sock_addr_set_unix_addr() that allows modifying a sockaddr
> from bpf. While this is already possible for AF_INET and AF_INET6, we'll
> need this kfunc when we add unix socket support since modifying the
> address for those requires modifying both the address and the sockaddr
> length.
> 
> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> ---
>   kernel/bpf/btf.c  |  1 +
>   net/core/filter.c | 32 +++++++++++++++++++++++++++++++-
>   2 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 249657c466dd..15c972f27574 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7819,6 +7819,7 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
>   {
>   	switch (prog_type) {
>   	case BPF_PROG_TYPE_UNSPEC:
> +	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
>   		return BTF_KFUNC_HOOK_COMMON;
>   	case BPF_PROG_TYPE_XDP:
>   		return BTF_KFUNC_HOOK_XDP;
> diff --git a/net/core/filter.c b/net/core/filter.c
> index a094694899c9..3ed6cd33b268 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -11752,6 +11752,25 @@ __bpf_kfunc int bpf_dynptr_from_xdp(struct xdp_buff *xdp, u64 flags,
>   
>   	return 0;
>   }
> +
> +__bpf_kfunc int bpf_sock_addr_set_unix_addr(struct bpf_sock_addr_kern *sa_kern,
> +					    const u8 *addr, u32 addrlen__sz)
> +{
> +	struct sockaddr *sa = sa_kern->uaddr;
> +	struct sockaddr_un *un;
> +
> +	if (sa_kern->sk->sk_family != AF_UNIX)
> +		return -EINVAL;
> +
> +	if (addrlen__sz > UNIX_PATH_MAX)

Is it valid to have addrlen__sz == 0 for AF_UNIX?

> +		return -EINVAL;
> +
> +	un = (struct sockaddr_un *)sa;
> +	memcpy(un->sun_path, addr, addrlen__sz);
> +	sa_kern->uaddrlen = offsetof(struct sockaddr_un, sun_path) + addrlen__sz;
> +
> +	return 0;
> +}


