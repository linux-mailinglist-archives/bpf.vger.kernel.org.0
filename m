Return-Path: <bpf+bounces-10356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B967A5A04
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 08:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D72C1C209D4
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 06:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9EB34197;
	Tue, 19 Sep 2023 06:36:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB7321358;
	Tue, 19 Sep 2023 06:36:35 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7B2116;
	Mon, 18 Sep 2023 23:36:32 -0700 (PDT)
Date: Tue, 19 Sep 2023 08:36:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1695105390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HNsa/Hw2hv12CIG/NGD55HoGCgGxEaZUkdKrfsXvu1g=;
	b=pxYoStcD9nXSBKjhZyJFTiU43EhMnTCRvhy0RMW3OdtRgBtnqYe9bcWWEssQTu5rRcin3M
	IZAMjV0uwIasKti1+jAvXgq+VWhSbZ/QY6HXvPBcFh7JHLkH4ST2bj5THt62pGwqqYGc9w
	hA66hSWF9S9neqKofpvqzOadu91Z29/k4Ai0axJSWTmMEuxXwAEGtS5vUVZ8+EEwQTuA9M
	ap2ndy661fBe36n5ROxjB189cIwLFNAEfzs1AJv6DaS9notMDDq6YCNkuoZ1o5fvCMxQhp
	q7QD0fkrOanjJudM5UvRXOpVKJl0k2VEdw73cy8cbUSWAYpSvRLShLaitPrr2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1695105390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HNsa/Hw2hv12CIG/NGD55HoGCgGxEaZUkdKrfsXvu1g=;
	b=jDt0N2NTuBjduKl41IOkcIxWDUFBsvjCsEg2D2x/xvB7/PMipgwX4hSoHpqdvnL3PZL4xP
	8ACSy2WZ4xjN2oDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	hariprasad <hkelam@marvell.com>
Subject: Re: [PATCH net v2 3/3] octeontx2-pf: Do xdp_do_flush() after
 redirects.
Message-ID: <20230919063626.k604dEwL@linutronix.de>
References: <20230918153611.165722-1-bigeasy@linutronix.de>
 <20230918153611.165722-4-bigeasy@linutronix.de>
 <aa182e22-e7b9-d8e7-04ea-781fe0fb9103@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aa182e22-e7b9-d8e7-04ea-781fe0fb9103@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-09-18 10:58:39 [-0700], Kui-Feng Lee wrote:
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> > index e77d438489557..53b2a4ef52985 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> > @@ -1391,8 +1396,10 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
> >   		otx2_dma_unmap_page(pfvf, iova, pfvf->rbsize,
> >   				    DMA_FROM_DEVICE);
> > -		if (!err)
> > +		if (!err) {
> > +			*need_xdp_flush = true;
> 
> Is it possible to call xdp_do_flush() at the first place (here)?

It shouldn't be wrong. All drivers, except for cpsw, invoke
xdp_do_flush() after completing their NAPI loop and then flushing all
possible packets at once.

> >   			return true;
> > +		}
> >   		put_page(page);
> >   		break;
> >   	default:

Sebastian

