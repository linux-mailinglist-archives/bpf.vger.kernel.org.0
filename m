Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6723942DBCD
	for <lists+bpf@lfdr.de>; Thu, 14 Oct 2021 16:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbhJNOhJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Oct 2021 10:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbhJNOhI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Oct 2021 10:37:08 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9EEC061570
        for <bpf@vger.kernel.org>; Thu, 14 Oct 2021 07:35:03 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id o20so20242715wro.3
        for <bpf@vger.kernel.org>; Thu, 14 Oct 2021 07:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=opoBnFcqL36uT+TVFOfrR+y12LkFgOJUSw8ohzVT8iM=;
        b=gA7vsQXnaqNPzm7kh3z1BTeb9Eo7QImztDY1DaamgIeuoyXBXniJEIqE8nR42oBZr1
         OeCmcgHKRiuA1nTV37EsDIvZTAdZEQHECFUS8GdI0PLSeE4eZBA8t6zY82v/FR/YRP55
         kiftHjyVImigeAQ9nWw0FriXll6h8hh5I0vzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=opoBnFcqL36uT+TVFOfrR+y12LkFgOJUSw8ohzVT8iM=;
        b=LFEbyA5soeJPnz0BQ0nMrrg0g5OTwrwU1SG9kEkSlVNIGqORf/Q7LICmJgF6pb7vqy
         3N7x2jj1+0PmBdZCc30SMra2zOgTmzGGw0ewxDblePHwFNjL2pPWcu7ftULpDQYg8LCN
         TjC3984CNbBG7wbuqTwS47g4LW+5+vz08bPONLsRCBMZ4Y/gwTnPWukDvMhaORFzsA0U
         b21L6c0zTDHTmrLkuvhXbk6yASD+WX62FaCZ/e4W2yS2JR2MEZd+SfBjaCYCmLJ6U2E3
         pPaLBLUJJ3mg+BMbsITGryW7vvNP4HDJ7AOh015ZKxA9Dbh9I/HhkTFT+LUnLQuHisE+
         keRA==
X-Gm-Message-State: AOAM530E1lWuqSAaJvF19/icp2vX7tCE7YfAUUMPfxCepJygsJ1/qHu+
        O7a6MEZkQ08Hu2LFtf+CvXy0Ew==
X-Google-Smtp-Source: ABdhPJy03oRvTP3q5CDvHIgP3Ti62TY9AC/TV5EddxQjQxbucYpiHSD54EOJrs+BioCyqyg0ev/bYg==
X-Received: by 2002:a05:6000:1b90:: with SMTP id r16mr7241038wru.250.1634222102348;
        Thu, 14 Oct 2021 07:35:02 -0700 (PDT)
Received: from antares.. (4.4.a.7.5.8.b.d.d.b.6.7.4.d.a.6.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:6ad4:76bd:db85:7a44])
        by smtp.gmail.com with ESMTPSA id k6sm2656439wri.83.2021.10.14.07.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 07:35:01 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [RFC 7/9] bpf: split map modification structs
Date:   Thu, 14 Oct 2021 15:34:34 +0100
Message-Id: <20211014143436.54470-11-lmb@cloudflare.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211014143436.54470-1-lmb@cloudflare.com>
References: <20211014143436.54470-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

---
 include/uapi/linux/bpf.h | 51 +++++++++++++++++++++++++------
 kernel/bpf/syscall.c     | 65 ++++++++++++++--------------------------
 2 files changed, 65 insertions(+), 51 deletions(-)

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
index 337fbd2f1874..f44d888bebb9 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1032,23 +1032,17 @@ static void *___bpf_copy_key(bpfptr_t ukey, u64 key_size)
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
 
@@ -1099,23 +1093,17 @@ static int map_lookup_elem(union bpf_attr *attr)
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
@@ -1159,20 +1147,15 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
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
@@ -1211,22 +1194,16 @@ static int map_delete_elem(union bpf_attr *attr)
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
@@ -4570,16 +4547,20 @@ static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
 		err = err ?: map_create(&attr.map_create);
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

