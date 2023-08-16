Return-Path: <bpf+bounces-7865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E201177D878
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 04:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C28A91C20F2E
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 02:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DFB17D9;
	Wed, 16 Aug 2023 02:33:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB89C2E9
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 02:33:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748CD1BE6
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 19:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692153228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VNW1zQdlSA+EBMwsqEGzK2TiH2hiDgSEYVGqzy81FKw=;
	b=ivfv7coNyr6G+K3BeKepxNRJ84eDyBcx4Vcwp8fvdAPFGUcQfluj/pnOVX80BilVvAn3lQ
	16jeI9TZUF6hpWv5/5tL/i8HawOKrWFcS0Qv/Oo/3nnv4AiZEUntgi0jQCx2SQza/aHJwJ
	SqMVHQdS/khQ9Vd5RFF4fhpWrPphWYU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-nlPkqR0hMye2InOePnjxxg-1; Tue, 15 Aug 2023 22:33:47 -0400
X-MC-Unique: nlPkqR0hMye2InOePnjxxg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b6ff15946fso63930031fa.2
        for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 19:33:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692153226; x=1692758026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VNW1zQdlSA+EBMwsqEGzK2TiH2hiDgSEYVGqzy81FKw=;
        b=EkrT9R/qtX0DdkYT3DcYY0ezxewW5uDfin/oE0O8wDVhOHj7PcXaKgk+WgTpZTk/jA
         gsQomcKRzQhhl8ZT9+lX+tlOdtewm6RO8azMJNRGV6+YWah5echZcOK4DF7RUvZce/Pq
         ySUEj1rWMGad1k19avia6HXdFPFZ+0szc+61OK6aghgbah5KLlKsgilfiIGrv7xIZssT
         jjJoWSpRXtMQ/6a6COlYSyx6rt204leMDq7kIoaK9kV22a3hFlpPVREnVeebzB3p/32r
         CO9+N/AhituC2W9sUImdfya0M7UZrQUYCwVm4l3yoR00OgJai415RlvrleTM9I32JM2T
         5LOA==
X-Gm-Message-State: AOJu0YxXROh0U7HjW/OAjFio3tYnYyajsnMlz0XTR842nQcZZkYgjcUQ
	wQv+36wlSlSCv4F0ufVAXHDDz8PbhNQ7hJwP9xJXDHB6v9Vfrxb3jlAYy6d5zadluGoJ4tNggRS
	EfIKJaVxVGzgktg24+xonTJIMpCw/
X-Received: by 2002:a2e:87d4:0:b0:2b9:cd3d:4136 with SMTP id v20-20020a2e87d4000000b002b9cd3d4136mr426227ljj.2.1692153225915;
        Tue, 15 Aug 2023 19:33:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuqvZAnE6ML8oI2NAwZU1V3nFQiHWJ1QHjUqgo9pCf+uRWTz3qikCM4YBJ7Mh6JT7RKQu36d2mSMT50bmGwcU=
X-Received: by 2002:a2e:87d4:0:b0:2b9:cd3d:4136 with SMTP id
 v20-20020a2e87d4000000b002b9cd3d4136mr426215ljj.2.1692153225633; Tue, 15 Aug
 2023 19:33:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
 <20230810123057.43407-6-xuanzhuo@linux.alibaba.com> <CACGkMEsaYbsWyOKxA-xY=3dSmvzq9pMdYbypG9q+Ry2sMwAMPg@mail.gmail.com>
 <1692081029.4299796-8-xuanzhuo@linux.alibaba.com> <CACGkMEt5RyOy_6rTXon_7py=ZmdJD=e4dMOGpNOo3NOyahGvjg@mail.gmail.com>
 <1692091669.428807-1-xuanzhuo@linux.alibaba.com> <CACGkMEsnW-+fqcxu6E-cbAtMduE_n82fu+RA162fX5gr=Ckf5A@mail.gmail.com>
 <1692151724.9150448-1-xuanzhuo@linux.alibaba.com> <CACGkMEt7LSTY-TRcSD75vYcv0AkH2a5otVXga7VGRLu7JQT_dA@mail.gmail.com>
 <1692152487.9422052-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1692152487.9422052-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 16 Aug 2023 10:33:34 +0800
Message-ID: <CACGkMEvnVy+p8+Nro6v7Yr-m_N07200skcqwz-pCr5==sn68BQ@mail.gmail.com>
Subject: Re: [PATCH vhost v13 05/12] virtio_ring: introduce virtqueue_dma_dev()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 16, 2023 at 10:24=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> On Wed, 16 Aug 2023 10:19:34 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Wed, Aug 16, 2023 at 10:16=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alib=
aba.com> wrote:
> > >
> > > On Wed, 16 Aug 2023 09:13:48 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Tue, Aug 15, 2023 at 5:40=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > >
> > > > > On Tue, 15 Aug 2023 15:50:23 +0800, Jason Wang <jasowang@redhat.c=
om> wrote:
> > > > > > On Tue, Aug 15, 2023 at 2:32=E2=80=AFPM Xuan Zhuo <xuanzhuo@lin=
ux.alibaba.com> wrote:
> > > > > > >
> > > > > > >
> > > > > > > Hi, Jason
> > > > > > >
> > > > > > > Could you skip this patch?
> > > > > >
> > > > > > I'm fine with either merging or dropping this.
> > > > > >
> > > > > > >
> > > > > > > Let we review other patches firstly?
> > > > > >
> > > > > > I will be on vacation soon, and won't have time to do this unti=
l next week.
> > > > >
> > > > > Have a happly vacation.
> > > > >
> > > > > >
> > > > > > But I spot two possible "issues":
> > > > > >
> > > > > > 1) the DMA metadata were stored in the headroom of the page, th=
is
> > > > > > breaks frags coalescing, we need to benchmark it's impact
> > > > >
> > > > > Not every page, just the first page of the COMP pages.
> > > > >
> > > > > So I think there is no impact.
> > > >
> > > > Nope, see this:
> > > >
> > > >         if (SKB_FRAG_PAGE_ORDER &&
> > > >             !static_branch_unlikely(&net_high_order_alloc_disable_k=
ey)) {
> > > >                 /* Avoid direct reclaim but allow kswapd to wake */
> > > >                 pfrag->page =3D alloc_pages((gfp & ~__GFP_DIRECT_RE=
CLAIM) |
> > > >                                           __GFP_COMP | __GFP_NOWARN=
 |
> > > >                                           __GFP_NORETRY,
> > > >                                           SKB_FRAG_PAGE_ORDER);
> > > >                 if (likely(pfrag->page)) {
> > > >                         pfrag->size =3D PAGE_SIZE << SKB_FRAG_PAGE_=
ORDER;
> > > >                         return true;
> > > >                 }
> > > >         }
> > > >
> > > > The comp page might be disabled due to the SKB_FRAG_PAGE_ORDER and
> > > > net_high_order_alloc_disable_key.
> > >
> > >
> > > YES.
> > >
> > > But if comp page is disabled. Then we only get one page each time. Th=
e pages are
> > > not contiguous, so we don't have frags coalescing.
> > >
> > > If you mean the two pages got from alloc_page may be contiguous. The =
coalescing
> > > may then be broken. It's a possibility, but I think the impact will b=
e small.
> >
> > Let's have a simple benchmark and see?
>
>
> That is ok.
>
> I think you want to know the perf num with big traffic and the comp page
> disabled.

Yes.

Thanks

>
> Thanks.
>
>
> >
> > Thanks
> >
> > >
> > > Thanks.
> > >
> > >
> > > >
> > > > >
> > > > >
> > > > > > 2) pre mapped DMA addresses were not reused in the case of XDP_=
TX/XDP_REDIRECT
> > > > >
> > > > > Because that the tx is not the premapped mode.
> > > >
> > > > Yes, we can optimize this on top.
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > Thanks.
> > > > >
> > > > > >
> > > > > > I see Michael has merge this series so I'm fine to let it go fi=
rst.
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > >
> > > > > > > Thanks.
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> >
>


