Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBADB49E425
	for <lists+bpf@lfdr.de>; Thu, 27 Jan 2022 15:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiA0OFr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jan 2022 09:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233877AbiA0OFr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Jan 2022 09:05:47 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E0BC061714
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 06:05:46 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id j2so6104091ejk.6
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 06:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=70qrjlJnUzj4vZ9SPQNnrbTU5DBAMOQbqOGEf6eUS7M=;
        b=ktXKTKeIkwo7iYt44KPiB06gC9UM78n1y5Dj3B/IYkmsqDlNK9tiSILhEu+56r9iPm
         hl5C70NJMxqLe63pvxWDcFd/y4j8i3sb9W995S9g7ezzJ6YN6PoVX4qZ4u+NTuJn9rU9
         bOksBeIiYiaxzKDZaoSvz53Q/CCFI3DyxeOg/lYFPRoupxbly0I8zwlfBerEbcWKXvVd
         Kc2LA5pQUH1ERTlgIthvOfIzuVEvkk10sCTA1mXddE/XkF5CTvLGsCMJt+yGfScIenAG
         ZtN19fnw2es6musxi1YgQDXs3/KqyoQCyBxveiIGAQ7Lwcs26SKozthmhen/dQDBCf4A
         GF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=70qrjlJnUzj4vZ9SPQNnrbTU5DBAMOQbqOGEf6eUS7M=;
        b=i2N9x2KRrZi4bb3d6X6s364Ugox+G4BVlQMX26QizpOXm0+pPd77lKMMmmq24QFDNI
         Fc5HFPFSxu560kf+BLbGu1z8xQZ3c3qmrdQPiHhWNsVsoHtkhSvQTP5V20O8jmfoXjNc
         Q6mEPcZDDK1YOoCfMDFSCH+SAMB1BvWjGVaYemwxXF1tiaOrAW1i9fY4xhQOsJGf9O2T
         MtGhqzzklfvOp2z7KkOC3irdaZfc5qnkMCgCQIt+zCtutpXmyH3n+j8xM+14ZWtiErM3
         bJDWrPyDt6HeLKAoj3mZ9FNVY88Whp7wuTH2h1u5wfuzkibFwiRoqr0JRl4KyaHqoyl+
         rX2Q==
X-Gm-Message-State: AOAM530Xnf/0erxhoLwym8O4gYjnTExQrpcHdAhLkJpk2mwXTetN0LY7
        bFU1loKhWFXSKwTy4L+c3nYXMC2PXfw=
X-Google-Smtp-Source: ABdhPJzXoF7Qt/ZzXPLuGt5WcMTNoiTzcI7OgDuUnVIJX7IGribAZ74gmfW7zdInmDJk6yYTI+UCFQ==
X-Received: by 2002:a17:907:3fa5:: with SMTP id hr37mr3125416ejc.690.1643292345198;
        Thu, 27 Jan 2022 06:05:45 -0800 (PST)
Received: from [192.168.8.198] ([85.255.234.222])
        by smtp.gmail.com with ESMTPSA id c22sm6686055eds.72.2022.01.27.06.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 06:05:44 -0800 (PST)
Message-ID: <3b0f7739-542b-836e-66a6-6cd776ec57cb@gmail.com>
Date:   Thu, 27 Jan 2022 14:05:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH bpf-next v5] cgroup/bpf: fast path skb BPF filtering
Content-Language: en-US
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Stanislav Fomichev <sdf@google.com>
References: <a9ce5e5e628da06283b89496d02418cf7b942a89.1643292144.git.asml.silence@gmail.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <a9ce5e5e628da06283b89496d02418cf7b942a89.1643292144.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/27/22 14:04, Pavel Begunkov wrote:
> Even though there is a static key protecting from overhead from
> cgroup-bpf skb filtering when there is nothing attached, in many cases
> it's not enough as registering a filter for one type will ruin the fast
> path for all others. It's observed in production servers I've looked
> at but also in laptops, where registration is done during init by
> systemd or something else.

botched, please ignore

> 
> Add a per-socket fast path check guarding from such overhead. This
> affects both receive and transmit paths of TCP, UDP and other
> protocols. It showed ~1% tx/s improvement in small payload UDP
> send benchmarks using a real NIC and in a server environment and the
> number jumps to 2-3% for preemtible kernels.
> 
> Reviewed-by: Stanislav Fomichev <sdf@google.com>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
> 
> v2: replace bitmask appoach with empty_prog_array
> v3: add "bpf_" prefix to empty_prog_array
> v4: replace macros with inline functions
>      use cgroup_bpf_sock_enabled for set/getsockopt() filters
> v5: kill null sk check
> 
>   include/linux/bpf-cgroup.h | 26 +++++++++++++++++++++-----
>   include/linux/bpf.h        | 13 +++++++++++++
>   kernel/bpf/cgroup.c        | 30 ------------------------------
>   kernel/bpf/core.c          | 16 ++++------------
>   4 files changed, 38 insertions(+), 47 deletions(-)
> 
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index b525d8cdc25b..207c77b827cf 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -8,6 +8,7 @@
>   #include <linux/jump_label.h>
>   #include <linux/percpu.h>
>   #include <linux/rbtree.h>
> +#include <net/sock.h>
>   #include <uapi/linux/bpf.h>
>   
>   struct sock;
> @@ -165,11 +166,23 @@ int bpf_percpu_cgroup_storage_copy(struct bpf_map *map, void *key, void *value);
>   int bpf_percpu_cgroup_storage_update(struct bpf_map *map, void *key,
>   				     void *value, u64 flags);
>   
> +/* Opportunistic check to see whether we have any BPF program attached*/
> +static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
> +					   enum cgroup_bpf_attach_type type)
> +{
> +	struct cgroup *cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
> +	struct bpf_prog_array *array;
> +
> +	array = rcu_access_pointer(cgrp->bpf.effective[type]);
> +	return array != &bpf_empty_prog_array.hdr;
> +}
> +
>   /* Wrappers for __cgroup_bpf_run_filter_skb() guarded by cgroup_bpf_enabled. */
>   #define BPF_CGROUP_RUN_PROG_INET_INGRESS(sk, skb)			      \
>   ({									      \
>   	int __ret = 0;							      \
> -	if (cgroup_bpf_enabled(CGROUP_INET_INGRESS))		      \
> +	if (cgroup_bpf_enabled(CGROUP_INET_INGRESS) && sk &&		      \
> +	    cgroup_bpf_sock_enabled(sk, CGROUP_INET_INGRESS))		      \
>   		__ret = __cgroup_bpf_run_filter_skb(sk, skb,		      \
>   						    CGROUP_INET_INGRESS); \
>   									      \
> @@ -179,9 +192,10 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *map, void *key,
>   #define BPF_CGROUP_RUN_PROG_INET_EGRESS(sk, skb)			       \
>   ({									       \
>   	int __ret = 0;							       \
> -	if (cgroup_bpf_enabled(CGROUP_INET_EGRESS) && sk && sk == skb->sk) { \
> +	if (cgroup_bpf_enabled(CGROUP_INET_EGRESS) && sk == skb->sk) {	       \
>   		typeof(sk) __sk = sk_to_full_sk(sk);			       \
> -		if (sk_fullsock(__sk))					       \
> +		if (sk_fullsock(__sk) &&				       \
> +		    cgroup_bpf_sock_enabled(__sk, CGROUP_INET_EGRESS))	       \
>   			__ret = __cgroup_bpf_run_filter_skb(__sk, skb,	       \
>   						      CGROUP_INET_EGRESS); \
>   	}								       \
> @@ -347,7 +361,8 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *map, void *key,
>   				       kernel_optval)			       \
>   ({									       \
>   	int __ret = 0;							       \
> -	if (cgroup_bpf_enabled(CGROUP_SETSOCKOPT))			       \
> +	if (cgroup_bpf_enabled(CGROUP_SETSOCKOPT) &&			       \
> +	    cgroup_bpf_sock_enabled(sock, CGROUP_SETSOCKOPT))		       \
>   		__ret = __cgroup_bpf_run_filter_setsockopt(sock, level,	       \
>   							   optname, optval,    \
>   							   optlen,	       \
> @@ -367,7 +382,8 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *map, void *key,
>   				       max_optlen, retval)		       \
>   ({									       \
>   	int __ret = retval;						       \
> -	if (cgroup_bpf_enabled(CGROUP_GETSOCKOPT))			       \
> +	if (cgroup_bpf_enabled(CGROUP_GETSOCKOPT) &&			       \
> +	    cgroup_bpf_sock_enabled(sock, CGROUP_GETSOCKOPT))		       \
>   		if (!(sock)->sk_prot->bpf_bypass_getsockopt ||		       \
>   		    !INDIRECT_CALL_INET_1((sock)->sk_prot->bpf_bypass_getsockopt, \
>   					tcp_bpf_bypass_getsockopt,	       \
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 394305a5e02f..dcfe2de59b59 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1233,6 +1233,19 @@ struct bpf_prog_array {
>   	struct bpf_prog_array_item items[];
>   };
>   
> +struct bpf_empty_prog_array {
> +	struct bpf_prog_array hdr;
> +	struct bpf_prog *null_prog;
> +};
> +
> +/* to avoid allocating empty bpf_prog_array for cgroups that
> + * don't have bpf program attached use one global 'bpf_empty_prog_array'
> + * It will not be modified the caller of bpf_prog_array_alloc()
> + * (since caller requested prog_cnt == 0)
> + * that pointer should be 'freed' by bpf_prog_array_free()
> + */
> +extern struct bpf_empty_prog_array bpf_empty_prog_array;
> +
>   struct bpf_prog_array *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags);
>   void bpf_prog_array_free(struct bpf_prog_array *progs);
>   int bpf_prog_array_length(struct bpf_prog_array *progs);
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 279ebbed75a5..098632fdbc45 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -1384,20 +1384,6 @@ int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
>   }
>   
>   #ifdef CONFIG_NET
> -static bool __cgroup_bpf_prog_array_is_empty(struct cgroup *cgrp,
> -					     enum cgroup_bpf_attach_type attach_type)
> -{
> -	struct bpf_prog_array *prog_array;
> -	bool empty;
> -
> -	rcu_read_lock();
> -	prog_array = rcu_dereference(cgrp->bpf.effective[attach_type]);
> -	empty = bpf_prog_array_is_empty(prog_array);
> -	rcu_read_unlock();
> -
> -	return empty;
> -}
> -
>   static int sockopt_alloc_buf(struct bpf_sockopt_kern *ctx, int max_optlen,
>   			     struct bpf_sockopt_buf *buf)
>   {
> @@ -1456,19 +1442,11 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
>   	};
>   	int ret, max_optlen;
>   
> -	/* Opportunistic check to see whether we have any BPF program
> -	 * attached to the hook so we don't waste time allocating
> -	 * memory and locking the socket.
> -	 */
> -	if (__cgroup_bpf_prog_array_is_empty(cgrp, CGROUP_SETSOCKOPT))
> -		return 0;
> -
>   	/* Allocate a bit more than the initial user buffer for
>   	 * BPF program. The canonical use case is overriding
>   	 * TCP_CONGESTION(nv) to TCP_CONGESTION(cubic).
>   	 */
>   	max_optlen = max_t(int, 16, *optlen);
> -
>   	max_optlen = sockopt_alloc_buf(&ctx, max_optlen, &buf);
>   	if (max_optlen < 0)
>   		return max_optlen;
> @@ -1550,15 +1528,7 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
>   	};
>   	int ret;
>   
> -	/* Opportunistic check to see whether we have any BPF program
> -	 * attached to the hook so we don't waste time allocating
> -	 * memory and locking the socket.
> -	 */
> -	if (__cgroup_bpf_prog_array_is_empty(cgrp, CGROUP_GETSOCKOPT))
> -		return retval;
> -
>   	ctx.optlen = max_optlen;
> -
>   	max_optlen = sockopt_alloc_buf(&ctx, max_optlen, &buf);
>   	if (max_optlen < 0)
>   		return max_optlen;
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 0a1cfd8544b9..04a8d5bea552 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1968,18 +1968,10 @@ static struct bpf_prog_dummy {
>   	},
>   };
>   
> -/* to avoid allocating empty bpf_prog_array for cgroups that
> - * don't have bpf program attached use one global 'empty_prog_array'
> - * It will not be modified the caller of bpf_prog_array_alloc()
> - * (since caller requested prog_cnt == 0)
> - * that pointer should be 'freed' by bpf_prog_array_free()
> - */
> -static struct {
> -	struct bpf_prog_array hdr;
> -	struct bpf_prog *null_prog;
> -} empty_prog_array = {
> +struct bpf_empty_prog_array bpf_empty_prog_array = {
>   	.null_prog = NULL,
>   };
> +EXPORT_SYMBOL(bpf_empty_prog_array);
>   
>   struct bpf_prog_array *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags)
>   {
> @@ -1989,12 +1981,12 @@ struct bpf_prog_array *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags)
>   			       (prog_cnt + 1),
>   			       flags);
>   
> -	return &empty_prog_array.hdr;
> +	return &bpf_empty_prog_array.hdr;
>   }
>   
>   void bpf_prog_array_free(struct bpf_prog_array *progs)
>   {
> -	if (!progs || progs == &empty_prog_array.hdr)
> +	if (!progs || progs == &bpf_empty_prog_array.hdr)
>   		return;
>   	kfree_rcu(progs, rcu);
>   }

-- 
Pavel Begunkov
