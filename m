Return-Path: <bpf+bounces-11736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FCA7BE69F
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 18:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFA45281C3B
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 16:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E9A1CFB0;
	Mon,  9 Oct 2023 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cpc0A4X5"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C571A72A
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 16:37:25 +0000 (UTC)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE47B199
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 09:37:23 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-58c3a049bb7so842874a12.3
        for <bpf@vger.kernel.org>; Mon, 09 Oct 2023 09:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696869443; x=1697474243; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3m3SpqAXKqi5m7nXpXd0Do4Y76UUJJ1VzcUzwnnYBk0=;
        b=Cpc0A4X5YIKB9vHKZS+rnjBKybtFest99A8834kMx1yDCh529ALBMEVpjaweCIKGZM
         oAKxgHELh7EsqYeormye/043AEfhL7CxhsQP8wBscW1h8YJp4ak6s0yo77RBx4zxAbyI
         DQJgCvZRz6UCpF5EMAAhjMCm6FExbennbTIzz0R1KjaETlW+g6rzcFSgmxYBJlOEH6L0
         Rv3OPi6y7rQzo9++4nt3OAUhTphY7eHMH0lR5vYo/QbQySrNynN7rRULgHDS3RP6h/fB
         /pfQ3BNMvbJ+V1HmBGw6ciDtiyCHs2PnNfRCt6A5nCWJJSoWE/V1a/qXKMP659WaGMbp
         GTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696869443; x=1697474243;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3m3SpqAXKqi5m7nXpXd0Do4Y76UUJJ1VzcUzwnnYBk0=;
        b=cCfcr0DEy8eatdDNs3TSUieBN+qmylBgihblV4+TuIWeWkG53kntrX+nHPdY6znLVd
         XT5sLUrGmGNXqe4uPHnudedx4uuCx2689EG1a1LAq3zFDDGire4G35HHNIe4uCpUkXTI
         hb3hu1mA1E/2+HVjMnyFNcvfkAHdOXNDoIAN4afZR9aCMzZd4Jx9+08hclBVFnKW7OlC
         hqg94mw5jvn2lOIMb82oS3MgMP/3vcdmQw/YCpFwSFcoi9nPR1lxDX7/sc6DvaZxQkAL
         w6uKE5uPm27/rXWzT3RVfvxAqPR3OqNgHQrd+JhdxYE7itzoJy0QKKp55clE4WOYIHjN
         GReg==
X-Gm-Message-State: AOJu0YyvMy5sbHUuACMG0WbHt7+gWfz/5qWhkWchZPli67BcCazrd0F4
	yrOtJbf9U4vF73rZf2fppfOOVWs=
X-Google-Smtp-Source: AGHT+IHblrMcjqHuPj4ADoYiWBD6pjQUggZ7Vw1fFKOvfplusdZi3rc035YBnB1D+pxeH4/MrmWZdas=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a65:5085:0:b0:589:88e8:3ef1 with SMTP id
 r5-20020a655085000000b0058988e83ef1mr163501pgp.0.1696869442902; Mon, 09 Oct
 2023 09:37:22 -0700 (PDT)
Date: Mon, 9 Oct 2023 09:37:20 -0700
In-Reply-To: <532af030-f2a6-5569-549b-bbd012ad2640@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231003200522.1914523-1-sdf@google.com> <20231003200522.1914523-10-sdf@google.com>
 <532af030-f2a6-5569-549b-bbd012ad2640@kernel.org>
Message-ID: <ZSQsQMLUIum1hmOI@google.com>
Subject: Re: [PATCH bpf-next v3 09/10] selftests/bpf: Add TX side to xdp_hw_metadata
From: Stanislav Fomichev <sdf@google.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, kuba@kernel.org, toke@kernel.org, willemb@google.com, 
	dsahern@kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org, 
	maciej.fijalkowski@intel.com, yoong.siang.song@intel.com, 
	netdev@vger.kernel.org, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/09, Jesper Dangaard Brouer wrote:
> 
> 
> On 03/10/2023 22.05, Stanislav Fomichev wrote:
> > When we get a packet on port 9091, we swap src/dst and send it out.
> > At this point we also request the timestamp and checksum offloads.
> > 
> > Checksum offload is verified by looking at the tcpdump on the other side.
> > The tool prints pseudo-header csum and the final one it expects.
> > The final checksum actually matches the incoming packets checksum
> > because we only flip the src/dst and don't change the payload.
> > 
> > Some other related changes:
> > - switched to zerocopy mode by default; new flag can be used to force
> >    old behavior
> > - request fixed tx_metadata_len headroom
> > - some other small fixes (umem size, fill idx+i, etc)
> > 
> > mvbz3:~# ./xdp_hw_metadata eth3
> > ...
> > 0x1062cb8: rx_desc[0]->addr=80100 addr=80100 comp_addr=80100
> > rx_hash: 0x2E1B50B9 with RSS type:0x2A
> > rx_timestamp:  1691436369532047139 (sec:1691436369.5320)
> > XDP RX-time:   1691436369261756803 (sec:1691436369.2618) delta sec:-0.2703 (-270290.336 usec)
> 
> I guess system time isn't configured to be in sync with NIC HW time,
> as delta is a negative offset.
> 
> > AF_XDP time:   1691436369261878839 (sec:1691436369.2619) delta sec:0.0001 (122.036 usec)
> The AF_XDP time is also software system time and compared to XDP
> RX-time, it shows a delta of 122 usec.  This number indicate to me that
> the CPU is likely configured with power saving sleep states.

Yes, I don't do any synchronization and don't disable the sleep states.

> > 0x1062cb8: ping-pong with csum=3b8e (want de7e) csum_start=54 csum_offset=6
> > 0x1062cb8: complete tx idx=0 addr=10
> > 0x1062cb8: tx_timestamp:  1691436369598419505 (sec:1691436369.5984)
> 
> Could we add something that we can relate tx_timestamp to?
> 
> Like we do with the other delta calculations, as it helps us to
> understand/validate if the number we get back is sane. Like negative
> offset aboves tells us that system time sync isn't configured, and that
> system have configures C-states.
> 
> I suggest delta comparing "tx_timestamp" to "rx_timestamp", as they are
> the same clock domain.  It will tell us the total time spend from HW RX
> to HW TX, counting all the time used by software "ping-pong".
> 
>  1691436369.5984-1691436369.5320 = 0.0664 sec = 66.4 ms
> 
> When implementing this, it could be (1) practical to store the
> "rx_timestamp" in the metadata area of the completion packet, or (2)
> should we have a mechanism for external storage that can be keyed on the
> umem "addr"?

Sounds good. I can probably just store last rx_timestamp somewhere in the
global var and do a delta on tx? Since the test is single threaded
and sequential, not sure we need the mechanism to pass the tstamp around.
LMK if you disagree and I'm missing something.

> > 0x1062cb8: complete rx idx=128 addr=80100
> > 
> > mvbz4:~# nc  -Nu -q1 ${MVBZ3_LINK_LOCAL_IP}%eth3 9091
> > 
> > mvbz4:~# tcpdump -vvx -i eth3 udp
> > 	tcpdump: listening on eth3, link-type EN10MB (Ethernet), snapshot length 262144 bytes
> > 12:26:09.301074 IP6 (flowlabel 0x35fa5, hlim 127, next-header UDP (17) payload length: 11) fe80::1270:fdff:fe48:1087.55807 > fe80::1270:fdff:fe48:1077.9091: [bad udp cksum 0x3b8e -> 0xde7e!] UDP, length 3
> >          0x0000:  6003 5fa5 000b 117f fe80 0000 0000 0000
> >          0x0010:  1270 fdff fe48 1087 fe80 0000 0000 0000
> >          0x0020:  1270 fdff fe48 1077 d9ff 2383 000b 3b8e
> >          0x0030:  7864 70
> > 12:26:09.301976 IP6 (flowlabel 0x35fa5, hlim 127, next-header UDP (17) payload length: 11) fe80::1270:fdff:fe48:1077.9091 > fe80::1270:fdff:fe48:1087.55807: [udp sum ok] UDP, length 3
> >          0x0000:  6003 5fa5 000b 117f fe80 0000 0000 0000
> >          0x0010:  1270 fdff fe48 1077 fe80 0000 0000 0000
> >          0x0020:  1270 fdff fe48 1087 2383 d9ff 000b de7e
> >          0x0030:  7864 70
> > 
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >   tools/testing/selftests/bpf/xdp_hw_metadata.c | 202 +++++++++++++++++-
> >   1 file changed, 192 insertions(+), 10 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> > index 613321eb84c1..ab83d0ba6763 100644
> > --- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
> > +++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> > @@ -10,7 +10,9 @@
> >    *   - rx_hash
> >    *
> >    * TX:
> > - * - TBD
> > + * - UDP 9091 packets trigger TX reply
> > + * - TX HW timestamp is requested and reported back upon completion
> > + * - TX checksum is requested
> >    */
> >   #include <test_progs.h>
> > @@ -24,14 +26,17 @@
> [...]
> > @@ -51,22 +56,24 @@ struct xsk *rx_xsk;
> [...]
> > @@ -129,12 +136,22 @@ static void refill_rx(struct xsk *xsk, __u64 addr)
> [...]
> > @@ -228,6 +245,117 @@ static void verify_skb_metadata(int fd)
> >   	printf("skb hwtstamp is not found!\n");
> >   }
> > +static bool complete_tx(struct xsk *xsk)
> > +{
> > +	struct xsk_tx_metadata *meta;
> > +	__u64 addr;
> > +	void *data;
> > +	__u32 idx;
> > +
> > +	if (!xsk_ring_cons__peek(&xsk->comp, 1, &idx))
> > +		return false;
> > +
> > +	addr = *xsk_ring_cons__comp_addr(&xsk->comp, idx);
> > +	data = xsk_umem__get_data(xsk->umem_area, addr);
> > +	meta = data - sizeof(struct xsk_tx_metadata);
> > +
> > +	printf("%p: complete tx idx=%u addr=%llx\n", xsk, idx, addr);
> > +	printf("%p: tx_timestamp:  %llu (sec:%0.4f)\n", xsk,
> > +	       meta->completion.tx_timestamp,
> > +	       (double)meta->completion.tx_timestamp / NANOSEC_PER_SEC);
> > +	xsk_ring_cons__release(&xsk->comp, 1);
> > +
> > +	return true;
> > +}
> > +
> > +#define swap(a, b, len) do { \
> > +	for (int i = 0; i < len; i++) { \
> > +		__u8 tmp = ((__u8 *)a)[i]; \
> > +		((__u8 *)a)[i] = ((__u8 *)b)[i]; \
> > +		((__u8 *)b)[i] = tmp; \
> > +	} \
> > +} while (0)
> > +
> > +static void ping_pong(struct xsk *xsk, void *rx_packet)
> > +{
> > +	struct xsk_tx_metadata *meta;
> > +	struct ipv6hdr *ip6h = NULL;
> > +	struct iphdr *iph = NULL;
> > +	struct xdp_desc *tx_desc;
> > +	struct udphdr *udph;
> > +	struct ethhdr *eth;
> > +	__sum16 want_csum;
> > +	void *data;
> > +	__u32 idx;
> > +	int ret;
> > +	int len;
> > +
> > +	ret = xsk_ring_prod__reserve(&xsk->tx, 1, &idx);
> > +	if (ret != 1) {
> > +		printf("%p: failed to reserve tx slot\n", xsk);
> > +		return;
> > +	}
> > +
> > +	tx_desc = xsk_ring_prod__tx_desc(&xsk->tx, idx);
> > +	tx_desc->addr = idx % (UMEM_NUM / 2) * UMEM_FRAME_SIZE + sizeof(struct xsk_tx_metadata);
> > +	data = xsk_umem__get_data(xsk->umem_area, tx_desc->addr);
> > +
> > +	meta = data - sizeof(struct xsk_tx_metadata);
> > +	memset(meta, 0, sizeof(*meta));
> > +	meta->flags = XDP_TX_METADATA_TIMESTAMP;
> > +
> > +	eth = rx_packet;
> > +
> > +	if (eth->h_proto == htons(ETH_P_IP)) {
> > +		iph = (void *)(eth + 1);
> > +		udph = (void *)(iph + 1);
> > +	} else if (eth->h_proto == htons(ETH_P_IPV6)) {
> > +		ip6h = (void *)(eth + 1);
> > +		udph = (void *)(ip6h + 1);
> > +	} else {
> > +		printf("%p: failed to detect IP version for ping pong %04x\n", xsk, eth->h_proto);
> > +		xsk_ring_prod__cancel(&xsk->tx, 1);
> > +		return;
> > +	}
> > +
> > +	len = ETH_HLEN;
> > +	if (ip6h)
> > +		len += sizeof(*ip6h) + ntohs(ip6h->payload_len);
> > +	if (iph)
> > +		len += ntohs(iph->tot_len);
> > +
> > +	swap(eth->h_dest, eth->h_source, ETH_ALEN);
> > +	if (iph)
> > +		swap(&iph->saddr, &iph->daddr, 4);
> > +	else
> > +		swap(&ip6h->saddr, &ip6h->daddr, 16);
> > +	swap(&udph->source, &udph->dest, 2);
> > +
> > +	want_csum = udph->check;
> > +	if (ip6h)
> > +		udph->check = ~csum_ipv6_magic(&ip6h->saddr, &ip6h->daddr,
> > +					       ntohs(udph->len), IPPROTO_UDP, 0);
> > +	else
> > +		udph->check = ~csum_tcpudp_magic(iph->saddr, iph->daddr,
> > +						 ntohs(udph->len), IPPROTO_UDP, 0);
> > +
> > +	meta->flags |= XDP_TX_METADATA_CHECKSUM;
> > +	if (iph)
> > +		meta->csum_start = sizeof(*eth) + sizeof(*iph);
> > +	else
> > +		meta->csum_start = sizeof(*eth) + sizeof(*ip6h);
> > +	meta->csum_offset = offsetof(struct udphdr, check);
> > +
> > +	printf("%p: ping-pong with csum=%04x (want %04x) csum_start=%d csum_offset=%d\n",
> > +	       xsk, ntohs(udph->check), ntohs(want_csum), meta->csum_start, meta->csum_offset);
> > +
> > +	memcpy(data, rx_packet, len); /* don't share umem chunk for simplicity */
> > +	tx_desc->options |= XDP_TX_METADATA;
> > +	tx_desc->len = len;
> > +
> > +	xsk_ring_prod__submit(&xsk->tx, 1);
> > +}
> > +
> >   static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t clock_id)
> >   {
> >   	const struct xdp_desc *rx_desc;
> > @@ -250,6 +378,13 @@ static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t
> >   	while (true) {
> >   		errno = 0;
> > +
> > +		for (i = 0; i < rxq; i++) {
> > +			ret = kick_rx(&rx_xsk[i]);
> > +			if (ret)
> > +				printf("kick_rx ret=%d\n", ret);
> > +		}
> > +
> >   		ret = poll(fds, rxq + 1, 1000);
> >   		printf("poll: %d (%d) skip=%llu fail=%llu redir=%llu\n",
> >   		       ret, errno, bpf_obj->bss->pkts_skip,
> > @@ -280,6 +415,22 @@ static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t
> >   			       xsk, idx, rx_desc->addr, addr, comp_addr);
> >   			verify_xdp_metadata(xsk_umem__get_data(xsk->umem_area, addr),
> >   					    clock_id);
> > +
> > +			if (!skip_tx) {
> > +				/* mirror the packet back */
> > +				ping_pong(xsk, xsk_umem__get_data(xsk->umem_area, addr));
> > +
> > +				ret = kick_tx(xsk);
> > +				if (ret)
> > +					printf("kick_tx ret=%d\n", ret);
> > +
> > +				for (int j = 0; j < 500; j++) {
> > +					if (complete_tx(xsk))
> > +						break;
> > +					usleep(10*1000);
> 
> I don't fully follow why we need this usleep here.

To avoid the busypoll here (since we don't care too much about perf in
the test). But I agree, should be ok to drop, will do.

