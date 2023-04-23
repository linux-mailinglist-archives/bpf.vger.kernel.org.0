Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFDE86EC249
	for <lists+bpf@lfdr.de>; Sun, 23 Apr 2023 22:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjDWUnF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Apr 2023 16:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDWUnE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 Apr 2023 16:43:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8D710C9
        for <bpf@vger.kernel.org>; Sun, 23 Apr 2023 13:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682282536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7QcY3a3kH0+Rq9gUuMPOzuma/qnGDgBISD5Gp0wCqpU=;
        b=gb+HIoUeLIOBkEaAgTXw+1aqqmGvqynD/h0OChsbYhCORq2nt4fRWj8a7ixuvxsiimNykq
        9PWiS7J/NhRMjmylD8uwLpXV4Lv6q3NFsTNlur2/Y9Un60iz61CllVsnz/KAEQ2Pv55Z2i
        6SFiOkkFeGJcOVkLwDsgmyOKgzq6p0c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-m6iZX3ljO1q8H6n9pnz7AQ-1; Sun, 23 Apr 2023 16:42:14 -0400
X-MC-Unique: m6iZX3ljO1q8H6n9pnz7AQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-2ef39671038so1084031f8f.2
        for <bpf@vger.kernel.org>; Sun, 23 Apr 2023 13:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682282534; x=1684874534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QcY3a3kH0+Rq9gUuMPOzuma/qnGDgBISD5Gp0wCqpU=;
        b=TTFOhfn/m0p3jcAlWAlkzPZjKfbV2D1VwXKIKHVsj3+cOJvUZQbdIomC5Jpl3xMyWw
         K+gmfCmSleFBQ9V09Bw5jMQeUaR/JDyVKYWLTlXNxM4o0DORygxmvMh5zMulV/ta3rRh
         MDglCIcvamzZ/vj+hjQ24xNdn3w6xyCUFIIKmYyndR5Y5rPr9eEnf46Kt2coFLLQAz3c
         9M0sZaI/9x/my4/4jLn28elyEJXdarCRGM7/Y+vQLO3qsosai52NYdTT+3lDvE7KeC/I
         ifM1+cTA3SSJMNIa6WtEP2H3OkS9XhZgrfEGlSd0wllRNHOW+wDS2QWOsewW4iqPCBu4
         ETgA==
X-Gm-Message-State: AAQBX9dNKEW5zd4NvdxsGjB8TjYrnxeeekAVa7Iuj6L0Nnsw0KEgPd3c
        w3hpIVvT3AqQ8Nz2eP4eH7jYPR0L3mqCU2cimwJ7gxL7WUMFOGXS+36i6RTOadSGCm7Q8XuD4Yc
        HIEg9ud5bX17H
X-Received: by 2002:a5d:4e01:0:b0:304:6715:8728 with SMTP id p1-20020a5d4e01000000b0030467158728mr4236853wrt.18.1682282533889;
        Sun, 23 Apr 2023 13:42:13 -0700 (PDT)
X-Google-Smtp-Source: AKy350YdnKi+ZHb6STgweUlm/aZE45mVPCJXP21umah/V38ji93a8lhhwXhK5QKMqTIOSKpR49O6oQ==
X-Received: by 2002:a5d:4e01:0:b0:304:6715:8728 with SMTP id p1-20020a5d4e01000000b0030467158728mr4236836wrt.18.1682282533574;
        Sun, 23 Apr 2023 13:42:13 -0700 (PDT)
Received: from redhat.com ([2.55.17.255])
        by smtp.gmail.com with ESMTPSA id c1-20020a5d4f01000000b002fc0de07930sm9307913wru.13.2023.04.23.13.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 13:42:12 -0700 (PDT)
Date:   Sun, 23 Apr 2023 16:42:07 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH net-next v1] xsk: introduce xsk_dma_cbs
Message-ID: <20230423161828-mutt-send-email-mst@kernel.org>
References: <20230423062546.96880-1-xuanzhuo@linux.alibaba.com>
 <ZETUAMqKc8iLhTk3@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZETUAMqKc8iLhTk3@kroah.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Apr 23, 2023 at 08:45:20AM +0200, Greg KH wrote:
> On Sun, Apr 23, 2023 at 02:25:45PM +0800, Xuan Zhuo wrote:
> > The purpose of this patch is to allow driver pass the own dma callbacks
> > to xsk.
> > 
> > This is to cope with the scene of virtio-net. If virtio does not have
> > VIRTIO_F_ACCESS_PLATFORM, then virtio cannot use DMA API. In this case,
> > xsk cannot use DMA API directly to achieve DMA address. Based on this
> > scene, we must let xsk support driver to use the driver's dma callbacks.
> 
> Why does virtio need to use dma?  That seems to go against the overall
> goal of virtio's new security restrictions that are being proposed
> (where they do NOT want it to use dma as it is not secure).

Yes, they exactly use dma, specifically dma into bounce buffer.



