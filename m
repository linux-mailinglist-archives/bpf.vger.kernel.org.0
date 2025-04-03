Return-Path: <bpf+bounces-55262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C90A7A9C5
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 20:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2B0C174C26
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 18:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FFF253324;
	Thu,  3 Apr 2025 18:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrO6tYQ9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B24151992;
	Thu,  3 Apr 2025 18:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743706618; cv=none; b=WZ0AXuj3FaXEE1OMbMOO1E8Vb7n8rA1hc1UxCB26Lt6RfvDe7jPbWctMM+5hqVfyjzULyLF7XpfBInMIVK8s2KAJn29ew8+PvCybgUkp1clRgBWJgR4AO3A5xpd3q32enSxpKMUAA/V+1RYAwnhH06sqizfUFGnl3LUuJRt2mG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743706618; c=relaxed/simple;
	bh=0m0tDiG3R2IbxVtrdFv1pZS7BMH8Twtcpv1xpgspNUE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=k5Di0NdSx6ZvEU8xAL1NKDpc8SJu2yEmp26S9iGBqLD58Yk7vilHuEAxqFWK2PFWTTzID1X8CZ615oCXGhOXRtYbHVrG89PcsykGKRojCT9aR98z1w2sddud451J80jB2BdG9NJcNzS2NtPxVUJSMLIDSozZ/umX3Uatk7sZyxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrO6tYQ9; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c3bf231660so124405885a.0;
        Thu, 03 Apr 2025 11:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743706615; x=1744311415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnfme6BvDM4d5TgtkwsHU5xoleP7xzMB6ssKtqL68hw=;
        b=NrO6tYQ9gEUcwYA7IHcEWgznt7ZMzYGcjHWYCTO+SNhQIexVeP4wSbCo1tHuN+PDbs
         iwEbToS6oWLJCQMUCdevAxDn06+CbY7czSX+JXCIcej/0WIMCHljZzHz0CsmeK1HQScu
         o0kzygx/2FepobwSm7IOOxhcgXB0c7Pz8tJ6IHexYFsXo8ofr02ZdJlun7ExOZHjGVLW
         sl/Mv/hyIj+eSW1NLgyzYkf7Yrvda+eW6t3uXqHe0d2+Wa6n2UZvCwDpJgVzjM2aZZpC
         R+LkRUCQua0Nu3Zb0UctI8lhu2xIEULKtVwaJ8sx9hxurWlSj+g+Ssw7+9Q4/+/J06th
         mplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743706615; x=1744311415;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xnfme6BvDM4d5TgtkwsHU5xoleP7xzMB6ssKtqL68hw=;
        b=BJ7tOZKEwu13zO0cirO1yuWcRvaPvuVuCT7Bp3rEYbb+buFgw41fnL2nk8F2PxbvXd
         aLcTg5fph1lMOoAyLc5cIqXAd0jC3shpzcWyFQyajyMk4SEt3LxzHWyXoxLqByJRBZzU
         7AH53bPAjxXOa41P1qJd6FT7Kj6F7LKrP5U6tmFFmbree9DNy2x946mDbkEOfBYb9prE
         Y15SMt/JyRSg2v7yLhF8VWrroekjcLS3sTcxkrpjdw4fvW+SbomXXqSxzhH3LAdCbG88
         ASqT70HDXiTes2n4MwCLQnIKJdL7TtcFWFBosGSqdyRXLlQGkOXGYdYVONTQZlmy20Sz
         vV+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVS05oYPJNy3QQ0ifRabwbEMdvLgsc3rbhN0Xu/7qwEEzCFTOBkTI+IAGQ5h6j3Qz4FtwGd67k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/TKLa6MfD0xo0MJECGn9gCFFqFMAGkMuWuKvWrhX7QnBz0uno
	3Z57Jag7tLf1yZSYjQuoo3TK99r/JvX4RSgA+IhYjdKBPlZ800rb
X-Gm-Gg: ASbGncuMeD49kcBXMm9KuEZmx2GCiWNiTLTtAK/zJIkk/sVkFblYblaIyHLZruLmKfb
	Vq1d69vmSaaLbs8Mbm9cTR8m53hBZSDuvKca3pU92hdFb1Rw2eQUqYBH9p2RyRZ9xkUjrfLtzdU
	aMgkYI34l2HyT00CoD4XlncUMUU7vdu+WL4mrli+1YKf/1ryaqO45fSy4a7BcFCNFrfdjtk8GAF
	KlPUU92dW6hQjVK23uT5Hxk33qqWrv1kfsNBtFuJxCK/mKAVq47iej7EdPnAEffUBInLy+CSgHj
	5fmY32fryNusODlmI+uu35cLJzx15+clUW9XKJAroMLtdjDDLIH9Yyu2bmRc/nsSzLqEwNhtJ1a
	rH+JDRPZohFsM6YRUt2YAGg==
X-Google-Smtp-Source: AGHT+IFv+ITUUDoTIGYnoN5z4pYhd11i9IXx/333FCO7+kuWmRLNxWRDlY4KHRLkGDogZST7jcolow==
X-Received: by 2002:a05:620a:2805:b0:7c5:5cc4:ca5c with SMTP id af79cd13be357-7c774d32335mr49531685a.14.1743706615519;
        Thu, 03 Apr 2025 11:56:55 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c76e735361sm110260285a.18.2025.04.03.11.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 11:56:54 -0700 (PDT)
Date: Thu, 03 Apr 2025 14:56:54 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Stanislav Fomichev <stfomichev@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 john.fastabend@gmail.com, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <67eed9f680b5f_15e1b3294f4@willemb.c.googlers.com.notmuch>
In-Reply-To: <Z-7FaAu8qr5sFgXp@mini-arch>
References: <20250403140846.1268564-1-willemdebruijn.kernel@gmail.com>
 <20250403140846.1268564-3-willemdebruijn.kernel@gmail.com>
 <Z-7FaAu8qr5sFgXp@mini-arch>
Subject: Re: [PATCH bpf 2/2] selftests/net: test sk_filter support for
 SKF_NET_OFF on frags
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Stanislav Fomichev wrote:
> On 04/03, Willem de Bruijn wrote:
> > From: Willem de Bruijn <willemb@google.com>
> > 
> > Verify that a classic BPF linux socket filter correctly matches
> > packet contents. Including when accessing contents in an
> > skb_frag.
> > 
> > 1. Open a SOCK_RAW socket with a classic BPF filter on UDP dport 8000.
> > 2. Open a tap device with IFF_NAPI_FRAGS to inject skbs with frags.
> > 3. Send a packet for which the UDP header is in frag[0].
> > 4. Receive this packet to demonstrate that the socket accepted it.
> > 
> > Signed-off-by: Willem de Bruijn <willemb@google.com>
> 
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Thanks for the review :)

> My (weak) preference is to put (most) bpf-related things under
> selftests/bpf, but since you already have it working, not sure
> it's worth the effort.

I wasn't sure since this is exclusively legacy linux socket filters,
and needs a tun network stack to exercise it.

Will keep as is if you indeed don't mind.

> > ---
> >  tools/testing/selftests/net/.gitignore     |   1 +
> >  tools/testing/selftests/net/Makefile       |   2 +
> >  tools/testing/selftests/net/skf_net_off.c  | 244 +++++++++++++++++++++
> >  tools/testing/selftests/net/skf_net_off.sh |  28 +++
> >  4 files changed, 275 insertions(+)
> >  create mode 100644 tools/testing/selftests/net/skf_net_off.c
> >  create mode 100755 tools/testing/selftests/net/skf_net_off.sh
> > 
> > diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
> > index 679542f565a4..532bb732bc6d 100644
> > --- a/tools/testing/selftests/net/.gitignore
> > +++ b/tools/testing/selftests/net/.gitignore
> > @@ -39,6 +39,7 @@ scm_rights
> >  sk_bind_sendto_listen
> >  sk_connect_zero_addr
> >  sk_so_peek_off
> > +skf_net_off
> >  socket
> >  so_incoming_cpu
> >  so_netns_cookie
> > diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> > index 6d718b478ed8..124078b56fa4 100644
> > --- a/tools/testing/selftests/net/Makefile
> > +++ b/tools/testing/selftests/net/Makefile
> > @@ -106,6 +106,8 @@ TEST_PROGS += ipv6_route_update_soft_lockup.sh
> >  TEST_PROGS += busy_poll_test.sh
> >  TEST_GEN_PROGS += proc_net_pktgen
> >  TEST_PROGS += lwt_dst_cache_ref_loop.sh
> > +TEST_PROGS += skf_net_off.sh
> > +TEST_GEN_FILES += skf_net_off
> >  
> >  # YNL files, must be before "include ..lib.mk"
> >  YNL_GEN_FILES := busy_poller netlink-dumps
> > diff --git a/tools/testing/selftests/net/skf_net_off.c b/tools/testing/selftests/net/skf_net_off.c
> > new file mode 100644
> > index 000000000000..1fdf61d6cd7f
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/skf_net_off.c
> > @@ -0,0 +1,244 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/* Open a tun device.
> > + *
> > + * [modifications: use IFF_NAPI_FRAGS, add sk filter]
> > + *
> > + * Expects the device to have been configured previously, e.g.:
> > + *   sudo ip tuntap add name tap1 mode tap
> > + *   sudo ip link set tap1 up
> > + *   sudo ip link set dev tap1 addr 02:00:00:00:00:01
> > + *   sudo ip -6 addr add fdab::1 peer fdab::2 dev tap1 nodad
> > + *
> > + * And to avoid premature pskb_may_pull:
> > + *
> > + *   sudo ethtool -K tap1 gro off
> > + *   sudo bash -c 'echo 0 > /proc/sys/net/ipv4/ip_early_demux'
> > + */
> > +
> > +#define _GNU_SOURCE
> > +
> > +#include <arpa/inet.h>
> > +#include <errno.h>
> > +#include <error.h>
> > +#include <fcntl.h>
> > +#include <getopt.h>
> > +#include <linux/filter.h>
> > +#include <linux/if.h>
> > +#include <linux/if_packet.h>
> > +#include <linux/if_tun.h>
> > +#include <linux/ipv6.h>
> > +#include <netinet/if_ether.h>
> > +#include <netinet/in.h>
> > +#include <netinet/ip.h>
> > +#include <netinet/ip6.h>
> > +#include <netinet/udp.h>
> > +#include <poll.h>
> > +#include <signal.h>
> > +#include <stdbool.h>
> > +#include <stddef.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <sys/ioctl.h>
> > +#include <sys/socket.h>
> > +#include <sys/poll.h>
> > +#include <sys/types.h>
> > +#include <sys/uio.h>
> > +#include <unistd.h>
> > +
> > +static bool cfg_do_filter;
> > +static bool cfg_do_frags;
> > +static int cfg_dst_port = 8000;
> > +static char *cfg_ifname;
> > +
> > +static int tun_open(const char *tun_name)
> > +{
> > +	struct ifreq ifr = {0};
> > +	int fd, ret;
> > +
> > +	fd = open("/dev/net/tun", O_RDWR);
> > +	if (fd == -1)
> > +		error(1, errno, "open /dev/net/tun");
> > +
> > +	ifr.ifr_flags = IFF_TAP;
> > +	if (cfg_do_frags)
> > +		ifr.ifr_flags |= IFF_NAPI | IFF_NAPI_FRAGS;
> > +
> > +	strncpy(ifr.ifr_name, tun_name, IFNAMSIZ - 1);
> > +
> > +	ret = ioctl(fd, TUNSETIFF, &ifr);
> > +	if (ret)
> > +		error(1, ret, "ioctl TUNSETIFF");
> > +
> > +	return fd;
> > +}
> > +
> > +static void sk_set_filter(int fd)
> > +{
> > +	const int offset_proto = offsetof(struct ip6_hdr, ip6_nxt);
> > +	const int offset_dport = sizeof(struct ip6_hdr) + offsetof(struct udphdr, dest);
> > +
> > +	/* Filter UDP packets with destination port cfg_dst_port */
> > +	struct sock_filter filter_code[] = {
> > +		BPF_STMT(BPF_LD  + BPF_B   + BPF_ABS, SKF_AD_OFF + SKF_AD_PKTTYPE),
> > +		BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, PACKET_HOST, 0, 4),
> > +		BPF_STMT(BPF_LD  + BPF_B   + BPF_ABS, SKF_NET_OFF + offset_proto),
> > +		BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, IPPROTO_UDP, 0, 2),
> > +		BPF_STMT(BPF_LD  + BPF_H   + BPF_ABS, SKF_NET_OFF + offset_dport),
> > +		BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, cfg_dst_port, 1, 0),
> > +		BPF_STMT(BPF_RET + BPF_K, 0),
> > +		BPF_STMT(BPF_RET + BPF_K, 0xFFFF),
> > +	};
> > +
> > +	struct sock_fprog filter = {
> > +		sizeof(filter_code) / sizeof(filter_code[0]),
> > +		filter_code,
> > +	};
> > +
> > +	if (setsockopt(fd, SOL_SOCKET, SO_ATTACH_FILTER, &filter, sizeof(filter)))
> > +		error(1, errno, "setsockopt attach filter");
> > +}
> > +
> > +static int raw_open(void)
> > +{
> > +	int fd;
> > +
> > +	fd = socket(PF_INET6, SOCK_RAW, IPPROTO_UDP);
> > +	if (fd == -1)
> > +		error(1, errno, "socket raw (udp)");
> > +
> > +	if (cfg_do_filter)
> > +		sk_set_filter(fd);
> > +
> > +	return fd;
> > +}
> > +
> > +static void tun_write(int fd)
> > +{
> > +	const char eth_src[] = { 0x02, 0x00, 0x00, 0x00, 0x00, 0x02 };
> > +	const char eth_dst[] = { 0x02, 0x00, 0x00, 0x00, 0x00, 0x01 };
> > +	struct tun_pi pi = {0};
> > +	struct ipv6hdr ip6h = {0};
> > +	struct udphdr uh = {0};
> > +	struct ethhdr eth = {0};
> > +	uint32_t payload;
> > +	struct iovec iov[5];
> > +	int ret;
> > +
> > +	pi.proto = htons(ETH_P_IPV6);
> > +
> > +	memcpy(eth.h_source, eth_src, sizeof(eth_src));
> > +	memcpy(eth.h_dest, eth_dst, sizeof(eth_dst));
> > +	eth.h_proto = htons(ETH_P_IPV6);
> > +
> > +	ip6h.version = 6;
> > +	ip6h.payload_len = htons(sizeof(uh) + sizeof(uint32_t));
> > +	ip6h.nexthdr = IPPROTO_UDP;
> > +	ip6h.hop_limit = 8;
> > +	if (inet_pton(AF_INET6, "fdab::2", &ip6h.saddr) != 1)
> > +		error(1, errno, "inet_pton src");
> > +	if (inet_pton(AF_INET6, "fdab::1", &ip6h.daddr) != 1)
> > +		error(1, errno, "inet_pton src");
> > +
> > +	uh.source = htons(8000);
> > +	uh.dest = htons(cfg_dst_port);
> > +	uh.len = ip6h.payload_len;
> > +	uh.check = 0;
> > +
> > +	payload = htonl(0xABABABAB);		/* Covered in IPv6 length */
> > +
> > +	iov[0].iov_base = &pi;
> > +	iov[0].iov_len  = sizeof(pi);
> > +	iov[1].iov_base = &eth;
> > +	iov[1].iov_len  = sizeof(eth);
> > +	iov[2].iov_base = &ip6h;
> > +	iov[2].iov_len  = sizeof(ip6h);
> > +	iov[3].iov_base = &uh;
> > +	iov[3].iov_len  = sizeof(uh);
> > +	iov[4].iov_base = &payload;
> > +	iov[4].iov_len  = sizeof(payload);
> > +
> > +	ret = writev(fd, iov, sizeof(iov) / sizeof(iov[0]));
> > +	if (ret <= 0)
> > +		error(1, errno, "writev");
> > +}
> > +
> > +static void raw_read(int fd)
> > +{
> > +	struct timeval tv = { .tv_usec = 100 * 1000 };
> > +	struct msghdr msg = {0};
> > +	struct iovec iov[2];
> > +	struct udphdr uh;
> > +	uint32_t payload[2];
> > +	int ret;
> > +
> > +	if (setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv)))
> > +		error(1, errno, "setsockopt rcvtimeo udp");
> > +
> > +	iov[0].iov_base = &uh;
> > +	iov[0].iov_len = sizeof(uh);
> > +
> > +	iov[1].iov_base = payload;
> > +	iov[1].iov_len = sizeof(payload);
> > +
> > +	msg.msg_iov = iov;
> > +	msg.msg_iovlen = sizeof(iov) / sizeof(iov[0]);
> > +
> > +	ret = recvmsg(fd, &msg, 0);
> > +	if (ret <= 0)
> > +		error(1, errno, "read raw");
> > +	if (ret != sizeof(uh) + sizeof(payload[0]))
> > +		error(1, errno, "read raw: len=%d\n", ret);
> > +
> > +	fprintf(stderr, "raw recv: 0x%x\n", payload[0]);
> > +}
> > +
> > +static void parse_opts(int argc, char **argv)
> > +{
> > +	int c;
> > +
> > +	while ((c = getopt(argc, argv, "fFi:")) != -1) {
> > +		switch (c) {
> > +		case 'f':
> > +			cfg_do_filter = true;
> > +			printf("bpf filter enabled\n");
> > +			break;
> > +		case 'F':
> > +			cfg_do_frags = true;
> > +			printf("napi frags mode enabled\n");
> > +			break;
> > +		case 'i':
> > +			cfg_ifname = optarg;
> > +			break;
> > +		default:
> > +			error(1, 0, "unknown option %c", optopt);
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (!cfg_ifname)
> > +		error(1, 0, "must specify tap interface name (-i)");
> > +}
> > +
> > +int main(int argc, char **argv)
> > +{
> > +	int fdt, fdr;
> > +
> > +	parse_opts(argc, argv);
> > +
> > +	fdr = raw_open();
> > +	fdt = tun_open(cfg_ifname);
> > +
> > +	tun_write(fdt);
> > +	raw_read(fdr);
> > +
> > +	if (close(fdt))
> > +		error(1, errno, "close tun");
> > +	if (close(fdr))
> > +		error(1, errno, "close udp");
> > +
> > +	fprintf(stderr, "OK\n");
> > +	return 0;
> > +}
> > +
> > diff --git a/tools/testing/selftests/net/skf_net_off.sh b/tools/testing/selftests/net/skf_net_off.sh
> > new file mode 100755
> > index 000000000000..e9cce93a0258
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/skf_net_off.sh
> > @@ -0,0 +1,28 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +readonly NS="ns-$(mktemp -u XXXXXX)"
> > +
> > +cleanup() {
> > +	ip netns del $NS
> > +}
> > +
> > +ip netns add $NS
> > +trap cleanup EXIT
> > +
> > +ip -netns $NS link set lo up
> > +ip -netns $NS tuntap add name tap1 mode tap
> > +ip -netns $NS link set tap1 up
> > +ip -netns $NS link set dev tap1 addr 02:00:00:00:00:01
> > +ip -netns $NS -6 addr add fdab::1 peer fdab::2 dev tap1 nodad
> > +ip netns exec $NS ethtool -K tap1 gro off
> > +ip netns exec $NS sysctl -w net.ipv4.ip_early_demux=0
> 
> Curious: why disable ip_early_demux here?

Otherwise early demux will pull the headers into linear, in
udp_v6_early_demux

