Return-Path: <bpf+bounces-43311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5B59B3560
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 16:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91C621F23B7C
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 15:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A98A1DE883;
	Mon, 28 Oct 2024 15:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="u45R9Cpk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCE91D79A6
	for <bpf@vger.kernel.org>; Mon, 28 Oct 2024 15:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730130645; cv=none; b=pFHZavpnmdPPZjymnSj2qN7wIOMO6wq5AMZqXc2EQUcuQhA24r1P0mym3OekeZU/gVPYz4C34+tleDYaLR+itisBuKk3c1FP1o4kw2mDWoPb9KOezuaaZ/PfP1kJppke014sdgDEMYSz//we1yXx+zpIBHro+hfzYYiWxfP3GJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730130645; c=relaxed/simple;
	bh=mk0XVkj/BVeuaE7ONQhpIVnvMikQeIB9CLCoaNBrvIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6UhN63leAglQMN3ibrN0ttGNWUfP210ars3yV0h4K592FXecCzk4thN7144+k+wkLZd85k8l87CSRjorhZCoqH1xTWsIkeWFwypb0uuOQkjygEGIY5THgouUmpUUr8NvolLVTKvRX2UyMU4pI264u3Z4hhk7zFc6IEWhPnXetA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=u45R9Cpk; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e30116efc9so3643796a91.2
        for <bpf@vger.kernel.org>; Mon, 28 Oct 2024 08:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730130642; x=1730735442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FnWrBI/Ng0ohLOMbR5pqja8Ic94slwd/ycmRHXmbqDY=;
        b=u45R9Cpkaszf1NASjAFoPZdOhk50LBK81yIGsf1cTQtpRXfjngpVBeOXgnIk6CcxpA
         fSBy+mRg4YpflczHQREPWtqvSmnwh58eD+s8KJuy5u1gfxbRc+nuigmTzk91KO8DsZOb
         pUDfvP6M8P8N/AB2EpyGisp9Xtgnq67Msu3xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730130642; x=1730735442;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FnWrBI/Ng0ohLOMbR5pqja8Ic94slwd/ycmRHXmbqDY=;
        b=Fv75Ey74vmwvWBqX6w6dfI6nGJ3/fO2Z6bxH2IVpPWK3PE8GUhGoGqk6Q6oj8QuWNd
         vvKPGxVb7lTiFIzNeqVDTAeelbHvF4w+VXaO18yd4DKRQAEUKjUlN/k8ds5DzHFZqxfB
         ovITD9lcYP8zaLXz548BCL3T75tnFLrPm/hcaABoNfdbx3l1mrgLD8WiLGXMhZWzL+RC
         LzSH89wDRBK0Cmqxat7yHqBcARc4B6UgLHFmoiAitqig0AMqZ3xB7pAVOS/iLyFxSmzH
         mIBuSzZJJ1VF3NM2yKkq71u1khTl/WpuafwrV+gZvkqlRYe8onQ6Pv379VvZgSVMS+bL
         2ANA==
X-Forwarded-Encrypted: i=1; AJvYcCV2i1g6EoE9aespPc3jbaehFRCwtiF+y0hKsF7CEHezaH2/MlZCE8KURxqZZMsvNyBAXSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YypLrgcOSKYMfJ7f0ANalm9XKeo1lWOr7zdCIhqqEqP6DYpmvex
	UK2kuqyPhxKUugxFMwlcn88wi5RlhsVNOQ6RPhdgrttK90ByvPBjn+Q3cA/lWmM=
X-Google-Smtp-Source: AGHT+IF3/TCUpiKd84EFsAhToNlikdsicPBU+qdfa1uLxwqiByy2S0dHIBV5Oh8nWhYJGeniWTavIQ==
X-Received: by 2002:a17:90b:3654:b0:2e0:7b2b:f76 with SMTP id 98e67ed59e1d1-2e8f1072f43mr10157236a91.19.1730130641962;
        Mon, 28 Oct 2024 08:50:41 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e3555c1dsm7314523a91.4.2024.10.28.08.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 08:50:41 -0700 (PDT)
Date: Mon, 28 Oct 2024 08:50:38 -0700
From: Joe Damato <jdamato@fastly.com>
To: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
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
Message-ID: <Zx-yzhq4unv0gsVX@LQ3V64L9R2>
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
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7799132-7e4a-0ac2-cbda-c919ce434fe2@intel.com>

On Sun, Oct 27, 2024 at 11:49:33AM +0200, Lifshits, Vitaly wrote:
> 
> On 10/23/2024 12:52 AM, Joe Damato wrote:
> > Link queues to NAPI instances via netdev-genl API so that users can
> > query this information with netlink. Handle a few cases in the driver:
> >    1. Link/unlink the NAPIs when XDP is enabled/disabled
> >    2. Handle IGC_FLAG_QUEUE_PAIRS enabled and disabled
> > 
> > Example output when IGC_FLAG_QUEUE_PAIRS is enabled:
> > 
> > $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
> >                           --dump queue-get --json='{"ifindex": 2}'
> > 
> > [{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
> >   {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
> >   {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'rx'},
> >   {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'rx'},
> >   {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'tx'},
> >   {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'tx'},
> >   {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'tx'},
> >   {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'tx'}]
> > 
> > Since IGC_FLAG_QUEUE_PAIRS is enabled, you'll note that the same NAPI ID
> > is present for both rx and tx queues at the same index, for example
> > index 0:
> > 
> > {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
> > {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'tx'},
> > 
> > To test IGC_FLAG_QUEUE_PAIRS disabled, a test system was booted using
> > the grub command line option "maxcpus=2" to force
> > igc_set_interrupt_capability to disable IGC_FLAG_QUEUE_PAIRS.
> > 
> > Example output when IGC_FLAG_QUEUE_PAIRS is disabled:
> > 
> > $ lscpu | grep "On-line CPU"
> > On-line CPU(s) list:      0,2
> > 
> > $ ethtool -l enp86s0  | tail -5
> > Current hardware settings:
> > RX:		n/a
> > TX:		n/a
> > Other:		1
> > Combined:	2
> > 
> > $ cat /proc/interrupts  | grep enp
> >   144: [...] enp86s0
> >   145: [...] enp86s0-rx-0
> >   146: [...] enp86s0-rx-1
> >   147: [...] enp86s0-tx-0
> >   148: [...] enp86s0-tx-1
> > 
> > 1 "other" IRQ, and 2 IRQs for each of RX and Tx, so we expect netlink to
> > report 4 IRQs with unique NAPI IDs:
> > 
> > $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
> >                           --dump napi-get --json='{"ifindex": 2}'
> > [{'id': 8196, 'ifindex': 2, 'irq': 148},
> >   {'id': 8195, 'ifindex': 2, 'irq': 147},
> >   {'id': 8194, 'ifindex': 2, 'irq': 146},
> >   {'id': 8193, 'ifindex': 2, 'irq': 145}]
> > 
> > Now we examine which queues these NAPIs are associated with, expecting
> > that since IGC_FLAG_QUEUE_PAIRS is disabled each RX and TX queue will
> > have its own NAPI instance:
> > 
> > $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
> >                           --dump queue-get --json='{"ifindex": 2}'
> > [{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
> >   {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
> >   {'id': 0, 'ifindex': 2, 'napi-id': 8195, 'type': 'tx'},
> >   {'id': 1, 'ifindex': 2, 'napi-id': 8196, 'type': 'tx'}]
> > 
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> > ---
> >   v4:
> >     - Add rtnl_lock/rtnl_unlock in two paths: igc_resume and
> >       igc_io_error_detected. The code added to the latter is inspired by
> >       a similar implementation in ixgbe's ixgbe_io_error_detected.
> > 
> >   v3:
> >     - Replace igc_unset_queue_napi with igc_set_queue_napi(adapater, i,
> >       NULL), as suggested by Vinicius Costa Gomes
> >     - Simplify implemention of igc_set_queue_napi as suggested by Kurt
> >       Kanzenbach, with a tweak to use ring->queue_index
> > 
> >   v2:
> >     - Update commit message to include tests for IGC_FLAG_QUEUE_PAIRS
> >       disabled
> >     - Refactored code to move napi queue mapping and unmapping to helper
> >       functions igc_set_queue_napi and igc_unset_queue_napi
> >     - Adjust the code to handle IGC_FLAG_QUEUE_PAIRS disabled
> >     - Call helpers to map/unmap queues to NAPIs in igc_up, __igc_open,
> >       igc_xdp_enable_pool, and igc_xdp_disable_pool
> > 
> >   drivers/net/ethernet/intel/igc/igc.h      |  2 ++
> >   drivers/net/ethernet/intel/igc/igc_main.c | 41 ++++++++++++++++++++---
> >   drivers/net/ethernet/intel/igc/igc_xdp.c  |  2 ++
> >   3 files changed, 40 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
> > index eac0f966e0e4..b8111ad9a9a8 100644
> > --- a/drivers/net/ethernet/intel/igc/igc.h
> > +++ b/drivers/net/ethernet/intel/igc/igc.h
> > @@ -337,6 +337,8 @@ struct igc_adapter {
> >   	struct igc_led_classdev *leds;
> >   };
> > +void igc_set_queue_napi(struct igc_adapter *adapter, int q_idx,
> > +			struct napi_struct *napi);
> >   void igc_up(struct igc_adapter *adapter);
> >   void igc_down(struct igc_adapter *adapter);
> >   int igc_open(struct net_device *netdev);
> > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> > index 7964bbedb16c..04aa216ef612 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > @@ -4948,6 +4948,22 @@ static int igc_sw_init(struct igc_adapter *adapter)
> >   	return 0;
> >   }
> > +void igc_set_queue_napi(struct igc_adapter *adapter, int vector,
> > +			struct napi_struct *napi)
> > +{
> > +	struct igc_q_vector *q_vector = adapter->q_vector[vector];
> > +
> > +	if (q_vector->rx.ring)
> > +		netif_queue_set_napi(adapter->netdev,
> > +				     q_vector->rx.ring->queue_index,
> > +				     NETDEV_QUEUE_TYPE_RX, napi);
> > +
> > +	if (q_vector->tx.ring)
> > +		netif_queue_set_napi(adapter->netdev,
> > +				     q_vector->tx.ring->queue_index,
> > +				     NETDEV_QUEUE_TYPE_TX, napi);
> > +}
> > +
> >   /**
> >    * igc_up - Open the interface and prepare it to handle traffic
> >    * @adapter: board private structure
> > @@ -4955,6 +4971,7 @@ static int igc_sw_init(struct igc_adapter *adapter)
> >   void igc_up(struct igc_adapter *adapter)
> >   {
> >   	struct igc_hw *hw = &adapter->hw;
> > +	struct napi_struct *napi;
> >   	int i = 0;
> >   	/* hardware has been reset, we need to reload some things */
> > @@ -4962,8 +4979,11 @@ void igc_up(struct igc_adapter *adapter)
> >   	clear_bit(__IGC_DOWN, &adapter->state);
> > -	for (i = 0; i < adapter->num_q_vectors; i++)
> > -		napi_enable(&adapter->q_vector[i]->napi);
> > +	for (i = 0; i < adapter->num_q_vectors; i++) {
> > +		napi = &adapter->q_vector[i]->napi;
> > +		napi_enable(napi);
> > +		igc_set_queue_napi(adapter, i, napi);
> > +	}
> >   	if (adapter->msix_entries)
> >   		igc_configure_msix(adapter);
> > @@ -5192,6 +5212,7 @@ void igc_down(struct igc_adapter *adapter)
> >   	for (i = 0; i < adapter->num_q_vectors; i++) {
> >   		if (adapter->q_vector[i]) {
> >   			napi_synchronize(&adapter->q_vector[i]->napi);
> > +			igc_set_queue_napi(adapter, i, NULL);
> >   			napi_disable(&adapter->q_vector[i]->napi);
> >   		}
> >   	}
> > @@ -6021,6 +6042,7 @@ static int __igc_open(struct net_device *netdev, bool resuming)
> >   	struct igc_adapter *adapter = netdev_priv(netdev);
> >   	struct pci_dev *pdev = adapter->pdev;
> >   	struct igc_hw *hw = &adapter->hw;
> > +	struct napi_struct *napi;
> >   	int err = 0;
> >   	int i = 0;
> > @@ -6056,8 +6078,11 @@ static int __igc_open(struct net_device *netdev, bool resuming)
> >   	clear_bit(__IGC_DOWN, &adapter->state);
> > -	for (i = 0; i < adapter->num_q_vectors; i++)
> > -		napi_enable(&adapter->q_vector[i]->napi);
> > +	for (i = 0; i < adapter->num_q_vectors; i++) {
> > +		napi = &adapter->q_vector[i]->napi;
> > +		napi_enable(napi);
> > +		igc_set_queue_napi(adapter, i, napi);
> > +	}
> >   	/* Clear any pending interrupts. */
> >   	rd32(IGC_ICR);
> > @@ -7385,7 +7410,9 @@ static int igc_resume(struct device *dev)
> >   	wr32(IGC_WUS, ~0);
> >   	if (netif_running(netdev)) {
> > +		rtnl_lock();
> 
> This change will bring back the deadlock issue that was fixed in commit:
> 6f31d6b: "igc: Refactor runtime power management flow".

OK, thanks for letting me know.

I think I better understand what the issue is. It seems that:

- igc_resume can be called with rtnl held via ethtool (which I
  didn't know), which calls __igc_open
- __igc_open re-enables NAPIs and re-links queues to NAPI IDs (which
  requires rtnl)

so, it seems like the rtnl_lock() I've added to igc_resume is
unnecessary.

I suppose I don't know all of the paths where the pm functions can
be called -- are there others where RTNL is _not_ already held?

I looked at e1000e and it seems that driver does not re-enable NAPIs
in its resume path and thus does not suffer from the same issue as
igc.

So my questions are:

  1. Are there are other contexts where igc_resume is called where
     RTNL is not held?

  2. If the answer is that RTNL is always held when igc_resume is
     called, then I can send a v5 that removes the
     rtnl_lock/rtnl_unlock. What do you think?

[...]

> 
> Hi Joe,
> 
> 
> The current version will cause a regression, a possible deadlock, due to the
> addition of the rtnl_lock in igc_resume that was fixed previously.
> 
> You can refer to the following link:
> 
> https://github.com/torvalds/linux/commit/6f31d6b643a32cc126cf86093fca1ea575948bf0#diff-d5b32b873e9902b496280a5f42c246043c8f0691d8b3a6bbd56df99ce8ceb394L7190

Thanks for the link.

