Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC1F585134
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 15:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236547AbiG2N6v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 09:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236617AbiG2N6u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 09:58:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8EC8971718
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 06:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659103127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KJ/dTGRKY5+i0pAGUfeAsafS5YcWMs3vOgIRft+7hTg=;
        b=XoCFkWaQHTg8IXwUrD0wVC+Nbdg+NaiexdE2he2ZXc95+H1tctDeSxZkIurpvGs5HuCUJt
        kcVscIXNgHJ/Xf1SNgYWOsShUJFzA2cZ1dPjTtQytwaQd5Gzrm91WefVxmbOYGA7F7/oA3
        ty1aUvrvT+pLUx9yVsoDdYCFqP9V9ts=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-265-89npC9uvNP2GoxXiZhxWDg-1; Fri, 29 Jul 2022 09:58:46 -0400
X-MC-Unique: 89npC9uvNP2GoxXiZhxWDg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 009AA8039A3;
        Fri, 29 Jul 2022 13:58:46 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 156D22166B2D;
        Fri, 29 Jul 2022 13:58:41 +0000 (UTC)
Date:   Fri, 29 Jul 2022 21:58:36 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Zhang Wensheng <zhangwensheng@huaweicloud.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        yukuai3@huawei.com
Subject: Re: [PATCH -next] [RFC] block: fix null-deref in percpu_ref_put
Message-ID: <YuPnjI8oHx4dO3nr@T590>
References: <20220729105036.2202791-1-zhangwensheng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729105036.2202791-1-zhangwensheng@huaweicloud.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 29, 2022 at 06:50:36PM +0800, Zhang Wensheng wrote:
> From: Zhang Wensheng <zhangwensheng5@huawei.com>
> 
> A problem was find in stable 5.10 and the root cause of it like below.
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

Looks it is one generic issue in percpu_ref, I think the following patch
should address it.


diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
index d73a1c08c3e3..07308bd36d83 100644
--- a/include/linux/percpu-refcount.h
+++ b/include/linux/percpu-refcount.h
@@ -331,8 +331,12 @@ static inline void percpu_ref_put_many(struct percpu_ref *ref, unsigned long nr)
 
 	if (__ref_is_percpu(ref, &percpu_count))
 		this_cpu_sub(*percpu_count, nr);
-	else if (unlikely(atomic_long_sub_and_test(nr, &ref->data->count)))
-		ref->data->release(ref);
+	else {
+		percpu_ref_func_t	*release = ref->data->release;
+
+		if (unlikely(atomic_long_sub_and_test(nr, &ref->data->count)))
+			release(ref);
+	}
 
 	rcu_read_unlock();
 }


Thanks,
Ming

