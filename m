Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD86A63958C
	for <lists+bpf@lfdr.de>; Sat, 26 Nov 2022 11:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiKZKyY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 26 Nov 2022 05:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiKZKyW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 26 Nov 2022 05:54:22 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C471E724
        for <bpf@vger.kernel.org>; Sat, 26 Nov 2022 02:54:21 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id 4so6052150pli.0
        for <bpf@vger.kernel.org>; Sat, 26 Nov 2022 02:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Xt0FLthwIokZ4Vyletmr7akfC9js//XyjR4Hp8AOj0=;
        b=bLORgx6dd9bGzTiObXKgqW5UlXo/DzrHq3rS18hN+9EvoRccRnPOEKKrNCev2zF2cq
         gsttUv6XpMdx20yS1149fu9twk/qum9pmS/c3E4LxtUmOr68Q3gKYoeupLaclnMXi7aZ
         +n9qQrVf2fMQkJftBxg+h/9kSbiPYAb1GUoQ+qhy36bemRnj3aUHg8xQZpIkcjGvfTBs
         YfMeQRnMATmP4zj2zvbPR5xOYv4IhKJ0QnFmBjPhTpIM/kPSBcSw4Trby9/fjdm9GKy6
         97DZ3bJvoDuNrTZNpBrAHv88hJYPM9/AEZu0883diToio5uAc79eznxI5slrrUkf3PA9
         h9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Xt0FLthwIokZ4Vyletmr7akfC9js//XyjR4Hp8AOj0=;
        b=o5cVXQJ/UAcgu02viB0aAbJIaFZXBkmumUDOy/JM/E+Mu0S2fsjy0yzD2U2WHhX2Ko
         PKpBniO0y8S2JX8oM8Q53ZltDslVv5gJqdjFeb5PGfgx4ieRK8ddensvABTlv5TiFAVR
         aVfX9B0u2RzllViCjB6A7p6lY7vZYse77WzeqNzqhxoLUaJUhW/fU5u3hgVQTFYxfGOw
         tl/Pb1e1Sis9sVVLwk65WUDxMUnS0gjHjKshCuahWEmWpBq35u50QkMQI6nTONmnsZUc
         Bpq8VDg3F3JhYi0E+TlYirau+JVJwYw9XDJWO5acOOhPW+n/1LquuvVLex4MVSAJ9c2I
         eDRg==
X-Gm-Message-State: ANoB5pnx47LXVD4nshE0Kq/pc0JBFmjcEdZLb+0dsiNLKPylitt3FKCZ
        yBJwl4YHvXyNLBHSb6tDgDu7ZA1DB3Q=
X-Google-Smtp-Source: AA0mqf40mGjSmrqGi9Jus8BBuKDjPxRUZEEphpNJ6CGO6UT91fvoNisxlYx+dnO1uXvGxTOZsE2kIg==
X-Received: by 2002:a17:902:934b:b0:189:78db:12be with SMTP id g11-20020a170902934b00b0018978db12bemr1219247plp.8.1669460060477;
        Sat, 26 Nov 2022 02:54:20 -0800 (PST)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id z14-20020a1709027e8e00b00188fdae6e0esm5079904pla.44.2022.11.26.02.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 02:54:20 -0800 (PST)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com, toke@redhat.com,
        hengqi.chen@gmail.com
Subject: [PATCH bpf 2/2] selftests/bpf: Update map_in_map using map without BTF key/value info
Date:   Sat, 26 Nov 2022 18:53:51 +0800
Message-Id: <20221126105351.2578782-3-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221126105351.2578782-1-hengqi.chen@gmail.com>
References: <20221126105351.2578782-1-hengqi.chen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a selftest to ensure that inner map without BTF key/value info
can coexist with inner map with BTF key/value info in the same map_in_map.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 .../selftests/bpf/prog_tests/btf_map_in_map.c | 27 +++++++++++++++++++
 .../selftests/bpf/progs/test_btf_map_in_map.c | 22 +++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_map_in_map.c b/tools/testing/selftests/bpf/prog_tests/btf_map_in_map.c
index eb90a6b8850d..d34d91d6d9ca 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_map_in_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_map_in_map.c
@@ -154,6 +154,30 @@ static void test_diff_size(void)
 	test_btf_map_in_map__destroy(skel);
 }

+static void test_btf_key_value(void)
+{
+	struct test_btf_map_in_map *skel;
+	int err, map_fd1, map_fd2, zero = 0;
+
+	skel = test_btf_map_in_map__open_and_load();
+	if (CHECK(!skel, "skel_open", "failed to open&load skeleton\n"))
+		return;
+
+	map_fd1 = bpf_map__fd(skel->maps.inner);
+	err = bpf_map_update_elem(bpf_map__fd(skel->maps.outer), &zero, &map_fd1, 0);
+	CHECK(err, "update map_in_map using map with BTF key/value info",
+	      "cannot use inner map with BTF key/value info\n");
+
+	map_fd2 = bpf_map_create(BPF_MAP_TYPE_LRU_HASH, NULL, 4, 4, 1, NULL);
+	CHECK(map_fd2 < 0, "create map without BTF key/value info", "cannot create map\n");
+	err = bpf_map_update_elem(bpf_map__fd(skel->maps.outer), &zero, &map_fd2, 0);
+	CHECK(err, "update map_in_map using map without BTF key/value info",
+	      "cannot use inner map without BTF key/value info\n");
+
+	close(map_fd2);
+	test_btf_map_in_map__destroy(skel);
+}
+
 void test_btf_map_in_map(void)
 {
 	if (test__start_subtest("lookup_update"))
@@ -161,4 +185,7 @@ void test_btf_map_in_map(void)

 	if (test__start_subtest("diff_size"))
 		test_diff_size();
+
+	if (test__start_subtest("btf_key_value"))
+		test_btf_key_value();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_btf_map_in_map.c b/tools/testing/selftests/bpf/progs/test_btf_map_in_map.c
index c218cf8989a9..8f7ca70496f2 100644
--- a/tools/testing/selftests/bpf/progs/test_btf_map_in_map.c
+++ b/tools/testing/selftests/bpf/progs/test_btf_map_in_map.c
@@ -118,6 +118,28 @@ struct outer_sockarr_sz1 {
 	.values = { (void *)&sockarr_sz1 },
 };

+struct inner_key {
+	__u32 x;
+};
+
+struct inner_value {
+	__u32 y;
+};
+
+struct inner {
+	__uint(type, BPF_MAP_TYPE_LRU_HASH);
+	__uint(max_entries, 1);
+	__type(key, struct inner_key);
+	__type(value, struct inner_value);
+} inner SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__array(values, struct inner);
+} outer SEC(".maps");
+
 int input = 0;

 SEC("raw_tp/sys_enter")
--
2.34.1
