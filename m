Return-Path: <bpf+bounces-70658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF85BC968E
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 16:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 799E2347E43
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 14:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E432E975A;
	Thu,  9 Oct 2025 14:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRBIcPwh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E72A16EB42
	for <bpf@vger.kernel.org>; Thu,  9 Oct 2025 14:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760018565; cv=none; b=TZrzXvC/GbMD4jw1pvAv86akBG5bIvr3k2JWYP9Wb+6PkdB+sDmXU6FelE2mIE1h1Hg90LU5c+GdVJAh5jhgq6zrnAZKBHUTh85Ne7MyZr1Ga+yc3k+bTfMWAvxhi/QT6kmxjoFkXP8+BiZFVarIxGrZc886r1YGkI6UoDagc3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760018565; c=relaxed/simple;
	bh=np4B6Dcvwn1dTa2ukaBRLomS5/EqF3Vd2s46p5+oj2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3qOF8hz0o8UczeCQjYYJMM+2VCDKPzA9mDVJkoNo6fnlSBeika7UGftULDnOPMQK5LIp5koB+rdp+s7glzZWEsUSDWir4B7melXQMfV8nSexqiJjEla30iyfObYzuyyqjfrLuF+mu80fWhaF0Oq9H3shPOWrsZMbOs3YKS1518=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRBIcPwh; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e504975dbso6381845e9.1
        for <bpf@vger.kernel.org>; Thu, 09 Oct 2025 07:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760018562; x=1760623362; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ma+pbiVq6Y9+sUaOpiOPEynkbEVW/eMv8yb6AhQR5Wk=;
        b=lRBIcPwhO3+Laa2d3O+MIYrKDpBgNeD7R1olW0GrgS7sjlHoX109yMQYJf1nMwqCv3
         Ebq4wYuFa76LslKEufHydRpXc51jkXNsIEzyY/zPBLYTcOxtrnLXe3wI3pMOKs+ZopIB
         OfgNs1hhynhgW/1LAUB4LbFbNuoS0ni0DGsKC9z/DM11g5uIhqazr4zhJNZBmphAvqd2
         btyd7eFNwObKZt6qJNq/MTqAVc2LHoAutvpyK6uVstCVKUNl0myqSp3uGdlnf8QmfoaI
         iP/++B9Eukf5dTbANH/ASPDW/7G9gHWzEmi/zdX4C8KDLJ4G+oFefNMMDCd6/PqXXfb7
         7S0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760018562; x=1760623362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ma+pbiVq6Y9+sUaOpiOPEynkbEVW/eMv8yb6AhQR5Wk=;
        b=P8tCVs4BgewVZlw1SmIs79aM26QGMjn77FA8ukByq4N6t4sZR2yS1ec5GcbJSMUAQ+
         RGg5OWQjZleSsnpJAk70xesfX44aOwTR+hfNnvEjIW8r3GJKushAiNWf2yAtLs205Cz8
         pths7axp7xH1E1qFhAgRwnTexM7hDE2zCH1MgJ+ncQcF2MrRuPBXFWnbZVzlKvZwNLWg
         OXRAMsO39ay+RTXsulgFadJ7fxSO+eRMEXlATqNY7+1FPatE5/3A4Dt57Noc8nKiUCUX
         pdMqt4prbVZMSm1fkFvDVVjgsgKma9umnnWZAPV2qTHdDvLWDqui/bozG+CUXhRBvhCr
         SsaA==
X-Gm-Message-State: AOJu0Yyb7f0I5mmjp0xxauMqB1z8pDMO8cNWYO4fuuHns19z3/VHARYB
	I0BRmSEvNulMNw+NLR6hkiz2u94KByYW5O7e7nH5VB1hJVFg93ojaKxADbYWXA==
X-Gm-Gg: ASbGncu4PO3qFchC3zFKLcql/9T5qNm+WQZa8iVfanuSKCwLjlyX9FWXOyMePxIs+9Z
	wHgjd4tMdHWYRZTxFx/8rfRndbwWNhkK96m1VIuwwNG5iXLaLsDfGDrlMqxgyEOzPBUuyGSNfEk
	9QHdUNfURgPgmg7KkoUSUjGt+Mgel8NjxLtF4O+aW4qz6ZfjX+UDO6NzfxX65OIZJPkYUPTY9Vr
	RpQoMTHDoKfFJGbEyj2sstRWbIJ/+Y3iEA7OWlEVHa6I/g8GRlqoVGt8WdtufihZNVezRBuwbVt
	B1/VNHPvU69uvRBood20ViFiaiGTGwGLKTLiTj1ZWhllRtQrKhkMeHblTXP7GfQZNszDQjCZ7cH
	jihP2rwuOysTrFeSGtI6XfmO3xktffbZxPfZnyX88ZFNA2Bqh7ThyD7KDTxYOQmtDj8fr8DdGv9
	7G9CWGECaMhrSCr4knzpOZcY2hXsXXKESKSqDnozkvSz8xgT4jHHFk/6xS
X-Google-Smtp-Source: AGHT+IGJN8yAvvBcEQMGjrtBQtGGO3JKOOUbY2a3kzmLjLWVe9BnjDyjuYB784KhNwlihlbmspuWvA==
X-Received: by 2002:a05:600c:a43:b0:46f:b32e:528f with SMTP id 5b1f17b1804b1-46fb32e52e3mr13021945e9.5.1760018561946;
        Thu, 09 Oct 2025 07:02:41 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00b81184fd69385167.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:b811:84fd:6938:5167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4256866060fsm29129006f8f.14.2025.10.09.07.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 07:02:41 -0700 (PDT)
Date: Thu, 9 Oct 2025 16:02:38 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v7 4/5] selftests/bpf: Support non-linear flag in
 test loader
Message-ID: <0c44ad0d1f4899cbfd745ab654a2ad86e3737d37.1760015985.git.paul.chaignon@gmail.com>
References: <cover.1760015985.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1760015985.git.paul.chaignon@gmail.com>

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


