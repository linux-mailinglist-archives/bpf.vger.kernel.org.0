Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A6559B35C
	for <lists+bpf@lfdr.de>; Sun, 21 Aug 2022 13:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiHULgA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Aug 2022 07:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiHULgA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 21 Aug 2022 07:36:00 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD9A1836D
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 04:35:59 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e20so9567715wri.13
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 04:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metanetworks.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=glrEjaF6UN80soJ6diZk7wLex8HkVNn1dIiRDIPDZ9w=;
        b=I4AA7BTY/dURuFhFMqcPZSjqHNnx0Cys1a2aQG2jedBW0gC9b2m/dScuwwLgmznUcd
         7DP4jY+Q7Zcer417D0GAwKDz3IRDSW7sC4mHeZjh3SwMxbBbkM7x9CjNurBay+MfNyhB
         lou4M4Bg3qwr+HNCUbjCy+uRpggnBbUSn+Phc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=glrEjaF6UN80soJ6diZk7wLex8HkVNn1dIiRDIPDZ9w=;
        b=N56GObjlCxuUVnPAQa3jC5UihaegLau3I+QJnRA56xApbIO2cdoCXNfheeYbwKdhbT
         BnFmXoCb9jzrv4IKSEe9WhLHv8zaOiKtFWKGL+Sharys3DnjN63osjDEg5pMvhS1N1pr
         BFNpeANtHsAZFpAQLC5j+8B71To1KXsHYLJYgMlLGF07v/5xCJ7XMDgDu5BbTYkmAYdn
         S/PLRrTK2hrxXPSlLIJrCzHlcSTwQaONHWmvosltxg/Wd0zbxYdk8PXraDSdd6DyYJcB
         oMpDfmD6Z4LyAl/1eH06vrLJgfuc/jeySyIsb5dNREm630mmtV4a2Bn/5hG14kpuHzXV
         zpIw==
X-Gm-Message-State: ACgBeo2NmNdE6lKYJqaomm7WTBj0lIGRCJwzguoF7DmzU43SPf9cwGZj
        4r0JXNtS9bMxsiqC6lysav2jJHd6N04epkUdqXx9MtewM/iuZNdxQEpV95094SuTInYecXys/Gt
        g2v78f3ETeCgUf/q8yKaxHDZreGUdwScTB5Ty989evCNXPnHFOB0+luedKbrx0T9dwhBhmZb5
X-Google-Smtp-Source: AA6agR5BJClQ6VyjJebVyBgPCBp6jmEMgOABqZwrjzDymNEn8MOdRzIpSgi0x0gGAfyI2LC2efUKjw==
X-Received: by 2002:a05:6000:1547:b0:225:4fbb:df97 with SMTP id 7-20020a056000154700b002254fbbdf97mr2037927wry.76.1661081757161;
        Sun, 21 Aug 2022 04:35:57 -0700 (PDT)
Received: from blondie.home ([94.230.83.151])
        by smtp.gmail.com with ESMTPSA id l8-20020a05600c2cc800b003a6632fe925sm1067178wmc.13.2022.08.21.04.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 04:35:56 -0700 (PDT)
From:   Shmulik Ladkani <shmulik@metanetworks.com>
X-Google-Original-From: Shmulik Ladkani <shmulik.ladkani@gmail.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Stanislav Fomichev <sdf@google.com>
Cc:     Jakub Sitnicki <jakub@cloudflare.com>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: [PATCH v2 bpf-next 3/4] bpf: test_run: Propagate bpf_flow_dissect's retval to user's bpf_attr.test.retval
Date:   Sun, 21 Aug 2022 14:35:18 +0300
Message-Id: <20220821113519.116765-4-shmulik.ladkani@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220821113519.116765-1-shmulik.ladkani@gmail.com>
References: <20220821113519.116765-1-shmulik.ladkani@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Formerly, a boolean denoting whether bpf_flow_dissect returned BPF_OK
was set into 'bpf_attr.test.retval'.

Augment this, so users can check the actual return code of the dissector
program under test.

Existing prog_tests/flow_dissector*.c tests were correspondingly changed
to check against each test's expected retval.
Also, tests' resulting 'flow_keys' are verified only in case the expected
retval is BPF_OK. This allows adding new tests that expect non BPF_OK.

Signed-off-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
---
 net/bpf/test_run.c                            |  2 +-
 .../selftests/bpf/prog_tests/flow_dissector.c | 23 ++++++++++++++++++-
 .../prog_tests/flow_dissector_load_bytes.c    |  2 +-
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 51c479433517..25d8ecf105aa 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1445,7 +1445,7 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 	bpf_test_timer_enter(&t);
 	do {
 		retval = bpf_flow_dissect(prog, &ctx, eth->h_proto, ETH_HLEN,
-					  size, flags) == BPF_OK;
+					  size, flags);
 	} while (bpf_test_timer_continue(&t, 1, repeat, &ret, &duration));
 	bpf_test_timer_leave(&t);
 
diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
index 0c1661ea996e..8fa3c454995e 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
@@ -100,6 +100,7 @@ struct test {
 	} pkt;
 	struct bpf_flow_keys keys;
 	__u32 flags;
+	__u32 retval;
 };
 
 #define VLAN_HLEN	4
@@ -126,6 +127,7 @@ struct test tests[] = {
 			.sport = 80,
 			.dport = 8080,
 		},
+		.retval = BPF_OK,
 	},
 	{
 		.name = "ipv6",
@@ -146,6 +148,7 @@ struct test tests[] = {
 			.sport = 80,
 			.dport = 8080,
 		},
+		.retval = BPF_OK,
 	},
 	{
 		.name = "802.1q-ipv4",
@@ -168,6 +171,7 @@ struct test tests[] = {
 			.sport = 80,
 			.dport = 8080,
 		},
+		.retval = BPF_OK,
 	},
 	{
 		.name = "802.1ad-ipv6",
@@ -191,6 +195,7 @@ struct test tests[] = {
 			.sport = 80,
 			.dport = 8080,
 		},
+		.retval = BPF_OK,
 	},
 	{
 		.name = "ipv4-frag",
@@ -217,6 +222,7 @@ struct test tests[] = {
 			.dport = 8080,
 		},
 		.flags = BPF_FLOW_DISSECTOR_F_PARSE_1ST_FRAG,
+		.retval = BPF_OK,
 	},
 	{
 		.name = "ipv4-no-frag",
@@ -239,6 +245,7 @@ struct test tests[] = {
 			.is_frag = true,
 			.is_first_frag = true,
 		},
+		.retval = BPF_OK,
 	},
 	{
 		.name = "ipv6-frag",
@@ -265,6 +272,7 @@ struct test tests[] = {
 			.dport = 8080,
 		},
 		.flags = BPF_FLOW_DISSECTOR_F_PARSE_1ST_FRAG,
+		.retval = BPF_OK,
 	},
 	{
 		.name = "ipv6-no-frag",
@@ -287,6 +295,7 @@ struct test tests[] = {
 			.is_frag = true,
 			.is_first_frag = true,
 		},
+		.retval = BPF_OK,
 	},
 	{
 		.name = "ipv6-flow-label",
@@ -309,6 +318,7 @@ struct test tests[] = {
 			.dport = 8080,
 			.flow_label = __bpf_constant_htonl(0xbeeef),
 		},
+		.retval = BPF_OK,
 	},
 	{
 		.name = "ipv6-no-flow-label",
@@ -331,6 +341,7 @@ struct test tests[] = {
 			.flow_label = __bpf_constant_htonl(0xbeeef),
 		},
 		.flags = BPF_FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL,
+		.retval = BPF_OK,
 	},
 	{
 		.name = "ipip-encap",
@@ -359,6 +370,7 @@ struct test tests[] = {
 			.sport = 80,
 			.dport = 8080,
 		},
+		.retval = BPF_OK,
 	},
 	{
 		.name = "ipip-no-encap",
@@ -386,6 +398,7 @@ struct test tests[] = {
 			.is_encap = true,
 		},
 		.flags = BPF_FLOW_DISSECTOR_F_STOP_AT_ENCAP,
+		.retval = BPF_OK,
 	},
 };
 
@@ -503,6 +516,10 @@ static void run_tests_skb_less(int tap_fd, struct bpf_map *keys)
 		err = tx_tap(tap_fd, &tests[i].pkt, sizeof(tests[i].pkt));
 		CHECK(err < 0, "tx_tap", "err %d errno %d\n", err, errno);
 
+		/* check the stored flow_keys only if BPF_OK expected */
+		if (tests[i].retval != BPF_OK)
+			continue;
+
 		err = bpf_map_lookup_elem(keys_fd, &key, &flow_keys);
 		ASSERT_OK(err, "bpf_map_lookup_elem");
 
@@ -588,7 +605,11 @@ void test_flow_dissector(void)
 
 		err = bpf_prog_test_run_opts(prog_fd, &topts);
 		ASSERT_OK(err, "test_run");
-		ASSERT_EQ(topts.retval, 1, "test_run retval");
+		ASSERT_EQ(topts.retval, tests[i].retval, "test_run retval");
+
+		/* check the resulting flow_keys only if BPF_OK returned */
+		if (topts.retval != BPF_OK)
+			continue;
 		ASSERT_EQ(topts.data_size_out, sizeof(flow_keys),
 			  "test_run data_size_out");
 		CHECK_FLOW_KEYS(tests[i].name, flow_keys, tests[i].keys);
diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector_load_bytes.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector_load_bytes.c
index 36afb409c25f..c7a47b57ac91 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector_load_bytes.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector_load_bytes.c
@@ -44,7 +44,7 @@ void serial_test_flow_dissector_load_bytes(void)
 	ASSERT_OK(err, "test_run");
 	ASSERT_EQ(topts.data_size_out, sizeof(flow_keys),
 		  "test_run data_size_out");
-	ASSERT_EQ(topts.retval, 1, "test_run retval");
+	ASSERT_EQ(topts.retval, BPF_OK, "test_run retval");
 
 	if (fd >= -1)
 		close(fd);
-- 
2.37.2

