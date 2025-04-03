Return-Path: <bpf+bounces-55251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B851A7A89E
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 19:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B04BC16DA0B
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 17:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991932517A8;
	Thu,  3 Apr 2025 17:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZqnfGjo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DEA1A23BA;
	Thu,  3 Apr 2025 17:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743701357; cv=none; b=XImy/Q1KfPU4qpdecle3yTQp5XfjKp/hMxTKqwF9iM9csCrbiu8j07xDRvB5EUUxNDx4dte4BMGWhBztWCHV5wE8JRnySztyO460FWphaIVFOy7SlmY4Ok+tHgx8Lr0AAe7gksUJoXAZ1d/0ijm/oHQf/PAshCX2rpcvUjhBpGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743701357; c=relaxed/simple;
	bh=VmVAVcyjlY7YFbKKh6CYyAnKwPS8tXpuG6w8T5ps5UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktMzBlZS/21DX3bhCBsoXZcAn9p8wnzHex9rtFPQ2PbjBx8q6ZrqFkl2jvz381pLxkdiC3oRvNfthc4hdVn975lmaUD+5OVdscJCpbaccvQWa7U0Aszthq0jEL0kNxHnC+VF491sHj04p8NNNvX4FH6E3hg9PpE8g8UsFmngVgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZqnfGjo; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ff69365e1dso973347a91.3;
        Thu, 03 Apr 2025 10:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743701353; x=1744306153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1SbaQ6GbynbYeoObBVf6rFAUvUw9mEya4dEc+bkQ430=;
        b=XZqnfGjo9ZMGQSJTr+LT2EvniXLZYI7FqiiecjAbJGORiUt3JChoaG85ZN5l8ey/Xk
         lVAuQapeSCUSrE6NF1ePVhw+mKfZ4t/uCnSnXFRfeSm+UgStcgIkPRQEhdwwjnvj0b6G
         2LaCFnY7Gq91KT3XZxs+r7UKpmyWvxwtUnJzmVh0tWBfNjq3/52KV23n+zCKx9dTvnXN
         K9CmEYS0dFa4g8CSzsq9m6mFDxJtW8lj2DA0OVsRAFWSmcDUziupzG1nNrNdkwugDdxC
         aO6PdMSVaoXUdzP9jscsUownH30QGgyFu9Ia0yWxYKl0R66bPx198CawQshviHoMbpJk
         004Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743701353; x=1744306153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SbaQ6GbynbYeoObBVf6rFAUvUw9mEya4dEc+bkQ430=;
        b=tGEtbVsRdTFCvQfALEq0iVqmkqVMRc8R+f1TQVXSJEAOB77Eg3JQm19Gv7hvraibW5
         rzI4hMXX8OsTyJXUiOvGOTjIIyjV9R8TDtVaCWT8/0YR1icapjTf2NipQPMFSQ8+OGqB
         snInvKbOsddVEf7T4hb9/RHPaxrTfFtZuTQW340JZBVJaF61gZqkd3E++PUPxLj1wsTa
         NLCmyOMBtE1ud2ALqtT13IF7mEaHDqC3+2kfPNIHAKMTdaee9dmZMFH/XWZt62eUT/5R
         YBkIE8m1BTgTnRtFNDkTMrdJMZYeLzab9Q1GSrWbj9R9PgzZfR3RQDN7dCC71e3KLB7m
         XJpA==
X-Forwarded-Encrypted: i=1; AJvYcCVcgiTlUnadtJTMCbGfFuYGbijBpHl5ZZ+e05ikKTvdWZBoc3LiKewIY0P/N8cxP9qI0yWKGiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCncii1y8HE3A80YTUb7QMCm28oxE8012f4xJFZADpYmSyk3Q6
	zGKgkOkusURXoK2YT+D2G+DG7GoXtAWOxxtqsZ7L2VfhrtIgPqA=
X-Gm-Gg: ASbGncsxL+qfP8DVfz8pNykVsUMKN5Hbf5L3uoxiSUExX+hmXujCfjdcGscP2gViQ5M
	MF+b58W4sNtikDmCsWVIqrDVilCQ6WQ0VmbPDsJT6COyQ0VKX3Z5OInnPE7H4Wjb4Gllksbwtgd
	Xz2qru1dj2vB9wB8mcp83/QzT/voZSVWyIoe60kaLwilNzaeBAIjyzuhhWhNQlQI5QVjNSyVtiD
	Fi62dtU2zpUx6zoCdedgvDOLYTwdDcXykcs/uTPEmfjY1c3i7E/eWDK/qWS50FlWA0hIzuJ89/u
	GoOc5K+zz3++yGjbnQXlVmBPO1YT0AK70wwe/BCOHpQe
X-Google-Smtp-Source: AGHT+IEo2hot7oodVRjHXtKsQwyJ3zLP60PlTySdP/gudYjskh0nXDMFGq/SFrF99KVH57qH/BKPGg==
X-Received: by 2002:a17:90b:2b8b:b0:2fe:ac91:4667 with SMTP id 98e67ed59e1d1-306a491f50amr508893a91.29.1743701353452;
        Thu, 03 Apr 2025 10:29:13 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-305983b9752sm1950624a91.36.2025.04.03.10.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 10:29:13 -0700 (PDT)
Date: Thu, 3 Apr 2025 10:29:12 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, john.fastabend@gmail.com,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH bpf 2/2] selftests/net: test sk_filter support for
 SKF_NET_OFF on frags
Message-ID: <Z-7FaAu8qr5sFgXp@mini-arch>
References: <20250403140846.1268564-1-willemdebruijn.kernel@gmail.com>
 <20250403140846.1268564-3-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250403140846.1268564-3-willemdebruijn.kernel@gmail.com>

On 04/03, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Verify that a classic BPF linux socket filter correctly matches
> packet contents. Including when accessing contents in an
> skb_frag.
> 
> 1. Open a SOCK_RAW socket with a classic BPF filter on UDP dport 8000.
> 2. Open a tap device with IFF_NAPI_FRAGS to inject skbs with frags.
> 3. Send a packet for which the UDP header is in frag[0].
> 4. Receive this packet to demonstrate that the socket accepted it.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

My (weak) preference is to put (most) bpf-related things under
selftests/bpf, but since you already have it working, not sure
it's worth the effort.

> ---
>  tools/testing/selftests/net/.gitignore     |   1 +
>  tools/testing/selftests/net/Makefile       |   2 +
>  tools/testing/selftests/net/skf_net_off.c  | 244 +++++++++++++++++++++
>  tools/testing/selftests/net/skf_net_off.sh |  28 +++
>  4 files changed, 275 insertions(+)
>  create mode 100644 tools/testing/selftests/net/skf_net_off.c
>  create mode 100755 tools/testing/selftests/net/skf_net_off.sh
> 
> diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
> index 679542f565a4..532bb732bc6d 100644
> --- a/tools/testing/selftests/net/.gitignore
> +++ b/tools/testing/selftests/net/.gitignore
> @@ -39,6 +39,7 @@ scm_rights
>  sk_bind_sendto_listen
>  sk_connect_zero_addr
>  sk_so_peek_off
> +skf_net_off
>  socket
>  so_incoming_cpu
>  so_netns_cookie
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index 6d718b478ed8..124078b56fa4 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -106,6 +106,8 @@ TEST_PROGS += ipv6_route_update_soft_lockup.sh
>  TEST_PROGS += busy_poll_test.sh
>  TEST_GEN_PROGS += proc_net_pktgen
>  TEST_PROGS += lwt_dst_cache_ref_loop.sh
> +TEST_PROGS += skf_net_off.sh
> +TEST_GEN_FILES += skf_net_off
>  
>  # YNL files, must be before "include ..lib.mk"
>  YNL_GEN_FILES := busy_poller netlink-dumps
> diff --git a/tools/testing/selftests/net/skf_net_off.c b/tools/testing/selftests/net/skf_net_off.c
> new file mode 100644
> index 000000000000..1fdf61d6cd7f
> --- /dev/null
> +++ b/tools/testing/selftests/net/skf_net_off.c
> @@ -0,0 +1,244 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/* Open a tun device.
> + *
> + * [modifications: use IFF_NAPI_FRAGS, add sk filter]
> + *
> + * Expects the device to have been configured previously, e.g.:
> + *   sudo ip tuntap add name tap1 mode tap
> + *   sudo ip link set tap1 up
> + *   sudo ip link set dev tap1 addr 02:00:00:00:00:01
> + *   sudo ip -6 addr add fdab::1 peer fdab::2 dev tap1 nodad
> + *
> + * And to avoid premature pskb_may_pull:
> + *
> + *   sudo ethtool -K tap1 gro off
> + *   sudo bash -c 'echo 0 > /proc/sys/net/ipv4/ip_early_demux'
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <arpa/inet.h>
> +#include <errno.h>
> +#include <error.h>
> +#include <fcntl.h>
> +#include <getopt.h>
> +#include <linux/filter.h>
> +#include <linux/if.h>
> +#include <linux/if_packet.h>
> +#include <linux/if_tun.h>
> +#include <linux/ipv6.h>
> +#include <netinet/if_ether.h>
> +#include <netinet/in.h>
> +#include <netinet/ip.h>
> +#include <netinet/ip6.h>
> +#include <netinet/udp.h>
> +#include <poll.h>
> +#include <signal.h>
> +#include <stdbool.h>
> +#include <stddef.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/ioctl.h>
> +#include <sys/socket.h>
> +#include <sys/poll.h>
> +#include <sys/types.h>
> +#include <sys/uio.h>
> +#include <unistd.h>
> +
> +static bool cfg_do_filter;
> +static bool cfg_do_frags;
> +static int cfg_dst_port = 8000;
> +static char *cfg_ifname;
> +
> +static int tun_open(const char *tun_name)
> +{
> +	struct ifreq ifr = {0};
> +	int fd, ret;
> +
> +	fd = open("/dev/net/tun", O_RDWR);
> +	if (fd == -1)
> +		error(1, errno, "open /dev/net/tun");
> +
> +	ifr.ifr_flags = IFF_TAP;
> +	if (cfg_do_frags)
> +		ifr.ifr_flags |= IFF_NAPI | IFF_NAPI_FRAGS;
> +
> +	strncpy(ifr.ifr_name, tun_name, IFNAMSIZ - 1);
> +
> +	ret = ioctl(fd, TUNSETIFF, &ifr);
> +	if (ret)
> +		error(1, ret, "ioctl TUNSETIFF");
> +
> +	return fd;
> +}
> +
> +static void sk_set_filter(int fd)
> +{
> +	const int offset_proto = offsetof(struct ip6_hdr, ip6_nxt);
> +	const int offset_dport = sizeof(struct ip6_hdr) + offsetof(struct udphdr, dest);
> +
> +	/* Filter UDP packets with destination port cfg_dst_port */
> +	struct sock_filter filter_code[] = {
> +		BPF_STMT(BPF_LD  + BPF_B   + BPF_ABS, SKF_AD_OFF + SKF_AD_PKTTYPE),
> +		BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, PACKET_HOST, 0, 4),
> +		BPF_STMT(BPF_LD  + BPF_B   + BPF_ABS, SKF_NET_OFF + offset_proto),
> +		BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, IPPROTO_UDP, 0, 2),
> +		BPF_STMT(BPF_LD  + BPF_H   + BPF_ABS, SKF_NET_OFF + offset_dport),
> +		BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, cfg_dst_port, 1, 0),
> +		BPF_STMT(BPF_RET + BPF_K, 0),
> +		BPF_STMT(BPF_RET + BPF_K, 0xFFFF),
> +	};
> +
> +	struct sock_fprog filter = {
> +		sizeof(filter_code) / sizeof(filter_code[0]),
> +		filter_code,
> +	};
> +
> +	if (setsockopt(fd, SOL_SOCKET, SO_ATTACH_FILTER, &filter, sizeof(filter)))
> +		error(1, errno, "setsockopt attach filter");
> +}
> +
> +static int raw_open(void)
> +{
> +	int fd;
> +
> +	fd = socket(PF_INET6, SOCK_RAW, IPPROTO_UDP);
> +	if (fd == -1)
> +		error(1, errno, "socket raw (udp)");
> +
> +	if (cfg_do_filter)
> +		sk_set_filter(fd);
> +
> +	return fd;
> +}
> +
> +static void tun_write(int fd)
> +{
> +	const char eth_src[] = { 0x02, 0x00, 0x00, 0x00, 0x00, 0x02 };
> +	const char eth_dst[] = { 0x02, 0x00, 0x00, 0x00, 0x00, 0x01 };
> +	struct tun_pi pi = {0};
> +	struct ipv6hdr ip6h = {0};
> +	struct udphdr uh = {0};
> +	struct ethhdr eth = {0};
> +	uint32_t payload;
> +	struct iovec iov[5];
> +	int ret;
> +
> +	pi.proto = htons(ETH_P_IPV6);
> +
> +	memcpy(eth.h_source, eth_src, sizeof(eth_src));
> +	memcpy(eth.h_dest, eth_dst, sizeof(eth_dst));
> +	eth.h_proto = htons(ETH_P_IPV6);
> +
> +	ip6h.version = 6;
> +	ip6h.payload_len = htons(sizeof(uh) + sizeof(uint32_t));
> +	ip6h.nexthdr = IPPROTO_UDP;
> +	ip6h.hop_limit = 8;
> +	if (inet_pton(AF_INET6, "fdab::2", &ip6h.saddr) != 1)
> +		error(1, errno, "inet_pton src");
> +	if (inet_pton(AF_INET6, "fdab::1", &ip6h.daddr) != 1)
> +		error(1, errno, "inet_pton src");
> +
> +	uh.source = htons(8000);
> +	uh.dest = htons(cfg_dst_port);
> +	uh.len = ip6h.payload_len;
> +	uh.check = 0;
> +
> +	payload = htonl(0xABABABAB);		/* Covered in IPv6 length */
> +
> +	iov[0].iov_base = &pi;
> +	iov[0].iov_len  = sizeof(pi);
> +	iov[1].iov_base = &eth;
> +	iov[1].iov_len  = sizeof(eth);
> +	iov[2].iov_base = &ip6h;
> +	iov[2].iov_len  = sizeof(ip6h);
> +	iov[3].iov_base = &uh;
> +	iov[3].iov_len  = sizeof(uh);
> +	iov[4].iov_base = &payload;
> +	iov[4].iov_len  = sizeof(payload);
> +
> +	ret = writev(fd, iov, sizeof(iov) / sizeof(iov[0]));
> +	if (ret <= 0)
> +		error(1, errno, "writev");
> +}
> +
> +static void raw_read(int fd)
> +{
> +	struct timeval tv = { .tv_usec = 100 * 1000 };
> +	struct msghdr msg = {0};
> +	struct iovec iov[2];
> +	struct udphdr uh;
> +	uint32_t payload[2];
> +	int ret;
> +
> +	if (setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv)))
> +		error(1, errno, "setsockopt rcvtimeo udp");
> +
> +	iov[0].iov_base = &uh;
> +	iov[0].iov_len = sizeof(uh);
> +
> +	iov[1].iov_base = payload;
> +	iov[1].iov_len = sizeof(payload);
> +
> +	msg.msg_iov = iov;
> +	msg.msg_iovlen = sizeof(iov) / sizeof(iov[0]);
> +
> +	ret = recvmsg(fd, &msg, 0);
> +	if (ret <= 0)
> +		error(1, errno, "read raw");
> +	if (ret != sizeof(uh) + sizeof(payload[0]))
> +		error(1, errno, "read raw: len=%d\n", ret);
> +
> +	fprintf(stderr, "raw recv: 0x%x\n", payload[0]);
> +}
> +
> +static void parse_opts(int argc, char **argv)
> +{
> +	int c;
> +
> +	while ((c = getopt(argc, argv, "fFi:")) != -1) {
> +		switch (c) {
> +		case 'f':
> +			cfg_do_filter = true;
> +			printf("bpf filter enabled\n");
> +			break;
> +		case 'F':
> +			cfg_do_frags = true;
> +			printf("napi frags mode enabled\n");
> +			break;
> +		case 'i':
> +			cfg_ifname = optarg;
> +			break;
> +		default:
> +			error(1, 0, "unknown option %c", optopt);
> +			break;
> +		}
> +	}
> +
> +	if (!cfg_ifname)
> +		error(1, 0, "must specify tap interface name (-i)");
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int fdt, fdr;
> +
> +	parse_opts(argc, argv);
> +
> +	fdr = raw_open();
> +	fdt = tun_open(cfg_ifname);
> +
> +	tun_write(fdt);
> +	raw_read(fdr);
> +
> +	if (close(fdt))
> +		error(1, errno, "close tun");
> +	if (close(fdr))
> +		error(1, errno, "close udp");
> +
> +	fprintf(stderr, "OK\n");
> +	return 0;
> +}
> +
> diff --git a/tools/testing/selftests/net/skf_net_off.sh b/tools/testing/selftests/net/skf_net_off.sh
> new file mode 100755
> index 000000000000..e9cce93a0258
> --- /dev/null
> +++ b/tools/testing/selftests/net/skf_net_off.sh
> @@ -0,0 +1,28 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +readonly NS="ns-$(mktemp -u XXXXXX)"
> +
> +cleanup() {
> +	ip netns del $NS
> +}
> +
> +ip netns add $NS
> +trap cleanup EXIT
> +
> +ip -netns $NS link set lo up
> +ip -netns $NS tuntap add name tap1 mode tap
> +ip -netns $NS link set tap1 up
> +ip -netns $NS link set dev tap1 addr 02:00:00:00:00:01
> +ip -netns $NS -6 addr add fdab::1 peer fdab::2 dev tap1 nodad
> +ip netns exec $NS ethtool -K tap1 gro off
> +ip netns exec $NS sysctl -w net.ipv4.ip_early_demux=0

Curious: why disable ip_early_demux here?

