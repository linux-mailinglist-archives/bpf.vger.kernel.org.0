Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C108C6361EB
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 15:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238107AbiKWOe7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 09:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238592AbiKWOeu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 09:34:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997FE18B28
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 06:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669214031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VEC/ljsECl0xwOwNuuFj4J2VWL3DFQIVZWJ6dvR2khs=;
        b=C9vFwQEbkehORiQkhkuDd6jbj1pJJD5GTz1hlCK4houkRU0hjw/p+GBLHz0jh/Q0mvcK5B
        ffMtksegjZjM70KD/hnYcwmctRsEhcBLBBKP3ZWE7ZMfDgdqyq6XKLR7pVdWJ3WSQTpyyl
        liBiuuf9jVo5yOx0goFrS/kPxJTV9fY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-570-Ft1aI_j6M_Ca9gdsI1F23w-1; Wed, 23 Nov 2022 09:33:50 -0500
X-MC-Unique: Ft1aI_j6M_Ca9gdsI1F23w-1
Received: by mail-ej1-f72.google.com with SMTP id xc12-20020a170907074c00b007416699ea14so10050678ejb.19
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 06:33:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VEC/ljsECl0xwOwNuuFj4J2VWL3DFQIVZWJ6dvR2khs=;
        b=DqVc+OKKMjxFFbDtNIsiIv1txuMWj7mRJl67HOFFIJ8BrwHAu8Z2pku3UjvGPteUcZ
         KMTU/YIliOL/fTACTy7XFVbPB3oAFlEGAEdejHkc4tWRobB62S6ZvQbCD0oht77Dm++Z
         zHqW1nvCt0Iyk31NKRLoBIm0RsaBkC21z9usp7zqnb2+Jj2erwfuKuwplX4z19ChDW2J
         yQ29pkA7ToLHS7Lw3seTefE0zJRJ27w0cRepqajpOIusnBcYkFFcViGs3kJhaijQdoQm
         R8jE2PzLYrikg9/vDKY41Mc0BuvhKFBpUikgb2oIOe3Iy2lOjZBEJxcJO7/DiNONej+E
         fkeg==
X-Gm-Message-State: ANoB5plCmfpmq3y28eDBCu2I/dq2d1vCrbAQdWiFH9Ax97NSMeIzB+V1
        b97HHEutCq4b7AMcA676NXjKgEIFXhzeqNUzIsuDiZE9+Qx7X3UasZP3o4qO7g8Yzc/7SYnENiv
        cemW6g1yoHYv9
X-Received: by 2002:a17:906:ce35:b0:7ae:215:2dd5 with SMTP id sd21-20020a170906ce3500b007ae02152dd5mr8205308ejb.208.1669214029128;
        Wed, 23 Nov 2022 06:33:49 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6Br7EfMXN8zzJJucIbAC1NA/3UEE3+EzuxBZef9EsnddC7aq3JapzaQq+3gcmcLf6jmsIGvw==
X-Received: by 2002:a17:906:ce35:b0:7ae:215:2dd5 with SMTP id sd21-20020a170906ce3500b007ae02152dd5mr8205265ejb.208.1669214028772;
        Wed, 23 Nov 2022 06:33:48 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id es8-20020a056402380800b00459148fbb3csm7642794edb.86.2022.11.23.06.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 06:33:48 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 63FC87D511B; Wed, 23 Nov 2022 15:33:47 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Tariq Toukan <tariqt@nvidia.com>,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org
Subject: Re: [xdp-hints] [PATCH bpf-next v2 6/8] mlx4: Introduce
 mlx4_xdp_buff wrapper for xdp_buff
In-Reply-To: <20221121182552.2152891-7-sdf@google.com>
References: <20221121182552.2152891-1-sdf@google.com>
 <20221121182552.2152891-7-sdf@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 23 Nov 2022 15:33:47 +0100
Message-ID: <874jupviyc.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Stanislav Fomichev <sdf@google.com> writes:

> No functional changes. Boilerplate to allow stuffing more data after xdp_buff.
>
> Cc: Tariq Toukan <tariqt@nvidia.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Jesper Dangaard Brouer <brouer@redhat.com>
> Cc: Anatoly Burakov <anatoly.burakov@intel.com>
> Cc: Alexander Lobakin <alexandr.lobakin@intel.com>
> Cc: Magnus Karlsson <magnus.karlsson@gmail.com>
> Cc: Maryam Tahhan <mtahhan@redhat.com>
> Cc: xdp-hints@xdp-project.net
> Cc: netdev@vger.kernel.org
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>  drivers/net/ethernet/mellanox/mlx4/en_rx.c | 26 +++++++++++++---------
>  1 file changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> index 8f762fc170b3..467356633172 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> @@ -661,17 +661,21 @@ static int check_csum(struct mlx4_cqe *cqe, struct sk_buff *skb, void *va,
>  #define MLX4_CQE_STATUS_IP_ANY (MLX4_CQE_STATUS_IPV4)
>  #endif
>  
> +struct mlx4_xdp_buff {
> +	struct xdp_buff xdp;
> +};

This embedding trick works for drivers that put xdp_buff on the stack,
but mlx5 supports XSK zerocopy, which uses the xsk_buff_pool for
allocating them. This makes it a bit awkward to do the same thing there;
and since it's probably going to be fairly common to do something like
this, how about we just add a 'void *drv_priv' pointer to struct
xdp_buff that the drivers can use? The xdp_buff already takes up a full
cache line anyway, so any data stuffed after it will spill over to a new
one; so I don't think there's much difference performance-wise.

I'll send my patch to add support to mlx5 (using the drv_priv pointer
approach) separately.

-Toke

