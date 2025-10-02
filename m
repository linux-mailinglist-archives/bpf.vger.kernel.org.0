Return-Path: <bpf+bounces-70192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0F4BB38CF
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 12:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD8D9189F5C0
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 10:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AA0307AEF;
	Thu,  2 Oct 2025 10:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUAMuF/1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CDF2D73A2
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 10:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759399662; cv=none; b=XoX6qPFnu2r4U52aDz8UxCrOACxVKRbbkX+HyB7lnLedWREjvbb6QNufkk+q+VBD/Ze1CxIQxEJHL8uk/heqVpmgXFoEJIdea7IR6ui09G3Prkv88Pvdhgshx2NRmugXx1sBTv/C5MOgA4k4jxrG8hWWxtjl0RiLXD3OJZ5Vocc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759399662; c=relaxed/simple;
	bh=np4B6Dcvwn1dTa2ukaBRLomS5/EqF3Vd2s46p5+oj2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmH/uITyGZK/sFrmEG6yiAeBqmj8dqpo05n85nPmRO7BsE+Eb7lRPAdHTL0dOYm/e7FLJQi7wvsg+q1XuqtqPrl8hsG/yjJE8uaaH8ryE/ZqkzQj9PZ3Cnv706WtF8mNkna2VyEBQBrgEJE2CTqhgWWzYuWcX1ntkFMLBpJKFgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUAMuF/1; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3f0ae439bc3so399951f8f.1
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 03:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759399659; x=1760004459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ma+pbiVq6Y9+sUaOpiOPEynkbEVW/eMv8yb6AhQR5Wk=;
        b=nUAMuF/12wD6qoYsK+KUFCTl63rRZ5A4exI1/E6ChRq39SaWpdoo350HFgPbQbDKut
         C01/PIt36ZM8vYjTb0fOesZoKyYbu5jkN3Hnhk0luACcoaFo1/uFjQwCbdi6BaTGGK7y
         VE2Tt5oo7YvZiBs13TstaIllTGe//HfEipx79aU+NfdeWAMuHW0Y3+4RTGK6qriIX79v
         oSM9kX5q19Qrw06iSACKIH4hIJZT8tDU/2G+Q9Od/+aQ+mMkXk51zOHaPwyzQ2iI/HJ0
         Chiw4Xmv4VkF80iR86CQPwszPkNKToFVjOpUJTWxuvhd1oxg1GM2biiOUgJutUf4ajEv
         4t0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759399659; x=1760004459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ma+pbiVq6Y9+sUaOpiOPEynkbEVW/eMv8yb6AhQR5Wk=;
        b=BxOrc9vQh2atLDw/bN0rwW+rKSIVrTSaWiNOHX2JBX6cJPpINBhrC6zYrO/BVpbrD9
         ZLVe+2H9lo+gPCkUZzZynCerSxKjd+X0igDZfZ8lJ99ic/zsQGTG/6zjLInEmTd9nS4v
         WwFKKZgve8w4Q0pTRZreU0LA/ttlQWx3SmMJ1GqYS6CyXH5C9kq68+TkSMmQWy9+8YMR
         X2O0kCg9MQ82vFf6tIr4fVo1LNnYhrSh8so0hWUA8RWBD5+9WJCACT9fnEGC0M32vZhr
         zznlU0TCUK2YfPgNaP7K1pTpW4Iov15oO3Yv/ObQbhW88nIyFWDqx7BF5dhV/RMKGA2E
         QLUw==
X-Gm-Message-State: AOJu0Yx7twvLL7OhI0zKHDE3eK6vc1YaEKBfLfHI3aRo86TC1qLnp6zW
	ynO+dd7rE97cTDvd30tpFBXH7I1ZFKioQq8NPhrcJOqMLdkjvwcxefc+6KdhGwTn
X-Gm-Gg: ASbGncuUsu3VV2TS0TS9R5eQ/MXgHMy0dBd8O0fJozx5ywJhyRZ9SdE1p2GV+gI8GFj
	z/X6R1rIKHmuyJMQ2C2DAbjmCDRC2Kx5VMar4yPYvSP5fDKs51kI07H8mvg7o/JJFgbw6uP7jp7
	zj44zXD3NDgSCzWX5vy5/nkrF4m4Vx2gaO7Qt3C8EM7TnbznvOnVIHcRRe+QCflgEnjOXwimo8m
	W/9ED2iCIcT8v7iOjGrwczUX//R4kayrtKKgyQaiUgS53jWTvG+3bIr9tbLAmxRexhut+IjY2FK
	EQDqWnPsEO/uQlzATokUrvJpLrpUaCT/RmIqK7mUYIcFfhMf5yJwX5l9ztjozSq3TSpe8XYV/5i
	cq57x9D2ex0ivNpw1Rlheoq35oP8K7tsBg4NS7homNREAx8eiO1ZmIwqGEkHHub7rIidqW3Vv6/
	bCXkvruGTa8NCFb3DZgSA5Ily7277OONC/r/HaL7Suupw=
X-Google-Smtp-Source: AGHT+IHCEVxDjNgGstlTw5A6YrwrgvedQ/EgAC42Kz1f+RZEHo2c6LmroJL0pD+cdmqgRfDJEvI4Zg==
X-Received: by 2002:a05:6000:609:b0:3d7:2284:b20 with SMTP id ffacd0b85a97d-425577ecfe7mr5114311f8f.3.1759399659018;
        Thu, 02 Oct 2025 03:07:39 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e000a5ae04ae4e6e63e.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:a5a:e04a:e4e6:e63e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a8542sm2967242f8f.9.2025.10.02.03.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 03:07:38 -0700 (PDT)
Date: Thu, 2 Oct 2025 12:07:37 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v5 4/5] selftests/bpf: Support non-linear flag in
 test loader
Message-ID: <3a789ac644b3de4dd556bddd1e67785c2e07d546.1759397354.git.paul.chaignon@gmail.com>
References: <cover.1759397353.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759397353.git.paul.chaignon@gmail.com>

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


