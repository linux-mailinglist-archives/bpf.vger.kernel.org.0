Return-Path: <bpf+bounces-60924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45106ADEDDF
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 15:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5A367AA529
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 13:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE94414EC5B;
	Wed, 18 Jun 2025 13:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e3Mf10FT"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6648B2E9730
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 13:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750253572; cv=none; b=Le2s8kKAqKoFdtww7ot2BIwRRRRwGhIOINs4ciVgxdIQTTmONO8Jag8GAtdzmTYmp1txwQB4lxzkdBDOxwZt9MHclYfMvF3iC7prwl1ntM+epi+QDWT6404b4GEBswOrBum50nvI+8naTVzhnZFqwPih7gWAy9Ttiw05R3+erL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750253572; c=relaxed/simple;
	bh=VryLg8QIpCCiXWsUr6V0rI60TAfTmgQNLvvojD90p4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJOP+GJeBRPz1o6e0qNsOnVmuZ9U3KarbZq4fPQTW3mQ60BODaO9gnFHe6KjeMb1OsRLoU8CzlahDixzSfBdjkGgBFFbZcjHERmE856c0d0JYcxoXwJKQbOFsdrOsWUKuTcjSBKko4KkpIuSgHtpfmaqEsF74InSetguPxJrFaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e3Mf10FT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750253569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WC90qhcVw+LthRGUO/7JwkaSn5ActJf9qYe8MASw6Qk=;
	b=e3Mf10FTbpkRGGibo8r1k6vp7ZbAZPgN6XSKHghYOkr3esswR9eNSbp8ctW486gz9VVOF4
	rPnJomZqtXhIHSV0N6z/LKFilwgNuT7scAY7BkCjyoJyFUwK/OG44BxexPY3umYaJEdkuK
	iaS7jXvaWTGmMVdqKAq1L4tc1+9kWOU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-p4ywk0VuOKW4GzxnPmHe5w-1; Wed,
 18 Jun 2025 09:32:46 -0400
X-MC-Unique: p4ywk0VuOKW4GzxnPmHe5w-1
X-Mimecast-MFC-AGG-ID: p4ywk0VuOKW4GzxnPmHe5w_1750253565
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E099219560A7;
	Wed, 18 Jun 2025 13:32:44 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.226.177])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 46BB819560AF;
	Wed, 18 Jun 2025 13:32:40 +0000 (UTC)
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
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next v5 2/4] bpf: Add kfuncs for read-only string operations
Date: Wed, 18 Jun 2025 15:32:20 +0200
Message-ID: <0f7ca2fa042f5f6ade0044068169b46ad7fb8ee1.1750252029.git.vmalik@redhat.com>
In-Reply-To: <cover.1750252029.git.vmalik@redhat.com>
References: <cover.1750252029.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

String operations are commonly used so this exposes the most common ones
to BPF programs. For now, we limit ourselves to operations which do not
copy memory around.

Unfortunately, most in-kernel implementations assume that strings are
%NUL-terminated, which is not necessarily true, and therefore we cannot
use them directly in the BPF context. Instead, we open-code them using
__get_kernel_nofault instead of plain dereference to make them safe and
limit the strings length to XATTR_SIZE_MAX to make sure the functions
terminate. When __get_kernel_nofault fails, functions return -EFAULT.
Similarly, when the size bound is reached, the functions return -E2BIG.
In addition, we return -ERANGE when the passed strings are outside of
the kernel address space.

Note that thanks to these dynamic safety checks, no other constraints
are put on the kfunc args (they are marked with the "__ign" suffix to
skip any verifier checks for them).

All of the functions return integers, including functions which normally
(in kernel or libc) return pointers to the strings. The reason is that
since the strings are generally treated as unsafe, the pointers couldn't
be dereferenced anyways. So, instead, we return an index to the string
and let user decide what to do with it. This also nicely fits with
returning various error codes when necessary (see above).

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 kernel/bpf/helpers.c | 389 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 389 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b71e428ad936..d32175dc89bd 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -24,6 +24,7 @@
 #include <linux/bpf_mem_alloc.h>
 #include <linux/kasan.h>
 #include <linux/bpf_verifier.h>
+#include <linux/uaccess.h>
 
 #include "../../lib/kstrtox.h"
 
@@ -3278,6 +3279,383 @@ __bpf_kfunc void __bpf_trap(void)
 {
 }
 
+/* Kfuncs for string operations.
+ *
+ * Since strings are not necessarily %NUL-terminated, we cannot directly call
+ * in-kernel implementations. Instead, we open-code the implementations using
+ * __get_kernel_nofault instead of plain dereference to make them safe.
+ */
+
+/**
+ * bpf_strcmp - Compare two strings
+ * @s1__ign: One string
+ * @s2__ign: Another string
+ *
+ * Return:
+ * * %0       - Strings are equal
+ * * %-1      - @s1__ign is smaller
+ * * %1       - @s2__ign is smaller
+ * * %-EFAULT - Cannot read one of the strings
+ * * %-E2BIG  - One of strings is too large
+ * * %-ERANGE - One of strings is outside of kernel address space
+ */
+__bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
+{
+	char c1, c2;
+	int i;
+
+	if (!copy_from_kernel_nofault_allowed(s1__ign, 1) ||
+	    !copy_from_kernel_nofault_allowed(s2__ign, 1)) {
+		return -ERANGE;
+	}
+
+	guard(pagefault)();
+	for (i = 0; i < XATTR_SIZE_MAX; i++) {
+		__get_kernel_nofault(&c1, s1__ign, char, err_out);
+		__get_kernel_nofault(&c2, s2__ign, char, err_out);
+		if (c1 != c2)
+			return c1 < c2 ? -1 : 1;
+		if (c1 == '\0')
+			return 0;
+		s1__ign++;
+		s2__ign++;
+	}
+	return -E2BIG;
+err_out:
+	return -EFAULT;
+}
+
+/**
+ * bpf_strnchr - Find a character in a length limited string
+ * @s__ign: The string to be searched
+ * @count: The number of characters to be searched
+ * @c: The character to search for
+ *
+ * Note that the %NUL-terminator is considered part of the string, and can
+ * be searched for.
+ *
+ * Return:
+ * * >=0      - Index of the first occurrence of @c within @s__ign
+ * * %-1      - @c not found in the first @count characters of @s__ign
+ * * %-EFAULT - Cannot read @s__ign
+ * * %-E2BIG  - @s__ign is too large
+ * * %-ERANGE - @s__ign is outside of kernel address space
+ */
+__bpf_kfunc int bpf_strnchr(const char *s__ign, size_t count, char c)
+{
+	char sc;
+	int i;
+
+	if (!copy_from_kernel_nofault_allowed(s__ign, 1))
+		return -ERANGE;
+
+	guard(pagefault)();
+	for (i = 0; i < count && i < XATTR_SIZE_MAX; i++) {
+		__get_kernel_nofault(&sc, s__ign, char, err_out);
+		if (sc == c)
+			return i;
+		if (sc == '\0')
+			return -1;
+		s__ign++;
+	}
+	return i == XATTR_SIZE_MAX ? -E2BIG : -1;
+err_out:
+	return -EFAULT;
+}
+
+/**
+ * bpf_strchr - Find the first occurrence of a character in a string
+ * @s__ign: The string to be searched
+ * @c: The character to search for
+ *
+ * Note that the %NUL-terminator is considered part of the string, and can
+ * be searched for.
+ *
+ * Return:
+ * * >=0      - The index of the first occurrence of @c within @s__ign
+ * * -1       - @c not found in @s__ign
+ * * %-EFAULT - Cannot read @s__ign
+ * * %-E2BIG  - @s__ign is too large
+ * * %-ERANGE - @s__ign is outside of kernel address space
+ */
+__bpf_kfunc int bpf_strchr(const char *s__ign, char c)
+{
+	return bpf_strnchr(s__ign, XATTR_SIZE_MAX, c);
+}
+
+/**
+ * bpf_strchrnul - Find and return a character in a string, or end of string
+ * @s__ign: The string to be searched
+ * @c: The character to search for
+ *
+ * Return:
+ * * >=0      - Index of the first occurrence of @c within @s__ign or index of
+ *              the null byte at the end of @s__ign when @c is not found
+ * * %-EFAULT - Cannot read @s__ign
+ * * %-E2BIG  - @s__ign is too large
+ * * %-ERANGE - @s__ign is outside of kernel address space
+ */
+__bpf_kfunc int bpf_strchrnul(const char *s__ign, char c)
+{
+	char sc;
+	int i;
+
+	if (!copy_from_kernel_nofault_allowed(s__ign, 1))
+		return -ERANGE;
+
+	guard(pagefault)();
+	for (i = 0; i < XATTR_SIZE_MAX; i++) {
+		__get_kernel_nofault(&sc, s__ign, char, err_out);
+		if (sc == '\0' || sc == c)
+			return i;
+		s__ign++;
+	}
+	return -E2BIG;
+err_out:
+	return -EFAULT;
+}
+
+/**
+ * bpf_strrchr - Find the last occurrence of a character in a string
+ * @s__ign: The string to be searched
+ * @c: The character to search for
+ *
+ * Return:
+ * * >=0      - Index of the last occurrence of @c within @s__ign
+ * * %-1      - @c not found in @s__ign
+ * * %-EFAULT - Cannot read @s__ign
+ * * %-E2BIG  - @s__ign is too large
+ * * %-ERANGE - @s__ign is outside of kernel address space
+ */
+__bpf_kfunc int bpf_strrchr(const char *s__ign, int c)
+{
+	char sc;
+	int i, last = -1;
+
+	if (!copy_from_kernel_nofault_allowed(s__ign, 1))
+		return -ERANGE;
+
+	guard(pagefault)();
+	for (i = 0; i < XATTR_SIZE_MAX; i++) {
+		__get_kernel_nofault(&sc, s__ign, char, err_out);
+		if (sc == '\0')
+			return last;
+		if (sc == c)
+			last = i;
+		s__ign++;
+	}
+	return -E2BIG;
+err_out:
+	return -EFAULT;
+}
+
+/**
+ * bpf_strlen - Calculate the length of a length-limited string
+ * @s__ign: The string
+ * @count: The maximum number of characters to count
+ *
+ * Return:
+ * * >=0      - The length of @s__ign
+ * * %-EFAULT - Cannot read @s__ign
+ * * %-E2BIG  - @s__ign is too large
+ * * %-ERANGE - @s__ign is outside of kernel address space
+ */
+__bpf_kfunc int bpf_strnlen(const char *s__ign, size_t count)
+{
+	char c;
+	int i;
+
+	if (!copy_from_kernel_nofault_allowed(s__ign, 1))
+		return -ERANGE;
+
+	guard(pagefault)();
+	for (i = 0; i < count && i < XATTR_SIZE_MAX; i++) {
+		__get_kernel_nofault(&c, s__ign, char, err_out);
+		if (c == '\0')
+			return i;
+		s__ign++;
+	}
+	return i == XATTR_SIZE_MAX ? -E2BIG : i;
+err_out:
+	return -EFAULT;
+}
+
+/**
+ * bpf_strlen - Calculate the length of a string
+ * @s__ign: The string
+ *
+ * Return:
+ * * >=0      - The length of @s__ign
+ * * %-EFAULT - Cannot read @s__ign
+ * * %-E2BIG  - @s__ign is too large
+ * * %-ERANGE - @s__ign is outside of kernel address space
+ */
+__bpf_kfunc int bpf_strlen(const char *s__ign)
+{
+	return bpf_strnlen(s__ign, XATTR_SIZE_MAX);
+}
+
+/**
+ * bpf_strspn - Calculate the length of the initial substring of @s__ign which
+ *              only contains letters in @accept__ign
+ * @s__ign: The string to be searched
+ * @accept__ign: The string to search for
+ *
+ * Return:
+ * * >=0      - The length of the initial substring of @s__ign which only
+ *              contains letters from @accept__ign
+ * * %-EFAULT - Cannot read one of the strings
+ * * %-E2BIG  - One of the strings is too large
+ * * %-ERANGE - One of the strings is outside of kernel address space
+ */
+__bpf_kfunc int bpf_strspn(const char *s__ign, const char *accept__ign)
+{
+	char cs, ca;
+	bool found;
+	int i, j;
+
+	if (!copy_from_kernel_nofault_allowed(s__ign, 1) ||
+	    !copy_from_kernel_nofault_allowed(accept__ign, 1)) {
+		return -ERANGE;
+	}
+
+	guard(pagefault)();
+	for (i = 0; i < XATTR_SIZE_MAX; i++) {
+		__get_kernel_nofault(&cs, s__ign, char, err_out);
+		if (cs == '\0')
+			return i;
+		found = false;
+		for (j = 0; j < XATTR_SIZE_MAX; j++) {
+			__get_kernel_nofault(&ca, accept__ign + j, char, err_out);
+			if (cs == ca) {
+				found = true;
+				break;
+			}
+			if (ca == '\0')
+				break;
+		}
+		if (!found)
+			return i;
+		s__ign++;
+	}
+	return -E2BIG;
+err_out:
+	return -EFAULT;
+}
+
+/**
+ * strcspn - Calculate the length of the initial substring of @s__ign which
+ *           does not contain letters in @reject__ign
+ * @s__ign: The string to be searched
+ * @reject__ign: The string to search for
+ *
+ * Return:
+ * * >=0      - The length of the initial substring of @s__ign which does not
+ *              contain letters from @reject__ign
+ * * %-EFAULT - Cannot read one of the strings
+ * * %-E2BIG  - One of the strings is too large
+ * * %-ERANGE - One of the strings is outside of kernel address space
+ */
+__bpf_kfunc int bpf_strcspn(const char *s__ign, const char *reject__ign)
+{
+	char cs, cr;
+	bool found;
+	int i, j;
+
+	if (!copy_from_kernel_nofault_allowed(s__ign, 1) ||
+	    !copy_from_kernel_nofault_allowed(reject__ign, 1)) {
+		return -ERANGE;
+	}
+
+	guard(pagefault)();
+	for (i = 0; i < XATTR_SIZE_MAX; i++) {
+		__get_kernel_nofault(&cs, s__ign, char, err_out);
+		if (cs == '\0')
+			return i;
+		found = false;
+		for (j = 0; j < XATTR_SIZE_MAX; j++) {
+			__get_kernel_nofault(&cr, reject__ign + j, char, err_out);
+			if (cs == cr) {
+				found = true;
+				break;
+			}
+			if (cr == '\0')
+				break;
+		}
+		if (found)
+			return i;
+		s__ign++;
+	}
+	return -E2BIG;
+err_out:
+	return -EFAULT;
+}
+
+/**
+ * bpf_strnstr - Find the first substring in a length-limited string
+ * @s1__ign: The string to be searched
+ * @s2__ign: The string to search for
+ * @len: the maximum number of characters to search
+ *
+ * Return:
+ * * >=0      - Index of the first character of the first occurrence of @s2__ign
+ *              within the first @len characters of @s1__ign
+ * * %-1      - @s2__ign not found in the first @len characters of @s1__ign
+ * * %-EFAULT - Cannot read one of the strings
+ * * %-E2BIG  - One of the strings is too large
+ * * %-ERANGE - One of the strings is outside of kernel address space
+ */
+__bpf_kfunc int bpf_strnstr(const char *s1__ign, const char *s2__ign, size_t len)
+{
+	char c1, c2;
+	int i, j;
+
+	if (!copy_from_kernel_nofault_allowed(s1__ign, 1) ||
+	    !copy_from_kernel_nofault_allowed(s2__ign, 1)) {
+		return -ERANGE;
+	}
+
+	guard(pagefault)();
+	for (i = 0; i < XATTR_SIZE_MAX; i++) {
+		for (j = 0; i + j < len && j < XATTR_SIZE_MAX; j++) {
+			__get_kernel_nofault(&c1, s1__ign + j, char, err_out);
+			__get_kernel_nofault(&c2, s2__ign + j, char, err_out);
+			if (c2 == '\0')
+				return i;
+			if (c1 == '\0')
+				return -1;
+			if (c1 != c2)
+				break;
+		}
+		if (j == XATTR_SIZE_MAX)
+			return -E2BIG;
+		if (i + j == len)
+			return -1;
+		s1__ign++;
+	}
+	return -E2BIG;
+err_out:
+	return -EFAULT;
+}
+
+/**
+ * bpf_strstr - Find the first substring in a string
+ * @s1__ign: The string to be searched
+ * @s2__ign: The string to search for
+ *
+ * Return:
+ * * >=0      - Index of the first character of the first occurrence of @s2__ign
+ *              within @s1__ign
+ * * %-1      - @s2__ign is not a substring of @s1__ign
+ * * %-EFAULT - Cannot read one of the strings
+ * * %-E2BIG  - One of the strings is too large
+ * * %-ERANGE - One of the strings is outside of kernel address space
+ */
+__bpf_kfunc int bpf_strstr(const char *s1__ign, const char *s2__ign)
+{
+	return bpf_strnstr(s1__ign, s2__ign, XATTR_SIZE_MAX);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(generic_btf_ids)
@@ -3397,6 +3775,17 @@ BTF_ID_FLAGS(func, bpf_iter_dmabuf_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPAB
 BTF_ID_FLAGS(func, bpf_iter_dmabuf_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 #endif
 BTF_ID_FLAGS(func, __bpf_trap)
+BTF_ID_FLAGS(func, bpf_strcmp);
+BTF_ID_FLAGS(func, bpf_strchr);
+BTF_ID_FLAGS(func, bpf_strchrnul);
+BTF_ID_FLAGS(func, bpf_strnchr);
+BTF_ID_FLAGS(func, bpf_strrchr);
+BTF_ID_FLAGS(func, bpf_strlen);
+BTF_ID_FLAGS(func, bpf_strnlen);
+BTF_ID_FLAGS(func, bpf_strspn);
+BTF_ID_FLAGS(func, bpf_strcspn);
+BTF_ID_FLAGS(func, bpf_strstr);
+BTF_ID_FLAGS(func, bpf_strnstr);
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
-- 
2.49.0


