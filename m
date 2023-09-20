Return-Path: <bpf+bounces-10502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB9B7A8FDD
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 01:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A83D7281E13
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 23:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803DA41AA9;
	Wed, 20 Sep 2023 23:27:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73F941238;
	Wed, 20 Sep 2023 23:27:16 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BEFC1;
	Wed, 20 Sep 2023 16:27:15 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-690bc3f8326so312050b3a.0;
        Wed, 20 Sep 2023 16:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695252435; x=1695857235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRax94hCwOhKc7hyYJNfFzu7McWGtMtmigQv48BjD80=;
        b=P3T0qKkx8YhTSLz93EYOe8wIdKi8Imz6AwDkU2iOOsAo6+nyFp3pkvu8D5Sms6l8G/
         ns+hFRVef8FPj4XihKOEcXDk3otJ9/R7XlKvuEHjVzgMl+r0FNWf7X21uswgGLtXMAej
         ApXj6MDEWBhf488m5pkUfhRrSB8pdtTG34u2qNX61RUdXbc8ByGqiyaWOe9Zovn3dgvm
         EbjKcehfBaNxbPy565eHorJgpHnUbu8Si7m57rLT/YClv66/NvM2nEtbyWpNybJfeYaI
         Pqi1xl64KgL7IWksShNnDePDcuIkyLhRHklK7azrY9XrtdNqFjocw8spGN5SAACWe2xf
         RASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695252435; x=1695857235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRax94hCwOhKc7hyYJNfFzu7McWGtMtmigQv48BjD80=;
        b=W3UxBVpJBiOWA010wlhAubk83bpFTl8rCLKEPUlInz/5RxERrwilCWPREOBFwwPoGw
         KKcfTw6YrwOat3n8gVlIY/5YDV95lMr70K2zlM4nMvyvTV7EUY0Uqy0wdYIPNNq5B65D
         OGpbj6k+DyD0VDJifShVw/iT69yp7EHGmPZHCOFXgkNwq9wTP7aPZvW7oP0JSoNlKAzV
         uBOEeNIJwINVYL6mxAgZf+MbLAP12KAuCrNrHVvbbJjAE7Fu8Lloi62kQ6VxCAJZTnFP
         x6nfSoPwLQn1nCNC2zaMfGaBznITjkFJX/Y1TWL6+ouMve5JKgF0BP+GorcUfgEUXX+Y
         Eftg==
X-Gm-Message-State: AOJu0YzgrM69zfMeKrYALD1UL6FIKtbPGcHpwNFhymVFe6bKbZ+J8nlH
	eCeGZgwTD5jiJKp3Pf+O01w=
X-Google-Smtp-Source: AGHT+IE2WSglC5/05m2UJQ32jw5QvicrNogov53iyIgJaIh2f8lnp8E1ZEPtoukU4arciS5/A9zKCw==
X-Received: by 2002:a05:6a20:a10b:b0:14d:4ab5:5e34 with SMTP id q11-20020a056a20a10b00b0014d4ab55e34mr4303043pzk.51.1695252434770;
        Wed, 20 Sep 2023 16:27:14 -0700 (PDT)
Received: from john.lan ([98.97.37.198])
        by smtp.gmail.com with ESMTPSA id mz6-20020a17090b378600b0026b12768e46sm115362pjb.42.2023.09.20.16.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 16:27:14 -0700 (PDT)
From: John Fastabend <john.fastabend@gmail.com>
To: daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	jakub@cloudflare.com
Cc: john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf 3/3] bpf: sockmap, add tests for MSG_F_PEEK
Date: Wed, 20 Sep 2023 16:27:06 -0700
Message-Id: <20230920232706.498747-4-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230920232706.498747-1-john.fastabend@gmail.com>
References: <20230920232706.498747-1-john.fastabend@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Test that we can read with MSG_F_PEEK and then still get correct number
of available bytes through FIONREAD. The recv() (without PEEK) then
returns the bytes as expected. The recv() always worked though because
it was just the available byte reporting that was broke before latest
fixes.

Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 064cc5e8d9ad..e8eee2b8901e 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -475,6 +475,56 @@ static void test_sockmap_skb_verdict_fionread(bool pass_prog)
 		test_sockmap_drop_prog__destroy(drop);
 }
 
+
+static void test_sockmap_skb_verdict_peek(void)
+{
+	int err, map, verdict, s, c1, p1, zero = 0, sent, recvd, avail;
+	struct test_sockmap_pass_prog *pass;
+	char snd[256] = "0123456789";
+	char rcv[256] = "0";
+
+	pass = test_sockmap_pass_prog__open_and_load();
+	if (!ASSERT_OK_PTR(pass, "open_and_load"))
+		return;
+	verdict = bpf_program__fd(pass->progs.prog_skb_verdict);
+	map = bpf_map__fd(pass->maps.sock_map_rx);
+
+	err = bpf_prog_attach(verdict, map, BPF_SK_SKB_STREAM_VERDICT, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach"))
+		goto out;
+
+	s = socket_loopback(AF_INET, SOCK_STREAM);
+	if (!ASSERT_GT(s, -1, "socket_loopback(s)"))
+		goto out;
+
+	err = create_pair(s, AF_INET, SOCK_STREAM, &c1, &p1);
+	if (!ASSERT_OK(err, "create_pairs(s)"))
+		goto out;
+
+	err = bpf_map_update_elem(map, &zero, &c1, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "bpf_map_update_elem(c1)"))
+		goto out_close;
+
+	sent = xsend(p1, snd, sizeof(snd), 0);
+	ASSERT_EQ(sent, sizeof(snd), "xsend(p1)");
+	recvd = recv(c1, rcv, sizeof(rcv), MSG_PEEK);
+	ASSERT_EQ(recvd, sizeof(rcv), "recv(c1)");
+	err = ioctl(c1, FIONREAD, &avail);
+	ASSERT_OK(err, "ioctl(FIONREAD) error");
+	ASSERT_EQ(avail, sizeof(snd), "after peek ioctl(FIONREAD)");
+	recvd = recv(c1, rcv, sizeof(rcv), 0);
+	ASSERT_EQ(recvd, sizeof(rcv), "recv(p0)");
+	err = ioctl(c1, FIONREAD, &avail);
+	ASSERT_OK(err, "ioctl(FIONREAD) error");
+	ASSERT_EQ(avail, 0, "after read ioctl(FIONREAD)");
+
+out_close:
+	close(c1);
+	close(p1);
+out:
+	test_sockmap_pass_prog__destroy(pass);
+}
+
 void test_sockmap_basic(void)
 {
 	if (test__start_subtest("sockmap create_update_free"))
@@ -515,4 +565,6 @@ void test_sockmap_basic(void)
 		test_sockmap_skb_verdict_fionread(true);
 	if (test__start_subtest("sockmap skb_verdict fionread on drop"))
 		test_sockmap_skb_verdict_fionread(false);
+	if (test__start_subtest("sockmap skb_verdict msg_f_peek"))
+		test_sockmap_skb_verdict_peek();
 }
-- 
2.33.0


