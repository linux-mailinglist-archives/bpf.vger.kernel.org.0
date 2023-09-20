Return-Path: <bpf+bounces-10465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 791047A8926
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 18:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CE7E1C20A00
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 16:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDD03D3B7;
	Wed, 20 Sep 2023 16:00:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5A33C6B3
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 16:00:30 +0000 (UTC)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B738EC2
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 09:00:29 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-579de633419so69324477b3.3
        for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 09:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695225628; x=1695830428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S812tdFlhNDkSQJ/NFhPOZMzJjsNAoVsUA09SJZJ2TU=;
        b=TCkVQtEVIMEKbnTsTB78ICt5/tmt7rXN+9e3ZPlNnAIdxKIL4HjSr0t71Tjtcp6UFr
         Gg/w/1QzYNtpuYoK0B/Y6q+Xh8PPUsUXjVtuRQ89LU/Dfq5Q0mijzmgT9Tg9dIbcR78A
         1Btf8dGhJMD25sOuJ16hoY3uViY6FMTMh5Zgbcf3M94wevcpDrhYHoYgqfpeUCwdxdwE
         K1199Qo6ZhPBsx5WbM2l6SPHuURVUYS4EPAxjo6MZnXXv67W4K97mkP8HEnXPUNlnQGB
         TC2Fmq5cJXDA1ZZwoK5KkMbWZrwIKhCkcqO+oxYFSiawDYLrfunnSqSlBeFCYu/6BpE+
         Xlaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695225628; x=1695830428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S812tdFlhNDkSQJ/NFhPOZMzJjsNAoVsUA09SJZJ2TU=;
        b=ClCgxTtQUfAxwWQ/TyvahUATsujM00olUYxQAXzVfmL/Pud8RZX5VscQWlPbqPW11X
         ehdB8Zju6/cmFmS4NSPRl0B5OS3zYClIPdye8obMWQxoM54uc12lpGQ85tfuJfOq6X6I
         FsA+xlbcxIlWFIRIEwaffntYkAF3gSV1qSoyPRI+eMoDF43v6NII+R6BctNSB/kwFpJ/
         kqEgfOL3k4PfF19BUAzJsA9L/3REy34Z88I19xEmYyuP47aY1dmAtFZwOqnfGv3EBAxV
         z5w78DMwn9yo1KXqb8E54ew+kuSwJzoJ7KRDh4xuaKk0kl3mxltC7BTmy6+ohqAUp0Po
         06uA==
X-Gm-Message-State: AOJu0YyV8pEWxhxOyRgNzvXY9pdeJFPlyZaXohnWNGs+0LzXN71nJDCf
	suZUi5o1p+PvVMXH8vmzZ12r2etoolg=
X-Google-Smtp-Source: AGHT+IGGR6QYyzzALZRYiSbpNQzsBieuFBdfbHqtTXrzYeaTq/k+Cr2nRGvdzeVE3/yEys1Ss7t0KQ==
X-Received: by 2002:a0d:e8d2:0:b0:586:9cbb:eef4 with SMTP id r201-20020a0de8d2000000b005869cbbeef4mr3145058ywe.2.1695225628047;
        Wed, 20 Sep 2023 09:00:28 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:dcd2:9730:2c7c:239f])
        by smtp.gmail.com with ESMTPSA id m131-20020a817189000000b00589dbcf16cbsm3860490ywc.35.2023.09.20.09.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 09:00:26 -0700 (PDT)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [RFC bpf-next v3 06/11] bpf: validate value_type
Date: Wed, 20 Sep 2023 08:59:18 -0700
Message-Id: <20230920155923.151136-7-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920155923.151136-1-thinker.li@gmail.com>
References: <20230920155923.151136-1-thinker.li@gmail.com>
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

From: Kui-Feng Lee <thinker.li@gmail.com>

A value_type should has three members; refcnt, state, and data.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/bpf_struct_ops.c | 75 +++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index ef8a1edec891..fb684d2ee99d 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -99,6 +99,79 @@ const struct bpf_prog_ops bpf_struct_ops_prog_ops = {
 
 static const struct btf_type *module_type;
 
+static bool check_value_member(struct btf *btf,
+			       const struct btf_member *member,
+			       int index,
+			       const char *value_name,
+			       const char *name, const char *type_name,
+			       u16 kind)
+{
+	const char *mname, *mtname;
+	const struct btf_type *mt;
+	s32 mtype_id;
+
+	mname = btf_name_by_offset(btf, member->name_off);
+	if (!*mname) {
+		pr_warn("The member %d of %s should have a name\n",
+			index, value_name);
+		return false;
+	}
+	if (strcmp(mname, name)) {
+		pr_warn("The member %d of %s should be refcnt\n",
+			index, value_name);
+		return false;
+	}
+	mtype_id = member->type;
+	mt = btf_type_by_id(btf, mtype_id);
+	mtname = btf_name_by_offset(btf, mt->name_off);
+	if (!*mtname) {
+		pr_warn("The type of the member %d of %s should have a name\n",
+			index, value_name);
+		return false;
+	}
+	if (strcmp(mtname, type_name)) {
+		pr_warn("The type of the member %d of %s should be refcount_t\n",
+			index, value_name);
+		return false;
+	}
+	if (btf_kind(mt) != kind) {
+		pr_warn("The type of the member %d of %s should be %d\n",
+			index, value_name, btf_kind(mt));
+		return false;
+	}
+
+	return true;
+}
+
+static bool is_valid_value_type(struct btf *btf, s32 value_id,
+				const char *type_name, const char *value_name)
+{
+	const struct btf_member *member;
+	const struct btf_type *vt;
+
+	vt = btf_type_by_id(btf, value_id);
+	if (btf_vlen(vt) != 3) {
+		pr_warn("The number of %s's members should be 3, but we get %d\n",
+			value_name, btf_vlen(vt));
+		return false;
+	}
+	member = btf_type_member(vt);
+	if (!check_value_member(btf, member, 0, value_name,
+				"refcnt", "refcount_t", BTF_KIND_TYPEDEF))
+		return false;
+	member++;
+	if (!check_value_member(btf, member, 1, value_name,
+				"state", "bpf_struct_ops_state",
+				BTF_KIND_ENUM))
+		return false;
+	member++;
+	if (!check_value_member(btf, member, 2, value_name,
+				"data", type_name, BTF_KIND_STRUCT))
+		return false;
+
+	return true;
+}
+
 static void bpf_struct_ops_init_one(struct bpf_struct_ops *st_ops,
 				    struct btf *btf,
 				    struct bpf_verifier_log *log)
@@ -125,6 +198,8 @@ static void bpf_struct_ops_init_one(struct bpf_struct_ops *st_ops,
 			value_name);
 		return;
 	}
+	if (!is_valid_value_type(btf, value_id, st_ops->name, value_name))
+		return;
 
 	type_id = btf_find_by_name_kind(btf, st_ops->name,
 					BTF_KIND_STRUCT);
-- 
2.34.1


