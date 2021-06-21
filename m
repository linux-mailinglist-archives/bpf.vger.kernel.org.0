Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6EF53AF75B
	for <lists+bpf@lfdr.de>; Mon, 21 Jun 2021 23:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhFUV2k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Jun 2021 17:28:40 -0400
Received: from www62.your-server.de ([213.133.104.62]:45026 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbhFUV2j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Jun 2021 17:28:39 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1lvRQz-000706-0H; Mon, 21 Jun 2021 23:26:21 +0200
Received: from [85.7.101.30] (helo=linux-3.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1lvRQy-000Eoh-PS; Mon, 21 Jun 2021 23:26:20 +0200
Subject: Re: [PATCH bpf-next v6 3/4] bpf: support specifying ingress via
 xdp_md context in BPF_PROG_TEST_RUN
To:     Zvi Effron <zeffron@riotgames.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Cody Haas <chaas@riotgames.com>,
        Lisa Watanabe <lwatanabe@riotgames.com>
References: <20210617232904.1899-1-zeffron@riotgames.com>
 <20210617232904.1899-4-zeffron@riotgames.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c3332ade-4a7a-b22a-9323-13cf0751888c@iogearbox.net>
Date:   Mon, 21 Jun 2021 23:26:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20210617232904.1899-4-zeffron@riotgames.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.2/26208/Mon Jun 21 13:09:26 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/18/21 1:29 AM, Zvi Effron wrote:
> Support specifying the ingress_ifindex and rx_queue_index of xdp_md
> contexts for BPF_PROG_TEST_RUN.
> 
> The intended use case is to allow testing XDP programs that make decisions
> based on the ingress interface or RX queue.
> 
> If ingress_ifindex is specified, look up the device by the provided index
> in the current namespace and use its xdp_rxq for the xdp_buff. If the
> rx_queue_index is out of range, or is non-zero when the ingress_ifindex is
> 0, return -EINVAL.
> 
> Co-developed-by: Cody Haas <chaas@riotgames.com>
> Signed-off-by: Cody Haas <chaas@riotgames.com>
> Co-developed-by: Lisa Watanabe <lwatanabe@riotgames.com>
> Signed-off-by: Lisa Watanabe <lwatanabe@riotgames.com>
> Signed-off-by: Zvi Effron <zeffron@riotgames.com>
> ---
>   net/bpf/test_run.c | 22 +++++++++++++++++++++-
>   1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 229c5deb813c..1ba15c741517 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -690,15 +690,35 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>   
>   static int xdp_convert_md_to_buff(struct xdp_md *xdp_md, struct xdp_buff *xdp)
>   {
> +	unsigned int ingress_ifindex, rx_queue_index;
> +	struct netdev_rx_queue *rxqueue;
> +	struct net_device *device;
> +
>   	if (!xdp_md)
>   		return 0;
>   
>   	if (xdp_md->egress_ifindex != 0)
>   		return -EINVAL;
>   
> -	if (xdp_md->ingress_ifindex != 0 || xdp_md->rx_queue_index != 0)
> +	ingress_ifindex = xdp_md->ingress_ifindex;
> +	rx_queue_index = xdp_md->rx_queue_index;
> +
> +	if (!ingress_ifindex && rx_queue_index)
>   		return -EINVAL;
>   
> +	if (ingress_ifindex) {
> +		device = dev_get_by_index(current->nsproxy->net_ns,
> +					  ingress_ifindex);

This takes a reference on the device, which seems to be leaked here?

> +		if (!device)
> +			return -EINVAL;
> +
> +		if (rx_queue_index >= device->real_num_rx_queues)
> +			return -EINVAL;
> +
> +		rxqueue = __netif_get_rx_queue(device, rx_queue_index);
> +		xdp->rxq = &rxqueue->xdp_rxq;
> +	}
> +
>   	xdp->data = xdp->data_meta + xdp_md->data;
>   
>   	return 0;
> 

