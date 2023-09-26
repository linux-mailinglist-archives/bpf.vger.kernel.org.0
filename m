Return-Path: <bpf+bounces-10841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B097AE453
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 05:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id CD9EE281DB8
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 03:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1BF1865;
	Tue, 26 Sep 2023 03:53:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D60A7F;
	Tue, 26 Sep 2023 03:53:10 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CA4EC;
	Mon, 25 Sep 2023 20:53:09 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68bed2c786eso6056906b3a.0;
        Mon, 25 Sep 2023 20:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695700388; x=1696305188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRax94hCwOhKc7hyYJNfFzu7McWGtMtmigQv48BjD80=;
        b=WIox8li/GrKXMDVzILOBjJ4+DjrlOccIOVDjI9bFcNZ+UQLEIAhqxqwec0Y1H/CkpM
         grF7SlHTLDPFQE/3YzL6FQaLunUR+lOc5tIvIwnhTLDvXAigk362IINAQl7R8DEeng8e
         M+KnRI72lchHu8UtSi4NRvcoBQIx8eQ53eGn7Z/Xyd9xkCT4+W+6gi8H7KIYxH6pmP5I
         cKZTVryjssO0yeBs85MlQnNdKU6eowbL82NvdOJrGhrqjLZXWg/cuO1cT1EysNArCID9
         llqPvkQCiqauKRmx6LvNxWq9Zfwee60/6UwRiedMVpub9La2nXVEpYPxcpFTtOF+vLHw
         3P9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695700388; x=1696305188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRax94hCwOhKc7hyYJNfFzu7McWGtMtmigQv48BjD80=;
        b=BRsZK/RkVGxpEEcAQWin6+VjDNwP8hoSOkPtWPqiVS7oNOK81n+7j1Ctat9GyoBgzh
         Ir2HyI9Pm37NThT5w9ACJjjnenZqYhAqSwEZKnuMeuPm4zXDuxIZogJ9nt0w/xYl9nbY
         ULOPwIU342x/kvj073fIT/ErnVnWnow8RPtcF4DDhxxDDSJg3KJs+gG6h1YfC2OhKo8Y
         4Ecl/WpTUyZV/9vBH+sKWi8yGrec8SYOkjzsm14qnJusYYdSB/qLU/CYcg0Ui1ZwCvyi
         bdYj8m6Kf9kJaDkn/Vdy6vHzYl7O3CmAlKPQDkBP3Si9as/obbpcTciX2vytkY6hV4e4
         /G0Q==
X-Gm-Message-State: AOJu0YyfjpTfSEQfphnDA57r3lZ6HCevEd3y3UDnmW5fZKmxp+FVc08Q
	PT8Y/6gd/GFx+9mK4wawwXc=
X-Google-Smtp-Source: AGHT+IGgYhCEEqqY0LM/oTX4SyS1xhja0vFOHCuI+yqvROcHG+LZ2nXxw+2fIWlFwHq/bosMzmKfFw==
X-Received: by 2002:a05:6a20:9699:b0:147:fd40:2482 with SMTP id hp25-20020a056a20969900b00147fd402482mr6436800pzc.44.1695700388435;
        Mon, 25 Sep 2023 20:53:08 -0700 (PDT)
Received: from john.lan ([2605:59c8:148:ba00:650a:2e28:f286:c10b])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090322cf00b001c3e732b8dbsm9755723plg.168.2023.09.25.20.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 20:53:08 -0700 (PDT)
From: John Fastabend <john.fastabend@gmail.com>
To: daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	jakub@cloudflare.com
Cc: john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	edumazet@google.com
Subject: [PATCH bpf v3 3/3] bpf: sockmap, add tests for MSG_F_PEEK
Date: Mon, 25 Sep 2023 20:53:00 -0700
Message-Id: <20230926035300.135096-4-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230926035300.135096-1-john.fastabend@gmail.com>
References: <20230926035300.135096-1-john.fastabend@gmail.com>
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


