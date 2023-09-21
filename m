Return-Path: <bpf+bounces-10554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EEC7A9C50
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 21:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E79A28250D
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 19:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AC148EAB;
	Thu, 21 Sep 2023 17:49:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991AD29432
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 17:49:51 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FC9780F7
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 10:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695317582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1k8SHjrX7h+9geU6a4EfiZKaqOkQZE0r44U3ZFD7cFc=;
	b=Z1Ww4bUYpO3zvEPGHV1tMDwn00DOEFrl5ZU6fGpfq1JYneygAKTX7e1x28lVdSAPmiWhVr
	MU1d26adUOOv6d6IQerRq3eML58lqu8+oHTJEGZj00nOaUxayzJyhKAYjr9givpfJzNSOo
	+pBaTzcMe8F4TFoLetLowPoz/HgZh4Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-4NQ098haO9O244DpWWMfJw-1; Thu, 21 Sep 2023 03:01:20 -0400
X-MC-Unique: 4NQ098haO9O244DpWWMfJw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-405369a7ebfso493375e9.0
        for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 00:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695279679; x=1695884479;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1k8SHjrX7h+9geU6a4EfiZKaqOkQZE0r44U3ZFD7cFc=;
        b=HGIE1iOzAUBOkR2wbTbdBtc5hB/0DdL910tIR6ZkcdZhPiBGdDSJuH014c0OtYetYf
         DjtRjDjIwWfuQ9FcWWLXbZnoASuY3AfdIbViGJ/9wvB1Yuspx3298Y+uH2wLdo0J72DO
         MNfZWf53lhh5efp954Zs7CXXWyAniYLtmIzK7BSMOsBWwprH5cxijRKkX3gWsXh4iy84
         HaImitGhLtLiXSGSCviDTLRl2wUdBhbicDp1S/PsqvgsjvTQZudgUFZKx9mQcvT8MkbM
         TrdtiaEmQcrcWRP+RphxsR3+I9dS6b3TzTEnO6hY/wKj46p3t+AsygzEJsAXAIe67lCP
         VUwA==
X-Gm-Message-State: AOJu0Yx4vpeEdPIsoJdQiPFteELTFuWv60u3JHa2LRpG6qSsUo5xUZvb
	PVXW1fSnUWMnEPpfvt0FuFZD6y/DgV8aJLD1bZcu++2hn99MibtLtB2o/hYOTfH5Y54sUrMH0Iy
	hNbLxpRuIfw0s
X-Received: by 2002:adf:f2c3:0:b0:320:8f0:b93d with SMTP id d3-20020adff2c3000000b0032008f0b93dmr4009692wrp.3.1695279678803;
        Thu, 21 Sep 2023 00:01:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlabPQ9ETJCqjwqd2LwoQEltmhfS/JafI5C64mu6pBljNOcNJ7n71e438DM+Z//+Per1W11g==
X-Received: by 2002:adf:f2c3:0:b0:320:8f0:b93d with SMTP id d3-20020adff2c3000000b0032008f0b93dmr4009661wrp.3.1695279678370;
        Thu, 21 Sep 2023 00:01:18 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-251-4.dyn.eolo.it. [146.241.251.4])
        by smtp.gmail.com with ESMTPSA id t21-20020a170906179500b00988e953a586sm588033eje.61.2023.09.21.00.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 00:01:18 -0700 (PDT)
Message-ID: <f5832f155f3daff50b0e7ea94fee84d3a70e4f29.camel@redhat.com>
Subject: Re: [PATCH net v2 3/3] octeontx2-pf: Do xdp_do_flush() after
 redirects.
From: Paolo Abeni <pabeni@redhat.com>
To: Kui-Feng Lee <sinquersw@gmail.com>, Sebastian Andrzej Siewior
	 <bigeasy@linutronix.de>, netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,  Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Thomas
 Gleixner <tglx@linutronix.de>, Geetha sowjanya <gakula@marvell.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>, Sunil Goutham
 <sgoutham@marvell.com>, hariprasad <hkelam@marvell.com>
Date: Thu, 21 Sep 2023 09:01:16 +0200
In-Reply-To: <aa182e22-e7b9-d8e7-04ea-781fe0fb9103@gmail.com>
References: <20230918153611.165722-1-bigeasy@linutronix.de>
	 <20230918153611.165722-4-bigeasy@linutronix.de>
	 <aa182e22-e7b9-d8e7-04ea-781fe0fb9103@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-09-18 at 10:58 -0700, Kui-Feng Lee wrote:
>=20
> On 9/18/23 08:36, Sebastian Andrzej Siewior wrote:
> > xdp_do_flush() should be invoked before leaving the NAPI poll function
> > if XDP-redirect has been performed.
> >=20
> > Invoke xdp_do_flush() before leaving NAPI.
> >=20
> > Cc: Geetha sowjanya <gakula@marvell.com>
> > Cc: Subbaraya Sundeep <sbhatta@marvell.com>
> > Cc: Sunil Goutham <sgoutham@marvell.com>
> > Cc: hariprasad <hkelam@marvell.com>
> > Fixes: 06059a1a9a4a5 ("octeontx2-pf: Add XDP support to netdev PF")
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Acked-by: Geethasowjanya Akula <gakula@marvell.com>
> > ---
> >   .../marvell/octeontx2/nic/otx2_txrx.c         | 19 +++++++++++++-----=
-
> >   1 file changed, 13 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/d=
rivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> > index e77d438489557..53b2a4ef52985 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> > @@ -29,7 +29,8 @@
> >   static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
> >   				     struct bpf_prog *prog,
> >   				     struct nix_cqe_rx_s *cqe,
> > -				     struct otx2_cq_queue *cq);
> > +				     struct otx2_cq_queue *cq,
> > +				     bool *need_xdp_flush);
> >  =20
> >   static int otx2_nix_cq_op_status(struct otx2_nic *pfvf,
> >   				 struct otx2_cq_queue *cq)
> > @@ -337,7 +338,7 @@ static bool otx2_check_rcv_errors(struct otx2_nic *=
pfvf,
> >   static void otx2_rcv_pkt_handler(struct otx2_nic *pfvf,
> >   				 struct napi_struct *napi,
> >   				 struct otx2_cq_queue *cq,
> > -				 struct nix_cqe_rx_s *cqe)
> > +				 struct nix_cqe_rx_s *cqe, bool *need_xdp_flush)
> >   {
> >   	struct nix_rx_parse_s *parse =3D &cqe->parse;
> >   	struct nix_rx_sg_s *sg =3D &cqe->sg;
> > @@ -353,7 +354,7 @@ static void otx2_rcv_pkt_handler(struct otx2_nic *p=
fvf,
> >   	}
> >  =20
> >   	if (pfvf->xdp_prog)
> > -		if (otx2_xdp_rcv_pkt_handler(pfvf, pfvf->xdp_prog, cqe, cq))
> > +		if (otx2_xdp_rcv_pkt_handler(pfvf, pfvf->xdp_prog, cqe, cq, need_xdp=
_flush))
> >   			return;
> >  =20
> >   	skb =3D napi_get_frags(napi);
> > @@ -388,6 +389,7 @@ static int otx2_rx_napi_handler(struct otx2_nic *pf=
vf,
> >   				struct napi_struct *napi,
> >   				struct otx2_cq_queue *cq, int budget)
> >   {
> > +	bool need_xdp_flush =3D false;
> >   	struct nix_cqe_rx_s *cqe;
> >   	int processed_cqe =3D 0;
> >  =20
> > @@ -409,13 +411,15 @@ static int otx2_rx_napi_handler(struct otx2_nic *=
pfvf,
> >   		cq->cq_head++;
> >   		cq->cq_head &=3D (cq->cqe_cnt - 1);
> >  =20
> > -		otx2_rcv_pkt_handler(pfvf, napi, cq, cqe);
> > +		otx2_rcv_pkt_handler(pfvf, napi, cq, cqe, &need_xdp_flush);
> >  =20
> >   		cqe->hdr.cqe_type =3D NIX_XQE_TYPE_INVALID;
> >   		cqe->sg.seg_addr =3D 0x00;
> >   		processed_cqe++;
> >   		cq->pend_cqe--;
> >   	}
> > +	if (need_xdp_flush)
> > +		xdp_do_flush();
> >  =20
> >   	/* Free CQEs to HW */
> >   	otx2_write64(pfvf, NIX_LF_CQ_OP_DOOR,
> > @@ -1354,7 +1358,8 @@ bool otx2_xdp_sq_append_pkt(struct otx2_nic *pfvf=
, u64 iova, int len, u16 qidx)
> >   static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
> >   				     struct bpf_prog *prog,
> >   				     struct nix_cqe_rx_s *cqe,
> > -				     struct otx2_cq_queue *cq)
> > +				     struct otx2_cq_queue *cq,
> > +				     bool *need_xdp_flush)
> >   {
> >   	unsigned char *hard_start, *data;
> >   	int qidx =3D cq->cq_idx;
> > @@ -1391,8 +1396,10 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2=
_nic *pfvf,
> >  =20
> >   		otx2_dma_unmap_page(pfvf, iova, pfvf->rbsize,
> >   				    DMA_FROM_DEVICE);
> > -		if (!err)
> > +		if (!err) {
> > +			*need_xdp_flush =3D true;
>=20
> Is it possible to call xdp_do_flush() at the first place (here)?

AFAICT that would kill much/all of the performance benefits of bulk
redirect.

I think the proposed solution is a better one.

Cheers,

Paolo


