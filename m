Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80E46E5633
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 03:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjDRBIh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 21:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjDRBIf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 21:08:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053514215
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 18:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681780065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FJ5eAv/wPSjHQtCSmc7/SAtq7IJeARTquIRQEcE2Hzo=;
        b=JdlXFOToBfSwVClOgXYQ0hK0+6Retzpst49HLnLk7UWbDtY0Kh3B8YtcpGQGPVn7cDmMK/
        b9/COHk5/v5q8+lW7y4fBVugOEkUsuRrdeVKfiESoGozd84C1LDbmULS4edrjalgbFsRgG
        OYMxarAUMfFlXB0Bs1J7lN+YoAI18Ys=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-w05bmpRgNSOmmjy5UmyZaA-1; Mon, 17 Apr 2023 21:07:43 -0400
X-MC-Unique: w05bmpRgNSOmmjy5UmyZaA-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-38e1091707eso70357b6e.3
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 18:07:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681780062; x=1684372062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJ5eAv/wPSjHQtCSmc7/SAtq7IJeARTquIRQEcE2Hzo=;
        b=Ivs89hhwmnL//J1SK464MsTgDk4NZ7d+Lui4FpO2r564uUFR3AyuTCfqdqzYL3yZgK
         y+KVECLhdgGYZcy2lBaM07T1zR47dN4A288llCbW8Mh0fMQPL8Nb42+kB3z/aly+hxcY
         ldB4DjHJoUXMOIn6rZAeJW8qzlfB8MZjPnorsH+keeDM99pezJUsYHcmZ+wDOrSF2M9C
         E6s1HohOZIFsgFbUdsMjeLkoObJRTHvqRkpipX7mbQkab+oj5iUy9rnOaSsclmJ4Xqa5
         9p+6veIyImPtq6OtFgOwUFo0DtQx071Mq5Ihf1H35sFXx/iunT6FV/shiR+il751+kyi
         MZBQ==
X-Gm-Message-State: AAQBX9ctLJW/+mVKGjLAxEOZAwfkdM8E5EQMw5AXm5exYPdy9Or/s6mn
        5UWvg+mvdfg3ljqDBZ5LA3erlClEvrTklarcO749pPuSh2EoQIz4MX9VjaXoEOSPCZkMIbNWY3A
        QsmN2lzIIK+9DgC0Vo3UAYXcg0aE5
X-Received: by 2002:aca:a90f:0:b0:38c:2e50:7ba1 with SMTP id s15-20020acaa90f000000b0038c2e507ba1mr70557oie.9.1681780062174;
        Mon, 17 Apr 2023 18:07:42 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZqCb2yI8XjPtu0T702ZUJh3g15tnGze7/cYh3km5B2h6oWo65vgswsQUHg5Pv5UfUHzBzjLVKg/U5tifRvxHw=
X-Received: by 2002:aca:a90f:0:b0:38c:2e50:7ba1 with SMTP id
 s15-20020acaa90f000000b0038c2e507ba1mr70553oie.9.1681780061908; Mon, 17 Apr
 2023 18:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230417032750.7086-1-xuanzhuo@linux.alibaba.com>
 <ZDzKAD2SNe1q/XA6@infradead.org> <1681711081.378984-2-xuanzhuo@linux.alibaba.com>
 <20230417115610.7763a87c@kernel.org> <20230417115753.7fb64b68@kernel.org>
In-Reply-To: <20230417115753.7fb64b68@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 18 Apr 2023 09:07:30 +0800
Message-ID: <CACGkMEtPNPXFThHt4aNm4g-fC1DqTLcDnB_iBWb9-cAOHMYV_A@mail.gmail.com>
Subject: Re: [PATCH net-next] xsk: introduce xsk_dma_ops
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 18, 2023 at 2:58=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 17 Apr 2023 11:56:10 -0700 Jakub Kicinski wrote:
> > > May misunderstand, here the "dma_ops" is not the "dma_ops" of DMA API=
.
> > >
> > > I mean the callbacks for xsk to do dma.
> > >
> > > Maybe, I should rename it in the next version.
> >
> > Would you mind explaining this a bit more to folks like me who are not
> > familiar with VirtIO?  DMA API is supposed to hide the DMA mapping
> > details from the stack, why is it not sufficient here.

The reason is that legacy virtio device don't use DMA(vring_use_dma_api()).

The AF_XDP assumes DMA for netdev doesn't work in this case. We need a
way to make it work.

Thanks

>
> Umm.. also it'd help to post the user of the API in the same series.
> I only see the XSK changes, maybe if the virtio changes were in
> the same series I could answer my own question.
>

