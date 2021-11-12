Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E8344E140
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 06:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbhKLFFp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Nov 2021 00:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhKLFFo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Nov 2021 00:05:44 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80616C061766
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 21:02:54 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id y1so7455827plk.10
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 21:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=doekPDXJEcg7ehjwbs8LM0P6bw3DAVIocCK6R83e8Dk=;
        b=jczbOPQqeEAqzxi388RfWIas0usFky/+Uv4Y5iniggd5NDUi8lPohdMpdGKiybBlbP
         eC+1Rz0Ap7tHtPRk25wJa+cycPJaoFgKoD2IAQvAKsti5CIhwlP4t91kGlaa/A3i/le+
         myjlDnPgyWNp5PnoEVM178LH5CoRM9A29nnjLbnV4tHKgDBXbrIxsRLi40VxmG+HMVKd
         qRNfPsR+Eb7/dZc3t4hMdnLhLLHMyRPI90Jyp75iV5icFMZ5laUdm3ncj3RQ0IsDK9UH
         S2xUD/GcV95TJMh3/z8RRZELqDbAGOzCYLv/gWo952uM4YoeXdnGzZnUavD5nW8/Y05A
         LmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=doekPDXJEcg7ehjwbs8LM0P6bw3DAVIocCK6R83e8Dk=;
        b=cgk6fXbJcHBmLwz+ZSd1fQ+QCQr4kQDlFkUmqCvTN2PMlB7Zg0HbVaEe5USxNXZhZD
         D0FMgHH9ei39dZnhO6+hIzCy5uvQad/eLOkFCgp0elNm4tZHJCT8HrTpKiN6CfC2JYp5
         sQAVnWYsxvNxSJWlAl9A4YtnvSo+3nxihM3yvWOC04b2ptjroBoa7H92xiWu2hLICXpO
         EdS805+F6I53P4PDAahTv7acU/6ql4ALNaf1DpC6tFvqsgM3OPXtchECbdjLfMNqfGH0
         HsjrUM1h4P7asJJ0BCpE6Ixdyv+ZAdW5RNEoXzKcPdUgwziVWMv3G2KUj0V4eEP7++X3
         gANw==
X-Gm-Message-State: AOAM530c/FzsJ6CyZU6aUKDqkArXn5QCajln0PLug967uKhwuX+1brgf
        L1tRZnXozCj1HaMAS3Q+M08=
X-Google-Smtp-Source: ABdhPJwCx5Sa9KgH4ZkQZv9Qo2PKvTJds8OhV9WWwo+0OAY84fNs3YY/IRe76gL+Yj7yrIkkaP/KIw==
X-Received: by 2002:a17:90a:ba13:: with SMTP id s19mr32286775pjr.62.1636693374095;
        Thu, 11 Nov 2021 21:02:54 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:3dc4])
        by smtp.gmail.com with ESMTPSA id x193sm5079505pfd.160.2021.11.11.21.02.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Nov 2021 21:02:53 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v2 bpf-next 08/12] libbpf: Support init of inner maps in light skeleton.
Date:   Thu, 11 Nov 2021 21:02:26 -0800
Message-Id: <20211112050230.85640-9-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211112050230.85640-1-alexei.starovoitov@gmail.com>
References: <20211112050230.85640-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Add ability to initialize inner maps in light skeleton.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/bpf_gen_internal.h |  1 +
 tools/lib/bpf/gen_loader.c       | 27 +++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.c           |  6 +++---
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/bpf_gen_internal.h b/tools/lib/bpf/bpf_gen_internal.h
index ed162fdeecf6..34a7f529be39 100644
--- a/tools/lib/bpf/bpf_gen_internal.h
+++ b/tools/lib/bpf/bpf_gen_internal.h
@@ -64,5 +64,6 @@ void bpf_gen__record_attach_target(struct bpf_gen *gen, const char *name, enum b
 void bpf_gen__record_extern(struct bpf_gen *gen, const char *name, bool is_weak,
 			    bool is_typeless, int kind, int insn_idx);
 void bpf_gen__record_relo_core(struct bpf_gen *gen, const struct bpf_core_relo *core_relo);
+void bpf_gen__populate_outer_map(struct bpf_gen *gen, int outer_map_idx, int key, int inner_map_idx);
 
 #endif
diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 442c4477e38e..21aa564c9b91 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -1063,6 +1063,33 @@ void bpf_gen__map_update_elem(struct bpf_gen *gen, int map_idx, void *pvalue,
 	emit_check_err(gen);
 }
 
+void bpf_gen__populate_outer_map(struct bpf_gen *gen, int outer_map_idx, int slot,
+				 int inner_map_idx)
+{
+	int attr_size = offsetofend(union bpf_attr, flags);
+	int map_update_attr, key;
+	union bpf_attr attr;
+
+	memset(&attr, 0, attr_size);
+	pr_debug("gen: populate_outer_map: outer %d key %d inner %d\n",
+		 outer_map_idx, slot, inner_map_idx);
+
+	key = add_data(gen, &slot, sizeof(slot));
+
+	map_update_attr = add_data(gen, &attr, attr_size);
+	move_blob2blob(gen, attr_field(map_update_attr, map_fd), 4,
+		       blob_fd_array_off(gen, outer_map_idx));
+	emit_rel_store(gen, attr_field(map_update_attr, key), key);
+	emit_rel_store(gen, attr_field(map_update_attr, value),
+		       blob_fd_array_off(gen, inner_map_idx));
+
+	/* emit MAP_UPDATE_ELEM command */
+	emit_sys_bpf(gen, BPF_MAP_UPDATE_ELEM, map_update_attr, attr_size);
+	debug_ret(gen, "populate_outer_map outer %d key %d inner %d",
+		  outer_map_idx, slot, inner_map_idx);
+	emit_check_err(gen);
+}
+
 void bpf_gen__map_freeze(struct bpf_gen *gen, int map_idx)
 {
 	int attr_size = offsetofend(union bpf_attr, map_fd);
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 2311f484511a..a8a827d778ee 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4956,9 +4956,9 @@ static int init_map_slots(struct bpf_object *obj, struct bpf_map *map)
 		targ_map = map->init_slots[i];
 		fd = bpf_map__fd(targ_map);
 		if (obj->gen_loader) {
-			pr_warn("// TODO map_update_elem: idx %td key %d value==map_idx %td\n",
-				map - obj->maps, i, targ_map - obj->maps);
-			return -ENOTSUP;
+			bpf_gen__populate_outer_map(obj->gen_loader,
+						    map - obj->maps, i,
+						    targ_map - obj->maps);
 		} else {
 			err = bpf_map_update_elem(map->fd, &i, &fd, 0);
 		}
-- 
2.30.2

