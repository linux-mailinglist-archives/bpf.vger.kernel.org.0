Return-Path: <bpf+bounces-9764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C8779D4B0
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 17:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A95B281DA5
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 15:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E592B18C0F;
	Tue, 12 Sep 2023 15:20:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B91A31;
	Tue, 12 Sep 2023 15:20:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733CCC433C8;
	Tue, 12 Sep 2023 15:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694532036;
	bh=CyzBP67+/V5pqHwJ0uKs92bHtbAg4F+shcqqbAJgXWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eGnWVRXtlWgAILYsdIav3nXuMmQ+VX5b/GUXFPNWmwltMafQ7hkSF2ZFlvLYqUHcp
	 anRxuLJA5ikIr21kILDE9SXrAwtQHeIiQh5zeNeNcpAfipCWABZEfz1t/dreihyzI+
	 jmOGyYGbWwM79H3Wnarn26MYUkreBqZxqdoNXKo7xQx4uCHiN+oZNYc0ODEdRpOu8D
	 74sA2R/+EGR1LCF3Qv5kT6n2fbtNQn6wM8DBTn1ZaQUsPPgHzbefAd8OkrsqX6GOjd
	 M8s5IsR1v7Y/7cnCDKQOFTasA5JDDOjBOIYE2SXBOsKXBY42ik1KEpDPl8h0yCOkEV
	 Fx94Pgfv6JtDw==
Date: Tue, 12 Sep 2023 17:20:31 +0200
From: Simon Horman <horms@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 2/2] net: core: Sort headers alphabetically
Message-ID: <20230912152031.GI401982@kernel.org>
References: <20230911154534.4174265-1-andriy.shevchenko@linux.intel.com>
 <20230911154534.4174265-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911154534.4174265-2-andriy.shevchenko@linux.intel.com>

On Mon, Sep 11, 2023 at 06:45:34PM +0300, Andy Shevchenko wrote:
> It's rather a gigantic list of heards that is very hard to follow.
> Sorting helps to see what's already included and what's not.
> It improves a maintainability in a long term.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Hi Andy,

At the risk of bike shedding, the sort function of Vim, when operating
with the C locale, gives a slightly different order, as experssed by
this incremental diff.

I have no objections to your oder, but I'm slightly curious as
to how it came about.

diff --git a/net/core/dev.c b/net/core/dev.c
index d795a6c5a591..770138babf7e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -92,9 +92,9 @@
 #include <linux/if_ether.h>
 #include <linux/if_macvlan.h>
 #include <linux/if_vlan.h>
+#include <linux/in.h>
 #include <linux/indirect_call_wrapper.h>
 #include <linux/inetdevice.h>
-#include <linux/in.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/ip.h>
@@ -105,9 +105,9 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/net_namespace.h>
 #include <linux/netdevice.h>
 #include <linux/netfilter_netdev.h>
-#include <linux/net_namespace.h>
 #include <linux/netpoll.h>
 #include <linux/once_lite.h>
 #include <linux/pm_runtime.h>
@@ -142,8 +142,8 @@
 #include <net/ip.h>
 #include <net/iw_handler.h>
 #include <net/mpls.h>
-#include <net/netdev_rx_queue.h>
 #include <net/net_namespace.h>
+#include <net/netdev_rx_queue.h>
 #include <net/pkt_cls.h>
 #include <net/pkt_sched.h>
 #include <net/sock.h>

