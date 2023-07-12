Return-Path: <bpf+bounces-4815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE21874FC89
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 03:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A5371C20B57
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 01:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6B8397;
	Wed, 12 Jul 2023 01:16:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC5F638;
	Wed, 12 Jul 2023 01:16:41 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1981726;
	Tue, 11 Jul 2023 18:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dVMRKCtThpA0k7vZMvJIKRYdajbcjdgx3zkYzglFpvU=; b=AGieYMQVYFIP8kjVmm6NG4qKnJ
	mjj6Q9142L9yaOxC7IH158DUfTGzsqxXCtxHpgaU7tCgpJKxfq4giT0KqlzQgrSIvA+naYP1nsNW1
	vzEPPfo1u3rAbW0iuKuG+u0SnjWEvX7CD8/cQKZeSmPVPpEoL54n3yQiUfp3cpNiA9Ps=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qJOSs-0015Xo-Hq; Wed, 12 Jul 2023 03:16:22 +0200
Date: Wed, 12 Jul 2023 03:16:22 +0200
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
Message-ID: <a0e9f344-76b6-4cdc-a755-7ee9e57ea8d3@lunn.ch>
References: <20230704082916.2135501-1-wei.fang@nxp.com>
 <20230704082916.2135501-4-wei.fang@nxp.com>
 <0443a057-767f-4f9c-afd2-37d26b606d74@lunn.ch>
 <AM5PR04MB3139789F6CCA4BEC8A871C1D882FA@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <757f7803-72b6-4649-bfff-e4559d269880@lunn.ch>
 <AM5PR04MB3139A4FDA4DB6FB5A1DB1C7E8830A@AM5PR04MB3139.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM5PR04MB3139A4FDA4DB6FB5A1DB1C7E8830A@AM5PR04MB3139.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Sorry, the Vybrid platform is not currently maintained by us, and Vybrid is also not
> included in our usual Yocto SDK RC version.

Your Yocto SDK version does not matter. We are talking about mainline
here... You are maintaining the mainline driver, and submitting
patches to extend the mainline driver.

> Even I find a Vybrid board, I think it
> probably cann't run with the latest kernel image, because the latest kernel image
> does not match with the old Yocto SDK, and new Yocto SDK does not support Vybrid
> platform. I also asked my colleague in test team who is in charge of ethernet testing,
> she hadn't even heard of Vybrid platform.

Well 6.5-rc1 does run on Vybrid, i have a number of boards with
it. You will also find that many inflight entertainment systems have a
box under each row of seats in a aeroplane with a Vybrid controlling a
Marvell switch. Take a look at arch/arm/boot/dts/vf610-zii-* You will
also find a number of DTS files for imx5i, imx6, imx7 used for ZII
products which are back of the seat displays, and make heavy use of
networking with the FEC.

So i have in interest in the FEC for all these platforms.

> > And a bigger burst means more latency. Read about Buffer bloat.
> > 
> Perhaps, but not necessarily. For example, in some cases that some burst packets
> maybe stay in Qdisc instead of hardware queue if ring size is small.

Which is what you want, so high priority packets can jump to the head
of the queue.

> > While you have iperf running saturating the link, try a ping as well. How does
> > ping latency change with more TX buffers?
> > 
> Per your suggestions, I tested on i.MX8ULP, i.MX8MM and i.MX93 platforms. The
> results do not appear to be very different.

Thanks for the benchmark numbers. They look O.K.

       Andrew

