Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9ECC41FCFE
	for <lists+bpf@lfdr.de>; Sat,  2 Oct 2021 18:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbhJBQMF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 2 Oct 2021 12:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbhJBQME (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 2 Oct 2021 12:12:04 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76EBC0613EC
        for <bpf@vger.kernel.org>; Sat,  2 Oct 2021 09:10:18 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id k26so10727166pfi.5
        for <bpf@vger.kernel.org>; Sat, 02 Oct 2021 09:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GfXUjBs6aCjimx/l4QpxsuOL85bwwzW+aqwhKG0YeD0=;
        b=KfJnPkqBcvNYNnGKBWIy2MNK43oU3bvrd9pjbBPtP4gO+QJoqiWufqvinAtkwuUbWk
         Jj05+CnJuMT2Z1jRVIjU48kgyI5bEOHTq+UY1nwcuLT3O7VurXl0JacWL0rN5De8LnMM
         C5a2ahLXVyscqufTDXygqKMak0jHZ9LH6O1QL9KcW+EtZ0rIUErV8sbY6XLnpTs/YI9o
         vn1StNpAxW5qS6r6nBMq2cn8xkJsM6+EML838Ya1q2T8F3pqHmE6LfbTdSAsiAlsb/Gj
         Osr59Z//0BBPOD10ZlNXUiGltEqFemwaXiuJGb36BQj1XlwuSaLRgx+U/a0tkBe2PZ7Q
         uEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GfXUjBs6aCjimx/l4QpxsuOL85bwwzW+aqwhKG0YeD0=;
        b=mjDqbE4Ca+RUKvChTKQSC+WG2ONQn+kDYK5SO3MOz85UnyLOwKtfsLb1VMxpMdY+5+
         DKDg8rebAdFC2ZY6YZ9k0lGajbkHiNV/s18XX6kGYldvS+aTqSSHri/YRwqxkT7orAxC
         qp0aGAEr8Q7puonqSTcbN3gSD1h8laUZg7G2EYs7oPjhk1iIhkTq42dyrN2F+y5JkvqQ
         IzFPugh90KBc7a2FUlZsXvqPKh790QtWG/ZDbjzvFpGtfMA4ijEoWbuWJMH8Yq57Kbxv
         tXYsd4ao5K0yRNM+HcTrBTd02Km+VNzqZNGGY7IWmhL55fDPuw+6Ta4VhnEe3rG1e28o
         RTpA==
X-Gm-Message-State: AOAM5311j129fDDi4mJ5A5hQGK7BUOFZLZRrKQWlSUuD8gWnG33H5p4P
        zL8XGBV3oiiml+8rXwr2dUrCE6nrm+ECcQ==
X-Google-Smtp-Source: ABdhPJxFu6r761vHdN/gmqDucLryw63EWtzFHvA+KiDz1ecZxh09LQKZUIM5dAv/FE2kvP531hKgkw==
X-Received: by 2002:a62:160e:0:b0:445:1642:5069 with SMTP id 14-20020a62160e000000b0044516425069mr17153245pfw.66.1633191018075;
        Sat, 02 Oct 2021 09:10:18 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id v12sm9235720pgt.94.2021.10.02.09.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 09:10:17 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next v2] libbpf: Deprecate bpf_object__unload() API since v0.7
Date:   Sun,  3 Oct 2021 00:10:00 +0800
Message-Id: <20211002161000.3854559-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF objects are not re-loadable after unload. User are expected to use
bpf_object__close() to unload and free up resources in one operation.
No need to expose bpf_object__unload() as a public API, deprecate it.[0]
Add bpf_object_unload() as an alias to bpf_object__unload() and replace
all bpf_object__unload() to avoid compilation errors.

  [0] Closes: https://github.com/libbpf/libbpf/issues/290

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/lib/bpf/libbpf.c | 7 +++++--
 tools/lib/bpf/libbpf.h | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e23f1b6b9402..7de3dcbd61f2 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6679,6 +6679,9 @@ int bpf_object__unload(struct bpf_object *obj)
 	return 0;
 }

+__attribute__((alias("bpf_object__unload")))
+static int bpf_object_unload(struct bpf_object *obj);
+
 static int bpf_object__sanitize_maps(struct bpf_object *obj)
 {
 	struct bpf_map *m;
@@ -7055,7 +7058,7 @@ int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
 		if (obj->maps[i].pinned && !obj->maps[i].reused)
 			bpf_map__unpin(&obj->maps[i], NULL);

-	bpf_object__unload(obj);
+	bpf_object_unload(obj);
 	pr_warn("failed to load object '%s'\n", obj->path);
 	return libbpf_err(err);
 }
@@ -7664,7 +7667,7 @@ void bpf_object__close(struct bpf_object *obj)

 	bpf_gen__free(obj->gen_loader);
 	bpf_object__elf_finish(obj);
-	bpf_object__unload(obj);
+	bpf_object_unload(obj);
 	btf__free(obj->btf);
 	btf_ext__free(obj->btf_ext);

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index e35490c54eb3..ada0388ca1f2 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -150,6 +150,7 @@ struct bpf_object_load_attr {
 /* Load/unload object into/from kernel */
 LIBBPF_API int bpf_object__load(struct bpf_object *obj);
 LIBBPF_API int bpf_object__load_xattr(struct bpf_object_load_attr *attr);
+LIBBPF_DEPRECATED_SINCE(0, 7, "bpf_object__unload() is deprecated, use bpf_object__close() instead")
 LIBBPF_API int bpf_object__unload(struct bpf_object *obj);

 LIBBPF_API const char *bpf_object__name(const struct bpf_object *obj);
--
2.25.1
