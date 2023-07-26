Return-Path: <bpf+bounces-5991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D46763EA8
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 20:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44F6A1C21322
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 18:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3324CE63;
	Wed, 26 Jul 2023 18:38:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D097E1
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 18:38:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BC11BF6
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 11:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690396699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ZkfxuuQUI6WS1OsCy4f4xk/TS/NLkS7ZKlAlhCGBD4=;
	b=eRb5MtvGXI6/Lv39T0OoIG3Y3MGqsLd1TqqZ3LCTSJXV8WSrpi6FBUD902MZYZ49uyDOjs
	MRjdTXx33v8sjHZZiNWdlqnPm1OkW851TET7kx485YBHAUy66jCDcrzt7bqdPXt5/21HX/
	qvX8aNxVzbS+Ez4JMOntRtS2UE3QPew=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-Atv050cXNZmVxac3TSsq6A-1; Wed, 26 Jul 2023 14:38:17 -0400
X-MC-Unique: Atv050cXNZmVxac3TSsq6A-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4fdde274729so79140e87.3
        for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 11:38:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690396696; x=1691001496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ZkfxuuQUI6WS1OsCy4f4xk/TS/NLkS7ZKlAlhCGBD4=;
        b=eBVEgaqNkX52MJv05cx4CQwQSAaciq29Pct8GLsak3yhsmC5wescdwMEkINZCvwrzN
         +Wzn3fjx4wufqluCCM07S+Jxk0PQNQMoqOTpRq/465Z0fJ6gS4bdPlBgmWpYX/twsGul
         6fvPLLa7uxmHSuVl0WgaKtyBZ5uIX7JY1I0Yf5YAc0QG1qJqXNLVVipTydCVmh/d6f0X
         OeYJd5Yk48B6tDLNO2w8c3vIbLPGxXsX6yJbTPMSQTwOl1Ssyp1mpMcwFT+sq3sxoo8x
         eZNU7o72rgxygoG6bs2H4z8xOlsysk29MeD11GM2173GYgXScbS9JDYVfOO0RONDHrE3
         J4GA==
X-Gm-Message-State: ABy/qLbrP7gyL+ccKo2rT3bn+g60ZmG4eY1SPS+PpBOdsH3TViGoEeD6
	ms7U1nyxOw02B7Caz1XJj3G2IXsevH+QTiB+fyeQ0L1YtAZYCnQ7Gg1o5/dFIspubF9nBdQweWX
	0svgfEw+X/CVZ
X-Received: by 2002:a05:6512:32aa:b0:4fe:d9e:a47 with SMTP id q10-20020a05651232aa00b004fe0d9e0a47mr2160162lfe.69.1690396696360;
        Wed, 26 Jul 2023 11:38:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGrmEcx/kJue2Mk0wlq5n2w2uLYFHBteYJyc3Ij9fkV7DF4dbhcJqImI+mNTHeim2phb5ANfA==
X-Received: by 2002:a05:6512:32aa:b0:4fe:d9e:a47 with SMTP id q10-20020a05651232aa00b004fe0d9e0a47mr2160137lfe.69.1690396695997;
        Wed, 26 Jul 2023 11:38:15 -0700 (PDT)
Received: from redhat.com ([2.52.14.22])
        by smtp.gmail.com with ESMTPSA id v2-20020a170906380200b0099b6becb107sm8669173ejc.95.2023.07.26.11.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 11:38:14 -0700 (PDT)
Date: Wed, 26 Jul 2023 14:38:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bobby Eshleman <bobby.eshleman@bytedance.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryantan@vmware.com>, Vishnu Dasa <vdasa@vmware.com>,
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Simon Horman <simon.horman@corigine.com>,
	Krasnov Arseniy <oxffffaa@gmail.com>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	bpf@vger.kernel.org, Jiang Wang <jiang.wang@bytedance.com>
Subject: Re: [PATCH RFC net-next v5 10/14] virtio/vsock: add
 VIRTIO_VSOCK_F_DGRAM feature bit
Message-ID: <20230726143736-mutt-send-email-mst@kernel.org>
References: <20230413-b4-vsock-dgram-v5-0-581bd37fdb26@bytedance.com>
 <20230413-b4-vsock-dgram-v5-10-581bd37fdb26@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413-b4-vsock-dgram-v5-10-581bd37fdb26@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 12:50:14AM +0000, Bobby Eshleman wrote:
> This commit adds a feature bit for virtio vsock to support datagrams.
> 
> Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
> Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
> ---
>  include/uapi/linux/virtio_vsock.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
> index 331be28b1d30..27b4b2b8bf13 100644
> --- a/include/uapi/linux/virtio_vsock.h
> +++ b/include/uapi/linux/virtio_vsock.h
> @@ -40,6 +40,7 @@
>  
>  /* The feature bitmap for virtio vsock */
>  #define VIRTIO_VSOCK_F_SEQPACKET	1	/* SOCK_SEQPACKET supported */
> +#define VIRTIO_VSOCK_F_DGRAM		3	/* SOCK_DGRAM supported */
>  
>  struct virtio_vsock_config {
>  	__le64 guest_cid;

pls do not add interface without first getting it accepted in the
virtio spec.

> -- 
> 2.30.2


