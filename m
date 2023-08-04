Return-Path: <bpf+bounces-6992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1987776FFEC
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 14:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 212B21C2181C
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 12:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C77BA52;
	Fri,  4 Aug 2023 12:05:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA486BA28;
	Fri,  4 Aug 2023 12:05:23 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C75B1;
	Fri,  4 Aug 2023 05:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=BF7IxsJwwF3H6hTxOnnRHhHm2pxerHz0TwcwSYZ5mmo=; b=hn
	ITZz2x2U9gv8VyS3tbPuS1qJb2s+QdLDombVGgJBuIMp94B/jdNGHm1K8rEfkYkMQ3+ewn5LIO6kF
	LbiK6e4ZLwcXUaPHNQrnsjqHyQv9cFjU/JmA3DscTJjlqurbFbCQLAHvCpreRbwfhm9fptZMUrUZ6
	wuSJ327BFnrmpP0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qRtXG-0034lQ-BA; Fri, 04 Aug 2023 14:04:02 +0200
Date: Fri, 4 Aug 2023 14:04:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Cc: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Mark Gross <markgross@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Wong Vee Khee <veekhee@apple.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Revanth Kumar Uppala <ruppala@nvidia.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Andrey Konovalov <andrey.konovalov@linaro.org>,
	Jochen Henneberg <jh@henneberg-systemdesign.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
	bpf@vger.kernel.org, Voon Wei Feng <weifeng.voon@intel.com>,
	Tan Tee Min <tee.min.tan@linux.intel.com>,
	Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
	Lai Peter Jun Ann <jun.ann.lai@intel.com>
Subject: Re: [PATCH net-next v2 0/5] TSN auto negotiation between 1G and 2.5G
Message-ID: <5bd05ba2-fd88-4e5c-baed-9971ff917484@lunn.ch>
References: <20230804084527.2082302-1-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230804084527.2082302-1-yong.liang.choong@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 04, 2023 at 04:45:22PM +0800, Choong Yong Liang wrote:
> Intel platforms’ integrated Gigabit Ethernet controllers support
> 2.5Gbps mode statically using BIOS programming. In the current
> implementation, the BIOS menu provides an option to select between
> 10/100/1000Mbps and 2.5Gbps modes. Based on the selection, the BIOS
> programs the Phase Lock Loop (PLL) registers. The BIOS also read the
> TSN lane registers from Flexible I/O Adapter (FIA) block and provided
> 10/100/1000Mbps/2.5Gbps information to the stmmac driver. But
> auto-negotiation between 10/100/1000Mbps and 2.5Gbps is not allowed.
> The new proposal is to support auto-negotiation between 10/100/1000Mbps
> and 2.5Gbps . Auto-negotiation between 10, 100, 1000Mbps will use
> in-band auto negotiation. Auto-negotiation between 10/100/1000Mbps and
> 2.5Gbps will work as the following proposed flow, the stmmac driver reads
> the PHY link status registers then identifies the negotiated speed.
> Based on the speed stmmac driver will identify TSN lane registers from
> FIA then send IPC command to the Power Management controller (PMC)
> through PMC driver/API. PMC will act as a proxy to programs the
> PLL registers.

Have you considered using out of band for all link modes? You might
end up with a cleaner architecture, and not need any phylink/phylib
hacks.

	Andrew

