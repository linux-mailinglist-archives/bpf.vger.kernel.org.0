Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED113DE3CD
	for <lists+bpf@lfdr.de>; Tue,  3 Aug 2021 03:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbhHCBEE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Aug 2021 21:04:04 -0400
Received: from mga07.intel.com ([134.134.136.100]:65283 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233455AbhHCBEB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Aug 2021 21:04:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="277327859"
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; 
   d="scan'208";a="277327859"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 18:03:50 -0700
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; 
   d="scan'208";a="419480135"
Received: from ticela-or-032.amr.corp.intel.com (HELO localhost.localdomain) ([10.212.166.34])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 18:03:50 -0700
From:   Ederson de Souza <ederson.desouza@intel.com>
To:     xdp-hints@xdp-project.net
Cc:     bpf@vger.kernel.org
Subject: [[RFC xdp-hints] 14/16] libbpf: Helpers to access XDP hints based on BTF definitions
Date:   Mon,  2 Aug 2021 18:03:29 -0700
Message-Id: <20210803010331.39453-15-ederson.desouza@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210803010331.39453-1-ederson.desouza@intel.com>
References: <20210803010331.39453-1-ederson.desouza@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A new set of functions to help get the BTF definition of XDP hints
structure and get the information based on it.

`xsk_umem__btf_id` helps retrieve the BTF id of XDP metadata.
`xsk_btf__init` sets up a context based on the BTF, including a hashmap,
so that subsequent queries are faster.
`xsk_btf__read` returns a pointer to the position in the XDP metadata
containing a given field.
`xsk_btf__has_field` checks the presence of a field in the BTF.
`xsk_btf__free` frees up the context.

Besides those, a macro `XSK_BTF_READ_INTO` acts as a convenient helper
to read the field contents into a given variable.

Note that currently, the hashmap used to speed-up offset location into
the BTF doesn't use the field name as a string as key to the hashmap. It
directly uses the pointer value instead, as it is expected that most of
time, field names will be addressed by a shared constant string residing
on read-only memory, thus saving some time. If this assumption is not
entirely true, this optimisation needs to be rethought (or discarded
altogether).

Signed-off-by: Ederson de Souza <ederson.desouza@intel.com>
---
 tools/lib/bpf/libbpf.map |   5 ++
 tools/lib/bpf/xsk.c      | 177 +++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/xsk.h      |  15 ++++
 3 files changed, 197 insertions(+)

diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 663585f7f186..04ffee0dc005 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -375,8 +375,13 @@ LIBBPF_0.5.0 {
 		bpf_map_lookup_and_delete_elem_flags;
 		bpf_object__gen_loader;
 		libbpf_set_strict_mode;
+		xsk_btf__init;
+		xsk_btf__read;
+		xsk_btf__has_field;
+		xsk_btf__free;
 		xsk_umem__adjust_cons_data;
 		xsk_umem__adjust_cons_data_meta;
 		xsk_umem__adjust_prod_data;
 		xsk_umem__adjust_prod_data_meta;
+		xsk_umem__btf_id;
 } LIBBPF_0.4.0;
diff --git a/tools/lib/bpf/xsk.c b/tools/lib/bpf/xsk.c
index 17e8045eac0e..0455ddaa1734 100644
--- a/tools/lib/bpf/xsk.c
+++ b/tools/lib/bpf/xsk.c
@@ -31,6 +31,7 @@
 #include <linux/if_link.h>
 
 #include "bpf.h"
+#include "hashmap.h"
 #include "libbpf.h"
 #include "libbpf_internal.h"
 #include "xsk.h"
@@ -143,6 +144,14 @@ void *xsk_umem__adjust_cons_data_meta(void *umem_data, const struct xsk_umem *um
 	return umem_data;
 }
 
+int xsk_umem__btf_id(void *umem_data, const struct xsk_umem *umem)
+{
+	if (umem->config.xdp_headroom < sizeof(int))
+		return -EINVAL;
+
+	return *(int *)(umem_data - sizeof(int));
+}
+
 static bool xsk_page_aligned(void *buffer)
 {
 	unsigned long addr = (unsigned long)buffer;
@@ -1290,3 +1299,171 @@ void xsk_socket__delete(struct xsk_socket *xsk)
 		close(xsk->fd);
 	free(xsk);
 }
+
+struct xsk_btf_info {
+	struct hashmap map;
+	struct btf *btf;
+	const struct btf_type *type;
+};
+
+struct xsk_btf_entry {
+	__u32 offset;
+	__u32 size;
+};
+
+static void __xsk_btf_free_hash(struct xsk_btf_info *xbi)
+{
+	struct hashmap_entry *entry;
+	int i;
+
+	hashmap__for_each_entry((&(xbi->map)), entry, i) {
+		free(entry->value);
+	}
+	hashmap__clear(&(xbi->map));
+}
+
+static size_t __xsk_hash_fn(const void *key, void *ctx)
+{
+	return (size_t)key;
+}
+
+static bool __xsk_equal_fn(const void *k1, const void *k2, void *ctx)
+{
+	return k1 == k2;
+}
+
+int xsk_btf__init(__u32 btf_id, struct xsk_btf_info **xbi)
+{
+	const struct btf_member *m;
+	const struct btf_type *t;
+	unsigned short vlen;
+	struct btf *btf;
+	int i, id, ret = 0;
+
+	if (!xbi)
+		return -EINVAL;
+
+	ret = btf__get_from_id(btf_id, &btf);
+	if (ret < 0)
+		return ret;
+
+	id = btf__find_by_name(btf, "xdp_hints");
+	if (id < 0) {
+		ret = id;
+		goto error_btf;
+	}
+
+	t = btf__type_by_id(btf, id);
+
+	if (!BTF_INFO_KFLAG(t->info)) {
+		ret = -EINVAL;
+		goto error_btf;
+	}
+
+	*xbi = malloc(sizeof(**xbi));
+	if (!*xbi) {
+		ret = -ENOMEM;
+		goto error_btf;
+	}
+
+	hashmap__init(&(*xbi)->map, __xsk_hash_fn, __xsk_equal_fn, NULL);
+
+	/* Validate no BTF field is a bitfield */
+	m = btf_members(t);
+	vlen = BTF_INFO_VLEN(t->info);
+	for (i = 0; i < vlen; i++, m++) {
+		if (BTF_MEMBER_BITFIELD_SIZE(m->offset)) {
+			ret = -ENOTSUP;
+			goto error_entry;
+		}
+	}
+
+	(*xbi)->btf = btf;
+	(*xbi)->type = t;
+
+	return ret;
+
+error_entry:
+	__xsk_btf_free_hash(*xbi);
+	free(*xbi);
+
+error_btf:
+	btf__free(btf);
+	return ret;
+}
+
+static int __xsk_btf_field_entry(struct xsk_btf_info *xbi, const char *field,
+			  struct xsk_btf_entry **entry)
+{
+	const struct btf_member *m;
+	unsigned short vlen;
+	int i;
+
+	m = btf_members(xbi->type);
+	vlen = BTF_INFO_VLEN(xbi->type->info);
+	for (i = 0; i < vlen; i++, m++) {
+		const struct btf_type *member_type;
+		const char *name = btf__name_by_offset(xbi->btf, m->name_off);
+
+		if (strcmp(name, field))
+			continue;
+
+		if (entry) {
+			member_type = btf__type_by_id(xbi->btf, m->type);
+			*entry = malloc(sizeof(*entry));
+			if (!entry) {
+				return -ENOMEM;
+			}
+
+			/* As we bail out at init for bit fields, there should
+			 * be no entries whose offset is not a multiple of byte */
+			(*entry)->offset = BTF_MEMBER_BIT_OFFSET(m->offset) / 8;
+			(*entry)->size = member_type->size;
+		}
+		return 0;
+	}
+
+	return -ENOENT;
+}
+
+bool xsk_btf__has_field(const char *field, struct xsk_btf_info *xbi)
+{
+	if (!xbi)
+		return false;
+
+	return __xsk_btf_field_entry(xbi, field, NULL);
+}
+
+void xsk_btf__free(struct xsk_btf_info *xbi)
+{
+	if (!xbi)
+		return;
+
+	__xsk_btf_free_hash(xbi);
+	btf__free(xbi->btf);
+	free(xbi);
+}
+
+int xsk_btf__read(void **dest, size_t size, const char *field, struct xsk_btf_info *xbi,
+		  const void *addr)
+{
+	struct xsk_btf_entry *entry;
+	int err;
+
+	if (!field || !xbi || !dest || !addr)
+		return -EINVAL;
+
+	if (!hashmap__find(&(xbi->map), field, (void **)&entry)) {
+		err = __xsk_btf_field_entry(xbi, field, &entry);
+		if (err)
+			return err;
+
+		hashmap__add(&(xbi->map), field, entry);
+	}
+
+	if (entry->size != size)
+		return -EINVAL;
+
+	*dest = (void *)((char *)addr - xbi->type->size + entry->offset);
+	return 0;
+}
diff --git a/tools/lib/bpf/xsk.h b/tools/lib/bpf/xsk.h
index 7f4143150746..b0bddc70c5a6 100644
--- a/tools/lib/bpf/xsk.h
+++ b/tools/lib/bpf/xsk.h
@@ -253,6 +253,8 @@ LIBBPF_API void *xsk_umem__adjust_prod_data_meta(void *umem_data, const struct x
 LIBBPF_API void *xsk_umem__adjust_cons_data(void *umem_data, const struct xsk_umem *umem);
 LIBBPF_API void *xsk_umem__adjust_cons_data_meta(void *umem_data, const struct xsk_umem *umem);
 
+LIBBPF_API int xsk_umem__btf_id(void *umem_data, const struct xsk_umem *umem);
+
 #define XSK_RING_CONS__DEFAULT_NUM_DESCS      2048
 #define XSK_RING_PROD__DEFAULT_NUM_DESCS      2048
 #define XSK_UMEM__DEFAULT_FRAME_SHIFT    12 /* 4096 bytes */
@@ -322,6 +324,19 @@ xsk_socket__create_shared(struct xsk_socket **xsk_ptr,
 LIBBPF_API int xsk_umem__delete(struct xsk_umem *umem);
 LIBBPF_API void xsk_socket__delete(struct xsk_socket *xsk);
 
+struct xsk_btf_info;
+
+LIBBPF_API int xsk_btf__init(__u32 btf_id, struct xsk_btf_info **xbi);
+LIBBPF_API int xsk_btf__read(void **dest, size_t size, const char *field, struct xsk_btf_info *xbi,
+			     const void *addr);
+LIBBPF_API bool xsk_btf__has_field(const char *field, struct xsk_btf_info *xbi);
+LIBBPF_API void xsk_btf__free(struct xsk_btf_info *xbi);
+
+#define XSK_BTF_READ_INTO(dest, field, xbi, addr) ({ \
+	typeof(dest) *_d; \
+	xsk_btf__read((void **)&_d, sizeof(dest), #field, xbi, addr); \
+	dest = *_d; })
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
-- 
2.32.0

