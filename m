Return-Path: <bpf+bounces-77830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D72FCF380E
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 13:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6431430ACE4A
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 12:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67122337B8C;
	Mon,  5 Jan 2026 12:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="I19lL5yQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C266A3375CF
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 12:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615303; cv=none; b=pwOHxoy/WvsXh6luQVFbnHCWPiU7q8HvXhht6dxDgdzi/+0EsBQh/tm1FryxGB3TUUA5wQwt3kYMsc00/BYzcbHSkRKfCjyMnZpk8FFkVuUFEBGdDi8BMxvCVo27qsK5rhEILC6AP5rw+uqAJiH9IXIKdx0l7ptPgkIdSNBlnH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615303; c=relaxed/simple;
	bh=2yfJWvOlqqUloBLLoW2q2HL2e2rpQjMwjyevyHCtMnA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HiWGISgcxg10hjncetZLYgT4x2u6DYGbinMsa2p74L7Wgzct9Jvz1p4WpSTuXJdKKFxEDU4RCz1aYJfI+0pNpPIM63E6EKcrNZI9Ry+U5RbPlNBJM+90wwgcOQlWV4UGQY18g/EbPc4fQUUho1WEAS9zhxfjBHPu9CduF4hmVZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=I19lL5yQ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7277324054so2298636466b.0
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 04:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767615299; x=1768220099; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XS7vl1A2g95R4uUTc/Kdk0kAxz/ZnaHSG7AuQrHZBxk=;
        b=I19lL5yQFPPPTrS0Rv/H8nRsOm7a7OwueGOmhCazl2JMLdmfIFKiU8C17PlNnBx3qa
         4+1iortz3lIbHh83rwjP6uBPxlsjaEanrF96mefLEDw3/x21qWpc4qS+VKAAKXlikaOO
         2MfOeSmWHtE1I9uhRiC0m24j2oilE9BT5zqnx1Y6oH/dtqom+Dj3y2HhHlboWHk3qL6G
         MpyfruWP1jgg3J8fJiXrSOwf208LGeRO/CDFCnKEJe11jNHrdaVDZqn/Dbb7vV7kddWK
         jVs6Cdl/Ks0DCmPjK+T2jMzcgqUDLwotu0gJd+EgSEaSQYq7jwMzrF1cXn1iYoLdr+AT
         AkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767615299; x=1768220099;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XS7vl1A2g95R4uUTc/Kdk0kAxz/ZnaHSG7AuQrHZBxk=;
        b=xCeCHi4BrxN42UEyTb0ypRkFvmqeA+nI2aphlqYbxzzAAT1N3cVfNVJ8eFMdEBW+R6
         RZAwgPPafuImuK7+VMWjcoL3JhHMgIgyOkfL3pOrSOl5ojesUrZcT6SJTxZ2A6+xM8y4
         obOo+hwfwLEzrL9ZnlB01sVAQOz6SJOU2DUw8Q4PnlFXh2SLzR9oD3FWCNw6e+AHkOF9
         SnY0pZ1KPNxyc/sECnBl/AVKGHyWb7dpmsxLXSaeD+6EzXCRCwOZSN3q0nGVPSiHRZtP
         ARSF0+gN1TgjrOz+cOgVvSR3hEia6s7YZ9BlJX7OUGtI39SQ79n6UXeLPfQ1a75REEdC
         DPiA==
X-Gm-Message-State: AOJu0YwxBT8g5W1auF4o+2wQVXTqKSJVFdrjZZ9s/o+9BXRtQpGLTX4q
	4zKNbTnW/FqnQhgmJ9dws1cc+BXNYmEY/AkQbPv3aBFNDfbzGDcGk1+hFCgEkbaVulo=
X-Gm-Gg: AY/fxX6YIjTwHLK/IAtq39qghDcepBUE38PvnPM6i2texfqUkx6y2uvInmRUejQGXUM
	1H+7doXU2+7vfWIWWkyecuG3ncsM1ljsO6c0eyFRZurmRXgGBYD+OnCr6skffw6D8hHqlfpcSyI
	s4ogdD/zN8knLcMxIkxR6QB38uM1HppZEExlhyf7AWImDiHBR8/NuQ4+hXXXs2dabMkteBlpiW4
	oFwdtbNBIvRLawXwwoEr0kDMfAVFNw0Bri3HgKj0lKQ2eTJlS4RG+O0BE2N53nqvhOjazWjl/gW
	XjA7OU/Q9IR773vZ9dRdb4/aEtY139/6Q8WrthoAvF5TTnZ4Q5aFRdo/E0mQP+qittD9zfFXeAl
	s1omGgYR8ySfjQoyAeFlxDBJXa1zSGHW2Q7J9RNwOHKd4FuMPciYVbTVQEJ4BxaUPQxhmNxcphT
	5tE6jhOzt943Qss2v4WOizl3ihVcr02vmcH4lFWgama0YpwdQELUdnuFxsUq3bW2z7gF2EHA==
X-Google-Smtp-Source: AGHT+IHZMDRL+UUqEcBjsYh/+meX8k2tSH1WtJwNz1VoSvD8xlyueqHas3cXnYIUlmuaSmQmg2vJpQ==
X-Received: by 2002:a17:907:3fa2:b0:b83:b7c5:de2c with SMTP id a640c23a62f3a-b83b7c5df7cmr1495285166b.10.1767615298660;
        Mon, 05 Jan 2026 04:14:58 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037a614acsm5587029066b.3.2026.01.05.04.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 04:14:58 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 05 Jan 2026 13:14:41 +0100
Subject: [PATCH bpf-next v2 16/16] selftests/bpf: Test skb metadata access
 after L2 decapsulation
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-16-a21e679b5afa@cloudflare.com>
References: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
In-Reply-To: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Add tests to verify that XDP/skb metadata remains accessible after L2
decapsulation now that metadata tracking has been decoupled from the MAC
header offset.

Use a 2-netns setup to test each L2 decapsulation path that resets the MAC
header offset: GRE (IPv4/IPv6), VXLAN, GENEVE, L2TPv3, VLAN, QinQ, and
MPLS. SRv6 and NSH are not tested due to setup complexity (SRv6 requires 4
namespaces according to selftests/net/srv6_hl2encap_red_l2vpn_test.sh, NSH
requires Open vSwitch).

For each encapsulation type, test three access scenarios after L2 decap:
- direct skb->data_meta pointer access
- dynptr-based metadata access (bpf_dynptr_from_skb_meta)
- metadata access after move or skb head realloc (bpf_skb_adjust_room)

Change test_xdp_meta.c to identify test packets by payload content instead
of source MAC address, since L2 encapsulation pushes its own MAC header.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/bpf/config                 |   6 +-
 .../bpf/prog_tests/xdp_context_test_run.c          | 292 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  |  48 ++--
 3 files changed, 325 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 558839e3c185..f867b7eff085 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -130,4 +130,8 @@ CONFIG_INFINIBAND=y
 CONFIG_SMC=y
 CONFIG_SMC_HS_CTRL_BPF=y
 CONFIG_DIBS=y
-CONFIG_DIBS_LO=y
\ No newline at end of file
+CONFIG_DIBS_LO=y
+CONFIG_L2TP=y
+CONFIG_L2TP_V3=y
+CONFIG_L2TP_IP=y
+CONFIG_L2TP_ETH=y
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index ee94c281888a..dc7f936216db 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -8,9 +8,14 @@
 #define TX_NAME "veth1"
 #define TX_NETNS "xdp_context_tx"
 #define RX_NETNS "xdp_context_rx"
+#define RX_MAC "02:00:00:00:00:01"
+#define TX_MAC "02:00:00:00:00:02"
 #define TAP_NAME "tap0"
 #define DUMMY_NAME "dum0"
 #define TAP_NETNS "xdp_context_tuntap"
+#define ENCAP_DEV "encap"
+#define DECAP_RX_NETNS "xdp_context_decap_rx"
+#define DECAP_TX_NETNS "xdp_context_decap_tx"
 
 #define TEST_PAYLOAD_LEN 32
 static const __u8 test_payload[TEST_PAYLOAD_LEN] = {
@@ -127,6 +132,7 @@ static int send_test_packet(int ifindex)
 	/* We use the Ethernet header only to identify the test packet */
 	struct ethhdr eth = {
 		.h_source = { 0x12, 0x34, 0xDE, 0xAD, 0xBE, 0xEF },
+		.h_proto = htons(ETH_P_IP),
 	};
 
 	memcpy(packet, &eth, sizeof(eth));
@@ -155,6 +161,34 @@ static int send_test_packet(int ifindex)
 	return -1;
 }
 
+static int send_routed_packet(int af, const char *ip)
+{
+	struct sockaddr_storage addr;
+	socklen_t alen;
+	int r, sock = -1;
+
+	r = make_sockaddr(af, ip, 42, &addr, &alen);
+	if (!ASSERT_OK(r, "make_sockaddr"))
+		goto err;
+
+	sock = socket(af, SOCK_DGRAM, 0);
+	if (!ASSERT_OK_FD(sock, "socket"))
+		goto err;
+
+	r = sendto(sock, test_payload, sizeof(test_payload), 0,
+		   (struct sockaddr *)&addr, alen);
+	if (!ASSERT_EQ(r, sizeof(test_payload), "sendto"))
+		goto err;
+
+	close(sock);
+	return 0;
+
+err:
+	if (sock >= 0)
+		close(sock);
+	return -1;
+}
+
 static int write_test_packet(int tap_fd)
 {
 	__u8 packet[sizeof(struct ethhdr) + TEST_PAYLOAD_LEN];
@@ -510,3 +544,261 @@ void test_xdp_context_tuntap(void)
 
 	test_xdp_meta__destroy(skel);
 }
+
+enum l2_encap_type {
+	GRE4_ENCAP,
+	GRE6_ENCAP,
+	VXLAN_ENCAP,
+	GENEVE_ENCAP,
+	L2TPV3_ENCAP,
+	VLAN_ENCAP,
+	QINQ_ENCAP,
+	MPLS_ENCAP,
+};
+
+static bool l2_encap_uses_ipv6(enum l2_encap_type encap_type)
+{
+	return encap_type == GRE6_ENCAP;
+}
+
+static bool l2_encap_uses_routing(enum l2_encap_type encap_type)
+{
+	return encap_type == MPLS_ENCAP;
+}
+
+static bool setup_l2_encap_dev(enum l2_encap_type encap_type,
+			       const char *encap_dev, const char *lower_dev,
+			       const char *net_prefix, const char *local_addr,
+			       const char *remote_addr)
+{
+	switch (encap_type) {
+	case GRE4_ENCAP:
+		SYS(fail, "ip link add %s type gretap local %s remote %s",
+		    encap_dev, local_addr, remote_addr);
+		return true;
+
+	case GRE6_ENCAP:
+		SYS(fail, "ip link add %s type ip6gretap local %s remote %s",
+		    encap_dev, local_addr, remote_addr);
+		return true;
+
+	case VXLAN_ENCAP:
+		SYS(fail,
+		    "ip link add %s type vxlan id 42 local %s remote %s dstport 4789",
+		    encap_dev, local_addr, remote_addr);
+		return true;
+
+	case GENEVE_ENCAP:
+		SYS(fail,
+		    "ip link add %s type geneve id 42 remote %s",
+		    encap_dev, remote_addr);
+		return true;
+
+	case L2TPV3_ENCAP:
+		SYS(fail,
+		    "ip l2tp add tunnel tunnel_id 42 peer_tunnel_id 42 encap ip local %s remote %s",
+		    local_addr, remote_addr);
+		SYS(fail,
+		    "ip l2tp add session name %s tunnel_id 42 session_id 42 peer_session_id 42",
+		    encap_dev);
+		return true;
+
+	case VLAN_ENCAP:
+		SYS(fail, "ip link set dev %s down", lower_dev);
+		SYS(fail, "ethtool -K %s rx-vlan-hw-parse off", lower_dev);
+		SYS(fail, "ethtool -K %s tx-vlan-hw-insert off", lower_dev);
+		SYS(fail, "ip link set dev %s up", lower_dev);
+		SYS(fail, "ip link add %s link %s type vlan id 42", encap_dev,
+		    lower_dev);
+		return true;
+
+	case QINQ_ENCAP:
+		SYS(fail, "ip link set dev %s down", lower_dev);
+		SYS(fail, "ethtool -K %s rx-vlan-hw-parse off", lower_dev);
+		SYS(fail, "ethtool -K %s tx-vlan-hw-insert off", lower_dev);
+		SYS(fail, "ethtool -K %s rx-vlan-stag-hw-parse off", lower_dev);
+		SYS(fail, "ethtool -K %s tx-vlan-stag-hw-insert off", lower_dev);
+		SYS(fail, "ip link set dev %s up", lower_dev);
+		SYS(fail, "ip link add vlan.100 link %s type vlan proto 802.1ad id 100", lower_dev);
+		SYS(fail, "ip link set dev vlan.100 up");
+		SYS(fail, "ip link add %s link vlan.100 type vlan id 42", encap_dev);
+		return true;
+
+	case MPLS_ENCAP:
+		SYS(fail, "sysctl -wq net.mpls.platform_labels=65535");
+		SYS(fail, "sysctl -wq net.mpls.conf.%s.input=1", lower_dev);
+		SYS(fail, "ip route change %s encap mpls 42 via %s", net_prefix, remote_addr);
+		SYS(fail, "ip -f mpls route add 42 dev lo");
+		SYS(fail, "ip link set dev lo name %s", encap_dev);
+
+		return true;
+	}
+fail:
+	return false;
+}
+
+static void test_l2_decap(enum l2_encap_type encap_type,
+			  struct bpf_program *xdp_prog,
+			  struct bpf_program *tc_prog, bool *test_pass)
+{
+	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_INGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
+	const char *net, *rx_ip, *tx_ip, *addr_opts;
+	int af, plen;
+	struct netns_obj *rx_ns = NULL, *tx_ns = NULL;
+	struct nstoken *nstoken = NULL;
+	int lower_ifindex, upper_ifindex;
+	int ret;
+
+	if (l2_encap_uses_ipv6(encap_type)) {
+		af = AF_INET6;
+		net = "fd00::/64";
+		rx_ip = "fd00::1";
+		tx_ip = "fd00::2";
+		plen = 64;
+		addr_opts = "nodad";
+	} else {
+		af = AF_INET;
+		net = "192.0.2.0/24";
+		rx_ip = "192.0.2.1";
+		tx_ip = "192.0.2.2";
+		plen = 24;
+		addr_opts = "";
+	}
+
+	*test_pass = false;
+
+	rx_ns = netns_new(DECAP_RX_NETNS, false);
+	if (!ASSERT_OK_PTR(rx_ns, "create rx_ns"))
+		return;
+
+	tx_ns = netns_new(DECAP_TX_NETNS, false);
+	if (!ASSERT_OK_PTR(tx_ns, "create tx_ns"))
+		goto close;
+
+	SYS(close, "ip link add " RX_NAME " address " RX_MAC " netns " DECAP_RX_NETNS
+		   " type veth peer name " TX_NAME " address " TX_MAC " netns " DECAP_TX_NETNS);
+
+	nstoken = open_netns(DECAP_RX_NETNS);
+	if (!ASSERT_OK_PTR(nstoken, "setns rx_ns"))
+		goto close;
+
+	SYS(close, "ip addr add %s/%u dev %s %s", rx_ip, plen, RX_NAME, addr_opts);
+	SYS(close, "ip link set dev %s up", RX_NAME);
+
+	if (!setup_l2_encap_dev(encap_type, ENCAP_DEV, RX_NAME, net, rx_ip, tx_ip))
+		goto close;
+	SYS(close, "ip link set dev %s up", ENCAP_DEV);
+
+	lower_ifindex = if_nametoindex(RX_NAME);
+	if (!ASSERT_GE(lower_ifindex, 0, "if_nametoindex lower"))
+		goto close;
+
+	upper_ifindex = if_nametoindex(ENCAP_DEV);
+	if (!ASSERT_GE(upper_ifindex, 0, "if_nametoindex upper"))
+		goto close;
+
+	ret = bpf_xdp_attach(lower_ifindex, bpf_program__fd(xdp_prog), 0, NULL);
+	if (!ASSERT_GE(ret, 0, "bpf_xdp_attach"))
+		goto close;
+
+	tc_hook.ifindex = upper_ifindex;
+	ret = bpf_tc_hook_create(&tc_hook);
+	if (!ASSERT_OK(ret, "bpf_tc_hook_create"))
+		goto close;
+
+	tc_opts.prog_fd = bpf_program__fd(tc_prog);
+	ret = bpf_tc_attach(&tc_hook, &tc_opts);
+	if (!ASSERT_OK(ret, "bpf_tc_attach"))
+		goto close;
+
+	close_netns(nstoken);
+
+	nstoken = open_netns(DECAP_TX_NETNS);
+	if (!ASSERT_OK_PTR(nstoken, "setns tx_ns"))
+		goto close;
+
+	SYS(close, "ip addr add %s/%u dev %s %s", tx_ip, plen, TX_NAME, addr_opts);
+	SYS(close, "ip neigh add %s lladdr %s nud permanent dev %s", rx_ip, RX_MAC, TX_NAME);
+	SYS(close, "ip link set dev %s up", TX_NAME);
+
+	if (!setup_l2_encap_dev(encap_type, ENCAP_DEV, TX_NAME, net, tx_ip, rx_ip))
+		goto close;
+	SYS(close, "ip link set dev %s up", ENCAP_DEV);
+
+	upper_ifindex = if_nametoindex(ENCAP_DEV);
+	if (!ASSERT_GE(upper_ifindex, 0, "if_nametoindex upper"))
+		goto close;
+
+	if (l2_encap_uses_routing(encap_type))
+		ret = send_routed_packet(af, rx_ip);
+	else
+		ret = send_test_packet(upper_ifindex);
+	if (!ASSERT_OK(ret, "send packet"))
+		goto close;
+
+	if (!ASSERT_TRUE(*test_pass, "test_pass"))
+		dump_err_stream(tc_prog);
+
+close:
+	close_netns(nstoken);
+	netns_free(rx_ns);
+	netns_free(tx_ns);
+}
+
+__printf(1, 2) static bool start_subtest(const char *fmt, ...)
+{
+	char *subtest_name;
+	va_list ap;
+	int r;
+
+	va_start(ap, fmt);
+	r = vasprintf(&subtest_name, fmt, ap);
+	va_end(ap);
+	if (!ASSERT_GE(r, 0, "format string"))
+		return false;
+
+	r = test__start_subtest(subtest_name);
+	free(subtest_name);
+	return r;
+}
+
+void test_xdp_context_l2_decap(void)
+{
+	const struct test {
+		enum l2_encap_type encap_type;
+		const char *encap_name;
+	} tests[] = {
+		{ GRE4_ENCAP, "gre4" },
+		{ GRE6_ENCAP, "gre6" },
+		{ VXLAN_ENCAP, "vxlan" },
+		{ GENEVE_ENCAP, "geneve" },
+		{ L2TPV3_ENCAP, "l2tpv3" },
+		{ VLAN_ENCAP, "vlan" },
+		{ QINQ_ENCAP, "qinq" },
+		{ MPLS_ENCAP, "mpls" },
+	};
+	struct test_xdp_meta *skel;
+	const struct test *t;
+
+	skel = test_xdp_meta__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open and load skeleton"))
+		return;
+
+	for (t = tests; t < tests + ARRAY_SIZE(tests); t++) {
+		if (start_subtest("%s_direct_access", t->encap_name))
+			test_l2_decap(t->encap_type, skel->progs.ing_xdp,
+				      skel->progs.ing_cls,
+				      &skel->bss->test_pass);
+		if (start_subtest("%s_dynptr_read", t->encap_name))
+			test_l2_decap(t->encap_type, skel->progs.ing_xdp,
+				      skel->progs.ing_cls_dynptr_read,
+				      &skel->bss->test_pass);
+		if (start_subtest("%s_helper_adjust_room", t->encap_name))
+			test_l2_decap(t->encap_type, skel->progs.ing_xdp,
+				      skel->progs.helper_skb_adjust_room,
+				      &skel->bss->test_pass);
+	}
+
+	test_xdp_meta__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 0a0f371a2dec..69130e250e84 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -280,18 +280,35 @@ int ing_cls_dynptr_offset_oob(struct __sk_buff *ctx)
 	return TC_ACT_SHOT;
 }
 
+/* Test packets carry test metadata pattern as payload. */
+static bool is_test_packet(struct xdp_md *ctx)
+{
+	__u8 meta_have[META_SIZE];
+	__u32 len;
+	int ret;
+
+	len = bpf_xdp_get_buff_len(ctx);
+	if (len < META_SIZE)
+		return false;
+	ret = bpf_xdp_load_bytes(ctx, len - META_SIZE, meta_have, META_SIZE);
+	if (ret)
+		return false;
+	ret = __builtin_memcmp(meta_have, meta_want, META_SIZE);
+	if (ret)
+		return false;
+
+	return true;
+}
+
 /* Reserve and clear space for metadata but don't populate it */
 SEC("xdp")
 int ing_xdp_zalloc_meta(struct xdp_md *ctx)
 {
-	struct ethhdr *eth = ctx_ptr(ctx, data);
 	__u8 *meta;
 	int ret;
 
 	/* Drop any non-test packets */
-	if (eth + 1 > ctx_ptr(ctx, data_end))
-		return XDP_DROP;
-	if (!check_smac(eth))
+	if (!is_test_packet(ctx))
 		return XDP_DROP;
 
 	ret = bpf_xdp_adjust_meta(ctx, -META_SIZE);
@@ -310,33 +327,24 @@ int ing_xdp_zalloc_meta(struct xdp_md *ctx)
 SEC("xdp")
 int ing_xdp(struct xdp_md *ctx)
 {
-	__u8 *data, *data_meta, *data_end, *payload;
-	struct ethhdr *eth;
+	__u8 *data, *data_meta;
 	int ret;
 
+	/* Drop any non-test packets */
+	if (!is_test_packet(ctx))
+		return XDP_DROP;
+
 	ret = bpf_xdp_adjust_meta(ctx, -META_SIZE);
 	if (ret < 0)
 		return XDP_DROP;
 
 	data_meta = ctx_ptr(ctx, data_meta);
-	data_end  = ctx_ptr(ctx, data_end);
 	data      = ctx_ptr(ctx, data);
 
-	eth = (struct ethhdr *)data;
-	payload = data + sizeof(struct ethhdr);
-
-	if (payload + META_SIZE > data_end ||
-	    data_meta + META_SIZE > data)
-		return XDP_DROP;
-
-	/* The Linux networking stack may send other packets on the test
-	 * interface that interfere with the test. Just drop them.
-	 * The test packets can be recognized by their source MAC address.
-	 */
-	if (!check_smac(eth))
+	if (data_meta + META_SIZE > data)
 		return XDP_DROP;
 
-	__builtin_memcpy(data_meta, payload, META_SIZE);
+	__builtin_memcpy(data_meta, meta_want, META_SIZE);
 	return XDP_PASS;
 }
 

-- 
2.43.0


