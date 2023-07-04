Return-Path: <bpf+bounces-4009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FE9747A77
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 01:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F35E31C20A54
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 23:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0142A8BF9;
	Tue,  4 Jul 2023 23:41:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4471FDB;
	Tue,  4 Jul 2023 23:41:50 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2BAB2;
	Tue,  4 Jul 2023 16:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9SeNZOM5rUL+lPxR+zIXqie8ZQu23Px7Sxm57ft8vvE=; b=dbkQIbcUTFJ7p4iBuCVFQuDbsc
	jiK9oUyncaGxmlaFOGX0Tal5m9MPjSf0lkQoeHV1VmW7c2X5iDN3Td5MPk0qC7fff2G73cBcY+gJj
	Y/BLQ4lA6RaJ+bQ6ucD96ZbOmSZLh1+1TISI9yfyxjgutO+jhbhtrTKO3HzIhrRIun+g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qGpeL-000aoZ-Ns; Wed, 05 Jul 2023 01:41:37 +0200
Date: Wed, 5 Jul 2023 01:41:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: wei.fang@nxp.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com, netdev@vger.kernel.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net 1/3] net: fec: dynamically set the
 NETDEV_XDP_ACT_NDO_XMIT feature of XDP
Message-ID: <5b1182d5-a147-4bfd-9ac8-b33462e97b10@lunn.ch>
References: <20230704082916.2135501-1-wei.fang@nxp.com>
 <20230704082916.2135501-2-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704082916.2135501-2-wei.fang@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 04, 2023 at 04:29:14PM +0800, wei.fang@nxp.com wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> When a XDP program is installed or uninstalled, fec_restart() will
> be invoked to reset MAC and buffer descriptor rings. It's reasonable
> not to transmit any packet during the process of reset. However, the
> NETDEV_XDP_ACT_NDO_XMIT bit of xdp_features is enabled by default,
> that is to say, it's possible that the fec_enet_xdp_xmit() will be
> invoked even if the process of reset is not finished. In this case,
> the redirected XDP frames might be dropped and available transmit BDs
> may be incorrectly deemed insufficient. So this patch disable the
> NETDEV_XDP_ACT_NDO_XMIT feature by default and dynamically configure
> this feature when the bpf program is installed or uninstalled.

I don't know much about XDP, so please excuse what might be a stupid
question.

Is this a generic issue? Should this
xdp_features_clear_redirect_target(dev) /
xdp_features_set_redirect_target(dev, false) be done in the core?

	Andrew				      

