Return-Path: <bpf+bounces-42669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEFF9A7155
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 19:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4391CB20F06
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 17:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AB51F473C;
	Mon, 21 Oct 2024 17:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bBOhPFJZ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DCD5028C;
	Mon, 21 Oct 2024 17:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729532932; cv=none; b=FpkLYQUKHiMNYojEg9Kel4hH7wMJDOqRy6OMVUKDfsRQ3Q4FyMlTgKYDYFcqzG4Y2MlykvmU2Hv0mbBjZ8xEz0pir8WyxXyAAlJB1X258KHZ1fA3119AOuKJse71cFsSKgzvSkb8qHk6HF0WGGDKJ0gTZsTKSbryUnU7lzSy3FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729532932; c=relaxed/simple;
	bh=HDUE7vShHHJQGRZ7OyKpTLUDq3+cfNdFoYfU2fj+6hI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l7yp7XlNzrAWVpVxDBSkVtZUhbMVxMeRcy4DDayCHpo9jjKBeA12/pnHcL9GeHny9OQtjuOSGcO8lA3ZADegqMVgLTDxXZhtX9cB7BxVysVPPnp6iFR1Ed9tYYjTr7S2db3RXf0xG3sDi3DoIesiH3ySOWBLG+FidYFPnjrmo+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bBOhPFJZ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729532931; x=1761068931;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=HDUE7vShHHJQGRZ7OyKpTLUDq3+cfNdFoYfU2fj+6hI=;
  b=bBOhPFJZdeXoZ4uTG+mk4NOXiLxjqDiGDdF1yYyPL7tPqET8ohJn0E6L
   bb1WwlzfmM4UH4z+naQh8jU66zZjG+ndmBQcCuc0PuaD0HxzgYmnMkhmY
   OfBHxkJk7k/myRWl+4lw9G3+bXHRSQWa0xe4eoq0WEd4Hva1oEQTqrDTw
   O57WzEVg7DzFccpSCYrBm+/9Jzzf/pyMhJjxH0DXGyl6H5RSrQAz3xYhd
   vFWr40Lg1ipzeh4oia0YSqsR6FmOUCDHJBwUYUSxfLFkKlWMf6yA7w2V1
   PHFoVXsfro3KsPIYNsN2ariktdHLJFa0zokQD0AXR/5hk9P1+zpc/aDnA
   Q==;
X-CSE-ConnectionGUID: CSdy8FXmSp6JJdpgMmwKAg==
X-CSE-MsgGUID: qC56AXOBRnq/2M5FcJk+Uw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32715258"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="32715258"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 10:48:50 -0700
X-CSE-ConnectionGUID: hkY7BdqQQDW4rDZ5kS6dMw==
X-CSE-MsgGUID: sYb+WLBRSH2a7gv/WVNOow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="84199817"
Received: from philliph-desk.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.220.26])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 10:48:49 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org
Cc: kurt@linutronix.de, Joe Damato <jdamato@fastly.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, "moderated
 list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>, open list
 <linux-kernel@vger.kernel.org>, "open list:XDP (eXpress Data Path)"
 <bpf@vger.kernel.org>
Subject: Re: [net-next v3 2/2] igc: Link queues to NAPI instances
In-Reply-To: <20241018171343.314835-3-jdamato@fastly.com>
References: <20241018171343.314835-1-jdamato@fastly.com>
 <20241018171343.314835-3-jdamato@fastly.com>
Date: Mon, 21 Oct 2024 10:48:48 -0700
Message-ID: <874j55gxdr.fsf@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Joe Damato <jdamato@fastly.com> writes:

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


Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
-- 
Vinicius

