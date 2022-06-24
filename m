Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060415593DC
	for <lists+bpf@lfdr.de>; Fri, 24 Jun 2022 09:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiFXG7z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jun 2022 02:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiFXG7y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jun 2022 02:59:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD88D69246
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 23:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656053992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+FWCkGupGlsZhDvUF+chx88Z13TTRnc4OkTdsQ7elnE=;
        b=i9nOA8tidr8vr+EgGLUER/bvbW4tIdNQxluM98Es2W3gAXa4Pf94kxFnFgK7j50tJU6rk7
        X7LuJDBSH2RkKDhCqE4SX1k7Khxm3+jDLIJLeatiqoSvDjaavUlgChSJc9Pexr/r/sgHtS
        VMsSA8hdrDXCzCTB7vB8d0No4TR2gLM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-eqFmHC8MPTqaRCpGC492MQ-1; Fri, 24 Jun 2022 02:59:49 -0400
X-MC-Unique: eqFmHC8MPTqaRCpGC492MQ-1
Received: by mail-ej1-f69.google.com with SMTP id hp8-20020a1709073e0800b0072629757566so497711ejc.0
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 23:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+FWCkGupGlsZhDvUF+chx88Z13TTRnc4OkTdsQ7elnE=;
        b=j4DqeWhFry7vwmn280cgrLybg0hPYwiYUbUI9ryp4P4H10BZabVsTjcWNd0lIG/iC3
         lMacVjGt/CdcTtLcLSbHlrkGiKA+8kd+0U5FJO3DSQbwPSQjm+92L74+UpfMETIlKDVq
         0+cDagfD4pVEZQ4o5xDp8TL69h51ifzKuNPghcrkSDoELOSF/c6OacjfJgDnopYcX1jH
         v752wD1zHFfTjHyYNh+hswFut3+X5nAc54ecwMeVTwA8TBO396YN9XgdUE5sUSl7xVY1
         GNW3Sa0Gm1zzccUrkDHjHsFXKKh4ZPheiGzO70ttGJBmAk4oYEn4mEuM4DdaQs2bn4+1
         DJSg==
X-Gm-Message-State: AJIora/GeGwTT7Ld2q+9l5oID3Wzzpfe2s62Sjygo8m7vVUaQJ5j9ag6
        d7Sz10rrZkfQPAjJQ0K3JXAfo/GJxS5aoDPkpSPPjga6FH8c+q5OaS+XVan03+tdV787SgBInQ4
        bWk+1S+YUHvur
X-Received: by 2002:a17:906:dc8f:b0:725:28d1:422d with SMTP id cs15-20020a170906dc8f00b0072528d1422dmr6755849ejc.131.1656053987931;
        Thu, 23 Jun 2022 23:59:47 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1te/UstSdzxfRYfD6/tSqZXRF+jwCBe0/TwLXdOIJy4AlZcp3dqgfDv8QmtvsXyUBUV1p/nQw==
X-Received: by 2002:a17:906:dc8f:b0:725:28d1:422d with SMTP id cs15-20020a170906dc8f00b0072528d1422dmr6755835ejc.131.1656053987674;
        Thu, 23 Jun 2022 23:59:47 -0700 (PDT)
Received: from redhat.com ([2.55.188.216])
        by smtp.gmail.com with ESMTPSA id ec35-20020a0564020d6300b004316f94ec4esm1262273edb.66.2022.06.23.23.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 23:59:46 -0700 (PDT)
Date:   Fri, 24 Jun 2022 02:59:39 -0400
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
Subject: Re: [PATCH v10 25/41] virtio_pci: struct virtio_pci_common_cfg add
 queue_notify_data
Message-ID: <20220624025817-mutt-send-email-mst@kernel.org>
References: <20220624025621.128843-1-xuanzhuo@linux.alibaba.com>
 <20220624025621.128843-26-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624025621.128843-26-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 24, 2022 at 10:56:05AM +0800, Xuan Zhuo wrote:
> Add queue_notify_data in struct virtio_pci_common_cfg, which comes from
> here https://github.com/oasis-tcs/virtio-spec/issues/89
> 
> For not breaks uABI, add a new struct virtio_pci_common_cfg_notify.

What exactly is meant by not breaking uABI?
Users are supposed to be prepared for struct size to change ... no?


> Since I want to add queue_reset after queue_notify_data, I submitted
> this patch first.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
>  include/uapi/linux/virtio_pci.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
> index 3a86f36d7e3d..22bec9bd0dfc 100644
> --- a/include/uapi/linux/virtio_pci.h
> +++ b/include/uapi/linux/virtio_pci.h
> @@ -166,6 +166,13 @@ struct virtio_pci_common_cfg {
>  	__le32 queue_used_hi;		/* read-write */
>  };
>  
> +struct virtio_pci_common_cfg_notify {
> +	struct virtio_pci_common_cfg cfg;
> +
> +	__le16 queue_notify_data;	/* read-write */
> +	__le16 padding;
> +};
> +
>  /* Fields in VIRTIO_PCI_CAP_PCI_CFG: */
>  struct virtio_pci_cfg_cap {
>  	struct virtio_pci_cap cap;
> -- 
> 2.31.0

