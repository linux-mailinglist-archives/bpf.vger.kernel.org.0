Return-Path: <bpf+bounces-4012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 276A0747AB1
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 02:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6F20280EB4
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 00:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FA3653;
	Wed,  5 Jul 2023 00:25:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76A77F;
	Wed,  5 Jul 2023 00:25:17 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4A71B6;
	Tue,  4 Jul 2023 17:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=f7snvG4+DEFajHuJGR7PtjIGgxTVStOAGnv0m/878o0=; b=cuBXs167gwOb+SrNA9SkDYqQZw
	JNkkzVH758LFCcxH29aSSzLEVXEsKEmcI8AZ+FS86ewlgqEhTP7QE4u51uTnPR44DbJMHGXy/3Qxi
	R7eVB3+WdLX/jdn1kQNUDJ7Xbf7NqrQje6XhT3b44BoWD/iR9r2hHcAveZLBmrm6Il8A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qGqKM-000ax4-Bk; Wed, 05 Jul 2023 02:25:02 +0200
Date: Wed, 5 Jul 2023 02:25:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: wei.fang@nxp.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com, netdev@vger.kernel.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net 3/3] net: fec: increase the size of tx ring and
 update thresholds of tx ring
Message-ID: <0443a057-767f-4f9c-afd2-37d26b606d74@lunn.ch>
References: <20230704082916.2135501-1-wei.fang@nxp.com>
 <20230704082916.2135501-4-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704082916.2135501-4-wei.fang@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> After trying various methods, I think that increase the size of tx
> BD ring is simple and effective. Maybe the best resolution is that
> allocate NAPI for each queue to improve the efficiency of the NAPI
> callback, but this change is a bit big and I didn't try this method.
> Perheps this method will be implemented in a future patch.

How does this affect platforms like Vybrid with its fast Ethernet?
Does the burst latency go up?

> In addtion, this patch also updates the tx_stop_threshold and the
> tx_wake_threshold of the tx ring. In previous logic, the value of
> tx_stop_threshold is 217, however, the value of tx_wake_threshold
> is 147, it does not make sense that tx_wake_threshold is less than
> tx_stop_threshold.

What do these actually mean? I could imagine that as the ring fills
you don't want to stop until it is 217/512 full. There is then some
hysteresis, such that it has to drop below 147/512 before more can be
added? 

> Besides, both XDP path and 'slow path' share the
> tx BD rings. So if tx_stop_threshold is 217, in the case of heavy
> XDP traffic, the slow path is easily to be stopped, this will have
> a serious impact on the slow path.

Please post your iperf results for various platforms, so we can see
the effects of this. We generally don't accept tuning patches without
benchmarks which prove the improvements, and also show there is no
regression. And given the wide variety of SoCs using the FEC, i expect
testing on a number of SoCs, but Fast and 1G.

	Andrew

