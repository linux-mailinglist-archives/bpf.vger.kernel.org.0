Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DD56A8CFF
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 00:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjCBX1v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 18:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjCBX1v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 18:27:51 -0500
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68595942C
        for <bpf@vger.kernel.org>; Thu,  2 Mar 2023 15:27:30 -0800 (PST)
Received: by mail-qv1-f54.google.com with SMTP id jo29so722890qvb.0
        for <bpf@vger.kernel.org>; Thu, 02 Mar 2023 15:27:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677799650;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xsvRxZ0DqbvqPTo+o1p+OYRZ8VDPrflvrN3I+q/8GWs=;
        b=aQjnDcRPIgT8yoDfU10H45EjQnryqEsAF2QbwhDVXjsZz+56fSnJac8M8pbr2A+pMJ
         gmk4oy4YkQdq312UiulX1imEWFfMa0w17nhx1em9aiFoOcDzAVPzRxRcVgavxYpUDA1i
         wKiw/tpUX+y82o5dkfcnWFPlOnZSfhViZCreXtStI2Z4Pwj35X4xZm4eLbm0eN+9AWsr
         +pyeTa3iMonGk7W9tYH/rwdTobEa/bTXhvo8Tv00HkQq2++YEL5j867vmnF6/sU1WjUP
         VE0srhV4mCd+FDYqBp/74rEU7tVCRFsX0xJAyMS567cWhIe1EBG3u8q6pA6MEM3HqnDr
         STqQ==
X-Gm-Message-State: AO0yUKW8kclBMZYFK1WSGCA/ESLj8wdRsvdHFSnCY9BPjcNkIeyM6f0h
        1+w06CKdYzNVV+zFP50zOOHgmzvGeOTA3l6Y
X-Google-Smtp-Source: AK7set+OnO9D5+zt7H1EOEe5vGcJWzWEAYqYXzeEuYVhs2Rn3Ez+m3+PCabm6CD54ljO8lj9rNTuLQ==
X-Received: by 2002:ad4:5cea:0:b0:570:bf43:499 with SMTP id iv10-20020ad45cea000000b00570bf430499mr22722511qvb.9.1677799649607;
        Thu, 02 Mar 2023 15:27:29 -0800 (PST)
Received: from maniforge ([2620:10d:c091:480::1:5ba])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a254a00b007426b917031sm567632qko.121.2023.03.02.15.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 15:27:29 -0800 (PST)
Date:   Thu, 2 Mar 2023 17:27:27 -0600
From:   David Vernet <void@manifault.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add -Wuninitialized flag to bpf
 prog flags
Message-ID: <ZAEw36Rh4rSgzcc+@maniforge>
References: <20230302231924.344383-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302231924.344383-1-davemarchevsky@fb.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 02, 2023 at 03:19:24PM -0800, Dave Marchevsky wrote:
> Per C99 standard [0], Section 6.7.8, Paragraph 10:
> 
>   If an object that has automatic storage duration is not initialized
>   explicitly, its value is indeterminate.
> 
> And in the same document, in appendix "J.2 Undefined behavior":
> 
>   The behavior is undefined in the following circumstances:
>   [...]
>   The value of an object with automatic storage duration is used while
>   it is indeterminate (6.2.4, 6.7.8, 6.8).
> 
> This means that use of an uninitialized stack variable is undefined
> behavior, and therefore that clang can choose to do a variety of scary
> things, such as not generating bytecode for "bunch of useful code" in
> the below example:
> 
>   void some_func()
>   {
>     int i;
>     if (!i)
>       return;
>     // bunch of useful code
>   }
> 
> To add insult to injury, if some_func above is a helper function for
> some BPF program, clang can choose to not generate an "exit" insn,
> causing verifier to fail with "last insn is not an exit or jmp". Going
> from that verification failure to the root cause of uninitialized use
> is certain to be frustrating.
> 
> This patch adds -Wuninitialized to the cflags for selftest BPF progs and
> fixes up existing instances of uninitialized use.
> 
>   [0]: https://www.open-std.org/jtc1/sc22/WG14/www/docs/n1256.pdf
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> Cc: David Vernet <void@manifault.com>
> Cc: Tejun Heo <tj@kernel.org>

Acked-by: David Vernet <void@manifault.com>

> ---
>  tools/testing/selftests/bpf/Makefile                   |  2 +-
>  tools/testing/selftests/bpf/progs/rbtree.c             |  2 +-
>  tools/testing/selftests/bpf/progs/rbtree_fail.c        |  5 +++--
>  .../selftests/bpf/progs/test_kfunc_dynptr_param.c      |  2 +-
>  .../testing/selftests/bpf/progs/test_sk_lookup_kern.c  |  2 +-
>  tools/testing/selftests/bpf/progs/test_tunnel_kern.c   | 10 +++++-----
>  6 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index f40606a85a0f..eab3cf5399f5 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -357,7 +357,7 @@ BPF_CFLAGS = -g -Werror -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN) 		\
>  	     -I$(abspath $(OUTPUT)/../usr/include)
>  
>  CLANG_CFLAGS = $(CLANG_SYS_INCLUDES) \
> -	       -Wno-compare-distinct-pointer-types
> +	       -Wno-compare-distinct-pointer-types -Wuninitialized
>  
>  $(OUTPUT)/test_l4lb_noinline.o: BPF_CFLAGS += -fno-inline
>  $(OUTPUT)/test_xdp_noinline.o: BPF_CFLAGS += -fno-inline
> diff --git a/tools/testing/selftests/bpf/progs/rbtree.c b/tools/testing/selftests/bpf/progs/rbtree.c
> index e5db1a4287e5..4c90aa6abddd 100644
> --- a/tools/testing/selftests/bpf/progs/rbtree.c
> +++ b/tools/testing/selftests/bpf/progs/rbtree.c
> @@ -75,7 +75,7 @@ SEC("tc")
>  long rbtree_add_and_remove(void *ctx)
>  {
>  	struct bpf_rb_node *res = NULL;
> -	struct node_data *n, *m;
> +	struct node_data *n, *m = NULL;
>  
>  	n = bpf_obj_new(typeof(*n));
>  	if (!n)
> diff --git a/tools/testing/selftests/bpf/progs/rbtree_fail.c b/tools/testing/selftests/bpf/progs/rbtree_fail.c
> index bf3cba115897..3368f4b05ca0 100644
> --- a/tools/testing/selftests/bpf/progs/rbtree_fail.c
> +++ b/tools/testing/selftests/bpf/progs/rbtree_fail.c
> @@ -232,8 +232,9 @@ long rbtree_api_first_release_unlock_escape(void *ctx)
>  
>  	bpf_spin_lock(&glock);
>  	res = bpf_rbtree_first(&groot);
> -	if (res)
> -		n = container_of(res, struct node_data, node);
> +	if (!res)
> +		return -1;
> +	n = container_of(res, struct node_data, node);
>  	bpf_spin_unlock(&glock);
>  
>  	bpf_spin_lock(&glock);
> diff --git a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> index 2fbef3cc7ad8..2dde8e3fe4c9 100644
> --- a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> +++ b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> @@ -48,7 +48,7 @@ SEC("?lsm.s/bpf")
>  __failure __msg("arg#0 expected pointer to stack or dynptr_ptr")
>  int BPF_PROG(not_ptr_to_stack, int cmd, union bpf_attr *attr, unsigned int size)
>  {
> -	unsigned long val;
> +	unsigned long val = 0;
>  
>  	return bpf_verify_pkcs7_signature((struct bpf_dynptr *)val,
>  					  (struct bpf_dynptr *)val, NULL);
> diff --git a/tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c b/tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c
> index b502e5c92e33..6ccf6d546074 100644
> --- a/tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c
> +++ b/tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c
> @@ -23,8 +23,8 @@ static struct bpf_sock_tuple *get_tuple(void *data, __u64 nh_off,
>  					bool *ipv4)
>  {
>  	struct bpf_sock_tuple *result;
> +	__u64 ihl_len = 0;
>  	__u8 proto = 0;
> -	__u64 ihl_len;
>  
>  	if (eth_proto == bpf_htons(ETH_P_IP)) {
>  		struct iphdr *iph = (struct iphdr *)(data + nh_off);
> diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> index 508da4a23c4f..95b4aa0928ba 100644
> --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c

Coincidentally, this seems to also be failing on master.

> @@ -324,11 +324,11 @@ int ip4ip6erspan_get_tunnel(struct __sk_buff *skb)
>  SEC("tc")
>  int vxlan_set_tunnel_dst(struct __sk_buff *skb)
>  {
> -	int ret;
>  	struct bpf_tunnel_key key;
>  	struct vxlan_metadata md;
>  	__u32 index = 0;
>  	__u32 *local_ip = NULL;
> +	int ret = 0;
>  
>  	local_ip = bpf_map_lookup_elem(&local_ip_map, &index);
>  	if (!local_ip) {
> @@ -363,11 +363,11 @@ int vxlan_set_tunnel_dst(struct __sk_buff *skb)
>  SEC("tc")
>  int vxlan_set_tunnel_src(struct __sk_buff *skb)
>  {
> -	int ret;
>  	struct bpf_tunnel_key key;
>  	struct vxlan_metadata md;
>  	__u32 index = 0;
>  	__u32 *local_ip = NULL;
> +	int ret = 0;
>  
>  	local_ip = bpf_map_lookup_elem(&local_ip_map, &index);
>  	if (!local_ip) {
> @@ -494,9 +494,9 @@ SEC("tc")
>  int ip6vxlan_set_tunnel_dst(struct __sk_buff *skb)
>  {
>  	struct bpf_tunnel_key key;
> -	int ret;
>  	__u32 index = 0;
>  	__u32 *local_ip;
> +	int ret = 0;
>  
>  	local_ip = bpf_map_lookup_elem(&local_ip_map, &index);
>  	if (!local_ip) {
> @@ -525,9 +525,9 @@ SEC("tc")
>  int ip6vxlan_set_tunnel_src(struct __sk_buff *skb)
>  {
>  	struct bpf_tunnel_key key;
> -	int ret;
>  	__u32 index = 0;
>  	__u32 *local_ip;
> +	int ret = 0;
>  
>  	local_ip = bpf_map_lookup_elem(&local_ip_map, &index);
>  	if (!local_ip) {
> @@ -556,9 +556,9 @@ SEC("tc")
>  int ip6vxlan_get_tunnel_src(struct __sk_buff *skb)
>  {
>  	struct bpf_tunnel_key key;
> -	int ret;
>  	__u32 index = 0;
>  	__u32 *local_ip;
> +	int ret = 0;
>  
>  	local_ip = bpf_map_lookup_elem(&local_ip_map, &index);
>  	if (!local_ip) {
> -- 
> 2.30.2
> 
