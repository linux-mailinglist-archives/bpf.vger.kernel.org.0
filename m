Return-Path: <bpf+bounces-2027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3C2726A7E
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 22:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 437AE28141C
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 20:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5403925A;
	Wed,  7 Jun 2023 20:15:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60FC19BBC
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 20:15:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEC6125
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 13:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686168919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IbNJSMdQgU9VQLlBMF193RvlUeSC+D1EGbqTaY89bwo=;
	b=TM4D1KwtDiFTi+wEc4CIe1rdS2TwONzarjWtPWerQ0m6N2xobEzeNC1tqqLD71EURFeMpd
	exxC3X20xAGvJ3rxyi8LgGx1KR1jr/o3doFzrVbUnd/mHXn4WPCfbv8I8KG26ms6j6v3Lm
	r7e9ulTjVz/pq9MYYBg73I37Qza4iJw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-yvRPNqtpPdiV261RGqE_gQ-1; Wed, 07 Jun 2023 16:15:18 -0400
X-MC-Unique: yvRPNqtpPdiV261RGqE_gQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f7e64e1157so23003055e9.0
        for <bpf@vger.kernel.org>; Wed, 07 Jun 2023 13:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686168917; x=1688760917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbNJSMdQgU9VQLlBMF193RvlUeSC+D1EGbqTaY89bwo=;
        b=jtwTGl8j63gSUZs+nQFckEVu3cKjNQUzyXRRzYlOtUMpimEoLU/7ydgtDsnMppOAB1
         8MBgO8FuOV8Y9kYoFSiqD0CtsnoryrZ9nBT5KyUZgSLejUO4DpS4R74JHLmEwuY47lZr
         QXDhJdqu9jICsHwKE/kaY5QGd3H4gyF+AaFrGcgDsJ/vC/0etg/YIDLuvbRPMBCklYsw
         BNiQ0SGOoCmGckA5iGinIudyqYqDhjAZ1f+/eDD1i65jO861atiPB8qlKJtAMblmpvNh
         KBl1VQ0qvR3h8XiZVOKq2KIF86hneyf8uyqGD6gQrtoebTd4zNdje6ciBi1mGyscGnBZ
         RU2g==
X-Gm-Message-State: AC+VfDyszqzk1Nc0lIAjajtIdLt2x2hXUvZk994IXJtYVkJp1pd1HYy+
	hSk0ds+Js+eJyfEYrGT1QfEDuEILvdCAC2k6ORZvC6Nn2RCGnMvqlFP31UmdC57JOCtpRU4Urvn
	xut2UYja5XxBR
X-Received: by 2002:a1c:7717:0:b0:3f7:eadb:941d with SMTP id t23-20020a1c7717000000b003f7eadb941dmr7565499wmi.19.1686168917313;
        Wed, 07 Jun 2023 13:15:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6BuNZENhGXmy7RykVEep93dqwtBJaN8D86qVbIP42EfYDXBC7+P61b2CTrPMue3++mbYka1g==
X-Received: by 2002:a1c:7717:0:b0:3f7:eadb:941d with SMTP id t23-20020a1c7717000000b003f7eadb941dmr7565477wmi.19.1686168916980;
        Wed, 07 Jun 2023 13:15:16 -0700 (PDT)
Received: from redhat.com ([2.55.4.169])
        by smtp.gmail.com with ESMTPSA id s17-20020a7bc391000000b003f727764b10sm3110831wmj.4.2023.06.07.13.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 13:15:16 -0700 (PDT)
Date: Wed, 7 Jun 2023 16:15:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jakub Kicinski <kuba@kernel.org>,
	virtualization@lists.linux-foundation.org,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH vhost v10 00/10] virtio core prepares for AF_XDP
Message-ID: <20230607161440-mutt-send-email-mst@kernel.org>
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com>
 <20230602232902.446e1d71@kernel.org>
 <1685930301.215976-1-xuanzhuo@linux.alibaba.com>
 <ZICOl1hfsx5DwKff@infradead.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZICOl1hfsx5DwKff@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 07, 2023 at 07:05:11AM -0700, Christoph Hellwig wrote:
> On Mon, Jun 05, 2023 at 09:58:21AM +0800, Xuan Zhuo wrote:
> > On Fri, 2 Jun 2023 23:29:02 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> > > On Fri,  2 Jun 2023 17:21:56 +0800 Xuan Zhuo wrote:
> > > > Thanks for the help from Christoph.
> > >
> > > That said you haven't CCed him on the series, isn't the general rule to
> > > CC anyone who was involved in previous discussions?
> > 
> > 
> > Sorry, I forgot to add cc after git format-patch.
> 
> So I've been looking for this series elsewhere, but it seems to include
> neither lkml nor the iommu list, so I can't find it.  Can you please
> repost it?

I bounced to lkml now - does this help?


