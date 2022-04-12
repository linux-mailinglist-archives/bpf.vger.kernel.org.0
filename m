Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55804FD5EE
	for <lists+bpf@lfdr.de>; Tue, 12 Apr 2022 12:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358489AbiDLIbE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Apr 2022 04:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354250AbiDLHRT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Apr 2022 03:17:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4AB5A4B872
        for <bpf@vger.kernel.org>; Mon, 11 Apr 2022 23:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649746715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4c8Vusl4oEKcTcKekpVxwLN012dQSzoK0Qxc5GtiyU0=;
        b=VpOEWOiAcr//CaE4NvwZO1Qp+5CbYzV+VPa/a8Cn664ID/FR83LnTmXmvQp9hfbK5m428b
        b3au5f1DUKD+5x65isneLC05KloKEMGAzhAtmRIDJfJ+udwB9sZq8NB30+3zxBrR3RHvm7
        ypNKpMfRxXwiUy4WgtUWnlx6w4ruziI=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-157-bu6-UZLaOciAzIPfYjvNFw-1; Tue, 12 Apr 2022 02:58:33 -0400
X-MC-Unique: bu6-UZLaOciAzIPfYjvNFw-1
Received: by mail-pf1-f197.google.com with SMTP id i2-20020a056a00224200b004fa60c248a1so10985871pfu.13
        for <bpf@vger.kernel.org>; Mon, 11 Apr 2022 23:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4c8Vusl4oEKcTcKekpVxwLN012dQSzoK0Qxc5GtiyU0=;
        b=6pHvq0R0e0WCR1F5PkU7DtappKbiLb5UNyVjPZqfIBn166V9kb8BYSFmlOpC0U6i60
         1OBpJlwhJFMnggM+xfAzEV9slmi4RYybgutIk2mz4mJpRV6PArr0C9lvUsdQ10kb9Q0h
         ziVNPq0RvORqoi4bRKP+udkBZgqm4yXX3d/Vi7R26N+1oPqbqs1r2akOK9VlTtsJWOE2
         E+Aljw83ViYgDNbzrHWTRzVXmzItOwSHumjV0j9PRn3ScVUlYjE+7cQTGWoseK5CZtBP
         v2gBo7yFzNGbapNxVy+XFTcTwI/odO50g/Ulc6GMuyQUv7ijIxpVSJdCG2hawIk71xhM
         AhzA==
X-Gm-Message-State: AOAM530oX2niZT3uirm0ZhKK5NJ89VTuZITVQD8y0jh9BuI79DCVf6h0
        u/WJ5cD0h2TjYQtbOLHpPsO4fERzhh5oNFVADMQ27zx9mmxKD/JgsywfsWo43sgq3ktRyuhu4z6
        zRLz8RXCGTroL
X-Received: by 2002:a17:902:ce0a:b0:156:72e2:f191 with SMTP id k10-20020a170902ce0a00b0015672e2f191mr35096112plg.76.1649746712093;
        Mon, 11 Apr 2022 23:58:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxuJbdOoWZZRPEbzGsC4VuDhXJvgnJjxW0TEadVGxwoEvQb6fSAp5kYQnQ/9zpsf7VqHx4Bsg==
X-Received: by 2002:a17:902:ce0a:b0:156:72e2:f191 with SMTP id k10-20020a170902ce0a00b0015672e2f191mr35096092plg.76.1649746711844;
        Mon, 11 Apr 2022 23:58:31 -0700 (PDT)
Received: from [10.72.14.5] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b25-20020a637159000000b00381fda49d15sm1765570pgn.39.2022.04.11.23.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 23:58:31 -0700 (PDT)
Message-ID: <d228a41f-a3a1-029d-f259-d4fbab822e78@redhat.com>
Date:   Tue, 12 Apr 2022 14:58:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v9 22/32] virtio_pci: queue_reset: extract the logic of
 active vq for modern pci
Content-Language: en-US
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-um@lists.infradead.org, netdev@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, bpf@vger.kernel.org
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-23-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-23-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


在 2022/4/6 上午11:43, Xuan Zhuo 写道:
> Introduce vp_active_vq() to configure vring to backend after vq attach
> vring. And configure vq vector if necessary.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>   drivers/virtio/virtio_pci_modern.c | 46 ++++++++++++++++++------------
>   1 file changed, 28 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 86d301f272b8..49a4493732cf 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -176,6 +176,29 @@ static void vp_reset(struct virtio_device *vdev)
>   	vp_disable_cbs(vdev);
>   }
>   
> +static int vp_active_vq(struct virtqueue *vq, u16 msix_vec)
> +{
> +	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
> +	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
> +	unsigned long index;
> +
> +	index = vq->index;
> +
> +	/* activate the queue */
> +	vp_modern_set_queue_size(mdev, index, virtqueue_get_vring_size(vq));
> +	vp_modern_queue_address(mdev, index, virtqueue_get_desc_addr(vq),
> +				virtqueue_get_avail_addr(vq),
> +				virtqueue_get_used_addr(vq));
> +
> +	if (msix_vec != VIRTIO_MSI_NO_VECTOR) {
> +		msix_vec = vp_modern_queue_vector(mdev, index, msix_vec);
> +		if (msix_vec == VIRTIO_MSI_NO_VECTOR)
> +			return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +
>   static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
>   {
>   	return vp_modern_config_vector(&vp_dev->mdev, vector);
> @@ -220,32 +243,19 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>   
>   	vq->num_max = num;
>   
> -	/* activate the queue */
> -	vp_modern_set_queue_size(mdev, index, virtqueue_get_vring_size(vq));
> -	vp_modern_queue_address(mdev, index, virtqueue_get_desc_addr(vq),
> -				virtqueue_get_avail_addr(vq),
> -				virtqueue_get_used_addr(vq));
> +	err = vp_active_vq(vq, msix_vec);
> +	if (err)
> +		goto err;
>   
>   	vq->priv = (void __force *)vp_modern_map_vq_notify(mdev, index, NULL);
>   	if (!vq->priv) {
>   		err = -ENOMEM;
> -		goto err_map_notify;
> -	}
> -
> -	if (msix_vec != VIRTIO_MSI_NO_VECTOR) {
> -		msix_vec = vp_modern_queue_vector(mdev, index, msix_vec);
> -		if (msix_vec == VIRTIO_MSI_NO_VECTOR) {
> -			err = -EBUSY;
> -			goto err_assign_vector;
> -		}
> +		goto err;
>   	}
>   
>   	return vq;
>   
> -err_assign_vector:
> -	if (!mdev->notify_base)
> -		pci_iounmap(mdev->pci_dev, (void __iomem __force *)vq->priv);


We need keep this or anything I missed?

Thanks


> -err_map_notify:
> +err:
>   	vring_del_virtqueue(vq);
>   	return ERR_PTR(err);
>   }

