Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805BB4654D5
	for <lists+bpf@lfdr.de>; Wed,  1 Dec 2021 19:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352203AbhLASOj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Dec 2021 13:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352172AbhLASO1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Dec 2021 13:14:27 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012BCC061757
        for <bpf@vger.kernel.org>; Wed,  1 Dec 2021 10:11:03 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id b13so18363096plg.2
        for <bpf@vger.kernel.org>; Wed, 01 Dec 2021 10:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+NV2TwGE4OL7a3Z4OpLT80XMTQsK00mjK9IZRa9hLPc=;
        b=j9ZHzX9AhuHtE5qrk3wWkCQfPfS9q2tiVfOxY1PyMZtUSXpaXxiHOMxlPg5y/KUwwV
         Mhiz47aHu3cw19LlDON88WYYLLbIiQDz4CNFMbzUUTnndIwNktLHKk5ktrXGe+prrnmc
         eBtazvOHNgc6O1x13DVFc18L0iAzPZnJLJJbqZ6l9lXoFeOX2ZMFziet+I2BMVs7zsGM
         2mCkKdrs2kKVrXU3wNLXrcf0m6HQW6yTP0px9T8duYQ0rWRqi38icyW2vcpXGU/8h9bg
         e5kInR8EZLdp494MwOTJWWuSkbxb5JbyxFuhaO8fy/Ppb4YI8CKiMWjxucko4uoa/IWw
         wMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+NV2TwGE4OL7a3Z4OpLT80XMTQsK00mjK9IZRa9hLPc=;
        b=LB5+k/uIgFNw9pzxdH+XoVVaTajG3qBxYHhLXuP2CRyZSAvdul/WKR9Jo55Gq6TrC7
         Z9A/uUF81BcyTPUmwNNjhosZR0Z8EQatd/3PlsTk+i4skgUnGQS/Q312koxz1qX9sZ4v
         0G5H9MzbrmxNTQUedYaUsKS2bK99Y57EJcl6xdURjkVUlKtFMm6HiO8w7G3F5HitHAxZ
         e3gvHFdWdiJ5pS39CW+RoMy+3ORkwCNrw+XoiLcQA/aiEFp0ntkcFDbciYiaCw0oD3CC
         rJczbh3S1ZECjq955yM0JqJOP1IrAOzEXAX5FyKfjW3NXYFoiiKarGmYvGrePnAIlJGM
         9Dqw==
X-Gm-Message-State: AOAM532gWm1AhdNJfmLWJMCSrLm4vBM53Qld/pIHAxWj8dRhzU/+yO6t
        dIBIVbU0U3uPEFP26ax0ZnU=
X-Google-Smtp-Source: ABdhPJzYWutMpJCGY3f5f+a+NZZwO8trqRjpm+AQ5ftJCiWiIDgHo+7B1zNJeBEXoj0O14kSGH6IoQ==
X-Received: by 2002:a17:902:bb97:b0:144:d5cb:969f with SMTP id m23-20020a170902bb9700b00144d5cb969fmr9430070pls.36.1638382262517;
        Wed, 01 Dec 2021 10:11:02 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:620c])
        by smtp.gmail.com with ESMTPSA id m6sm330054pgs.18.2021.12.01.10.11.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Dec 2021 10:11:02 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v5 bpf-next 07/17] libbpf: Cleanup struct bpf_core_cand.
Date:   Wed,  1 Dec 2021 10:10:30 -0800
Message-Id: <20211201181040.23337-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211201181040.23337-1-alexei.starovoitov@gmail.com>
References: <20211201181040.23337-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andrii Nakryiko <andrii@kernel.org>

Remove two redundant fields from struct bpf_core_cand.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/libbpf.c    | 30 +++++++++++++++++-------------
 tools/lib/bpf/relo_core.h |  2 --
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 9eaf2d9820e6..96792d6e6fc1 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5179,15 +5179,18 @@ static int bpf_core_add_cands(struct bpf_core_cand *local_cand,
 			      struct bpf_core_cand_list *cands)
 {
 	struct bpf_core_cand *new_cands, *cand;
-	const struct btf_type *t;
-	const char *targ_name;
+	const struct btf_type *t, *local_t;
+	const char *targ_name, *local_name;
 	size_t targ_essent_len;
 	int n, i;
 
+	local_t = btf__type_by_id(local_cand->btf, local_cand->id);
+	local_name = btf__str_by_offset(local_cand->btf, local_t->name_off);
+
 	n = btf__type_cnt(targ_btf);
 	for (i = targ_start_id; i < n; i++) {
 		t = btf__type_by_id(targ_btf, i);
-		if (btf_kind(t) != btf_kind(local_cand->t))
+		if (btf_kind(t) != btf_kind(local_t))
 			continue;
 
 		targ_name = btf__name_by_offset(targ_btf, t->name_off);
@@ -5198,12 +5201,12 @@ static int bpf_core_add_cands(struct bpf_core_cand *local_cand,
 		if (targ_essent_len != local_essent_len)
 			continue;
 
-		if (strncmp(local_cand->name, targ_name, local_essent_len) != 0)
+		if (strncmp(local_name, targ_name, local_essent_len) != 0)
 			continue;
 
 		pr_debug("CO-RE relocating [%d] %s %s: found target candidate [%d] %s %s in [%s]\n",
-			 local_cand->id, btf_kind_str(local_cand->t),
-			 local_cand->name, i, btf_kind_str(t), targ_name,
+			 local_cand->id, btf_kind_str(local_t),
+			 local_name, i, btf_kind_str(t), targ_name,
 			 targ_btf_name);
 		new_cands = libbpf_reallocarray(cands->cands, cands->len + 1,
 					      sizeof(*cands->cands));
@@ -5212,8 +5215,6 @@ static int bpf_core_add_cands(struct bpf_core_cand *local_cand,
 
 		cand = &new_cands[cands->len];
 		cand->btf = targ_btf;
-		cand->t = t;
-		cand->name = targ_name;
 		cand->id = i;
 
 		cands->cands = new_cands;
@@ -5320,18 +5321,21 @@ bpf_core_find_cands(struct bpf_object *obj, const struct btf *local_btf, __u32 l
 	struct bpf_core_cand local_cand = {};
 	struct bpf_core_cand_list *cands;
 	const struct btf *main_btf;
+	const struct btf_type *local_t;
+	const char *local_name;
 	size_t local_essent_len;
 	int err, i;
 
 	local_cand.btf = local_btf;
-	local_cand.t = btf__type_by_id(local_btf, local_type_id);
-	if (!local_cand.t)
+	local_cand.id = local_type_id;
+	local_t = btf__type_by_id(local_btf, local_type_id);
+	if (!local_t)
 		return ERR_PTR(-EINVAL);
 
-	local_cand.name = btf__name_by_offset(local_btf, local_cand.t->name_off);
-	if (str_is_empty(local_cand.name))
+	local_name = btf__name_by_offset(local_btf, local_t->name_off);
+	if (str_is_empty(local_name))
 		return ERR_PTR(-EINVAL);
-	local_essent_len = bpf_core_essential_name_len(local_cand.name);
+	local_essent_len = bpf_core_essential_name_len(local_name);
 
 	cands = calloc(1, sizeof(*cands));
 	if (!cands)
diff --git a/tools/lib/bpf/relo_core.h b/tools/lib/bpf/relo_core.h
index f410691cc4e5..4f864b8e33b7 100644
--- a/tools/lib/bpf/relo_core.h
+++ b/tools/lib/bpf/relo_core.h
@@ -8,8 +8,6 @@
 
 struct bpf_core_cand {
 	const struct btf *btf;
-	const struct btf_type *t;
-	const char *name;
 	__u32 id;
 };
 
-- 
2.30.2

