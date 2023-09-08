Return-Path: <bpf+bounces-9548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F8A798E3C
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 20:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA9D1281DCC
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 18:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B9014F73;
	Fri,  8 Sep 2023 18:20:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3655171A2
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 18:20:21 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0803D3A97
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 11:20:01 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68e26165676so2510563b3a.0
        for <bpf@vger.kernel.org>; Fri, 08 Sep 2023 11:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1694197133; x=1694801933; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9DIksM6myeoWeDBcpXYOMBk+NYMmdWPc+5HOrctp+9s=;
        b=cQPXp1mI5865RqEsYQSRQnbMWBiiStN4A6SkaGlxc4NIeF2t7LEAgCMeUfJHqeZoBB
         CnHObcP4Ukr48Sb80NpKI4VbLnme5u4d1giaKMomMha/0NKTnwYSJ+Evz9SdqP0xAylv
         eyFATxMoXFz93RqQrUdo6JAVhCnyyKum/mUtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694197133; x=1694801933;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9DIksM6myeoWeDBcpXYOMBk+NYMmdWPc+5HOrctp+9s=;
        b=jzvPRFbPHNOhu2DI+EWxgVMaT2KV650vHS9VeAdf2mRsgMKfDtTu9P+KV+wMyVjbKP
         7T9OceuICr/QZczgUMWvToM5UhGnc/nC+752qryh91ly9o3Rn2HiOVgjj4btM50nolee
         o9gfWFELdYXb85rjNCet24LfHGJvsIcKW1aBLle7iFjSnzvGjehKWOj7BewXNrVGnZ19
         iACDzBx/o0RAC4bqics4uGKuXSyyOi0bx7ZPj2gK7DQ/j3APwfxV0ifXzaMCdrvLcsFs
         6ImC+Wjd3ocxtWoM/1wkrc5uB8CNTgoz9T2ZzgA2XQwf2hSnXl57ys8bZI6jWk6ebfrt
         zlSw==
X-Gm-Message-State: AOJu0YxCcXLYp8/GnZIvl4IcZWgl7sMb4XUQrYc+PsivTtXFgRXnEXvs
	NNHaO/fzq/LI8d25qi6vNh04AA==
X-Google-Smtp-Source: AGHT+IEL011BEfLSNoZ0VWbsnUu9K98As3uc78Y5lkcy50J2yjnTrkBn7oLeFhQDR9RIQZU4AK+E0w==
X-Received: by 2002:a05:6a20:7d9b:b0:13e:debc:3657 with SMTP id v27-20020a056a207d9b00b0013edebc3657mr3555227pzj.30.1694197133598;
        Fri, 08 Sep 2023 11:18:53 -0700 (PDT)
Received: from C02YVCJELVCG.dhcp.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id w25-20020a63af19000000b00563da87a52dsm1470280pge.40.2023.09.08.11.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 11:18:53 -0700 (PDT)
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
X-Google-Original-From: Andy Gospodarek <gospo@broadcom.com>
Date: Fri, 8 Sep 2023 14:18:45 -0400
To: Michael Chan <michael.chan@broadcom.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH net 2/4] bnxt_en: Flush XDP for bnxt_poll_nitroa0()'s NAPI
Message-ID: <ZPtlhSywT5cBTj8u@C02YVCJELVCG.dhcp.broadcom.net>
References: <20230908135748.794163-1-bigeasy@linutronix.de>
 <20230908135748.794163-3-bigeasy@linutronix.de>
 <CALs4sv2=ox6ZWj3FUY=0-Zj3uNAOpCLM_vf_dmsVx+ju2S9UUA@mail.gmail.com>
 <CACKFLin+1whPs0qeM5xBb1yXx8FkFS_vGrW6PaGy41_XVH=SGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLin+1whPs0qeM5xBb1yXx8FkFS_vGrW6PaGy41_XVH=SGg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 08, 2023 at 10:57:13AM -0700, Michael Chan wrote:
> On Fri, Sep 8, 2023 at 9:30 AM Pavan Chebbi <pavan.chebbi@broadcom.com> wrote:
> >
> > On Fri, Sep 8, 2023 at 7:29 PM Sebastian Andrzej Siewior
> > <bigeasy@linutronix.de> wrote:
> > >
> > > bnxt_poll_nitroa0() invokes bnxt_rx_pkt() which can run a XDP program
> > > which in turn can return XDP_REDIRECT. bnxt_rx_pkt() is also used by
> > > __bnxt_poll_work() which flushes (xdp_do_flush()) the packets after each
> > > round. bnxt_poll_nitroa0() lacks this feature.
> > > xdp_do_flush() should be invoked before leaving the NAPI callback.
> > >
> > > Invoke xdp_do_flush() after a redirect in bnxt_poll_nitroa0() NAPI.
> > >
> > > Cc: Michael Chan <michael.chan@broadcom.com>
> > > Fixes: f18c2b77b2e4e ("bnxt_en: optimized XDP_REDIRECT support")
> > > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > ---
> > >  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > > index 5cc0dbe121327..7551aa8068f8f 100644
> > > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > > @@ -2614,6 +2614,7 @@ static int bnxt_poll_nitroa0(struct napi_struct *napi, int budget)
> > >         struct rx_cmp_ext *rxcmp1;
> > >         u32 cp_cons, tmp_raw_cons;
> > >         u32 raw_cons = cpr->cp_raw_cons;
> > > +       bool flush_xdp = false;
> >
> > Michael can confirm but I don't think we need this additional variable.
> > Since the event is always ORed, we could directly check if (event &
> > BNXT_REDIRECT_EVENT) just like is done in __bnxt_poll_work().
> 
> If we have a mix of XDP_TX and XDP_REDIRECT during NAPI, event can be
> cleared by XDP_TX.  So this patch looks correct to me because of that.

Agreed

> Or we can make it consistent with __bnxt_poll_work() and assume that
> XDP_TX won't mix with XDP_REDIRECT.

Unfortunately we probably cannot guarantee that or maybe more to point
we do not want to guarantee that.

Thanks for this patch.

Reviewed-by: Andy Gospodarek <gospo@broadcom.com>


> Handling a mix of XDP actions needs to be looked at separately.  The
> driver currently won't work well when that happens.  I am working on
> an internal patch to address that and will post it when it's ready.
> Thanks.
> 
> >
> > >         u32 rx_pkts = 0;
> > >         u8 event = 0;
> > >
> > > @@ -2648,6 +2649,8 @@ static int bnxt_poll_nitroa0(struct napi_struct *napi, int budget)
> > >                                 rx_pkts++;
> > >                         else if (rc == -EBUSY)  /* partial completion */
> > >                                 break;
> > > +                       if (event & BNXT_REDIRECT_EVENT)
> > > +                               flush_xdp = true;
> > >                 } else if (unlikely(TX_CMP_TYPE(txcmp) ==
> > >                                     CMPL_BASE_TYPE_HWRM_DONE)) {
> > >                         bnxt_hwrm_handler(bp, txcmp);
> > > @@ -2667,6 +2670,8 @@ static int bnxt_poll_nitroa0(struct napi_struct *napi, int budget)
> > >
> > >         if (event & BNXT_AGG_EVENT)
> > >                 bnxt_db_write(bp, &rxr->rx_agg_db, rxr->rx_agg_prod);
> > > +       if (flush_xdp)
> > > +               xdp_do_flush();
> > >
> > >         if (!bnxt_has_work(bp, cpr) && rx_pkts < budget) {
> > >                 napi_complete_done(napi, rx_pkts);
> > > --
> > > 2.40.1
> > >
> > >



