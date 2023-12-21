Return-Path: <bpf+bounces-18573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBE681C1ED
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 00:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 797C9B230B6
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 23:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF407B3A4;
	Thu, 21 Dec 2023 23:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbKzr+UC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5000E7AE9A;
	Thu, 21 Dec 2023 23:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d3f2985425so8483585ad.3;
        Thu, 21 Dec 2023 15:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703201020; x=1703805820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+x0ahGfIuY9ZBZ2nRz7NtYxAUGL6RGhLBHqlN87RGY=;
        b=bbKzr+UCn2i6CiPqtCHUVDjdIhCYNm3c1FOfvI1FD/TMFT+U4T45yhH9od58peo/1e
         vw/FM/5j6DG4dN768bQGmzwsQpglCnfNPzhtPlx1wp77AYwLrHD5slqSlOHP5cEbtsIM
         PcvnkjmlUjCnDr4C6TXslXPSJU6cI7srt9+NMjl2H+RLolXuV5sDpvOTmKawfo00Bkvq
         fNzqzQcJGw1ZvnwjqJqFaDqjVlO74nrcgf0bcbj9W5qMjPTdagrfrdPjDgbJp0OHHkEZ
         dTYyqv8CZbwi/t0D4wm+NWak3I85B/qZSHcvQe3+Le5+UylAm6jfYxwNU4jYKdqiO+Jk
         H3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703201020; x=1703805820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+x0ahGfIuY9ZBZ2nRz7NtYxAUGL6RGhLBHqlN87RGY=;
        b=oOwGqw/B4JkuoMK/XgN1Syk0KuEtaKff465I+IUx1cdO502cGJNPX5WNS/RkgVIwbn
         CBl+C1DHMhGy6pH8Cw2u09v1H/RRou36pD+11iz39IGnUkqnZ4qQR2szx3b/6Kfg+Dy4
         d7XRMIlzRzWFbILqQuWptMaFnZhDqiM3ZvydkMOVcHE2fWoiQJBhrAEfJ0ALV1QKm4Yu
         o3y9icaG+W5uq502m4JWCyxsz44v31zwvbDk5jEYqZAYYXS+d8Hz26vekoBuEez1QgYF
         /Zf2fro14QL6PfXH3vRRl9VEuInfzf5wyHixk61gW7kTA5RD9+DAmzJInnhUpdiM5gP5
         aYTw==
X-Gm-Message-State: AOJu0YyoTpHZZQvP0B6twGsQWlDcstpu8XZkz+aFjTUxHx42xX/q2ZYR
	FQY6kOegvEPdgyB4oXisGSQZt9wW90U=
X-Google-Smtp-Source: AGHT+IGtSsxUk7FY/DqMi/dyyaORaLvb96RcRn+3K/EWhkI/Z5vZL9XHtohlnt7ke4173HXsgKIwRw==
X-Received: by 2002:a17:902:ec82:b0:1d0:8f0d:b6e4 with SMTP id x2-20020a170902ec8200b001d08f0db6e4mr396354plg.111.1703201019523;
        Thu, 21 Dec 2023 15:23:39 -0800 (PST)
Received: from john.rmac-pubwifi.localzone (fw.royalmoore.com. [72.21.11.210])
        by smtp.gmail.com with ESMTPSA id g15-20020a1709029f8f00b001d3e33a73d5sm2139641plq.279.2023.12.21.15.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 15:23:37 -0800 (PST)
From: John Fastabend <john.fastabend@gmail.com>
To: jakub@cloudflare.com,
	rivendell7@gmail.com,
	kuniyu@amazon.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf 5/5] bpf: sockmap, add tests for proto updates replace socket
Date: Thu, 21 Dec 2023 15:23:27 -0800
Message-Id: <20231221232327.43678-6-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231221232327.43678-1-john.fastabend@gmail.com>
References: <20231221232327.43678-1-john.fastabend@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test that replaces the same socket with itself. This exercises a
corner case where old element and new element have the same posck.
Test protocols: TCP, UDP, stream af_unix and dgram af_unix.

Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 337c92cfb4aa..b5eb287912d1 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -685,6 +685,68 @@ static void test_sockmap_many_maps(void)
 	close(udp);
 }
 
+static void test_sockmap_same_sock(void)
+{
+	struct test_sockmap_pass_prog *skel;
+	int stream[2], dgram, udp, tcp;
+	int i, err, map, zero = 0;
+
+	skel = test_sockmap_pass_prog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	map = bpf_map__fd(skel->maps.sock_map_rx);
+
+	dgram = xsocket(AF_UNIX, SOCK_DGRAM, 0);
+	if (dgram < 0)
+		return;
+
+	tcp = connected_socket_v4();
+	if (!ASSERT_GE(tcp, 0, "connected_socket_v4")) {
+		close(dgram);
+		return;
+	}
+
+	udp = xsocket(AF_INET, SOCK_DGRAM | SOCK_NONBLOCK, 0);
+	if (udp < 0) {
+		close(dgram);
+		close(tcp);
+		return;
+	}
+
+	err = socketpair(AF_UNIX, SOCK_STREAM, 0, stream);
+	ASSERT_OK(err, "socketpair(af_unix, sock_stream)");
+	if (err)
+		goto out;
+
+	for (i = 0; i < 2; i++) {
+		err = bpf_map_update_elem(map, &zero, &stream[0], BPF_ANY);
+		ASSERT_OK(err, "bpf_map_update_elem(stream)");
+	}
+	for (i = 0; i < 2; i++) {
+		err = bpf_map_update_elem(map, &zero, &dgram, BPF_ANY);
+		ASSERT_OK(err, "bpf_map_update_elem(dgram)");
+	}
+	for (i = 0; i < 2; i++) {
+		err = bpf_map_update_elem(map, &zero, &udp, BPF_ANY);
+		ASSERT_OK(err, "bpf_map_update_elem(udp)");
+	}
+	for (i = 0; i < 2; i++) {
+		err = bpf_map_update_elem(map, &zero, &tcp, BPF_ANY);
+		ASSERT_OK(err, "bpf_map_update_elem(tcp)");
+	}
+
+	err = bpf_map_delete_elem(map, &zero);
+	ASSERT_OK(err, "bpf_map_delete_elem(entry)");
+
+	close(stream[0]);
+	close(stream[1]);
+out:
+	close(dgram);
+	close(tcp);
+	close(udp);
+}
+
 void test_sockmap_basic(void)
 {
 	if (test__start_subtest("sockmap create_update_free"))
@@ -733,4 +795,6 @@ void test_sockmap_basic(void)
 		test_sockmap_many_socket();
 	if (test__start_subtest("sockmap one socket to many maps"))
 		test_sockmap_many_maps();
+	if (test__start_subtest("sockmap same socket replace"))
+		test_sockmap_same_sock();
 }
-- 
2.33.0


