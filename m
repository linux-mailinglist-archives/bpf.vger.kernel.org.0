Return-Path: <bpf+bounces-70507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE9CBC18A2
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 15:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1348419A41B5
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 13:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711B92E0B5A;
	Tue,  7 Oct 2025 13:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+A3ZWrg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268B42E11C6
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759844322; cv=none; b=O822v5261E40PKQmbbqrcLUY47wNJ8PRNAxce0oQG7f3GSD+0H4nc9D2UMexVsvy/j3gsBf6kudyao9eyd+9fyH2PBh24AE6ogvY19nAKbxk50Nl2qIOInl2JDEUtKxN0WbzX+2iYns/KyC28ov6etxVIhREcrBL7Dbz5IDNUro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759844322; c=relaxed/simple;
	bh=np4B6Dcvwn1dTa2ukaBRLomS5/EqF3Vd2s46p5+oj2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjLw7l3suBVNzGV+AiYUb2I+e0OlFqSFJxpMK4au6L8mE8R1MQQCDb6WDxkvdNdnli9LNWCrkwgCpcSg6LevKmqeLcz1oGlUZXo7robPkeLKiQpOiF1kJedZL8HU/RDn6KdFWQ7AqjDfjQSGwTYkmWY/KCtmHWbnZvP/8QjsX4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+A3ZWrg; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e542196c7so40818215e9.0
        for <bpf@vger.kernel.org>; Tue, 07 Oct 2025 06:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759844318; x=1760449118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ma+pbiVq6Y9+sUaOpiOPEynkbEVW/eMv8yb6AhQR5Wk=;
        b=M+A3ZWrgN853IwumawjEcrX1hHy9ML3NMLE6XKTz/GRk9FBBuTWuADQtECdtrwX0n8
         cShH8a8bAXq3Kwv7qnOl6GCRoF9k9sUhnfbBMgUi+OUgf0vZKQ9inwxL/Sa4X0ptSRSE
         Ct1xHYgi6dCHYafQQpkGsVqm2WpwhnhNzl9/xI0xe9Cp36I4IdtkiwFgmsa7btevNwgc
         7rtKEYD24OpV8FgCoHIOY3hRKssEiKyS50kqkw0bw/p+3mOW8tdxST4++UIs+fSChsdb
         xLy44Y1+OOsaKeMJWhF0OfGfmQjhbO83jiyZF0NjWmKPXH2wMM+FzAT70sV0ouTciKYk
         lhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759844318; x=1760449118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ma+pbiVq6Y9+sUaOpiOPEynkbEVW/eMv8yb6AhQR5Wk=;
        b=mWZWvLwaOo1i1EehlNUbFutYEWTp2sthSe7BXyTWLoM6Jq5ONOMGv5t2yJNe+40SzP
         cPvXKGVsI78rVpsY2sfTArxlwX4KvMZeGLSjEuDSLtyaPbtoIFVipI0IHamgEAnnvwQS
         6+ICM/aHGni1M8BD7Zv5wpAQdwhCxJ0hxXsMcSsl9sDJ5zYPfsOe1V+pmD8aXKzTYitu
         dwNkKLYY9mYuSJvCZIwRIw2oknfa/n0lLDbFck2Qudnt6ZJMlVzNg4+j1yiUl/AU1TUw
         GjGn4y0XCHwn1kvEhQRsvYwWXBww//yERcEC+W/RJEenpF0RKRHB+a+5FhPvB9U4ttkQ
         X5Wg==
X-Gm-Message-State: AOJu0YwyCJYJLmaTuxobfUqdET7gg5E/uMZcDK8X0be8xm5hO0qMdOwL
	rHK3mFUu9NWvpKOrp+yz3uB/+SXKIJSnyS07q6VLE+v5aAlSXAXu1hLWc2cg1gka
X-Gm-Gg: ASbGncvgOMo0+8O+SNddD4eIuNz4rl05blzGynzbTCIgtQlht9VT1V9BPfi6RdI1dyy
	sQci+aY6oygAwA/ZKKyAmEEZ/gAcdtohCb/DOlnNdSSp07ZOA2vu6ugJ4QTmTK8ON7zIL0XCqmo
	xYBRdWKvkD0PVNpzlShhCmMVv1jSdGmobFVvMWeIjM9quqTVFURUDGvgWTGTso8wVFOWh6vbFEC
	JvIHaa0SUVZUlre9RSWs4IUXGjoH1n6uXjhTwMypFX9G0Tia8v0F9+EEWEiYXUZOWSQtDjb6sIC
	Dl0IVVWUvBkuIvqgyV9UT6o4y6KGE+QaeFmpnr0dYSQ0pvM5GPyCFKRtxhtpy/DyyiKFIbSqC/d
	Lqi4FelZ8uYuSmzSFneGp70eNcTD97u+KnRHzFUBIGInekVGcRv8AnMSpDtnwDxOGic7nnNtj6u
	IujJ0zlOENksHpZpZi6PmRPuqANkBMchV5GIjB9mMitaWi6Q==
X-Google-Smtp-Source: AGHT+IE+QVyk0/17sNBKjZ6RQqlFO7pJPg3N8yQIPE854MLlD4DZvVi3S24iw2hbBwfe28aa4Kq1cA==
X-Received: by 2002:a05:600d:810a:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-46fa29b2a32mr25017115e9.11.1759844318346;
        Tue, 07 Oct 2025 06:38:38 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0079f574fca42e1d7a.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:79f5:74fc:a42e:1d7a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e77972d2csm166484745e9.5.2025.10.07.06.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 06:38:37 -0700 (PDT)
Date: Tue, 7 Oct 2025 15:38:36 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v6 4/5] selftests/bpf: Support non-linear flag in
 test loader
Message-ID: <7f2ef84283295564c12915dde6144efbfa39e055.1759843268.git.paul.chaignon@gmail.com>
References: <cover.1759843268.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759843268.git.paul.chaignon@gmail.com>

This patch adds support for a new tag __linear_size in the test loader,
to specify the size of the linear area in case of non-linear skbs. If
the tag is absent or null, a linear skb is crafted.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  4 ++++
 .../bpf/progs/verifier_direct_packet_access.c |  1 +
 tools/testing/selftests/bpf/test_loader.c     | 19 +++++++++++++++++--
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index a7a1a684eed1..c9bfbe1bafc1 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -126,6 +126,9 @@
  *                   Several __arch_* annotations could be specified at once.
  *                   When test case is not run on current arch it is marked as skipped.
  * __caps_unpriv     Specify the capabilities that should be set when running the test.
+ *
+ * __linear_size     Specify the size of the linear area of non-linear skbs, or
+ *                   0 for linear skbs.
  */
 #define __msg(msg)		__attribute__((btf_decl_tag("comment:test_expect_msg=" XSTR(__COUNTER__) "=" msg)))
 #define __not_msg(msg)		__attribute__((btf_decl_tag("comment:test_expect_not_msg=" XSTR(__COUNTER__) "=" msg)))
@@ -159,6 +162,7 @@
 #define __stderr_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_stderr_unpriv=" XSTR(__COUNTER__) "=" msg)))
 #define __stdout(msg)		__attribute__((btf_decl_tag("comment:test_expect_stdout=" XSTR(__COUNTER__) "=" msg)))
 #define __stdout_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_stdout_unpriv=" XSTR(__COUNTER__) "=" msg)))
+#define __linear_size(sz)	__attribute__((btf_decl_tag("comment:test_linear_size=" XSTR(sz))))
 
 /* Define common capabilities tested using __caps_unpriv */
 #define CAP_NET_ADMIN		12
diff --git a/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c b/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
index 28b602ac9cbe..a61897e01a50 100644
--- a/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Converted from tools/testing/selftests/bpf/verifier/direct_packet_access.c */
 
+#include <linux/if_ether.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 74ecc281bb8c..690181617f04 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -43,6 +43,7 @@
 #define TEST_TAG_EXPECT_STDERR_PFX_UNPRIV "comment:test_expect_stderr_unpriv="
 #define TEST_TAG_EXPECT_STDOUT_PFX "comment:test_expect_stdout="
 #define TEST_TAG_EXPECT_STDOUT_PFX_UNPRIV "comment:test_expect_stdout_unpriv="
+#define TEST_TAG_LINEAR_SIZE "comment:test_linear_size="
 
 /* Warning: duplicated in bpf_misc.h */
 #define POINTER_VALUE	0xbadcafe
@@ -89,6 +90,7 @@ struct test_spec {
 	int mode_mask;
 	int arch_mask;
 	int load_mask;
+	int linear_sz;
 	bool auxiliary;
 	bool valid;
 };
@@ -633,6 +635,11 @@ static int parse_test_spec(struct test_loader *tester,
 					      &spec->unpriv.stdout);
 			if (err)
 				goto cleanup;
+		} else if (str_has_pfx(s, TEST_TAG_LINEAR_SIZE)) {
+			val = s + sizeof(TEST_TAG_LINEAR_SIZE) - 1;
+			err = parse_int(val, &spec->linear_sz, "test linear size");
+			if (err)
+				goto cleanup;
 		}
 	}
 
@@ -1007,10 +1014,11 @@ static bool is_unpriv_capable_map(struct bpf_map *map)
 	}
 }
 
-static int do_prog_test_run(int fd_prog, int *retval, bool empty_opts)
+static int do_prog_test_run(int fd_prog, int *retval, bool empty_opts, int linear_sz)
 {
 	__u8 tmp_out[TEST_DATA_LEN << 2] = {};
 	__u8 tmp_in[TEST_DATA_LEN] = {};
+	struct __sk_buff ctx = {};
 	int err, saved_errno;
 	LIBBPF_OPTS(bpf_test_run_opts, topts,
 		.data_in = tmp_in,
@@ -1020,6 +1028,12 @@ static int do_prog_test_run(int fd_prog, int *retval, bool empty_opts)
 		.repeat = 1,
 	);
 
+	if (linear_sz) {
+		ctx.data_end = linear_sz;
+		topts.ctx_in = &ctx;
+		topts.ctx_size_in = sizeof(ctx);
+	}
+
 	if (empty_opts) {
 		memset(&topts, 0, sizeof(struct bpf_test_run_opts));
 		topts.sz = sizeof(struct bpf_test_run_opts);
@@ -1269,7 +1283,8 @@ void run_subtest(struct test_loader *tester,
 		}
 
 		err = do_prog_test_run(bpf_program__fd(tprog), &retval,
-				       bpf_program__type(tprog) == BPF_PROG_TYPE_SYSCALL ? true : false);
+				       bpf_program__type(tprog) == BPF_PROG_TYPE_SYSCALL ? true : false,
+				       spec->linear_sz);
 		if (!err && retval != subspec->retval && subspec->retval != POINTER_VALUE) {
 			PRINT_FAIL("Unexpected retval: %d != %d\n", retval, subspec->retval);
 			goto tobj_cleanup;
-- 
2.43.0


