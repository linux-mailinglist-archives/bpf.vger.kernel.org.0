Return-Path: <bpf+bounces-54608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 362ABA6D9C5
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 13:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44F91188BCA3
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 12:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D182B25E468;
	Mon, 24 Mar 2025 12:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="djLvG/hH"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F70A25E453
	for <bpf@vger.kernel.org>; Mon, 24 Mar 2025 12:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742817840; cv=none; b=ivFbhZc7LH0Y+pXJgBKHRYR4sYW1gZlUbcUd4TeTRSXl2ZBjt5VENxg46OYujohlET1/o5lAXmCVA+5VpgmGzRZv8EQwokSD8KmVW63IcLQSST/QsncpsKz2LTMM0yqTGfE8SDyxdBt3W5ZZ6SPQaULRlWJKIolDTa7H5PB6u2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742817840; c=relaxed/simple;
	bh=HNx4QiA3rP+FvxfE9dRbmiJkYKBXbF/XAs0/9xBqOuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q4R7IxnaaAwyjhIEKzvO5YZpu/pcWkkh2lOGqNkeVnnHToNbZT9HiLPEBpo4IuCX4+fbg8ESDrR9cGy3TDD7exfEIaXDiRbLlz/rs0Ojr2N+OwJxS7rHpYIEL6Z6nXdrh/pY0hVJPUB+77z87lAyVGxtL4fIjb1a+G8oZwLuSEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=djLvG/hH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742817837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4dAk/rOo8Oi7gPACZuCp1fyOAo9iIAwzKkF4P/VUJEo=;
	b=djLvG/hHeI363RIF4yVtYExC0R7ySAlQUy/IBMBF8vRuHnnSsYySrhf4y9YVPuT5zCym+i
	uUlJu/1nW5K7rTtxR1gTnJ95uOns2fFTF3rtqXr79OvuynLlmVl1xiiV9j8OiHWYgLiag/
	joGjEMkPqaL/Jb9W6kVRO5nQloPd6v4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-VMsNQQTIPFWDBUd-afxuYQ-1; Mon,
 24 Mar 2025 08:03:51 -0400
X-MC-Unique: VMsNQQTIPFWDBUd-afxuYQ-1
X-Mimecast-MFC-AGG-ID: VMsNQQTIPFWDBUd-afxuYQ_1742817828
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0FB221956067;
	Mon, 24 Mar 2025 12:03:48 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.224.25])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7216D180A802;
	Mon, 24 Mar 2025 12:03:42 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next v3 1/3] bpf: Add kfuncs for read-only string operations
Date: Mon, 24 Mar 2025 13:03:28 +0100
Message-ID: <4e26ca57634db305a622b010b0d86dbb36b09c37.1741874348.git.vmalik@redhat.com>
In-Reply-To: <cover.1741874348.git.vmalik@redhat.com>
References: <cover.1741874348.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

String operations are commonly used so this exposes the most common ones
to BPF programs. For now, we limit ourselves to operations which do not
copy memory around.

Unfortunately, most in-kernel implementations assume that strings are
%NUL-terminated, which is not necessarily true, and therefore we cannot
use them directly in BPF context. So, we use distinct approaches for
bounded and unbounded variants of string operations:

- Unbounded variants are open-coded with using __get_kernel_nofault
  instead of plain dereference to make them safe.

- Bounded variants use params with the __sz suffix so safety is assured
  by the verifier and we can use the in-kernel (potentially optimized)
  functions.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 kernel/bpf/helpers.c | 299 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 299 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 5449756ba102..6f6af4289cd0 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2011-2014 PLUMgrid, http://plumgrid.com
  */
+#include "linux/uaccess.h"
 #include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/bpf-cgroup.h>
@@ -3193,6 +3194,291 @@ __bpf_kfunc void bpf_local_irq_restore(unsigned long *flags__irq_flag)
 	local_irq_restore(*flags__irq_flag);
 }
 
+/* Kfuncs for string operations.
+ *
+ * Since strings are not necessarily %NUL-terminated, we cannot directly call
+ * in-kernel implementations. Instead, unbounded variants are open-coded with
+ * using __get_kernel_nofault instead of plain dereference to make them safe.
+ * Bounded variants use params with the __sz suffix so safety is assured by the
+ * verifier and we can use the in-kernel (potentially optimized) functions.
+ */
+
+/**
+ * bpf_strcmp - Compare two strings
+ * @cs: One string
+ * @ct: Another string
+ */
+__bpf_kfunc int bpf_strcmp(const char *cs, const char *ct)
+{
+	int i = 0, ret = 0;
+	char c1, c2;
+
+	pagefault_disable();
+	while (i++ < XATTR_SIZE_MAX) {
+		__get_kernel_nofault(&c1, cs++, char, cs_out);
+		__get_kernel_nofault(&c2, ct++, char, ct_out);
+		if (c1 != c2) {
+			ret = c1 < c2 ? -1 : 1;
+			goto out;
+		}
+		if (!c1)
+			goto out;
+	}
+cs_out:
+	ret = -1;
+	goto out;
+ct_out:
+	ret = 1;
+out:
+	pagefault_enable();
+	return ret;
+}
+
+/**
+ * bpf_strchr - Find the first occurrence of a character in a string
+ * @s: The string to be searched
+ * @c: The character to search for
+ *
+ * Note that the %NUL-terminator is considered part of the string, and can
+ * be searched for.
+ */
+__bpf_kfunc char *bpf_strchr(const char *s, int c)
+{
+	char *ret = NULL;
+	int i = 0;
+	char sc;
+
+	pagefault_disable();
+	while (i++ < XATTR_SIZE_MAX) {
+		__get_kernel_nofault(&sc, s, char, out);
+		if (sc == (char)c) {
+			ret = (char *)s;
+			break;
+		}
+		if (sc == '\0')
+			break;
+		s++;
+	}
+out:
+	pagefault_enable();
+	return ret;
+}
+
+/**
+ * bpf_strchrnul - Find and return a character in a string, or end of string
+ * @s: The string to be searched
+ * @c: The character to search for
+ *
+ * Returns pointer to first occurrence of 'c' in s. If c is not found, then
+ * return a pointer to the null byte at the end of s.
+ */
+__bpf_kfunc char *bpf_strchrnul(const char *s, int c)
+{
+	char *ret = NULL;
+	int i = 0;
+	char sc;
+
+	pagefault_disable();
+	while (i++ < XATTR_SIZE_MAX) {
+		__get_kernel_nofault(&sc, s, char, out);
+		if (sc == '\0' || sc == (char)c) {
+			ret = (char *)s;
+			break;
+		}
+		s++;
+	}
+out:
+	pagefault_enable();
+	return ret;
+}
+
+/**
+ * bpf_strnchr - Find a character in a length limited string
+ * @s: The string to be searched
+ * @s__sz: The number of characters to be searched
+ * @c: The character to search for
+ *
+ * Note that the %NUL-terminator is considered part of the string, and can
+ * be searched for.
+ */
+__bpf_kfunc char *bpf_strnchr(void *s, u32 s__sz, int c)
+{
+	return strnchr(s, s__sz, c);
+}
+
+/**
+ * bpf_strnchrnul - Find and return a character in a length limited string,
+ * or end of string
+ * @s: The string to be searched
+ * @s__sz: The number of characters to be searched
+ * @c: The character to search for
+ *
+ * Returns pointer to the first occurrence of 'c' in s. If c is not found,
+ * then return a pointer to the last character of the string.
+ */
+__bpf_kfunc char *bpf_strnchrnul(void *s, u32 s__sz, int c)
+{
+	return strnchrnul(s, s__sz, c);
+}
+
+/**
+ * bpf_strrchr - Find the last occurrence of a character in a string
+ * @s: The string to be searched
+ * @c: The character to search for
+ */
+__bpf_kfunc char *bpf_strrchr(const char *s, int c)
+{
+	char *ret = NULL;
+	int i = 0;
+	char sc;
+
+	pagefault_disable();
+	while (i++ < XATTR_SIZE_MAX) {
+		__get_kernel_nofault(&sc, s, char, out);
+		if (sc == '\0')
+			break;
+		if (sc == (char)c)
+			ret = (char *)s;
+		s++;
+	}
+out:
+	pagefault_enable();
+	return (char *)ret;
+}
+
+__bpf_kfunc size_t bpf_strlen(const char *s)
+{
+	int i = 0;
+	char c;
+
+	pagefault_disable();
+	while (i < XATTR_SIZE_MAX) {
+		__get_kernel_nofault(&c, s++, char, out);
+		if (c == '\0')
+			break;
+		i++;
+	}
+out:
+	pagefault_enable();
+	return i;
+}
+
+__bpf_kfunc size_t bpf_strnlen(void *s, u32 s__sz)
+{
+	return strnlen(s, s__sz);
+}
+
+/**
+ * bpf_strspn - Calculate the length of the initial substring of @s which only contain letters in @accept
+ * @s: The string to be searched
+ * @accept: The string to search for
+ */
+__bpf_kfunc size_t bpf_strspn(const char *s, const char *accept)
+{
+	int i = 0;
+	char c;
+
+	pagefault_disable();
+	while (i < XATTR_SIZE_MAX) {
+		__get_kernel_nofault(&c, s++, char, out);
+		if (c == '\0' || !bpf_strchr(accept, c))
+			break;
+		i++;
+	}
+out:
+	pagefault_enable();
+	return i;
+}
+
+/**
+ * strcspn - Calculate the length of the initial substring of @s which does not contain letters in @reject
+ * @s: The string to be searched
+ * @reject: The string to avoid
+ */
+__bpf_kfunc size_t bpf_strcspn(const char *s, const char *reject)
+{
+	int i = 0;
+	char c;
+
+	pagefault_disable();
+	while (i < XATTR_SIZE_MAX) {
+		__get_kernel_nofault(&c, s++, char, out);
+		if (c == '\0' || bpf_strchr(reject, c))
+			break;
+		i++;
+	}
+out:
+	pagefault_enable();
+	return i;
+}
+
+/**
+ * bpf_strpbrk - Find the first occurrence of a set of characters
+ * @cs: The string to be searched
+ * @ct: The characters to search for
+ */
+__bpf_kfunc char *bpf_strpbrk(const char *cs, const char *ct)
+{
+	char *ret = NULL;
+	int i = 0;
+	char c;
+
+	pagefault_disable();
+	while (i++ < XATTR_SIZE_MAX) {
+		__get_kernel_nofault(&c, cs, char, out);
+		if (c == '\0')
+			break;
+		if (bpf_strchr(ct, c)) {
+			ret = (char *)cs;
+			break;
+		}
+		cs++;
+	}
+out:
+	pagefault_enable();
+	return ret;
+}
+
+/**
+ * bpf_strstr - Find the first substring in a %NUL terminated string
+ * @s1: The string to be searched
+ * @s2: The string to search for
+ */
+__bpf_kfunc char *bpf_strstr(const char *s1, const char *s2)
+{
+	size_t l1, l2;
+
+	l2 = bpf_strlen(s2);
+	if (!l2)
+		return (char *)s1;
+	l1 = bpf_strlen(s1);
+	while (l1 >= l2) {
+		l1--;
+		if (!memcmp(s1, s2, l2))
+			return (char *)s1;
+		s1++;
+	}
+	return NULL;
+}
+
+/**
+ * bpf_strnstr - Find the first substring in a length-limited string
+ * @s1: The string to be searched
+ * @s1__sz: The size of @s1
+ * @s2: The string to search for
+ * @s2__sz: The size of @s2
+ */
+__bpf_kfunc char *bpf_strnstr(void *s1, u32 s1__sz, void *s2, u32 s2__sz)
+{
+	/* strnstr() uses strlen() to get the length of s2. Since this is not
+	 * safe in BPF context for non-%NUL-terminated strings, use strnlen
+	 * first to make it safe.
+	 */
+	if (strnlen(s2, s2__sz) == s2__sz)
+		return NULL;
+	return strnstr(s1, s2, s1__sz);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(generic_btf_ids)
@@ -3293,6 +3579,19 @@ BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLE
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_local_irq_save)
 BTF_ID_FLAGS(func, bpf_local_irq_restore)
+BTF_ID_FLAGS(func, bpf_strcmp);
+BTF_ID_FLAGS(func, bpf_strchr);
+BTF_ID_FLAGS(func, bpf_strchrnul);
+BTF_ID_FLAGS(func, bpf_strnchr);
+BTF_ID_FLAGS(func, bpf_strnchrnul);
+BTF_ID_FLAGS(func, bpf_strrchr);
+BTF_ID_FLAGS(func, bpf_strlen);
+BTF_ID_FLAGS(func, bpf_strnlen);
+BTF_ID_FLAGS(func, bpf_strspn);
+BTF_ID_FLAGS(func, bpf_strcspn);
+BTF_ID_FLAGS(func, bpf_strpbrk);
+BTF_ID_FLAGS(func, bpf_strstr);
+BTF_ID_FLAGS(func, bpf_strnstr);
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
-- 
2.48.1


