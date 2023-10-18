Return-Path: <bpf+bounces-12521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 015B47CD5D7
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 09:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39EB61C20C5A
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 07:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F78125D6;
	Wed, 18 Oct 2023 07:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Osg+yyzm"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9085E11C81
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 07:59:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88801102
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 00:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697615952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j/RuX7PEGAER5VWHTAgQGINHue7Pa6HBkkP2SfD/G/8=;
	b=Osg+yyzmBUa3I/gTiU+X703MH+bG84ZDlVRVD0Hn+DVfht12YeHJtje4uPlXoiMXt4bPws
	S6G7QqEhLOZQyC73gKKCCL7u47HNbVRCpRLEdnzeKk4/WWW2d3Lw4evNaDQMTID+UNsjG7
	wA0C6jNHOeXgSzYHdcoZvM+KQbMtWgk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-m65X-LnBNMKbSSHZosEAHw-1; Wed, 18 Oct 2023 03:59:11 -0400
X-MC-Unique: m65X-LnBNMKbSSHZosEAHw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-534543af820so5014102a12.2
        for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 00:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697615950; x=1698220750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/RuX7PEGAER5VWHTAgQGINHue7Pa6HBkkP2SfD/G/8=;
        b=VhWcAgOysX6SeE5ZR1KTf3P89ElxXE+KAsR3uay3BCGfgm0Z11l7MLLvgTk4GgI2qc
         M0R2t5DAABCnvqOcjNSzn9ExvVB7m/pi7stm/drSmEqOPRtQhCSkrD+/ak3efVOpjVto
         0N3slLe68J9Rp+AE49Yx6aPK38ZRNRY8v9kDZvfj+NSo2gFYLAIQdzVoqNBZqYeJ5Y6H
         9sLPACvsvLIp6w3swMA/7DwYAu8dBldpnwimzopZ75TyfkAj/So3xDde+ol0vdZknl07
         fcU8D+7O/qLFarkWGBlz7kaFAYMpQYGp1glI/xLZxR3RYEyewi9sI7SKidTwjmHFtriV
         U/uQ==
X-Gm-Message-State: AOJu0YymUte9qqy04DFMKyaJlbv5dGS8ZIDYZgXK47HZeNBUVQchhxji
	JVrAa6vaMxw8JOXm0IgHEZiiid88RWlTVeh1J5+55B40TH+PPyx0k3IEvtAHLQfWdEmAmju9bX4
	rbl6CtCImbMSwMX4o+EgDw3g=
X-Received: by 2002:a05:6402:518d:b0:52d:212d:78ee with SMTP id q13-20020a056402518d00b0052d212d78eemr3681714edd.25.1697615949945;
        Wed, 18 Oct 2023 00:59:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWa90MygBLIZW4CwgrTQDTiga7S0LJQ7NKa0AEFJwcbizxjymr8txFWZM0Exp5aJmHG3yWYA==
X-Received: by 2002:a05:6402:518d:b0:52d:212d:78ee with SMTP id q13-20020a056402518d00b0052d212d78eemr3681693edd.25.1697615949647;
        Wed, 18 Oct 2023 00:59:09 -0700 (PDT)
Received: from redhat.com ([193.142.201.34])
        by smtp.gmail.com with ESMTPSA id j30-20020a508a9e000000b0053f11e3c019sm2389384edj.90.2023.10.18.00.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 00:59:09 -0700 (PDT)
Date: Wed, 18 Oct 2023 03:59:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH vhost 02/22] virtio_ring: introduce
 virtqueue_dma_[un]map_page_attrs
Message-ID: <20231018035751-mutt-send-email-mst@kernel.org>
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
 <20231011092728.105904-3-xuanzhuo@linux.alibaba.com>
 <1697615580.6880193-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1697615580.6880193-1-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 18, 2023 at 03:53:00PM +0800, Xuan Zhuo wrote:
> Hi Michael,
> 
> Do you think it's appropriate to push the first two patches of this patch set to
> linux 6.6?
> 
> Thanks.

I generally treat patchsets as a whole unless someone asks me to do
otherwise. Why do you want this?

-- 
MST


