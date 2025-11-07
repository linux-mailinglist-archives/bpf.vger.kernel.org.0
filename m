Return-Path: <bpf+bounces-73960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E176FC409AE
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 16:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 582ED420B62
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 15:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C62B329C58;
	Fri,  7 Nov 2025 15:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZuKBncC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8A02E1C7B
	for <bpf@vger.kernel.org>; Fri,  7 Nov 2025 15:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529683; cv=none; b=oJDawZRPZBeuITd7+Tw7m3cUBDdOpXk1he9mxrGpoDMVOAUHlzkCFX8Yn+B1v55N8B7jKLFen6BTsqleBNU51mTBPcF7STZxRegSolJDU6XvzZPtX2vz05As+NQawcMVJQrFqdWn2pQ/2GQsGI1osgvxct27WMWy75KqU9P96z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529683; c=relaxed/simple;
	bh=sS1mO9mVY+n0upVSqMY2+JLIYxv51EtgKKHOtGgsa0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kGgifhn80dp0Df4u86x8EySr/52HBI6/8z2wI+uLTYsPkrM9WguhsfOVCvPCVHsOwJ8/vfmcRELaD7P5yKSQjHqhiXSxIamY7Hd03M5wcmC2KzgPlIXkdr7R7DSN3IvpxiFR7JVkpQXahvMtGYPq+GJ6tC5rGsvHbvsrJGisZcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZuKBncC; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-421851bcb25so486805f8f.2
        for <bpf@vger.kernel.org>; Fri, 07 Nov 2025 07:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762529680; x=1763134480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gEZVeIp0039U3hcjQwmnwBxA9uxTpd6QC1RB9S7+CrU=;
        b=UZuKBncCypL+jKCMPscr3E2i4iQJNYuIWpjai0EQJmKJEfbzQbgNX0pa6KjVKl7zt8
         Obd8nckaYFlhQI81UFFDJlchJTz49BAz66gtTewc5FdRbQHXqovFQIlrBzstKbxW3usA
         0fX4aSoR7G0GP8xdNLs6xO8gAqyA4zdoxlaWwEZwE3gWWeCKdO0YVdZWp5Fj+xVYtGSk
         rqafRnMHmvHO6/oJRIGV6J9C1ejaL3U7Kjwebcf0zA7w+0fHxE+e5QT7p5HDwz4fP5w8
         KSD7PZWOy1gNjJLRUclXeQaYH5OeLD1CANuzh2uIZ/siUav8oYb10MHsJeQEFGt3u9aC
         ZEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762529680; x=1763134480;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gEZVeIp0039U3hcjQwmnwBxA9uxTpd6QC1RB9S7+CrU=;
        b=A6yw/iZPXfSbjLkTP3PLfy7jObGFFYClcwSEAmUYq9jvyupvBBBtO651F/bttMTxn6
         nqquxrfRQngiMa1aBAJxYnOh5G8mRkambTc91Tl+s3hjQ9E1KzZk+SMoThAAZZVKiC9f
         8V3rBUKsyTCURQL+dtd0ZY5QXPjVc49HnZH0d1BWrXl0UIS5pex6obcQ2/3aRJ754zt+
         yosZxQ0N2wovvK/8NaH201lbq8VajEtB4OgPQ9vdmws2/+o5aFTDNxZ0aUeW3d0H0uza
         71TwMZd9YZYS7s5qMk6wlPe8pVmHGhdDU3yl1BramRGEcfu2t8AkBEnZXYs1gDJFktq1
         Woog==
X-Gm-Message-State: AOJu0Yzk31DPWtcanGOwZw5mpHZW9E52RVC1J+YOLNZNFK80UufnKnZ0
	zp5Xj7YM3oS0J+z9vzEhLIre30vSZJxrefu1E4El33ek+Y8OtlAKGu7B
X-Gm-Gg: ASbGncuXMeruLBIQcGDkXVZi7mSqw3MwQTZkoZ8Iegpkjfn+lIY9USDv74Wt7D30XhB
	Bjed07JXk72x+INHZRpy4vdTXs86t/aOp29nlhsftt7ngpWlSgQZLYHrqF5C47YbwpslvmZOC9y
	sMvOr7sFIbTNLQhjMqodr2C+b2BpEKJR0u75xBVihDq4O08R8+C7Iz2p8r9BaZ3OuKabYel7zVx
	maoLLnU9+aFsG228JFmSj42u3USQKZ35Q2t5Kt5w2g1BKRJf6atLvvKdEt52HhtbQzi59829in9
	UiWTkkWXudn96p31HdKOhXt7SLE6psm5pQMR7qGunJFFvLhija0gLwQOeldYbGICT7r5xFJhURG
	3joq7jDrjuVCZko8caydlOqdgyiz8GyDHaZ90R5+ZnVLrERlCQ3s8WvOK5TRvkj4YjJs9LcEYI/
	eGLsDil0mD71TzmmcEU7VFrGMgh6/ARlBuM8PYvcRU8J8phzIpDnyqTlWzoi0k0Ufj62MD
X-Google-Smtp-Source: AGHT+IHhupneGIhhYLefCar228DT2G/CyJxPNnAcGQ7Z0TOciv/vnELQt/uV6goIQtVqRKCfPLfsfQ==
X-Received: by 2002:a05:6000:2303:b0:429:f050:adbb with SMTP id ffacd0b85a97d-42ae58898c7mr3366126f8f.26.1762529680187;
        Fri, 07 Nov 2025 07:34:40 -0800 (PST)
Received: from yd-B55TXL3.. (2a01cb09e0629b811add4a5ce9a2296d.ipv6.abo.wanadoo.fr. [2a01:cb09:e062:9b81:1add:4a5c:e9a2:296d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62bfa0sm6308130f8f.5.2025.11.07.07.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 07:34:39 -0800 (PST)
From: paulhoussel2@gmail.com
To: paulhoussel2@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Houssel <paul.houssel@orange.com>,
	Martin Horth <martin.horth@telecom-sudparis.eu>,
	Ouail Derghal <ouail.derghal@imt-atlantique.fr>,
	Guilhem Jazeron <guilhem.jazeron@inria.fr>,
	Ludovic Paillat <ludovic.paillat@inria.fr>,
	Robin Theveniaut <robin.theveniaut@irit.fr>,
	Tristan d'Audibert <tristan.daudibert@gmail.com>
Subject: [PATCH] libbpf: fix BTF dedup to support recursive typedef definitions
Date: Fri,  7 Nov 2025 16:34:08 +0100
Message-ID: <20251107153408.159342-1-paulhoussel2@gmail.com>
X-Mailer: git-send-email 2.43.0
Reply-To: paulhoussel2@gmail.com
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Houssel <paul.houssel@orange.com>

Handle recursive typedefs in BTF deduplication

Pahole fails to encode BTF for some Go projects (e.g. Kubernetes and
Podman) due to recursive type definitions that create reference loops
not representable in C. These recursive typedefs trigger a failure in
the BTF deduplication algorithm.

This patch extends btf_dedup_ref_type() to properly handle potential
recursion for BTF_KIND_TYPEDEF, similar to how recursion is already
handled for BTF_KIND_STRUCT. This allows pahole to successfully
generate BTF for Go binaries using recursive types without impacting
existing C-based workflows.

Co-developed-by: Martin Horth <martin.horth@telecom-sudparis.eu>
Signed-off-by: Martin Horth <martin.horth@telecom-sudparis.eu>
Co-developed-by: Ouail Derghal <ouail.derghal@imt-atlantique.fr>
Signed-off-by: Ouail Derghal <ouail.derghal@imt-atlantique.fr>
Co-developed-by: Guilhem Jazeron <guilhem.jazeron@inria.fr>
Signed-off-by: Guilhem Jazeron <guilhem.jazeron@inria.fr>
Co-developed-by: Ludovic Paillat <ludovic.paillat@inria.fr>
Signed-off-by: Ludovic Paillat <ludovic.paillat@inria.fr>
Co-developed-by: Robin Theveniaut <robin.theveniaut@irit.fr>
Signed-off-by: Robin Theveniaut <robin.theveniaut@irit.fr>
Suggested-by: Tristan d'Audibert <tristan.daudibert@gmail.com>
Signed-off-by: Paul Houssel <paul.houssel@orange.com>

---
The issue was originally observed when attempting to encode BTF for
Kubernetes binaries (kubectl, kubeadm):

$ git clone --depth 1 https://github.com/kubernetes/kubernetes
$ cd ./kubernetes
$ make kubeadm DBG=1
$ pahole --btf_encode_detached=kubeadm.btf _output/bin/kubeadm
btf_encoder__encode: btf__dedup failed!
Failed to encode BTF

The root cause lies in recursive type definitions that cannot exist
in C but are valid in Go.

program.go:

"package main

type Foo func() Foo

func main() {
	bar()
}

func bar() Foo {
	return nil
}"

Building and encoding this program with pahole triggers the same
deduplication failure:

$ go build -gcflags "all=-N -l" ./program.go
$ pahole --btf_encode_detached=program.btf program
btf_encoder__encode: btf__dedup failed!
Failed to encode BTF

As noted in the comment of btf_dedup_ref_type(), the deduplication
logic previously assumed recursion only occurs through structs or
unions:

"[...] there is no danger of encountering cycles because in C type
system the only way to form type cycle is through struct/union, so
any chain of reference types, even those taking part in a type
cycle, will inevitably reach struct/union at some point."

However, Go allows such recursion through typedef-like constructs
(function types, aliases), requiring a special case for
BTF_KIND_TYPEDEF.

This patch introduces that special handling, ensuring pahole can
handle Go-generated BTFs while maintaining compatibility with
existing C workflows.
---
 tools/lib/bpf/btf.c | 97 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 9f141395c074..239f52115c53 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -3408,6 +3408,7 @@ static int btf_dedup_prep(struct btf_dedup *d);
 static int btf_dedup_strings(struct btf_dedup *d);
 static int btf_dedup_prim_types(struct btf_dedup *d);
 static int btf_dedup_struct_types(struct btf_dedup *d);
+static int btf_dedup_typedef_types(struct btf_dedup *d);
 static int btf_dedup_ref_types(struct btf_dedup *d);
 static int btf_dedup_resolve_fwds(struct btf_dedup *d);
 static int btf_dedup_compact_types(struct btf_dedup *d);
@@ -3590,6 +3591,11 @@ int btf__dedup(struct btf *btf, const struct btf_dedup_opts *opts)
 		pr_debug("btf_dedup_struct_types failed: %s\n", errstr(err));
 		goto done;
 	}
+	err = btf_dedup_typedef_types(d);
+	if (err < 0) {
+		pr_debug("btf_dedup_typedef_types failed: %s\n", errstr(err));
+		goto done;
+	}
 	err = btf_dedup_resolve_fwds(d);
 	if (err < 0) {
 		pr_debug("btf_dedup_resolve_fwds failed: %s\n", errstr(err));
@@ -3901,6 +3907,20 @@ static int btf_dedup_strings(struct btf_dedup *d)
 	return err;
 }
 
+/*
+ * Calculate type signature hash of TYPEDEF, ignoring referenced type IDs,
+ * as referenced type IDs equivalence is established separately during type
+ * graph equivalence check algorithm.
+ */
+static long btf_hash_typedef(struct btf_type *t)
+{
+	long h;
+
+	h = hash_combine(0, t->name_off);
+	h = hash_combine(h, t->info);
+	return h;
+}
+
 static long btf_hash_common(struct btf_type *t)
 {
 	long h;
@@ -3918,6 +3938,13 @@ static bool btf_equal_common(struct btf_type *t1, struct btf_type *t2)
 	       t1->size == t2->size;
 }
 
+/* Check structural compatibility of two TYPEDEF. */
+static bool btf_equal_typedef(struct btf_type *t1, struct btf_type *t2)
+{
+	return t1->name_off == t2->name_off &&
+	       t1->info == t2->info;
+}
+
 /* Calculate type signature hash of INT or TAG. */
 static long btf_hash_int_decl_tag(struct btf_type *t)
 {
@@ -4936,10 +4963,77 @@ static int btf_dedup_struct_types(struct btf_dedup *d)
 	return 0;
 }
 
+/*
+ * Deduplicate typedef types.
+ *
+ * Similar as for struct/union types, for each typedef type its type
+ * signature hash is calculated, taking into account type's name
+ * and its size, but ignoring type ID's referenced from fields,
+ * because they might not be deduped completely until after
+ * reference types deduplication phase.
+ */
+static int btf_dedup_typedef_type(struct btf_dedup *d, __u32 type_id)
+{
+	struct btf_type *cand_type, *t;
+	struct hashmap_entry *hash_entry;
+	/* if we don't find equivalent type, then we are canonical */
+	__u32 new_id = type_id;
+	__u16 kind;
+	long h;
+
+	if (d->map[type_id] <= BTF_MAX_NR_TYPES)
+		return 0;
+
+	t = btf_type_by_id(d->btf, type_id);
+	kind = btf_kind(t);
+
+	if (kind != BTF_KIND_TYPEDEF)
+		return 0;
+	h = btf_hash_typedef(t);
+	for_each_dedup_cand(d, hash_entry, h) {
+		__u32 cand_id = hash_entry->value;
+		int eq;
+
+		cand_type = btf_type_by_id(d->btf, cand_id);
+		if (!btf_equal_typedef(t, cand_type))
+			continue;
+
+		btf_dedup_clear_hypot_map(d);
+		eq = btf_dedup_is_equiv(d, type_id, cand_id);
+		if (eq < 0)
+			return eq;
+		if (!eq)
+			continue;
+		btf_dedup_merge_hypot_map(d);
+		if (d->hypot_adjust_canon) /* not really equivalent */
+			continue;
+		new_id = cand_id;
+		break;
+	}
+
+	d->map[type_id] = new_id;
+	if (type_id == new_id && btf_dedup_table_add(d, h, type_id))
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int btf_dedup_typedef_types(struct btf_dedup *d)
+{
+	int i, err;
+
+	for (i = 0; i < d->btf->nr_types; i++) {
+		err = btf_dedup_typedef_type(d, d->btf->start_id + i);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
 /*
  * Deduplicate reference type.
  *
- * Once all primitive and struct/union types got deduplicated, we can easily
+ * Once all primitive, struct/union and typedef types got deduplicated, we can easily
  * deduplicate all other (reference) BTF types. This is done in two steps:
  *
  * 1. Resolve all referenced type IDs into their canonical type IDs. This
@@ -4982,7 +5076,6 @@ static int btf_dedup_ref_type(struct btf_dedup *d, __u32 type_id)
 	case BTF_KIND_VOLATILE:
 	case BTF_KIND_RESTRICT:
 	case BTF_KIND_PTR:
-	case BTF_KIND_TYPEDEF:
 	case BTF_KIND_FUNC:
 	case BTF_KIND_TYPE_TAG:
 		ref_type_id = btf_dedup_ref_type(d, t->type);
-- 
2.43.0


