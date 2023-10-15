Return-Path: <bpf+bounces-12236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6597C998B
	for <lists+bpf@lfdr.de>; Sun, 15 Oct 2023 16:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6FB3B20D27
	for <lists+bpf@lfdr.de>; Sun, 15 Oct 2023 14:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2903A7464;
	Sun, 15 Oct 2023 14:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="PEYPCRgK"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2101F7498
	for <bpf@vger.kernel.org>; Sun, 15 Oct 2023 14:18:13 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6935AEE
	for <bpf@vger.kernel.org>; Sun, 15 Oct 2023 07:17:57 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6c615df24c0so2460228a34.1
        for <bpf@vger.kernel.org>; Sun, 15 Oct 2023 07:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697379477; x=1697984277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1mvW2t/KaK6qhmD8VB0bMy9T0sNtWqMqFjE4LFqirU=;
        b=PEYPCRgKus0rda0MhcXO5x2VbSl1KXWVJNCMQOGwa6AvftUWVwhruiaWAsgzcw3QIl
         FYVCBe5knKjWpHSEpAumK5NvaPYkDPVl2CEWDlLHWX5QFILT+11Ln3x0iR6IskEywF4Z
         JV/TMWoOWecs2rO2avEt+022fbjjFvrl/MZd/qz6BkSvV06TLX3CiAF2/zThv9ALbybB
         CwrwkB/zOYLxsIW5rH0beUvGKg6Crm1qWlDCDdtYRbaCFjiy91kJkiG7iYQ5qSJbp4xI
         b7XVj/mL3WV+2/HuoWnKAWSDdm1mdj1TYq60IEhVu4dKAkZvjogDVrpRmyR0RDN79GBt
         +1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697379477; x=1697984277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/1mvW2t/KaK6qhmD8VB0bMy9T0sNtWqMqFjE4LFqirU=;
        b=TzITF7WH04SRt6b4pGANGma/VXtsTNVTA12uhkGhs8LeNBYszi7J2GZyIDZLwtFn27
         2GBccvJ8NKosxtcC9E9EZl101mDlmpawW8YVWTV8XFRMtJZCu+BXyxWs4EMDTNIfaL2N
         r7sFHtAAz+dLlcyR9uGRMpeNTt7Py/+tGkf2e59ymb4ddZMk94BuC4uSP2xA0We3b+hz
         RPoThHLFkA6OzZavDMmRa5Bly8EOOoZAp6t4sGAk9ejvIVgUMnirwWoregjlUGzdkcl/
         U925kKJ37dF0HzYKo+Cqywq2EC6NZyl+4JDBkaKC+5UskKTVvkcy85F37qcuSVWeLBew
         cfFA==
X-Gm-Message-State: AOJu0Yw2OOoIE65ehGYDf44azRD8gAI+CKhUoYCzp0sqh0R0IGyF43+1
	4b54ln6wIKAw0HPSO1UQokZqXg==
X-Google-Smtp-Source: AGHT+IE6nBGBidFux5UPalixOnmQwVzr+KLBQdRpHoTGY90spcP7YYT4kzA5jLuRVCH74DvN30YsVQ==
X-Received: by 2002:a05:6830:4bc:b0:6bc:952a:1032 with SMTP id l28-20020a05683004bc00b006bc952a1032mr33799823otd.14.1697379477144;
        Sun, 15 Oct 2023 07:17:57 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with UTF8SMTPSA id x6-20020a636306000000b005ab46970aaasm4098753pgb.17.2023.10.15.07.17.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Oct 2023 07:17:56 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kselftest@vger.kernel.org,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Andrew Melnychenko <andrew@daynix.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [RFC PATCH v2 6/7] selftests/bpf: Test BPF_PROG_TYPE_VNET_HASH
Date: Sun, 15 Oct 2023 23:16:34 +0900
Message-ID: <20231015141644.260646-7-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231015141644.260646-1-akihiko.odaki@daynix.com>
References: <20231015141644.260646-1-akihiko.odaki@daynix.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The added tests will ensure that the new relevant members of struct
__sk_buff are initialized with 0, that the members are properly
interpreted by tun, and tun checks the virtio-net header size before
reporting hash values and types the BPF program computed.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tools/testing/selftests/bpf/config            |   1 +
 tools/testing/selftests/bpf/config.aarch64    |   1 -
 .../selftests/bpf/prog_tests/vnet_hash.c      | 385 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/vnet_hash.c |  16 +
 4 files changed, 402 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/vnet_hash.c
 create mode 100644 tools/testing/selftests/bpf/progs/vnet_hash.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index e41eb33b2704..c05defa83b44 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -10,6 +10,7 @@ CONFIG_BPF_LSM=y
 CONFIG_BPF_STREAM_PARSER=y
 CONFIG_BPF_SYSCALL=y
 # CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
+CONFIG_BRIDGE=y
 CONFIG_CGROUP_BPF=y
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_SHA256=y
diff --git a/tools/testing/selftests/bpf/config.aarch64 b/tools/testing/selftests/bpf/config.aarch64
index 253821494884..1bf6375ac7f3 100644
--- a/tools/testing/selftests/bpf/config.aarch64
+++ b/tools/testing/selftests/bpf/config.aarch64
@@ -17,7 +17,6 @@ CONFIG_BPF_JIT_ALWAYS_ON=y
 CONFIG_BPF_JIT_DEFAULT_ON=y
 CONFIG_BPF_PRELOAD_UMD=y
 CONFIG_BPF_PRELOAD=y
-CONFIG_BRIDGE=m
 CONFIG_CGROUP_CPUACCT=y
 CONFIG_CGROUP_DEVICE=y
 CONFIG_CGROUP_FREEZER=y
diff --git a/tools/testing/selftests/bpf/prog_tests/vnet_hash.c b/tools/testing/selftests/bpf/prog_tests/vnet_hash.c
new file mode 100644
index 000000000000..4d71d7b5adc6
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/vnet_hash.c
@@ -0,0 +1,385 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+
+#include <net/if.h>
+#include <sched.h>
+
+#include "test_progs.h"
+#include "vnet_hash.skel.h"
+
+#include <linux/if_arp.h>
+#include <linux/if_tun.h>
+#include <linux/sockios.h>
+#include <linux/virtio_net.h>
+
+#define TUN_HWADDR_SOURCE { 0x02, 0x00, 0x00, 0x00, 0x00, 0x00 }
+#define TUN_HWADDR_DEST { 0x02, 0x00, 0x00, 0x00, 0x00, 0x01 }
+
+#define TUN_IPADDR_SOURCE htonl((172 << 24) | (17 << 16) | 0)
+#define TUN_IPADDR_DEST htonl((172 << 24) | (17 << 16) | 1)
+
+struct payload {
+	struct ethhdr ethhdr;
+	struct arphdr arphdr;
+	unsigned char sender_hwaddr[6];
+	uint32_t sender_ipaddr;
+	unsigned char target_hwaddr[6];
+	uint32_t target_ipaddr;
+} __packed;
+
+static bool bpf_setup(struct vnet_hash **skel)
+{
+	*skel = vnet_hash__open();
+	if (!ASSERT_OK_PTR(*skel, __func__))
+		return false;
+
+	if (!ASSERT_OK(vnet_hash__load(*skel), __func__)) {
+		vnet_hash__destroy(*skel);
+		return false;
+	}
+
+	return true;
+}
+
+static void bpf_teardown(struct vnet_hash *skel)
+{
+	vnet_hash__destroy(skel);
+}
+
+static bool local_setup(int *fd)
+{
+	*fd = socket(AF_LOCAL, SOCK_STREAM, 0);
+	return ASSERT_GE(*fd, 0, __func__);
+}
+
+static bool local_set_flags(int fd, const char *name, short flags)
+{
+	struct ifreq ifreq = { .ifr_flags = flags };
+
+	strcpy(ifreq.ifr_name, name);
+
+	return ASSERT_OK(ioctl(fd, SIOCSIFFLAGS, &ifreq), __func__);
+}
+
+static void local_teardown(int fd)
+{
+	ASSERT_OK(close(fd), __func__);
+}
+
+static bool bridge_setup(int local_fd)
+{
+	if (!ASSERT_OK(ioctl(local_fd, SIOCBRADDBR, "xbridge"), __func__))
+		return false;
+
+	return local_set_flags(local_fd, "xbridge", IFF_UP);
+}
+
+static bool bridge_add_if(int local_fd, const char *name)
+{
+	struct ifreq ifreq = {
+		.ifr_name = "xbridge",
+		.ifr_ifindex = if_nametoindex(name)
+	};
+
+	if (!ASSERT_NEQ(ifreq.ifr_ifindex, 0, __func__))
+		return false;
+
+	return ASSERT_OK(ioctl(local_fd, SIOCBRADDIF, &ifreq), __func__);
+}
+
+static void bridge_teardown(int local_fd)
+{
+	if (!local_set_flags(local_fd, "xbridge", 0))
+		return;
+
+	ASSERT_OK(ioctl(local_fd, SIOCBRDELBR, "xbridge"), __func__);
+}
+
+static bool tun_open(int *fd, char *ifname, short flags)
+{
+	struct ifreq ifr;
+
+	*fd = open("/dev/net/tun", O_RDWR);
+	if (!ASSERT_GE(*fd, 0, __func__))
+		return false;
+
+	memset(&ifr, 0, sizeof(ifr));
+	strcpy(ifr.ifr_name, ifname);
+	ifr.ifr_flags = flags | IFF_TAP | IFF_NAPI | IFF_NO_PI |
+			IFF_MULTI_QUEUE;
+
+	if (!ASSERT_OK(ioctl(*fd, TUNSETIFF, (void *) &ifr), __func__)) {
+		ASSERT_OK(close(*fd), __func__);
+		return false;
+	}
+
+	strcpy(ifname, ifr.ifr_name);
+
+	return true;
+}
+
+static bool tun_source_setup(int local_fd, int *fd)
+{
+	char ifname[IFNAMSIZ];
+
+	ifname[0] = 0;
+	if (!tun_open(fd, ifname, 0))
+		return false;
+
+	if (!bridge_add_if(local_fd, ifname)) {
+		ASSERT_OK(close(*fd), __func__);
+		return false;
+	}
+
+	if (!local_set_flags(local_fd, ifname, IFF_UP)) {
+		ASSERT_OK(close(*fd), __func__);
+		return false;
+	}
+
+	return true;
+}
+
+static void tun_source_teardown(int fd)
+{
+	ASSERT_OK(close(fd), __func__);
+}
+
+static bool tun_dest_setup(int local_fd, struct vnet_hash *bpf,
+			   int *fd, char *ifname)
+{
+	struct {
+		struct virtio_net_hdr vnet_hdr;
+		struct payload payload;
+	} __packed packet = {
+		.payload = {
+			.ethhdr = {
+				.h_source = TUN_HWADDR_DEST,
+				.h_dest = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff },
+				.h_proto = htons(ETH_P_ARP)
+			},
+			.arphdr = {
+				.ar_hrd = htons(ARPHRD_ETHER),
+				.ar_pro = htons(ETH_P_IP),
+				.ar_hln = ETH_ALEN,
+				.ar_pln = 4,
+				.ar_op = htons(ARPOP_REQUEST)
+			},
+			.sender_hwaddr = TUN_HWADDR_DEST,
+			.sender_ipaddr = TUN_IPADDR_DEST,
+			.target_ipaddr = TUN_IPADDR_DEST
+		}
+	};
+
+	int bpf_fd = bpf_program__fd(bpf->progs.prog);
+
+	ifname[0] = 0;
+	if (!tun_open(fd, ifname, IFF_VNET_HDR))
+		return false;
+
+	if (!ASSERT_OK(ioctl(*fd, TUNSETSTEERINGEBPF, &bpf_fd), __func__))
+		goto fail;
+
+	if (!bridge_add_if(local_fd, ifname))
+		goto fail;
+
+	if (!local_set_flags(local_fd, ifname, IFF_UP))
+		goto fail;
+
+	if (!ASSERT_EQ(write(*fd, &packet, sizeof(packet)), sizeof(packet), __func__))
+		goto fail;
+
+	return true;
+
+fail:
+	ASSERT_OK(close(*fd), __func__);
+	return false;
+}
+
+static void tun_dest_teardown(int fd)
+{
+	ASSERT_OK(close(fd), __func__);
+}
+
+static bool tun_dest_queue_setup(char *ifname, int *fd)
+{
+	return tun_open(fd, ifname, IFF_VNET_HDR);
+}
+
+static void tun_dest_queue_teardown(int fd)
+{
+	ASSERT_OK(close(fd), __func__);
+}
+
+static void *test_vnet_hash_thread(void *arg)
+{
+	struct payload sent = {
+		.ethhdr = {
+			.h_source = TUN_HWADDR_SOURCE,
+			.h_dest = TUN_HWADDR_DEST,
+			.h_proto = htons(ETH_P_ARP)
+		},
+		.arphdr = {
+			.ar_hrd = htons(ARPHRD_ETHER),
+			.ar_pro = htons(ETH_P_IP),
+			.ar_hln = ETH_ALEN,
+			.ar_pln = 4,
+			.ar_op = htons(ARPOP_REPLY)
+		},
+		.sender_hwaddr = TUN_HWADDR_SOURCE,
+		.sender_ipaddr = TUN_IPADDR_SOURCE,
+		.target_hwaddr = TUN_HWADDR_DEST,
+		.target_ipaddr = TUN_IPADDR_DEST
+	};
+	union {
+		struct virtio_net_hdr_v1_hash virtio_net_hdr;
+		uint8_t bytes[sizeof(struct virtio_net_hdr_v1_hash) + sizeof(struct payload)];
+	} received;
+	struct vnet_hash *bpf;
+	int local_fd;
+	int source_fd;
+	int dest_fds[2];
+	char dest_ifname[IFNAMSIZ];
+	int vnet_hdr_sz;
+
+	if (!ASSERT_OK(unshare(CLONE_NEWNET), "unshare"))
+		return NULL;
+
+	if (!bpf_setup(&bpf))
+		return NULL;
+
+	if (!local_setup(&local_fd))
+		goto fail_local;
+
+	if (!bridge_setup(local_fd))
+		goto fail_bridge;
+
+	if (!tun_source_setup(local_fd, &source_fd))
+		goto fail_tun_source;
+
+	if (!tun_dest_setup(local_fd, bpf, dest_fds, dest_ifname))
+		goto fail_tun_dest;
+
+	if (!ASSERT_EQ(write(source_fd, &sent, sizeof(sent)), sizeof(sent), "write"))
+		goto fail_tests_single_queue;
+
+	if (!ASSERT_EQ(read(dest_fds[0], &received, sizeof(received)),
+		       sizeof(struct virtio_net_hdr) + sizeof(struct payload),
+		       "read"))
+		goto fail_tests_single_queue;
+
+	ASSERT_EQ(received.virtio_net_hdr.hdr.flags, 0,
+		  "virtio_net_hdr.hdr.flags");
+	ASSERT_EQ(received.virtio_net_hdr.hdr.gso_type, VIRTIO_NET_HDR_GSO_NONE,
+		  "virtio_net_hdr.hdr.gso_type");
+	ASSERT_EQ(received.virtio_net_hdr.hdr.hdr_len, 0,
+		  "virtio_net_hdr.hdr.hdr_len");
+	ASSERT_EQ(received.virtio_net_hdr.hdr.gso_size, 0,
+		  "virtio_net_hdr.hdr.gso_size");
+	ASSERT_EQ(received.virtio_net_hdr.hdr.csum_start, 0,
+		  "virtio_net_hdr.hdr.csum_start");
+	ASSERT_EQ(received.virtio_net_hdr.hdr.csum_offset, 0,
+		  "virtio_net_hdr.hdr.csum_offset");
+	ASSERT_EQ(memcmp(received.bytes + sizeof(struct virtio_net_hdr), &sent, sizeof(sent)), 0,
+		  "payload");
+
+	vnet_hdr_sz = sizeof(struct virtio_net_hdr_v1_hash);
+	if (!ASSERT_OK(ioctl(dest_fds[0], TUNSETVNETHDRSZ, &vnet_hdr_sz), "TUNSETVNETHDRSZ"))
+		goto fail_tests_single_queue;
+
+	if (!ASSERT_EQ(write(source_fd, &sent, sizeof(sent)), sizeof(sent),
+		       "hash: write"))
+		goto fail_tests_single_queue;
+
+	if (!ASSERT_EQ(read(dest_fds[0], &received, sizeof(received)),
+		       sizeof(struct virtio_net_hdr_v1_hash) + sizeof(struct payload),
+		       "hash: read"))
+		goto fail_tests_single_queue;
+
+	ASSERT_EQ(received.virtio_net_hdr.hdr.flags, 0,
+		  "hash: virtio_net_hdr.hdr.flags");
+	ASSERT_EQ(received.virtio_net_hdr.hdr.gso_type, VIRTIO_NET_HDR_GSO_NONE,
+		  "hash: virtio_net_hdr.hdr.gso_type");
+	ASSERT_EQ(received.virtio_net_hdr.hdr.hdr_len, 0,
+		  "hash: virtio_net_hdr.hdr.hdr_len");
+	ASSERT_EQ(received.virtio_net_hdr.hdr.gso_size, 0,
+		  "hash: virtio_net_hdr.hdr.gso_size");
+	ASSERT_EQ(received.virtio_net_hdr.hdr.csum_start, 0,
+		  "hash: virtio_net_hdr.hdr.csum_start");
+	ASSERT_EQ(received.virtio_net_hdr.hdr.csum_offset, 0,
+		  "hash: virtio_net_hdr.hdr.csum_offset");
+	ASSERT_EQ(received.virtio_net_hdr.hdr.num_buffers, 0,
+		  "hash: virtio_net_hdr.hdr.num_buffers");
+	ASSERT_EQ(received.virtio_net_hdr.hash_value, htole32(3),
+		  "hash: virtio_net_hdr.hash_value");
+	ASSERT_EQ(received.virtio_net_hdr.hash_report, htole16(2),
+		  "hash: virtio_net_hdr.hash_report");
+	ASSERT_EQ(received.virtio_net_hdr.padding, 0,
+		  "hash: virtio_net_hdr.padding");
+	ASSERT_EQ(memcmp(received.bytes + sizeof(struct virtio_net_hdr_v1_hash), &sent,
+			 sizeof(sent)),
+		  0,
+		  "hash: payload");
+
+	if (!tun_dest_queue_setup(dest_ifname, dest_fds + 1))
+		goto fail_tests_single_queue;
+
+	if (!ASSERT_EQ(write(source_fd, &sent, sizeof(sent)), sizeof(sent),
+		      "hash, multi queue: write"))
+		goto fail_tests_multi_queue;
+
+	if (!ASSERT_EQ(read(dest_fds[1], &received, sizeof(received)),
+		       sizeof(struct virtio_net_hdr_v1_hash) + sizeof(struct payload),
+		       "hash, multi queue: read"))
+		goto fail_tests_multi_queue;
+
+	ASSERT_EQ(received.virtio_net_hdr.hdr.flags, 0,
+		  "hash, multi queue: virtio_net_hdr.hdr.flags");
+	ASSERT_EQ(received.virtio_net_hdr.hdr.gso_type, VIRTIO_NET_HDR_GSO_NONE,
+		  "hash, multi queue: virtio_net_hdr.hdr.gso_type");
+	ASSERT_EQ(received.virtio_net_hdr.hdr.hdr_len, 0,
+		  "hash, multi queue: virtio_net_hdr.hdr.hdr_len");
+	ASSERT_EQ(received.virtio_net_hdr.hdr.gso_size, 0,
+		  "hash, multi queue: virtio_net_hdr.hdr.gso_size");
+	ASSERT_EQ(received.virtio_net_hdr.hdr.csum_start, 0,
+		  "hash, multi queue: virtio_net_hdr.hdr.csum_start");
+	ASSERT_EQ(received.virtio_net_hdr.hdr.csum_offset, 0,
+		  "hash, multi queue: virtio_net_hdr.hdr.csum_offset");
+	ASSERT_EQ(received.virtio_net_hdr.hdr.num_buffers, 0,
+		  "hash, multi queue: virtio_net_hdr.hdr.num_buffers");
+	ASSERT_EQ(received.virtio_net_hdr.hash_value, htole32(3),
+		  "hash, multi queue: virtio_net_hdr.hash_value");
+	ASSERT_EQ(received.virtio_net_hdr.hash_report, htole16(2),
+		  "hash, multi queue: virtio_net_hdr.hash_report");
+	ASSERT_EQ(received.virtio_net_hdr.padding, 0,
+		  "hash, multi queue: virtio_net_hdr.padding");
+	ASSERT_EQ(memcmp(received.bytes + sizeof(struct virtio_net_hdr_v1_hash), &sent,
+			 sizeof(sent)),
+		  0,
+		  "hash, multi queue: payload");
+
+fail_tests_multi_queue:
+	tun_dest_queue_teardown(dest_fds[1]);
+fail_tests_single_queue:
+	tun_dest_teardown(dest_fds[0]);
+fail_tun_dest:
+	tun_source_teardown(source_fd);
+fail_tun_source:
+	bridge_teardown(local_fd);
+fail_bridge:
+	local_teardown(local_fd);
+fail_local:
+	bpf_teardown(bpf);
+
+	return NULL;
+}
+
+void test_vnet_hash(void)
+{
+	pthread_t thread;
+	int err;
+
+	err = pthread_create(&thread, NULL, &test_vnet_hash_thread, NULL);
+	if (ASSERT_OK(err, "pthread_create"))
+		ASSERT_OK(pthread_join(thread, NULL), "pthread_join");
+}
diff --git a/tools/testing/selftests/bpf/progs/vnet_hash.c b/tools/testing/selftests/bpf/progs/vnet_hash.c
new file mode 100644
index 000000000000..0451bab65647
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/vnet_hash.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+SEC("vnet_hash")
+int prog(struct __sk_buff *skb)
+{
+	skb->vnet_hash_value ^= 3;
+	skb->vnet_hash_report ^= 2;
+	skb->vnet_rss_queue ^= 1;
+
+	return BPF_OK;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.42.0


