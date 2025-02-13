Return-Path: <bpf+bounces-51476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7736A35236
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 00:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC79D3AB38D
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 23:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69341C84A6;
	Thu, 13 Feb 2025 23:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGeqn/xA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD592753F0
	for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 23:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739489549; cv=none; b=LttgUq5idPQyPsemvKDnrZIHO1xrWEKPJlo1EV1DjX+B/ai4b4CnPDDvPSR1uKLnBG9QzM16HlGVPde6PpSjC+B2EXCYRF7DtZ/yiclKyEn6Kz4jKESS0gepvhTW6oS5/BdL/HbvSpF9C70q/a76tTZeHRwSKvvPy2v7+pDb6ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739489549; c=relaxed/simple;
	bh=rZ0m5Fo13yppwYJVpOLvL4WAzvEJB/XhogGIw+I07sk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kLnmmUTmHcUXL6X6XigvroYpRyg2QzDaptVx6RhYPrL90ORTOfRpTZGtAcwjaN/ON8pQlJsVIImFFTP7TlbQyJYV6xp5FGPLfVCsrtvKgg9XvhwK0JC/+5ig4C7DsDhdp1PQND3RFdelkUVdzvJc+yZaoyAZn4TFAlraTFP7A84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGeqn/xA; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21f2339dcfdso22483795ad.1
        for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 15:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739489547; x=1740094347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=70YxyTIVJMFQiNdsJi6x+sRSZ3x+j0i9FEYIP2oo0/U=;
        b=nGeqn/xAjGOUAm7dgJ4IGLeJIHrfEY1sVqAJt6/3bYjFUo9M7zxo7XUmTZJaneP4Ni
         rB4rcAv+2E1QA8LCgCt2QpEPSFlQ9VJ6dx+SAxJGbmTagxNtWOIK4xh+pbJGFd1SEeRh
         9Wq0cKwzvQ5FeEjOqr1Vro9QlW6uCum38LrpcSzsNWSDCFkb7vah1cLoIrTxkDcuVWdY
         YpEMbBag0krJxQpSVIxM0Q1qxvDquwiJPX16esUquXbUGkB1fdlYUd+p9DdgX6pTym8l
         bNywvwhvvIb5Gl7f/gZafx2U61wo0+/gWPy9cD2xh3kaKXbBZ/QH2r+qpvyMUSHuIXZx
         iIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739489547; x=1740094347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=70YxyTIVJMFQiNdsJi6x+sRSZ3x+j0i9FEYIP2oo0/U=;
        b=ZWP4DTFo4hHRGp5vda1ahlgnjywGhO0jxSIJhpggTGoj7xzaqZLQVQK68jBFdG9N1c
         2I3AokQHypblAUsTTtEbGCsTgu8hnMf112X1mu6fdmG+37kWAe+hT5kJnrBPu9i/6qFD
         YZKCHbmvjm+22JG9+o+ykDTMxAUos4a902T/oRJ3dKkc8k00yw9BaIn8vPH2vNtbiOkY
         r2d+lIc2CSr2cvZxNmLTrZ9JZno9Delf8dalmUxNdLF7TBkh6+iMrs99Jv0y/Sxsxdfh
         toRMM/SrpgUSu+GYhzKeDr16+QJLeqRFCFyWafMpb3Mm8eQFIOvHfnvv9IoR3towcwZx
         ZruQ==
X-Gm-Message-State: AOJu0YyZ2RdAiHqv+ftNigpYGvgerXIwFh48uPCM4nrhfUvJhTkKIbTj
	woFSpfotUsa4s40vZuKlfreR8noqzBAB24977Wm8NcgTJeRwDxCLeJQZPQ==
X-Gm-Gg: ASbGncsKmK5zhMxxTeMAtyVfHBnU+rZHBNSmoPkmKX3Gpbfb3glCI341T80eopyPhBt
	ivBc2W/zOrEuWnF8ef9JiBJrIkNsQ9J9FckIKt3KuB3SheOnvmp9/uy+oBtwiwBq0Yk9vwqQ6oB
	tKV0FiPQr2bJUtP4rzc/fhMMi41+QSrhtxiNAeuo7vOJSmEuOJ78zQnwx402eBbWZimZTrPuOXm
	XjW8o36sydBgM9z57+snDnT+Kv4GP9qbXuTFE7NiEy1VMRx6PhqlNUdImJBL/qZGUdAlSJuz1TT
	hBfjGbZ6kUoUGe4sYEkLhJ5Xo8sqO1YN0gDmAM9WBE90OKfk8cDZdh4umfivnKB2rw==
X-Google-Smtp-Source: AGHT+IH9/Fo4E1B3N07qrOIyuvlR9NadN6XdBBkt5NaTf6P0ZdF1ejYbykA87ynS5mPlFs6NPz15+g==
X-Received: by 2002:a17:902:c948:b0:216:4676:dfb5 with SMTP id d9443c01a7336-220d374d200mr64972765ad.21.1739489546813;
        Thu, 13 Feb 2025 15:32:26 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5584e4dsm17795675ad.210.2025.02.13.15.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 15:32:26 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1] selftests/bpf: Fix stdout race condition in traffic monitor
Date: Thu, 13 Feb 2025 15:32:17 -0800
Message-ID: <20250213233217.553258-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 tools/testing/selftests/bpf/network_helpers.c | 33 ++++++++-----------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 80844a5fb1fe..95e943270f35 100644
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
2.47.1


