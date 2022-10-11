Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B235FAF18
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 11:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiJKJJu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Oct 2022 05:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiJKJJr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Oct 2022 05:09:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DC212AF6;
        Tue, 11 Oct 2022 02:09:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 782AEB8077D;
        Tue, 11 Oct 2022 09:09:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09370C433D6;
        Tue, 11 Oct 2022 09:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665479384;
        bh=e/JcTTsFExZNIu2rmBxBfqtrwgiK/DKYtwEa/H3b/ng=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hnndYwFMHpi4kR7q16r87yuReLUbAnhNXK2PNks+YXRBrQrMhMePbZ/Anz4g3O1NN
         NiEbm3Q+ORLUXvJJYLGIFpnJxUinJ8781Lc/kZiB8x6ssPYgHO4rX0he2qRSx2bsJ6
         xAT5ZaY9+KuWhLeOFluc4/tftUZNnEhuAA8Hi/dokQZ9zy48rwFuQRg2pmx7Wfd5/J
         d0jjAo3fWJdbwTBghHxIQ7DEH+uRL2bDdzGVnHJOLLs8z9LMnkbvDygVD9GZJWRNV8
         QQNQ3G6LfpBvYCkdx3h4Viib54arAzqf7Z0YW/PI+/SkNj9XtqTRAmVQx8hwfLEOTv
         tSQQ9Ghhzod8w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5D5F85C1959; Tue, 11 Oct 2022 02:09:41 -0700 (PDT)
Date:   Tue, 11 Oct 2022 02:09:41 -0700
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
Subject: Re: [PATCH bpf-next 3/3] bpf: Free trace program array after one
 RCU-tasks-trace grace period
Message-ID: <20221011090941.GI4221@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221011071128.3470622-1-houtao@huaweicloud.com>
 <20221011071128.3470622-4-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011071128.3470622-4-houtao@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 11, 2022 at 03:11:28PM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> To support sleepable uprobe bpf program, the freeing of trace program
> array chains a RCU-tasks-trace grace period with a normal RCU grace
> period. But considering in the current implementation of RCU-tasks-trace
> that one RCU-tasks-trace grace period implies one normal RCU grace
> period, so it is not need for such chaining and it is safe to free the
> array in the callback of call_rcu_tasks_trace().

And the same here.  ;-)

							Thanx, Paul

> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/bpf/core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 711fd293b6de..f943620b55b0 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2247,12 +2247,15 @@ void bpf_prog_array_free(struct bpf_prog_array *progs)
>  	kfree_rcu(progs, rcu);
>  }
>  
> +/* Now RCU Tasks grace period implies RCU grace period, so no need to call
> + * kfree_rcu(), just call kfree() directly.
> + */
>  static void __bpf_prog_array_free_sleepable_cb(struct rcu_head *rcu)
>  {
>  	struct bpf_prog_array *progs;
>  
>  	progs = container_of(rcu, struct bpf_prog_array, rcu);
> -	kfree_rcu(progs, rcu);
> +	kfree(progs);
>  }
>  
>  void bpf_prog_array_free_sleepable(struct bpf_prog_array *progs)
> -- 
> 2.29.2
> 
