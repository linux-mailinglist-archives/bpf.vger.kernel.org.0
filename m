Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2305644E138
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 06:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhKLFF0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Nov 2021 00:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbhKLFFZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Nov 2021 00:05:25 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5147C061766
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 21:02:35 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id x7so5717875pjn.0
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 21:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gr8dHu5TUhwAl55CrMgrb6ZY/ajDJALTeC6Nrhk+hA8=;
        b=DUj8swEdkBJQEbdKIqUhVUwALLdP17jd69Ud8OiVy3fwBl6K+ieCN9leDTNzyequJW
         p4uu9ZRZHqL/nlpMwfHayjmGkFMlYY1xuHcZDt49hKAT1NILQwzYeXxBIdtK9qfgPatZ
         1KRf0l30LooAgiHUQEAj44H4cEjC1PPihv9OF7Jv6KgM5yN2+v39npOaYgmOcX8W/LZ8
         TMrapxdu7OfbA4U3McEXBDQ2rrcJx+M+zbXjUJVvEg5U9Eoj6q3fNXp5DmlgIIp2ypBL
         WSccy+nAKLXnQdXDc7hNJ7wCeIkh8IXsnP7gSZzZ8PJ6kdeUGnvQReLDH6hXmXtxwoDu
         6oKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gr8dHu5TUhwAl55CrMgrb6ZY/ajDJALTeC6Nrhk+hA8=;
        b=GwWgq4eOSiCfc//Ati4nasbZM+JUNcrXNB9joWkkXxsgwFWgNko/kbfwxaXjOIVodb
         Lz9csrDMGJ71uvEuOmHKtuKo1G/ChukmM6T39/mGUCaimGGrk9H387QDhi0yflAosAjQ
         qJifCMgHTzmiBBEQ+p4wMIADYndSxh7k07Su42bPl25tiBwbe84LnUyLFaeV1039F507
         fGhBq1Pv/vXztHp93iHcR3i9O9zs7K69PzueMS3BX81SxICyjkOE60Pjx+/+JwOwJXD7
         Y6WfrlOSpc0NdYG1QO7LXh3L5cXUIDPyt6ub3nurqUTKgZXee4DC7N8d7sD5fj4pNvAj
         QQRw==
X-Gm-Message-State: AOAM533mQOfZeDSrZmQOEdacVD1xlZCrC+i0IhyK9D7LybwBv2ok7rxi
        xWSF+JobTbEHVo5giCu7MKQ=
X-Google-Smtp-Source: ABdhPJyevEsx5RFICGJI4SdW9mnhEp8Fa+egP4vjCbWB3LzvuAGCyjmLZCzvBn8fl/g/5Pqebp+Esg==
X-Received: by 2002:a17:90a:df97:: with SMTP id p23mr14921600pjv.3.1636693355256;
        Thu, 11 Nov 2021 21:02:35 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:3dc4])
        by smtp.gmail.com with ESMTPSA id t8sm3800118pgk.66.2021.11.11.21.02.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Nov 2021 21:02:35 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v2 bpf-next 01/12] libbpf: s/btf__type_by_id/btf_type_by_id/.
Date:   Thu, 11 Nov 2021 21:02:19 -0800
Message-Id: <20211112050230.85640-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211112050230.85640-1-alexei.starovoitov@gmail.com>
References: <20211112050230.85640-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

To prepare relo_core.c to be compiled in the kernel and the user space
replace btf__type_by_id with btf_type_by_id.

In libbpf btf__type_by_id and btf_type_by_id have different behavior.

bpf_core_apply_relo_insn() needs behavior of uapi btf__type_by_id
vs internal btf_type_by_id, but type_id range check is already done
in bpf_core_apply_relo(), so it's safe to replace it everywhere.
The kernel btf_type_by_id() does the check anyway. It doesn't hurt.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/btf.c             |  2 +-
 tools/lib/bpf/libbpf_internal.h |  2 +-
 tools/lib/bpf/relo_core.c       | 16 ++++++++--------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index fadf089ae8fe..aa0e0bbde697 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -454,7 +454,7 @@ const struct btf *btf__base_btf(const struct btf *btf)
 }
 
 /* internal helper returning non-const pointer to a type */
-struct btf_type *btf_type_by_id(struct btf *btf, __u32 type_id)
+struct btf_type *btf_type_by_id(const struct btf *btf, __u32 type_id)
 {
 	if (type_id == 0)
 		return &btf_void;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index f7ac349650a1..1e1250e1dfa3 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -172,7 +172,7 @@ static inline void *libbpf_reallocarray(void *ptr, size_t nmemb, size_t size)
 struct btf;
 struct btf_type;
 
-struct btf_type *btf_type_by_id(struct btf *btf, __u32 type_id);
+struct btf_type *btf_type_by_id(const struct btf *btf, __u32 type_id);
 const char *btf_kind_str(const struct btf_type *t);
 const struct btf_type *skip_mods_and_typedefs(const struct btf *btf, __u32 id, __u32 *res_id);
 
diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index b5b8956a1be8..dc9f775cf10b 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -51,7 +51,7 @@ static bool is_flex_arr(const struct btf *btf,
 		return false;
 
 	/* has to be the last member of enclosing struct */
-	t = btf__type_by_id(btf, acc->type_id);
+	t = btf_type_by_id(btf, acc->type_id);
 	return acc->idx == btf_vlen(t) - 1;
 }
 
@@ -388,7 +388,7 @@ static int bpf_core_match_member(const struct btf *local_btf,
 		return 0;
 
 	local_id = local_acc->type_id;
-	local_type = btf__type_by_id(local_btf, local_id);
+	local_type = btf_type_by_id(local_btf, local_id);
 	local_member = btf_members(local_type) + local_acc->idx;
 	local_name = btf__name_by_offset(local_btf, local_member->name_off);
 
@@ -580,7 +580,7 @@ static int bpf_core_calc_field_relo(const char *prog_name,
 		return -EUCLEAN; /* request instruction poisoning */
 
 	acc = &spec->spec[spec->len - 1];
-	t = btf__type_by_id(spec->btf, acc->type_id);
+	t = btf_type_by_id(spec->btf, acc->type_id);
 
 	/* a[n] accessor needs special handling */
 	if (!acc->name) {
@@ -729,7 +729,7 @@ static int bpf_core_calc_enumval_relo(const struct bpf_core_relo *relo,
 	case BPF_ENUMVAL_VALUE:
 		if (!spec)
 			return -EUCLEAN; /* request instruction poisoning */
-		t = btf__type_by_id(spec->btf, spec->spec[0].type_id);
+		t = btf_type_by_id(spec->btf, spec->spec[0].type_id);
 		e = btf_enum(t) + spec->spec[0].idx;
 		*val = e->val;
 		break;
@@ -805,8 +805,8 @@ static int bpf_core_calc_relo(const char *prog_name,
 		if (res->orig_sz != res->new_sz) {
 			const struct btf_type *orig_t, *new_t;
 
-			orig_t = btf__type_by_id(local_spec->btf, res->orig_type_id);
-			new_t = btf__type_by_id(targ_spec->btf, res->new_type_id);
+			orig_t = btf_type_by_id(local_spec->btf, res->orig_type_id);
+			new_t = btf_type_by_id(targ_spec->btf, res->new_type_id);
 
 			/* There are two use cases in which it's safe to
 			 * adjust load/store's mem size:
@@ -1054,7 +1054,7 @@ static void bpf_core_dump_spec(int level, const struct bpf_core_spec *spec)
 	int i;
 
 	type_id = spec->root_type_id;
-	t = btf__type_by_id(spec->btf, type_id);
+	t = btf_type_by_id(spec->btf, type_id);
 	s = btf__name_by_offset(spec->btf, t->name_off);
 
 	libbpf_print(level, "[%u] %s %s", type_id, btf_kind_str(t), str_is_empty(s) ? "<anon>" : s);
@@ -1158,7 +1158,7 @@ int bpf_core_apply_relo_insn(const char *prog_name, struct bpf_insn *insn,
 	int i, j, err;
 
 	local_id = relo->type_id;
-	local_type = btf__type_by_id(local_btf, local_id);
+	local_type = btf_type_by_id(local_btf, local_id);
 	if (!local_type)
 		return -EINVAL;
 
-- 
2.30.2

