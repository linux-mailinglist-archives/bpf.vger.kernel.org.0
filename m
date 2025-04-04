Return-Path: <bpf+bounces-55288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 166A5A7B35A
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 02:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B8123B7991
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 00:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473BF1F4CBE;
	Fri,  4 Apr 2025 00:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5ikD+0K"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA88B1552E3;
	Fri,  4 Apr 2025 00:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725146; cv=none; b=EBnGo7g6YXYh0Q7qiCe6HPGLl++rkN8qAmQ8564GfO477WrvxUb4S4mQcSDF95iVEnlvcJismdp697A7bReUjzJ/HEHQGdG9CKp+BHJLouf0GdGGmBUcfG0QoY1a01WuU2IMPCEb7e7BZ1MQJq3o9z1QFAXO6HAmWmep/isbQ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725146; c=relaxed/simple;
	bh=OEphS++aiw5Zon+jzaEsnLlRZocxSiGBmdEBgLHZP4M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pJAwFIToZUKb0aWApW+lG8ggqyGzRSEu+FZEVoUHkAtLGXQe88rAeUqwxEV0e/dnoZD1JjsiBbS1p02BOYy+hfiWxKGq246y2CEr3huMjfBI0rh5noyOtKaHhbEbjVfy3XIWEl1KUHYQg3B+3KjKGcSiWs9z/0kDkVJGM4i+cw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5ikD+0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F81C4CEE3;
	Fri,  4 Apr 2025 00:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743725146;
	bh=OEphS++aiw5Zon+jzaEsnLlRZocxSiGBmdEBgLHZP4M=;
	h=From:To:Cc:Subject:Date:From;
	b=o5ikD+0KSfr0htuQNl4ZXJtI1lbmzwPhBYXqXCQ6b9iP5NL5m+3c+ICVB8W3tZU6H
	 jCUabzv9DUH1u/dHZxK94AUdLBPAK6RcbwrMfAqRb3HUUyJP925dDbu3aHxpe0mLa/
	 nJxJguQxxEMSdSBNU72pDYNqod6sx8cux2IiPMBLBQXAR1H606vSLHlplq65TM2z/j
	 E0dHO6gu0WNfudQNyr+cPhbdOvKTueqvCR9FghS7TnpatDyiZWCT/7WnjYUN4tEJ34
	 LHyrdKNNZwbdxMb0/quLmSkGiPe2G0HVDk2XpO7MCYJ9Redy7Gvkl1E9QqiAdtRcKb
	 AK13tiTFb79Sg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 01/20] selftests/bpf: Fix stdout race condition in traffic monitor
Date: Thu,  3 Apr 2025 20:05:21 -0400
Message-Id: <20250404000541.2688670-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
Content-Transfer-Encoding: 8bit

From: Amery Hung <ameryhung@gmail.com>

[ Upstream commit b99f27e90268b1a814c13f8bd72ea1db448ea257 ]

Fix a race condition between the main test_progs thread and the traffic
monitoring thread. The traffic monitor thread tries to print a line
using multiple printf and use flockfile() to prevent the line from being
torn apart. Meanwhile, the main thread doing io redirection can reassign
or close stdout when going through tests. A deadlock as shown below can
happen.

       main                      traffic_monitor_thread
       ====                      ======================
                                 show_transport()
                                 -> flockfile(stdout)

stdio_hijack_init()
-> stdout = open_memstream(log_buf, log_cnt);
   ...
   env.subtest_state->stdout_saved = stdout;

                                    ...
                                    funlockfile(stdout)
stdio_restore_cleanup()
-> fclose(env.subtest_state->stdout_saved);

After the traffic monitor thread lock stdout, A new memstream can be
assigned to stdout by the main thread. Therefore, the traffic monitor
thread later will not be able to unlock the original stdout. As the
main thread tries to access the old stdout, it will hang indefinitely
as it is still locked by the traffic monitor thread.

The deadlock can be reproduced by running test_progs repeatedly with
traffic monitor enabled:

for ((i=1;i<=100;i++)); do
  ./test_progs -a flow_dissector_skb* -m '*'
done

Fix this by only calling printf once and remove flockfile()/funlockfile().

Signed-off-by: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Link: https://patch.msgid.link/20250213233217.553258-1-ameryhung@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/network_helpers.c | 33 ++++++++-----------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 27784946b01b8..af0ee70a53f9f 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -771,12 +771,13 @@ static const char *pkt_type_str(u16 pkt_type)
 	return "Unknown";
 }
 
+#define MAX_FLAGS_STRLEN 21
 /* Show the information of the transport layer in the packet */
 static void show_transport(const u_char *packet, u16 len, u32 ifindex,
 			   const char *src_addr, const char *dst_addr,
 			   u16 proto, bool ipv6, u8 pkt_type)
 {
-	char *ifname, _ifname[IF_NAMESIZE];
+	char *ifname, _ifname[IF_NAMESIZE], flags[MAX_FLAGS_STRLEN] = "";
 	const char *transport_str;
 	u16 src_port, dst_port;
 	struct udphdr *udp;
@@ -817,29 +818,21 @@ static void show_transport(const u_char *packet, u16 len, u32 ifindex,
 
 	/* TCP or UDP*/
 
-	flockfile(stdout);
+	if (proto == IPPROTO_TCP)
+		snprintf(flags, MAX_FLAGS_STRLEN, "%s%s%s%s",
+			 tcp->fin ? ", FIN" : "",
+			 tcp->syn ? ", SYN" : "",
+			 tcp->rst ? ", RST" : "",
+			 tcp->ack ? ", ACK" : "");
+
 	if (ipv6)
-		printf("%-7s %-3s IPv6 %s.%d > %s.%d: %s, length %d",
+		printf("%-7s %-3s IPv6 %s.%d > %s.%d: %s, length %d%s\n",
 		       ifname, pkt_type_str(pkt_type), src_addr, src_port,
-		       dst_addr, dst_port, transport_str, len);
+		       dst_addr, dst_port, transport_str, len, flags);
 	else
-		printf("%-7s %-3s IPv4 %s:%d > %s:%d: %s, length %d",
+		printf("%-7s %-3s IPv4 %s:%d > %s:%d: %s, length %d%s\n",
 		       ifname, pkt_type_str(pkt_type), src_addr, src_port,
-		       dst_addr, dst_port, transport_str, len);
-
-	if (proto == IPPROTO_TCP) {
-		if (tcp->fin)
-			printf(", FIN");
-		if (tcp->syn)
-			printf(", SYN");
-		if (tcp->rst)
-			printf(", RST");
-		if (tcp->ack)
-			printf(", ACK");
-	}
-
-	printf("\n");
-	funlockfile(stdout);
+		       dst_addr, dst_port, transport_str, len, flags);
 }
 
 static void show_ipv6_packet(const u_char *packet, u32 ifindex, u8 pkt_type)
-- 
2.39.5


