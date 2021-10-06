Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 332B042376B
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 07:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhJFFNJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 01:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhJFFNJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Oct 2021 01:13:09 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DDCC061749
        for <bpf@vger.kernel.org>; Tue,  5 Oct 2021 22:11:17 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id h1so1302187pfv.12
        for <bpf@vger.kernel.org>; Tue, 05 Oct 2021 22:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sHwPwHpKx20bSn061Pvs+eWhJjg079AYJMiYhBX4/kM=;
        b=DETZZUmez27hXFsEwHKl8JqiaLhij1TU0BpylbBk+TL2zTasJE2j7GSrDKSmZ0bvOj
         xBdaj7k2ka9NPw9fLV1gRPwrXiixu73Yd9qJ8wv7CMCJhpBoYqJe8Va9isQSOLkj24lE
         clyIO3nXiIwKI5DDviovfBmoFXsRvpnZ+RzofLDm+73TfnNW9qMDnj3Vr+kR4+QnjTOS
         EHXIJ3GkA6I8RYZZ4FkJENKcFldS4y5bTnB74FiUYIJQ904d3CaEhG95iNGIBHh2kSg4
         kf6czI1PpGXW6dd7x/CyrB2EaBmWF55MHIcYGfVtUOcLNE+zVKFZCOLc5inVkGT+7o8L
         uKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sHwPwHpKx20bSn061Pvs+eWhJjg079AYJMiYhBX4/kM=;
        b=RGO4/7DGsu3PDiqrc3+V8bKCu0PHwYZ89LWcS+aM2/qd2ZphzCQSM5LEkBwCxi/3gT
         3wCaNFHLLOZvpWr+tywX3fUk3nBCy/w+GCewJntZ4birNsaINTFR8Asey/gGcbpWWEHz
         Q1MElpm3fz3oStg5VRV7Yo2UOwwuo+YQuj0nQqdGLa1tT/Vwg7br5smtIVeG34RU99Fz
         dNIXvl9pKRC7DtA99CsnNsfCB16rjQZwwzUzaimz7VSno8k+UAshoKmcM/nWX+T1ZCpA
         baUh7Kv0TQz+14xKKJTkWKENBi2GRSeo82IPk37AuixUcrNxzsPrhckzCtTgbsNKdzTx
         1a4A==
X-Gm-Message-State: AOAM533yoaBguNDQ1WLBnpXYvW4JZKtXgysnKdZKJalT15vnU2T84GZX
        nrBg0se5emDWHbfsbs70Qq3JNfLVESrZJA==
X-Google-Smtp-Source: ABdhPJyEYiqY1bzMMqKHVb5uVXqTih70sbFQ7d/yfvByAarOSzwnfswGXFGObLS7pRwHt1jDaLmsdg==
X-Received: by 2002:aa7:870b:0:b0:44b:bcef:32b4 with SMTP id b11-20020aa7870b000000b0044bbcef32b4mr35144075pfo.41.1633497077115;
        Tue, 05 Oct 2021 22:11:17 -0700 (PDT)
Received: from andriin-mbp.thefacebook.com ([2620:10d:c090:400::5:b85c])
        by smtp.gmail.com with ESMTPSA id y22sm3858090pjj.33.2021.10.05.22.11.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Oct 2021 22:11:16 -0700 (PDT)
From:   andrii.nakryiko@gmail.com
X-Google-Original-From: andrii@kernel.org
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     andrii@kernel.org, kernel-team@fb.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v2 bpf-next 1/3] libbpf: add API that copies all BTF types from one BTF object to another
Date:   Tue,  5 Oct 2021 22:11:05 -0700
Message-Id: <20211006051107.17921-2-andrii@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006051107.17921-1-andrii@kernel.org>
References: <20211006051107.17921-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andrii Nakryiko <andrii@kernel.org>

Add a bulk copying api, btf__add_btf(), that speeds up and simplifies
appending entire contents of one BTF object to another one, taking care
of copying BTF type data, adjusting resulting BTF type IDs according to
their new locations in the destination BTF object, as well as copying
and deduplicating all the referenced strings and updating all the string
offsets in new BTF types as appropriate.

This API is intended to be used from tools that are generating and
otherwise manipulating BTFs generically, such as pahole. In pahole's
case, this API is useful for speeding up parallelized BTF encoding, as
it allows pahole to offload all the intricacies of BTF type copying to
libbpf and handle the parallelization aspects of the process.

Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/btf.c      | 114 ++++++++++++++++++++++++++++++++++++++-
 tools/lib/bpf/btf.h      |  22 ++++++++
 tools/lib/bpf/libbpf.map |   1 +
 3 files changed, 135 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 7774f99afa6e..60fbd1c6d466 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -189,12 +189,17 @@ int libbpf_ensure_mem(void **data, size_t *cap_cnt, size_t elem_sz, size_t need_
 	return 0;
 }
 
+static void *btf_add_type_offs_mem(struct btf *btf, size_t add_cnt)
+{
+	return libbpf_add_mem((void **)&btf->type_offs, &btf->type_offs_cap, sizeof(__u32),
+			      btf->nr_types, BTF_MAX_NR_TYPES, add_cnt);
+}
+
 static int btf_add_type_idx_entry(struct btf *btf, __u32 type_off)
 {
 	__u32 *p;
 
-	p = libbpf_add_mem((void **)&btf->type_offs, &btf->type_offs_cap, sizeof(__u32),
-			   btf->nr_types, BTF_MAX_NR_TYPES, 1);
+	p = btf_add_type_offs_mem(btf, 1);
 	if (!p)
 		return -ENOMEM;
 
@@ -1703,6 +1708,111 @@ int btf__add_type(struct btf *btf, const struct btf *src_btf, const struct btf_t
 	return btf_commit_type(btf, sz);
 }
 
+static int btf_rewrite_type_ids(__u32 *type_id, void *ctx)
+{
+	struct btf *btf = ctx;
+
+	if (!*type_id) /* nothing to do for VOID references */
+		return 0;
+
+	/* we haven't updated btf's type count yet, so
+	 * btf->start_id + btf->nr_types - 1 is the type ID offset we should
+	 * add to all newly added BTF types
+	 */
+	*type_id += btf->start_id + btf->nr_types - 1;
+	return 0;
+}
+
+int btf__add_btf(struct btf *btf, const struct btf *src_btf)
+{
+	struct btf_pipe p = { .src = src_btf, .dst = btf };
+	int data_sz, sz, cnt, i, err, old_strs_len;
+	__u32 *off;
+	void *t;
+
+	/* appending split BTF isn't supported yet */
+	if (src_btf->base_btf)
+		return libbpf_err(-ENOTSUP);
+
+	/* deconstruct BTF, if necessary, and invalidate raw_data */
+	if (btf_ensure_modifiable(btf))
+		return libbpf_err(-ENOMEM);
+
+	/* remember original strings section size if we have to roll back
+	 * partial strings section changes
+	 */
+	old_strs_len = btf->hdr->str_len;
+
+	data_sz = src_btf->hdr->type_len;
+	cnt = btf__get_nr_types(src_btf);
+
+	/* pre-allocate enough memory for new types */
+	t = btf_add_type_mem(btf, data_sz);
+	if (!t)
+		return libbpf_err(-ENOMEM);
+
+	/* pre-allocate enough memory for type offset index for new types */
+	off = btf_add_type_offs_mem(btf, cnt);
+	if (!off)
+		return libbpf_err(-ENOMEM);
+
+	/* bulk copy types data for all types from src_btf */
+	memcpy(t, src_btf->types_data, data_sz);
+
+	for (i = 0; i < cnt; i++) {
+		sz = btf_type_size(t);
+		if (sz < 0) {
+			/* unlikely, has to be corrupted src_btf */
+			err = sz;
+			goto err_out;
+		}
+
+		/* fill out type ID to type offset mapping for lookups by type ID */
+		*off = t - btf->types_data;
+
+		/* add, dedup, and remap strings referenced by this BTF type */
+		err = btf_type_visit_str_offs(t, btf_rewrite_str, &p);
+		if (err)
+			goto err_out;
+
+		/* remap all type IDs referenced from this BTF type */
+		err = btf_type_visit_type_ids(t, btf_rewrite_type_ids, btf);
+		if (err)
+			goto err_out;
+
+		/* go to next type data and type offset index entry */
+		t += sz;
+		off++;
+	}
+
+	/* Up until now any of the copied type data was effectively invisible,
+	 * so if we exited early before this point due to error, BTF would be
+	 * effectively unmodified. There would be extra internal memory
+	 * pre-allocated, but it would not be available for querying.  But now
+	 * that we've copied and rewritten all the data successfully, we can
+	 * update type count and various internal offsets and sizes to
+	 * "commit" the changes and made them visible to the outside world.
+	 */
+	btf->hdr->type_len += data_sz;
+	btf->hdr->str_off += data_sz;
+	btf->nr_types += cnt;
+
+	/* return type ID of the first added BTF type */
+	return btf->start_id + btf->nr_types - cnt;
+err_out:
+	/* zero out preallocated memory as if it was just allocated with
+	 * libbpf_add_mem()
+	 */
+	memset(btf->types_data + btf->hdr->type_len, 0, data_sz);
+	memset(btf->strs_data + old_strs_len, 0, btf->hdr->str_len - old_strs_len);
+
+	/* and now restore original strings section size; types data size
+	 * wasn't modified, so doesn't need restoring, see big comment above */
+	btf->hdr->str_len = old_strs_len;
+
+	return libbpf_err(err);
+}
+
 /*
  * Append new BTF_KIND_INT type with:
  *   - *name* - non-empty, non-NULL type name;
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 2cfe31327920..864eb51753a1 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -173,6 +173,28 @@ LIBBPF_API int btf__find_str(struct btf *btf, const char *s);
 LIBBPF_API int btf__add_str(struct btf *btf, const char *s);
 LIBBPF_API int btf__add_type(struct btf *btf, const struct btf *src_btf,
 			     const struct btf_type *src_type);
+/**
+ * @brief **btf__add_btf()** appends all the BTF types from *src_btf* into *btf*
+ * @param btf BTF object which all the BTF types and strings are added to
+ * @param src_btf BTF object which all BTF types and referenced strings are copied from
+ * @return BTF type ID of the first appended BTF type, or negative error code
+ *
+ * **btf__add_btf()** can be used to simply and efficiently append the entire
+ * contents of one BTF object to another one. All the BTF type data is copied
+ * over, all referenced type IDs are adjusted by adding a necessary ID offset.
+ * Only strings referenced from BTF types are copied over and deduplicated, so
+ * if there were some unused strings in *src_btf*, those won't be copied over,
+ * which is consistent with the general string deduplication semantics of BTF
+ * writing APIs.
+ *
+ * If any error is encountered during this process, the contents of *btf* is
+ * left intact, which means that **btf__add_btf()** follows the transactional
+ * semantics and the operation as a whole is all-or-nothing.
+ *
+ * *src_btf* has to be non-split BTF, as of now copying types from split BTF
+ * is not supported and will result in -ENOTSUP error code returned.
+ */
+LIBBPF_API int btf__add_btf(struct btf *btf, const struct btf *src_btf);
 
 LIBBPF_API int btf__add_int(struct btf *btf, const char *name, size_t byte_sz, int encoding);
 LIBBPF_API int btf__add_float(struct btf *btf, const char *name, size_t byte_sz);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 9e649cf9e771..f6b0db1e8c8b 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -389,5 +389,6 @@ LIBBPF_0.5.0 {
 
 LIBBPF_0.6.0 {
 	global:
+		btf__add_btf;
 		btf__add_tag;
 } LIBBPF_0.5.0;
-- 
2.30.2

