Return-Path: <bpf+bounces-16057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 612D07FBEB7
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 16:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17956280E6F
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 15:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E7935284;
	Tue, 28 Nov 2023 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQqKj1UW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC91A8;
	Tue, 28 Nov 2023 07:55:21 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6cbb71c3020so4671550b3a.1;
        Tue, 28 Nov 2023 07:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701186920; x=1701791720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubiOfDlZOkPMLJm4KAhcb6vWazjlt037QMNuSdQFg/A=;
        b=VQqKj1UWAmr75LVyPFAInasqpMgIyIloHey8sY98P9Og3safJO4KRtcq32GcNbmeLh
         Waw9UNAkmPvq+ekSjoNudJBRwWEuIUIvXwhDzX8puxzLE54VGXXp+Ad7TS0LPCs3j6gk
         crLBd2YFK38Uqyhli35WJFEy4L2HNrZzGESXItvWiCj2e6UVIdO6XAzpiYjjeZkVGjNq
         dPHbuecVvXf2MaHmtO7CvZQmuqU8XN/A0qviMwR/UV7dVEmShPe/O1zOS3UtLkbwvD6D
         ZF89b+L+2DWH5OCvctB3g5XbrQHns0QSN7vGVI3sXNeNYTdFrS2oL8gexa9HcSfW1lAF
         K/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701186920; x=1701791720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ubiOfDlZOkPMLJm4KAhcb6vWazjlt037QMNuSdQFg/A=;
        b=oWRfK0agBnTVk4joRgxFcWoZIQYMGsA06x6g6Qu8ZEVQL9md7CCt0beYzqvQAkt+Mc
         EdBEGXHuySwh+R5c55mnslygUZhFbG40MBuF5CdvHdxnh3+emFADUn4+QmSq/dP8hNGW
         3B0hVqC4Wrjev7LImyKO3iBF4APv1rqLE5WFvirQv4eFp9LOpwGyyj7zQfiAnXjs/0lI
         hXIx2Ypl1IBwJMdebC7+rb5WlzYIGnv9hBgK0j2SICnqbVfrT8LefgYqgRfVzXvnBoLa
         6/b3m6d4G73MyyrlGvo3GvzgYE7m7d4Zgc4rT6DbbDmGWSslxLUEc0UY7VKMAaae6nAX
         tOQA==
X-Gm-Message-State: AOJu0YzPGBVSt3psa7EFv0n/azL+3ORtFwJXxUBNrES+wl5jIup7eufN
	0yHv+1P7Y3lREENXV8jR3h8=
X-Google-Smtp-Source: AGHT+IGe0ZVIe6mDtJJbdJerITwQl03YWRHaD2jKKld/eG1FIYpvkXRax2CNnF4X/vb5zPLJFmQ03Q==
X-Received: by 2002:a05:6a21:33a7:b0:187:4118:140 with SMTP id yy39-20020a056a2133a700b0018741180140mr24539396pzb.24.1701186920592;
        Tue, 28 Nov 2023 07:55:20 -0800 (PST)
Received: from john.lan ([2605:59c8:148:ba10:1a40:ebd8:363b:757e])
        by smtp.gmail.com with ESMTPSA id w12-20020aa7858c000000b006cd8c9ae7adsm3695378pfn.25.2023.11.28.07.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 07:55:19 -0800 (PST)
From: John Fastabend <john.fastabend@gmail.com>
To: martin.lau@kernel.org,
	jakub@cloudflare.com
Cc: john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf v3 2/2] bpf: sockmap, add af_unix test with both sockets in map
Date: Tue, 28 Nov 2023 07:55:15 -0800
Message-Id: <20231128155515.9302-3-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231128155515.9302-1-john.fastabend@gmail.com>
References: <20231128155515.9302-1-john.fastabend@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds a test where both pairs of a af_unix paired socket are put into
a BPF map. This ensures that when we tear down the af_unix pair we don't
have any issues on sockmap side with ordering and reference counting.

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 .../selftests/bpf/prog_tests/sockmap_listen.c | 51 +++++++++++++++----
 .../selftests/bpf/progs/test_sockmap_listen.c |  7 +++
 2 files changed, 47 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index a934d430c20c..a07d4862eeba 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -1337,7 +1337,8 @@ static void test_redir(struct test_sockmap_listen *skel, struct bpf_map *map,
 }
 
 static void pairs_redir_to_connected(int cli0, int peer0, int cli1, int peer1,
-				     int sock_mapfd, int verd_mapfd, enum redir_mode mode)
+				     int sock_mapfd, int nop_mapfd,
+				     int verd_mapfd, enum redir_mode mode)
 {
 	const char *log_prefix = redir_mode_str(mode);
 	unsigned int pass;
@@ -1351,6 +1352,12 @@ static void pairs_redir_to_connected(int cli0, int peer0, int cli1, int peer1,
 	if (err)
 		return;
 
+	if (nop_madfd >= 0) {
+		err = add_to_sockmap(nop_mapfd, cli0, cli1);
+		if (err)
+			return;
+	}
+
 	n = write(cli1, "a", 1);
 	if (n < 0)
 		FAIL_ERRNO("%s: write", log_prefix);
@@ -1387,7 +1394,7 @@ static void unix_redir_to_connected(int sotype, int sock_mapfd,
 		goto close0;
 	c1 = sfd[0], p1 = sfd[1];
 
-	pairs_redir_to_connected(c0, p0, c1, p1, sock_mapfd, verd_mapfd, mode);
+	pairs_redir_to_connected(c0, p0, c1, p1, sock_mapfd, -1, verd_mapfd, mode);
 
 	xclose(c1);
 	xclose(p1);
@@ -1677,7 +1684,7 @@ static void udp_redir_to_connected(int family, int sock_mapfd, int verd_mapfd,
 	if (err)
 		goto close_cli0;
 
-	pairs_redir_to_connected(c0, p0, c1, p1, sock_mapfd, verd_mapfd, mode);
+	pairs_redir_to_connected(c0, p0, c1, p1, sock_mapfd, -1, verd_mapfd, mode);
 
 	xclose(c1);
 	xclose(p1);
@@ -1735,7 +1742,7 @@ static void inet_unix_redir_to_connected(int family, int type, int sock_mapfd,
 	if (err)
 		goto close;
 
-	pairs_redir_to_connected(c0, p0, c1, p1, sock_mapfd, verd_mapfd, mode);
+	pairs_redir_to_connected(c0, p0, c1, p1, sock_mapfd, -1, verd_mapfd, mode);
 
 	xclose(c1);
 	xclose(p1);
@@ -1770,8 +1777,10 @@ static void inet_unix_skb_redir_to_connected(struct test_sockmap_listen *skel,
 	xbpf_prog_detach2(verdict, sock_map, BPF_SK_SKB_VERDICT);
 }
 
-static void unix_inet_redir_to_connected(int family, int type, int sock_mapfd,
-					int verd_mapfd, enum redir_mode mode)
+static void unix_inet_redir_to_connected(int family, int type,
+					int sock_mapfd, int nop_mapfd,
+					int verd_mapfd,
+					enum redir_mode mode)
 {
 	int c0, c1, p0, p1;
 	int sfd[2];
@@ -1785,7 +1794,8 @@ static void unix_inet_redir_to_connected(int family, int type, int sock_mapfd,
 		goto close_cli0;
 	c1 = sfd[0], p1 = sfd[1];
 
-	pairs_redir_to_connected(c0, p0, c1, p1, sock_mapfd, verd_mapfd, mode);
+	pairs_redir_to_connected(c0, p0, c1, p1,
+				 sock_mapfd, nop_mapfd, verd_mapfd, mode);
 
 	xclose(c1);
 	xclose(p1);
@@ -1799,6 +1809,7 @@ static void unix_inet_skb_redir_to_connected(struct test_sockmap_listen *skel,
 					    struct bpf_map *inner_map, int family)
 {
 	int verdict = bpf_program__fd(skel->progs.prog_skb_verdict);
+	int nop_map = bpf_map__fd(skel->maps.nop_map);
 	int verdict_map = bpf_map__fd(skel->maps.verdict_map);
 	int sock_map = bpf_map__fd(inner_map);
 	int err;
@@ -1808,14 +1819,32 @@ static void unix_inet_skb_redir_to_connected(struct test_sockmap_listen *skel,
 		return;
 
 	skel->bss->test_ingress = false;
-	unix_inet_redir_to_connected(family, SOCK_DGRAM, sock_map, verdict_map,
+	unix_inet_redir_to_connected(family, SOCK_DGRAM,
+				     sock_map, -1, verdict_map,
 				     REDIR_EGRESS);
-	unix_inet_redir_to_connected(family, SOCK_STREAM, sock_map, verdict_map,
+	unix_inet_redir_to_connected(family, SOCK_DGRAM,
+				     sock_map, -1, verdict_map,
+				     REDIR_EGRESS);
+
+	unix_inet_redir_to_connected(family, SOCK_DGRAM,
+				     sock_map, nop_map, verdict_map,
+				     REDIR_EGRESS);
+	unix_inet_redir_to_connected(family, SOCK_STREAM,
+				     sock_map, nop_map, verdict_map,
 				     REDIR_EGRESS);
 	skel->bss->test_ingress = true;
-	unix_inet_redir_to_connected(family, SOCK_DGRAM, sock_map, verdict_map,
+	unix_inet_redir_to_connected(family, SOCK_DGRAM,
+				     sock_map, -1, verdict_map,
+				     REDIR_INGRESS);
+	unix_inet_redir_to_connected(family, SOCK_STREAM,
+				     sock_map, -1, verdict_map,
+				     REDIR_INGRESS);
+
+	unix_inet_redir_to_connected(family, SOCK_DGRAM,
+				     sock_map, nop_map, verdict_map,
 				     REDIR_INGRESS);
-	unix_inet_redir_to_connected(family, SOCK_STREAM, sock_map, verdict_map,
+	unix_inet_redir_to_connected(family, SOCK_STREAM,
+				     sock_map, nop_map, verdict_map,
 				     REDIR_INGRESS);
 
 	xbpf_prog_detach2(verdict, sock_map, BPF_SK_SKB_VERDICT);
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_listen.c b/tools/testing/selftests/bpf/progs/test_sockmap_listen.c
index 464d35bd57c7..b7250eb9c30c 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_listen.c
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_listen.c
@@ -14,6 +14,13 @@ struct {
 	__type(value, __u64);
 } sock_map SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(max_entries, 2);
+	__type(key, __u32);
+	__type(value, __u64);
+} nop_map SEC(".maps");
+
 struct {
 	__uint(type, BPF_MAP_TYPE_SOCKHASH);
 	__uint(max_entries, 2);
-- 
2.33.0


