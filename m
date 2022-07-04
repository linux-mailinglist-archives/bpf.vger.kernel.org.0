Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEAF564C2B
	for <lists+bpf@lfdr.de>; Mon,  4 Jul 2022 05:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbiGDDrr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Jul 2022 23:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiGDDrq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Jul 2022 23:47:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09D8B62E7
        for <bpf@vger.kernel.org>; Sun,  3 Jul 2022 20:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656906464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L2gDTuBKuZK9BdBvTV1z4CFK8vS6yKvfUsO3/KE/ibo=;
        b=PBE4QMNNI0M/8LlN62bMqbOEl7LajpLJLO5Ur/m6yb1qveGNYnptNc5rTBuAUBQ3q3ILEw
        p0pK7yA797kZ1EpBBjfInICTDMDD1aZvhGvJ0ify/D92YIBbdmUF6v4ap3FgPXVkhlyu+u
        w+6UzeQxE3L8927Dlo2eXXiBbfGH4CU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-310-ZTbMmEYnOsSKCzfmQr-uPA-1; Sun, 03 Jul 2022 23:47:43 -0400
X-MC-Unique: ZTbMmEYnOsSKCzfmQr-uPA-1
Received: by mail-pl1-f200.google.com with SMTP id h18-20020a170902f55200b0016a4a78bd71so4420635plf.9
        for <bpf@vger.kernel.org>; Sun, 03 Jul 2022 20:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=L2gDTuBKuZK9BdBvTV1z4CFK8vS6yKvfUsO3/KE/ibo=;
        b=ud7awTnWx1QmdAF/940sl7M4xnmhyiSbB7PHPPFdLB/kPBp6IG5HRn72kKScxfyBPt
         LcxhLkPAXnnpUfMOFGxvCuhMdz2C8wkASYYVfggT+r+YI7eufBq2OsJ925eSrij0UCKe
         3r4Evhza1ZrUCNeOxJwKuO7Elb3EXKz2t59hLj43cIOoBTOgibaRNvwZe2L+2DZWzJD5
         DQjUqWVDSuYQGkI2RdaXBh97IuSfBe5Gjv3kd+4doxH1kZmsk3bPrEJQAdrEkDQeEgAN
         IOsaBWV6LrLNW2qiG91Bb3JZXPJ793NbAJUn3ka2R60M7FB8jCmbO/szwzxiE8bL+9vU
         Aisg==
X-Gm-Message-State: AJIora/SaKJwxMOeq5qglonZbt9fzbqyag/paxdpdRGUgg2EstIVsHCU
        VBFbV6zCGDetfMzDEEaRccCg3txKyx+nugWJjj7SnFpoYb4m/GmAWEE1CSUR+ECg6GXo2xR4jaX
        wITvaT1iZ8PSC
X-Received: by 2002:a17:902:8b87:b0:169:5e5:43de with SMTP id ay7-20020a1709028b8700b0016905e543demr33751365plb.8.1656906461961;
        Sun, 03 Jul 2022 20:47:41 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1urar+tEFxn2OYR0nSzN1qR/6pFNL30ksJWbHZrPH1ZYknebpnFXj10hmhcTKfVqx002oRx8A==
X-Received: by 2002:a17:902:8b87:b0:169:5e5:43de with SMTP id ay7-20020a1709028b8700b0016905e543demr33751314plb.8.1656906461703;
        Sun, 03 Jul 2022 20:47:41 -0700 (PDT)
Received: from [10.72.13.251] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e11-20020a17090a7c4b00b001eee8998f2esm8701227pjl.17.2022.07.03.20.47.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jul 2022 20:47:41 -0700 (PDT)
Message-ID: <2fdff856-cddf-1235-8078-312de94600c7@redhat.com>
Date:   Mon, 4 Jul 2022 11:47:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v11 25/40] virtio: allow to unbreak/break virtqueue
 individually
Content-Language: en-US
From:   Jason Wang <jasowang@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     virtualization@lists.linux-foundation.org,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
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
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-26-xuanzhuo@linux.alibaba.com>
 <20220701022950-mutt-send-email-mst@kernel.org>
 <79e519ec-0129-6a21-11da-44eaff1429fa@redhat.com>
In-Reply-To: <79e519ec-0129-6a21-11da-44eaff1429fa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


在 2022/7/1 17:36, Jason Wang 写道:
>
> 在 2022/7/1 14:31, Michael S. Tsirkin 写道:
>> On Wed, Jun 29, 2022 at 02:56:41PM +0800, Xuan Zhuo wrote:
>>> This patch allows the new introduced
>>> __virtqueue_break()/__virtqueue_unbreak() to break/unbreak the
>>> virtqueue.
>>>
>>> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> I wonder how this interacts with the hardening patches.
>> Jason?
>
>
> Consider we've marked it as broken, I think we don't need to care 
> about the hardening in this series. Just make it work without hardening.
>
> And I will handle vq reset when rework the IRQ hardening.
>
> Thanks


Rethink of this, I think Xuan's code should be fine. We know we will 
have another rework.

Thanks


>
>
>>
>>> ---
>>>   drivers/virtio/virtio_ring.c | 24 ++++++++++++++++++++++++
>>>   include/linux/virtio.h       |  3 +++
>>>   2 files changed, 27 insertions(+)
>>>
>>> diff --git a/drivers/virtio/virtio_ring.c 
>>> b/drivers/virtio/virtio_ring.c
>>> index 5ec43607cc15..7b02be7fce67 100644
>>> --- a/drivers/virtio/virtio_ring.c
>>> +++ b/drivers/virtio/virtio_ring.c
>>> @@ -2744,6 +2744,30 @@ unsigned int virtqueue_get_vring_size(struct 
>>> virtqueue *_vq)
>>>   }
>>>   EXPORT_SYMBOL_GPL(virtqueue_get_vring_size);
>>>   +/*
>>> + * This function should only be called by the core, not directly by 
>>> the driver.
>>> + */
>>> +void __virtqueue_break(struct virtqueue *_vq)
>>> +{
>>> +    struct vring_virtqueue *vq = to_vvq(_vq);
>>> +
>>> +    /* Pairs with READ_ONCE() in virtqueue_is_broken(). */
>>> +    WRITE_ONCE(vq->broken, true);
>>> +}
>>> +EXPORT_SYMBOL_GPL(__virtqueue_break);
>>> +
>>> +/*
>>> + * This function should only be called by the core, not directly by 
>>> the driver.
>>> + */
>>> +void __virtqueue_unbreak(struct virtqueue *_vq)
>>> +{
>>> +    struct vring_virtqueue *vq = to_vvq(_vq);
>>> +
>>> +    /* Pairs with READ_ONCE() in virtqueue_is_broken(). */
>>> +    WRITE_ONCE(vq->broken, false);
>>> +}
>> I don't think these "Pairs" comments have any value.
>>
>>
>>> +EXPORT_SYMBOL_GPL(__virtqueue_unbreak);
>>> +
>>>   bool virtqueue_is_broken(struct virtqueue *_vq)
>>>   {
>>>       struct vring_virtqueue *vq = to_vvq(_vq);
>>> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
>>> index 1272566adec6..dc474a0d48d1 100644
>>> --- a/include/linux/virtio.h
>>> +++ b/include/linux/virtio.h
>>> @@ -138,6 +138,9 @@ bool is_virtio_device(struct device *dev);
>>>   void virtio_break_device(struct virtio_device *dev);
>>>   void __virtio_unbreak_device(struct virtio_device *dev);
>>>   +void __virtqueue_break(struct virtqueue *_vq);
>>> +void __virtqueue_unbreak(struct virtqueue *_vq);
>>> +
>>>   void virtio_config_changed(struct virtio_device *dev);
>>>   #ifdef CONFIG_PM_SLEEP
>>>   int virtio_device_freeze(struct virtio_device *dev);
>>> -- 
>>> 2.31.0

