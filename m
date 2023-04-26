Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DED06EFC83
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 23:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236131AbjDZVbY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 17:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbjDZVbX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 17:31:23 -0400
Received: from out-45.mta1.migadu.com (out-45.mta1.migadu.com [IPv6:2001:41d0:203:375::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBECE76
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 14:31:04 -0700 (PDT)
Message-ID: <96baca8c-06db-88c4-d1ab-f68ebf851c90@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1682544661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mi1LQqy2w2Y9kDvrHcWL78U54XC+lzDzpBYO2ASMm3w=;
        b=G364O4yn+Px03oTbkjb9gDUS3NBv080FLjnBPNk8wwSOGvHBz2elEaT9p8ugGn0ftEIwzN
        P3WMnzqVCmgyEXH6bu5kN891vUtwDdEFdS6HXs2DtJKPUX/0MaPTIDgc1zZjlijk+JdA6U
        UVQN7p7LpUb4YN6qUES8fuuogHzjZok=
Date:   Wed, 26 Apr 2023 14:30:58 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 05/10] bpf: Add bpf_sock_addr_set() to allow
 writing sockaddr len from bpf
Content-Language: en-US
To:     Daan De Meyer <daan.j.demeyer@gmail.com>
Cc:     kernel-team@meta.com, bpf@vger.kernel.org
References: <20230421162718.440230-1-daan.j.demeyer@gmail.com>
 <20230421162718.440230-6-daan.j.demeyer@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230421162718.440230-6-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/21/23 9:27 AM, Daan De Meyer wrote:
> As prep for adding unix socket support to the cgroup sockaddr hooks,
> let's add a kfunc bpf_sock_addr_set() that allows modifying the
> sockaddr length from bpf. This is required to allow modifying AF_UNIX
> sockaddrs correctly.
> 
> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> ---
>   net/core/filter.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 44fb997434ad..1c656e2d7b58 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -81,6 +81,7 @@
>   #include <net/xdp.h>
>   #include <net/mptcp.h>
>   #include <net/netfilter/nf_conntrack_bpf.h>
> +#include <linux/un.h>
>   
>   static const struct bpf_func_proto *
>   bpf_sk_base_func_proto(enum bpf_func_id func_id);
> @@ -11670,6 +11671,44 @@ __bpf_kfunc int bpf_dynptr_from_xdp(struct xdp_buff *xdp, u64 flags,
>   
>   	return 0;
>   }
> +
> +__bpf_kfunc int bpf_sock_addr_set(struct bpf_sock_addr_kern *sa_kern,
> +				  const void *addr, u32 addrlen__sz)
> +{
> +	const struct sockaddr *sa = addr;
> +
> +	if (addrlen__sz <= offsetof(struct sockaddr, sa_family))
> +		return -EINVAL;
> +
> +	if (addrlen__sz > sizeof(struct sockaddr_storage))
> +		return -EINVAL;
> +
> +	if (sa->sa_family != sa_kern->uaddr->sa_family)
> +		return -EINVAL;
> +
> +	switch (sa->sa_family) {
> +	case AF_INET:
> +		if (addrlen__sz < sizeof(struct sockaddr_in))
> +			return -EINVAL;
> +		break;
> +	case AF_INET6:
> +		if (addrlen__sz < SIN6_LEN_RFC2133)
> +			return -EINVAL;
> +		break;
> +	case AF_UNIX:
> +		if (addrlen__sz <= offsetof(struct sockaddr_un, sun_path) ||
> +		    addrlen__sz > sizeof(struct sockaddr_un))
> +			return -EINVAL;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	memcpy(sa_kern->uaddr, sa, addrlen__sz);

Can you check whether the current inet* hooks can support changing sin[6]_* 
other than the sin[6]_addr part? e.g. from looking at inet6_getname(), bpf prog 
changing sin6_scope_id does not get through. Also, if I read the patches 
correctly, an increased sa_kern->uaddrlen is getting silently ignored for 
inet[6] hooks and it does not look right. e.g. for IPv6, what if the bpf prog 
set uaddrlen larger to include the sin6_scope_id?

or tweak the kfunc a little to only allow changing the sin[6]_addr and sun_path. 
Something like this (uncompiled code):

__bpf_kfunc int bpf_sock_addr_set(struct bpf_sock_addr_kern *sa_kern,
				  const u8 *addr, u32 addrlen__sz)
{
	struct sockaddr *sa = sa_kern->uaddr;
	struct sockaddr_in *sa4;
	struct sockaddr_in6 *sa6;
	struct sockaddr_un *un;

	switch (sa_kern->sk->sk_family) {
	case AF_INET:
		if (addrlen__sz != 4)
			return -EINVAL;
		sa4 = (struct sockaddr_in *)sa;
		sa4->sin_addr.s_addr = *(__be32 *)addr;
		break;
	case AF_INET6:
		if (addrlen__sz != 16)
			return -EINVAL;
		sa6 = (struct sockaddr_in6 *)sa;
		memcpy(sa6->sin6_addr.s6_addr, addr, 16);
		break;
	case AF_UNIX:
		if (addrlen__sz > UNIX_PATH_MAX)
			return -EINVAL;
		un = (struct sockaddr_un *)sa;
		memcpy(un->sun_path, addr, addrlen__sz);
		/* uaddrlen is only for the length of the sun_path
		 *(and sin[6]_addr too?)
		 */
		sa_kern->uaddrlen = addrlen__sz;
		break;
	default:
		/* impossible */
		WARN_ON_ONCE(1);
		return -EINVAL;
	}

	return 0;
}

> +	sa_kern->uaddrlen = addrlen__sz;
> +
> +	return 0;
> +}
>   __diag_pop();

