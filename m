Return-Path: <bpf+bounces-10771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AC27AE04A
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 22:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 8B8A1B20A61
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 20:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCB924204;
	Mon, 25 Sep 2023 20:25:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A15241FE;
	Mon, 25 Sep 2023 20:24:58 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD990112;
	Mon, 25 Sep 2023 13:24:55 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c5bbb205e3so66052225ad.0;
        Mon, 25 Sep 2023 13:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695673495; x=1696278295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26fi+axt3x0k9FrIsRxv3t9BAfLZcnBuCf6adchVtJk=;
        b=gQk9GBuCARGuI1luKhxqBRck3PrreBKTveMDcYpEvy+uD0OLWKrTmlZoI2uceKHuK3
         MVtu3UYcLvuc6M61qow+TN6IB3kGgqHuF+pogzBkhm1ng4HGclimfeu2fduKDVSut/7F
         gzEeaREJj3/czZgApnqb2l+80NkjRz0GLUja21wD3LWrhgh3PZXU3Hu0Me/i9jje5qU5
         izrDouXC+LXRQfZlxkLm5lHMHiBWM0cYbBV6HkQLqeXoOjzcY+QJketiZlT4h71eJfPe
         ZS6qdTKJrDo7HQfMevIgqKdqwpE+zn0r5mPlhqqILLQqadOuEGESPUzlSAzlpFYRSjIH
         PfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695673495; x=1696278295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=26fi+axt3x0k9FrIsRxv3t9BAfLZcnBuCf6adchVtJk=;
        b=vH9BYDcPVrA1zWGSbqciy2TCOROdQp5yB1A7TlpWaDwqhpH05Un5yyKo1FLYZYR7Hm
         cO4NjFtsGxIrNq0EhxepR9lgmKrBjv2aLuSU6TSUkIjzAZXSV55Rcken1X0lwSXPoq7o
         4/Vu3gdV47T/XT3vDuTTLkmGL28nPjYTQLdcHbG/uRc6X4kzJe6xzbROoKFaBDMIwcqg
         k58Pxz5pukKj28CCAwRPD7HgzgxauWwoMSjQeKWIX6Kz8xy0/1Mbi0wBb1MnGrPYZXIX
         odKaTK+RXqK7svi/GRMNKXyATFwXDwZmYwsTJlkF+LANxQwSwwDynptfRVNH5G5oYaJQ
         LN+w==
X-Gm-Message-State: AOJu0Yw0o7xsfhQ1vDwMvSO0rJENjYksuL25dTJIdAgUGpya+j7XPAVQ
	iSWF5B6Pa/NkqaIb366unms=
X-Google-Smtp-Source: AGHT+IFBdeW/jjK+MhzVVLeKAQD8V0G7aMTmpM5YbPbumcBI4oViM6X+VF/zcA/NkYR+ICd80UY5wg==
X-Received: by 2002:a17:902:ecc6:b0:1b8:b285:ec96 with SMTP id a6-20020a170902ecc600b001b8b285ec96mr10590028plh.23.1695673495348;
        Mon, 25 Sep 2023 13:24:55 -0700 (PDT)
Received: from john.lan ([2605:59c8:148:ba00:51e:699c:e63:c15a])
        by smtp.gmail.com with ESMTPSA id jg6-20020a17090326c600b001c61df93afdsm2254040plb.59.2023.09.25.13.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 13:24:54 -0700 (PDT)
From: John Fastabend <john.fastabend@gmail.com>
To: daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	jakub@cloudflare.com
Cc: john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	edumazet@google.com
Subject: [PATCH bpf v2 3/3] bpf: sockmap, add tests for MSG_F_PEEK
Date: Mon, 25 Sep 2023 13:24:48 -0700
Message-Id: <20230925202448.100920-4-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230925202448.100920-1-john.fastabend@gmail.com>
References: <20230925202448.100920-1-john.fastabend@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Test that we can read with MSG_F_PEEK and then still get correct number
of available bytes through FIONREAD. The recv() (without PEEK) then
returns the bytes as expected. The recv() always worked though because
it was just the available byte reporting that was broke before latest
fixes.

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
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


