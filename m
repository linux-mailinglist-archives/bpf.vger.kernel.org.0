Return-Path: <bpf+bounces-35064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 253679374E5
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 10:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 991301F22281
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 08:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F076984A5B;
	Fri, 19 Jul 2024 08:13:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA10679E5;
	Fri, 19 Jul 2024 08:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721376811; cv=none; b=VXDwTUEuRrHmq6CPHblK+nLFszon2JjEY6n0b6k5fvdkeqUufcFBEY7DIdnPEqjgyLmKKiwPvMLi7ZDnbi3oubSgkKtG6AcMVTECJpdol0y/tUQWYpj0YBbVzHCuM/cXZ7pQsMWtyOEuS+sOWWZIpGqW5T7qfitHyzff/yES34g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721376811; c=relaxed/simple;
	bh=WHsYV4fWQ1SKrc2VdfUxUlEo1NTw+En+rcCSDDxq04U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CVVqkaieswoEgbcqheVe52qtAyQIh9IKajjG1Vo2OoA89YQrLRMPPd+iYJFZg1+N/xbnFvPJuQTpaAn4OE+ykQ9VKQXMozHauux6pCL/pu8Ebd5YRZHTyd2gScD0sp7mlQz8pwwrb5rQOIGwucL5JeLge5P8pC9bMVXGKZNLKrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WQMqx3gNLz4f3jkg;
	Fri, 19 Jul 2024 16:13:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 93F011A06D7;
	Fri, 19 Jul 2024 16:13:25 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP3 (Coremail) with SMTP id _Ch0CgCXo04hIJpm5CslAg--.56491S9;
	Fri, 19 Jul 2024 16:13:25 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	James Morris <jamorris@linux.microsoft.com>,
	Kees Cook <kees@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Florent Revest <revest@google.com>
Subject: [PATCH bpf-next v1 7/9] selftests/bpf: Add return value checks for failed tests
Date: Fri, 19 Jul 2024 16:17:47 +0800
Message-Id: <20240719081749.769748-8-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240719081749.769748-1-xukuohai@huaweicloud.com>
References: <20240719081749.769748-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCXo04hIJpm5CslAg--.56491S9
X-Coremail-Antispam: 1UD129KBjvJXoWxWw1UXF4ftrW7Xr43uFy5twb_yoWrWw45pa
	4kZ3s2krySgF13Xw1xAr4xXFWFgws2q3yUArWxX34xZ3W7Jr97Xr4IgF45Xrn8JrZYyws5
	Zay2qrZxZr48Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUI-eODUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

The return ranges of some bpf lsm test progs can not be deduced by
the verifier accurately. To avoid erroneous rejections, add explicit
return value checks for these progs.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 tools/testing/selftests/bpf/progs/err.h                | 10 ++++++++++
 tools/testing/selftests/bpf/progs/test_sig_in_xattr.c  |  4 ++++
 .../selftests/bpf/progs/test_verify_pkcs7_sig.c        |  8 ++++++--
 .../selftests/bpf/progs/verifier_global_subprogs.c     |  7 ++++++-
 4 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/err.h b/tools/testing/selftests/bpf/progs/err.h
index d66d283d9e59..38529779a236 100644
--- a/tools/testing/selftests/bpf/progs/err.h
+++ b/tools/testing/selftests/bpf/progs/err.h
@@ -5,6 +5,16 @@
 #define MAX_ERRNO 4095
 #define IS_ERR_VALUE(x) (unsigned long)(void *)(x) >= (unsigned long)-MAX_ERRNO
 
+#define __STR(x) #x
+
+#define set_if_not_errno_or_zero(x, y)			\
+({							\
+	asm volatile ("if %0 s< -4095 goto +1\n"	\
+		      "if %0 s<= 0 goto +1\n"		\
+		      "%0 = " __STR(y) "\n"		\
+		      : "+r"(x));			\
+})
+
 static inline int IS_ERR_OR_NULL(const void *ptr)
 {
 	return !ptr || IS_ERR_VALUE((unsigned long)ptr);
diff --git a/tools/testing/selftests/bpf/progs/test_sig_in_xattr.c b/tools/testing/selftests/bpf/progs/test_sig_in_xattr.c
index 2f0eb1334d65..8ef6b39335b6 100644
--- a/tools/testing/selftests/bpf/progs/test_sig_in_xattr.c
+++ b/tools/testing/selftests/bpf/progs/test_sig_in_xattr.c
@@ -6,6 +6,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include "bpf_kfuncs.h"
+#include "err.h"
 
 char _license[] SEC("license") = "GPL";
 
@@ -79,5 +80,8 @@ int BPF_PROG(test_file_open, struct file *f)
 	ret = bpf_verify_pkcs7_signature(&digest_ptr, &sig_ptr, trusted_keyring);
 
 	bpf_key_put(trusted_keyring);
+
+	set_if_not_errno_or_zero(ret, -EFAULT);
+
 	return ret;
 }
diff --git a/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c b/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
index f42e9f3831a1..12034a73ee2d 100644
--- a/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
+++ b/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
@@ -11,6 +11,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include "bpf_kfuncs.h"
+#include "err.h"
 
 #define MAX_DATA_SIZE (1024 * 1024)
 #define MAX_SIG_SIZE 1024
@@ -55,12 +56,12 @@ int BPF_PROG(bpf, int cmd, union bpf_attr *attr, unsigned int size)
 
 	ret = bpf_probe_read_kernel(&value, sizeof(value), &attr->value);
 	if (ret)
-		return ret;
+		goto out;
 
 	ret = bpf_copy_from_user(data_val, sizeof(struct data),
 				 (void *)(unsigned long)value);
 	if (ret)
-		return ret;
+		goto out;
 
 	if (data_val->data_len > sizeof(data_val->data))
 		return -EINVAL;
@@ -84,5 +85,8 @@ int BPF_PROG(bpf, int cmd, union bpf_attr *attr, unsigned int size)
 
 	bpf_key_put(trusted_keyring);
 
+out:
+	set_if_not_errno_or_zero(ret, -EFAULT);
+
 	return ret;
 }
diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
index a9fc30ed4d73..20904cd2baa2 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
@@ -7,6 +7,7 @@
 #include "bpf_misc.h"
 #include "xdp_metadata.h"
 #include "bpf_kfuncs.h"
+#include "err.h"
 
 /* The compiler may be able to detect the access to uninitialized
    memory in the routines performing out of bound memory accesses and
@@ -331,7 +332,11 @@ SEC("?lsm/bpf")
 __success __log_level(2)
 int BPF_PROG(arg_tag_ctx_lsm)
 {
-	return tracing_subprog_void(ctx) + tracing_subprog_u64(ctx);
+	int ret;
+
+	ret = tracing_subprog_void(ctx) + tracing_subprog_u64(ctx);
+	set_if_not_errno_or_zero(ret, -1);
+	return ret;
 }
 
 SEC("?struct_ops/test_1")
-- 
2.30.2


