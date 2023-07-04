Return-Path: <bpf+bounces-4010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB34D747A86
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 01:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 276FD1C2093B
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 23:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6AF8C01;
	Tue,  4 Jul 2023 23:48:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163EF882F;
	Tue,  4 Jul 2023 23:48:29 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13FFB2;
	Tue,  4 Jul 2023 16:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=djBxEq25qs+5OR8ZssEqtx77qeVop1kWx7fA/jsBTg8=; b=PSQDDrtOhDwEa8ppQeOf4ZBSCt
	AjUXlnqXC5ldJEDkXJKR9Q6k5u4DlxhC39fxcoZjtzTO/0Od2rgIiKh9qwfIL445Bc+/M9czbOorg
	6KTxYwo5rMo/cANp7tQTkiSK0ApkxazDQ04ebEzXemvP5cRlbiKQ1Y/crI1dnh+jfWoQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qGpko-000apo-Bv; Wed, 05 Jul 2023 01:48:18 +0200
Date: Wed, 5 Jul 2023 01:48:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: wei.fang@nxp.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com, netdev@vger.kernel.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net 2/3] net: fec: recycle pages for transmitted XDP
 frames
Message-ID: <2e3d30c1-f885-42f5-91c5-878da079d8a9@lunn.ch>
References: <20230704082916.2135501-1-wei.fang@nxp.com>
 <20230704082916.2135501-3-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704082916.2135501-3-wei.fang@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>  	/* Save skb pointer */
> -	txq->tx_skbuff[index] = skb;
> +	txq->tx_buf[index].skb = skb;

What about txq->tx_buf[index].type ?

> @@ -862,7 +860,7 @@ static int fec_enet_txq_submit_tso(struct fec_enet_priv_tx_q *txq,
>  	}
>  
>  	/* Save skb pointer */
> -	txq->tx_skbuff[index] = skb;
> +	txq->tx_buf[index].skb = skb;

here as well.

> +				/* restore default tx buffer type: FEC_TXBUF_T_SKB */
> +				txq->tx_buf[i].type = FEC_TXBUF_T_SKB;

Seems error prone. It would be safer to explicitly set it next to
assigning .skb/.xdp.

	  Andrew

