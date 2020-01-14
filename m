Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 676F913AFD8
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2020 17:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgANQrA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jan 2020 11:47:00 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:35814 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbgANQqz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jan 2020 11:46:55 -0500
Received: by mail-pj1-f73.google.com with SMTP id l8so9167205pje.0
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2020 08:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0ZZGOVa7EnJEsoOGWnh8FKGGunEpv3ouJ9H6MPXwHHU=;
        b=OnEmcG7Z1b8fn/LqDccA04IsZ4ftZMZ8tgrB0WVlNrIrJ+69R4SUnTYQ8yPWrs6VnC
         12GYWf1bydu7O4pllLGhEbNYro+UaC3jv+nolF/d/J3PENjhZPz2exgmh89Hla3n+aAt
         VsOFXdu3cD6XNtEgef+WqlUHXBs5TdsS+OPZgEvrHlAuA5NXFrLrWhbVlLL/vIUUgiCm
         r8WKV22w4TeSpMMEdIrZlvYiBnCQVHm4x12XzYd5+KYlRD12QjSlfJOaVVh/Cfjo8Cvv
         OJxjNLT57+wLEKyh5hJa7nyXU8TWRsA1BYwI5T5OoeyzoKGrHj9mLa0E7/rU4+VN0vL9
         1kzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0ZZGOVa7EnJEsoOGWnh8FKGGunEpv3ouJ9H6MPXwHHU=;
        b=g/GPH5LvxE6t+KrInyambIYc6PBuTK5kQWrXCEbkAXuClSRHZbk5uxjaO8K80rO+9r
         8XPO4iPSBhSKtZFPWbdmGMAI8TYEVKphFuQi29/HIHLDI9pzFfIDCxgILwXJSrqlXNL5
         jQprquf8I3KsN4P/yqFeOM6rNo7s+6QU8yuyjODqbByVwR/kOFt1/1srThxmX7lvc28U
         rHejsCZ12mRsyEbLf0Xpcyo+Nd8ZLqr605FI2sun7OAXQgIgsj69ZV0onmT2GqSq5VSY
         CMIsiUJCdwIsHMaRB1dwBmis5srpA443/zGCEr6pVk5/yOHS6Np/EqUwU7x/Kp8CgK2U
         f63g==
X-Gm-Message-State: APjAAAWipR5IbLfX/+mffVE9voQ3KUksxyPzAJQXRZ+u43ury6evhX+G
        1/qPmieBHJlo/ZYrsTIq+KmofNdMT5JQ
X-Google-Smtp-Source: APXvYqy6igihoyMTYiS23TUvN5OViNjX3JKaXsgKWeQQpNQ7KaMyS2eIYBekiBbThz8XG8KvEK42DzVE2zCm
X-Received: by 2002:a63:201d:: with SMTP id g29mr28801762pgg.427.1579020414067;
 Tue, 14 Jan 2020 08:46:54 -0800 (PST)
Date:   Tue, 14 Jan 2020 08:46:12 -0800
In-Reply-To: <20200114164614.47029-1-brianvv@google.com>
Message-Id: <20200114164614.47029-9-brianvv@google.com>
Mime-Version: 1.0
References: <20200114164614.47029-1-brianvv@google.com>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH v4 bpf-next 7/9] libbpf: add libbpf support to batch ops
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Brian Vazquez <brianvv@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yonghong Song <yhs@fb.com>

Added four libbpf API functions to support map batch operations:
  . int bpf_map_delete_batch( ... )
  . int bpf_map_lookup_batch( ... )
  . int bpf_map_lookup_and_delete_batch( ... )
  . int bpf_map_update_batch( ... )

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/bpf.c      | 60 ++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/bpf.h      | 22 +++++++++++++++
 tools/lib/bpf/libbpf.map |  4 +++
 3 files changed, 86 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 500afe478e94a..12ce8d275f7dc 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -452,6 +452,66 @@ int bpf_map_freeze(int fd)
 	return sys_bpf(BPF_MAP_FREEZE, &attr, sizeof(attr));
 }
 
+static int bpf_map_batch_common(int cmd, int fd, void  *in_batch,
+				void *out_batch, void *keys, void *values,
+				__u32 *count,
+				const struct bpf_map_batch_opts *opts)
+{
+	union bpf_attr attr = {};
+	int ret;
+
+	if (!OPTS_VALID(opts, bpf_map_batch_opts))
+		return -EINVAL;
+
+	memset(&attr, 0, sizeof(attr));
+	attr.batch.map_fd = fd;
+	attr.batch.in_batch = ptr_to_u64(in_batch);
+	attr.batch.out_batch = ptr_to_u64(out_batch);
+	attr.batch.keys = ptr_to_u64(keys);
+	attr.batch.values = ptr_to_u64(values);
+	if (count)
+		attr.batch.count = *count;
+	attr.batch.elem_flags  = OPTS_GET(opts, elem_flags, 0);
+	attr.batch.flags = OPTS_GET(opts, flags, 0);
+
+	ret = sys_bpf(cmd, &attr, sizeof(attr));
+	if (count)
+		*count = attr.batch.count;
+
+	return ret;
+}
+
+int bpf_map_delete_batch(int fd, void *keys, __u32 *count,
+			 const struct bpf_map_batch_opts *opts)
+{
+	return bpf_map_batch_common(BPF_MAP_DELETE_BATCH, fd, NULL,
+				    NULL, keys, NULL, count, opts);
+}
+
+int bpf_map_lookup_batch(int fd, void *in_batch, void *out_batch, void *keys,
+			 void *values, __u32 *count,
+			 const struct bpf_map_batch_opts *opts)
+{
+	return bpf_map_batch_common(BPF_MAP_LOOKUP_BATCH, fd, in_batch,
+				    out_batch, keys, values, count, opts);
+}
+
+int bpf_map_lookup_and_delete_batch(int fd, void *in_batch, void *out_batch,
+				    void *keys, void *values, __u32 *count,
+				    const struct bpf_map_batch_opts *opts)
+{
+	return bpf_map_batch_common(BPF_MAP_LOOKUP_AND_DELETE_BATCH,
+				    fd, in_batch, out_batch, keys, values,
+				    count, opts);
+}
+
+int bpf_map_update_batch(int fd, void *keys, void *values, __u32 *count,
+			 const struct bpf_map_batch_opts *opts)
+{
+	return bpf_map_batch_common(BPF_MAP_UPDATE_BATCH, fd, NULL, NULL,
+				    keys, values, count, opts);
+}
+
 int bpf_obj_pin(int fd, const char *pathname)
 {
 	union bpf_attr attr;
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 56341d117e5ba..b976e77316cca 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -127,6 +127,28 @@ LIBBPF_API int bpf_map_lookup_and_delete_elem(int fd, const void *key,
 LIBBPF_API int bpf_map_delete_elem(int fd, const void *key);
 LIBBPF_API int bpf_map_get_next_key(int fd, const void *key, void *next_key);
 LIBBPF_API int bpf_map_freeze(int fd);
+
+struct bpf_map_batch_opts {
+	size_t sz; /* size of this struct for forward/backward compatibility */
+	__u64 elem_flags;
+	__u64 flags;
+};
+#define bpf_map_batch_opts__last_field flags
+
+LIBBPF_API int bpf_map_delete_batch(int fd, void *keys,
+				    __u32 *count,
+				    const struct bpf_map_batch_opts *opts);
+LIBBPF_API int bpf_map_lookup_batch(int fd, void *in_batch, void *out_batch,
+				    void *keys, void *values, __u32 *count,
+				    const struct bpf_map_batch_opts *opts);
+LIBBPF_API int bpf_map_lookup_and_delete_batch(int fd, void *in_batch,
+					void *out_batch, void *keys,
+					void *values, __u32 *count,
+					const struct bpf_map_batch_opts *opts);
+LIBBPF_API int bpf_map_update_batch(int fd, void *keys, void *values,
+				    __u32 *count,
+				    const struct bpf_map_batch_opts *opts);
+
 LIBBPF_API int bpf_obj_pin(int fd, const char *pathname);
 LIBBPF_API int bpf_obj_get(const char *pathname);
 
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index a19f04e6e3d96..1902a0fc6afcc 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -214,6 +214,10 @@ LIBBPF_0.0.7 {
 		btf_dump__emit_type_decl;
 		bpf_link__disconnect;
 		bpf_map__attach_struct_ops;
+		bpf_map_delete_batch;
+		bpf_map_lookup_and_delete_batch;
+		bpf_map_lookup_batch;
+		bpf_map_update_batch;
 		bpf_object__find_program_by_name;
 		bpf_object__attach_skeleton;
 		bpf_object__destroy_skeleton;
-- 
2.25.0.rc1.283.g88dfdc4193-goog

