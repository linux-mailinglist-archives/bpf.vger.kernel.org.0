Return-Path: <bpf+bounces-4508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE19574BED0
	for <lists+bpf@lfdr.de>; Sat,  8 Jul 2023 21:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FAE81C20913
	for <lists+bpf@lfdr.de>; Sat,  8 Jul 2023 19:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE83A95F;
	Sat,  8 Jul 2023 19:03:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6D5185C;
	Sat,  8 Jul 2023 19:03:53 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E651BE;
	Sat,  8 Jul 2023 12:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=b1GJX3RGXSzNdKU1TCJSvmWTtGpaGACMjyZe5y3vCEE=; b=B+7+0ISbfpifyEoillBS5hPKhN
	FEhXhW6on672uxDvggUB+cojjQ5EWXGYggNkQeVEtAUvFmkXx+KUrTifzyU5T50G8ake5Rajy00IB
	3qwYf0b+jhRs6mA0pc5EFXC3j/OnoIkV7r8KZwnC5Sawbw5EFX7kpquJPH9xbdseXsNY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qIDDW-000pPu-TS; Sat, 08 Jul 2023 21:03:38 +0200
Date: Sat, 8 Jul 2023 21:03:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"hawk@kernel.org" <hawk@kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	dl-linux-imx <linux-imx@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH net 3/3] net: fec: increase the size of tx ring and
 update thresholds of tx ring
Message-ID: <757f7803-72b6-4649-bfff-e4559d269880@lunn.ch>
References: <20230704082916.2135501-1-wei.fang@nxp.com>
 <20230704082916.2135501-4-wei.fang@nxp.com>
 <0443a057-767f-4f9c-afd2-37d26b606d74@lunn.ch>
 <AM5PR04MB3139789F6CCA4BEC8A871C1D882FA@AM5PR04MB3139.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM5PR04MB3139789F6CCA4BEC8A871C1D882FA@AM5PR04MB3139.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > How does this affect platforms like Vybrid with its fast Ethernet?
> Sorry, I don't have the Vybrid platform, but I think I don't think it has much
> impact, at most it just takes up some more memory.

It has been 6 months since the page pool patches were posted and i
asked about benchmark results for other platforms like Vybrid. Is it
so hard to get hold or reference platforms? Fugang Duan used to have a
test farm of all sorts of boards and reported to me the regressions i
introduced with MDIO changes and PM changes. As somebody who seems to
be an NXP FEC Maintainer i would expect you to have access to a range
of hardware. Especially since XDP and eBPF is a bit of a niche for
embedded processes which NXP produce. You want to be sure your changes
don't regress the main use cases which i guess are plain networking.

> > Does the burst latency go up?
> No, for fec, when a packet is attached to the BDs, the software will immediately
> trigger the hardware to send the packet. In addition, I think it may improve the
> latency, because the size of the tx ring becomes larger, and more packets can be
> attached to the BD ring for burst traffic.

And a bigger burst means more latency. Read about Buffer
bloat.

While you have iperf running saturating the link, try a ping as
well. How does ping latency change with more TX buffers?

Ideally you want enough transmit buffers to keep the link full, but
not more. If the driver is using BQL, the network stack will help with
this.

> Below are the results on i.MX6UL/8MM/8MP/8ULP/93 platforms, i.MX6UL and
> 8ULP only support Fast ethernet. Others support 1G.

Thanks for the benchmark numbers. Please get into the habit of
including them. We like to see justification for any sort of
performance tweaks.

	Andrew

