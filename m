Return-Path: <bpf+bounces-42824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDF29AB79D
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 22:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 980B61C22E7A
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 20:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B131CC88F;
	Tue, 22 Oct 2024 20:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Ocy/0BbV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B831CB30C
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 20:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729628909; cv=none; b=US2RDP+KA8H+/O95VFIcs5GkfqjTxC0gmuGzWLO1KEj5c4glwAJQc1l4GlIeIrTqP/R6BWxWhMCa1fkCB4aXjL5J0YZRWj9C5a8Yv+hBdPlCA1S171sEPc1JzG4NsokePOkbsU31kJg/cLkr9ptgUgrEDmS3w/1+9E2qYIF04kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729628909; c=relaxed/simple;
	bh=bf/yd66V3kuF83bTxs0evHL8Paf59mxT72gHVvyI7IE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdSQtr+SvJFIvE9PJvc1CclXSNCAjFU2DeTz8j06smm/YcpCsyVXVEEs+Y++dBAjTjxQGxYKm0XH+9nzq49JsUU0jf/e95QPWXhlqzVih5RkO7JOQFV0iFNshzF8LpfPYrR07rdhLr9ASAApLXV/nhpa3pCAhMWa/UzAn1VtzNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Ocy/0BbV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20ce65c8e13so52055485ad.1
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 13:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1729628906; x=1730233706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJMWdLBxWmamd6hVKbJ1xLBNYdB6AKwK9i9T9Bn4rmA=;
        b=Ocy/0BbVMmB40lTHv5RR0Kln1NTpZJpKeaCqOghSAC3dRywf0OWe/zcBjJFW+xYz7i
         dxN9bvX9x2ZKm5a/1ufvEUAUnyekFR7IhWdWziFzHJeSS1zuz2XO9mFZK6f4a2OjlmiQ
         zpawrfAESLtDnkniCA7p9wi6sedcafxgy+D0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729628906; x=1730233706;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PJMWdLBxWmamd6hVKbJ1xLBNYdB6AKwK9i9T9Bn4rmA=;
        b=hTZATh5xSPEvEsTJeGExmLs7s0aJUW0+nxZW80TlvPVdo9TfhiZv+DYEPOsZs+92bq
         1hrPQs6Stx7YCFKDrcsQ8uM7vtgFK9Jm5eqJ+fYgp2IzTFeeEVrT/0cD5g3VolbDKxu1
         x9m2QUzpUAePC6gPRjuBsNq3wUbjMOeCKsaV2TzCy7q7fyUrVAvVUBx4Fjvj5L1MyCMw
         vXWDRJSBNnNzgJGZIfoh8QOuu+MZL20qxF4SXhh15gU2wLYHVGMxms4h5tFJ+evNDX4s
         q6XFNrouK9/mUs8w89BgWwhKZdZ8Or+OMxTiB4y2P23SpyWFKy7pnBV75PSm1fbrTepg
         kGmw==
X-Forwarded-Encrypted: i=1; AJvYcCWKxEEp7edajIYx2O6V/EDeIrg80wXZqJTYEJVsj+97yZDElsXRIBJZkPp46edoee59U4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvKivktIjUWY0eWyuvD8esAciN6xocKT0mD4zxlb/rDHLhbWjf
	6OtCnuZurqf7/9DA6v++gOt9VMxYZFq+c7GlxS2THXW1V62H3Z+Gx1aCFkXQDuI=
X-Google-Smtp-Source: AGHT+IF/ce2cH6YsKQwrxSrc+EOHV6a0+Ka22Y3Dqi0AhC2mugNz9U3DkGtcDFiVTs9rUCoC04Hcuw==
X-Received: by 2002:a17:903:2344:b0:20c:d469:ba95 with SMTP id d9443c01a7336-20fa9e09f1bmr5229205ad.16.1729628906327;
        Tue, 22 Oct 2024 13:28:26 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0c0bb7sm46730885ad.143.2024.10.22.13.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 13:28:25 -0700 (PDT)
Date: Tue, 22 Oct 2024 13:28:22 -0700
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: kurt@linutronix.de, vinicius.gomes@intel.com,
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
	"open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>,
	jacob.e.keller@intel.com
Subject: Re: [net-next v3 2/2] igc: Link queues to NAPI instances
Message-ID: <ZxgK5jsCn5VmKKrH@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
	kurt@linutronix.de, vinicius.gomes@intel.com,
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
	"open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>,
	jacob.e.keller@intel.com
References: <20241018171343.314835-1-jdamato@fastly.com>
 <20241018171343.314835-3-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018171343.314835-3-jdamato@fastly.com>

On Fri, Oct 18, 2024 at 05:13:43PM +0000, Joe Damato wrote:
> Link queues to NAPI instances via netdev-genl API so that users can
> query this information with netlink. Handle a few cases in the driver:
>   1. Link/unlink the NAPIs when XDP is enabled/disabled
>   2. Handle IGC_FLAG_QUEUE_PAIRS enabled and disabled
> 
> Example output when IGC_FLAG_QUEUE_PAIRS is enabled:
> 
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                          --dump queue-get --json='{"ifindex": 2}'
> 
> [{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
>  {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'rx'},
>  {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'rx'},
>  {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'tx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'tx'},
>  {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'tx'},
>  {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'tx'}]
> 
> Since IGC_FLAG_QUEUE_PAIRS is enabled, you'll note that the same NAPI ID
> is present for both rx and tx queues at the same index, for example
> index 0:
> 
> {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
> {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'tx'},
> 
> To test IGC_FLAG_QUEUE_PAIRS disabled, a test system was booted using
> the grub command line option "maxcpus=2" to force
> igc_set_interrupt_capability to disable IGC_FLAG_QUEUE_PAIRS.
> 
> Example output when IGC_FLAG_QUEUE_PAIRS is disabled:
> 
> $ lscpu | grep "On-line CPU"
> On-line CPU(s) list:      0,2
> 
> $ ethtool -l enp86s0  | tail -5
> Current hardware settings:
> RX:		n/a
> TX:		n/a
> Other:		1
> Combined:	2
> 
> $ cat /proc/interrupts  | grep enp
>  144: [...] enp86s0
>  145: [...] enp86s0-rx-0
>  146: [...] enp86s0-rx-1
>  147: [...] enp86s0-tx-0
>  148: [...] enp86s0-tx-1
> 
> 1 "other" IRQ, and 2 IRQs for each of RX and Tx, so we expect netlink to
> report 4 IRQs with unique NAPI IDs:
> 
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                          --dump napi-get --json='{"ifindex": 2}'
> [{'id': 8196, 'ifindex': 2, 'irq': 148},
>  {'id': 8195, 'ifindex': 2, 'irq': 147},
>  {'id': 8194, 'ifindex': 2, 'irq': 146},
>  {'id': 8193, 'ifindex': 2, 'irq': 145}]
> 
> Now we examine which queues these NAPIs are associated with, expecting
> that since IGC_FLAG_QUEUE_PAIRS is disabled each RX and TX queue will
> have its own NAPI instance:
> 
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                          --dump queue-get --json='{"ifindex": 2}'
> [{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
>  {'id': 0, 'ifindex': 2, 'napi-id': 8195, 'type': 'tx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8196, 'type': 'tx'}]
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  v3:
>    - Replace igc_unset_queue_napi with igc_set_queue_napi(adapater, i,
>      NULL), as suggested by Vinicius Costa Gomes
>    - Simplify implemention of igc_set_queue_napi as suggested by Kurt
>      Kanzenbach, with a tweak to use ring->queue_index
> 
>  v2:
>    - Update commit message to include tests for IGC_FLAG_QUEUE_PAIRS
>      disabled
>    - Refactored code to move napi queue mapping and unmapping to helper
>      functions igc_set_queue_napi and igc_unset_queue_napi
>    - Adjust the code to handle IGC_FLAG_QUEUE_PAIRS disabled
>    - Call helpers to map/unmap queues to NAPIs in igc_up, __igc_open,
>      igc_xdp_enable_pool, and igc_xdp_disable_pool
> 
>  drivers/net/ethernet/intel/igc/igc.h      |  2 ++
>  drivers/net/ethernet/intel/igc/igc_main.c | 33 ++++++++++++++++++++---
>  drivers/net/ethernet/intel/igc/igc_xdp.c  |  2 ++
>  3 files changed, 33 insertions(+), 4 deletions(-)

I took another look at this to make sure that RTNL is held when
igc_set_queue_napi is called after the e1000 bug report came in [1],
and there may be two locations I've missed:

1. igc_resume, which calls __igc_open
2. igc_io_error_detected, which calls igc_down

In both cases, I think the code can be modified to hold rtnl around
calls to __igc_open and igc_down.

Let me know what you think ?

If you agree that I should hold rtnl in both of those cases, what is
the best way to proceed:
  - send a v4, or
  - wait for this to get merged (since I got the notification it was
    pulled into intel-next) and send a fixes ?

Here's the full analysis I came up with; I tried to be thorough, but
it is certainly possible I missed a call site:

For the up case:

- igc_up:
  - called from igc_reinit_locked, which is called via:
    - igc_reset_task (rtnl is held)
    - igc_set_features (ndo_set_features, which itself has an ASSERT_RTNL)
    - various places in igc_ethtool (set_priv_flags, nway_reset,
      ethtool_set_eee) all of which have RTNL held
  - igc_change_mtu which also has RTNL held
- __igc_open
  - called from igc_resume, which may need an rtnl_lock ?
  - igc_open
    - called from igc_io_resume, rtnl is held
    - called from igc_reinit_queues, only via ethool set_channels,
      where rtnl is held
    - ndo_open where rtnl is held

For the down case:

- igc_down:
  - called from various ethtool locations (set_ringparam,
    set_pauseparam, set_link_ksettings) all of which hold rtnl
  - called from igc_io_error_detected, which may need an rtnl_lock
  - igc_reinit_locked which is fine, as described above
  - igc_change_mtu which is fine, as described above
  - called from __igc_close
    - called from __igc_shutdown which holds rtnl
    - called from igc_reinit_queues which is fine as described above
    - called from igc_close which is ndo_close

