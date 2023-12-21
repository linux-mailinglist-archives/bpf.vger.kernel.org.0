Return-Path: <bpf+bounces-18571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EAA81C1E9
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 00:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997871C2489B
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 23:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5F17AE82;
	Thu, 21 Dec 2023 23:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqFQAGTm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5AC7AE72;
	Thu, 21 Dec 2023 23:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d40eec5e12so6966875ad.1;
        Thu, 21 Dec 2023 15:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703201015; x=1703805815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnCWdeXTPDOxyHWiRsUb8ioOTz8NlNC6gPY1DELcE5o=;
        b=ZqFQAGTm0BkcGElF5fWd4htbffs0lV17U+I8GXrxd3KVrP7+VO3kPEAjpEvgMLYcDd
         sotxjC+UXSVoA0LSXFp/PLQpM7FG3kZRAaUy9UZxzH5iSkMuThKIaOPwBGDEK3WeRmAM
         /qzpwCawatd9K29qQIpyQEfyuvSJ/VtGNsilB0GNyfdbYcuKV/VQhNm8TMpmJtqkJyPU
         oyEp6hzQOwP3LbeifrRt0UYc9cuG55imzXhW3Xg5jticI6gA2cOzwwgPKblWxmW6YcGe
         u/Kuy7UK4u111q5WK6qGwA71uZDz5k0HbBiDqrWMRUJn7wDyT8NUxpfhroUPTeUxWVIF
         4KyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703201015; x=1703805815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnCWdeXTPDOxyHWiRsUb8ioOTz8NlNC6gPY1DELcE5o=;
        b=aFzy3vyCSnoG1d6fBMvate7jIEkaFAesxELEcc+X/pHkGCcB0lRVBCIIDJu0cJaTNL
         ybjgRPoS5jXkawr4jkFM/3NuLMoXozRMXZ9lm79iUX5i23A4n6GYavMGzhRfUxaXz+kh
         MKZzojCsC+vY+3jduMHNddsVUh9sjvzOMd+FQwRad+2dV8K+NM6LKhDtwgTElJn8+iD5
         AUktB5cRhiRmY6O6xAp8rcUoErTz6YnK+VOTZ5af9gswT1hJlZTNYAQzdCa5o7zgRJyd
         Q4FKN+zoB5Q6HnYBNL+lfG6rWQwQoV0tdBQ6KM4iyrnQbDvtI8afyUjs8yIKmY6h56Ee
         QbaQ==
X-Gm-Message-State: AOJu0YxNPoaYcy1LatRQqzBN5+AOT3ncF2PYZ4dq4XHmxM5ZQ1tLPNjf
	q/qF4D/nlXnw4ZlZiYJQf0k=
X-Google-Smtp-Source: AGHT+IHNFIbODp+7ob/S/stMEfSWPBelG2bJF/iIm/bzf1wUSi0QDffq8aBxqeJ/UOCh5oKOKFmtoQ==
X-Received: by 2002:a17:902:eb8b:b0:1d3:aa36:386 with SMTP id q11-20020a170902eb8b00b001d3aa360386mr393622plg.70.1703201015417;
        Thu, 21 Dec 2023 15:23:35 -0800 (PST)
Received: from john.rmac-pubwifi.localzone (fw.royalmoore.com. [72.21.11.210])
        by smtp.gmail.com with ESMTPSA id g15-20020a1709029f8f00b001d3e33a73d5sm2139641plq.279.2023.12.21.15.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 15:23:34 -0800 (PST)
From: John Fastabend <john.fastabend@gmail.com>
To: jakub@cloudflare.com,
	rivendell7@gmail.com,
	kuniyu@amazon.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf 3/5] bpf: sockmap, add tests for proto updates many to single map
Date: Thu, 21 Dec 2023 15:23:25 -0800
Message-Id: <20231221232327.43678-4-john.fastabend@gmail.com>
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

Add test with a single map where each socket is inserted multiple
times. Test protocols: TCP, UDP, stream af_unix and dgram af_unix.

Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 66 ++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 7c2241fae19a..22240eeb798b 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -555,6 +555,69 @@ static void test_sockmap_unconnected_unix(void)
 	close(dgram);
 }
 
+static void test_sockmap_many_socket(void)
+{
+	struct test_sockmap_pass_prog *skel;
+	int stream[2], dgram, udp, tcp;
+	int i, err, map, entry = 0;
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
+	for (i = 0; i < 2; i++, entry++) {
+		err = bpf_map_update_elem(map, &entry, &stream[0], BPF_ANY);
+		ASSERT_OK(err, "bpf_map_update_elem(stream)");
+	}
+	for (i = 0; i < 2; i++, entry++) {
+		err = bpf_map_update_elem(map, &entry, &dgram, BPF_ANY);
+		ASSERT_OK(err, "bpf_map_update_elem(dgram)");
+	}
+	for (i = 0; i < 2; i++, entry++) {
+		err = bpf_map_update_elem(map, &entry, &udp, BPF_ANY);
+		ASSERT_OK(err, "bpf_map_update_elem(udp)");
+	}
+	for (i = 0; i < 2; i++, entry++) {
+		err = bpf_map_update_elem(map, &entry, &tcp, BPF_ANY);
+		ASSERT_OK(err, "bpf_map_update_elem(tcp)");
+	}
+	for (entry--; entry >= 0; entry--) {
+		err = bpf_map_delete_elem(map, &entry);
+		ASSERT_OK(err, "bpf_map_delete_elem(entry)");
+	}
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
@@ -597,7 +660,8 @@ void test_sockmap_basic(void)
 		test_sockmap_skb_verdict_fionread(false);
 	if (test__start_subtest("sockmap skb_verdict msg_f_peek"))
 		test_sockmap_skb_verdict_peek();
-
 	if (test__start_subtest("sockmap unconnected af_unix"))
 		test_sockmap_unconnected_unix();
+	if (test__start_subtest("sockmap one socket to many map entries"))
+		test_sockmap_many_socket();
 }
-- 
2.33.0


