Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3656584F6C
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 13:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbiG2LRD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 07:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbiG2LRC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 07:17:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C2F7FE5C;
        Fri, 29 Jul 2022 04:17:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23E5EB82779;
        Fri, 29 Jul 2022 11:16:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C00AC433D6;
        Fri, 29 Jul 2022 11:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659093417;
        bh=RXYoK6oz0l5y7J6IuTr4803g99DXwdBPQzEWV2FGtZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZISK5VAYZOAKJnI9umDVFUWwzO+abJ/Z+Gj7BkCazpuBC/7Yts3Zw/DSwyf9iXmVF
         SBrjtLpkhsE5ASJfFsqv6Q898r9SIgTVOCDEtHMnw/04DdOOcifjf9fw2SHpESAdZx
         iKHq96IseBfanP6ywzFnTws3+Vt5sY1g6Ur1u6r8=
Date:   Fri, 29 Jul 2022 13:16:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhang Wensheng <zhangwensheng@huaweicloud.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        yukuai3@huawei.com
Subject: Re: [PATCH -next] [RFC] block: fix null-deref in percpu_ref_put
Message-ID: <YuPBpn0jIEy65T6P@kroah.com>
References: <20220729105036.2202791-1-zhangwensheng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729105036.2202791-1-zhangwensheng@huaweicloud.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 29, 2022 at 06:50:36PM +0800, Zhang Wensheng wrote:
> From: Zhang Wensheng <zhangwensheng5@huawei.com>
> 
> A problem was find in stable 5.10 and the root cause of it like below.

5.10 is very old, is this still an issue in Linus's tree?

> 
> In the use of q_usage_counter of request_queue, blk_cleanup_queue using
> "wait_event(q->mq_freeze_wq, percpu_ref_is_zero(&q->q_usage_counter))"
> to wait q_usage_counter becoming zero. however, if the q_usage_counter
> becoming zero quickly, and percpu_ref_exit will execute and ref->data
> will be freed, maybe another process will cause a null-defef problem
> like below:
> 
> 	CPU0                             CPU1
> blk_cleanup_queue
>  blk_freeze_queue
>   blk_mq_freeze_queue_wait
> 				scsi_end_request
> 				 percpu_ref_get
> 				 ...
> 				 percpu_ref_put
> 				  atomic_long_sub_and_test
>   percpu_ref_exit
>    ref->data -> NULL
>    				   ref->data->release(ref) -> null-deref
> 
> Fix it by setting flag(QUEUE_FLAG_USAGE_COUNT_SYNC) to add synchronization
> mechanism, when ref->data->release is called, the flag will be setted,
> and the "wait_event" in blk_mq_freeze_queue_wait must wait flag becoming
> true as well, which will limit percpu_ref_exit to execute ahead of time.
> 
> Although the problem was not reproduced in mainline, it may also has
> problem when the passthrough IO which will go directly to
> blk_cleanup_queue and cause the problem as well.
> 
> Signed-off-by: Zhang Wensheng <zhangwensheng5@huawei.com>

As the documentation said, this is not how you mark things for stable
backports.

> ---
>  block/blk-core.c       | 4 +++-
>  block/blk-mq.c         | 7 +++++++
>  include/linux/blk-mq.h | 1 +
>  include/linux/blkdev.h | 2 ++
>  4 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 27fb1357ad4b..4b73f46e62ec 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -312,7 +312,8 @@ void blk_cleanup_queue(struct request_queue *q)
>  	 * prevent that blk_mq_run_hw_queues() accesses the hardware queues
>  	 * after draining finished.
>  	 */
> -	blk_freeze_queue(q);
> +	blk_freeze_queue_start(q);
> +	blk_mq_freeze_queue_wait_sync(q);
>  
>  	blk_queue_flag_set(QUEUE_FLAG_DEAD, q);
>  
> @@ -403,6 +404,7 @@ static void blk_queue_usage_counter_release(struct percpu_ref *ref)
>  	struct request_queue *q =
>  		container_of(ref, struct request_queue, q_usage_counter);
>  
> +	blk_queue_flag_set(QUEUE_FLAG_USAGE_COUNT_SYNC, q);
>  	wake_up_all(&q->mq_freeze_wq);
>  }
>  
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 93d9d60980fb..44e764257511 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -165,6 +165,7 @@ void blk_freeze_queue_start(struct request_queue *q)
>  {
>  	mutex_lock(&q->mq_freeze_lock);
>  	if (++q->mq_freeze_depth == 1) {
> +		blk_queue_flag_clear(QUEUE_FLAG_USAGE_COUNT_SYNC, q);
>  		percpu_ref_kill(&q->q_usage_counter);
>  		mutex_unlock(&q->mq_freeze_lock);
>  		if (queue_is_mq(q))
> @@ -175,6 +176,12 @@ void blk_freeze_queue_start(struct request_queue *q)
>  }
>  EXPORT_SYMBOL_GPL(blk_freeze_queue_start);
>  
> +void blk_mq_freeze_queue_wait_sync(struct request_queue *q)
> +{
> +	wait_event(q->mq_freeze_wq, percpu_ref_is_zero(&q->q_usage_counter) &&
> +			test_bit(QUEUE_FLAG_USAGE_COUNT_SYNC, &q->queue_flags));

No timeout ever?


> +}
> +
>  void blk_mq_freeze_queue_wait(struct request_queue *q)
>  {
>  	wait_event(q->mq_freeze_wq, percpu_ref_is_zero(&q->q_usage_counter));
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index e2d9daf7e8dd..50fd56f85b31 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -868,6 +868,7 @@ void blk_mq_freeze_queue(struct request_queue *q);
>  void blk_mq_unfreeze_queue(struct request_queue *q);
>  void blk_freeze_queue_start(struct request_queue *q);
>  void blk_mq_freeze_queue_wait(struct request_queue *q);
> +void blk_mq_freeze_queue_wait_sync(struct request_queue *q);
>  int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
>  				     unsigned long timeout);
>  
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 2f7b43444c5f..93ed8b166d66 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -575,6 +575,8 @@ struct request_queue {
>  #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
>  #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
>  #define QUEUE_FLAG_SQ_SCHED     30	/* single queue style io dispatch */
> +/* sync for q_usage_counter */
> +#define QUEUE_FLAG_USAGE_COUNT_SYNC    31

Why not put the comment a the end of the line like everything else in
this list?

And why not use tabs?

thanks,

greg k-h
