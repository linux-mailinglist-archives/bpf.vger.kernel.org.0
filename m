Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA4842DBCA
	for <lists+bpf@lfdr.de>; Thu, 14 Oct 2021 16:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhJNOhH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Oct 2021 10:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbhJNOhG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Oct 2021 10:37:06 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC11C061570
        for <bpf@vger.kernel.org>; Thu, 14 Oct 2021 07:35:01 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r10so20085394wra.12
        for <bpf@vger.kernel.org>; Thu, 14 Oct 2021 07:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yUU1GvrRd41KtND7k0YFbBqZ4IbM7SfwZfPHgulYfvc=;
        b=bP1MVtAe0NbNumsdh1wyOFUTmaodnUnncipuqpLyKwuIxaxP7gTgaNqBD2X9sk3R2+
         qg4ZCYRJvJF7xOhUJbP31t86pn6p7/HIu3FpvgN2lvWDbZudUBPetffZE/nGn639SeFk
         uruo+EsG4IP5gZaAJQYViSI+/IQOmOcnq1IA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yUU1GvrRd41KtND7k0YFbBqZ4IbM7SfwZfPHgulYfvc=;
        b=08I09YO+q9dCYOTBAQOCh/IK9P7NxjYVJRkBcs2R95UkNfd5mZ9NZjTn73I7FFS5l0
         aexHAgl7T8yf9VOGK38pHyYDivbanRVFv91+0s0jSw1v+vTLZuybQ23E8pmN87pGDwGj
         zPfnPbdaFUNQW1OU78B0S14pZWHH9U6Yy45Vl0N3K5iBZBukhbjXtafBPnNqvzc8ljnD
         3UKrJyQPuTxlqFKOgj0MXOTXdRG5x7hs3ZX0LFcobdTKyFKqSjVgMeaeZZUBfqm5QZ6b
         PUA2FqDEh4xpFISNVv4acaGqjZjdlU6SoqjY41Vl5twmReyThwWSjZDgo0b7dY0VZSK1
         k1Bw==
X-Gm-Message-State: AOAM533R8+dSl2688aN2C3T91HoKtIsXwSCWZeN04kX97YhDxLOPyGUq
        EMjAE3xbdxha+tK9O3h5IhsMLA==
X-Google-Smtp-Source: ABdhPJxmZ26B7P8I9SosXjcdkZTcRmC/RuOg1SuEfkNJImJrMwhC3IouhR2VgiibuK24vvuCI2eRew==
X-Received: by 2002:a5d:63ca:: with SMTP id c10mr7003238wrw.407.1634222099773;
        Thu, 14 Oct 2021 07:34:59 -0700 (PDT)
Received: from antares.. (4.4.a.7.5.8.b.d.d.b.6.7.4.d.a.6.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:6ad4:76bd:db85:7a44])
        by smtp.gmail.com with ESMTPSA id k6sm2656439wri.83.2021.10.14.07.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 07:34:59 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [RFC 6/9] bpf: split map modification structs
Date:   Thu, 14 Oct 2021 15:34:31 +0100
Message-Id: <20211014143436.54470-8-lmb@cloudflare.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211014143436.54470-1-lmb@cloudflare.com>
References: <20211014143436.54470-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

---
 include/uapi/linux/bpf.h | 51 +++++++++++++++++++++++------
 kernel/bpf/syscall.c     | 70 ++++++++++++++++------------------------
 2 files changed, 70 insertions(+), 51 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index f1c163778d7a..d3acd12d98c1 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1294,18 +1294,41 @@ struct bpf_map_create_attr {
 						 */
 };
 
+struct bpf_map_lookup_elem_attr {
+	__u32 map_fd;
+	__bpf_md_ptr(const void *, key);
+	__bpf_md_ptr(void *, value);
+	__u64 flags;
+};
+
+struct bpf_map_update_elem_attr {
+	__u32 map_fd;
+	__bpf_md_ptr(const void *, key);
+	__bpf_md_ptr(void *, value);
+	__u64 flags;
+};
+
+struct bpf_map_delete_elem_attr {
+	__u32 map_fd;
+	__bpf_md_ptr(const void *, key);
+};
+
+struct bpf_map_get_next_key_attr {
+	__u32 map_fd;
+	__bpf_md_ptr(const void *, key);
+	__bpf_md_ptr(void *, next_key);
+};
+
 union bpf_attr {
 	struct bpf_map_create_attr map_create;
 
-	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
-		__u32		map_fd;
-		__aligned_u64	key;
-		union {
-			__aligned_u64 value;
-			__aligned_u64 next_key;
-		};
-		__u64		flags;
-	};
+	struct bpf_map_lookup_elem_attr map_lookup_elem;
+
+	struct bpf_map_update_elem_attr map_update_elem;
+
+	struct bpf_map_delete_elem_attr map_delete_elem;
+
+	struct bpf_map_get_next_key_attr map_get_next_key;
 
 	struct { /* struct used by BPF_MAP_*_BATCH commands */
 		__aligned_u64	in_batch;	/* start batch,
@@ -1524,6 +1547,16 @@ union bpf_attr {
 		__u32	btf_value_type_id;
 		__u32	btf_vmlinux_value_type_id;
 	};
+
+	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
+		__u32		map_fd;
+		__aligned_u64	key;
+		union {
+			__aligned_u64 value;
+			__aligned_u64 next_key;
+		};
+		__u64		flags;
+	};
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index f7b57877acd2..c4aecdbb390e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -728,6 +728,11 @@ int bpf_get_file_flag(int flags)
 		__tmp; \
 	})
 
+#define CHECK_ATTR_TAIL(attr, field) \
+	(memchr_inv((void *)(attr) + offsetofend(typeof(*attr), field), 0, \
+		    sizeof(*(attr)) - offsetofend(typeof(*attr), field)) != NULL ? -EINVAL : 0)
+
+
 /* dst and src must have at least "size" number of bytes.
  * Return strlen on success and < 0 on error.
  */
@@ -1041,23 +1046,17 @@ static void *___bpf_copy_key(bpfptr_t ukey, u64 key_size)
 	return NULL;
 }
 
-/* last field in 'union bpf_attr' used by this command */
-#define BPF_MAP_LOOKUP_ELEM_LAST_FIELD flags
-
-static int map_lookup_elem(union bpf_attr *attr)
+static int map_lookup_elem(struct bpf_map_lookup_elem_attr *attr)
 {
-	void __user *ukey = u64_to_user_ptr(attr->key);
-	void __user *uvalue = u64_to_user_ptr(attr->value);
-	int ufd = attr->map_fd;
+	void __user *ukey = u64_to_user_ptr(attr->key_u64);
+	void __user *uvalue = u64_to_user_ptr(attr->value_u64);
+	int ufd = attr->fd;
 	struct bpf_map *map;
 	void *key, *value;
 	u32 value_size;
 	struct fd f;
 	int err;
 
-	if (CHECK_ATTR(BPF_MAP_LOOKUP_ELEM))
-		return -EINVAL;
-
 	if (attr->flags & ~BPF_F_LOCK)
 		return -EINVAL;
 
@@ -1108,23 +1107,17 @@ static int map_lookup_elem(union bpf_attr *attr)
 	return err;
 }
 
-
-#define BPF_MAP_UPDATE_ELEM_LAST_FIELD flags
-
-static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
+static int map_update_elem(struct bpf_map_update_elem_attr *attr, bpfptr_t uattr)
 {
-	bpfptr_t ukey = make_bpfptr(attr->key, uattr.is_kernel);
-	bpfptr_t uvalue = make_bpfptr(attr->value, uattr.is_kernel);
-	int ufd = attr->map_fd;
+	bpfptr_t ukey = make_bpfptr(attr->key_u64, uattr.is_kernel);
+	bpfptr_t uvalue = make_bpfptr(attr->value_u64, uattr.is_kernel);
+	int ufd = attr->fd;
 	struct bpf_map *map;
 	void *key, *value;
 	u32 value_size;
 	struct fd f;
 	int err;
 
-	if (CHECK_ATTR(BPF_MAP_UPDATE_ELEM))
-		return -EINVAL;
-
 	f = fdget(ufd);
 	map = __bpf_map_get(f);
 	if (IS_ERR(map))
@@ -1168,20 +1161,15 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 	return err;
 }
 
-#define BPF_MAP_DELETE_ELEM_LAST_FIELD key
-
-static int map_delete_elem(union bpf_attr *attr)
+static int map_delete_elem(struct bpf_map_delete_elem_attr *attr)
 {
-	void __user *ukey = u64_to_user_ptr(attr->key);
-	int ufd = attr->map_fd;
+	void __user *ukey = u64_to_user_ptr(attr->key_u64);
+	int ufd = attr->fd;
 	struct bpf_map *map;
 	struct fd f;
 	void *key;
 	int err;
 
-	if (CHECK_ATTR(BPF_MAP_DELETE_ELEM))
-		return -EINVAL;
-
 	f = fdget(ufd);
 	map = __bpf_map_get(f);
 	if (IS_ERR(map))
@@ -1220,22 +1208,16 @@ static int map_delete_elem(union bpf_attr *attr)
 	return err;
 }
 
-/* last field in 'union bpf_attr' used by this command */
-#define BPF_MAP_GET_NEXT_KEY_LAST_FIELD next_key
-
-static int map_get_next_key(union bpf_attr *attr)
+static int map_get_next_key(struct bpf_map_get_next_key_attr *attr)
 {
-	void __user *ukey = u64_to_user_ptr(attr->key);
-	void __user *unext_key = u64_to_user_ptr(attr->next_key);
-	int ufd = attr->map_fd;
+	void __user *ukey = u64_to_user_ptr(attr->key_u64);
+	void __user *unext_key = u64_to_user_ptr(attr->next_key_u64);
+	int ufd = attr->fd;
 	struct bpf_map *map;
 	void *key, *next_key;
 	struct fd f;
 	int err;
 
-	if (CHECK_ATTR(BPF_MAP_GET_NEXT_KEY))
-		return -EINVAL;
-
 	f = fdget(ufd);
 	map = __bpf_map_get(f);
 	if (IS_ERR(map))
@@ -4578,16 +4560,20 @@ static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
 		err = map_create(ATTR_FIELD(&attr, map_create));
 		break;
 	case BPF_MAP_LOOKUP_ELEM:
-		err = map_lookup_elem(&attr);
+		err = CHECK_ATTR_TAIL(&attr, map_lookup_elem);
+		err = err ?: map_lookup_elem(&attr.map_lookup_elem);
 		break;
 	case BPF_MAP_UPDATE_ELEM:
-		err = map_update_elem(&attr, uattr);
+		err = CHECK_ATTR_TAIL(&attr, map_update_elem);
+		err = err ?: map_update_elem(&attr.map_update_elem, uattr);
 		break;
 	case BPF_MAP_DELETE_ELEM:
-		err = map_delete_elem(&attr);
+		err = CHECK_ATTR_TAIL(&attr, map_delete_elem);
+		err = err ?: map_delete_elem(&attr.map_delete_elem);
 		break;
 	case BPF_MAP_GET_NEXT_KEY:
-		err = map_get_next_key(&attr);
+		err = CHECK_ATTR_TAIL(&attr, map_get_next_key);
+		err = err ?: map_get_next_key(&attr.map_get_next_key);
 		break;
 	case BPF_MAP_FREEZE:
 		err = map_freeze(&attr);
-- 
2.30.2

