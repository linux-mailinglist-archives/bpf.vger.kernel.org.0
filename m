Return-Path: <bpf+bounces-57636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FD0AAD657
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 08:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 125D43B3C23
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 06:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019F82116F5;
	Wed,  7 May 2025 06:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JJtIuORe"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7C4211491
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 06:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746600083; cv=none; b=EzdHenbfN8EzdwWfT4fuO0WSICNrGoflvP+vvunHAPEeT+n8srTXsaa8r4XT3NRjNWYBuIhzzPMo2EjTweXiXATIO+QWulXg1AHn2jyOtnM5q8nAvcDFpCJcAP12VCrjXF/v0DW74Yzs3FM1sMaNLuVY7zo0hOFvK7Hvr5iGSI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746600083; c=relaxed/simple;
	bh=yKd1/jBduo38jrcc5xiJRvh1YSPYcj6vjr3NaJQi5Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iNV4g4JtXUSN5/uVA53tjE8QcABw73ClmwKM+eho/yRx4rFQabO80CkN9gF3Gs2N+ashIAllWv7eZxSiRs/xSu6l+Mc4fKHE+Pvc8RWfxSLafzODo8Nbny2N23bpSeJjp01NL0gXYDKGm52SUORJloLvWSDKsjVt+OVvitaB0tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JJtIuORe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746600079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r86DOHuOaWZOrhx6Y+KQ/yMS/C603LZDyTVpAfoPr2g=;
	b=JJtIuORecAvYBOeW1/YlmaKiLpN9YbtqaDFpPAB+WkXB0VhiSxIAXxOUm41p7nZQuFPXr0
	YWwDmd0TM7aokzk2hBnLLiyy+neLO/CCoq+b9B85+SFmUaL52u/+Dx5RJ4S9iizjjQBoNo
	9c//o68EQHb2r8/dP6j49XwFguXKLYU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-dUKsqmDRMfWXy4MCNEGEsQ-1; Wed,
 07 May 2025 02:41:13 -0400
X-MC-Unique: dUKsqmDRMfWXy4MCNEGEsQ-1
X-Mimecast-MFC-AGG-ID: dUKsqmDRMfWXy4MCNEGEsQ_1746600072
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B89AB18001D1;
	Wed,  7 May 2025 06:41:11 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.224.220])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB42C18003FC;
	Wed,  7 May 2025 06:41:06 +0000 (UTC)
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
Subject: [PATCH bpf-next v4 3/4] bpf: Add kfuncs for read-only string operations
Date: Wed,  7 May 2025 08:40:38 +0200
Message-ID: <19913411da8c08170d959207e28262efc0a5d813.1746598898.git.vmalik@redhat.com>
In-Reply-To: <cover.1746598898.git.vmalik@redhat.com>
References: <cover.1746598898.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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

At the moment, strings can be passed to the kfuncs in three forms:
- string literals (i.e. pointers to read-only maps)
- global variables (i.e. pointers to read-write maps)
- stack-allocated buffers

Note that currently, it is not possible to pass strings from the BPF
program context (like function args) as the verifier doesn't treat them
as neither PTR_TO_MEM nor PTR_TO_BTF_ID.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 kernel/bpf/helpers.c | 440 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 440 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e3a2662f4e33..8fb7c2ca7ac0 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -23,6 +23,7 @@
 #include <linux/btf_ids.h>
 #include <linux/bpf_mem_alloc.h>
 #include <linux/kasan.h>
+#include <linux/uaccess.h>
 
 #include "../../lib/kstrtox.h"
 
@@ -3194,6 +3195,433 @@ __bpf_kfunc void bpf_local_irq_restore(unsigned long *flags__irq_flag)
 	local_irq_restore(*flags__irq_flag);
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
+ * @s1: One string
+ * @s2: Another string
+ *
+ * Return:
+ * * %0       - Strings are equal
+ * * %-1      - @s1 is smaller
+ * * %1       - @s2 is smaller
+ * * %-EFAULT - Cannot read one of the strings
+ * * %-E2BIG  - One of strings is too large
+ */
+__bpf_kfunc int bpf_strcmp(const char *s1, const char *s2)
+{
+	char c1, c2;
+	int i;
+
+	if (!s1 || !s2)
+		return -EFAULT;
+
+	guard(pagefault)();
+	for (i = 0; i < XATTR_SIZE_MAX; i++) {
+		__get_kernel_nofault(&c1, s1, char, err_out);
+		__get_kernel_nofault(&c2, s2, char, err_out);
+		if (c1 != c2)
+			return c1 < c2 ? -1 : 1;
+		if (c1 == '\0')
+			return 0;
+		s1++;
+		s2++;
+	}
+	return -E2BIG;
+err_out:
+	return -EFAULT;
+}
+
+/**
+ * bpf_strchr - Find the first occurrence of a character in a string
+ * @s: The string to be searched
+ * @c: The character to search for
+ *
+ * Note that the %NUL-terminator is considered part of the string, and can
+ * be searched for.
+ *
+ * Return:
+ * * const char * - Pointer to the first occurrence of @c within @s
+ * * %NULL        - @c not found in @s
+ * * %-EFAULT     - Cannot read @s
+ * * %-E2BIG      - @s too large
+ */
+__bpf_kfunc const char *bpf_strchr(const char *s, char c)
+{
+	char sc;
+	int i;
+
+	if (!s)
+		return ERR_PTR(-EFAULT);
+
+	guard(pagefault)();
+	for (i = 0; i < XATTR_SIZE_MAX; i++) {
+		__get_kernel_nofault(&sc, s, char, err_out);
+		if (sc == c)
+			return s;
+		if (sc == '\0')
+			return NULL;
+		s++;
+	}
+	return ERR_PTR(-E2BIG);
+err_out:
+	return ERR_PTR(-EFAULT);
+}
+
+/**
+ * bpf_strnchr - Find a character in a length limited string
+ * @s: The string to be searched
+ * @count: The number of characters to be searched
+ * @c: The character to search for
+ *
+ * Note that the %NUL-terminator is considered part of the string, and can
+ * be searched for.
+ *
+ * Return:
+ * * const char * - Pointer to the first occurrence of @c within @s
+ * * %NULL        - @c not found in the first @count characters of @s
+ * * %-EFAULT     - Cannot read @s
+ * * %-E2BIG      - @s too large
+ */
+__bpf_kfunc const char *bpf_strnchr(const char *s, size_t count, char c)
+{
+	char sc;
+	int i;
+
+	if (!s)
+		return ERR_PTR(-EFAULT);
+
+	guard(pagefault)();
+	for (i = 0; i < count && i < XATTR_SIZE_MAX; i++) {
+		__get_kernel_nofault(&sc, s, char, err_out);
+		if (sc == c)
+			return s;
+		if (sc == '\0')
+			return NULL;
+		s++;
+	}
+	return i == XATTR_SIZE_MAX ? ERR_PTR(-E2BIG) : NULL;
+err_out:
+	return ERR_PTR(-EFAULT);
+}
+
+/**
+ * bpf_strchrnul - Find and return a character in a string, or end of string
+ * @s: The string to be searched
+ * @c: The character to search for
+ *
+ * Return:
+ * * const char * - Pointer to the first occurrence of @c within @s or pointer
+ *                  to the null byte at the end of @s when @c is not found
+ * * %-EFAULT     - Cannot read @s
+ * * %-E2BIG      - @s too large
+ */
+__bpf_kfunc const char *bpf_strchrnul(const char *s, char c)
+{
+	char sc;
+	int i;
+
+	if (!s)
+		return ERR_PTR(-EFAULT);
+
+	guard(pagefault)();
+	for (i = 0; i < XATTR_SIZE_MAX; i++) {
+		__get_kernel_nofault(&sc, s, char, err_out);
+		if (sc == '\0' || sc == c)
+			return s;
+		s++;
+	}
+	return ERR_PTR(-E2BIG);
+err_out:
+	return ERR_PTR(-EFAULT);
+}
+
+/**
+ * bpf_strrchr - Find the last occurrence of a character in a string
+ * @s: The string to be searched
+ * @c: The character to search for
+ *
+ * Return:
+ * * const char * - Pointer to the last occurrence of @c within @s
+ * * %NULL        - @c not found in @s
+ * * %-EFAULT     - Cannot read @s
+ * * %-E2BIG      - @s too large
+ */
+__bpf_kfunc const char *bpf_strrchr(const char *s, int c)
+{
+	const char *last = NULL;
+	char sc;
+	int i;
+
+	if (!s)
+		return ERR_PTR(-EFAULT);
+
+	guard(pagefault)();
+	for (i = 0; i < XATTR_SIZE_MAX; i++) {
+		__get_kernel_nofault(&sc, s, char, err_out);
+		if (sc == '\0')
+			return last;
+		if (sc == c)
+			last = s;
+		s++;
+	}
+	return ERR_PTR(-E2BIG);
+err_out:
+	return ERR_PTR(-EFAULT);
+}
+
+/**
+ * bpf_strlen - Calculate the length of a string
+ * @s: The string
+ *
+ * Return:
+ * * >=0      - The length of @s
+ * * %-EFAULT - Cannot read @s
+ * * %-E2BIG  - @s too large
+ */
+__bpf_kfunc int bpf_strlen(const char *s)
+{
+	char c;
+	int i;
+
+	if (!s)
+		return -EFAULT;
+
+	guard(pagefault)();
+	for (i = 0; i < XATTR_SIZE_MAX; i++) {
+		__get_kernel_nofault(&c, s, char, err_out);
+		if (c == '\0')
+			return i;
+		s++;
+	}
+	return -E2BIG;
+err_out:
+	return -EFAULT;
+}
+
+/**
+ * bpf_strlen - Calculate the length of a length-limited string
+ * @s: The string
+ * @count: The maximum number of characters to count
+ *
+ * Return:
+ * * >=0      - The length of @s
+ * * %-EFAULT - Cannot read @s
+ * * %-E2BIG  - @s too large
+ */
+__bpf_kfunc int bpf_strnlen(const char *s, size_t count)
+{
+	char c;
+	int i;
+
+	if (!s)
+		return -EFAULT;
+
+	guard(pagefault)();
+	for (i = 0; i < count && i < XATTR_SIZE_MAX; i++) {
+		__get_kernel_nofault(&c, s, char, err_out);
+		if (c == '\0')
+			return i;
+		s++;
+	}
+	return i == XATTR_SIZE_MAX ? -E2BIG : i;
+err_out:
+	return -EFAULT;
+}
+
+/**
+ * bpf_strspn - Calculate the length of the initial substring of @s which only
+ *              contains letters in @accept
+ * @s: The string to be searched
+ * @accept: The string to search for
+ *
+ * Return:
+ * * >=0      - The length of the initial substring of @s which only contains
+ *              letter in @accept
+ * * %-EFAULT - Cannot read @s
+ * * %-E2BIG  - @s too large
+ */
+__bpf_kfunc int bpf_strspn(const char *s, const char *accept)
+{
+	const char *p;
+	char c;
+	int i;
+
+	if (!s || !accept)
+		return -EFAULT;
+
+	guard(pagefault)();
+	for (i = 0; i < XATTR_SIZE_MAX; i++) {
+		__get_kernel_nofault(&c, s, char, err_out);
+		p = bpf_strchr(accept, c);
+		if (IS_ERR(p))
+			return PTR_ERR(p);
+		if (c == '\0' || !p)
+			return i;
+		s++;
+	}
+	return -E2BIG;
+err_out:
+	return -EFAULT;
+}
+
+/**
+ * strcspn - Calculate the length of the initial substring of @s which does not
+ *           contain letters in @reject
+ * @s: The string to be searched
+ * @reject: The string to avoid
+ *
+ * Return:
+ * * >=0      - The length of the initial substring of @s which does not contain
+ *              letters from @reject
+ * * %-EFAULT - Cannot read @s
+ * * %-E2BIG  - @s too large
+ */
+__bpf_kfunc int bpf_strcspn(const char *s, const char *reject)
+{
+	const char *p;
+	char c;
+	int i;
+
+	if (!s || !reject)
+		return -EFAULT;
+
+	guard(pagefault)();
+	for (i = 0; i < XATTR_SIZE_MAX; i++) {
+		__get_kernel_nofault(&c, s, char, err_out);
+		p = bpf_strchr(reject, c);
+		if (IS_ERR(p))
+			return PTR_ERR(p);
+		if (c == '\0' || p)
+			return i;
+		s++;
+	}
+	return -E2BIG;
+err_out:
+	return -EFAULT;
+}
+
+/**
+ * bpf_strpbrk - Find the first occurrence of a set of characters
+ * @s: The string to be searched
+ * @accept: The characters to search for
+ *
+ * Return:
+ * * const char * - Pointer to the first occurrence of a character from @accept
+ *                  within @s
+ * * %NULL        - No character from @accept found in @s
+ * * %-EFAULT     - Cannot read one of the strings
+ * * %-E2BIG      - One of the strings is too large
+ */
+__bpf_kfunc const char *bpf_strpbrk(const char *s, const char *accept)
+{
+	const char *p;
+	char c;
+	int i;
+
+	if (!s || !accept)
+		return ERR_PTR(-EFAULT);
+
+	guard(pagefault)();
+	for (i = 0; i < XATTR_SIZE_MAX; i++) {
+		__get_kernel_nofault(&c, s, char, err_out);
+		if (c == '\0')
+			return NULL;
+		p = bpf_strchr(accept, c);
+		if (IS_ERR(p))
+			return p;
+		if (p)
+			return s;
+		s++;
+	}
+	return ERR_PTR(-E2BIG);
+err_out:
+	return ERR_PTR(-EFAULT);
+}
+
+/**
+ * bpf_strstr - Find the first substring in a string
+ * @s1: The string to be searched
+ * @s2: The string to search for
+ *
+ * Return:
+ * * const char * - Pointer to the first occurrence of @s2 within @s1
+ * * %NULL        - @s2 is not a substring of @s1
+ * * %-EFAULT     - Cannot read one of the strings
+ * * %-E2BIG      - One of the strings is too large
+ */
+__bpf_kfunc const char *bpf_strstr(const char *s1, const char *s2)
+{
+	char c1, c2;
+	int i, j;
+
+	if (!s1 || !s2)
+		return ERR_PTR(-EFAULT);
+
+	guard(pagefault)();
+	for (i = 0; i < XATTR_SIZE_MAX; i++) {
+		for (j = 0; j < XATTR_SIZE_MAX; j++) {
+			__get_kernel_nofault(&c1, s1 + j, char, err_out);
+			__get_kernel_nofault(&c2, s2 + j, char, err_out);
+			if (c2 == '\0')
+				return s1;
+			if (c1 == '\0')
+				return NULL;
+			if (c1 != c2)
+				break;
+		}
+		if (j == XATTR_SIZE_MAX)
+			return ERR_PTR(-E2BIG);
+		s1++;
+	}
+	return ERR_PTR(-E2BIG);
+err_out:
+	return ERR_PTR(-EFAULT);
+}
+
+/**
+ * bpf_strnstr - Find the first substring in a length-limited string
+ * @s1: The string to be searched
+ * @s2: The string to search for
+ * @len: the maximum number of characters to search
+ */
+__bpf_kfunc const char *bpf_strnstr(const char *s1, const char *s2, size_t len)
+{
+	char c1, c2;
+	int i, j;
+
+	if (!s1 || !s2)
+		return ERR_PTR(-EFAULT);
+
+	guard(pagefault)();
+	for (i = 0; i < XATTR_SIZE_MAX; i++) {
+		for (j = 0; i + j < len && j < XATTR_SIZE_MAX; j++) {
+			__get_kernel_nofault(&c1, s1 + j, char, err_out);
+			__get_kernel_nofault(&c2, s2 + j, char, err_out);
+			if (c2 == '\0')
+				return s1;
+			if (c1 == '\0')
+				return NULL;
+			if (c1 != c2)
+				break;
+		}
+		if (j == XATTR_SIZE_MAX)
+			return ERR_PTR(-E2BIG);
+		if (i + j == len)
+			return NULL;
+		s1++;
+	}
+	return ERR_PTR(-E2BIG);
+err_out:
+	return ERR_PTR(-EFAULT);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(generic_btf_ids)
@@ -3294,6 +3722,18 @@ BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLE
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_local_irq_save)
 BTF_ID_FLAGS(func, bpf_local_irq_restore)
+BTF_ID_FLAGS(func, bpf_strcmp);
+BTF_ID_FLAGS(func, bpf_strchr, KF_RET_NULL);
+BTF_ID_FLAGS(func, bpf_strchrnul);
+BTF_ID_FLAGS(func, bpf_strnchr, KF_RET_NULL);
+BTF_ID_FLAGS(func, bpf_strrchr, KF_RET_NULL);
+BTF_ID_FLAGS(func, bpf_strlen);
+BTF_ID_FLAGS(func, bpf_strnlen);
+BTF_ID_FLAGS(func, bpf_strspn);
+BTF_ID_FLAGS(func, bpf_strcspn);
+BTF_ID_FLAGS(func, bpf_strpbrk, KF_RET_NULL);
+BTF_ID_FLAGS(func, bpf_strstr, KF_RET_NULL);
+BTF_ID_FLAGS(func, bpf_strnstr, KF_RET_NULL);
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
-- 
2.49.0


