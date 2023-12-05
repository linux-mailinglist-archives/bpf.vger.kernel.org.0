Return-Path: <bpf+bounces-16817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AC1806234
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 23:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9787C2820BC
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 22:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDEE405CD;
	Tue,  5 Dec 2023 22:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U6r5dOUS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CDE1B1
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 14:59:10 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1d092b42fb4so1785255ad.0
        for <bpf@vger.kernel.org>; Tue, 05 Dec 2023 14:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701817150; x=1702421950; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DiDmnpUUNncrnI6aYqSgsfPSW6+CjhtdUetE6abrmhM=;
        b=U6r5dOUShRcNlBrdMrLBOCW1Sm1s3DdWvtf4XJw5th74qMItEO/fZD5SPlthiQZelW
         xXTZ5i86Y1CP/e+uMivUOmdwKQKxH8Tg9WYFlk9z59fmhzNAnEisg9rYE06C5HbO2zda
         Bu7N8gRLzWt3QRKA5ZVU3BQiH+egL6o7ATH8Iwq+8gcEuJSlPJYPN0u+KgTt6Feon7Kb
         Bgy0O+sFeDNJz4kqNpdL1hITjuxzYXd+d/vDd0zzRBWl433sTs0BqpNlZzhO1QxKMziN
         yB6sHVrWM5LynjnCmNoJJluVIlqs/82CzBtcEpUmVXoJVGab9fEC3Q1TOnECBpQmTiXr
         mIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701817150; x=1702421950;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DiDmnpUUNncrnI6aYqSgsfPSW6+CjhtdUetE6abrmhM=;
        b=RoYAN8hHDExtOL1dmSXi03Ior9ZqS7evWTW3Gum7u8HW0Zyc8BVZ1rx88dKhqy0jZU
         A9IrV/1b2FPeV6cVdVWC+MXpMjWXK+GMtMHLZy7vdCSEUOT9FPezooBOzVcU7bmEjrVl
         757MvHIYS3GK4ZUyDHuSf0R0aV2rADZHDGZ9NUVv8N2draqW4gH+EhUNZwEK1ZnYmnS7
         pX0QjA7+3uoow/FP4W2VXqRQye9JjllZKyaoTy5KhlFjYTNNNri9DcSGzkwIE9O//Cdw
         xWbP6WMQAzffCjQEdAbmrfbwA5FQEY2BvfjsxDNpKgwoQb0MShNEpz/LK0xhpDhdzD0R
         DecA==
X-Gm-Message-State: AOJu0Ywvw8Tp4ymag0Oc4Mut6jGBEgJVHPFJbsWg0vYqDHvKfVjtCwV3
	S+5YWBQyZ6mJ72UjOrIcIImZm14=
X-Google-Smtp-Source: AGHT+IHnWRQw3sBkw9X9W/vevsDl7PUkpFSopPucOm6JGnj51cT1SO2wA03RbmH1O1pGJhycl+koljM=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:ce91:b0:1d0:4246:90b1 with SMTP id
 f17-20020a170902ce9100b001d0424690b1mr50333plg.0.1701817149511; Tue, 05 Dec
 2023 14:59:09 -0800 (PST)
Date: Tue, 5 Dec 2023 14:59:07 -0800
In-Reply-To: <20231205210847.28460-18-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231205210847.28460-1-larysa.zaremba@intel.com> <20231205210847.28460-18-larysa.zaremba@intel.com>
Message-ID: <ZW-rO6bzRa47tY-T@google.com>
Subject: Re: [PATCH bpf-next v8 17/18] selftests/bpf: Add AF_INET packet
 generation to xdp_metadata
From: Stanislav Fomichev <sdf@google.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Anatoly Burakov <anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>, 
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>, 
	xdp-hints@xdp-project.net, netdev@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Tariq Toukan <tariqt@mellanox.com>, 
	Saeed Mahameed <saeedm@mellanox.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset="utf-8"

On 12/05, Larysa Zaremba wrote:
> The easiest way to simulate stripped VLAN tag in veth is to send a packet
> from VLAN interface, attached to veth. Unfortunately, this approach is
> incompatible with AF_XDP on TX side, because VLAN interfaces do not have
> such feature.
> 
> Check both packets sent via AF_XDP TX and regular socket.
> 
> AF_INET packet will also have a filled-in hash type (XDP_RSS_TYPE_L4),
> unlike AF_XDP packet, so more values can be checked.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  .../selftests/bpf/prog_tests/xdp_metadata.c   | 116 +++++++++++++++---
>  1 file changed, 97 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> index 33cdf88efa6b..e7f06cbdd845 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> @@ -20,7 +20,7 @@
>  
>  #define UDP_PAYLOAD_BYTES 4
>  
> -#define AF_XDP_SOURCE_PORT 1234
> +#define UDP_SOURCE_PORT 1234
>  #define AF_XDP_CONSUMER_PORT 8080
>  
>  #define UMEM_NUM 16
> @@ -33,6 +33,12 @@
>  #define RX_ADDR "10.0.0.2"
>  #define PREFIX_LEN "8"
>  #define FAMILY AF_INET
> +#define TX_NETNS_NAME "xdp_metadata_tx"
> +#define RX_NETNS_NAME "xdp_metadata_rx"
> +#define TX_MAC "00:00:00:00:00:01"
> +#define RX_MAC "00:00:00:00:00:02"
> +
> +#define XDP_RSS_TYPE_L4 BIT(3)
>  
>  struct xsk {
>  	void *umem_area;
> @@ -181,7 +187,7 @@ static int generate_packet(struct xsk *xsk, __u16 dst_port)
>  	ASSERT_EQ(inet_pton(FAMILY, RX_ADDR, &iph->daddr), 1, "inet_pton(RX_ADDR)");
>  	ip_csum(iph);
>  
> -	udph->source = htons(AF_XDP_SOURCE_PORT);
> +	udph->source = htons(UDP_SOURCE_PORT);
>  	udph->dest = htons(dst_port);
>  	udph->len = htons(sizeof(*udph) + UDP_PAYLOAD_BYTES);
>  	udph->check = ~csum_tcpudp_magic(iph->saddr, iph->daddr,
> @@ -204,6 +210,30 @@ static int generate_packet(struct xsk *xsk, __u16 dst_port)
>  	return 0;
>  }
>  
> +static int generate_packet_inet(void)
> +{
> +	char udp_payload[UDP_PAYLOAD_BYTES];
> +	struct sockaddr_in rx_addr;
> +	int sock_fd, err = 0;
> +
> +	/* Build a packet */
> +	memset(udp_payload, 0xAA, UDP_PAYLOAD_BYTES);
> +	rx_addr.sin_addr.s_addr = inet_addr(RX_ADDR);
> +	rx_addr.sin_family = AF_INET;
> +	rx_addr.sin_port = htons(AF_XDP_CONSUMER_PORT);
> +
> +	sock_fd = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
> +	if (!ASSERT_GE(sock_fd, 0, "socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP)"))
> +		return sock_fd;
> +
> +	err = sendto(sock_fd, udp_payload, UDP_PAYLOAD_BYTES, MSG_DONTWAIT,
> +		     (void *)&rx_addr, sizeof(rx_addr));
> +	ASSERT_GE(err, 0, "sendto");
> +
> +	close(sock_fd);
> +	return err;
> +}
> +
>  static void complete_tx(struct xsk *xsk)
>  {
>  	struct xsk_tx_metadata *meta;
> @@ -236,7 +266,7 @@ static void refill_rx(struct xsk *xsk, __u64 addr)
>  	}
>  }
>  
> -static int verify_xsk_metadata(struct xsk *xsk)
> +static int verify_xsk_metadata(struct xsk *xsk, bool sent_from_af_xdp)
>  {
>  	const struct xdp_desc *rx_desc;
>  	struct pollfd fds = {};
> @@ -290,17 +320,36 @@ static int verify_xsk_metadata(struct xsk *xsk)
>  	if (!ASSERT_NEQ(meta->rx_hash, 0, "rx_hash"))
>  		return -1;
>  
> +	if (!sent_from_af_xdp) {
> +		if (!ASSERT_NEQ(meta->rx_hash_type & XDP_RSS_TYPE_L4, 0, "rx_hash_type"))
> +			return -1;
> +		goto done;
> +	}
> +
>  	ASSERT_EQ(meta->rx_hash_type, 0, "rx_hash_type");
>  
>  	/* checksum offload */
>  	ASSERT_EQ(udph->check, htons(0x721c), "csum");
>  
> +done:
>  	xsk_ring_cons__release(&xsk->rx, 1);
>  	refill_rx(xsk, comp_addr);
>  
>  	return 0;
>  }
>  
> +static void switch_ns_to_rx(struct nstoken **tok)
> +{
> +	close_netns(*tok);
> +	*tok = open_netns(RX_NETNS_NAME);
> +}
> +
> +static void switch_ns_to_tx(struct nstoken **tok)
> +{
> +	close_netns(*tok);
> +	*tok = open_netns(TX_NETNS_NAME);
> +}
> +
>  void test_xdp_metadata(void)
>  {
>  	struct xdp_metadata2 *bpf_obj2 = NULL;
> @@ -318,27 +367,31 @@ void test_xdp_metadata(void)
>  	int sock_fd;
>  	int ret;
>  
> -	/* Setup new networking namespace, with a veth pair. */
> +	/* Setup new networking namespaces, with a veth pair. */
> +	SYS(out, "ip netns add " TX_NETNS_NAME);
> +	SYS(out, "ip netns add " RX_NETNS_NAME);
>  
> -	SYS(out, "ip netns add xdp_metadata");
> -	tok = open_netns("xdp_metadata");
> +	tok = open_netns(TX_NETNS_NAME);
>  	SYS(out, "ip link add numtxqueues 1 numrxqueues 1 " TX_NAME
>  	    " type veth peer " RX_NAME " numtxqueues 1 numrxqueues 1");
> -	SYS(out, "ip link set dev " TX_NAME " address 00:00:00:00:00:01");
> -	SYS(out, "ip link set dev " RX_NAME " address 00:00:00:00:00:02");
> +	SYS(out, "ip link set " RX_NAME " netns " RX_NETNS_NAME);
> +
> +	SYS(out, "ip link set dev " TX_NAME " address " TX_MAC);
>  	SYS(out, "ip link set dev " TX_NAME " up");
> -	SYS(out, "ip link set dev " RX_NAME " up");
>  	SYS(out, "ip addr add " TX_ADDR "/" PREFIX_LEN " dev " TX_NAME);
> +
> +	/* Avoid ARP calls */
> +	SYS(out, "ip -4 neigh add " RX_ADDR " lladdr " RX_MAC " dev " TX_NAME);
> +
> +	switch_ns_to_rx(&tok);
> +
> +	SYS(out, "ip link set dev " RX_NAME " address " RX_MAC);
> +	SYS(out, "ip link set dev " RX_NAME " up");
>  	SYS(out, "ip addr add " RX_ADDR "/" PREFIX_LEN " dev " RX_NAME);
>  
>  	rx_ifindex = if_nametoindex(RX_NAME);
> -	tx_ifindex = if_nametoindex(TX_NAME);
>  
> -	/* Setup separate AF_XDP for TX and RX interfaces. */
> -
> -	ret = open_xsk(tx_ifindex, &tx_xsk);
> -	if (!ASSERT_OK(ret, "open_xsk(TX_NAME)"))
> -		goto out;
> +	/* Setup separate AF_XDP for RX interface. */
>  
>  	ret = open_xsk(rx_ifindex, &rx_xsk);
>  	if (!ASSERT_OK(ret, "open_xsk(RX_NAME)"))
> @@ -379,18 +432,38 @@ void test_xdp_metadata(void)
>  	if (!ASSERT_GE(ret, 0, "bpf_map_update_elem"))
>  		goto out;
>  
> -	/* Send packet destined to RX AF_XDP socket. */
> +	switch_ns_to_tx(&tok);
> +
> +	/* Setup separate AF_XDP for TX interface nad send packet to the RX socket. */

Not sure we care, but s/nad/and/ if you happen to do another respin..

Acked-by: Stanislav Fomichev <sdf@google.com>

