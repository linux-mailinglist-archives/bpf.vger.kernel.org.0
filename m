Return-Path: <bpf+bounces-7044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BEB770A3A
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 23:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D250282692
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 21:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DB71DA53;
	Fri,  4 Aug 2023 21:01:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7F61DA3D;
	Fri,  4 Aug 2023 21:01:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1190C433C8;
	Fri,  4 Aug 2023 21:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691182890;
	bh=6OIr/MSf9FOl1vGca/ZPHp09IpYJdHQW2UEvmBNfWkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QjSytdoSgVP0ySkaaCT/sbm+LxdhYJOuAjrjOYcrHCnzNRAOtZ4U7fCav+OZgMwuh
	 Ua5GlXkmjIQekXuv4FQ+ikO9AmykSWYnAWfVTuwDNh9bCvqEhcNKFhVB9Iwq3od6w9
	 d9nj7BsgRWBGSbRVr8BYFGb7qWw7SG2uXUkW/c4oSiWHBV9NSe4Qmtpfnc3wfGvri0
	 bp7N8s8jq3WCcFZy5fp20YNmAdm/KE05mRrVG0q69shSWSGCunevEoaETwN7zvDvbW
	 Mi8hU2kVqKSEFjdULsLjRSQsSZOgptFJQwuN5ewBcFeI2tE5VmfrpqmBwUfy8G6EQq
	 WmKe/EXpW+QKg==
Date: Fri, 4 Aug 2023 23:01:24 +0200
From: Simon Horman <horms@kernel.org>
To: "huangjie.albert" <huangjie.albert@bytedance.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Shmulik Ladkani <shmulik.ladkani@gmail.com>,
	Kees Cook <keescook@chromium.org>,
	Richard Gobert <richardbgobert@gmail.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Subject: Re: [RFC Optimizing veth xsk performance 06/10] veth: add
 ndo_xsk_wakeup callback for veth
Message-ID: <ZM1nJPEAKLjM1YN/@vergenet.net>
References: <20230803140441.53596-1-huangjie.albert@bytedance.com>
 <20230803140441.53596-7-huangjie.albert@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803140441.53596-7-huangjie.albert@bytedance.com>

On Thu, Aug 03, 2023 at 10:04:32PM +0800, huangjie.albert wrote:
> Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
> ---
>  drivers/net/veth.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 944761807ca4..600225e27e9e 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -1840,6 +1840,45 @@ static void veth_set_rx_headroom(struct net_device *dev, int new_hr)
>  	rcu_read_unlock();
>  }
>  
> +static void veth_xsk_remote_trigger_napi(void *info)
> +{
> +	struct veth_sq *sq = info;
> +
> +	napi_schedule(&sq->xdp_napi);
> +}
> +
> +static int veth_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
> +{
> +	struct veth_priv *priv;
> +	struct veth_sq *sq;
> +	u32 last_cpu, cur_cpu;
> +
> +	if (!netif_running(dev))
> +		return -ENETDOWN;
> +
> +	if (qid >= dev->real_num_rx_queues)
> +		return -EINVAL;
> +
> +	priv = netdev_priv(dev);
> +	sq = &priv->sq[qid];
> +
> +	if (napi_if_scheduled_mark_missed(&sq->xdp_napi))
> +		return 0;
> +
> +	last_cpu = sq->xsk.last_cpu;
> +	cur_cpu = get_cpu();
> +
> +	/*  raise a napi */
> +	if (last_cpu == cur_cpu) {
> +		napi_schedule(&sq->xdp_napi);
> +	} else {
> +		smp_call_function_single(last_cpu, veth_xsk_remote_trigger_napi, sq, true);
> +	}

nit: no need for braces in the above.

	if (last_cpu == cur_cpu)
		napi_schedule(&sq->xdp_napi);
	else
		smp_call_function_single(last_cpu, veth_xsk_remote_trigger_napi, sq, true);

...

