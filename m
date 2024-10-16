Return-Path: <bpf+bounces-42135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BED99FDBC
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 03:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A86B5B21203
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 01:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077561531E6;
	Wed, 16 Oct 2024 01:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="eqkq5H/A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA9C11711
	for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 01:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729040494; cv=none; b=sGD9JX7kbs2ktt+ijk/sgy/pCgBOPVzL3NzIh4HUag0lVIhCa1ugGS983r8Frmd7lbdgJTqa2yKYBAeUEeVmcKDjWCiDITymqBo13pV3AHSEEPBRq1NqIvt8eJ0IOjyQGRgyDTyto6H9Mu20SszZxHuz7v5PJPZCSyJp2itkOxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729040494; c=relaxed/simple;
	bh=+yv22d3jWrd3J5Ds/95GRaZM3vdt8i+Vst/MlLElr7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVS0hbUXpn8S1KRYGg+Kz+FuQiTH4M6U0t58Q+dLmH45tALIg7k/BGl/iWwpcwJFe0w8AJzHqwRI0LfGflxe6iQ8uaHkPwCrK8h3tJNdM4/FQQGnBPQqwqSE9CndovA2skMVTT9FJPazC9fp6NoqJronMdAiTIyDbWQUYkmWzeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=eqkq5H/A; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7db908c9c83so3602534a12.2
        for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 18:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1729040491; x=1729645291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LwITyP/tHiSvmhKS9kDwYbqHDTa6LjHd2wgVqJpiwS0=;
        b=eqkq5H/AtnY76kuYoaHvFwRN1Ddh4XPGKJHEYT5GHcVk3waG5id0H30nFzN6lDkI/U
         1X1MGyxodW8gyp8ZEOX9zKRhNBrafAncy0UUEWRL5ajoYTZ7od4k216irLOE3QxoAxve
         a8h281DS5tun114NNOqR/WpYAdSPu/h0aAXAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729040491; x=1729645291;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LwITyP/tHiSvmhKS9kDwYbqHDTa6LjHd2wgVqJpiwS0=;
        b=V1B+0ZQvsR3YvXD5+5ZgGIF6djkhAYX5sswyo0K15P8zs2wnti8VWCFdfbSMXlYnYR
         D0VURWDLnDnRc5abiwzT8f8zb7OrH/PTh15bSGYY/SlnD/oLPLBUeqIknkt7cl0uzC+T
         5oErJ2Decr5m6+gWZkjUk2RGXo69t/2gszbQ1be3r+8aPNsrKMSK4PCyNYPGUNg4JqKz
         IJTlNyTjxhRYqSeaRJg4M1XS7Jg5LoDmgixFMrPKXks97PhlUjZqB3F+69y9JynZjM+M
         AMAjvDlMGMPYaARmv3RNs4YOB3l8UdGyrpoP7Bb19q8xH00yGOtnJncDD2maq7L5SNrX
         NnWw==
X-Forwarded-Encrypted: i=1; AJvYcCUveGbQvpHAmip/KXwSjtEMutWXFIDBqq5r3GR/iBlzXtiPp1ODJlYOGROCrnDB4WSqHxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL39cckQKpaJc0VXCDVqF/Gv5DMBvzz5oWfB2Z0M+Yz5sgkI+1
	V+ioxDwn/UZdv8uvUpjNcFHBSQ3M1Tj6A/drTEsA92lOtk45nGA3cKF5YZWO/dI=
X-Google-Smtp-Source: AGHT+IFgtcJqMf5QpqhZob66AklcaVZNotbGk59N2QQ8WDGlir7z/0wQgN7eOkPKJvZ6Cb/Eod3ktw==
X-Received: by 2002:a05:6a21:3a42:b0:1d8:f977:8cda with SMTP id adf61e73a8af0-1d8f977d2efmr5042091637.27.1729040491522;
        Tue, 15 Oct 2024 18:01:31 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e774cf5b0sm1967351b3a.167.2024.10.15.18.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 18:01:31 -0700 (PDT)
Date: Tue, 15 Oct 2024 18:01:26 -0700
From: Joe Damato <jdamato@fastly.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: netdev@vger.kernel.org, vinicius.gomes@intel.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Subject: Re: [RFC net-next v2 2/2] igc: Link queues to NAPI instances
Message-ID: <Zw8QZowkIRM-8-U1@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Kurt Kanzenbach <kurt@linutronix.de>, netdev@vger.kernel.org,
	vinicius.gomes@intel.com, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
References: <20241014213012.187976-1-jdamato@fastly.com>
 <20241014213012.187976-3-jdamato@fastly.com>
 <87h69d3bm2.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h69d3bm2.fsf@kurt.kurt.home>

On Tue, Oct 15, 2024 at 12:27:01PM +0200, Kurt Kanzenbach wrote:
> On Mon Oct 14 2024, Joe Damato wrote:
> > Link queues to NAPI instances via netdev-genl API so that users can
> > query this information with netlink. Handle a few cases in the driver:
> >   1. Link/unlink the NAPIs when XDP is enabled/disabled
> >   2. Handle IGC_FLAG_QUEUE_PAIRS enabled and disabled
> >
> > Example output when IGC_FLAG_QUEUE_PAIRS is enabled:
> >
> > $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
> >                          --dump queue-get --json='{"ifindex": 2}'
> >
> > [{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
> >  {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
> >  {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'rx'},
> >  {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'rx'},
> >  {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'tx'},
> >  {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'tx'},
> >  {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'tx'},
> >  {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'tx'}]
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
> >  144: [...] enp86s0
> >  145: [...] enp86s0-rx-0
> >  146: [...] enp86s0-rx-1
> >  147: [...] enp86s0-tx-0
> >  148: [...] enp86s0-tx-1
> >
> > 1 "other" IRQ, and 2 IRQs for each of RX and Tx, so we expect netlink to
> > report 4 IRQs with unique NAPI IDs:
> >
> > $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
> >                          --dump napi-get --json='{"ifindex": 2}'
> > [{'id': 8196, 'ifindex': 2, 'irq': 148},
> >  {'id': 8195, 'ifindex': 2, 'irq': 147},
> >  {'id': 8194, 'ifindex': 2, 'irq': 146},
> >  {'id': 8193, 'ifindex': 2, 'irq': 145}]
> >
> > Now we examine which queues these NAPIs are associated with, expecting
> > that since IGC_FLAG_QUEUE_PAIRS is disabled each RX and TX queue will
> > have its own NAPI instance:
> >
> > $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
> >                          --dump queue-get --json='{"ifindex": 2}'
> > [{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
> >  {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
> >  {'id': 0, 'ifindex': 2, 'napi-id': 8195, 'type': 'tx'},
> >  {'id': 1, 'ifindex': 2, 'napi-id': 8196, 'type': 'tx'}]
> >
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> >  v2:
> >    - Update commit message to include tests for IGC_FLAG_QUEUE_PAIRS
> >      disabled
> >    - Refactored code to move napi queue mapping and unmapping to helper
> >      functions igc_set_queue_napi and igc_unset_queue_napi
> >    - Adjust the code to handle IGC_FLAG_QUEUE_PAIRS disabled
> >    - Call helpers to map/unmap queues to NAPIs in igc_up, __igc_open,
> >      igc_xdp_enable_pool, and igc_xdp_disable_pool
> >
> >  drivers/net/ethernet/intel/igc/igc.h      |  3 ++
> >  drivers/net/ethernet/intel/igc/igc_main.c | 58 +++++++++++++++++++++--
> >  drivers/net/ethernet/intel/igc/igc_xdp.c  |  2 +
> >  3 files changed, 59 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
> > index eac0f966e0e4..7b1c9ea60056 100644
> > --- a/drivers/net/ethernet/intel/igc/igc.h
> > +++ b/drivers/net/ethernet/intel/igc/igc.h
> > @@ -337,6 +337,9 @@ struct igc_adapter {
> >  	struct igc_led_classdev *leds;
> >  };
> >  
> > +void igc_set_queue_napi(struct igc_adapter *adapter, int q_idx,
> > +			struct napi_struct *napi);
> > +void igc_unset_queue_napi(struct igc_adapter *adapter, int q_idx);
> >  void igc_up(struct igc_adapter *adapter);
> >  void igc_down(struct igc_adapter *adapter);
> >  int igc_open(struct net_device *netdev);
> > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> > index 7964bbedb16c..59c00acfa0ed 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > @@ -4948,6 +4948,47 @@ static int igc_sw_init(struct igc_adapter *adapter)
> >  	return 0;
> >  }
> >  
> > +void igc_set_queue_napi(struct igc_adapter *adapter, int q_idx,
> > +			struct napi_struct *napi)
> > +{
> > +	if (adapter->flags & IGC_FLAG_QUEUE_PAIRS) {
> > +		netif_queue_set_napi(adapter->netdev, q_idx,
> > +				     NETDEV_QUEUE_TYPE_RX, napi);
> > +		netif_queue_set_napi(adapter->netdev, q_idx,
> > +				     NETDEV_QUEUE_TYPE_TX, napi);
> > +	} else {
> > +		if (q_idx < adapter->num_rx_queues) {
> > +			netif_queue_set_napi(adapter->netdev, q_idx,
> > +					     NETDEV_QUEUE_TYPE_RX, napi);
> > +		} else {
> > +			q_idx -= adapter->num_rx_queues;
> > +			netif_queue_set_napi(adapter->netdev, q_idx,
> > +					     NETDEV_QUEUE_TYPE_TX, napi);
> > +		}
> > +	}
> > +}
> 
> In addition, to what Vinicius said. I think this can be done
> simpler. Something like this?
> 
> void igc_set_queue_napi(struct igc_adapter *adapter, int vector,
> 			struct napi_struct *napi)
> {
> 	struct igc_q_vector *q_vector = adapter->q_vector[vector];
> 
> 	if (q_vector->rx.ring)
> 		netif_queue_set_napi(adapter->netdev, vector, NETDEV_QUEUE_TYPE_RX, napi);
> 
> 	if (q_vector->tx.ring)
> 		netif_queue_set_napi(adapter->netdev, vector, NETDEV_QUEUE_TYPE_TX, napi);
> }

Ah, yes, that is much simpler. Thanks for the suggestion. I'll do
that for the v3.

