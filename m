Return-Path: <bpf+bounces-4148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4F3749415
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 05:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 992972811FF
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 03:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110A0EBB;
	Thu,  6 Jul 2023 03:11:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94217E9;
	Thu,  6 Jul 2023 03:11:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89955C433C8;
	Thu,  6 Jul 2023 03:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688613117;
	bh=yWdV7ZYJcwz2B3RUMrTub/yaskmu17/qCOO5ZtZOOFI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DiiZuHyaw6qK144HdreOdxREqjVe+3kzVaELyEbuWe+oYF3YyQ1rR78MpHIh1MJF8
	 r9TloAHMIU/zJuShmQ6MwSwqtiwnUETUQnBsV5/Q5bZ4jH3d8y75wjZ5uTV3sI6gLf
	 Mn/a141vFtXBNJbSyIgve+mAp+tbNd/BnV6n7g+EIS93KeYlTlATmCqiTszKgncSr9
	 KR/yminicEi98MEC3xNX5fPnOsaxl/SI4s4WW4F1dLd2sa90JBoENse2lzjmWOwAJj
	 BFRwC7MvEYu1Ela8U3voI3wC+PPb0nXLIl9QqPj5A3XaEPocXvzfcZQKMmQd3ObUnf
	 wsw7btt2NDhcw==
Date: Wed, 5 Jul 2023 20:11:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "ast@kernel.org" <ast@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>, "hawk@kernel.org"
 <hawk@kernel.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
 Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, dl-linux-imx
 <linux-imx@nxp.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH net 3/3] net: fec: increase the size of tx ring and
 update thresholds of tx ring
Message-ID: <20230705201155.5a05bf18@kernel.org>
In-Reply-To: <AM5PR04MB3139ED2B0F74BBD00B85A448882CA@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20230704082916.2135501-1-wei.fang@nxp.com>
	<20230704082916.2135501-4-wei.fang@nxp.com>
	<0443a057-767f-4f9c-afd2-37d26b606d74@lunn.ch>
	<AM5PR04MB3139789F6CCA4BEC8A871C1D882FA@AM5PR04MB3139.eurprd04.prod.outlook.com>
	<20230705111119.07c3dee3@kernel.org>
	<AM5PR04MB3139ED2B0F74BBD00B85A448882CA@AM5PR04MB3139.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Jul 2023 01:44:49 +0000 Wei Fang wrote:
> > But you shouldn't restart the queue for a single packet either.
> > Restarting for a single packet wastes CPU cycles as there will be much more
> > stop / start operations. Two large packets seem like the absolute minimum
> > reasonable wake threshold.
> > 
> > Setting tx_stop_threshold to MAX_SKB_FRAGS doesn't seem right either, as
> > you won't be able to accept a full TSO frame.
> >   
> Maybe I should keep the tx_stop_threshold unchanged, so that the queue is
> to be stopped if the available BDs is not enough for a full TSO frame to be attached.
> And then just change tx_wake_threshold to tx_stop_threshold + 1, which I think it's
> more reasonable.

How about at least tx_stop_threshold + 2 * MAX_SKB_FRAGS ?
If a queue of hundreds of entries is overflowing, we should be able 
to apply a hysteresis of a few tens of entries. Do you see a
difference in drops? The packets from the stack should preferably stay
in the qdiscs instead of the driver queue, where AQM and scheduling can
be applied.

