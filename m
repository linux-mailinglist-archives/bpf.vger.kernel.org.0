Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE58562BCF
	for <lists+bpf@lfdr.de>; Fri,  1 Jul 2022 08:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbiGAGbb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Jul 2022 02:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbiGAGba (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Jul 2022 02:31:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7437F1403B
        for <bpf@vger.kernel.org>; Thu, 30 Jun 2022 23:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656657088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t4mq0djcD9YM3JASrOeZhnSSARiulyBSa0GkqeNjlYw=;
        b=JZhvhR+f+kWD4Dcc8nshOcQE+cHPYJ3T0hJRHxwa0unW9J39bCxSB/Wt5KAWXZCFFUPnpO
        i4ZlpH9fc3z7VtXmcfs+sPDqwbylli8811UCRKKSz3pyPdrJbH6y5g5Hv6is+rX3BP9Qxp
        HnxGI5njVb6Ix7TBKD7Q6IYf9FfvrnE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-494-Bl1J2TUdOYepYSjEelkFvw-1; Fri, 01 Jul 2022 02:31:27 -0400
X-MC-Unique: Bl1J2TUdOYepYSjEelkFvw-1
Received: by mail-ed1-f70.google.com with SMTP id z19-20020a05640240d300b00437633081abso1128317edb.0
        for <bpf@vger.kernel.org>; Thu, 30 Jun 2022 23:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t4mq0djcD9YM3JASrOeZhnSSARiulyBSa0GkqeNjlYw=;
        b=Msm1xt87jpxMS3jS2FBMpSh7dy9teJj+1nvlBlx4qEo8m6BGFcE6rq3+Ksovxos7jd
         uyNIpN53HocXKgMoD4XpH0nkdhcDLE7buNh/qsIv81nmffAcEjL5f4hYQOAxJKjP3LeU
         L68nYE0u+yXgHXo78WpbN2p5LBOJJqMCsydK+nTnmYSD0EM+LmykLJquLNdWFn6+npOZ
         KRXS+R0od2E6LYKcm5AKiDjcJDXildFVzE9JFbj75Wz1Aa5NgqGhpKUorD6l6lxnOGmE
         VyYhVGQHw0PP15F6cR+E2GoTKFrEIbPaH5l2YfSkNGndibGCveMmnqDWSdsOtYDtbYTp
         GCDA==
X-Gm-Message-State: AJIora+rueuDo4AhvS4UGAaJxzGmdP+wm8g93Uc6F9svxp47ZOiZzBEt
        hV0+CpFJR6pcUeyiadsXCyw0uHSXyV8LMKs0bAJsmlMHthEhSAhXD59PodcpMtWdR+nw5G44oh1
        MglsKhHbNop5l
X-Received: by 2002:a17:907:2704:b0:72a:596f:8b9f with SMTP id w4-20020a170907270400b0072a596f8b9fmr7711937ejk.761.1656657086011;
        Thu, 30 Jun 2022 23:31:26 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uBC6Csq0KK3mHQr921uHGRsVzPm9YamAGsOXqm/7tt8aIzVOGmGN35oK+8gpDy+vr5kzch1Q==
X-Received: by 2002:a17:907:2704:b0:72a:596f:8b9f with SMTP id w4-20020a170907270400b0072a596f8b9fmr7711894ejk.761.1656657085791;
        Thu, 30 Jun 2022 23:31:25 -0700 (PDT)
Received: from redhat.com ([2.55.3.188])
        by smtp.gmail.com with ESMTPSA id ia10-20020a170907a06a00b0070b7875aa6asm9874051ejc.166.2022.06.30.23.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 23:31:25 -0700 (PDT)
Date:   Fri, 1 Jul 2022 02:31:18 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     virtualization@lists.linux-foundation.org,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-um@lists.infradead.org, netdev@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, bpf@vger.kernel.org,
        kangjie.xu@linux.alibaba.com
Subject: Re: [PATCH v11 25/40] virtio: allow to unbreak/break virtqueue
 individually
Message-ID: <20220701022950-mutt-send-email-mst@kernel.org>
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-26-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629065656.54420-26-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 29, 2022 at 02:56:41PM +0800, Xuan Zhuo wrote:
> This patch allows the new introduced
> __virtqueue_break()/__virtqueue_unbreak() to break/unbreak the
> virtqueue.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

I wonder how this interacts with the hardening patches.
Jason?

> ---
>  drivers/virtio/virtio_ring.c | 24 ++++++++++++++++++++++++
>  include/linux/virtio.h       |  3 +++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 5ec43607cc15..7b02be7fce67 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2744,6 +2744,30 @@ unsigned int virtqueue_get_vring_size(struct virtqueue *_vq)
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_get_vring_size);
>  
> +/*
> + * This function should only be called by the core, not directly by the driver.
> + */
> +void __virtqueue_break(struct virtqueue *_vq)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +	/* Pairs with READ_ONCE() in virtqueue_is_broken(). */
> +	WRITE_ONCE(vq->broken, true);
> +}
> +EXPORT_SYMBOL_GPL(__virtqueue_break);
> +
> +/*
> + * This function should only be called by the core, not directly by the driver.
> + */
> +void __virtqueue_unbreak(struct virtqueue *_vq)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +	/* Pairs with READ_ONCE() in virtqueue_is_broken(). */
> +	WRITE_ONCE(vq->broken, false);
> +}

I don't think these "Pairs" comments have any value.


> +EXPORT_SYMBOL_GPL(__virtqueue_unbreak);
> +
>  bool virtqueue_is_broken(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 1272566adec6..dc474a0d48d1 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -138,6 +138,9 @@ bool is_virtio_device(struct device *dev);
>  void virtio_break_device(struct virtio_device *dev);
>  void __virtio_unbreak_device(struct virtio_device *dev);
>  
> +void __virtqueue_break(struct virtqueue *_vq);
> +void __virtqueue_unbreak(struct virtqueue *_vq);
> +
>  void virtio_config_changed(struct virtio_device *dev);
>  #ifdef CONFIG_PM_SLEEP
>  int virtio_device_freeze(struct virtio_device *dev);
> -- 
> 2.31.0

