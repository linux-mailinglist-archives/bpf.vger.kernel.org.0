Return-Path: <bpf+bounces-6522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FFF76A7E6
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 06:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58910281895
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 04:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AE246B6;
	Tue,  1 Aug 2023 04:30:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807696ABB;
	Tue,  1 Aug 2023 04:30:27 +0000 (UTC)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A16A2112;
	Mon, 31 Jul 2023 21:30:24 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2682b4ca7b7so3024837a91.3;
        Mon, 31 Jul 2023 21:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690864224; x=1691469024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=776YvuBT2o+3N0jG6Zo+Nima5t92155vc9hfZr1faKk=;
        b=rt9z56jABU9MJPxF5blwK3g2sD4mB5l21I1sBoCXVcYTv+z7cpr9e3Xc9VTfvr8Efi
         4BG/GThzY5BREnYDWqImwrijuX2T9TiIChqUDGFwrFMFzzdt1a8JXNauflPN573iOO2Z
         g0PEucGF4GIjaUHE/sDPIjezhZOj0NLprZvcp+YMh2gEn6I0wBHqMB3GtEOv/Ip+qjFj
         rxgFg+9QZj+GYYZymTL37SocACHRSZVV+1Yqw3CnRfI96SB+O5oXKyxjkgSFWdqUolEC
         VlRSPxnfqKibF8MwN4607X6PpJ+dUm08FTf51R49imGBcKS9TGEmefc7X8P0Kb8+ydE9
         payA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690864224; x=1691469024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=776YvuBT2o+3N0jG6Zo+Nima5t92155vc9hfZr1faKk=;
        b=MjGUxLsU5BPNw/ERE+rlQCBCir+EPE36m0cBLH7dDTrlOxPxcGM/yqlbrG8kCYCuCt
         T3jl9HMV4caOmEVKNIAKaSFosJVFsowYQHkZcYUF29WHS/2bQo18AzUOAYyrXIitg12m
         Fsr1HTMLFb+CXZHgoZRVpas5G3X3nPGqBP32saCfaTW7wkEUkIYXh/6HWHUOi0yaNcT/
         I2x8x2i/FPhy6oGZfCzcX8V2ozEGwQ+BCw8MtcL50dkheoES6RvqNz4s118SwQc8sBko
         ApFzTYz6R+8Xj4KgEyiwPBfX5PS+Unztrr6jo9UlK1axlXWbFPYEW5LsW9BUHeZmvlXz
         6k4Q==
X-Gm-Message-State: ABy/qLbY7t4Xk5TN/N3PSyDq/XuOR/sz4G3Tq3w/uMuEmP6G7ww1sr+6
	dr8RVosYL0Uv9gwHAE+F9GtAH6E8TVkD9XRk
X-Google-Smtp-Source: APBJJlGwc0D45cABI3SJLqH9UcPn8pe+oOD47SnYfpdI0990kjrICpWC2EDUm24iy3+6DK8rvcAbfw==
X-Received: by 2002:a17:90a:d808:b0:267:e011:3e9a with SMTP id a8-20020a17090ad80800b00267e0113e9amr9512775pjv.3.1690864223786;
        Mon, 31 Jul 2023 21:30:23 -0700 (PDT)
Received: from localhost (c-67-166-91-86.hsd1.wa.comcast.net. [67.166.91.86])
        by smtp.gmail.com with ESMTPSA id ep11-20020a17090ae64b00b00262eccfa29fsm8389618pjb.33.2023.07.31.21.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 21:30:23 -0700 (PDT)
Date: Tue, 1 Aug 2023 04:30:22 +0000
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	linux-hyperv@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
	kvm@vger.kernel.org,
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Simon Horman <simon.horman@corigine.com>,
	virtualization@lists.linux-foundation.org,
	Eric Dumazet <edumazet@google.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryantan@vmware.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Krasnov Arseniy <oxffffaa@gmail.com>,
	Vishnu Dasa <vdasa@vmware.com>,
	Jiang Wang <jiang.wang@bytedance.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH RFC net-next v5 10/14] virtio/vsock: add
 VIRTIO_VSOCK_F_DGRAM feature bit
Message-ID: <ZMiKXh173b/3Pj1L@bullseye>
References: <20230413-b4-vsock-dgram-v5-0-581bd37fdb26@bytedance.com>
 <20230413-b4-vsock-dgram-v5-10-581bd37fdb26@bytedance.com>
 <20230726143736-mutt-send-email-mst@kernel.org>
 <tpwk67lij7t7hquduogxzyox5wvq73yriv7vqiizqoxxtxvfwq@jzkcmq4kv3b4>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tpwk67lij7t7hquduogxzyox5wvq73yriv7vqiizqoxxtxvfwq@jzkcmq4kv3b4>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 09:48:21AM +0200, Stefano Garzarella wrote:
> On Wed, Jul 26, 2023 at 02:38:08PM -0400, Michael S. Tsirkin wrote:
> > On Wed, Jul 19, 2023 at 12:50:14AM +0000, Bobby Eshleman wrote:
> > > This commit adds a feature bit for virtio vsock to support datagrams.
> > > 
> > > Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
> > > Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
> > > ---
> > >  include/uapi/linux/virtio_vsock.h | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
> > > index 331be28b1d30..27b4b2b8bf13 100644
> > > --- a/include/uapi/linux/virtio_vsock.h
> > > +++ b/include/uapi/linux/virtio_vsock.h
> > > @@ -40,6 +40,7 @@
> > > 
> > >  /* The feature bitmap for virtio vsock */
> > >  #define VIRTIO_VSOCK_F_SEQPACKET	1	/* SOCK_SEQPACKET supported */
> > > +#define VIRTIO_VSOCK_F_DGRAM		3	/* SOCK_DGRAM supported */
> > > 
> > >  struct virtio_vsock_config {
> > >  	__le64 guest_cid;
> > 
> > pls do not add interface without first getting it accepted in the
> > virtio spec.
> 
> Yep, fortunatelly this series is still RFC.
> I think by now we've seen that the implementation is doable, so we
> should discuss the changes to the specification ASAP. Then we can
> merge the series.
> 
> @Bobby can you start the discussion about spec changes?
> 

No problem at all. Am I right to assume that a new patch to the spec is
the standard starting point for discussion?

> Thanks,
> Stefano
> 
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization

