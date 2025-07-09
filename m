Return-Path: <bpf+bounces-62823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37F9AFEFFE
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 19:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B19216E912
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 17:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261B12367AF;
	Wed,  9 Jul 2025 17:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MimFIXsK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD83B22D9E6;
	Wed,  9 Jul 2025 17:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752082671; cv=none; b=fOvGJXqFuuZlsgrk8HXNm0uotx9dkq0JY3CG3Ap1JItThJQ6wbjYERtFCzlqQ2Lb4dDgWHZVzfmlByuacPrc6N5aWOVf+5cuNy3R5bv8TQHdmIl9wXJ7/ggNznjjPxcFTD8J70XWL9i+j8QaFjsUjiaKT+QV0IOxd7nG2mjCN9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752082671; c=relaxed/simple;
	bh=6IJB0cFsbw1rnDfnTFI3/4jatidakLkeiu015dsx3Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VEfTJ83rnB6Im3q+YvO87/TVq5dV9mdnKYvL+ValKmw1UY1YDRCg8rRsHYwkLZkX7Pccslh6Ot/RVKNJkVrooDRj+JHjbSSWdibXeqR9rd/mRTDrzziD+E7Jp7YdWsGSJpckK0rRhboMWH0oQ4ksdP6GZAIZ+xosIwRCt/M9e4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MimFIXsK; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a528243636so147115f8f.3;
        Wed, 09 Jul 2025 10:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752082668; x=1752687468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xgz3nF3TelMB8mvuSUREfbUAebPUbqtl3fsYp1+DdQ=;
        b=MimFIXsKKtFhbJBq5q6cdkdK6TD7ojM4rZ8susaDVCVUlB6jIRSlhNRxrxailcqb1e
         ew13hPcRuMD3UqzLuyI6YVKelSdBlWQUNQTA22LG0MJ+8DM8Ynh2ggW+oIEWIBkmG3Ao
         J14SQ+0SvFVu+HALq01/3QYgtF/6aSGS3iQD7u73PE5sMaFuckkuM8epfpQyk7SFMLZm
         DKrkeW01HOww3/0/IIQlWxfFUth3BQdguUwr7+kT7QXRaxNO1iJpYG8dohR9zevLTdpD
         8Unxn/Q6Ny/6OALuC2pgeRrkA3znR++yHw7igu3OzAmGW4fYoGvPbACdaq3pgwE9lnmp
         xxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752082668; x=1752687468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1xgz3nF3TelMB8mvuSUREfbUAebPUbqtl3fsYp1+DdQ=;
        b=fLMsRcOKkdvCK4fu9U0sTzRsrv8uQhmF9N76RopJUzZAnH4dO5qWxpQhda+DfYXk2Y
         wvWFzHXvwjVjLT07xIr2NpyGtgj6aVW1omY9FZmKI1ijQgXCm/we3ZZc5mUSYvpWlVML
         R0fmGQybfSmYODwfyTTJpyoftBrEvryUnvRPNmYnfb7Lg1lCulRMAJa7ESxxu6MDwSgd
         Nyfi5tBx5EPvb1NdsFsNgf0bV509xQhuRQ6dMERCf3JxNX51rGKz8H2KiTpxPRXxdBrQ
         qj0LkcUwarQr2B2P/Su5MsVxsnbCyVv5SgU12dj3MVWdqvlXHrKS9HTVh5P6ZtjwTiUW
         v33Q==
X-Forwarded-Encrypted: i=1; AJvYcCVbDYaqKTmOU3dyIH3zU8L7FYGRk/vY2gnClH8rcOa89JNqX1dS4ma3xQRTDkiegxxViXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqaBuUXeH2I2XFUb6f3Vs1+cIM33ULrYpK17ub30tzDwU2Uw03
	ig6MztCgdRVpmwWIGWGeVtVRbPEEXdb1mKplFqMNz1fXPOj2nKH9vqYfnf+wwnE9
X-Gm-Gg: ASbGncuxf6Uv+KnTUkLoVfujrf4nrBdNVqNEqjFzTPKeMoRasS8YRD8NJ9Dy8yEfKbV
	YTxvYDPUWY23xxh4Lr+qAtip3ll3eaw3RgcwSMpbTZs7Je3dwvtt5iMmNzCKW2eKVyaK/TOHFBx
	JHG64/GvBNZ563PJb1SyXRHU5kJXcIbK315jWGqqX2zHBLZs0FJ2LCChWvTuThZ0kSCYzcLZ7R+
	4+2EA/EzJPtsZDq9m0B6sbYBq5AflAHJ4PKVq0g0+lq12E9GzcvrHtR5JbdFdkeiCOlPXZtvj90
	AoUqMru3xw61orwA3Ob3ULlj/bJBSWnHbjXKE36V7Aeob6af5khiQw5xZPGC
X-Google-Smtp-Source: AGHT+IG/IyUnlpvZ+JCzJ9/sbfNlcTreiNT9s1Vq50pfMQXhhFv8JKmMyUR7A/KNvo5bRv8U9E1KcQ==
X-Received: by 2002:a05:6000:2482:b0:3a4:f663:acb9 with SMTP id ffacd0b85a97d-3b5e7880fc8mr837123f8f.9.1752082667541;
        Wed, 09 Jul 2025 10:37:47 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:43::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030ba54sm16493161f8f.8.2025.07.09.10.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 10:37:46 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	horms@kernel.org,
	cratiu@nvidia.com,
	noren@nvidia.com,
	cjubran@nvidia.com,
	mbloch@nvidia.com,
	mohsin.bashr@gmail.com,
	jdamato@fastly.com,
	gal@nvidia.com,
	sdf@fomichev.me,
	bpf@vger.kernel.org
Subject: [PATCH net-next 3/5] selftests: drv-net: Test XDP_TX support
Date: Wed,  9 Jul 2025 10:37:05 -0700
Message-ID: <20250709173707.3177206-4-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250709173707.3177206-1-mohsin.bashr@gmail.com>
References: <20250709173707.3177206-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test to verify the XDP_TX functionality by generating traffic from a
remote node on a specific UDP port and redirecting it back to the sender.

./drivers/net/xdp.py
TAP version 13
1..5
ok 1 xdp.test_xdp_native_pass_sb
ok 2 xdp.test_xdp_native_pass_mb
ok 3 xdp.test_xdp_native_drop_sb
ok 4 xdp.test_xdp_native_drop_mb
ok 5 xdp.test_xdp_native_tx_mb

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 tools/testing/selftests/drivers/net/xdp.py    | 34 ++++++++
 .../selftests/net/lib/xdp_native.bpf.c        | 79 +++++++++++++++++++
 2 files changed, 113 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/xdp.py b/tools/testing/selftests/drivers/net/xdp.py
index ac7eaaecef14..e05b78592989 100755
--- a/tools/testing/selftests/drivers/net/xdp.py
+++ b/tools/testing/selftests/drivers/net/xdp.py
@@ -27,6 +27,7 @@ class XDPAction(Enum):
     """Enum for XDP actions."""
     PASS = 0  # Pass the packet up to the stack
     DROP = 1  # Drop the packet
+    TX = 2    # Route the packet to the remote host
 
 
 class XDPStats(Enum):
@@ -34,6 +35,7 @@ class XDPStats(Enum):
     RX = 0    # Count of valid packets received for testing
     PASS = 1  # Count of packets passed up to the stack
     DROP = 2  # Count of packets dropped
+    TX = 3    # Count of incoming packets routed to the remote host
 
 
 @dataclass
@@ -187,6 +189,8 @@ def _get_stats(xdp_map_id):
             stats_formatted[XDPStats.PASS.value] = val
         elif stats_dump[key]["formatted"]["key"] == XDPStats.DROP.value:
             stats_formatted[XDPStats.DROP.value] = val
+        elif stats_dump[key]["formatted"]["key"] == XDPStats.TX.value:
+            stats_formatted[XDPStats.TX.value] = val
 
     return stats_formatted
 
@@ -285,6 +289,35 @@ def test_xdp_native_drop_mb(cfg):
     _test_drop(cfg, bpf_info, 8000)
 
 
+def test_xdp_native_tx_mb(cfg):
+    """
+    Tests the XDP_TX action for a multi-buff case.
+
+    Args:
+        cfg: Configuration object containing network settings.
+    """
+    cfg.require_cmd("socat", remote=True)
+
+    bpf_info = BPFProgInfo("xdp_prog_frags", "xdp_native.bpf.o", "xdp.frags", 9000)
+    prog_info = _load_xdp_prog(cfg, bpf_info)
+    port = rand_port()
+
+    _set_xdp_map("map_xdp_setup", TestConfig.MODE.value, XDPAction.TX.value)
+    _set_xdp_map("map_xdp_setup", TestConfig.PORT.value, port)
+
+    test_string = ''.join(random.choice(string.ascii_lowercase) for _ in range(8000))
+    rx_udp = f"socat -{cfg.addr_ipver} -T 2 -u UDP-RECV:{port},reuseport STDOUT"
+    tx_udp = f"echo {test_string} | socat -t 2 -u STDIN UDP:{cfg.baddr}:{port}"
+
+    with bkg(rx_udp, host=cfg.remote, exit_wait=True) as rnc:
+        cmd(tx_udp, host=cfg.remote, shell=True)
+
+    stats = _get_stats(prog_info['maps']['map_xdp_stats'])
+
+    ksft_eq(rnc.stdout.strip(), test_string, "UDP packet exchange failed")
+    ksft_eq(stats[XDPStats.TX.value], 1, "TX stats mismatch")
+
+
 def main():
     """
     Main function to execute the XDP tests.
@@ -301,6 +334,7 @@ def main():
                 test_xdp_native_pass_mb,
                 test_xdp_native_drop_sb,
                 test_xdp_native_drop_mb,
+                test_xdp_native_tx_mb,
             ],
             args=(cfg,))
     ksft_exit()
diff --git a/tools/testing/selftests/net/lib/xdp_native.bpf.c b/tools/testing/selftests/net/lib/xdp_native.bpf.c
index b52561be9e9a..1abf22def604 100644
--- a/tools/testing/selftests/net/lib/xdp_native.bpf.c
+++ b/tools/testing/selftests/net/lib/xdp_native.bpf.c
@@ -22,12 +22,14 @@ enum {
 enum {
 	XDP_MODE_PASS = 0,
 	XDP_MODE_DROP = 1,
+	XDP_MODE_TX = 2,
 } xdp_map_modes;
 
 enum {
 	STATS_RX = 0,
 	STATS_PASS = 1,
 	STATS_DROP = 2,
+	STATS_TX = 3,
 } xdp_stats;
 
 struct {
@@ -121,6 +123,81 @@ static int xdp_mode_drop_handler(struct xdp_md *ctx, __u16 port)
 	return XDP_DROP;
 }
 
+static void swap_machdr(void *data)
+{
+	struct ethhdr *eth = data;
+	__u8 tmp_mac[ETH_ALEN];
+
+	__builtin_memcpy(tmp_mac, eth->h_source, ETH_ALEN);
+	__builtin_memcpy(eth->h_source, eth->h_dest, ETH_ALEN);
+	__builtin_memcpy(eth->h_dest, tmp_mac, ETH_ALEN);
+}
+
+static int xdp_mode_tx_handler(struct xdp_md *ctx, __u16 port)
+{
+	void *data_end = (void *)(long)ctx->data_end;
+	void *data = (void *)(long)ctx->data;
+	struct ethhdr *eth = data;
+	struct udphdr *udph = NULL;
+
+	if (data + sizeof(*eth) > data_end)
+		return XDP_PASS;
+
+	if (eth->h_proto == bpf_htons(ETH_P_IP)) {
+		struct iphdr *iph = data + sizeof(*eth);
+		__be32 tmp_ip = iph->saddr;
+
+		if (iph + 1 > (struct iphdr *)data_end ||
+		     iph->protocol != IPPROTO_UDP)
+			return XDP_PASS;
+
+		udph = data + sizeof(*iph) + sizeof(*eth);
+
+		if (udph + 1 > (struct udphdr *)data_end)
+			return XDP_PASS;
+		if (udph->dest != bpf_htons(port))
+			return XDP_PASS;
+
+		record_stats(ctx, STATS_RX);
+		swap_machdr((void *)eth);
+
+		iph->saddr = iph->daddr;
+		iph->daddr = tmp_ip;
+
+		record_stats(ctx, STATS_TX);
+
+		return XDP_TX;
+
+	} else if (eth->h_proto  == bpf_htons(ETH_P_IPV6)) {
+		struct ipv6hdr *ipv6h = data + sizeof(*eth);
+		struct in6_addr tmp_ipv6;
+
+		if (ipv6h + 1 > (struct ipv6hdr *)data_end ||
+			ipv6h->nexthdr != IPPROTO_UDP)
+			return XDP_PASS;
+
+		udph = data + sizeof(*ipv6h) + sizeof(*eth);
+
+		if (udph + 1 > (struct udphdr *)data_end)
+			return XDP_PASS;
+		if (udph->dest != bpf_htons(port))
+			return XDP_PASS;
+
+		record_stats(ctx, STATS_RX);
+		swap_machdr((void *)eth);
+
+		__builtin_memcpy(&tmp_ipv6, &ipv6h->saddr, sizeof(tmp_ipv6));
+		__builtin_memcpy(&ipv6h->saddr, &ipv6h->daddr, sizeof(tmp_ipv6));
+		__builtin_memcpy(&ipv6h->daddr, &tmp_ipv6, sizeof(tmp_ipv6));
+
+		record_stats(ctx, STATS_TX);
+
+		return XDP_TX;
+	}
+
+	return XDP_PASS;
+}
+
 static int xdp_prog_common(struct xdp_md *ctx)
 {
 	__u32 key, *port;
@@ -141,6 +218,8 @@ static int xdp_prog_common(struct xdp_md *ctx)
 		return xdp_mode_pass(ctx, (__u16)(*port));
 	case XDP_MODE_DROP:
 		return xdp_mode_drop_handler(ctx, (__u16)(*port));
+	case XDP_MODE_TX:
+		return xdp_mode_tx_handler(ctx, (__u16)(*port));
 	}
 
 	/* Default action is to simple pass */
-- 
2.47.1


