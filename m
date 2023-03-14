Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2526B8AED
	for <lists+bpf@lfdr.de>; Tue, 14 Mar 2023 07:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjCNGF7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Mar 2023 02:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCNGF6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 02:05:58 -0400
Received: from out-25.mta1.migadu.com (out-25.mta1.migadu.com [95.215.58.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898578DCEB
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 23:05:54 -0700 (PDT)
Message-ID: <685fe34b-4f84-8bb2-4da7-67eef8ca3b0e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678773952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o+SD+4TO51Ptk2KisSv0fSCt9ldtoaUwYbooz3qMg7g=;
        b=nmm7tPcHpkoaD/2AOfRzo7lK1XcjjgrQTgPRmShEjWok/+bnBeYRsY44vVjz9HX4fAzTD0
        FQ4yV3ZSg0fcgMNbu80z5QGn3H3WoCDim+iSCIk1dpYEsOL5gNmjbXu1vW0fZRZZzSYEl7
        37tQRrcb/qUYSl/2HvQW9pQhMab5yoM=
Date:   Mon, 13 Mar 2023 23:05:49 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 1/8] bpf: Retire the struct_ops map
 kvalue->refcnt.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@meta.com>
References: <20230310043812.3087672-1-kuifeng@meta.com>
 <20230310043812.3087672-2-kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230310043812.3087672-2-kuifeng@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/9/23 8:38 PM, Kui-Feng Lee wrote:
> We have replaced kvalue-refcnt with synchronize_rcu() to wait for an
> RCU grace period.
> 
> Maintenance of kvalue->refcnt was a complicated task, as we had to
> simultaneously keep track of two reference counts: one for the
> reference count of bpf_map. When the kvalue->refcnt reaches zero, we
> also have to reduce the reference count on bpf_map - yet these steps
> are not performed in an atomic manner and require us to be vigilant
> when managing them. By eliminating kvalue->refcnt, we can make our
> maintenance more straightforward as the refcount of bpf_map is now
> solely managed!
> 
> To prevent the trampoline image of a struct_ops from being released
> while it is still in use, we wait for an RCU grace period. The
> setsockopt(TCP_CONGESTION, "...") command allows you to change your
> socket's congestion control algorithm and can result in releasing the
> old struct_ops implementation.

If the setsockopt() above is referring to the syscall setsockopt(), then the old 
struct_ops is fine. The old struct_ops is protected by the struct_ops map's 
refcnt (or the current kvalue->refcnt). The sk in setsockopt(sk, ...) will no 
longer use the old struct_ops before the refcnt is decremented. This part should 
be the same as the tcp-cc kernel module.

> Moreover, since this function is
> exposed through bpf_setsockopt(), it may be accessed by BPF programs
> as well. To ensure that the trampoline image belonging to struct_op
> can be safely called while its method is in use, struct_ops is
> safeguarded with rcu_read_lock(). Doing so prevents any destruction of
> the associated images before returning from a trampoline and requires
> us to wait for an RCU grace period.

The bpf_setsockopt(TCP_CONGESTION) is the reason that the trampoline image needs 
a grace period, but I noticed RCU grace period itself is not enough for 
trampoline image and more on this later.

Another reason the struct_ops map needs a RCU grace period is because of the 
bpf_try_module_get() (in tcp_set_default_congestion_control for example).


> ---
>   include/linux/bpf.h         |  1 +
>   kernel/bpf/bpf_struct_ops.c | 68 ++++++++++++++++++++-----------------
>   kernel/bpf/syscall.c        |  6 ++--
>   3 files changed, 42 insertions(+), 33 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index e64ff1e89fb2..00ca92ea6f2e 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1938,6 +1938,7 @@ struct bpf_map *bpf_map_get_with_uref(u32 ufd);
>   struct bpf_map *__bpf_map_get(struct fd f);
>   void bpf_map_inc(struct bpf_map *map);
>   void bpf_map_inc_with_uref(struct bpf_map *map);
> +struct bpf_map *__bpf_map_inc_not_zero(struct bpf_map *map, bool uref);
>   struct bpf_map * __must_check bpf_map_inc_not_zero(struct bpf_map *map);
>   void bpf_map_put_with_uref(struct bpf_map *map);
>   void bpf_map_put(struct bpf_map *map);
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 38903fb52f98..ab7811a4c1dd 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -58,6 +58,11 @@ struct bpf_struct_ops_map {
>   	struct bpf_struct_ops_value kvalue;
>   };
>   
> +struct bpf_struct_ops_link {
> +	struct bpf_link link;
> +	struct bpf_map __rcu *map;
> +};

Comparing with v5, this is moved from patch 3 to patch 1. It is not used here, 
so it belongs to patch 3.


> @@ -574,6 +585,19 @@ static void bpf_struct_ops_map_free(struct bpf_map *map)
>   {
>   	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
>   
> +	/* The struct_ops's function may switch to another struct_ops.
> +	 *
> +	 * For example, bpf_tcp_cc_x->init() may switch to
> +	 * another tcp_cc_y by calling
> +	 * setsockopt(TCP_CONGESTION, "tcp_cc_y").
> +	 * During the switch,  bpf_struct_ops_put(tcp_cc_x) is called
> +	 * and its refcount may reach 0 which then free its
> +	 * trampoline image while tcp_cc_x is still running.
> +	 *
> +	 * Thus, a rcu grace period is needed here.
> +	 */
> +	synchronize_rcu();

After the trampoline image finished running a struct_ops's "prog", it still has 
a few insn need to execute in the trampoline image, so it also needs to wait for 
synchronize_rcu_tasks/call_rcu_tasks.

This is an old issue, only happens when the struct_ops prog calls 
bpf_setsockopt(TCP_CONGESTION) with CONFIG_PREEMPT and unlikely other upcoming 
struct_ops subsystem may need this, please help to do a follow up fix on it 
(separate from this set) to also wait for the rcu_tasks gp.


