Return-Path: <bpf+bounces-67922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D503BB503EA
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 19:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B62473AD646
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 17:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41551371EB6;
	Tue,  9 Sep 2025 17:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="ZH8XAOdE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD6231690B
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 17:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437245; cv=none; b=fIlUmnW8/pXpTuYx9p+5Aniu9aiHwOCjRI3mbjuuy68ybcf/Ud797zzOmrG1E86urlxGQgnhILcmArsBc00Qh1TgYu5HZaIVw/k6hphYZyEW1h90NecgdY/fSFkQLV+yvIsQM/kpNiAhLuFGJCl61WAkfu2GCJiXGxHrC5adFw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437245; c=relaxed/simple;
	bh=Lbe38wll4IXyCxzVMiY0dfY2WXOxgVlySCsiLx3zr4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TGFjYpqZnXT6Hge4pAU155yPR1JFvB8RWQ1PLrb3BiTj+lQUwiZb/BDzS8QAOMFcR1VmhPe65hr+3beVKyOHQlnCIXqY8eoXBj/RgMX6soIl2xSNI7/biTtVQC/IFxAszK/mfy373dAPsExUYCRA8dB3ndOuYqC6TFmWmUNOH0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=ZH8XAOdE; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77263a06618so623399b3a.3
        for <bpf@vger.kernel.org>; Tue, 09 Sep 2025 10:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1757437243; x=1758042043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJILTcwTj5GLlMxe8k8wUCvHBjY6ncPyFv6CxtbM9mo=;
        b=ZH8XAOdEvvVWII4ufxyz7Hi3Yyl1WUqoS2ydExEr5VNkFXVif/CMd26sevrxfnoxv7
         dOXazu1gYsfW780TvW3gvLYXGYO4vk4m2ml9zJX3eBtQ8LNd8uQqLPMaLy5DWZIRoD95
         fIgmtAWIYXbcnsKZy2Bl74uIx1hFVOE/i96G49rpc23+4SDS30HAUlCj5es3AvVPn/mX
         +hvQ1L9wHoKDcs7xIdOTo4yzoP6RUBGs8qgn7iWew/VtL2LzZhKGYyXYaI1BoU+DNBbV
         LgSdsA4CPWml++VdmM4EbahaCGjff3wsiJqFMU/uPG7RA3AdtOMiXMdk1KdFjcwlWV92
         WPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757437243; x=1758042043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJILTcwTj5GLlMxe8k8wUCvHBjY6ncPyFv6CxtbM9mo=;
        b=cEvS5AgnJNO0FBJkGs6aMLub0FWN+rpjiqxs7mnzB2MqXPzelCzniNZ3019gbUWszG
         kwV4fLew2/BXuJ74z85gVqk091bT+/26ZUcpZISYyI6NGouE8gpPgJtj31ItoX1VN4mv
         G3Y/pdjpk4QY5DlIqHIwH68/KL8aUru5UXojd+36oNOM8/odVR4Ip+2ReNcW0iW9D8WR
         pTlIBK0meUWQWXgucNzq71Xc60Vdxo7rkR4Wp+3UfOTa6gh7LVzXNRTpMncOgfJng5PY
         Qd5Ml5nk4KOQs+815//XoZH2dOeY37/ycM63FkDtEk9OE3FuYgHODIIrlw6WJPe39M1Q
         6nxg==
X-Gm-Message-State: AOJu0Yx7FVdipWUqLrO7CHvf/nk9r3sHi8IP8guVaF6YmvYAcbdgHHMW
	u4OROX82Zv3lnD1i/Z1gT6UIHYObwVe/HPqdOeFMxlXprlBzRLrBYaB4MDyK5GHweUdKdV4oqTj
	EfGDC
X-Gm-Gg: ASbGncuPO9LYM9zeCNx0DtYXEuf4iw2Qwrf3IvDHBr5TWUMJHc5S87I3PCYnEpWn3iR
	VHYmCmj76sse3cp0difyZP4nhujpx8t14oN+Jf90bPKtHDqYnmGEgM2OwCyVUqz/OBTxHjvJ4As
	le6unEybCxhU86Bv6PHiryEQhd65u2KO/HqE9q9iw9O4SAX1I3HDlRpjLLm7aHe+y9lsEt6OJ5p
	SH0QenpsKJZGZhU/wRhPVcw8Cv1gpPi+kv6dIZrGoSsi6/CUNhRM7v+dFiVTYQFkKU6D4gU/+1/
	3OK7bIoN2s0Qb/cuslmLyjrt9HWjKMTtOfm8lrlsYT5YJj7sAY2/iEKiOz3jL1AbyJ6JEvnM59Y
	bFupOjtWwW5wYVksl2h4gqR7S
X-Google-Smtp-Source: AGHT+IGE5JJFfpN2wchcA+CrDTZuQyNgLgrjcdiM3hi/WufD9Wlys/JexGNpiP5WlAQo9pznIPoMKA==
X-Received: by 2002:a05:6a20:6a29:b0:24c:e3da:1a89 with SMTP id adf61e73a8af0-253466eb59dmr9762776637.8.1757437243112;
        Tue, 09 Sep 2025 10:00:43 -0700 (PDT)
Received: from t14.. ([104.133.198.228])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548a6a814esm251733a12.29.2025.09.09.10.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 10:00:42 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Aditi Ghag <aditi.ghag@isovalent.com>
Subject: [RFC PATCH bpf-next 13/14] selftests/bpf: Extend insert and destroy tests for UDP sockets
Date: Tue,  9 Sep 2025 10:00:07 -0700
Message-ID: <20250909170011.239356-14-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909170011.239356-1-jordan@jrife.io>
References: <20250909170011.239356-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exercise BPF_SOCK_OPS_UDP_CONNECTED_CB by extending the socket map
insert and destroy tests.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 110 ++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_update.c |   1 +
 2 files changed, 111 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 00afa377cf7d..7506de15611e 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -440,10 +440,13 @@ static void test_sockmap_insert_sockops_and_destroy(void)
 	__u32 key_prefix = htonl((__u32)port0);
 	int accept_serv[4] = {-1, -1, -1, -1};
 	int tcp_clien[4] = {-1, -1, -1, -1};
+	int udp_clien[4] = {-1, -1, -1, -1};
 	union bpf_iter_link_info linfo = {};
 	int tcp_serv[4] = {-1, -1, -1, -1};
+	int udp_serv[4] = {-1, -1, -1, -1};
 	struct nstoken *nstoken = NULL;
 	int tcp_clien_cookies[4] = {};
+	int udp_clien_cookies[4] = {};
 	struct bpf_link *link = NULL;
 	char buf[64];
 	int len;
@@ -494,6 +497,22 @@ static void test_sockmap_insert_sockops_and_destroy(void)
 	if (!ASSERT_OK_FD(tcp_serv[3], "start_server"))
 		goto cleanup;
 
+	udp_serv[0] = start_server(AF_INET, SOCK_DGRAM, "127.0.0.1", port0, 0);
+	if (!ASSERT_OK_FD(udp_serv[0], "start_server"))
+		goto cleanup;
+
+	udp_serv[1] = start_server(AF_INET6, SOCK_DGRAM, "::1", port0, 0);
+	if (!ASSERT_OK_FD(udp_serv[1], "start_server"))
+		goto cleanup;
+
+	udp_serv[2] = start_server(AF_INET, SOCK_DGRAM, "127.0.0.1", port1, 0);
+	if (!ASSERT_OK_FD(udp_serv[2], "start_server"))
+		goto cleanup;
+
+	udp_serv[3] = start_server(AF_INET6, SOCK_DGRAM, "::1", port1, 0);
+	if (!ASSERT_OK_FD(udp_serv[3], "start_server"))
+		goto cleanup;
+
 	for (i = 0; i < ARRAY_SIZE(tcp_serv); i++) {
 		tcp_clien[i] = connect_to_fd(tcp_serv[i], 0);
 		if (!ASSERT_OK_FD(tcp_clien[i], "connect_to_fd"))
@@ -504,11 +523,21 @@ static void test_sockmap_insert_sockops_and_destroy(void)
 			goto cleanup;
 	}
 
+	for (i = 0; i < ARRAY_SIZE(udp_serv); i++) {
+		udp_clien[i] = connect_to_fd(udp_serv[i], 0);
+		if (!ASSERT_OK_FD(udp_clien[i], "connect_to_fd"))
+			goto cleanup;
+	}
+
 	/* Ensure that sockets are connected. */
 	for (i = 0; i < ARRAY_SIZE(tcp_clien); i++)
 		if (!ASSERT_EQ(send(tcp_clien[i], "a", 1, 0), 1, "send"))
 			goto cleanup;
 
+	for (i = 0; i < ARRAY_SIZE(udp_clien); i++)
+		if (!ASSERT_EQ(send(udp_clien[i], "a", 1, 0), 1, "send"))
+			goto cleanup;
+
 	/* Ensure that client sockets exist in the map and the hash. */
 	if (!ASSERT_EQ(update_skel->bss->count,
 		       ARRAY_SIZE(tcp_clien) + ARRAY_SIZE(udp_clien),
@@ -518,6 +547,9 @@ static void test_sockmap_insert_sockops_and_destroy(void)
 	for (i = 0; i < ARRAY_SIZE(tcp_clien); i++)
 		tcp_clien_cookies[i] = socket_cookie(tcp_clien[i]);
 
+	for (i = 0; i < ARRAY_SIZE(udp_clien); i++)
+		udp_clien_cookies[i] = socket_cookie(udp_clien[i]);
+
 	for (i = 0; i < ARRAY_SIZE(tcp_clien); i++) {
 		if (!ASSERT_TRUE(has_socket(update_skel->maps.sock_map,
 					    tcp_clien_cookies[i],
@@ -532,6 +564,20 @@ static void test_sockmap_insert_sockops_and_destroy(void)
 			goto cleanup;
 	}
 
+	for (i = 0; i < ARRAY_SIZE(udp_clien); i++) {
+		if (!ASSERT_TRUE(has_socket(update_skel->maps.sock_map,
+					    udp_clien_cookies[i],
+					    sizeof(__u32)),
+				 "has_socket"))
+			goto cleanup;
+
+		if (!ASSERT_TRUE(has_socket(update_skel->maps.sock_hash,
+					    udp_clien_cookies[i],
+					    sizeof(struct sock_hash_key)),
+				 "has_socket"))
+			goto cleanup;
+	}
+
 	/* Destroy sockets connected to port0. */
 	linfo.map.map_fd = bpf_map__fd(update_skel->maps.sock_hash);
 	linfo.map.sock_hash.key_prefix = (__u64)(void *)&key_prefix;
@@ -568,9 +614,23 @@ static void test_sockmap_insert_sockops_and_destroy(void)
 	if (!ASSERT_EQ(send(tcp_clien[3], "a", 1, 0), 1, "send"))
 		goto cleanup;
 
+	if (!ASSERT_LT(send(udp_clien[0], "a", 1, 0), 0, "send"))
+		goto cleanup;
+
+	if (!ASSERT_LT(send(udp_clien[1], "a", 1, 0), 0, "send"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(send(udp_clien[2], "a", 1, 0), 1, "send"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(send(udp_clien[3], "a", 1, 0), 1, "send"))
+		goto cleanup;
+
 	/* Close and ensure that sockets are removed from maps. */
 	close(tcp_clien[0]);
 	close(tcp_clien[1]);
+	close(udp_clien[0]);
+	close(udp_clien[1]);
 
 	/* Ensure that the sockets connected to port0 were removed from the
 	 * maps.
@@ -622,10 +682,60 @@ static void test_sockmap_insert_sockops_and_destroy(void)
 				    sizeof(struct sock_hash_key)),
 			 "has_socket"))
 		goto cleanup;
+
+	if (!ASSERT_FALSE(has_socket(update_skel->maps.sock_map,
+				     udp_clien_cookies[0],
+				     sizeof(__u32)),
+			 "has_socket"))
+		goto cleanup;
+
+	if (!ASSERT_FALSE(has_socket(update_skel->maps.sock_map,
+				     udp_clien_cookies[1],
+				     sizeof(__u32)),
+			 "has_socket"))
+		goto cleanup;
+
+	if (!ASSERT_TRUE(has_socket(update_skel->maps.sock_map,
+				    udp_clien_cookies[2],
+				    sizeof(__u32)),
+			 "has_socket"))
+		goto cleanup;
+
+	if (!ASSERT_TRUE(has_socket(update_skel->maps.sock_map,
+				    udp_clien_cookies[3],
+				    sizeof(__u32)),
+			 "has_socket"))
+		goto cleanup;
+
+	if (!ASSERT_FALSE(has_socket(update_skel->maps.sock_hash,
+				     udp_clien_cookies[0],
+				     sizeof(struct sock_hash_key)),
+			 "has_socket"))
+		goto cleanup;
+
+	if (!ASSERT_FALSE(has_socket(update_skel->maps.sock_hash,
+				     udp_clien_cookies[1],
+				     sizeof(struct sock_hash_key)),
+			 "has_socket"))
+		goto cleanup;
+
+	if (!ASSERT_TRUE(has_socket(update_skel->maps.sock_hash,
+				    udp_clien_cookies[2],
+				    sizeof(struct sock_hash_key)),
+			 "has_socket"))
+		goto cleanup;
+
+	if (!ASSERT_TRUE(has_socket(update_skel->maps.sock_hash,
+				    udp_clien_cookies[3],
+				    sizeof(struct sock_hash_key)),
+			 "has_socket"))
+		goto cleanup;
 cleanup:
 	close_fds(accept_serv, ARRAY_SIZE(accept_serv));
 	close_fds(tcp_clien, ARRAY_SIZE(tcp_clien));
+	close_fds(udp_clien, ARRAY_SIZE(udp_clien));
 	close_fds(tcp_serv, ARRAY_SIZE(tcp_serv));
+	close_fds(udp_serv, ARRAY_SIZE(udp_serv));
 	if (prog_fd >= 0)
 		bpf_prog_detach(cg_fd, BPF_CGROUP_SOCK_OPS);
 	if (cg_fd >= 0)
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_update.c b/tools/testing/selftests/bpf/progs/test_sockmap_update.c
index eb84753c6a1a..0d826004d56d 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_update.c
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_update.c
@@ -77,6 +77,7 @@ int insert_sock(struct bpf_sock_ops *skops)
 
 	switch (skops->op) {
 	case BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:
+	case BPF_SOCK_OPS_UDP_CONNECTED_CB:
 		bpf_sock_hash_update(skops, &sock_hash, &key, BPF_NOEXIST);
 		bpf_sock_map_update(skops, &sock_map, &count, BPF_NOEXIST);
 		count++;
-- 
2.43.0


