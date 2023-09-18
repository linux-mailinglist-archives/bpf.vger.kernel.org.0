Return-Path: <bpf+bounces-10321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C377A516D
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 19:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8F21281B8D
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 17:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72C9266DB;
	Mon, 18 Sep 2023 17:58:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C03266C7;
	Mon, 18 Sep 2023 17:58:44 +0000 (UTC)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5F6102;
	Mon, 18 Sep 2023 10:58:42 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-59bf1dde73fso44517377b3.3;
        Mon, 18 Sep 2023 10:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695059921; x=1695664721; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=84YJa0AaVgLnE24DhgC/8kuYxwokMsbSE42Xl2g4Dv0=;
        b=QHxKKW5ENnkoKvW1pluVelRdOXpd4S/e2HAIjZw1pZndiaku1eg5G2Z2Pvd986TpJf
         YWThgkneGWdy8JB8BnPtkv57IQI3b4pgODjSgqjDLiDsi/rKqRswBvKx8Uu/z//zY9nJ
         uQi7aybe/zErS6P5skN0ffxyoso3Td1je4EGFm0aYHGzW4yoOnBRiXRARqj2NDGkaoU9
         7yo89a4trnEvgUhwMD9C+Q3SlcTGnAubjPE9+RXfiP+l/humAD24tutqMpNk08Va9rBX
         7VDlS6iYOH3/4UhbAgE0Z8voESm8RWNIJ+sxWABvW5cRltLmaxBVnzARROn8u6xWV//p
         gYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695059921; x=1695664721;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=84YJa0AaVgLnE24DhgC/8kuYxwokMsbSE42Xl2g4Dv0=;
        b=sovn2maU7cQSXJ7YwOp23BLglOq+TtFqTljBRLU8PBoBUJpsMbupnm8aY+YdM4C4BT
         JtO2xPevt93hgv9vPPW0zvZrFzokpfaiI8dZFH7MhoYt2bxvrT+nTbvAXeysbBZxt7Aq
         VqL7SfEsOTJzq+O07VQyBTtgZ84klRiSMv/NaZZfZlSPGShqSOUceYoj8ugH5Ib/p7/k
         4alo4IIPzy+yx2o6TwCtQBbgp33MQkXoeclUN2j5n+Rz9GXKV4cBePeKd6ofZYIIeK4W
         tjYVSnbrWPIjgwoqsxCKjlD3FUGpYExrXvVdDzyfWRFK1FXTYqU7lNY/dpyrQJgLJwfh
         3aZw==
X-Gm-Message-State: AOJu0Yw7exmWr+LnaBHA7PPyIiJhBQPShh74k4iNqTodgGWVRg+iWgEr
	qlbu+u7n8NoaCMysWfBqJ3Y=
X-Google-Smtp-Source: AGHT+IEhx6D+yON0ymQNs/Qp9OrR1oSBBPnsJeiBK+ug/mq5TEjUms+6dNlajk11r3oy0BtZyW/xpA==
X-Received: by 2002:a81:5309:0:b0:576:fc3a:3ef5 with SMTP id h9-20020a815309000000b00576fc3a3ef5mr10107534ywb.47.1695059921392;
        Mon, 18 Sep 2023 10:58:41 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:cd9b:b05b:a4d3:eeda? ([2600:1700:6cf8:1240:cd9b:b05b:a4d3:eeda])
        by smtp.gmail.com with ESMTPSA id m131-20020a817189000000b00589dbcf16cbsm2731713ywc.35.2023.09.18.10.58.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 10:58:40 -0700 (PDT)
Message-ID: <aa182e22-e7b9-d8e7-04ea-781fe0fb9103@gmail.com>
Date: Mon, 18 Sep 2023 10:58:39 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net v2 3/3] octeontx2-pf: Do xdp_do_flush() after
 redirects.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, Geetha sowjanya <gakula@marvell.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>, Sunil Goutham
 <sgoutham@marvell.com>, hariprasad <hkelam@marvell.com>
References: <20230918153611.165722-1-bigeasy@linutronix.de>
 <20230918153611.165722-4-bigeasy@linutronix.de>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20230918153611.165722-4-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/18/23 08:36, Sebastian Andrzej Siewior wrote:
> xdp_do_flush() should be invoked before leaving the NAPI poll function
> if XDP-redirect has been performed.
> 
> Invoke xdp_do_flush() before leaving NAPI.
> 
> Cc: Geetha sowjanya <gakula@marvell.com>
> Cc: Subbaraya Sundeep <sbhatta@marvell.com>
> Cc: Sunil Goutham <sgoutham@marvell.com>
> Cc: hariprasad <hkelam@marvell.com>
> Fixes: 06059a1a9a4a5 ("octeontx2-pf: Add XDP support to netdev PF")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Acked-by: Geethasowjanya Akula <gakula@marvell.com>
> ---
>   .../marvell/octeontx2/nic/otx2_txrx.c         | 19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> index e77d438489557..53b2a4ef52985 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> @@ -29,7 +29,8 @@
>   static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
>   				     struct bpf_prog *prog,
>   				     struct nix_cqe_rx_s *cqe,
> -				     struct otx2_cq_queue *cq);
> +				     struct otx2_cq_queue *cq,
> +				     bool *need_xdp_flush);
>   
>   static int otx2_nix_cq_op_status(struct otx2_nic *pfvf,
>   				 struct otx2_cq_queue *cq)
> @@ -337,7 +338,7 @@ static bool otx2_check_rcv_errors(struct otx2_nic *pfvf,
>   static void otx2_rcv_pkt_handler(struct otx2_nic *pfvf,
>   				 struct napi_struct *napi,
>   				 struct otx2_cq_queue *cq,
> -				 struct nix_cqe_rx_s *cqe)
> +				 struct nix_cqe_rx_s *cqe, bool *need_xdp_flush)
>   {
>   	struct nix_rx_parse_s *parse = &cqe->parse;
>   	struct nix_rx_sg_s *sg = &cqe->sg;
> @@ -353,7 +354,7 @@ static void otx2_rcv_pkt_handler(struct otx2_nic *pfvf,
>   	}
>   
>   	if (pfvf->xdp_prog)
> -		if (otx2_xdp_rcv_pkt_handler(pfvf, pfvf->xdp_prog, cqe, cq))
> +		if (otx2_xdp_rcv_pkt_handler(pfvf, pfvf->xdp_prog, cqe, cq, need_xdp_flush))
>   			return;
>   
>   	skb = napi_get_frags(napi);
> @@ -388,6 +389,7 @@ static int otx2_rx_napi_handler(struct otx2_nic *pfvf,
>   				struct napi_struct *napi,
>   				struct otx2_cq_queue *cq, int budget)
>   {
> +	bool need_xdp_flush = false;
>   	struct nix_cqe_rx_s *cqe;
>   	int processed_cqe = 0;
>   
> @@ -409,13 +411,15 @@ static int otx2_rx_napi_handler(struct otx2_nic *pfvf,
>   		cq->cq_head++;
>   		cq->cq_head &= (cq->cqe_cnt - 1);
>   
> -		otx2_rcv_pkt_handler(pfvf, napi, cq, cqe);
> +		otx2_rcv_pkt_handler(pfvf, napi, cq, cqe, &need_xdp_flush);
>   
>   		cqe->hdr.cqe_type = NIX_XQE_TYPE_INVALID;
>   		cqe->sg.seg_addr = 0x00;
>   		processed_cqe++;
>   		cq->pend_cqe--;
>   	}
> +	if (need_xdp_flush)
> +		xdp_do_flush();
>   
>   	/* Free CQEs to HW */
>   	otx2_write64(pfvf, NIX_LF_CQ_OP_DOOR,
> @@ -1354,7 +1358,8 @@ bool otx2_xdp_sq_append_pkt(struct otx2_nic *pfvf, u64 iova, int len, u16 qidx)
>   static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
>   				     struct bpf_prog *prog,
>   				     struct nix_cqe_rx_s *cqe,
> -				     struct otx2_cq_queue *cq)
> +				     struct otx2_cq_queue *cq,
> +				     bool *need_xdp_flush)
>   {
>   	unsigned char *hard_start, *data;
>   	int qidx = cq->cq_idx;
> @@ -1391,8 +1396,10 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
>   
>   		otx2_dma_unmap_page(pfvf, iova, pfvf->rbsize,
>   				    DMA_FROM_DEVICE);
> -		if (!err)
> +		if (!err) {
> +			*need_xdp_flush = true;

Is it possible to call xdp_do_flush() at the first place (here)?

>   			return true;
> +		}
>   		put_page(page);
>   		break;
>   	default:

