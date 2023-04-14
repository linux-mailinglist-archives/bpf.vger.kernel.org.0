Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAA16E1BD4
	for <lists+bpf@lfdr.de>; Fri, 14 Apr 2023 07:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjDNFle (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Apr 2023 01:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjDNFld (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Apr 2023 01:41:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F982729
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 22:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681450846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=36R8yA5JwrX0XhwM8RvPweATRjX3s/5NTOfHCOBnG08=;
        b=Sa9ASbmqxeZxN2EeL5aNaZpzsFwPWhGFHvSpfbxDYtdkvMRyd4K6vncGzwSzJOiStiR9r7
        CPPm9AG+q+2slu3OzPwKuW93bwqmP1I7/kXp/SLrWDfCzQcB6TPCibhVwRapm0nsJGKwKc
        rjRuD1ZMCvQvJGNsiEB7TjP5JRXejvI=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-flBzpVt_OHm-bNaYBOBhVQ-1; Fri, 14 Apr 2023 01:40:44 -0400
X-MC-Unique: flBzpVt_OHm-bNaYBOBhVQ-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1842c947865so9176998fac.0
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 22:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681450844; x=1684042844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36R8yA5JwrX0XhwM8RvPweATRjX3s/5NTOfHCOBnG08=;
        b=OgtvwgltZq0XNI81nFXLNKyriBGQs84rIKGaXBatgBt3HlMxnBbABHP+AjASx1gBCf
         tEEwn26N/cif/XS4FA/fOxS57NgQ6y2TGHN1poPBYpK9BuPkAfU3dT088R0cM+3uHQkJ
         8/joY+UJ4uPK8IK0tSAjsEzYC4+RFuc/juSlWzNPA2HHncErJRC9JUvFWYH+rtkctrGM
         qY8Qy5LbZNMrh3+aVi9GuqZHi8aSOFouuH6GGDIzXoJQ5fn9YDTF6u2xadbWmSSEl17U
         bxe1NWbrOSmvomCHrz8yvyEF4ofuHzHVoZNb7Og2hrVpVfCjM4lcBJU2zGPGEIqu+dzJ
         6LHw==
X-Gm-Message-State: AAQBX9dH7pPanVvomkY6A/4xzcNDcmDquwvnVr4s9lUQUjjdY0LAmjMM
        bW8N+yLuQLLus4oLvhGvAUFacVI+8URxmfQLeWsa67S62U/MCF58Zz+Jv9TGbI4WyUDr2TKZHm9
        P+cbTZ+E3gyv9DWjWL233kxy/6WCB
X-Received: by 2002:a05:6870:5627:b0:17d:1287:1b5c with SMTP id m39-20020a056870562700b0017d12871b5cmr2524969oao.9.1681450843890;
        Thu, 13 Apr 2023 22:40:43 -0700 (PDT)
X-Google-Smtp-Source: AKy350YUPuw9qHFJb/CWKg4l7nwBYVM6AmHM+j+mUdqLLHmDT2abxvGjtVUB/vr6+CVJxJ2HGXu46UgbDiYuS5Oy9R4=
X-Received: by 2002:a05:6870:5627:b0:17d:1287:1b5c with SMTP id
 m39-20020a056870562700b0017d12871b5cmr2524956oao.9.1681450843735; Thu, 13 Apr
 2023 22:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230413121937.46135-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230413121937.46135-1-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 14 Apr 2023 13:40:32 +0800
Message-ID: <CACGkMEsE8TosCxyf4GwmsBzo1Ot9FiLtsWt16oz0f0J99DGYCg@mail.gmail.com>
Subject: Re: [PATCH net] virtio_net: bugfix overflow inside xdp_linearize_page()
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 13, 2023 at 8:19=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Here we copy the data from the original buf to the new page. But we
> not check that it may be overflow.
>
> As long as the size received(including vnethdr) is greater than 3840
> (PAGE_SIZE -VIRTIO_XDP_HEADROOM). Then the memcpy will overflow.
>
> And this is completely possible, as long as the MTU is large, such
> as 4096. In our test environment, this will cause crash. Since crash is
> caused by the written memory, it is meaningless, so I do not include it.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Missing fixes tag?

Other than this,

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/net/virtio_net.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 2396c28c0122..ea1bd4bb326d 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -814,8 +814,13 @@ static struct page *xdp_linearize_page(struct receiv=
e_queue *rq,
>                                        int page_off,
>                                        unsigned int *len)
>  {
> -       struct page *page =3D alloc_page(GFP_ATOMIC);
> +       int tailroom =3D SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> +       struct page *page;
> +
> +       if (page_off + *len + tailroom > PAGE_SIZE)
> +               return NULL;
>
> +       page =3D alloc_page(GFP_ATOMIC);
>         if (!page)
>                 return NULL;
>
> @@ -823,7 +828,6 @@ static struct page *xdp_linearize_page(struct receive=
_queue *rq,
>         page_off +=3D *len;
>
>         while (--*num_buf) {
> -               int tailroom =3D SKB_DATA_ALIGN(sizeof(struct skb_shared_=
info));
>                 unsigned int buflen;
>                 void *buf;
>                 int off;
> --
> 2.32.0.3.g01195cf9f
>

