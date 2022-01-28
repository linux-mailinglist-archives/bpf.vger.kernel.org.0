Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CE94A03BE
	for <lists+bpf@lfdr.de>; Fri, 28 Jan 2022 23:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351719AbiA1Wdn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Jan 2022 17:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351714AbiA1Wdi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Jan 2022 17:33:38 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD992C061714
        for <bpf@vger.kernel.org>; Fri, 28 Jan 2022 14:33:37 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id o10so6965872qkg.0
        for <bpf@vger.kernel.org>; Fri, 28 Jan 2022 14:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QR+Itf7KQ260h8yV5RQUnaBH/fNz41L57NJEHCSbahE=;
        b=U7dttIqF+IhRHTg88du7YhsACkHWRT8+3iLRLR01trqvLixZh6zXVrAOdfHfoFFLAK
         GEqM3vL18qdgn/+ZWedXGQ7C9ykkb5W0fz1ak1+hgWC/e60+GWjVJ+mBErA/QQ5PS4NC
         GNjZWC1E6EjO5zHQ/seEA+3Rz4BmWDHWjuNQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QR+Itf7KQ260h8yV5RQUnaBH/fNz41L57NJEHCSbahE=;
        b=coNUOIauYgRn4VoqxBDQp5UfVknES1phiofScswuocGbPlEdp2H9PG4lZciukm/QiL
         /cICXUgtYhG9cTO215kp2tPWQPWJRvvaIjdBAw1mJJAnkhe/Aw5XFMZONlka2JrwmFZy
         UJ/fTMTg15WDecqZPARAUuarP36UqWxcwOF2tAc/GLG6IwWg5IqhWRwEPlaekM8NQo9J
         K2w3ulzY3oFWyYv8I9/AqBrZ3FG8PVrV8Cnx10NJ5cJKF0nuMK7QNq7FNgXvIX9NTlMo
         VpX3dQqgSIMvJvTuBt70ZA4/kB8DGJUcIBgxwOdytKSSz6Oflftp36fbLWvoOVwO93eI
         m/ig==
X-Gm-Message-State: AOAM533mogO/vb7s23V8RNPYrVnmQD5gKcrSoyhtvioBJVl1bx6p9MjY
        ewNmAXy2lbeRNl1abNMTlNnfTw==
X-Google-Smtp-Source: ABdhPJzV3ZoyMzdhnk2Q4fUEm05/PxuhjgQgD/Hkbp2rVVkjjnK8QfCmaR+SVD1ET+/PZ8XpKy0/eQ==
X-Received: by 2002:a05:620a:2990:: with SMTP id r16mr7492323qkp.501.1643409217022;
        Fri, 28 Jan 2022 14:33:37 -0800 (PST)
Received: from localhost.localdomain ([181.136.110.101])
        by smtp.gmail.com with ESMTPSA id i18sm3723972qka.80.2022.01.28.14.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 14:33:36 -0800 (PST)
From:   =?UTF-8?q?Mauricio=20V=C3=A1squez?= <mauricio@kinvolk.io>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Rafael David Tinoco <rafaeldtinoco@gmail.com>,
        Lorenzo Fontana <lorenzo.fontana@elastic.co>,
        Leonardo Di Donato <leonardo.didonato@elastic.co>
Subject: [PATCH bpf-next v5 4/9] bpftool: Add struct definitions and helpers for BTFGen
Date:   Fri, 28 Jan 2022 17:33:07 -0500
Message-Id: <20220128223312.1253169-5-mauricio@kinvolk.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220128223312.1253169-1-mauricio@kinvolk.io>
References: <20220128223312.1253169-1-mauricio@kinvolk.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add some structs and helpers that will be used by BTFGen in the next
commits.

Signed-off-by: Mauricio Vásquez <mauricio@kinvolk.io>
Signed-off-by: Rafael David Tinoco <rafael.tinoco@aquasec.com>
Signed-off-by: Lorenzo Fontana <lorenzo.fontana@elastic.co>
Signed-off-by: Leonardo Di Donato <leonardo.didonato@elastic.co>
---
 tools/bpf/bpftool/gen.c | 75 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 64371f466fa6..68bb88e86b27 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -1118,6 +1118,81 @@ static int btf_save_raw(const struct btf *btf, const char *path)
 	return err;
 }
 
+struct btfgen_type {
+	struct btf_type *type;
+	unsigned int id;
+};
+
+struct btfgen_info {
+	struct hashmap *types;
+	struct btf *src_btf;
+};
+
+static size_t btfgen_hash_fn(const void *key, void *ctx)
+{
+	return (size_t)key;
+}
+
+static bool btfgen_equal_fn(const void *k1, const void *k2, void *ctx)
+{
+	return k1 == k2;
+}
+
+static void *uint_as_hash_key(int x)
+{
+	return (void *)(uintptr_t)x;
+}
+
+static void btfgen_free_type(struct btfgen_type *type)
+{
+	free(type);
+}
+
+static void btfgen_free_info(struct btfgen_info *info)
+{
+	struct hashmap_entry *entry;
+	size_t bkt;
+
+	if (!info)
+		return;
+
+	if (!IS_ERR_OR_NULL(info->types)) {
+		hashmap__for_each_entry(info->types, entry, bkt) {
+			btfgen_free_type(entry->value);
+		}
+		hashmap__free(info->types);
+	}
+
+	btf__free(info->src_btf);
+
+	free(info);
+}
+
+static struct btfgen_info *
+btfgen_new_info(const char *targ_btf_path)
+{
+	struct btfgen_info *info;
+
+	info = calloc(1, sizeof(*info));
+	if (!info)
+		return NULL;
+
+	info->src_btf = btf__parse(targ_btf_path, NULL);
+	if (libbpf_get_error(info->src_btf)) {
+		btfgen_free_info(info);
+		return NULL;
+	}
+
+	info->types = hashmap__new(btfgen_hash_fn, btfgen_equal_fn, NULL);
+	if (IS_ERR(info->types)) {
+		errno = -PTR_ERR(info->types);
+		btfgen_free_info(info);
+		return NULL;
+	}
+
+	return info;
+}
+
 /* Create BTF file for a set of BPF objects */
 static int btfgen(const char *src_btf, const char *dst_btf, const char *objspaths[])
 {
-- 
2.25.1

