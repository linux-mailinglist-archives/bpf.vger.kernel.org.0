Return-Path: <bpf+bounces-18572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AD581C1EB
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 00:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 649561F2644C
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 23:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33727997F;
	Thu, 21 Dec 2023 23:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhiHVE7c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A51A7997C;
	Thu, 21 Dec 2023 23:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d3eae5c1d7so9513815ad.2;
        Thu, 21 Dec 2023 15:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703201017; x=1703805817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmCEPynfpBGFyS6GGX7437i0lA+GuTcbygWqF7dFGkQ=;
        b=ZhiHVE7c0x+bsyf3NSE04xq0pozD8BwAkeoXBNd+t6/XKFPnF7WS8eXYUMsAELNn22
         hG4ndWBpX7TecWDEDx5Skx6AsbX3qW3lHH15QY3KiHBnAUVRLHneRT6cAwIP2NQfDM5S
         SqLVQ36mm4TYsTfiTMSvWhbLcwyiEbrgEPx0im3W1qR4dmaqTWES5n6nLUQaSxrKwwLr
         4259nGcIEKB+8uFgnCzGqXru/dfC1j/Y0CxTp6AVa7QY7uGE+PMKIXcOUaMRX5Kz5g6P
         k5GPqTBGaw4HXaSSfhmQK0uC5Q1yZTk7Lz+DGaMkHwLSwKRRXPBCLMNkYeuX7lTf10yr
         6KoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703201017; x=1703805817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wmCEPynfpBGFyS6GGX7437i0lA+GuTcbygWqF7dFGkQ=;
        b=arMz1YtOBsK9HWKV4CP2jWOuSqN8Zo8Hzj0XOXXeX8MgoCx9HcGC5nnilEv4FUE56e
         Cq4/FOUAPmy9Zb/kvvnrViMcVykpiWcqFT5BT/jO+SovLlfYCgKN2eK3EWVF0ZyZ6atQ
         DNf2lyDIOdHEaHIlLDLFGFTnDZiZJot8l5KgQBm4MfMculY0BMEw47CIS9K0PIMccElX
         N5QQpDiFQCoVtgZsAST/j5pK0nk6etRzOHyVI3cIDlKjgfJWXYIMbgURuUuMqc6RUIoU
         ZcBgFBh0ooecaHQpeIJ7WNHK9XtOjUy12bbIDAcAd8Z2s6BNCAriI2nqobRikqoJe3lv
         Dugw==
X-Gm-Message-State: AOJu0YzsmK3hQNwx5tGTi3p554BVSLI2d6dd4xL+5kWt6NzoL6P/7KX6
	yHevSFQdVjSHXJXZUYRf8gljOIZZZLE=
X-Google-Smtp-Source: AGHT+IF55bEhutOJVNWIwUXoYi8nRd2yxsnP648y+tnqSf0MsiK99PedaKGXW8sWh8AVjKUHeToCUg==
X-Received: by 2002:a17:902:b94c:b0:1d0:711b:c926 with SMTP id h12-20020a170902b94c00b001d0711bc926mr347252pls.110.1703201017421;
        Thu, 21 Dec 2023 15:23:37 -0800 (PST)
Received: from john.rmac-pubwifi.localzone (fw.royalmoore.com. [72.21.11.210])
        by smtp.gmail.com with ESMTPSA id g15-20020a1709029f8f00b001d3e33a73d5sm2139641plq.279.2023.12.21.15.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 15:23:35 -0800 (PST)
From: John Fastabend <john.fastabend@gmail.com>
To: jakub@cloudflare.com,
	rivendell7@gmail.com,
	kuniyu@amazon.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf 4/5] bpf: sockmap, add tests for proto updates single socket to many map
Date: Thu, 21 Dec 2023 15:23:26 -0800
Message-Id: <20231221232327.43678-5-john.fastabend@gmail.com>
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

Add test with multiple maps where each socket is inserted in multiple
maps. Test protocols: TCP, UDP, stream af_unix and dgram af_unix.

Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 22240eeb798b..337c92cfb4aa 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -618,6 +618,73 @@ static void test_sockmap_many_socket(void)
 	close(udp);
 }
 
+static void test_sockmap_many_maps(void)
+{
+	struct test_sockmap_pass_prog *skel;
+	int stream[2], dgram, udp, tcp;
+	int i, err, map[2], entry = 0;
+
+	skel = test_sockmap_pass_prog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	map[0] = bpf_map__fd(skel->maps.sock_map_rx);
+	map[1] = bpf_map__fd(skel->maps.sock_map_tx);
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
+		err = bpf_map_update_elem(map[i], &entry, &stream[0], BPF_ANY);
+		ASSERT_OK(err, "bpf_map_update_elem(stream)");
+	}
+	for (i = 0; i < 2; i++, entry++) {
+		err = bpf_map_update_elem(map[i], &entry, &dgram, BPF_ANY);
+		ASSERT_OK(err, "bpf_map_update_elem(dgram)");
+	}
+	for (i = 0; i < 2; i++, entry++) {
+		err = bpf_map_update_elem(map[i], &entry, &udp, BPF_ANY);
+		ASSERT_OK(err, "bpf_map_update_elem(udp)");
+	}
+	for (i = 0; i < 2; i++, entry++) {
+		err = bpf_map_update_elem(map[i], &entry, &tcp, BPF_ANY);
+		ASSERT_OK(err, "bpf_map_update_elem(tcp)");
+	}
+	for (entry--; entry >= 0; entry--) {
+		err = bpf_map_delete_elem(map[1], &entry);
+		entry--;
+		ASSERT_OK(err, "bpf_map_delete_elem(entry)");
+		err = bpf_map_delete_elem(map[0], &entry);
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
@@ -664,4 +731,6 @@ void test_sockmap_basic(void)
 		test_sockmap_unconnected_unix();
 	if (test__start_subtest("sockmap one socket to many map entries"))
 		test_sockmap_many_socket();
+	if (test__start_subtest("sockmap one socket to many maps"))
+		test_sockmap_many_maps();
 }
-- 
2.33.0


