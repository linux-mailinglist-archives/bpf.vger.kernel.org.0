Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711245BBDB9
	for <lists+bpf@lfdr.de>; Sun, 18 Sep 2022 14:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiIRMRs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 18 Sep 2022 08:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiIRMRr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 18 Sep 2022 08:17:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84761D0E2
        for <bpf@vger.kernel.org>; Sun, 18 Sep 2022 05:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663503466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YIbilycgQyjenY282EZwIsPOR3PFZL895xpYAyq5afo=;
        b=cceqa2GsaVj0FTELW5Nuhk+n9LlJ4hvPyqls+8rs+nQhbDo/jiRicfZyUz2Z06BPfk7bEj
        zAM/f/LWLxtFRtnQdSy8ZT3zb0EtcADY70hivN0KBrBN+tM9sy8egjZEPncSf71JKPTRe5
        u08Mz88ledCsgARMoRVwzlxIhUJNkuA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-132-kW5mmBTPMiWC7wULLh17ow-1; Sun, 18 Sep 2022 08:17:42 -0400
X-MC-Unique: kW5mmBTPMiWC7wULLh17ow-1
Received: by mail-wr1-f69.google.com with SMTP id e18-20020adfa452000000b00228a420c389so5936798wra.16
        for <bpf@vger.kernel.org>; Sun, 18 Sep 2022 05:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=YIbilycgQyjenY282EZwIsPOR3PFZL895xpYAyq5afo=;
        b=OMHSgjXeIvUAjRzHo9m0AufJz9KMMdXTkIfvfRXIsDemXfGceM69vb6+R1BM1NNCYn
         SAF7J8BfJFuqGoadg2ePIvqEtYyKVxCJw2IT6Iwe/UnCRhEcfvI7MG967auWAGmo4RU6
         Ka+MLZFSTGGUmX8kr76KbvI/yF8ks2ZpSxdR6Vc0wbyt/p3bBDzewNmqT5OXw8rVN20H
         PjKG3I8zZFddPYX0TsCHC9wREyT0nIUnjiFV7c/sAb1LBo4rxQz2Oc91k8cBOVI0/eAt
         W9Jhxswj04WSpZiyEwATCShlBYYe0jLLMeWgMLe9bVKuVuS1GtrqizjJnm5rKHGtod4f
         m0pA==
X-Gm-Message-State: ACrzQf2dy6M9mj8llNqcpw7ic+HZy0SxIWzSITu0rHhG4ACEzF3e3NGF
        k8d6G4wvIPkkmNodgq62/9jPKYKKk2LMCMp1OG3d6zawvHIj6Z0rx7G95dynuUJ5R+2l+5KdVPb
        3zbA2DQ/pXe6p
X-Received: by 2002:a5d:4742:0:b0:22a:3a88:d9e6 with SMTP id o2-20020a5d4742000000b0022a3a88d9e6mr8183464wrs.438.1663503461618;
        Sun, 18 Sep 2022 05:17:41 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6OgKAiHsRIMsNcvcQlSELq9pAaD49wvj8xve/5Xz8Q2YgoqvtA0Jk9oZfbBvYoMf3nUdnFOQ==
X-Received: by 2002:a5d:4742:0:b0:22a:3a88:d9e6 with SMTP id o2-20020a5d4742000000b0022a3a88d9e6mr8183456wrs.438.1663503461375;
        Sun, 18 Sep 2022 05:17:41 -0700 (PDT)
Received: from redhat.com ([2.52.4.6])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c354700b003b4cba4ef71sm4421682wmq.41.2022.09.18.05.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 05:17:40 -0700 (PDT)
Date:   Sun, 18 Sep 2022 08:17:36 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Junbo <junbo4242@gmail.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] Do not name control queue for virtio-net
Message-ID: <20220918081713-mutt-send-email-mst@kernel.org>
References: <20220917092857.3752357-1-junbo4242@gmail.com>
 <20220918025033-mutt-send-email-mst@kernel.org>
 <CACvn-oGUj0mDxBO2yV1mwvz4PzhN3rDnVpUh12NA5jLKTqRT3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACvn-oGUj0mDxBO2yV1mwvz4PzhN3rDnVpUh12NA5jLKTqRT3A@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Sep 18, 2022 at 05:00:20PM +0800, Junbo wrote:
> hi Michael
> 
> in virtio-net.c
>     /* Parameters for control virtqueue, if any */
>     if (vi->has_cvq) {
>         callbacks[total_vqs - 1] = NULL;
>         names[total_vqs - 1] = "control";
>     }
> 
> I think the Author who write the code

wait, that was not you?

> maybe want to name the control queue to
> 'virtioX-control', but it never worked, we can see the name still be
> 'virtioX-config' in /proc/interrupts, for example 
>  43:          0          0          0          0          0          0        
>  0          0   PCI-MSI-edge      virtio0-config
>  44:         64          0          0          0          0          0      
> 1845          0   PCI-MSI-edge      virtio0-input.0
>  45:          1          0          0          0          0          0        
>  0          0   PCI-MSI-edge      virtio0-output.0
> 
> Because in function vp_request_msix_vectors, it just allocate 'xxxx-config' to
> every virtio devices, even the virtio device do not need it. in /proc/
> interrupts, we can see that each virtio device's first interrupt always named
> 'virtioX-config'.
> 
> So I think it's better to not explicitly give the "control" here, it's
> useless...  
> 
> 
> Michael S. Tsirkin <mst@redhat.com> 于2022年9月18日周日 14:56写道：
> 
>     On Sat, Sep 17, 2022 at 09:28:57AM +0000, junbo4242@gmail.com wrote:
>     > From: Junbo <junbo4242@gmail.com>
>     >
>     > In virtio drivers, the control queue always named <virtioX>-config.
>     >
>     > Signed-off-by: Junbo <junbo4242@gmail.com>
> 
>     I don't think that's right. config is the config interrupt.
> 
> 
> 
>     > ---
>     >  drivers/net/virtio_net.c | 3 ++-
>     >  1 file changed, 2 insertions(+), 1 deletion(-)
>     >
>     > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>     > index 9cce7dec7366..0b3e74cfe201 100644
>     > --- a/drivers/net/virtio_net.c
>     > +++ b/drivers/net/virtio_net.c
>     > @@ -3469,7 +3469,8 @@ static int virtnet_find_vqs(struct virtnet_info
>     *vi)
>     >       /* Parameters for control virtqueue, if any */
>     >       if (vi->has_cvq) {
>     >               callbacks[total_vqs - 1] = NULL;
>     > -             names[total_vqs - 1] = "control";
>     > +             /* control virtqueue always named <virtioX>-config */
>     > +             names[total_vqs - 1] = "";
>     >       }
>     > 
>     >       /* Allocate/initialize parameters for send/receive virtqueues */
>     > --
>     > 2.31.1
> 
> 

