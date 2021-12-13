Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F4C4721EC
	for <lists+bpf@lfdr.de>; Mon, 13 Dec 2021 08:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbhLMHtJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Dec 2021 02:49:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47255 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232561AbhLMHtI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Dec 2021 02:49:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639381748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ajmFbDRx9BLe176bpdQggywBMmHI+LQFi36+JDBB49U=;
        b=GubAAYSVly5HxpYNqmXDo1MSbZoNzceDDzp1yzTU4/gk1qsRtm74RZ3zHpsoWlh08nKhBj
        szWKC0zqSIbNmN5g+ZJzIKjlUpS5IHsXl1B6vwcZsgkspQ+tpQMXpNZ6zX2osKGKNoxVjl
        4C0uB1bJ4TMX5RQi4CmuoV9I2d/qtJU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-363-AYXe-eiGMruVifY8Mq_AoA-1; Mon, 13 Dec 2021 02:49:06 -0500
X-MC-Unique: AYXe-eiGMruVifY8Mq_AoA-1
Received: by mail-lf1-f69.google.com with SMTP id w11-20020a05651234cb00b0041f93ca5812so5175533lfr.21
        for <bpf@vger.kernel.org>; Sun, 12 Dec 2021 23:49:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ajmFbDRx9BLe176bpdQggywBMmHI+LQFi36+JDBB49U=;
        b=lrZt3118VdHFq1UR1F5te+TJH6O49xvO6tnmq2fHC7WE7jbmORYdSc3Rri54cU9tAV
         RUEl2VaQ2lWqfL7/0bqirZmnho1jPeLyV/0JaT+UszLwFMkJOOc5Rgz0b++upU4n+OIe
         xcGFxSaXUMLCMdDFgADEKp0I0wluVV65loKMN6y+dCGpMggNQEln2Q42YXagapb12Gs2
         p7GNmgGE1HMMZxNm1nOstCF1VBCFvjkqShKTFhkWsDgHUcJVTxTgO/SbwuTITl0TMH+Y
         +PyC0Uq5TgjiAyRa2NKm2UN0onSlzhxScRQ/DGaUUbFIbg04RUtBJNeh8W39JwNubsMO
         puBw==
X-Gm-Message-State: AOAM530VWDTCe+5c1AYQshGybuH5UeQ9FLOx9LQiw7V1JmfBTAv1eMd3
        DNvzyNQTACEWG85NxjUsvJ/yu0Z+sEXhTFzSkKGJjlpjahgq9HnKspMwPJVSwW5X440QE3OHk+C
        I8YXRlBp42EQ8cR1pIY5fqfh0vAme
X-Received: by 2002:a2e:b88d:: with SMTP id r13mr28041727ljp.362.1639381745319;
        Sun, 12 Dec 2021 23:49:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy6Kho2IY5dIkx4dw7D65wn0As3tEagQCBwgaJDxLSQvZQN2qrKmtB5zWAMksvRMGbAAVFtrQQetSAmODA5C8k=
X-Received: by 2002:a2e:b88d:: with SMTP id r13mr28041706ljp.362.1639381745081;
 Sun, 12 Dec 2021 23:49:05 -0800 (PST)
MIME-Version: 1.0
References: <20211213045012.12757-1-mengensun@tencent.com>
In-Reply-To: <20211213045012.12757-1-mengensun@tencent.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 13 Dec 2021 15:48:53 +0800
Message-ID: <CACGkMEtLso8QjvmjTQ=S_bbGxu11O_scRa8GT7z6MXfJbfzfRg@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: make copy len check in xdp_linearize_page
To:     mengensun8801@gmail.com
Cc:     davem <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
        mengensun <mengensun@tencent.com>,
        MengLong Dong <imagedong@tencent.com>,
        ZhengXiong Jiang <mungerjiang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 13, 2021 at 12:50 PM <mengensun8801@gmail.com> wrote:
>
> From: mengensun <mengensun@tencent.com>
>
> xdp_linearize_page asume ring elem size is smaller then page size
> when copy the first ring elem, but, there may be a elem size bigger
> then page size.
>
> add_recvbuf_mergeable may add a hole to ring elem, the hole size is
> not sure, according EWMA.

The logic is to try to avoid dropping packets in this case, so I
wonder if it's better to "fix" the add_recvbuf_mergeable().

Or another idea is to switch to use XDP generic here where we can use
skb_linearize() which should be more robust and we can drop the
xdp_linearize_page() logic completely.

Thanks

>
> so, fix it by check copy len,if checked failed, just dropped the
> whole frame, not make the memory dirty after the page.
>
> Signed-off-by: mengensun <mengensun@tencent.com>
> Reviewed-by: MengLong Dong <imagedong@tencent.com>
> Reviewed-by: ZhengXiong Jiang <mungerjiang@tencent.com>
> ---
>  drivers/net/virtio_net.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 36a4b7c195d5..844bdbd67ff7 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -662,8 +662,12 @@ static struct page *xdp_linearize_page(struct receive_queue *rq,
>                                        int page_off,
>                                        unsigned int *len)
>  {
> -       struct page *page = alloc_page(GFP_ATOMIC);
> +       struct page *page;
>
> +       if (*len > PAGE_SIZE - page_off)
> +               return NULL;
> +
> +       page = alloc_page(GFP_ATOMIC);
>         if (!page)
>                 return NULL;
>
> --
> 2.27.0
>

