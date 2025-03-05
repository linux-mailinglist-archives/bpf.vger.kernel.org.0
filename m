Return-Path: <bpf+bounces-53385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7F9A509DB
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 19:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 450657A335E
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 18:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7964D2512D9;
	Wed,  5 Mar 2025 18:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ros8ZBDM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C53219ABA3
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 18:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198870; cv=none; b=Gxhi1OPeNINmgbyXuEGKiF/0VMicByyT5VRcPZMUxWd7KOHr0n5J5rlMlrT35sXV7e5DHuQ7p3j1ytKnBHPHI9xevx/W1Y7Lj9QiYwvIWuiqhzANd6JHS1T+yptJZfc7uW4aVZ38pVajRMD+kRAAWS/zmECQBk91D53jRABqV+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198870; c=relaxed/simple;
	bh=RPdasL1MbMrPrt4BIYfwhFqWwkvQGilOkYn2DaefPuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dG4iiA51Yf7emtTmo6QRKPHQqXNdDMbfiJFbs4krPXdQo5oevbEtODGWLqucR7oS00lQ0b2+uApjfvyulPOaef1hJsrqXXoLuyo96reKLyCpTocPaAo9B+nT0+R3IBY0P932e8U82hJjjO4S1mndsoy9H7/3PYV7EShtPoxeWic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ros8ZBDM; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fce3b01efcso10502538a91.3
        for <bpf@vger.kernel.org>; Wed, 05 Mar 2025 10:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741198867; x=1741803667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBeZV5R1UAAg+peVD9OiV0vdIAqTzXf/8YWUV1uCT/w=;
        b=Ros8ZBDMWXhUCeiz+Jabes2ptPMwqcGbSb5w9Xs30bJ1B17AmOiEX3LyRJ9RdIFGgI
         iof7kffNep1GglRQmpFphY2ZPLrvZvwkEQ0Zc4aG2nctAli2N3eJ6SFtAlUFz+y1I1R8
         T3zBlNT8CDZV3xqiQh55rSzGTdihq44RC+6SCAF1xKafqM8k2aVTi6MSwMTYZb6audi9
         K8AS3rRr7w4dPY6A4VWDqcAZdr6gD1Oe+qD1AIWBrQFsqnoweL5wtzVCouLLS7wbRzJA
         bNtoXOcAquMmXU0Irsx4gdXqjnchYQmRrT4hchi68r03VK0NrwsIiVVYVWUhgo7xTLlY
         Doig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741198867; x=1741803667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EBeZV5R1UAAg+peVD9OiV0vdIAqTzXf/8YWUV1uCT/w=;
        b=CLSgaJJfuZHR1Q92CFMyHA8JzYjvVwoDdmebSw8tfBcYQOv+yCjoNx4K71AkkyGDAi
         FiOJqgErAnfPNprwN9NDbOsftdxk2z7GHfDpDTPPPn7ZiPW1B4t7nhNmOmKYdI8W7eN6
         LV0rXw+Df6V9kL+IuMvV3AuCZINmfGY6EuP2cYn3u+DFnuJtjkMDAVj1FVLb+xC14IKl
         FLMdAO8p/7JMvH8ruJLgp0sGE0Ry31PfVTrI5UDNbuyz4LlUW/cfRnhfVG8hcdOpTinq
         GJlW+CPcojd+aEe6kLRxuhRY6J/CG4im9CteoSRS5cs/WhpSkhTgMgEEqAMP9O8WkZMj
         ECvQ==
X-Gm-Message-State: AOJu0Yw+feZkctMbXqbwC1oH2tsbs3p0VkBtg+hJHW8GoE/jW6xZVHsf
	iLtG/qR7mMzvQJMXCUFajLoRZEhkW6+ADI6a5RAKHj9xNqAWFYaSusjrCg==
X-Gm-Gg: ASbGnctpF2ZgRTRQczjUfo8LNbXpxiEdaVrINz4VBri3ZlCr/kFkwUIxB0za38nH2c/
	gx7h3VZYP2fU67esSUuGfFXINkMIeBpIZcIKweiVwzsZXHM6JPkXXVdPBY+vXzvONDZiIUqlHjD
	bUFRio8ftplq6Zs7NTh0ZHsWftpEVfAE+DtmOFcgqj7Udz268Dz7m7TELwZZMXG8z5Aoc3wqy9C
	jKE+VVCpAB3pJNOIvIJxnsPHLeBZysBvVx7v5m5psJvoWuLEUbzpnPsbj33+Kn+gamFxsWSdOvH
	IT3IIGKjyD88kIIgMMlUrjuGnfsBIzEmbJ7278wHfX+VhjxG2hVtKVt9EDqLmcYMWMq1ky/QDhe
	C4QWmPqPMZvxN/WBTtYM=
X-Google-Smtp-Source: AGHT+IHGo570AEWTx0pgqFK3ZuFrltqZSoEBzICmqhhW8IH5ZGdA9Iw591USPU89VU96tL+Br7bBZQ==
X-Received: by 2002:a17:90b:35cf:b0:2ee:d96a:5816 with SMTP id 98e67ed59e1d1-2ff497900camr7055495a91.10.1741198867602;
        Wed, 05 Mar 2025 10:21:07 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e8253acsm1650399a91.49.2025.03.05.10.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 10:21:07 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 2/3] selftests/bpf: Allow assigning traffic monitor print function
Date: Wed,  5 Mar 2025 10:20:56 -0800
Message-ID: <20250305182057.2802606-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305182057.2802606-1-ameryhung@gmail.com>
References: <20250305182057.2802606-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow users to change traffic monitor's print function. If not provided,
traffic monitor will print to stdout by default.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 tools/testing/selftests/bpf/network_helpers.c | 69 ++++++++++++++-----
 tools/testing/selftests/bpf/network_helpers.h |  8 +++
 2 files changed, 58 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 737a952dcf80..11f07c82166b 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -750,6 +750,36 @@ struct tmonitor_ctx {
 	int pcap_fd;
 };
 
+static int __base_pr(const char *format, va_list args)
+{
+	return vfprintf(stdout, format, args);
+}
+
+static tm_print_fn_t __tm_pr = __base_pr;
+
+tm_print_fn_t traffic_monitor_set_print(tm_print_fn_t fn)
+{
+	tm_print_fn_t old_print_fn;
+
+	old_print_fn = __atomic_exchange_n(&__tm_pr, fn, __ATOMIC_RELAXED);
+
+	return old_print_fn;
+}
+
+void tm_print(const char *format, ...)
+{
+	tm_print_fn_t print_fn;
+	va_list args;
+
+	print_fn = __atomic_load_n(&__tm_pr, __ATOMIC_RELAXED);
+	if (!print_fn)
+		return;
+
+	va_start(args, format);
+	__tm_pr(format, args);
+	va_end(args);
+}
+
 /* Is this packet captured with a Ethernet protocol type? */
 static bool is_ethernet(const u_char *packet)
 {
@@ -767,7 +797,7 @@ static bool is_ethernet(const u_char *packet)
 	case 770: /* ARPHRD_FRAD */
 	case 778: /* ARPHDR_IPGRE */
 	case 803: /* ARPHRD_IEEE80211_RADIOTAP */
-		printf("Packet captured: arphdr_type=%d\n", arphdr_type);
+		tm_print("Packet captured: arphdr_type=%d\n", arphdr_type);
 		return false;
 	}
 	return true;
@@ -817,19 +847,19 @@ static void show_transport(const u_char *packet, u16 len, u32 ifindex,
 		dst_port = ntohs(tcp->dest);
 		transport_str = "TCP";
 	} else if (proto == IPPROTO_ICMP) {
-		printf("%-7s %-3s IPv4 %s > %s: ICMP, length %d, type %d, code %d\n",
-		       ifname, pkt_type_str(pkt_type), src_addr, dst_addr, len,
-		       packet[0], packet[1]);
+		tm_print("%-7s %-3s IPv4 %s > %s: ICMP, length %d, type %d, code %d\n",
+			 ifname, pkt_type_str(pkt_type), src_addr, dst_addr, len,
+			 packet[0], packet[1]);
 		return;
 	} else if (proto == IPPROTO_ICMPV6) {
-		printf("%-7s %-3s IPv6 %s > %s: ICMPv6, length %d, type %d, code %d\n",
-		       ifname, pkt_type_str(pkt_type), src_addr, dst_addr, len,
-		       packet[0], packet[1]);
+		tm_print("%-7s %-3s IPv6 %s > %s: ICMPv6, length %d, type %d, code %d\n",
+			 ifname, pkt_type_str(pkt_type), src_addr, dst_addr, len,
+			 packet[0], packet[1]);
 		return;
 	} else {
-		printf("%-7s %-3s %s %s > %s: protocol %d\n",
-		       ifname, pkt_type_str(pkt_type), ipv6 ? "IPv6" : "IPv4",
-		       src_addr, dst_addr, proto);
+		tm_print("%-7s %-3s %s %s > %s: protocol %d\n",
+			 ifname, pkt_type_str(pkt_type), ipv6 ? "IPv6" : "IPv4",
+			 src_addr, dst_addr, proto);
 		return;
 	}
 
@@ -843,13 +873,13 @@ static void show_transport(const u_char *packet, u16 len, u32 ifindex,
 			 tcp->ack ? ", ACK" : "");
 
 	if (ipv6)
-		printf("%-7s %-3s IPv6 %s.%d > %s.%d: %s, length %d%s\n",
-		       ifname, pkt_type_str(pkt_type), src_addr, src_port,
-		       dst_addr, dst_port, transport_str, len, flags);
+		tm_print("%-7s %-3s IPv6 %s.%d > %s.%d: %s, length %d%s\n",
+			 ifname, pkt_type_str(pkt_type), src_addr, src_port,
+			 dst_addr, dst_port, transport_str, len, flags);
 	else
-		printf("%-7s %-3s IPv4 %s:%d > %s:%d: %s, length %d%s\n",
-		       ifname, pkt_type_str(pkt_type), src_addr, src_port,
-		       dst_addr, dst_port, transport_str, len, flags);
+		tm_print("%-7s %-3s IPv4 %s:%d > %s:%d: %s, length %d%s\n",
+			 ifname, pkt_type_str(pkt_type), src_addr, src_port,
+			 dst_addr, dst_port, transport_str, len, flags);
 }
 
 static void show_ipv6_packet(const u_char *packet, u32 ifindex, u8 pkt_type)
@@ -964,8 +994,8 @@ static void *traffic_monitor_thread(void *arg)
 				ifname = _ifname;
 			}
 
-			printf("%-7s %-3s Unknown network protocol type 0x%x\n",
-			       ifname, pkt_type_str(ptype), proto);
+			tm_print("%-7s %-3s Unknown network protocol type 0x%x\n",
+				 ifname, pkt_type_str(ptype), proto);
 		}
 	}
 
@@ -1165,8 +1195,9 @@ void traffic_monitor_stop(struct tmonitor_ctx *ctx)
 	write(ctx->wake_fd, &w, sizeof(w));
 	pthread_join(ctx->thread, NULL);
 
-	printf("Packet file: %s\n", strrchr(ctx->pkt_fname, '/') + 1);
+	tm_print("Packet file: %s\n", strrchr(ctx->pkt_fname, '/') + 1);
 
 	traffic_monitor_release(ctx);
 }
+
 #endif /* TRAFFIC_MONITOR */
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 9f6e05d886c5..2d726f8f6327 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -249,10 +249,13 @@ static inline __sum16 build_udp_v6_csum(const struct ipv6hdr *ip6h,
 
 struct tmonitor_ctx;
 
+typedef int (*tm_print_fn_t)(const char *format, va_list args);
+
 #ifdef TRAFFIC_MONITOR
 struct tmonitor_ctx *traffic_monitor_start(const char *netns, const char *test_name,
 					   const char *subtest_name);
 void traffic_monitor_stop(struct tmonitor_ctx *ctx);
+tm_print_fn_t traffic_monitor_set_print(tm_print_fn_t fn);
 #else
 static inline struct tmonitor_ctx *traffic_monitor_start(const char *netns, const char *test_name,
 							 const char *subtest_name)
@@ -263,6 +266,11 @@ static inline struct tmonitor_ctx *traffic_monitor_start(const char *netns, cons
 static inline void traffic_monitor_stop(struct tmonitor_ctx *ctx)
 {
 }
+
+static inline tm_print_fn_t traffic_monitor_set_print(tm_print_fn_t fn)
+{
+	return NULL;
+}
 #endif
 
 #endif
-- 
2.47.1


