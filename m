Return-Path: <bpf+bounces-3394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE9773CEE6
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 09:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F591C208FC
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 07:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFF581B;
	Sun, 25 Jun 2023 07:19:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C7A7C
	for <bpf@vger.kernel.org>; Sun, 25 Jun 2023 07:19:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB872B7
	for <bpf@vger.kernel.org>; Sun, 25 Jun 2023 00:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687677574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=crvYJVJpTbYTunCiIEUekC9+YM4D9xRjLajPL7dk4PA=;
	b=QMslYb5vRHwCh8l52KRWHlIYk+PVfZjP1ZHnqlPCZ1aLYVJkZ+9I3t4ZCqw3ZLujhr5J07
	OWuH0/61RJyLB45SGVTOkAjR3CpMMSJtns9aTXKAn4f1bw5D9mm2cWyHtNQj8jJc8TAZgI
	GUCSlcSzMrqujOyN+xPsnpyVGZZQAFw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-0FCluSNcPaeyz5vytCbV-w-1; Sun, 25 Jun 2023 03:19:33 -0400
X-MC-Unique: 0FCluSNcPaeyz5vytCbV-w-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4f60dd5ab21so1384148e87.3
        for <bpf@vger.kernel.org>; Sun, 25 Jun 2023 00:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687677571; x=1690269571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crvYJVJpTbYTunCiIEUekC9+YM4D9xRjLajPL7dk4PA=;
        b=guLPNCxlgBbmKU0JJMc+4LI6xNWulEtNY8EAfUmVOkKF/SOo/I5NALZK9P5YKZrHCq
         wxYTKPcMHe8G/l7RtEU6u0tp2dBJPvoV6xfg/EhSiRQpM0R7e1xdzhvZ2ywxV7e1tYNf
         ZELzbbsQnllQ0dWhitxEuAL5pNNpkNMzCoW9UvB4oadkTnUK4VGhVn3TDNhIPajMZ17l
         KP/UIk+1lhLrw8H2TCu4LXLIZVb1Rnl4qke6sToSG5tHXiQtvceL7znwfJ7s/0PsHq7M
         SGSm8N3RpXydBIelm6xtXwyVk2jXVh6Qvep/HpvLT5Ogc2Eht/NJ0sRaSyEDrt1UzhJA
         p1TQ==
X-Gm-Message-State: AC+VfDwrp70gOyranjjIObd2r0VvtN432aBmY2dCYMAIkwX5+eXxpmnJ
	Gj78tcOXOQ4wHL6rG+lWO0C8JMpEKgFQcG9xFxUe2kRsv4zO2UhugxWTjggO1S5+bygpsQDO/nL
	Z/HbBV+lfZKFTRjTSE8GoTmlEMq85
X-Received: by 2002:a19:6707:0:b0:4f9:570c:7b28 with SMTP id b7-20020a196707000000b004f9570c7b28mr8024950lfc.32.1687677571713;
        Sun, 25 Jun 2023 00:19:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6TgoGtKPYE2HSayNlGMZC/cfCWA138bcv26/89XSaCn7BDOGhY9nOX2R0SMVgiHTEoVQUlFSg/uM40fccKi2k=
X-Received: by 2002:a19:6707:0:b0:4f9:570c:7b28 with SMTP id
 b7-20020a196707000000b004f9570c7b28mr8024939lfc.32.1687677571423; Sun, 25 Jun
 2023 00:19:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com> <1687329734.4588535-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1687329734.4588535-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 25 Jun 2023 15:19:20 +0800
Message-ID: <CACGkMEvUM3JgcX72OFCQKuPT4M7a8Gtsd68_QMzBUJBg8=h2+A@mail.gmail.com>
Subject: Re: [PATCH vhost v10 00/10] virtio core prepares for AF_XDP
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 21, 2023 at 2:43=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Hi Jason,
>
> Do you have plan to review this?

Just came back from vacation, will do this next week.

Thanks

>
> Thanks.
>


