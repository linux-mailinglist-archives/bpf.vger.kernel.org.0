Return-Path: <bpf+bounces-15701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CE47F5083
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 20:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 316EB280E6A
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 19:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283CE5E0DA;
	Wed, 22 Nov 2023 19:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kt9u0VmN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4987518E;
	Wed, 22 Nov 2023 11:24:59 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6c10f098a27so148879b3a.2;
        Wed, 22 Nov 2023 11:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700681099; x=1701285899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubjkS5+y1rW721gBAWdylENqvUrLaiGAMBOmuqAVODw=;
        b=kt9u0VmN26uO4hS7DXKi4ODG0ZsyWB2kkLmg1WIv++tVJ0EDaou4lg3/c+Bz0OkEnm
         rVpOI/LdLhiXDGzSznWE7C9RBBI6RfUJMltDPuU9lFAH2oadxzN8EZHz2pkcNJo3PCNW
         Q7uJ9oj/k7s2YP5NuHdJreOLBp3/MkFgpTm/u3dpI7x/EseGaxA4GfFHAD7aAsBFWfDW
         mfpVw9kPJjFVz1ZUYh6K7gXOHPA2svmgSU/C8Ur/zJrzVS6qgGfY5saSeBqKbMuaGBR1
         RhwqDvi/K1sOL9kHlJuEvTfVGiLqAheyfhuG8xn59GIfp2YgXPH12todvi8fVHy62FfJ
         ldsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700681099; x=1701285899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ubjkS5+y1rW721gBAWdylENqvUrLaiGAMBOmuqAVODw=;
        b=eTbGQmm4vm2Oy7btf7hcucxyddHZ+xnr5Uyh7Gz/hX9LpcouqS3aH5hSw0kuwZSnJw
         1/gPFzgi0IIBmjc0YyqaT7MomPmVRUsLf3QW3hnaGvozwq2Vm9WvDxWIhYKUfJIEBl7H
         KrYekBcI/K+iMWhLA4ghUEaWvDd/eE2ZDX1awO8QhBG4MQUaSgiDq5wB0PC83P85gOcX
         PFa4JsxDlTvtC/0bjosNd41k6GFVNJVA9OFGTGipcq97Mj1TYVARAsYQsx0iycKiDj/O
         xN0sMKyKIXCgRX6Rs0UKFmEgefPifRfZfUby8q+c5a2D8uZ0hA5e1lg2Dj7Vsre0bJFY
         53YQ==
X-Gm-Message-State: AOJu0Yy0vb12dulOGAhbctHCGCBjxeb5Q9+c6fJn8MfjbJKdoulHF2A0
	BRs6goCBmJYtIiMbKXr3nN0ZaBik2ddX1g==
X-Google-Smtp-Source: AGHT+IFXv5xe0pSr7N8OmmaFqHrpmS3bELXjb9VwKIv/KmGJ6a4jNsRl1qZKl0oN7aCz3jLvxO/fSg==
X-Received: by 2002:a05:6a20:7347:b0:188:444e:2b74 with SMTP id v7-20020a056a20734700b00188444e2b74mr3463890pzc.50.1700681098674;
        Wed, 22 Nov 2023 11:24:58 -0800 (PST)
Received: from john.lan ([98.97.116.126])
        by smtp.gmail.com with ESMTPSA id r7-20020a056a00216700b006c052bb7da5sm89240pff.7.2023.11.22.11.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 11:24:57 -0800 (PST)
From: John Fastabend <john.fastabend@gmail.com>
To: martin.lau@kernel.org,
	jakub@cloudflare.com
Cc: john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf v2 2/2] bpf: sockmap, add af_unix test with both sockets in map
Date: Wed, 22 Nov 2023 11:24:52 -0800
Message-Id: <20231122192452.335312-3-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231122192452.335312-1-john.fastabend@gmail.com>
References: <20231122192452.335312-1-john.fastabend@gmail.com>
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

Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 .../selftests/bpf/prog_tests/sockmap_listen.c | 39 ++++++++++++++++---
 .../selftests/bpf/progs/test_sockmap_listen.c |  7 ++++
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 8df8cbb447f1..90e97907c1c1 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -1824,8 +1824,10 @@ static void inet_unix_skb_redir_to_connected(struct test_sockmap_listen *skel,
 	xbpf_prog_detach2(verdict, sock_map, BPF_SK_SKB_VERDICT);
 }
 
-static void unix_inet_redir_to_connected(int family, int type, int sock_mapfd,
-					int verd_mapfd, enum redir_mode mode)
+static void unix_inet_redir_to_connected(int family, int type,
+					int sock_mapfd, int nop_mapfd,
+					int verd_mapfd,
+					enum redir_mode mode)
 {
 	const char *log_prefix = redir_mode_str(mode);
 	int c0, c1, p0, p1;
@@ -1849,6 +1851,12 @@ static void unix_inet_redir_to_connected(int family, int type, int sock_mapfd,
 	if (err)
 		goto close;
 
+	if (nop_mapfd >= 0) {
+		err = add_to_sockmap(nop_mapfd, c0, c1);
+		if (err)
+			goto close;
+	}
+
 	n = write(c1, "a", 1);
 	if (n < 0)
 		FAIL_ERRNO("%s: write", log_prefix);
@@ -1883,6 +1891,7 @@ static void unix_inet_skb_redir_to_connected(struct test_sockmap_listen *skel,
 					    struct bpf_map *inner_map, int family)
 {
 	int verdict = bpf_program__fd(skel->progs.prog_skb_verdict);
+	int nop_map = bpf_map__fd(skel->maps.nop_map);
 	int verdict_map = bpf_map__fd(skel->maps.verdict_map);
 	int sock_map = bpf_map__fd(inner_map);
 	int err;
@@ -1892,14 +1901,32 @@ static void unix_inet_skb_redir_to_connected(struct test_sockmap_listen *skel,
 		return;
 
 	skel->bss->test_ingress = false;
-	unix_inet_redir_to_connected(family, SOCK_DGRAM, sock_map, verdict_map,
+	unix_inet_redir_to_connected(family, SOCK_DGRAM,
+				     sock_map, -1, verdict_map,
+				     REDIR_EGRESS);
+	unix_inet_redir_to_connected(family, SOCK_DGRAM,
+				     sock_map, -1, verdict_map,
 				     REDIR_EGRESS);
-	unix_inet_redir_to_connected(family, SOCK_STREAM, sock_map, verdict_map,
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


