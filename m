Return-Path: <bpf+bounces-53211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3464A4E97D
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 18:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3DB58C38C6
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 16:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13623285412;
	Tue,  4 Mar 2025 16:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePHQNT+X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180EE20E716
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 16:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106199; cv=none; b=CLyNEzX8yOauK4fd8mCt3rufZbqYzVepd75XT1NvO87Mwgq8Ij1SetFT1NWCrlLzvSOvHtmThziIpFdpK512G8GzswWBAniI5a7O4sXc9Kvhu/QyznLwdOAqAlcE8wng8VpFq9I681Q9siIpHO8QOFniGogbNTG/0zETnmvyq2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106199; c=relaxed/simple;
	bh=RPdasL1MbMrPrt4BIYfwhFqWwkvQGilOkYn2DaefPuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kT5Ac0oUi4jfHDzrm4PXJLlrdTbXl8BQ7J895iG+HY+m8/isHsH26VItPPgDC7I24sHdUYI6SLIBm4r0v3ZO4FtjrPilPBv3Pcob0JK2UzxkNfOBeUYA4hvT4XOK6ylYH/xT2hH1YS5xBkRkTMQ5gaJbaM3cigwCj3QyJvfclm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePHQNT+X; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-223785beedfso72301505ad.1
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 08:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741106197; x=1741710997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBeZV5R1UAAg+peVD9OiV0vdIAqTzXf/8YWUV1uCT/w=;
        b=ePHQNT+XVwIOY3YA81XvAdJXCe9OMJyjlm7momBncmlLZUbD1vYc6pm335zf3LUfr5
         CVgTJC3ZsHg4wTSBS1zwPHeu7W8uwOD0suiaMJ45P8dQlMSUQbxQSgl11xKwpB7oINXr
         L16/QurqvVIhUgKQGf0EgDoVHOsssHVU45Z1KUMKboxxox7jU3YveCOldhhmBfi6qmGw
         3lQNsJRJEIDbstmoDkMCxour5oc1JGdhzBIVc39sOt8rghCTrrc01mIETob3khs4GILi
         P4HndjsClHIQ5BWEUVsNkoKE/KLc8KJr3HeEuRXLuuFnwheTqyOgZXkicOV6yN0MgbCd
         Ze+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741106197; x=1741710997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EBeZV5R1UAAg+peVD9OiV0vdIAqTzXf/8YWUV1uCT/w=;
        b=TUxmMAygYMoz9cdLm8HvubsZPCIctTZuPWH+ZO2BE+FImu/rClURxH9Zk/I8XAuNUd
         QldtwvWCZKx6qvcrANf70+cjnhIQfywei28nTT1tdGcMexs6TaeK8PN+Yk8rrdNfjPVA
         UbIlVd89vtNXKkvDhlaRWJ6JHwkPKXj6OVGaxBmQaDSIfQyQMBpprzNxxwFhrXRWBYw6
         W4XcNpHH9e9v3fQjLN2e/PzCAIcZ0DHI5x1gR54ZQ0A2pTBCNVE42yfTOhAYfDhnpn8c
         ct5yCojnS+v1tQ2ugWKCGafV4ejgY7TOc3npo1Pzx8Z5G5H8dPsvI49JKPLqVesLck5H
         8bDg==
X-Gm-Message-State: AOJu0YwJEUr23HBYpiOmhQ/JS46tIk4ytvnZsPOciZGFqPaE9TnNcwfN
	unfUlGLuVg9TlSP3nVJ1Gp2mlbS7Qq6ORhrhTRM2EOVziCYtTdMuWOIz0Q==
X-Gm-Gg: ASbGncsHJu3cSV5346kvflpKX8sdWrcWCD478SADCIXR35B33Exswp0NCmS/PfTDpK6
	kEJMYZCv5D2Ump3EPSIIsoIvBxMeGx5+lwRawOeZvjEDCtViksWTeqkQKw7g2z9sjFJ2aCfekIY
	WqVxWxOYLZyb1rsvZk97+j+ZRGs51cH1WRi47ysjF0v+vclhEJGVnTH9cZ70usOvZBzYwoWly1X
	PNekC/SI+gEf0X/CytCIRuLF6s7SBCuY1ihxxfB+2EErbPmsD8z/Ex/v5Oc7mM372TsiBKhe+71
	33GMVkA6vHUwkKOfh53usvdAWf8T9LsrPcLJUpZWTNJlfRC9cRJ0ZYDYgJO2FdRrCeWoVwWK3Kj
	JSF1kkfAoQifYf3/4brE=
X-Google-Smtp-Source: AGHT+IGwfOa5ZhVnNacAJOPecoHkWeOyha5xogkk4xyYjBRKxg3JlPYDyyHHFz6Ng8rneyRP6jqu0w==
X-Received: by 2002:a05:6a00:3ccc:b0:736:69aa:112c with SMTP id d2e1a72fcca58-73669aa1598mr7613554b3a.9.1741106197026;
        Tue, 04 Mar 2025 08:36:37 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe2a640sm11522175b3a.16.2025.03.04.08.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 08:36:36 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 2/3] selftests/bpf: Allow assigning traffic monitor print function
Date: Tue,  4 Mar 2025 08:36:25 -0800
Message-ID: <20250304163626.1362031-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250304163626.1362031-1-ameryhung@gmail.com>
References: <20250304163626.1362031-1-ameryhung@gmail.com>
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


