Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234BE457ACB
	for <lists+bpf@lfdr.de>; Sat, 20 Nov 2021 04:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbhKTDgJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Nov 2021 22:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbhKTDgF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Nov 2021 22:36:05 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E5CC06173E
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 19:33:01 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id m24so9563615pls.10
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 19:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IEnoFM2S78w2/4v1vtXOkI2w0mmp3ovJnlD0eVLOwvw=;
        b=pbIYWaAyCM29AblfAMxMdr29uhZ7VuzuMy4WGDNjdWkV+mr5uEn7irRGrSgxNoUaaQ
         qxIQoswLiP/mU5xekTlaMVrBQ+jogY6I7vRAXQ7TZQ+1psfLw7NApGbEHxVjSbXN2om6
         6SLgYnySpJ9F63cJER+lTlOndNB1yK3N4e5blbdk0lr0f08PlA7N36tmgqquNLf5q8p6
         En5dWsWbIUknbND2raccWPm8JFLD4uSQndAlRQiP84VGksf1OkrTasOGgRfefftzff1F
         pIVhWMjhH81KtPsrFpPcf/FFalajiDLR61ExEmGawtdRYCRJ3Q3VxEYv7pSbn6ZrM0Sa
         FBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IEnoFM2S78w2/4v1vtXOkI2w0mmp3ovJnlD0eVLOwvw=;
        b=ifdlJG+8j7TDE1w+uLg1qnlz6QwRFa9jrFVI+afw4M3qkM938WXYd3gtEOm8lcedr2
         C8hUFn7BVpF7d7NkZHQH7A+5AjfwBHj/4/SzQ/1uHW7WRDvQ/Ukax55K54mVcpqbyV8W
         mGLNrC3X6J2eDhr138bldXTj8SKZSXoa+2SYbmuqxrvV4Ho+Ms7hd8n1u03uwo8vIhJO
         QQUzAKSDm7AZXpKcp80XkJhbTcPz/KSSee1Dwzj3Lstzdcrf5k9JPUINwkEt0dbqNC9v
         HfuFJbWR+v0PsBR9uispnwaAr0qmuUTgjOHeS3n0MaD23McWHqKCYGhyzh8tYRNHS23l
         VkcQ==
X-Gm-Message-State: AOAM532+MNhkjbqpZtQSw8i8R1V45aCCJlz5+RTRCE10PsbzmnMDXVs8
        kS+c7yeazNFgu26zlMukIuc=
X-Google-Smtp-Source: ABdhPJxRigBAnTncDMqQTqhUJeYeafsX0MitMC/4WSHmTjetpNY3v7wVvoUk9d4aHYsExBeEqaREqw==
X-Received: by 2002:a17:90b:351:: with SMTP id fh17mr6382132pjb.19.1637379180867;
        Fri, 19 Nov 2021 19:33:00 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:a858])
        by smtp.gmail.com with ESMTPSA id me7sm13752360pjb.9.2021.11.19.19.33.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Nov 2021 19:33:00 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v3 bpf-next 01/13] libbpf: Replace btf__type_by_id() with btf_type_by_id().
Date:   Fri, 19 Nov 2021 19:32:43 -0800
Message-Id: <20211120033255.91214-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211120033255.91214-1-alexei.starovoitov@gmail.com>
References: <20211120033255.91214-1-alexei.starovoitov@gmail.com>
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
 tools/lib/bpf/relo_core.c       | 19 ++++++++-----------
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index e97217a77196..4a1115eb39b4 100644
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
index b5b8956a1be8..c0904f4cb514 100644
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
@@ -1158,10 +1158,7 @@ int bpf_core_apply_relo_insn(const char *prog_name, struct bpf_insn *insn,
 	int i, j, err;
 
 	local_id = relo->type_id;
-	local_type = btf__type_by_id(local_btf, local_id);
-	if (!local_type)
-		return -EINVAL;
-
+	local_type = btf_type_by_id(local_btf, local_id);
 	local_name = btf__name_by_offset(local_btf, local_type->name_off);
 	if (!local_name)
 		return -EINVAL;
-- 
2.30.2

