Return-Path: <bpf+bounces-16104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8E67FCC55
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 02:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECE652832A8
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 01:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87F53C16;
	Wed, 29 Nov 2023 01:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkV+AXH/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FDE19A6;
	Tue, 28 Nov 2023 17:26:04 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so4804203a12.1;
        Tue, 28 Nov 2023 17:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701221163; x=1701825963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66Orb0A/FBk2ud9bubDjtOxTZ6JhqUJSm1nBS/v96J4=;
        b=OkV+AXH/k1m1AEex9GBN0X1eFTPdy0/FhnhnAuE0x2HFVXTHJbEgfungYHJS7yfPqq
         jNLSv25ibrLkq7m9xW1ApsoQ5wzM+BFPCwJM5xlz3xs4J3P/sczJQkVjlkLqqZjb9ctA
         CpbvnFw8VCzfKLtKtY5ri80FFDwqXC+ia42h2/7yzcIWLpAWkJJ3c5srl/1OjPZwAFqI
         F6219iDT0VsaCkNsEJ/qjg2STS6ZBB/dX39TK/cjg0iBdgWYEioMwa575ZXp78j9MOF5
         lFS8PCHatsdjjsuIXl1UsjXBahFQJYdRWgxN/qwXGu2VuqfyafyLTIelZLVZkaMHKcd7
         BRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701221163; x=1701825963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=66Orb0A/FBk2ud9bubDjtOxTZ6JhqUJSm1nBS/v96J4=;
        b=n8/ZyM+gBs1Mt4UZ6+UrLllVqj5qSlehXVZGVyR9Wb7glRbKNckChN/FlcpfE5DmiH
         OBXVh9ueL5kub4XEzyj+GT0r30iErU+ExS5CWFAcVhl8B/jHqG/hsGHESIUM2JdQcN8i
         CMHHVjJEha2WXnBqghm5hYfWYAnC/wTgEA/xxUQ2Ymdo5Fn7AaQsv+TsRStrQsZmUsnt
         vInLe/D5saHpHROpPbYeu32oD2vxQp04OEWrAsXXsBwCMJhAjRoj+EyUA6n1+5cXDaLu
         xEH4TGM/G3ZWL7jwtYu3W1fp/1UEcNHrWxy9M23uBOo9LRzjgqT+A0MSpgHcGnT7LDxH
         czOg==
X-Gm-Message-State: AOJu0YyQAaLIglx28Sa6Kw1KZGVCvM2DurP34TairwXv3rNCxIV0xucU
	tIctS0y8alrZZM2TFuap1dkqNm52QSJjzA==
X-Google-Smtp-Source: AGHT+IE4T4hbdizCtpFu02Q+bGu2pCGmdjKMlZowHW7tYSiIvTonYzT2zMaBF+ARfNwCrQf1+QJPUQ==
X-Received: by 2002:a05:6a20:144b:b0:18c:548d:3d0f with SMTP id a11-20020a056a20144b00b0018c548d3d0fmr17277576pzi.5.1701221163647;
        Tue, 28 Nov 2023 17:26:03 -0800 (PST)
Received: from john.lan ([2605:59c8:148:ba10:9a79:36c7:502e:91e9])
        by smtp.gmail.com with ESMTPSA id gb23-20020a17090b061700b00285114454b4sm122757pjb.22.2023.11.28.17.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 17:26:02 -0800 (PST)
From: John Fastabend <john.fastabend@gmail.com>
To: martin.lau@kernel.org,
	jakub@cloudflare.com
Cc: john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf v4 2/2] bpf: sockmap, add af_unix test with both sockets in map
Date: Tue, 28 Nov 2023 17:25:57 -0800
Message-Id: <20231129012557.95371-3-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231129012557.95371-1-john.fastabend@gmail.com>
References: <20231129012557.95371-1-john.fastabend@gmail.com>
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
index a934d430c20c..a92807bfcd13 100644
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
 
+	if (nop_mapfd >= 0) {
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


