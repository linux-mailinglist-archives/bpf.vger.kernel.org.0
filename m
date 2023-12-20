Return-Path: <bpf+bounces-18382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 828E6819FDC
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 14:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096CE1F23281
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 13:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA5835895;
	Wed, 20 Dec 2023 13:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOaMs9h2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594752D63F
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 13:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-553338313a0so4588041a12.2
        for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 05:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703079265; x=1703684065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQixnI1ROZf+QNKlUZTJhjGervT3Yg/doBsBIU+T8oc=;
        b=dOaMs9h2vf0hprQ9W0q8cUdW6/bptdWPj7cz+MNOKJnKTBbfIPwHIju9lrQXkg2Vnq
         zhAqGcKtq2RB3ReRCNAalAK9c3SkzavVDKaCKUQIciaW36SuvagnZeujcPlfeeled4LU
         EYHBhTEHAgjMTRs1DSgq7LimDu6kOE+c+umq2/z+adWuBcK6x47nGnIRDhk23xuU5Iao
         QSPu7boPafOqOy4qcIymioD68myPURq+VC7/QOUfrQVkc8+OSO3qTP71Fe5513QY/Z+0
         K8QwxubtwhmxVycGl6WBYR3EfEyhgg+ogXIhvPoaQUP3O0TjYxdbv5psZ3qx1YZqRX1a
         zYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703079265; x=1703684065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQixnI1ROZf+QNKlUZTJhjGervT3Yg/doBsBIU+T8oc=;
        b=tkfdnYUdEfGGxbEzU+xjkstJ/ASL3WnqgV/TK8US/TJVtOODz667a/JcGZvzilonS7
         PUt7sJwyK4DLTNOcaqxEHHD1be7j6WmIek4sIRDjLVnstsvEEFzuPZuJ2tJXX1nx0s4+
         llkK9Dmf68kXgOfzWMWqSd0Z5Af4vytjnPQxxMM3efMt+RxDVHMB4h4HukeltnhIZ3Wm
         C61KvD/fuaUKO5OFWPvhKX9Jf6I8M1zVuRLJS0HdxqbBhQP2M9L2scwwkPuHy1Re63ei
         C5v+Ie+NwRYV2wIpWtaiwGn35lx04wV5dUnyesaVf+g9pdsEMnzD/4iLHlMeeNJMGazO
         fXqQ==
X-Gm-Message-State: AOJu0YyN0HMRECrFAfDQmaCq4J5FZ/MrzFqgfzgf7V3a7GKIj4F6QDg7
	hcOqxEdeiKcM2ver014zIQYD38w/2uA=
X-Google-Smtp-Source: AGHT+IF66e75sFeTtVjiwBwyscr8V1OCIuSOenAP3qZoqzl+sMQ3kXH4ti6+ynBCTqCOAKyHTpw1Rw==
X-Received: by 2002:a17:907:86a2:b0:a23:5530:f33b with SMTP id qa34-20020a17090786a200b00a235530f33bmr3550975ejc.108.1703079265001;
        Wed, 20 Dec 2023 05:34:25 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id vs4-20020a170907a58400b00a22fb8901c4sm9951032ejc.12.2023.12.20.05.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 05:34:24 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	quentin@isovalent.com,
	alan.maguire@oracle.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC v3 2/3] bpftool: add attribute preserve_static_offset for context types
Date: Wed, 20 Dec 2023 15:34:10 +0200
Message-ID: <20231220133411.22978-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231220133411.22978-1-eddyz87@gmail.com>
References: <20231220133411.22978-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When printing vmlinux.h, emit attribute preserve_static_offset [0]
for types that have associated BTF decl tag T with value
"preserve_static_offset".

To avoid hacking libbpf dump logic emit forward declarations annotated
with attribute. Such forward declarations have to come before
structure definitions.

Only emit such forward declarations when context types are present in
target BTF (identified by name).

C language standard wording in section "6.7.2.1 Structure and union
specifiers" [1] is vague, but example in 6.7.2.1.21 explicitly allows
such notation, and it matches clang behavior.

Here is how 'bpftool btf gen ... format c' looks after this change:

    #ifndef __VMLINUX_H__
    #define __VMLINUX_H__

    #if !defined(BPF_NO_PRESERVE_STATIC_OFFSET) && \
        __has_attribute(preserve_static_offset)
    #pragma clang attribute push \
              (__attribute__((preserve_static_offset)), apply_to = record)

    struct bpf_cgroup_dev_ctx;
    ...

    #pragma clang attribute pop
    #endif

    ... rest of the output unchanged ...

This is a follow up for discussion in thread [2].

[0] https://clang.llvm.org/docs/AttributeReference.html#preserve-static-offset
[1] https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3088.pdf
[2] https://lore.kernel.org/bpf/fce6188a-6ccc-4b92-9aa7-9ee18b2f2fa1@isovalent.com/

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/bpf/bpftool/btf.c | 135 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 91fcb75babe3..feded48ddd76 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -460,6 +460,136 @@ static void __printf(2, 0) btf_dump_printf(void *ctx,
 	vfprintf(stdout, fmt, args);
 }
 
+/* Recursively walk all dependencies of 'id' and mark those as true in
+ * array 'deps'. The goal is to find all types that would be printed by
+ * btf_dump if 'id' is dumped.
+ */
+static void mark_dependencies(const struct btf *btf, __u32 id, bool *deps)
+{
+	const struct btf_param *params;
+	const struct btf_array *arr;
+	const struct btf_type *t;
+	struct btf_member *m;
+	__u16 vlen, i;
+
+	if (id == 0 || deps[id])
+		return;
+
+	deps[id] = true;
+	t = btf__type_by_id(btf, id);
+	if (!t)
+		return;
+
+	switch (btf_kind(t)) {
+	case BTF_KIND_PTR:
+	case BTF_KIND_TYPEDEF:
+	case BTF_KIND_VOLATILE:
+	case BTF_KIND_CONST:
+	case BTF_KIND_RESTRICT:
+	case BTF_KIND_TYPE_TAG:
+	case BTF_KIND_DECL_TAG:
+	case BTF_KIND_FUNC:
+		mark_dependencies(btf, t->type, deps);
+		break;
+	case BTF_KIND_STRUCT:
+	case BTF_KIND_UNION:
+		vlen = btf_vlen(t);
+		m = btf_members(t);
+		for (i = 0; i < vlen; ++i)
+			mark_dependencies(btf, m[i].type, deps);
+		break;
+	case BTF_KIND_ARRAY:
+		arr = btf_array(t);
+		mark_dependencies(btf, arr->type, deps);
+		break;
+	case BTF_KIND_FUNC_PROTO:
+		vlen = btf_vlen(t);
+		params = btf_params(t);
+		mark_dependencies(btf, t->type, deps);
+		for (i = 0; i < vlen; ++i)
+			mark_dependencies(btf, params[i].type, deps);
+		break;
+	default:
+		/* ignore */
+		break;
+	}
+}
+
+/* Iterate all types in 'btf', if there are BTF_DECL_TAG records R
+ * with "preserve_static_offset" tag - emit a forward declaration
+ * for R->type annotated with preserve_static_offset attribute [0].
+ *
+ * If root_type_ids/root_type_cnt is specified, filter generated declarations
+ * to only include root_type_ids and corresponding dependencies.
+ *
+ * [0] https://clang.llvm.org/docs/AttributeReference.html#preserve-static-offset
+ */
+static int emit_static_offset_protos(const struct btf *btf,
+				     __u32 *root_type_ids, int root_type_cnt)
+{
+	bool *root_type_deps = NULL;
+	bool first = true;
+	__u32 i, id, cnt;
+
+	cnt = btf__type_cnt(btf);
+	if (root_type_cnt) {
+		root_type_deps = calloc(cnt, sizeof(*root_type_deps));
+		if (!root_type_deps)
+			return -ENOMEM;
+
+		for (i = 0; i < (__u32)root_type_cnt; ++i)
+			mark_dependencies(btf, root_type_ids[i], root_type_deps);
+	}
+
+	for (id = 1; id < cnt; ++id) {
+		const struct btf_type *t, *s;
+		const char *name, *tag;
+
+		t = btf__type_by_id(btf, id);
+		if (!t)
+			continue;
+
+		if (!btf_is_decl_tag(t))
+			continue;
+
+		tag = btf__name_by_offset(btf, t->name_off);
+		if (strcmp(tag, "preserve_static_offset") != 0)
+			continue;
+
+		if (root_type_deps && !root_type_deps[t->type])
+			continue;
+
+		s = btf__type_by_id(btf, t->type);
+		if (!s)
+			continue;
+
+		if (!btf_is_struct(s) && !btf_is_union(s))
+			continue;
+
+		name = btf__name_by_offset(btf, s->name_off);
+		if (!name)
+			continue;
+
+		if (first) {
+			first = false;
+			printf("#if !defined(BPF_NO_PRESERVE_STATIC_OFFSET) && __has_attribute(preserve_static_offset)\n");
+			printf("#pragma clang attribute push (__attribute__((preserve_static_offset)), apply_to = record)\n");
+			printf("\n");
+		}
+
+		printf("struct %s;\n", name);
+	}
+
+	if (!first) {
+		printf("\n");
+		printf("#pragma clang attribute pop\n");
+		printf("#endif /* BPF_NO_PRESERVE_STATIC_OFFSET */\n\n");
+	}
+
+	free(root_type_deps);
+	return 0;
+}
+
 static int dump_btf_c(const struct btf *btf,
 		      __u32 *root_type_ids, int root_type_cnt)
 {
@@ -473,6 +603,11 @@ static int dump_btf_c(const struct btf *btf,
 	printf("#ifndef __VMLINUX_H__\n");
 	printf("#define __VMLINUX_H__\n");
 	printf("\n");
+
+	err = emit_static_offset_protos(btf, root_type_ids, root_type_cnt);
+	if (err)
+		goto done;
+
 	printf("#ifndef BPF_NO_PRESERVE_ACCESS_INDEX\n");
 	printf("#pragma clang attribute push (__attribute__((preserve_access_index)), apply_to = record)\n");
 	printf("#endif\n\n");
-- 
2.42.1


