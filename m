Return-Path: <bpf+bounces-43312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B24FE9B3596
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 17:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BB98B22536
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 16:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370A8188917;
	Mon, 28 Oct 2024 16:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="BUmNu/bb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5D7190664
	for <bpf@vger.kernel.org>; Mon, 28 Oct 2024 16:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131214; cv=none; b=atNYccFXhFtOB5M5takNGmx/4WL//kujyEIKIALjGCO1LNv22WaZkGb/TpkXkfkHpdMxY+etVuNbjRZ1BWQKyrkasCtk2MWAOZLFtBB06JuMLl4KZZyjBbYn55od+mOIHsDOuarqy6h2A5u2MBJdFq6aX1XhGRHsA8fXSAF4TE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131214; c=relaxed/simple;
	bh=QwqP83XAo0YkUbSfEzrELiJ8ZX+2xyOAx3UUWG3XHak=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MebyKjtMDZUT34WQlai4l9clRce0smdkufc8ZSn3IQgTIv5OkhlZxKPIGNMd+0sffacLrkp8YH3Y0bchslzdySI/m1++BGXQEzIT+PPBeJl1VDHgj5OtYM8D/RYU8D3THGdD+TSxnv1k/Ee05bhoBpjmPvnC0acxV0SBWkvLLBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=BUmNu/bb; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c77459558so36667735ad.0
        for <bpf@vger.kernel.org>; Mon, 28 Oct 2024 09:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730131211; x=1730736011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=haqq1qNw0QZXGAInx6qkNQxtQ4BitayuB9tS5HSqd6o=;
        b=BUmNu/bb3FupS5FgGSzX93zIxKmXcZl5TkUK4js9qFHX52ZRxqqOW2za59AsSVc7lm
         1cTC2T0ZLi7o+tK/o5C81E1vBxEyKKx9tHPKJPtrXwd6GOZKG4y63bHsgechp8doBAQR
         PwNEqTllFaURkup++78K+8m2x006v3a7vff30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730131211; x=1730736011;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=haqq1qNw0QZXGAInx6qkNQxtQ4BitayuB9tS5HSqd6o=;
        b=KBDahbB1cpT6M0KHGp7Id+eA90gijn1fryMKWwlQaRgQpma2yOKHE0smBDJJh6+qmH
         C+1sidcxeDF7lUCgxCX83dCPBNvNkFP2BcqCFA6SHkV1fzH60q5xWStFvF7Ip58nLeXj
         wi3LLleMlVTH0ehCt9Cs92iZpkwjB+Q3Imt9WInIi8wAee/kKbwnlSElcvAtF4nVT4Ln
         4IE1gnXsEHneNUs/JRf2AU+a+YLx0T85y04mVFVpzhZqNXCzEQ+FPU9HfLpJwdpUG3jH
         l9mblmXteI/rsWokgHHlqfrMyPBOwyEAJUdohDg+7PMZvrN1xQv5kWO3X9KhHo7AuwLT
         D9fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEuuidI4XkzYB3cbiwh7cv9J+XAcZF6QFcJE85dj2Wd8SY9tFtx4RDjso9JBsvzLhlOBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/TxMyMVjhF0r9Lg33mbmC/uoOp45+uiGqGJoC4LYRHUVDUPqa
	tc29elJnbaepZm8EKXFRI0RaLzUFGt6SEVYJzp5I6C5SLGzwKr9NWtv4IVSCuYo=
X-Google-Smtp-Source: AGHT+IF9MGeNuqga+/weHL5uzr367LPHam5w/xQkq4qZWyfTUkcZfzU+GWfOJyg15RswH1RPZtBi6A==
X-Received: by 2002:a17:903:2449:b0:20c:d578:d712 with SMTP id d9443c01a7336-210c6ce56acmr139563655ad.59.1730131211059;
        Mon, 28 Oct 2024 09:00:11 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf4332fsm52282025ad.16.2024.10.28.09.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 09:00:10 -0700 (PDT)
Date: Mon, 28 Oct 2024 09:00:06 -0700
From: Joe Damato <jdamato@fastly.com>
To: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>,
	"kurt@linutronix.de" <kurt@linutronix.de>,
	"Gomes, Vinicius" <vinicius.gomes@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>,
	stanislaw.gruszka@linux.intel.com
Subject: Re: [Intel-wired-lan] [iwl-next v4 2/2] igc: Link queues to NAPI
 instances
Message-ID: <Zx-1BhZlXRQCImex@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	"Lifshits, Vitaly" <vitaly.lifshits@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>,
	"kurt@linutronix.de" <kurt@linutronix.de>,
	"Gomes, Vinicius" <vinicius.gomes@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>,
	stanislaw.gruszka@linux.intel.com
References: <20241022215246.307821-1-jdamato@fastly.com>
 <20241022215246.307821-3-jdamato@fastly.com>
 <d7799132-7e4a-0ac2-cbda-c919ce434fe2@intel.com>
 <Zx-yzhq4unv0gsVX@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zx-yzhq4unv0gsVX@LQ3V64L9R2>

On Mon, Oct 28, 2024 at 08:50:38AM -0700, Joe Damato wrote:
> On Sun, Oct 27, 2024 at 11:49:33AM +0200, Lifshits, Vitaly wrote:
> > 
> > On 10/23/2024 12:52 AM, Joe Damato wrote:
> > > Link queues to NAPI instances via netdev-genl API so that users can
> > > query this information with netlink. Handle a few cases in the driver:
> > >    1. Link/unlink the NAPIs when XDP is enabled/disabled
> > >    2. Handle IGC_FLAG_QUEUE_PAIRS enabled and disabled
> > > 
> > > Example output when IGC_FLAG_QUEUE_PAIRS is enabled:
> > > 
> > > $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
> > >                           --dump queue-get --json='{"ifindex": 2}'
> > > 
> > > [{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
> > >   {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
> > >   {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'rx'},
> > >   {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'rx'},
> > >   {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'tx'},
> > >   {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'tx'},
> > >   {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'tx'},
> > >   {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'tx'}]
> > > 
> > > Since IGC_FLAG_QUEUE_PAIRS is enabled, you'll note that the same NAPI ID
> > > is present for both rx and tx queues at the same index, for example
> > > index 0:
> > > 
> > > {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
> > > {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'tx'},
> > > 
> > > To test IGC_FLAG_QUEUE_PAIRS disabled, a test system was booted using
> > > the grub command line option "maxcpus=2" to force
> > > igc_set_interrupt_capability to disable IGC_FLAG_QUEUE_PAIRS.
> > > 
> > > Example output when IGC_FLAG_QUEUE_PAIRS is disabled:
> > > 
> > > $ lscpu | grep "On-line CPU"
> > > On-line CPU(s) list:      0,2
> > > 
> > > $ ethtool -l enp86s0  | tail -5
> > > Current hardware settings:
> > > RX:		n/a
> > > TX:		n/a
> > > Other:		1
> > > Combined:	2
> > > 
> > > $ cat /proc/interrupts  | grep enp
> > >   144: [...] enp86s0
> > >   145: [...] enp86s0-rx-0
> > >   146: [...] enp86s0-rx-1
> > >   147: [...] enp86s0-tx-0
> > >   148: [...] enp86s0-tx-1
> > > 
> > > 1 "other" IRQ, and 2 IRQs for each of RX and Tx, so we expect netlink to
> > > report 4 IRQs with unique NAPI IDs:
> > > 
> > > $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
> > >                           --dump napi-get --json='{"ifindex": 2}'
> > > [{'id': 8196, 'ifindex': 2, 'irq': 148},
> > >   {'id': 8195, 'ifindex': 2, 'irq': 147},
> > >   {'id': 8194, 'ifindex': 2, 'irq': 146},
> > >   {'id': 8193, 'ifindex': 2, 'irq': 145}]
> > > 
> > > Now we examine which queues these NAPIs are associated with, expecting
> > > that since IGC_FLAG_QUEUE_PAIRS is disabled each RX and TX queue will
> > > have its own NAPI instance:
> > > 
> > > $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
> > >                           --dump queue-get --json='{"ifindex": 2}'
> > > [{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
> > >   {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
> > >   {'id': 0, 'ifindex': 2, 'napi-id': 8195, 'type': 'tx'},
> > >   {'id': 1, 'ifindex': 2, 'napi-id': 8196, 'type': 'tx'}]
> > > 
> > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > > Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> > > ---
> > >   v4:
> > >     - Add rtnl_lock/rtnl_unlock in two paths: igc_resume and
> > >       igc_io_error_detected. The code added to the latter is inspired by
> > >       a similar implementation in ixgbe's ixgbe_io_error_detected.
> > > 
> > >   v3:
> > >     - Replace igc_unset_queue_napi with igc_set_queue_napi(adapater, i,
> > >       NULL), as suggested by Vinicius Costa Gomes
> > >     - Simplify implemention of igc_set_queue_napi as suggested by Kurt
> > >       Kanzenbach, with a tweak to use ring->queue_index
> > > 
> > >   v2:
> > >     - Update commit message to include tests for IGC_FLAG_QUEUE_PAIRS
> > >       disabled
> > >     - Refactored code to move napi queue mapping and unmapping to helper
> > >       functions igc_set_queue_napi and igc_unset_queue_napi
> > >     - Adjust the code to handle IGC_FLAG_QUEUE_PAIRS disabled
> > >     - Call helpers to map/unmap queues to NAPIs in igc_up, __igc_open,
> > >       igc_xdp_enable_pool, and igc_xdp_disable_pool
> > > 
> > >   drivers/net/ethernet/intel/igc/igc.h      |  2 ++
> > >   drivers/net/ethernet/intel/igc/igc_main.c | 41 ++++++++++++++++++++---
> > >   drivers/net/ethernet/intel/igc/igc_xdp.c  |  2 ++
> > >   3 files changed, 40 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
> > > index eac0f966e0e4..b8111ad9a9a8 100644
> > > --- a/drivers/net/ethernet/intel/igc/igc.h
> > > +++ b/drivers/net/ethernet/intel/igc/igc.h
> > > @@ -337,6 +337,8 @@ struct igc_adapter {
> > >   	struct igc_led_classdev *leds;
> > >   };
> > > +void igc_set_queue_napi(struct igc_adapter *adapter, int q_idx,
> > > +			struct napi_struct *napi);
> > >   void igc_up(struct igc_adapter *adapter);
> > >   void igc_down(struct igc_adapter *adapter);
> > >   int igc_open(struct net_device *netdev);
> > > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> > > index 7964bbedb16c..04aa216ef612 100644
> > > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > > @@ -4948,6 +4948,22 @@ static int igc_sw_init(struct igc_adapter *adapter)
> > >   	return 0;
> > >   }
> > > +void igc_set_queue_napi(struct igc_adapter *adapter, int vector,
> > > +			struct napi_struct *napi)
> > > +{
> > > +	struct igc_q_vector *q_vector = adapter->q_vector[vector];
> > > +
> > > +	if (q_vector->rx.ring)
> > > +		netif_queue_set_napi(adapter->netdev,
> > > +				     q_vector->rx.ring->queue_index,
> > > +				     NETDEV_QUEUE_TYPE_RX, napi);
> > > +
> > > +	if (q_vector->tx.ring)
> > > +		netif_queue_set_napi(adapter->netdev,
> > > +				     q_vector->tx.ring->queue_index,
> > > +				     NETDEV_QUEUE_TYPE_TX, napi);
> > > +}
> > > +
> > >   /**
> > >    * igc_up - Open the interface and prepare it to handle traffic
> > >    * @adapter: board private structure
> > > @@ -4955,6 +4971,7 @@ static int igc_sw_init(struct igc_adapter *adapter)
> > >   void igc_up(struct igc_adapter *adapter)
> > >   {
> > >   	struct igc_hw *hw = &adapter->hw;
> > > +	struct napi_struct *napi;
> > >   	int i = 0;
> > >   	/* hardware has been reset, we need to reload some things */
> > > @@ -4962,8 +4979,11 @@ void igc_up(struct igc_adapter *adapter)
> > >   	clear_bit(__IGC_DOWN, &adapter->state);
> > > -	for (i = 0; i < adapter->num_q_vectors; i++)
> > > -		napi_enable(&adapter->q_vector[i]->napi);
> > > +	for (i = 0; i < adapter->num_q_vectors; i++) {
> > > +		napi = &adapter->q_vector[i]->napi;
> > > +		napi_enable(napi);
> > > +		igc_set_queue_napi(adapter, i, napi);
> > > +	}
> > >   	if (adapter->msix_entries)
> > >   		igc_configure_msix(adapter);
> > > @@ -5192,6 +5212,7 @@ void igc_down(struct igc_adapter *adapter)
> > >   	for (i = 0; i < adapter->num_q_vectors; i++) {
> > >   		if (adapter->q_vector[i]) {
> > >   			napi_synchronize(&adapter->q_vector[i]->napi);
> > > +			igc_set_queue_napi(adapter, i, NULL);
> > >   			napi_disable(&adapter->q_vector[i]->napi);
> > >   		}
> > >   	}
> > > @@ -6021,6 +6042,7 @@ static int __igc_open(struct net_device *netdev, bool resuming)
> > >   	struct igc_adapter *adapter = netdev_priv(netdev);
> > >   	struct pci_dev *pdev = adapter->pdev;
> > >   	struct igc_hw *hw = &adapter->hw;
> > > +	struct napi_struct *napi;
> > >   	int err = 0;
> > >   	int i = 0;
> > > @@ -6056,8 +6078,11 @@ static int __igc_open(struct net_device *netdev, bool resuming)
> > >   	clear_bit(__IGC_DOWN, &adapter->state);
> > > -	for (i = 0; i < adapter->num_q_vectors; i++)
> > > -		napi_enable(&adapter->q_vector[i]->napi);
> > > +	for (i = 0; i < adapter->num_q_vectors; i++) {
> > > +		napi = &adapter->q_vector[i]->napi;
> > > +		napi_enable(napi);
> > > +		igc_set_queue_napi(adapter, i, napi);
> > > +	}
> > >   	/* Clear any pending interrupts. */
> > >   	rd32(IGC_ICR);
> > > @@ -7385,7 +7410,9 @@ static int igc_resume(struct device *dev)
> > >   	wr32(IGC_WUS, ~0);
> > >   	if (netif_running(netdev)) {
> > > +		rtnl_lock();
> > 
> > This change will bring back the deadlock issue that was fixed in commit:
> > 6f31d6b: "igc: Refactor runtime power management flow".
> 
> OK, thanks for letting me know.
> 
> I think I better understand what the issue is. It seems that:
> 
> - igc_resume can be called with rtnl held via ethtool (which I
>   didn't know), which calls __igc_open
> - __igc_open re-enables NAPIs and re-links queues to NAPI IDs (which
>   requires rtnl)
> 
> so, it seems like the rtnl_lock() I've added to igc_resume is
> unnecessary.
> 
> I suppose I don't know all of the paths where the pm functions can
> be called -- are there others where RTNL is _not_ already held?
> 
> I looked at e1000e and it seems that driver does not re-enable NAPIs
> in its resume path and thus does not suffer from the same issue as
> igc.
> 
> So my questions are:
> 
>   1. Are there are other contexts where igc_resume is called where
>      RTNL is not held?
> 
>   2. If the answer is that RTNL is always held when igc_resume is
>      called, then I can send a v5 that removes the
>      rtnl_lock/rtnl_unlock. What do you think?

I see, so it looks like there is:
   - resume
   - runtime_resume

The bug I am reintroducing is runtime_resume already holding RTNL
before my added call to rtnl_lock.

OK.

Does resume also hold rtnl before the driver's igc_resume is called?
I am asking because I don't know much about how PM works.

If resume does not hold RTNL (but runtime resume does, as the bug
you pointed out shows), it seems like a wrapper can be added to tell
the code whether rtnl should be held or not based on which resume is
happening.

Does anyone know if: resume (not runtime_resume) already holds RTNL?
I'll try to take a look and see, but I am not very familiar with PM.

