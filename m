Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BFF4D27F8
	for <lists+bpf@lfdr.de>; Wed,  9 Mar 2022 05:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiCIEtu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Mar 2022 23:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiCIEtr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Mar 2022 23:49:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D3D5F155C03
        for <bpf@vger.kernel.org>; Tue,  8 Mar 2022 20:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646801328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7yW1kWq855MoycbxENZXn/INYb5Qcrtgiwr9xtyGJCE=;
        b=BqcZKHSgPtV7wWEAkPYeiBzssX0Az1kSsBGdDEKxPjUvA7V2z5hV1mkVlg0JxvlQnA8Y/0
        VxeVA6q+OC04lUufrR7TOzDd2br5jEc5uQFn3UPUaVLmPXn/5kFttwlcy4EvpivAPdlxTm
        heJyLu3qEqXVlYqzbPVjgnG3RREYeG8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-286-4v4JFVu4OqGs7QL3YfeDVw-1; Tue, 08 Mar 2022 23:48:46 -0500
X-MC-Unique: 4v4JFVu4OqGs7QL3YfeDVw-1
Received: by mail-pj1-f69.google.com with SMTP id s20-20020a17090ad49400b001bf481fae01so2176675pju.1
        for <bpf@vger.kernel.org>; Tue, 08 Mar 2022 20:48:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7yW1kWq855MoycbxENZXn/INYb5Qcrtgiwr9xtyGJCE=;
        b=lgXXpZF6eUjs3KMz6OPuoVZ2VuPbCfm2lTsWP3y624AJKemzC01vPNXF8dVKnw7OGM
         5VO/cDJMoXO+Ciw0kFZjRRbEL8DNWkGq7eSLpFi6zfZwK+m1pJObR4l3vcwQYqrVfCHL
         tng0oQw+9egfaPjTrWrZpRSPVyFLPjh5To6K1JeSHmH5Lt6+DHhoGmvboXnx8ykq8vIF
         ylbo0ZBJVbB3KXy3Da095s8tEciHVah99dkGqY5loEsH0RP5dVMPRiTijdSpjy4v5gwy
         dIzCt+jvdO1RB+scYdnW7sB9woxqCjTi1sROOSn3hxQbUmS1IZwstEXhIlDegJz3utnw
         87nA==
X-Gm-Message-State: AOAM533Wik1GmMn9gG7ZMWgKfFIJkwQOXtQdyxgnpVLl5Pq/xIlNMbc0
        L/mIAtMPM4hHBXEoJHenN5iVF42J46OaUIRYXfAHcLzySxe2kBU4N7sLXXBBvr53tQUzHqRz3Tn
        Rg8AujD1NpGTI
X-Received: by 2002:a17:90b:17ca:b0:1bf:6188:cc00 with SMTP id me10-20020a17090b17ca00b001bf6188cc00mr8597553pjb.2.1646801325723;
        Tue, 08 Mar 2022 20:48:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwosqJUOOIblsYGQ27dg95V2/uz330dPMJom2dl9RgGa8k3TOiXYiGNo7Wasa+ovCrQzyH4wQ==
X-Received: by 2002:a17:90b:17ca:b0:1bf:6188:cc00 with SMTP id me10-20020a17090b17ca00b001bf6188cc00mr8597538pjb.2.1646801325443;
        Tue, 08 Mar 2022 20:48:45 -0800 (PST)
Received: from [10.72.13.251] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g15-20020a056a0023cf00b004e17e11cb17sm821341pfc.111.2022.03.08.20.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 20:48:44 -0800 (PST)
Message-ID: <373494ae-825b-d573-012c-4e7d453934da@redhat.com>
Date:   Wed, 9 Mar 2022 12:48:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v7 01/26] virtio_pci: struct virtio_pci_common_cfg add
 queue_notify_data
Content-Language: en-US
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
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
        linux-um@lists.infradead.org, platform-driver-x86@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, bpf@vger.kernel.org
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-2-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220308123518.33800-2-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


在 2022/3/8 下午8:34, Xuan Zhuo 写道:
> Add queue_notify_data in struct virtio_pci_common_cfg, which comes from
> here https://github.com/oasis-tcs/virtio-spec/issues/89
>
> For not breaks uABI, add a new struct virtio_pci_common_cfg_notify.
>
> Since I want to add queue_reset after queue_notify_data, I submitted
> this patch first.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   include/uapi/linux/virtio_pci.h | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
> index 3a86f36d7e3d..22bec9bd0dfc 100644
> --- a/include/uapi/linux/virtio_pci.h
> +++ b/include/uapi/linux/virtio_pci.h
> @@ -166,6 +166,13 @@ struct virtio_pci_common_cfg {
>   	__le32 queue_used_hi;		/* read-write */
>   };
>   
> +struct virtio_pci_common_cfg_notify {
> +	struct virtio_pci_common_cfg cfg;
> +
> +	__le16 queue_notify_data;	/* read-write */
> +	__le16 padding;
> +};
> +
>   /* Fields in VIRTIO_PCI_CAP_PCI_CFG: */
>   struct virtio_pci_cfg_cap {
>   	struct virtio_pci_cap cap;

