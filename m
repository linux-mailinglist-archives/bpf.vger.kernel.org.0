Return-Path: <bpf+bounces-17479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBF280E1E9
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 03:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9346D2824BD
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 02:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE9423D9;
	Tue, 12 Dec 2023 02:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLXBZtoH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2578C2691
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 18:32:50 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3333fbbeab9so4599173f8f.2
        for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 18:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702348341; x=1702953141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymPQQ+vO77kJlYebMg54UIjrbNhoAxdhVYd/RJX0YcY=;
        b=GLXBZtoH46pYAIZnM9NmBKo54yMtkqTzyz+cbDct4wBzVBrKpGOeuXB1Q3Ojl3jIAw
         JXeNeLCtJ9ATe/zodLXmBYaUJIQEOp4itTvygTUCXMJGQ5aeTL+feBDc1PRUc7PYPvNg
         V6cLwlpnBVcSsEmRnKjf0MA3FBkvQ90eRKBEoX1dyOZ19OAzNl7rTI2PA2CWAOFgRUH7
         rddlKbLKpz5vPyUVvX0QpG68TwDffBnj0IvUVF7fFm9L8iPujYE0rEAOHnI+v1742sMc
         s7zNRs6hsVtrFKDUrd6lpemTCzH7fzbeBeWNhsRtHQc++uW4kDZwSQ7mNOjdrR8xqPVc
         F+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348341; x=1702953141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymPQQ+vO77kJlYebMg54UIjrbNhoAxdhVYd/RJX0YcY=;
        b=aXAbdYZIgMZnVoPv9pZaCWm7vmYu0Leirlw7DCT8mNENadMxh+XwKA85ac9YCSm0Sz
         EOiWUzOyTW/6eng+wvPrOcO1z1XZlV4zBO2By9lezEkK3A2Aqqj2El873eugfCy554fk
         m31poHDzvABJZcOZAMedEEr908BimairmE5YwivVcsimswCGLj4rEM5XlYNL6kER+ym8
         PSnPG/v3i2LSFd0J/JXL6/uTBElKULzdc1J/HPesJUs5D5ypX4HnPFs6WkYn4LvKkDfT
         QXsLnTYiTXsdXFAjDhk65iePZ8jc5etHOGiDImGDmPqr+SYHxYHSxn4PoL7/VCEXzlz+
         q3HQ==
X-Gm-Message-State: AOJu0YzrTEk9GYwgKlVDRVeeg/wr6ORSYcdVpeOYAoGCsl1toEvFkmB4
	7IHUwYW9nenNQZBY6KMfRRPbyDnvNC0=
X-Google-Smtp-Source: AGHT+IG07vZhB90FQMuu9jjWiBbEriaj4Z98pw/FixYMsQpd9D/gE3C0bPK2q8ylRnrdDBlJd2U8rA==
X-Received: by 2002:adf:fd04:0:b0:332:e3f1:9656 with SMTP id e4-20020adffd04000000b00332e3f19656mr2709395wrr.35.1702348341028;
        Mon, 11 Dec 2023 18:32:21 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id e12-20020adfe38c000000b003332fa77a0fsm9659900wrm.21.2023.12.11.18.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:32:20 -0800 (PST)
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
Subject: [RFC v2 2/3] bpftool: add attribute preserve_static_offset for context types
Date: Tue, 12 Dec 2023 04:31:35 +0200
Message-ID: <20231212023136.7021-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231212023136.7021-1-eddyz87@gmail.com>
References: <20231212023136.7021-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When printing vmlinux.h emit attribute preserve_static_offset [0] for
types that are used as context parameters for BPF programs. To avoid
hacking libbpf dump logic emit forward declarations annotated with
attribute. Such forward declarations have to come before structure
definitions.

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
[2] https://lore.kernel.org/bpf/20231208000531.19179-1-eddyz87@gmail.com/

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/bpf/bpftool/btf.c | 131 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 116 insertions(+), 15 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 91fcb75babe3..2abe71194afb 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -460,11 +460,118 @@ static void __printf(2, 0) btf_dump_printf(void *ctx,
 	vfprintf(stdout, fmt, args);
 }
 
+static const char * const context_types[] = {
+	"bpf_cgroup_dev_ctx",
+	"bpf_nf_ctx",
+	"bpf_perf_event_data",
+	"bpf_raw_tracepoint_args",
+	"bpf_sk_lookup",
+	"bpf_sock",
+	"bpf_sock_addr",
+	"bpf_sock_ops",
+	"bpf_sockopt",
+	"bpf_sysctl",
+	"__sk_buff",
+	"sk_msg_md",
+	"sk_reuseport_md",
+	"xdp_md",
+	"pt_regs",
+};
+
+static bool is_context_type_name(const struct btf *btf, const char *name)
+{
+	__u32 i;
+
+	for (i = 0; i < ARRAY_SIZE(context_types); ++i)
+		if (strcmp(name, context_types[i]) == 0)
+			return true;
+
+	return false;
+}
+
+/* When root_type_ids == NULL represents an iterator
+ * over all type ids in BTF: [1 .. btf__type_cnt(btf)].
+ *
+ * When root_type_ids != NULL represents an iterator
+ * over all type ids in root_type_ids array.
+ */
+struct root_type_iter {
+	__u32 *root_type_ids;
+	__u32 cnt;
+	__u32 pos;
+};
+
+static struct root_type_iter make_root_type_iter(const struct btf *btf,
+						 __u32 *root_type_ids, int root_type_cnt)
+{
+	if (root_type_cnt)
+		return (struct root_type_iter) { root_type_ids, root_type_cnt, 0 };
+
+	return (struct root_type_iter) { NULL, btf__type_cnt(btf), 1 };
+}
+
+static __u32 root_type_iter_next(struct root_type_iter *iter)
+{
+	if (iter->pos >= iter->cnt)
+		return 0;
+
+	if (iter->root_type_ids)
+		return iter->root_type_ids[iter->pos++];
+
+	return iter->pos++;
+}
+
+/* Iterate all types in 'btf', if there are types with name matching
+ * name of a BPF program context parameter type - emit a forward
+ * declaration for this type annotated with preserve_static_offset
+ * attribute [0].
+ *
+ * [0] https://clang.llvm.org/docs/AttributeReference.html#preserve-static-offset
+ */
+static void emit_static_offset_protos(const struct btf *btf, struct root_type_iter iter)
+{
+	bool first = true;
+	__u32 id;
+
+	while ((id = root_type_iter_next(&iter))) {
+		const struct btf_type *t;
+		const char *name;
+
+		t = btf__type_by_id(btf, id);
+		if (!t)
+			continue;
+
+		name = btf__name_by_offset(btf, t->name_off);
+		if (!name)
+			continue;
+
+		if (!btf_is_struct(t) || !is_context_type_name(btf, name))
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
+}
+
 static int dump_btf_c(const struct btf *btf,
 		      __u32 *root_type_ids, int root_type_cnt)
 {
+	struct root_type_iter iter;
 	struct btf_dump *d;
-	int err = 0, i;
+	int err = 0;
+	__u32 id;
 
 	d = btf_dump__new(btf, btf_dump_printf, NULL, NULL);
 	if (!d)
@@ -473,24 +580,18 @@ static int dump_btf_c(const struct btf *btf,
 	printf("#ifndef __VMLINUX_H__\n");
 	printf("#define __VMLINUX_H__\n");
 	printf("\n");
+
+	emit_static_offset_protos(btf, make_root_type_iter(btf, root_type_ids, root_type_cnt));
+
 	printf("#ifndef BPF_NO_PRESERVE_ACCESS_INDEX\n");
 	printf("#pragma clang attribute push (__attribute__((preserve_access_index)), apply_to = record)\n");
 	printf("#endif\n\n");
 
-	if (root_type_cnt) {
-		for (i = 0; i < root_type_cnt; i++) {
-			err = btf_dump__dump_type(d, root_type_ids[i]);
-			if (err)
-				goto done;
-		}
-	} else {
-		int cnt = btf__type_cnt(btf);
-
-		for (i = 1; i < cnt; i++) {
-			err = btf_dump__dump_type(d, i);
-			if (err)
-				goto done;
-		}
+	iter = make_root_type_iter(btf, root_type_ids, root_type_cnt);
+	while ((id = root_type_iter_next(&iter))) {
+		err = btf_dump__dump_type(d, id);
+		if (err)
+			goto done;
 	}
 
 	printf("#ifndef BPF_NO_PRESERVE_ACCESS_INDEX\n");
-- 
2.42.1


