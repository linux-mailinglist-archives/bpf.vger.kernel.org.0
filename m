Return-Path: <bpf+bounces-11658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB287BCC52
	for <lists+bpf@lfdr.de>; Sun,  8 Oct 2023 07:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D7681C20AFB
	for <lists+bpf@lfdr.de>; Sun,  8 Oct 2023 05:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CBD522E;
	Sun,  8 Oct 2023 05:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="vvSK8kZQ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA031FC8
	for <bpf@vger.kernel.org>; Sun,  8 Oct 2023 05:22:53 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10717C6
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 22:22:51 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-69101022969so3128780b3a.3
        for <bpf@vger.kernel.org>; Sat, 07 Oct 2023 22:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696742570; x=1697347370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKBP9OidVZtRjyPI+dL7f0Ou7EZ8mYm7HxjxyAavXjY=;
        b=vvSK8kZQtk0o++AJ/wQ3H9cIiAUNeDlPvKenKS9pxFGBkUgi2Lqi3FZJVjC3GqYzW5
         sB3XpCizq93t/e9Fd6ibctWLD7zPrds7GpT4Kz4/ZIIu27iMiFwUAw6G+erAiv3rcHbk
         bKR+Th74BWLc7GIVszisIpI1aTO5O8r433Ki7Vk/OuAl6GUMpvmqoT8yaFFiF5C1nNXz
         Vy45AQZsleY+8UUee1vhMBvxgpAI1Mth4IbrUzdud70Rp7pKR7bXx5CKfo2aDdUzD2aw
         Ec3tU1JuvTZtXp0tpLS9HpjNaP8qC5v2Lj5UUGwn4dpuLNPHook9A2S9WDRmJN/0UWv+
         3o0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696742570; x=1697347370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oKBP9OidVZtRjyPI+dL7f0Ou7EZ8mYm7HxjxyAavXjY=;
        b=h0fSJuUgd5+l8MWtk4Fmkgwe8Wlmu+dUZupEv2KRUhUJgfHLAN+R5ebn+lvA5UT0uO
         OB1vee1D/fpGOWFHWpfkdpeXv/U5wUE99LLgUNNVwJnLmR6zd+2tguH07F3qFWIAf2Pb
         t6Tyl9o3mSHNRT3OE2053vlYwkq3FLdCeY7bmUW4g8mdBQWYpLgWkGkFsDBuhPih/Soe
         TBL7586IyECdohfO1537qWvOzVwq31xSVKAmmg5rwnZ0nmngZdRIUELAg0T5L4esK9O/
         +mtnt0zv7dumjr415Oe0zrKDVwP4pdAWsvDNrbLgUbTNpU98+MDp5d7IJ6bsK8K5C2L0
         cbgg==
X-Gm-Message-State: AOJu0YzS58+s2j3BtwALDY1kYEyXo3uYKBwBJ1rvRJ6mNArjFzRiFult
	R4lBhAG4oJK2UaUK7eR5+Y/9SQ==
X-Google-Smtp-Source: AGHT+IG36H9U5TphBvXsn5jJ+RFrSEAA6EIqoSwejagR/ikRbdmjuiGs25vIJjx3PZ2OM+wTCNw+Mw==
X-Received: by 2002:a05:6a00:348f:b0:696:8874:c12b with SMTP id cp15-20020a056a00348f00b006968874c12bmr12867686pfb.13.1696742570518;
        Sat, 07 Oct 2023 22:22:50 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with UTF8SMTPSA id k14-20020aa792ce000000b006933f85bc29sm3958551pfa.111.2023.10.07.22.22.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Oct 2023 22:22:50 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo Shuah Khan <"xuanzhuo@linux.alibaba.comshuah"@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
	kpsingh@kernel.org, rdunlap@infradead.org, willemb@google.com,
	gustavoars@kernel.org, herbert@gondor.apana.org.au,
	steffen.klassert@secunet.com, nogikh@google.com, pablo@netfilter.org,
	decui@microsoft.com, cai@lca.pw, jakub@cloudflare.com,
	elver@google.com, pabeni@redhat.com,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [RFC PATCH 6/7] selftest: tun: Add tests for virtio-net hashing
Date: Sun,  8 Oct 2023 14:20:50 +0900
Message-ID: <20231008052101.144422-7-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231008052101.144422-1-akihiko.odaki@daynix.com>
References: <20231008052101.144422-1-akihiko.odaki@daynix.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The added tests confirm tun can perform RSS and hash reporting, and
reject invalid configurations for them.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tools/testing/selftests/net/Makefile |   2 +-
 tools/testing/selftests/net/tun.c    | 578 ++++++++++++++++++++++++++-
 2 files changed, 572 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 8b017070960d..253a683073d9 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -2,7 +2,7 @@
 # Makefile for net selftests
 
 CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g
-CFLAGS += -I../../../../usr/include/ $(KHDR_INCLUDES)
+CFLAGS += -I../../../../usr/include/ -I../../../include/ $(KHDR_INCLUDES)
 # Additional include paths needed by kselftest.h
 CFLAGS += -I../
 
diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index fa83918b62d1..862652fb4ed4 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -2,21 +2,39 @@
 
 #define _GNU_SOURCE
 
+#include <endian.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <stddef.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
-#include <linux/if.h>
+#include <net/if.h>
+#include <netinet/ip.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+#include <linux/compiler.h>
+#include <linux/icmp.h>
+#include <linux/if_arp.h>
 #include <linux/if_tun.h>
+#include <linux/ipv6.h>
 #include <linux/netlink.h>
 #include <linux/rtnetlink.h>
-#include <sys/ioctl.h>
-#include <sys/socket.h>
+#include <linux/sockios.h>
+#include <linux/tcp.h>
+#include <linux/udp.h>
+#include <linux/virtio_net.h>
 
 #include "../kselftest_harness.h"
 
+#define TUN_HWADDR_SOURCE { 0x02, 0x00, 0x00, 0x00, 0x00, 0x00 }
+
+#define TUN_HWADDR_DEST { 0x02, 0x00, 0x00, 0x00, 0x00, 0x01 }
+
+#define TUN_IPADDR_SOURCE htonl((172 << 24) | (17 << 16) | 0)
+#define TUN_IPADDR_DEST htonl((172 << 24) | (17 << 16) | 1)
+
 static int tun_attach(int fd, char *dev)
 {
 	struct ifreq ifr;
@@ -39,7 +57,7 @@ static int tun_detach(int fd, char *dev)
 	return ioctl(fd, TUNSETQUEUE, (void *) &ifr);
 }
 
-static int tun_alloc(char *dev)
+static int tun_alloc(char *dev, short flags)
 {
 	struct ifreq ifr;
 	int fd, err;
@@ -52,7 +70,8 @@ static int tun_alloc(char *dev)
 
 	memset(&ifr, 0, sizeof(ifr));
 	strcpy(ifr.ifr_name, dev);
-	ifr.ifr_flags = IFF_TAP | IFF_NAPI | IFF_MULTI_QUEUE;
+	ifr.ifr_flags = flags | IFF_TAP | IFF_NAPI | IFF_NO_PI |
+			IFF_MULTI_QUEUE;
 
 	err = ioctl(fd, TUNSETIFF, (void *) &ifr);
 	if (err < 0) {
@@ -64,6 +83,40 @@ static int tun_alloc(char *dev)
 	return fd;
 }
 
+static bool tun_add_to_bridge(int local_fd, const char *name)
+{
+	struct ifreq ifreq = {
+		.ifr_name = "xbridge",
+		.ifr_ifindex = if_nametoindex(name)
+	};
+
+	if (!ifreq.ifr_ifindex) {
+		perror("if_nametoindex");
+		return false;
+	}
+
+	if (ioctl(local_fd, SIOCBRADDIF, &ifreq)) {
+		perror("SIOCBRADDIF");
+		return false;
+	}
+
+	return true;
+}
+
+static bool tun_set_flags(int local_fd, const char *name, short flags)
+{
+	struct ifreq ifreq = { .ifr_flags = flags };
+
+	strcpy(ifreq.ifr_name, name);
+
+	if (ioctl(local_fd, SIOCSIFFLAGS, &ifreq)) {
+		perror("SIOCSIFFLAGS");
+		return false;
+	}
+
+	return true;
+}
+
 static int tun_delete(char *dev)
 {
 	struct {
@@ -102,6 +155,153 @@ static int tun_delete(char *dev)
 	return ret;
 }
 
+static uint32_t tun_sum(const void *buf, size_t len)
+{
+	const uint16_t *sbuf = buf;
+	uint32_t sum = 0;
+
+	while (len > 1) {
+		sum += *sbuf++;
+		len -= 2;
+	}
+
+	if (len)
+		sum += *(uint8_t *)sbuf;
+
+	return sum;
+}
+
+static uint16_t tun_build_ip_check(uint32_t sum)
+{
+	return ~((sum & 0xffff) + (sum >> 16));
+}
+
+static uint32_t tun_build_ip_pseudo_sum(const void *iphdr)
+{
+	uint16_t tot_len = ntohs(((struct iphdr *)iphdr)->tot_len);
+
+	return tun_sum((char *)iphdr + offsetof(struct iphdr, saddr), 8) +
+	       htons(((struct iphdr *)iphdr)->protocol) +
+	       htons(tot_len - sizeof(struct iphdr));
+}
+
+static uint32_t tun_build_ipv6_pseudo_sum(const void *ipv6hdr)
+{
+	return tun_sum((char *)ipv6hdr + offsetof(struct ipv6hdr, saddr), 32) +
+	       ((struct ipv6hdr *)ipv6hdr)->payload_len +
+	       htons(((struct ipv6hdr *)ipv6hdr)->nexthdr);
+}
+
+static void tun_build_ethhdr(struct ethhdr *ethhdr, uint16_t proto)
+{
+	*ethhdr = (struct ethhdr) {
+		.h_dest = TUN_HWADDR_DEST,
+		.h_source = TUN_HWADDR_SOURCE,
+		.h_proto = htons(proto)
+	};
+}
+
+static void tun_build_iphdr(void *dest, uint16_t len, uint8_t protocol)
+{
+	struct iphdr iphdr = {
+		.ihl = sizeof(iphdr) / 4,
+		.version = 4,
+		.tot_len = htons(sizeof(iphdr) + len),
+		.ttl = 255,
+		.protocol = protocol,
+		.saddr = TUN_IPADDR_SOURCE,
+		.daddr = TUN_IPADDR_DEST
+	};
+
+	iphdr.check = tun_build_ip_check(tun_sum(&iphdr, sizeof(iphdr)));
+	memcpy(dest, &iphdr, sizeof(iphdr));
+}
+
+static void tun_build_ipv6hdr(void *dest, uint16_t len, uint8_t protocol)
+{
+	struct ipv6hdr ipv6hdr = {
+		.version = 6,
+		.payload_len = htons(len),
+		.nexthdr = protocol,
+		.saddr = {
+			.s6_addr32 = {
+				htonl(0xffff0000), 0, 0, TUN_IPADDR_SOURCE
+			}
+		},
+		.daddr = {
+			.s6_addr32 = {
+				htonl(0xffff0000), 0, 0, TUN_IPADDR_DEST
+			}
+		},
+	};
+
+	memcpy(dest, &ipv6hdr, sizeof(ipv6hdr));
+}
+
+static void tun_build_tcphdr(void *dest, uint32_t sum)
+{
+	struct tcphdr tcphdr = {
+		.source = htons(9),
+		.dest = htons(9),
+		.fin = 1,
+		.doff = sizeof(tcphdr) / 4,
+	};
+	uint32_t tcp_sum = tun_sum(&tcphdr, sizeof(tcphdr));
+
+	tcphdr.check = tun_build_ip_check(sum + tcp_sum);
+	memcpy(dest, &tcphdr, sizeof(tcphdr));
+}
+
+static void tun_build_udphdr(void *dest, uint32_t sum)
+{
+	struct udphdr udphdr = {
+		.source = htons(9),
+		.dest = htons(9),
+		.len = htons(sizeof(udphdr)),
+	};
+	uint32_t udp_sum = tun_sum(&udphdr, sizeof(udphdr));
+
+	udphdr.check = tun_build_ip_check(sum + udp_sum);
+	memcpy(dest, &udphdr, sizeof(udphdr));
+}
+
+static bool tun_vnet_hash_check(int source_fd, const int *dest_fds,
+				const void *buffer, size_t len,
+				uint16_t report, uint32_t value)
+{
+	size_t read_len = sizeof(struct virtio_net_hdr_v1_hash) + len;
+	struct virtio_net_hdr_v1_hash *read_buffer;
+	int ret;
+
+	if (write(source_fd, buffer, len) != len) {
+		perror("write");
+		return false;
+	}
+
+	read_buffer = malloc(read_len);
+	if (!read_buffer) {
+		perror("malloc");
+		return false;
+	}
+
+	ret = read(dest_fds[value & 1], read_buffer, read_len);
+	if (ret != read_len) {
+		perror("read");
+		free(read_buffer);
+		return false;
+	}
+
+	if (read_buffer->hash_value != htole32(value) ||
+	    read_buffer->hash_report != htole16(report) ||
+	    memcmp(read_buffer + 1, buffer, len)) {
+		free(read_buffer);
+		return false;
+	}
+
+	free(read_buffer);
+	return true;
+}
+
 FIXTURE(tun)
 {
 	char ifname[IFNAMSIZ];
@@ -112,10 +312,10 @@ FIXTURE_SETUP(tun)
 {
 	memset(self->ifname, 0, sizeof(self->ifname));
 
-	self->fd = tun_alloc(self->ifname);
+	self->fd = tun_alloc(self->ifname, 0);
 	ASSERT_GE(self->fd, 0);
 
-	self->fd2 = tun_alloc(self->ifname);
+	self->fd2 = tun_alloc(self->ifname, 0);
 	ASSERT_GE(self->fd2, 0);
 }
 
@@ -159,4 +359,368 @@ TEST_F(tun, reattach_close_delete) {
 	EXPECT_EQ(tun_delete(self->ifname), 0);
 }
 
+FIXTURE(tun_vnet_hash)
+{
+	int local_fd;
+	int source_fd;
+	int dest_fds[2];
+};
+
+FIXTURE_SETUP(tun_vnet_hash)
+{
+	static const struct {
+		struct tun_vnet_hash hdr;
+		uint16_t indirection_table[ARRAY_SIZE(self->dest_fds)];
+		uint8_t key[40];
+	} vnet_hash = {
+		.hdr = {
+			.flags = TUN_VNET_HASH_REPORT | TUN_VNET_HASH_RSS,
+			.types = VIRTIO_NET_RSS_HASH_TYPE_IPv4 |
+				VIRTIO_NET_RSS_HASH_TYPE_TCPv4 |
+				VIRTIO_NET_RSS_HASH_TYPE_UDPv4 |
+				VIRTIO_NET_RSS_HASH_TYPE_IPv6 |
+				VIRTIO_NET_RSS_HASH_TYPE_TCPv6 |
+				VIRTIO_NET_RSS_HASH_TYPE_UDPv6,
+			.indirection_table_mask = 1
+		},
+		.indirection_table = { 0, 1 },
+		.key = {
+			0x6d, 0x5a, 0x56, 0xda, 0x25, 0x5b, 0x0e, 0xc2,
+			0x41, 0x67, 0x25, 0x3d, 0x43, 0xa3, 0x8f, 0xb0,
+			0xd0, 0xca, 0x2b, 0xcb, 0xae, 0x7b, 0x30, 0xb4,
+			0x77, 0xcb, 0x2d, 0xa3, 0x80, 0x30, 0xf2, 0x0c,
+			0x6a, 0x42, 0xb7, 0x3b, 0xbe, 0xac, 0x01, 0xfa
+		}
+	};
+
+	struct {
+		struct virtio_net_hdr_v1_hash vnet_hdr;
+		struct ethhdr ethhdr;
+		struct arphdr arphdr;
+		unsigned char sender_hwaddr[6];
+		uint32_t sender_ipaddr;
+		unsigned char target_hwaddr[6];
+		uint32_t target_ipaddr;
+	} __packed packet = {
+		.ethhdr = {
+			.h_source = TUN_HWADDR_SOURCE,
+			.h_dest = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff },
+			.h_proto = htons(ETH_P_ARP)
+		},
+		.arphdr = {
+			.ar_hrd = htons(ARPHRD_ETHER),
+			.ar_pro = htons(ETH_P_IP),
+			.ar_hln = ETH_ALEN,
+			.ar_pln = 4,
+			.ar_op = htons(ARPOP_REQUEST)
+		},
+		.sender_hwaddr = TUN_HWADDR_DEST,
+		.sender_ipaddr = TUN_IPADDR_DEST,
+		.target_ipaddr = TUN_IPADDR_DEST
+	};
+
+	char ifname[IFNAMSIZ];
+	int i;
+
+	self->local_fd = socket(AF_LOCAL, SOCK_STREAM, 0);
+	ASSERT_GE(self->local_fd, 0);
+
+	ASSERT_EQ(ioctl(self->local_fd, SIOCBRADDBR, "xbridge"), 0);
+	ASSERT_TRUE(tun_set_flags(self->local_fd, "xbridge", IFF_UP));
+
+	ifname[0] = 0;
+	self->source_fd = tun_alloc(ifname, 0);
+	ASSERT_GE(self->source_fd, 0);
+	ASSERT_TRUE(tun_add_to_bridge(self->local_fd, ifname));
+	ASSERT_TRUE(tun_set_flags(self->local_fd, ifname, IFF_UP));
+
+	ifname[0] = 0;
+	for (size_t i = 0; i < ARRAY_SIZE(self->dest_fds); i++) {
+		self->dest_fds[i] = tun_alloc(ifname, IFF_VNET_HDR);
+		ASSERT_GE(self->dest_fds[i], 0);
+	}
+
+	ASSERT_TRUE(tun_add_to_bridge(self->local_fd, ifname));
+	i = sizeof(struct virtio_net_hdr_v1_hash);
+	ASSERT_EQ(ioctl(self->dest_fds[0], TUNSETVNETHDRSZ, &i), 0);
+	i = 1;
+	ASSERT_EQ(ioctl(self->dest_fds[0], TUNSETVNETLE, &i), 0);
+	ASSERT_TRUE(tun_set_flags(self->local_fd, ifname, IFF_UP));
+	ASSERT_EQ(write(self->dest_fds[0], &packet, sizeof(packet)),
+		  sizeof(packet));
+	ASSERT_EQ(ioctl(self->dest_fds[0], TUNSETVNETHASH, &vnet_hash), 0);
+}
+
+FIXTURE_TEARDOWN(tun_vnet_hash)
+{
+	ASSERT_TRUE(tun_set_flags(self->local_fd, "xbridge", 0));
+	EXPECT_EQ(ioctl(self->local_fd, SIOCBRDELBR, "xbridge"), 0);
+	EXPECT_EQ(close(self->source_fd), 0);
+
+	for (size_t i = 0; i < ARRAY_SIZE(self->dest_fds); i++)
+		EXPECT_EQ(close(self->dest_fds[i]), 0);
+
+	EXPECT_EQ(close(self->local_fd), 0);
+}
+
+TEST_F(tun_vnet_hash, ipv4)
+{
+	struct {
+		struct ethhdr ethhdr;
+		struct iphdr iphdr;
+	} __packed packet;
+
+	tun_build_ethhdr(&packet.ethhdr, ETH_P_IP);
+	tun_build_iphdr(&packet.iphdr, 0, 253);
+
+	EXPECT_TRUE(tun_vnet_hash_check(self->source_fd, self->dest_fds,
+					&packet, sizeof(packet),
+					VIRTIO_NET_HASH_REPORT_IPv4,
+					0x9246d590));
+}
+
+TEST_F(tun_vnet_hash, tcpv4)
+{
+	struct {
+		struct ethhdr ethhdr;
+		struct iphdr iphdr;
+		struct tcphdr tcphdr;
+	} __packed packet;
+
+	tun_build_ethhdr(&packet.ethhdr, ETH_P_IP);
+	tun_build_iphdr(&packet.iphdr, sizeof(struct tcphdr), IPPROTO_TCP);
+
+	tun_build_tcphdr(&packet.tcphdr,
+			 tun_build_ip_pseudo_sum(&packet.iphdr));
+
+	EXPECT_TRUE(tun_vnet_hash_check(self->source_fd, self->dest_fds,
+					&packet, sizeof(packet),
+					VIRTIO_NET_HASH_REPORT_TCPv4,
+					0xfad3f31a));
+}
+
+TEST_F(tun_vnet_hash, udpv4)
+{
+	struct {
+		struct ethhdr ethhdr;
+		struct iphdr iphdr;
+		struct udphdr udphdr;
+	} __packed packet;
+
+	tun_build_ethhdr(&packet.ethhdr, ETH_P_IP);
+	tun_build_iphdr(&packet.iphdr, sizeof(struct udphdr), IPPROTO_UDP);
+
+	tun_build_udphdr(&packet.udphdr,
+			 tun_build_ip_pseudo_sum(&packet.iphdr));
+
+	EXPECT_TRUE(tun_vnet_hash_check(self->source_fd, self->dest_fds,
+					&packet, sizeof(packet),
+					VIRTIO_NET_HASH_REPORT_UDPv4,
+					0xfad3f31a));
+}
+
+TEST_F(tun_vnet_hash, ipv6)
+{
+	struct {
+		struct ethhdr ethhdr;
+		struct ipv6hdr ipv6hdr;
+	} __packed packet;
+
+	tun_build_ethhdr(&packet.ethhdr, ETH_P_IPV6);
+	tun_build_ipv6hdr(&packet.ipv6hdr, 0, 253);
+
+	EXPECT_TRUE(tun_vnet_hash_check(self->source_fd, self->dest_fds,
+					&packet, sizeof(packet),
+					VIRTIO_NET_HASH_REPORT_IPv6,
+					0x6b7835b3));
+}
+
+TEST_F(tun_vnet_hash, tcpv6)
+{
+	struct {
+		struct ethhdr ethhdr;
+		struct ipv6hdr ipv6hdr;
+		struct tcphdr tcphdr;
+	} __packed packet;
+
+	tun_build_ethhdr(&packet.ethhdr, ETH_P_IPV6);
+	tun_build_ipv6hdr(&packet.ipv6hdr, sizeof(struct tcphdr), IPPROTO_TCP);
+
+	tun_build_tcphdr(&packet.tcphdr,
+			 tun_build_ipv6_pseudo_sum(&packet.ipv6hdr));
+
+	EXPECT_TRUE(tun_vnet_hash_check(self->source_fd, self->dest_fds,
+					&packet, sizeof(packet),
+					VIRTIO_NET_HASH_REPORT_TCPv6,
+					0x6c6717));
+}
+
+TEST_F(tun_vnet_hash, udpv6)
+{
+	struct {
+		struct ethhdr ethhdr;
+		struct ipv6hdr ipv6hdr;
+		struct udphdr udphdr;
+	} __packed packet;
+
+	tun_build_ethhdr(&packet.ethhdr, ETH_P_IPV6);
+	tun_build_ipv6hdr(&packet.ipv6hdr, sizeof(struct udphdr), IPPROTO_UDP);
+
+	tun_build_udphdr(&packet.udphdr,
+			 tun_build_ipv6_pseudo_sum(&packet.ipv6hdr));
+
+	EXPECT_TRUE(tun_vnet_hash_check(self->source_fd, self->dest_fds,
+					&packet, sizeof(packet),
+					VIRTIO_NET_HASH_REPORT_UDPv6,
+					0x6c6717));
+}
+
+FIXTURE(tun_vnet_hash_config)
+{
+	int fd;
+};
+
+FIXTURE_SETUP(tun_vnet_hash_config)
+{
+	char ifname[IFNAMSIZ];
+
+	ifname[0] = 0;
+	self->fd = tun_alloc(ifname, 0);
+	ASSERT_GE(self->fd, 0);
+}
+
+FIXTURE_TEARDOWN(tun_vnet_hash_config)
+{
+	EXPECT_EQ(close(self->fd), 0);
+}
+
+TEST_F(tun_vnet_hash_config, cap)
+{
+	struct tun_vnet_hash_cap cap;
+
+	ASSERT_EQ(ioctl(self->fd, TUNGETVNETHASHCAP, &cap), 0);
+	EXPECT_EQ(cap.max_indirection_table_length, 128);
+	EXPECT_EQ(cap.types,
+		  VIRTIO_NET_RSS_HASH_TYPE_IPv4 |
+		  VIRTIO_NET_RSS_HASH_TYPE_TCPv4 |
+		  VIRTIO_NET_RSS_HASH_TYPE_UDPv4 |
+		  VIRTIO_NET_RSS_HASH_TYPE_IPv6 |
+		  VIRTIO_NET_RSS_HASH_TYPE_TCPv6 |
+		  VIRTIO_NET_RSS_HASH_TYPE_UDPv6);
+}
+
+TEST_F(tun_vnet_hash_config, insufficient_hdr_sz)
+{
+	static const struct tun_vnet_hash vnet_hash = {
+		.flags = TUN_VNET_HASH_REPORT
+	};
+	int i;
+
+	i = 1;
+	ASSERT_EQ(ioctl(self->fd, TUNSETVNETLE, &i), 0);
+
+	ASSERT_EQ(ioctl(self->fd, TUNSETVNETHASH, &vnet_hash), -1);
+	EXPECT_EQ(errno, EINVAL);
+}
+
+TEST_F(tun_vnet_hash_config, shrink_hdr_sz)
+{
+	static const struct tun_vnet_hash vnet_hash = {
+		.flags = TUN_VNET_HASH_REPORT
+	};
+	int i;
+
+	i = sizeof(struct virtio_net_hdr_v1_hash);
+	ASSERT_EQ(ioctl(self->fd, TUNSETVNETHDRSZ, &i), 0);
+
+	i = 1;
+	ASSERT_EQ(ioctl(self->fd, TUNSETVNETLE, &i), 0);
+
+	ASSERT_EQ(ioctl(self->fd, TUNSETVNETHASH, &vnet_hash), 0);
+
+	i = sizeof(struct virtio_net_hdr);
+	ASSERT_EQ(ioctl(self->fd, TUNSETVNETHDRSZ, &i), -1);
+	EXPECT_EQ(errno, EINVAL);
+}
+
+TEST_F(tun_vnet_hash_config, too_big_indirection_table)
+{
+	static const struct tun_vnet_hash vnet_hash = {
+		.flags = TUN_VNET_HASH_REPORT,
+		.indirection_table_mask = 255
+	};
+	int i;
+
+	i = sizeof(struct virtio_net_hdr_v1_hash);
+	ASSERT_EQ(ioctl(self->fd, TUNSETVNETHDRSZ, &i), 0);
+
+	i = 1;
+	ASSERT_EQ(ioctl(self->fd, TUNSETVNETLE, &i), 0);
+
+	ASSERT_EQ(ioctl(self->fd, TUNSETVNETHASH, &vnet_hash), -1);
+	EXPECT_EQ(errno, EINVAL);
+}
+
+TEST_F(tun_vnet_hash_config, set_be_early)
+{
+	static const struct tun_vnet_hash vnet_hash = {
+		.flags = TUN_VNET_HASH_REPORT
+	};
+	int i;
+
+	i = 1;
+	if (ioctl(self->fd, TUNSETVNETBE, &i))
+		return;
+
+	i = sizeof(struct virtio_net_hdr_v1_hash);
+	ASSERT_EQ(ioctl(self->fd, TUNSETVNETHDRSZ, &i), 0);
+
+	ASSERT_EQ(ioctl(self->fd, TUNSETVNETHASH, &vnet_hash), -1);
+	EXPECT_EQ(errno, EINVAL);
+}
+
+TEST_F(tun_vnet_hash_config, set_be_later)
+{
+	static const struct tun_vnet_hash vnet_hash = {
+		.flags = TUN_VNET_HASH_REPORT
+	};
+	int i;
+
+	i = sizeof(struct virtio_net_hdr_v1_hash);
+	ASSERT_EQ(ioctl(self->fd, TUNSETVNETHDRSZ, &i), 0);
+
+	if (ioctl(self->fd, TUNSETVNETHASH, &vnet_hash))
+		return;
+
+	i = 1;
+	ASSERT_EQ(ioctl(self->fd, TUNSETVNETBE, &i), -1);
+	EXPECT_EQ(errno, EINVAL);
+}
+
+TEST_F(tun_vnet_hash_config, unset_le_later)
+{
+	static const struct tun_vnet_hash vnet_hash = {
+		.flags = TUN_VNET_HASH_REPORT
+	};
+	int i;
+
+	i = sizeof(struct virtio_net_hdr_v1_hash);
+	ASSERT_EQ(ioctl(self->fd, TUNSETVNETHDRSZ, &i), 0);
+
+	i = 1;
+	ioctl(self->fd, TUNSETVNETBE, &i);
+
+	if (!ioctl(self->fd, TUNSETVNETHASH, &vnet_hash))
+		return;
+
+	i = 1;
+	ASSERT_EQ(ioctl(self->fd, TUNSETVNETLE, &i), 0);
+
+	ASSERT_EQ(ioctl(self->fd, TUNSETVNETHASH, &vnet_hash), 0);
+
+	i = 0;
+	ASSERT_EQ(ioctl(self->fd, TUNSETVNETLE, &i), -1);
+	EXPECT_EQ(errno, EINVAL);
+}
+
 TEST_HARNESS_MAIN
-- 
2.42.0


