Return-Path: <bpf+bounces-61644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6616EAE95AC
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 08:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35B08168627
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 06:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB6B22FAF4;
	Thu, 26 Jun 2025 06:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R6Tl9q75"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5472264A9
	for <bpf@vger.kernel.org>; Thu, 26 Jun 2025 06:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750918138; cv=none; b=s49bL3moNmc4iG5dhDRgSWRmL0GOmZ9SH0fZ1Lo2A2PSk1oGmVjn8nvNTNPAmdOrIM1vdmFxmBme2z0bqjf1LiSD4Nkp2I6bUHSSqM8QJhLuwsqry4O4NkO+UkdpNGBLg/hQdCUqSZgAtI9UAZD+jW0lrb8IK9Hy+2/9qpz0oGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750918138; c=relaxed/simple;
	bh=jaJrcq7Rh/vYUkUE2lqY/bbjDyaQhcsqUDDNzGmRNmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aL8EnIxFd1yXdCaku9/atBJsq5K6xmfg+brd8utTpglxwBodQwWk16XO2O9WzEHSiAPBZa3DCXKO0exboQRFI6+6jAfIPYX9l4Li5oBTwtTua9TxlzziPe+MWrZrFUsscye+VH4B/HG6giT2eW8A3VjQhVexvK6u1iWduqjNTGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R6Tl9q75; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750918135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S6Dxc2/VDhbKDvHxAw+2aOGz/VbF48cdAnsgpAdv/kk=;
	b=R6Tl9q75ORVRKXq7V4LnAebM8ostjzOoL/VdFVMiV35KrnquPyRDqJkg/KHVuksKZSCRaz
	xu1zTnEfeXoUqsdfDFPjZL+tY47oU6qr0Kwg9unKRbJG0cYcu2ewNOj86FuWhxnOfjKl92
	3y8sb412j0KmsQlzDY1Q9y8JNKaypEs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-lRP9_QbyM3mCtT4nHvHmcg-1; Thu,
 26 Jun 2025 02:08:51 -0400
X-MC-Unique: lRP9_QbyM3mCtT4nHvHmcg-1
X-Mimecast-MFC-AGG-ID: lRP9_QbyM3mCtT4nHvHmcg_1750918129
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 51CD418011EE;
	Thu, 26 Jun 2025 06:08:49 +0000 (UTC)
Received: from vmalik-fedora.brq.redhat.com (unknown [10.43.17.39])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19D9D19560A3;
	Thu, 26 Jun 2025 06:08:44 +0000 (UTC)
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
Subject: [PATCH bpf-next v8 2/4] bpf: Add kfuncs for read-only string operations
Date: Thu, 26 Jun 2025 08:08:29 +0200
Message-ID: <4b008a6212852c1b056a413f86e3efddac73551c.1750917800.git.vmalik@redhat.com>
In-Reply-To: <cover.1750917800.git.vmalik@redhat.com>
References: <cover.1750917800.git.vmalik@redhat.com>
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
 kernel/bpf/helpers.c | 382 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 382 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b71e428ad936..2cdcf7b2c91e 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -24,6 +24,7 @@
 #include <linux/bpf_mem_alloc.h>
 #include <linux/kasan.h>
 #include <linux/bpf_verifier.h>
+#include <linux/uaccess.h>
 
 #include "../../lib/kstrtox.h"
 
@@ -3278,6 +3279,376 @@ __bpf_kfunc void __bpf_trap(void)
 {
 }
 
+/*
+ * Kfuncs for string operations.
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
+ * * %-ENOENT - @c not found in the first @count characters of @s__ign
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
+			return -ENOENT;
+		s__ign++;
+	}
+	return i == XATTR_SIZE_MAX ? -E2BIG : -ENOENT;
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
+ * * %-ENOENT - @c not found in @s__ign
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
+ * * %-ENOENT - @c not found in @s__ign
+ * * %-EFAULT - Cannot read @s__ign
+ * * %-E2BIG  - @s__ign is too large
+ * * %-ERANGE - @s__ign is outside of kernel address space
+ */
+__bpf_kfunc int bpf_strrchr(const char *s__ign, int c)
+{
+	char sc;
+	int i, last = -ENOENT;
+
+	if (!copy_from_kernel_nofault_allowed(s__ign, 1))
+		return -ERANGE;
+
+	guard(pagefault)();
+	for (i = 0; i < XATTR_SIZE_MAX; i++) {
+		__get_kernel_nofault(&sc, s__ign, char, err_out);
+		if (sc == c)
+			last = i;
+		if (sc == '\0')
+			return last;
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
+		for (j = 0; j < XATTR_SIZE_MAX; j++) {
+			__get_kernel_nofault(&ca, accept__ign + j, char, err_out);
+			if (cs == ca || ca == '\0')
+				break;
+		}
+		if (j == XATTR_SIZE_MAX)
+			return -E2BIG;
+		if (ca == '\0')
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
+		for (j = 0; j < XATTR_SIZE_MAX; j++) {
+			__get_kernel_nofault(&cr, reject__ign + j, char, err_out);
+			if (cs == cr || cr == '\0')
+				break;
+		}
+		if (j == XATTR_SIZE_MAX)
+			return -E2BIG;
+		if (cr != '\0')
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
+ * * %-ENOENT - @s2__ign not found in the first @len characters of @s1__ign
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
+			__get_kernel_nofault(&c2, s2__ign + j, char, err_out);
+			if (c2 == '\0')
+				return i;
+			__get_kernel_nofault(&c1, s1__ign + j, char, err_out);
+			if (c1 == '\0')
+				return -ENOENT;
+			if (c1 != c2)
+				break;
+		}
+		if (j == XATTR_SIZE_MAX)
+			return -E2BIG;
+		if (i + j == len)
+			return -ENOENT;
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
+ * * %-ENOENT - @s2__ign is not a substring of @s1__ign
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
@@ -3397,6 +3768,17 @@ BTF_ID_FLAGS(func, bpf_iter_dmabuf_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPAB
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


