Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B626E6077
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 13:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjDRL4L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 07:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjDRLyK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 07:54:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D5C3580
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 04:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681818781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZXvHe+hqlmu93yWIU70NYfBDF1m9Fy56L1Ru9xyKRuE=;
        b=QUgtIgYGARewpbXm8X57dL1T9zklS+6mSzLLuDiRgSeIEePRw3gnwg+uHLLjsH160qKXmT
        meKd2E7HttxhS8DOBsqYkK/It8YdiyPBa3mF39aj9SjDd0uxef4S85r4yBPwIz2nN+caH3
        wC15c6jk3h8FzoNLwPwGgb71HG9mlr0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-zP0gvO5mOBOnHRvADCZT8w-1; Tue, 18 Apr 2023 07:49:35 -0400
X-MC-Unique: zP0gvO5mOBOnHRvADCZT8w-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-2fcec825133so158464f8f.3
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 04:49:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681818574; x=1684410574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXvHe+hqlmu93yWIU70NYfBDF1m9Fy56L1Ru9xyKRuE=;
        b=XQWHHeBqyeS0vR+eHswphlhbnvWtK2wXW3/EoIf3tEh+/ChJM46wHYd/RcTHcYPE8S
         yKIInL8jkasz2KDltIAwqjLRC0VBsSAti3nczXDh13ExoWQHdVPezeT6uoq6zLwgbxiQ
         YzT8dA+SeqXf1sYJTtyAkFIKJznbBuHzDirzrCR0q8buWypMkq9EyMyqP5hkWmfBtYau
         wSMGJJgO0kCtB5bn9ixtH/e2mDnCTQg6kRLEqUkgD1/FDOZxzVvHqrEuCtjO+UYYg1h7
         rHBMMNd9PO/px3N+1dc3gChLAiuQBYxSLWuP4sJsoiVIii5jhkxoF5VsRLxm7TGVUvDa
         aUSg==
X-Gm-Message-State: AAQBX9d/gHXKYZQsn0rnZxUYsOh/uW5IaTrzTN5xboq4ddS4OOISeJ+i
        OSSLCebC4XCuYWMfwPbj1q7HDBexloSrBWmtZuwus3tJDCuHkx3qIDarxKBjTHwucC9Mc7hMyCy
        RVMNqMb1cP4BB
X-Received: by 2002:adf:fc92:0:b0:2f9:338:743d with SMTP id g18-20020adffc92000000b002f90338743dmr1863031wrr.23.1681818574099;
        Tue, 18 Apr 2023 04:49:34 -0700 (PDT)
X-Google-Smtp-Source: AKy350aYOVN1Z2VSO4baE6EM1hNDxkNcLBVWEre5foX9c33S7tdTllckYbjKhI5GlVc4jsmMnSneYQ==
X-Received: by 2002:adf:fc92:0:b0:2f9:338:743d with SMTP id g18-20020adffc92000000b002f90338743dmr1863011wrr.23.1681818573765;
        Tue, 18 Apr 2023 04:49:33 -0700 (PDT)
Received: from redhat.com ([2.52.136.129])
        by smtp.gmail.com with ESMTPSA id a7-20020adfed07000000b002fb2782219esm3758368wro.3.2023.04.18.04.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 04:49:33 -0700 (PDT)
Date:   Tue, 18 Apr 2023 07:49:28 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 00/14] virtio_net: refactor xdp codes
Message-ID: <20230418074911-mutt-send-email-mst@kernel.org>
References: <20230418065327.72281-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418065327.72281-1-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 18, 2023 at 02:53:13PM +0800, Xuan Zhuo wrote:
> Due to historical reasons, the implementation of XDP in virtio-net is relatively
> chaotic. For example, the processing of XDP actions has two copies of similar
> code. Such as page, xdp_page processing, etc.
> 
> The purpose of this patch set is to refactor these code. Reduce the difficulty
> of subsequent maintenance. Subsequent developers will not introduce new bugs
> because of some complex logical relationships.
> 
> In addition, the supporting to AF_XDP that I want to submit later will also need
> to reuse the logic of XDP, such as the processing of actions, I don't want to
> introduce a new similar code. In this way, I can reuse these codes in the
> future.
> 
> Please review.
> 
> Thanks.

Big refactoring, pls allow a bit more time for review. Thanks!

> v2:
>     1. re-split to make review more convenient
> 
> v1:
>     1. fix some variables are uninitialized
> 
> Xuan Zhuo (14):
>   virtio_net: mergeable xdp: put old page immediately
>   virtio_net: introduce mergeable_xdp_prepare()
>   virtio_net: optimize mergeable_xdp_prepare()
>   virtio_net: introduce virtnet_xdp_handler() to seprate the logic of
>     run xdp
>   virtio_net: introduce xdp res enums
>   virtio_net: separate the logic of freeing xdp shinfo
>   virtio_net: separate the logic of freeing the rest mergeable buf
>   virtio_net: auto release xdp shinfo
>   virtio_net: introduce receive_mergeable_xdp()
>   virtio_net: merge: remove skip_xdp
>   virtio_net: introduce receive_small_xdp()
>   virtio_net: small: optimize code
>   virtio_net: small: optimize code
>   virtio_net: small: remove skip_xdp
> 
>  drivers/net/virtio_net.c | 625 +++++++++++++++++++++++----------------
>  1 file changed, 362 insertions(+), 263 deletions(-)
> 
> --
> 2.32.0.3.g01195cf9f

