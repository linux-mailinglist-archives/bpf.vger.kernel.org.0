Return-Path: <bpf+bounces-70307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05798BB7709
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 18:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9730919C4C51
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 16:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D41D2BDC33;
	Fri,  3 Oct 2025 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBCXF3EN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C81A29E117
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 16:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759507479; cv=none; b=eKwbgcZk3r+4jyFTlEedDNlvpLp5QSpcai0nYJywh2kcM31YZIVeFoXjyvVCvsq8pv/eu4u2W3pM1jU4wFp6VjCt3vhX9zyfG4UK3Q900tMHmj2AbAJWflFS4TTnUYF6WrMY11N2pxW+Bo5ECdlu0eiAxjHrzWJdWCVAhIpTb8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759507479; c=relaxed/simple;
	bh=ATS5JlvbOVLRtV0nKnjlxQ8k3FcxAp+uYwY+cuk4KM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Df0B20L1JHclRj3sDdh+XbzS3WvbJ0rTmLm5cTqSVF78ZqhGD/QHx3m3z010ygRrR2ZW9fnGHxvXTgMrl/ZZJN0NAAyi3pVdZF+ZiwcMiziq16gbAnOZfGjrxuqaCMxOpizAy7GhR+2Uv/idmCjDGpSenwIgTP3WEbJwRPaWQjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBCXF3EN; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-41174604d88so1304773f8f.2
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 09:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759507476; x=1760112276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqf2WAfJzEUoeg63hcb1dzEDB2Fw0eXJPn14WiGGA40=;
        b=iBCXF3ENFaT6kvK1v2UYu1ajUXYvFkT9dvYgmh0kMns1uO2f4qawoQy0jsDyT5N+Xk
         Gh2ARS5A7KG9jbAp94oWUJWaSZHCtVQaxGZTvVROQ7KftGdGo3LQfYt4gqj9SRw1nXUa
         ow2D28WUZQ6vVTVUiedk3QeQ0J7W3Q3UqOP79KnZxcdepQ/1XnVeq/A0RTF5ibmf5+BW
         jJvLyNKlm7jWtwXfuVKFMS4RTaCW9mfA+qat/D4+0NWnHHtWPXdyA41GXzXg6eBcSqeq
         NiGh8TWoEgtaz3jSYPJBtjvrK5ZGX7M5qNsBJP+USw2SAh3CosF7H0ZZKu57FAx0LEyk
         rzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759507476; x=1760112276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gqf2WAfJzEUoeg63hcb1dzEDB2Fw0eXJPn14WiGGA40=;
        b=XjxhunZhqZsKrds7LsKUZMdatl6VX395UmHpWeFHaS5Qx00r56SFkc+CwHj3RW3cTn
         XOeNVGrs2AutzUVqhpI77bLatvxkzVgODkS3M/16BGBB5jccUOtEm0bD6IFAvpWPEqEz
         svW2ZectKHHasPoTSd0f56gbfdlK8kMnoHVhPnw/jMOx1Ev2W6wjSRG9NL/9f1GH50dv
         BT5c7WkOZ2x061GcUQfw6knuIbtMzf0FFFW3EjpehppWV47kBvhup0YDbPMNQlgeVsU9
         NEBniYC8YAgDUW921DPLeJYubDv6EtCws60tzccmKNGY+T5u3uXWRFUOMwNKI4VHh7Zq
         LcIw==
X-Gm-Message-State: AOJu0YzX/dobnF3V1lzpBzF8SW0LNqPAfbh0suIG00IIoyxIVA79XOd+
	rzgPXj2JCE7MV/Fu7MuGnETmjgnrPpNI6raBWk+rreOYJBel5mgT0okpA2Iv9g==
X-Gm-Gg: ASbGncsI966+Fvm97Rsi4Yr2UJ4Uj4pMFITUYkpzKAc2FHnt1Prd7wtozXQrdGI95uR
	jaFvY7si5XOiP9qAkilJwGkEauKKH2sQAeGgpjkM+HDs9Ebwtf/IqyDezRVlGmDxO1RGM/JFO4s
	ZjaarQhPoqeGDc0/KxS9GkWBtOavP8AsK0TMk/vF0wxxyEBq6IyHJtzeiKj1r34wiRSeAW80C3W
	mRckf0AEGTSsLKwWVyekhTH/9msbX305T9EWmkvBjfPwvEV+xT84k0HKmgWiPUxXZZpg5XMF7GQ
	fYzlfMAsu3vHQ6jAoVws+J0/0Hgp9m4RVJdDWNQhEgj7fPoae7Vozw18mn7IM8KUOvASDFNu4UM
	za2a36SM0Iewm6QfSPml2Xota+bNz4WoZ+DyC
X-Google-Smtp-Source: AGHT+IEHI1HJ9OdB69z2N+AykO7ajT3KGCteE6Nrb3JwdvPGiJmAOYdoaksvu0yUTFCuZYtSMJnjuw==
X-Received: by 2002:a05:6000:420a:b0:424:2275:63c7 with SMTP id ffacd0b85a97d-425671d6c24mr2285565f8f.56.1759507476319;
        Fri, 03 Oct 2025 09:04:36 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:5b97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f0853sm8730488f8f.50.2025.10.03.09.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 09:04:35 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [RFC PATCH v1 03/10] lib: extract freader into a separate files
Date: Fri,  3 Oct 2025 17:04:09 +0100
Message-ID: <20251003160416.585080-4-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com>
References: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Move the freader implementation from buildid.{c,h} into a dedicated
compilation unit, freader.{c,h}.

This allows reuse of freader outside buildid, e.g. for file dynptr
support added later. Includes are updated and symbols are exported as
needed. No functional change intended.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/linux/freader.h |  32 +++++++++
 lib/Makefile            |   2 +-
 lib/buildid.c           | 145 +---------------------------------------
 lib/freader.c           | 133 ++++++++++++++++++++++++++++++++++++
 4 files changed, 167 insertions(+), 145 deletions(-)
 create mode 100644 include/linux/freader.h
 create mode 100644 lib/freader.c

diff --git a/include/linux/freader.h b/include/linux/freader.h
new file mode 100644
index 000000000000..a08ea9f59945
--- /dev/null
+++ b/include/linux/freader.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_FREADER_H
+#define _LINUX_FREADER_H
+
+#include <linux/types.h>
+
+struct freader {
+	void *buf;
+	u32 buf_sz;
+	int err;
+	union {
+		struct {
+			struct file *file;
+			struct folio *folio;
+			void *addr;
+			loff_t folio_off;
+			bool may_fault;
+		};
+		struct {
+			const char *data;
+			u64 data_sz;
+		};
+	};
+};
+
+void freader_init_from_file(struct freader *r, void *buf, u32 buf_sz,
+			    struct file *file, bool may_fault);
+void freader_init_from_mem(struct freader *r, const char *data, u64 data_sz);
+const void *freader_fetch(struct freader *r, loff_t file_off, size_t sz);
+void freader_cleanup(struct freader *r);
+int freader_err(struct freader *r);
+#endif
diff --git a/lib/Makefile b/lib/Makefile
index 392ff808c9b9..4761885228fa 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -40,7 +40,7 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
 	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
 	 nmi_backtrace.o win_minmax.o memcat_p.o \
-	 buildid.o objpool.o iomem_copy.o sys_info.o
+	 buildid.o objpool.o iomem_copy.o sys_info.o freader.o
 
 lib-$(CONFIG_UNION_FIND) += union_find.o
 lib-$(CONFIG_PRINTK) += dump_stack.o
diff --git a/lib/buildid.c b/lib/buildid.c
index c4b0f376fb34..e770dc4b73d3 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -6,155 +6,12 @@
 #include <linux/kernel.h>
 #include <linux/pagemap.h>
 #include <linux/secretmem.h>
+#include <linux/freader.h>
 
 #define BUILD_ID 3
 
 #define MAX_PHDR_CNT 256
 
-struct freader {
-	void *buf;
-	u32 buf_sz;
-	int err;
-	union {
-		struct {
-			struct file *file;
-			struct folio *folio;
-			void *addr;
-			loff_t folio_off;
-			bool may_fault;
-		};
-		struct {
-			const char *data;
-			u64 data_sz;
-		};
-	};
-};
-
-static void freader_init_from_file(struct freader *r, void *buf, u32 buf_sz,
-				   struct file *file, bool may_fault)
-{
-	memset(r, 0, sizeof(*r));
-	r->buf = buf;
-	r->buf_sz = buf_sz;
-	r->file = file;
-	r->may_fault = may_fault;
-}
-
-static void freader_init_from_mem(struct freader *r, const char *data, u64 data_sz)
-{
-	memset(r, 0, sizeof(*r));
-	r->data = data;
-	r->data_sz = data_sz;
-}
-
-static void freader_put_folio(struct freader *r)
-{
-	if (!r->folio)
-		return;
-	kunmap_local(r->addr);
-	folio_put(r->folio);
-	r->folio = NULL;
-}
-
-static int freader_get_folio(struct freader *r, loff_t file_off)
-{
-	/* check if we can just reuse current folio */
-	if (r->folio && file_off >= r->folio_off &&
-	    file_off < r->folio_off + folio_size(r->folio))
-		return 0;
-
-	freader_put_folio(r);
-
-	/* reject secretmem folios created with memfd_secret() */
-	if (secretmem_mapping(r->file->f_mapping))
-		return -EFAULT;
-
-	r->folio = filemap_get_folio(r->file->f_mapping, file_off >> PAGE_SHIFT);
-
-	/* if sleeping is allowed, wait for the page, if necessary */
-	if (r->may_fault && (IS_ERR(r->folio) || !folio_test_uptodate(r->folio))) {
-		filemap_invalidate_lock_shared(r->file->f_mapping);
-		r->folio = read_cache_folio(r->file->f_mapping, file_off >> PAGE_SHIFT,
-					    NULL, r->file);
-		filemap_invalidate_unlock_shared(r->file->f_mapping);
-	}
-
-	if (IS_ERR(r->folio) || !folio_test_uptodate(r->folio)) {
-		if (!IS_ERR(r->folio))
-			folio_put(r->folio);
-		r->folio = NULL;
-		return -EFAULT;
-	}
-
-	r->folio_off = folio_pos(r->folio);
-	r->addr = kmap_local_folio(r->folio, 0);
-
-	return 0;
-}
-
-static const void *freader_fetch(struct freader *r, loff_t file_off, size_t sz)
-{
-	size_t folio_sz;
-
-	/* provided internal temporary buffer should be sized correctly */
-	if (WARN_ON(r->buf && sz > r->buf_sz)) {
-		r->err = -E2BIG;
-		return NULL;
-	}
-
-	if (unlikely(file_off + sz < file_off)) {
-		r->err = -EOVERFLOW;
-		return NULL;
-	}
-
-	/* working with memory buffer is much more straightforward */
-	if (!r->buf) {
-		if (file_off + sz > r->data_sz) {
-			r->err = -ERANGE;
-			return NULL;
-		}
-		return r->data + file_off;
-	}
-
-	/* fetch or reuse folio for given file offset */
-	r->err = freader_get_folio(r, file_off);
-	if (r->err)
-		return NULL;
-
-	/* if requested data is crossing folio boundaries, we have to copy
-	 * everything into our local buffer to keep a simple linear memory
-	 * access interface
-	 */
-	folio_sz = folio_size(r->folio);
-	if (file_off + sz > r->folio_off + folio_sz) {
-		int part_sz = r->folio_off + folio_sz - file_off;
-
-		/* copy the part that resides in the current folio */
-		memcpy(r->buf, r->addr + (file_off - r->folio_off), part_sz);
-
-		/* fetch next folio */
-		r->err = freader_get_folio(r, r->folio_off + folio_sz);
-		if (r->err)
-			return NULL;
-
-		/* copy the rest of requested data */
-		memcpy(r->buf + part_sz, r->addr, sz - part_sz);
-
-		return r->buf;
-	}
-
-	/* if data fits in a single folio, just return direct pointer */
-	return r->addr + (file_off - r->folio_off);
-}
-
-static void freader_cleanup(struct freader *r)
-{
-	if (!r->buf)
-		return; /* non-file-backed mode */
-
-	freader_put_folio(r);
-}
-
 /*
  * Parse build id from the note segment. This logic can be shared between
  * 32-bit and 64-bit system, because Elf32_Nhdr and Elf64_Nhdr are
diff --git a/lib/freader.c b/lib/freader.c
new file mode 100644
index 000000000000..32a17d137b32
--- /dev/null
+++ b/lib/freader.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/freader.h>
+#include <linux/cache.h>
+#include <linux/elf.h>
+#include <linux/kernel.h>
+#include <linux/pagemap.h>
+#include <linux/secretmem.h>
+
+void freader_init_from_file(struct freader *r, void *buf, u32 buf_sz,
+			    struct file *file, bool may_fault)
+{
+	memset(r, 0, sizeof(*r));
+	r->buf = buf;
+	r->buf_sz = buf_sz;
+	r->file = file;
+	r->may_fault = may_fault;
+}
+
+void freader_init_from_mem(struct freader *r, const char *data, u64 data_sz)
+{
+	memset(r, 0, sizeof(*r));
+	r->data = data;
+	r->data_sz = data_sz;
+}
+
+static void freader_put_folio(struct freader *r)
+{
+	if (!r->folio)
+		return;
+	kunmap_local(r->addr);
+	folio_put(r->folio);
+	r->folio = NULL;
+}
+
+static int freader_get_folio(struct freader *r, loff_t file_off)
+{
+	/* check if we can just reuse current folio */
+	if (r->folio && file_off >= r->folio_off &&
+	    file_off < r->folio_off + folio_size(r->folio))
+		return 0;
+
+	freader_put_folio(r);
+
+	/* reject secretmem folios created with memfd_secret() */
+	if (secretmem_mapping(r->file->f_mapping))
+		return -EFAULT;
+
+	r->folio = filemap_get_folio(r->file->f_mapping, file_off >> PAGE_SHIFT);
+
+	/* if sleeping is allowed, wait for the page, if necessary */
+	if (r->may_fault && (IS_ERR(r->folio) || !folio_test_uptodate(r->folio))) {
+		filemap_invalidate_lock_shared(r->file->f_mapping);
+		r->folio = read_cache_folio(r->file->f_mapping, file_off >> PAGE_SHIFT,
+					    NULL, r->file);
+		filemap_invalidate_unlock_shared(r->file->f_mapping);
+	}
+
+	if (IS_ERR(r->folio) || !folio_test_uptodate(r->folio)) {
+		if (!IS_ERR(r->folio))
+			folio_put(r->folio);
+		r->folio = NULL;
+		return -EFAULT;
+	}
+
+	r->folio_off = folio_pos(r->folio);
+	r->addr = kmap_local_folio(r->folio, 0);
+
+	return 0;
+}
+
+const void *freader_fetch(struct freader *r, loff_t file_off, size_t sz)
+{
+	size_t folio_sz;
+
+	/* provided internal temporary buffer should be sized correctly */
+	if (WARN_ON(r->buf && sz > r->buf_sz)) {
+		r->err = -E2BIG;
+		return NULL;
+	}
+
+	if (unlikely(file_off + sz < file_off)) {
+		r->err = -EOVERFLOW;
+		return NULL;
+	}
+
+	/* working with memory buffer is much more straightforward */
+	if (!r->buf) {
+		if (file_off + sz > r->data_sz) {
+			r->err = -ERANGE;
+			return NULL;
+		}
+		return r->data + file_off;
+	}
+
+	/* fetch or reuse folio for given file offset */
+	r->err = freader_get_folio(r, file_off);
+	if (r->err)
+		return NULL;
+
+	/* if requested data is crossing folio boundaries, we have to copy
+	 * everything into our local buffer to keep a simple linear memory
+	 * access interface
+	 */
+	folio_sz = folio_size(r->folio);
+	if (file_off + sz > r->folio_off + folio_sz) {
+		int part_sz = r->folio_off + folio_sz - file_off;
+
+		/* copy the part that resides in the current folio */
+		memcpy(r->buf, r->addr + (file_off - r->folio_off), part_sz);
+
+		/* fetch next folio */
+		r->err = freader_get_folio(r, r->folio_off + folio_sz);
+		if (r->err)
+			return NULL;
+
+		/* copy the rest of requested data */
+		memcpy(r->buf + part_sz, r->addr, sz - part_sz);
+
+		return r->buf;
+	}
+
+	/* if data fits in a single folio, just return direct pointer */
+	return r->addr + (file_off - r->folio_off);
+}
+
+void freader_cleanup(struct freader *r)
+{
+	if (!r->buf)
+		return; /* non-file-backed mode */
+
+	freader_put_folio(r);
+}
-- 
2.51.0


