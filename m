Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2BB5FAF16
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 11:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJKJJL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Oct 2022 05:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJKJJK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Oct 2022 05:09:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D28838A2A;
        Tue, 11 Oct 2022 02:09:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6846B81263;
        Tue, 11 Oct 2022 09:09:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 699FDC433C1;
        Tue, 11 Oct 2022 09:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665479345;
        bh=Ut+sPqo7tdjkvGWeQfn49BVRj0mTMwY6TBjjJlYk4ZY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VIzbRw2U0sZ/mlt5GntwI/v6KOkMQBviBDzoRe7dzcJkfPMXHKIuFi/25xm+PMvNj
         Qh76kkAeHR5r/dmA7uhHoEBcDdL+7jK9y05KryrN7dDpAFDRyuoSnVvsT7bAVHhKQw
         XLhm/MrRi13ZMXTviBOsKt4RKjoewg82xWtMUQ1bQwptk6dLVSlJ1eYa71sRfrFWMS
         LQ2+2fNOWVIt4kXDGgKQNdMT4KQLAyQHh5j/L7fPdiO1/MknYOWs4I1popNun1KDgq
         8uzTA3LqGzyTIg8VQoLsJFaLH+3zwD7Y40f+B8MPZ5jrWnViv/I0/Mbzx58Fuz2lZQ
         Mx3XMac9VKr4g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C437E5C1959; Tue, 11 Oct 2022 02:09:02 -0700 (PDT)
Date:   Tue, 11 Oct 2022 02:09:02 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Delyan Kratunov <delyank@fb.com>, rcu@vger.kernel.org,
        houtao1@huawei.com
Subject: Re: [PATCH bpf-next 2/3] bpf: Free local storage memory after one
 RCU-tasks-trace grace period
Message-ID: <20221011090902.GH4221@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221011071128.3470622-1-houtao@huaweicloud.com>
 <20221011071128.3470622-3-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011071128.3470622-3-houtao@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 11, 2022 at 03:11:27PM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Local storage map is accessible for both sleepable and normal bpf
> program, so its memory is freed by using both call_rcu_tasks_trace() and
> kfree_rcu() to wait for both RCU-tasks-trace grace period and RCU grace
> period to expire.
> 
> However According to the current implementation of RCU-tasks-trace, one
> RCU-tasks-trace grace period waits for one RCU grace period, so there is
> no need to call kfree_rcu(), it is safe to call kfree() directly.

Again, this is true, but this is an implementation detail that is not
guaranteed in future versions of the kernel.  But if this additional
call_rcu() is causing trouble, I could add some API member that
returned true in kernels where it does happen to be the case that
call_rcu_tasks_trace() implies a call_rcu()-style grace period.

The BPF local storage code could then complain or adapt, as appropriate.

Again, thoughts?

							Thanx, Paul

> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/bpf/bpf_local_storage.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> index 802fc15b0d73..18a2dd611635 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -84,20 +84,26 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
>  	return NULL;
>  }
>  
> +/* Now RCU Tasks grace period implies RCU grace period, so no need to call
> + * kfree_rcu(), just call kfree() directly.
> + */
>  void bpf_local_storage_free_rcu(struct rcu_head *rcu)
>  {
>  	struct bpf_local_storage *local_storage;
>  
>  	local_storage = container_of(rcu, struct bpf_local_storage, rcu);
> -	kfree_rcu(local_storage, rcu);
> +	kfree(local_storage);
>  }
>  
> +/* Now RCU Tasks grace period implies RCU grace period, so no need to call
> + * kfree_rcu(), just call kfree() directly.
> + */
>  static void bpf_selem_free_rcu(struct rcu_head *rcu)
>  {
>  	struct bpf_local_storage_elem *selem;
>  
>  	selem = container_of(rcu, struct bpf_local_storage_elem, rcu);
> -	kfree_rcu(selem, rcu);
> +	kfree(selem);
>  }
>  
>  /* local_storage->lock must be held and selem->local_storage == local_storage.
> -- 
> 2.29.2
> 
