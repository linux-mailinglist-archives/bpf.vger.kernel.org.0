Return-Path: <bpf+bounces-11683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 858567BD4EF
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 10:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8B041C20B15
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 08:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87240154A7;
	Mon,  9 Oct 2023 08:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ji2IMxv1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8F5FBF9;
	Mon,  9 Oct 2023 08:12:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E90EC433C8;
	Mon,  9 Oct 2023 08:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696839161;
	bh=FuMe2valXJSb5IfSuggvXhu0GEsiBLS5QMggzJ0KYKo=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Ji2IMxv1dPttQWMicDFLlnE/8aGY0bilEfR2SVUxG1evJqjA8c26Sr4xZBxXaIrxw
	 zrfrO27Yf28W7vDCvehZPOhiYZDLvR+CDjk5ZRbUvkMe82oEgiNl2dUoO4llTzY3op
	 MiWMZ3A37W7rfu2acGhg2BjSHjTV8jyeYFS2C/bej63XHuvbYIxWCJfR75Yb4Kksyb
	 9P9NAhtyzsuVpol6RVRZL6eUorYy4NHRsYif8559luDUiDiNjOX2fUpo6wIfsVasSt
	 I6qkXpFuIqTe2UeGS61ah7T/K0CforP9uBHJmyhtUlqOvqtEt4M+U561Twb9jCWuod
	 isTykP1oYWdZg==
Message-ID: <532af030-f2a6-5569-549b-bbd012ad2640@kernel.org>
Date: Mon, 9 Oct 2023 10:12:34 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc: hawk@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org, kuba@kernel.org,
 toke@kernel.org, willemb@google.com, dsahern@kernel.org,
 magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com,
 yoong.siang.song@intel.com, netdev@vger.kernel.org, xdp-hints@xdp-project.net
Subject: Re: [PATCH bpf-next v3 09/10] selftests/bpf: Add TX side to
 xdp_hw_metadata
To: Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
References: <20231003200522.1914523-1-sdf@google.com>
 <20231003200522.1914523-10-sdf@google.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20231003200522.1914523-10-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/10/2023 22.05, Stanislav Fomichev wrote:
> When we get a packet on port 9091, we swap src/dst and send it out.
> At this point we also request the timestamp and checksum offloads.
> 
> Checksum offload is verified by looking at the tcpdump on the other side.
> The tool prints pseudo-header csum and the final one it expects.
> The final checksum actually matches the incoming packets checksum
> because we only flip the src/dst and don't change the payload.
> 
> Some other related changes:
> - switched to zerocopy mode by default; new flag can be used to force
>    old behavior
> - request fixed tx_metadata_len headroom
> - some other small fixes (umem size, fill idx+i, etc)
> 
> mvbz3:~# ./xdp_hw_metadata eth3
> ...
> 0x1062cb8: rx_desc[0]->addr=80100 addr=80100 comp_addr=80100
> rx_hash: 0x2E1B50B9 with RSS type:0x2A
> rx_timestamp:  1691436369532047139 (sec:1691436369.5320)
> XDP RX-time:   1691436369261756803 (sec:1691436369.2618) delta sec:-0.2703 (-270290.336 usec)

I guess system time isn't configured to be in sync with NIC HW time,
as delta is a negative offset.

> AF_XDP time:   1691436369261878839 (sec:1691436369.2619) delta sec:0.0001 (122.036 usec)
The AF_XDP time is also software system time and compared to XDP
RX-time, it shows a delta of 122 usec.  This number indicate to me that
the CPU is likely configured with power saving sleep states.

> 0x1062cb8: ping-pong with csum=3b8e (want de7e) csum_start=54 csum_offset=6
> 0x1062cb8: complete tx idx=0 addr=10
> 0x1062cb8: tx_timestamp:  1691436369598419505 (sec:1691436369.5984)

Could we add something that we can relate tx_timestamp to?

Like we do with the other delta calculations, as it helps us to
understand/validate if the number we get back is sane. Like negative
offset aboves tells us that system time sync isn't configured, and that
system have configures C-states.

I suggest delta comparing "tx_timestamp" to "rx_timestamp", as they are
the same clock domain.  It will tell us the total time spend from HW RX
to HW TX, counting all the time used by software "ping-pong".

  1691436369.5984-1691436369.5320 = 0.0664 sec = 66.4 ms

When implementing this, it could be (1) practical to store the
"rx_timestamp" in the metadata area of the completion packet, or (2)
should we have a mechanism for external storage that can be keyed on the
umem "addr"?

> 0x1062cb8: complete rx idx=128 addr=80100
> 
> mvbz4:~# nc  -Nu -q1 ${MVBZ3_LINK_LOCAL_IP}%eth3 9091
> 
> mvbz4:~# tcpdump -vvx -i eth3 udp
> 	tcpdump: listening on eth3, link-type EN10MB (Ethernet), snapshot length 262144 bytes
> 12:26:09.301074 IP6 (flowlabel 0x35fa5, hlim 127, next-header UDP (17) payload length: 11) fe80::1270:fdff:fe48:1087.55807 > fe80::1270:fdff:fe48:1077.9091: [bad udp cksum 0x3b8e -> 0xde7e!] UDP, length 3
>          0x0000:  6003 5fa5 000b 117f fe80 0000 0000 0000
>          0x0010:  1270 fdff fe48 1087 fe80 0000 0000 0000
>          0x0020:  1270 fdff fe48 1077 d9ff 2383 000b 3b8e
>          0x0030:  7864 70
> 12:26:09.301976 IP6 (flowlabel 0x35fa5, hlim 127, next-header UDP (17) payload length: 11) fe80::1270:fdff:fe48:1077.9091 > fe80::1270:fdff:fe48:1087.55807: [udp sum ok] UDP, length 3
>          0x0000:  6003 5fa5 000b 117f fe80 0000 0000 0000
>          0x0010:  1270 fdff fe48 1077 fe80 0000 0000 0000
>          0x0020:  1270 fdff fe48 1087 2383 d9ff 000b de7e
>          0x0030:  7864 70
> 
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>   tools/testing/selftests/bpf/xdp_hw_metadata.c | 202 +++++++++++++++++-
>   1 file changed, 192 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> index 613321eb84c1..ab83d0ba6763 100644
> --- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
> +++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> @@ -10,7 +10,9 @@
>    *   - rx_hash
>    *
>    * TX:
> - * - TBD
> + * - UDP 9091 packets trigger TX reply
> + * - TX HW timestamp is requested and reported back upon completion
> + * - TX checksum is requested
>    */
>   
>   #include <test_progs.h>
> @@ -24,14 +26,17 @@
[...]
> @@ -51,22 +56,24 @@ struct xsk *rx_xsk;
[...]
> @@ -129,12 +136,22 @@ static void refill_rx(struct xsk *xsk, __u64 addr)
[...]
> @@ -228,6 +245,117 @@ static void verify_skb_metadata(int fd)
>   	printf("skb hwtstamp is not found!\n");
>   }
>   
> +static bool complete_tx(struct xsk *xsk)
> +{
> +	struct xsk_tx_metadata *meta;
> +	__u64 addr;
> +	void *data;
> +	__u32 idx;
> +
> +	if (!xsk_ring_cons__peek(&xsk->comp, 1, &idx))
> +		return false;
> +
> +	addr = *xsk_ring_cons__comp_addr(&xsk->comp, idx);
> +	data = xsk_umem__get_data(xsk->umem_area, addr);
> +	meta = data - sizeof(struct xsk_tx_metadata);
> +
> +	printf("%p: complete tx idx=%u addr=%llx\n", xsk, idx, addr);
> +	printf("%p: tx_timestamp:  %llu (sec:%0.4f)\n", xsk,
> +	       meta->completion.tx_timestamp,
> +	       (double)meta->completion.tx_timestamp / NANOSEC_PER_SEC);
> +	xsk_ring_cons__release(&xsk->comp, 1);
> +
> +	return true;
> +}
> +
> +#define swap(a, b, len) do { \
> +	for (int i = 0; i < len; i++) { \
> +		__u8 tmp = ((__u8 *)a)[i]; \
> +		((__u8 *)a)[i] = ((__u8 *)b)[i]; \
> +		((__u8 *)b)[i] = tmp; \
> +	} \
> +} while (0)
> +
> +static void ping_pong(struct xsk *xsk, void *rx_packet)
> +{
> +	struct xsk_tx_metadata *meta;
> +	struct ipv6hdr *ip6h = NULL;
> +	struct iphdr *iph = NULL;
> +	struct xdp_desc *tx_desc;
> +	struct udphdr *udph;
> +	struct ethhdr *eth;
> +	__sum16 want_csum;
> +	void *data;
> +	__u32 idx;
> +	int ret;
> +	int len;
> +
> +	ret = xsk_ring_prod__reserve(&xsk->tx, 1, &idx);
> +	if (ret != 1) {
> +		printf("%p: failed to reserve tx slot\n", xsk);
> +		return;
> +	}
> +
> +	tx_desc = xsk_ring_prod__tx_desc(&xsk->tx, idx);
> +	tx_desc->addr = idx % (UMEM_NUM / 2) * UMEM_FRAME_SIZE + sizeof(struct xsk_tx_metadata);
> +	data = xsk_umem__get_data(xsk->umem_area, tx_desc->addr);
> +
> +	meta = data - sizeof(struct xsk_tx_metadata);
> +	memset(meta, 0, sizeof(*meta));
> +	meta->flags = XDP_TX_METADATA_TIMESTAMP;
> +
> +	eth = rx_packet;
> +
> +	if (eth->h_proto == htons(ETH_P_IP)) {
> +		iph = (void *)(eth + 1);
> +		udph = (void *)(iph + 1);
> +	} else if (eth->h_proto == htons(ETH_P_IPV6)) {
> +		ip6h = (void *)(eth + 1);
> +		udph = (void *)(ip6h + 1);
> +	} else {
> +		printf("%p: failed to detect IP version for ping pong %04x\n", xsk, eth->h_proto);
> +		xsk_ring_prod__cancel(&xsk->tx, 1);
> +		return;
> +	}
> +
> +	len = ETH_HLEN;
> +	if (ip6h)
> +		len += sizeof(*ip6h) + ntohs(ip6h->payload_len);
> +	if (iph)
> +		len += ntohs(iph->tot_len);
> +
> +	swap(eth->h_dest, eth->h_source, ETH_ALEN);
> +	if (iph)
> +		swap(&iph->saddr, &iph->daddr, 4);
> +	else
> +		swap(&ip6h->saddr, &ip6h->daddr, 16);
> +	swap(&udph->source, &udph->dest, 2);
> +
> +	want_csum = udph->check;
> +	if (ip6h)
> +		udph->check = ~csum_ipv6_magic(&ip6h->saddr, &ip6h->daddr,
> +					       ntohs(udph->len), IPPROTO_UDP, 0);
> +	else
> +		udph->check = ~csum_tcpudp_magic(iph->saddr, iph->daddr,
> +						 ntohs(udph->len), IPPROTO_UDP, 0);
> +
> +	meta->flags |= XDP_TX_METADATA_CHECKSUM;
> +	if (iph)
> +		meta->csum_start = sizeof(*eth) + sizeof(*iph);
> +	else
> +		meta->csum_start = sizeof(*eth) + sizeof(*ip6h);
> +	meta->csum_offset = offsetof(struct udphdr, check);
> +
> +	printf("%p: ping-pong with csum=%04x (want %04x) csum_start=%d csum_offset=%d\n",
> +	       xsk, ntohs(udph->check), ntohs(want_csum), meta->csum_start, meta->csum_offset);
> +
> +	memcpy(data, rx_packet, len); /* don't share umem chunk for simplicity */
> +	tx_desc->options |= XDP_TX_METADATA;
> +	tx_desc->len = len;
> +
> +	xsk_ring_prod__submit(&xsk->tx, 1);
> +}
> +
>   static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t clock_id)
>   {
>   	const struct xdp_desc *rx_desc;
> @@ -250,6 +378,13 @@ static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t
>   
>   	while (true) {
>   		errno = 0;
> +
> +		for (i = 0; i < rxq; i++) {
> +			ret = kick_rx(&rx_xsk[i]);
> +			if (ret)
> +				printf("kick_rx ret=%d\n", ret);
> +		}
> +
>   		ret = poll(fds, rxq + 1, 1000);
>   		printf("poll: %d (%d) skip=%llu fail=%llu redir=%llu\n",
>   		       ret, errno, bpf_obj->bss->pkts_skip,
> @@ -280,6 +415,22 @@ static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t
>   			       xsk, idx, rx_desc->addr, addr, comp_addr);
>   			verify_xdp_metadata(xsk_umem__get_data(xsk->umem_area, addr),
>   					    clock_id);
> +
> +			if (!skip_tx) {
> +				/* mirror the packet back */
> +				ping_pong(xsk, xsk_umem__get_data(xsk->umem_area, addr));
> +
> +				ret = kick_tx(xsk);
> +				if (ret)
> +					printf("kick_tx ret=%d\n", ret);
> +
> +				for (int j = 0; j < 500; j++) {
> +					if (complete_tx(xsk))
> +						break;
> +					usleep(10*1000);

I don't fully follow why we need this usleep here.

> +				}
> +			}
> +
>   			xsk_ring_cons__release(&xsk->rx, 1);
>   			refill_rx(xsk, comp_addr);
>   		}
> @@ -404,21 +555,52 @@ static void timestamping_enable(int fd, int val)

