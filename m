Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3A2573F1A
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 23:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236537AbiGMVnC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 17:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiGMVnB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 17:43:01 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0C133E15;
        Wed, 13 Jul 2022 14:43:01 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id e16so120801pfm.11;
        Wed, 13 Jul 2022 14:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f+NhKyzppDv/2IvxpOEHkasVtdb6OH3y3PQ0MVNgHPs=;
        b=o0uaAhIIC6tyC6F2t0kp91snxL/aTvAzHKrsGKgA8zyNxnYKajXsAPMWy6VrZgMJJS
         Rscx0NsOWvkF8BM//TFwdfrGZZQyrZsVPLDoSLnfk+lCzht1IqNgCB6DgbORabzMYx5q
         PlLSshUGgK8y+ApDX5Am5LgYg9n99byIRXvrL7tUeKqLU3SuAB/up4iORhFR+4JRNnv0
         SPTQV6Z8KKN0Yxu3sSWxWOCkwOEBEODvn/a0S7SNXC9jB3at9o+GBMlbqvqGbt7utssb
         Ny4tLEBFI8wCZd0Tr9WidLYwjBP19Cg44jBnTBLYDSiuuzXSSIbwOMjargW2kY5ASbUD
         NceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f+NhKyzppDv/2IvxpOEHkasVtdb6OH3y3PQ0MVNgHPs=;
        b=NQiSlDQNEE20pNjNZdRYoPDA36M07fXu33qdhuwgvPYJmup23swxe/0mXvt2ef0wKJ
         BT00o6nYmsU+ypFYBlaKwHYYR/YbHoAM30045tKbPd8x0b6/7Gu0nzMbE1ax+lTr9RQg
         D27K6Ow0IAcMATWTejBco/X529intZT9kEBx3XJAl95wNt80+3rUAmm/3B/XejgNohMk
         0UhIhvE85VsDKttCPQuAsBEvAY3bzNB5KV8YpYLGD7u85egKeYdN2XVpemjqAC4huyGX
         rsIL1iw1kGYWHpD36B8Db5EaQ//fb17VyHXu4nmJxFtjjxoMfNRZqG2qEOquySNSHu1/
         vhnQ==
X-Gm-Message-State: AJIora9TYe6jESqHaD00vjkrfGR0ol8ZB2WHSMOqQssGMhLzxzoA+YYa
        rBF58iFAyRZ3iwZW24cHgA==
X-Google-Smtp-Source: AGRyM1vugRHzL8XuDBv8N6yX77axqffKQHpKzuttlh42JNkkLCU/mfEB7BTk4CrHW26/U6JMTvSr2w==
X-Received: by 2002:a63:1220:0:b0:411:f661:f819 with SMTP id h32-20020a631220000000b00411f661f819mr4643273pgl.250.1657748580523;
        Wed, 13 Jul 2022 14:43:00 -0700 (PDT)
Received: from jevburton3.c.googlers.com.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id e29-20020aa7981d000000b0052ab54a4711sm1194pfl.150.2022.07.13.14.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 14:43:00 -0700 (PDT)
From:   Joe Burton <jevburton.kernel@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Joe Burton <jevburton@google.com>
Subject: [PATCH bpf-next] libbpf: Add bpf_map__set_name()
Date:   Wed, 13 Jul 2022 21:42:46 +0000
Message-Id: <20220713214246.2545204-1-jevburton.kernel@gmail.com>
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Joe Burton <jevburton@google.com>

Add the capability to set a `struct bpf_map` name.

bpf_map__reuse_fd(struct bpf_map *map, int fd) does the following:

1. get the bpf_map_info of the passed-in fd
2. strdup the name from the bpf_map_info
3. assign that name to the map
4. and some other stuff

While `map.name` may initially be arbitrarily long, this operation
truncates it after 15 characters.

We have some infrastructure that uses bpf_map__reuse_fd() to preserve
maps across upgrades. Some of our users have long map names, and are
seeing their maps 'disappear' after an upgrade, due to the name
truncation.

By invoking `bpf_map__set_name()` after `bpf_map__reuse_fd()`, we can
trivially work around the issue.

Signed-off-by: Joe Burton <jevburton@google.com>
---
 tools/lib/bpf/libbpf.c | 22 ++++++++++++++++++++++
 tools/lib/bpf/libbpf.h |  3 ++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 72548798126b..725baf508e6f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9089,6 +9089,28 @@ const char *bpf_map__name(const struct bpf_map *map)
 	return map->name;
 }
 
+int bpf_map__set_name(struct bpf_map *map, const char *name)
+{
+	char *new_name;
+
+	if (!map)
+		return libbpf_err(-EINVAL);
+
+	new_name = strdup(name);
+	if (!new_name)
+		return libbpf_err(-ENOMEM);
+
+	if (map_uses_real_name(map)) {
+		free(map->real_name);
+		map->real_name = new_name;
+	} else {
+		free(map->name);
+		map->name = new_name;
+	}
+
+	return 0;
+}
+
 enum bpf_map_type bpf_map__type(const struct bpf_map *map)
 {
 	return map->def.type;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index e4d5353f757b..e898c4cb514a 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -731,8 +731,9 @@ LIBBPF_API bool bpf_map__autocreate(const struct bpf_map *map);
  */
 LIBBPF_API int bpf_map__fd(const struct bpf_map *map);
 LIBBPF_API int bpf_map__reuse_fd(struct bpf_map *map, int fd);
-/* get map name */
+/* get/set map name */
 LIBBPF_API const char *bpf_map__name(const struct bpf_map *map);
+LIBBPF_API int bpf_map__set_name(struct bpf_map *map, const char *name);
 /* get/set map type */
 LIBBPF_API enum bpf_map_type bpf_map__type(const struct bpf_map *map);
 LIBBPF_API int bpf_map__set_type(struct bpf_map *map, enum bpf_map_type type);
-- 
2.37.0.144.g8ac04bfd2-goog

