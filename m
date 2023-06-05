Return-Path: <bpf+bounces-1794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A67721D9F
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 07:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BED541C209D1
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 05:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA065232;
	Mon,  5 Jun 2023 05:44:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B72631
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 05:44:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD02AF
	for <bpf@vger.kernel.org>; Sun,  4 Jun 2023 22:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685943876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/ejXk37OnpgBfntpQO2hBNILL2g4QMjhCiXN34MbvEk=;
	b=fGFQpBRRMc40C8fWbp/Nrv4DsdtHxKzD4SEaxGaMphPyxjZMJnxgZNoBWMR4jE2FEfTD6b
	fA3eKHFWdsf0rYddOWY60d+M+xnW8HeIduBpgtjxURdOCaZfq80SWSHjWyRmv/UF0W1Xoh
	CWVW8WYSk8yRDqF2S90dsTMCa6JGpVA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-AAfOyK65Nui_EA1n8rQGtw-1; Mon, 05 Jun 2023 01:44:33 -0400
X-MC-Unique: AAfOyK65Nui_EA1n8rQGtw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30af222c5feso2393681f8f.1
        for <bpf@vger.kernel.org>; Sun, 04 Jun 2023 22:44:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685943873; x=1688535873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ejXk37OnpgBfntpQO2hBNILL2g4QMjhCiXN34MbvEk=;
        b=mHfQBZKTWTDtizRBIxQ6HRNBRB2L7AENmWY00gtsBUV6RTu0dLF5atqHuENnw+MEhE
         tNPA7uuwlvkggegCOCB3Vc/Wuj3swAugUb5XMM12IC5JIYHWflTCSFPMffTGSozwn6sw
         flsXkNvPD8aRSWjvnn8GbMlZ+QKHJyO3cA0Pay3JnkQF3CvLI61qrYsSpYiyoHBCgSre
         LDCjzdU+Jm5/2Hd89Uod/DrhJJzzaQutkU4waC56ONq8+mk3GXo4pG4TuDot8nHUKzTe
         /1jYb1lyO2OEWqBjH5CU/2YsvEpkPuPcm8KZjJdck3Kwl2RtkYplHDgy+YAaUlOiwA61
         vIlA==
X-Gm-Message-State: AC+VfDxGCUenjuQGK3d47Pap0F3/BhJObwsf1EJ2eNMc+0UFP3bgMsBN
	ysAgcQXqzKnQ6P7g/5cKyVfLQoDZrfg/Igpf/VbJ9JnKZ3uI0Q1yKIV+E5xogPf6lCCNgAI5k6p
	nqThjTZeZCDl1
X-Received: by 2002:adf:f687:0:b0:30a:e5e3:ea66 with SMTP id v7-20020adff687000000b0030ae5e3ea66mr4818791wrp.14.1685943872852;
        Sun, 04 Jun 2023 22:44:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5PHhVf9POTk1AmuouTd4HghcP4O8qLZ+32oStK2OroFPJBE288EDHshOL1o8Lb2YOXPb2Bvg==
X-Received: by 2002:adf:f687:0:b0:30a:e5e3:ea66 with SMTP id v7-20020adff687000000b0030ae5e3ea66mr4818781wrp.14.1685943872612;
        Sun, 04 Jun 2023 22:44:32 -0700 (PDT)
Received: from redhat.com ([2.55.41.2])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600c378400b003f195d540d9sm13048625wmr.14.2023.06.04.22.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 22:44:31 -0700 (PDT)
Date: Mon, 5 Jun 2023 01:44:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	virtualization@lists.linux-foundation.org,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH vhost v10 10/10] virtio_net: support dma premapped
Message-ID: <20230605014154-mutt-send-email-mst@kernel.org>
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com>
 <20230602092206.50108-11-xuanzhuo@linux.alibaba.com>
 <20230602233152.4d9b9ba4@kernel.org>
 <1685931044.5893385-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1685931044.5893385-2-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 05, 2023 at 10:10:44AM +0800, Xuan Zhuo wrote:
> On Fri, 2 Jun 2023 23:31:52 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> > On Fri,  2 Jun 2023 17:22:06 +0800 Xuan Zhuo wrote:
> > >  drivers/net/virtio_net.c | 163 +++++++++++++++++++++++++++++++++------
> >
> > ack for this going via the vhost tree, FWIW, but you'll potentially
> > need to wait for the merge window to move forward with the actual
> > af xdp patches, in this case.
> 
> 
> My current plan is to let virtio support premapped dma first, and then implement
> virtio-net to support af-xdp zerocopy.
> 
> This will indeed involve two branches. But most of the implementations in this
> patch are virtio code, so I think it would be more appropriate to commit to
> vhost. Do you have any good ideas?
> 
> 
> Thanks.

Are you still making changes to net core? DMA core? If it's only
virtio-net then I can probably merge all of it - just a couple of
bugfixes there so far, it shouldn't cause complex conflicts.

-- 
MST


