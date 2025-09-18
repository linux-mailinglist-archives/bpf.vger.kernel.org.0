Return-Path: <bpf+bounces-68827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 878F6B8618F
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 18:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3454862656B
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 16:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927C3246798;
	Thu, 18 Sep 2025 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNr+1HV/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4864E220F3F
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 16:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758214147; cv=none; b=YZCb0gC/sOog8m3IIJUyn3m1hFDxT1ThqZhNE1a22s0JhMMoKDZ9sbFG8SVPtIr5EnvzLqWZjy1PGqPoTYw1hG03LzbvBC+l1QQoWg015gfdhJqyWkS5QEB+/kiw3NUUyxYPY5Gp0yTY05fkATZOoim+YH7rUguc30sqgn2bo1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758214147; c=relaxed/simple;
	bh=NxuOwBDPXyPDamHCEKMLtSykPruNK7+sRQKqVIyRQi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GigIkX2OyJ/X/gyZ+cjkADl15gjqzBMqQ5Pz57mJHfe7eNfjcl2nJ+CB9KRk/OKpE3SN453xBMzjJhYY9P0qPCKRRk4njoR6sAnqyi39XNaPv10MJrtFGnNurnNcHS4cqWwYxDotVeHZABvkQLLVoPZo2np3VkadFf/KxAW6/pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNr+1HV/; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45cb6428c46so11762985e9.1
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 09:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758214143; x=1758818943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=naIqebnGtYpPO+MaA406hG6ahEfDSUj1Dkgs34ZLmFA=;
        b=nNr+1HV/ibD5jYcim7TC8xtb7bKKtVp/9hk4y8jmPt9AQmXm5xBUWFdx3d3TsNidsi
         T91TVJyqI8Fir/frqfiuz/pOKK8z6WKpxSPnkZyBa6R2YaWqe3acA4JwQkds4rwhvCKJ
         a8x67TlvbE7Um4eQHv6QLt0R6XE2549cwtjvoWiR/2EEqdyd65GR+IwvYsDTNjb/850x
         L9oBGpmWEO4MHP2YtNP08JYsYTT/EyHnjv2HgNUvobeb8tLYYaqVnvQlKN+1LUVdl6TT
         +kRekcw61omf85S4VEMzD8Wt3NAYxTA496oos/8fgBqtsKuhGdAoxnjXMP7kmC/E+bBS
         /boQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758214143; x=1758818943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naIqebnGtYpPO+MaA406hG6ahEfDSUj1Dkgs34ZLmFA=;
        b=sMOLkpf/mlG7pCCmWFPSIekLKLnUD8leX1BE+pE1EVlZNkkqlI0nnl+M4wjmncMTNK
         u3GUd8eHXfWlwKFFdrQMxvjgNRsO47elrQrh48ccL9x+KdjPOsX0r4jeaRXj5z+acg5l
         8Ik6WyvFM9GXHxswfxvhg/BIPFg7HVa5UNyddEal/FPd8llFFKQgtp9xs+ELL2ihngae
         /rz2gnR0NyaXkq7n0/UgMZaRaqDLRGDlYpj+88QpgWMayDAiFo6W8Mf6igNy4SZSKsQs
         e9nczM1NIsHJurEtZdAiVOgXUXfuabObhmImLwnDLoNqBpMRsPo1m/qBygMbHx086WNq
         NCzw==
X-Gm-Message-State: AOJu0YzKAirgTm4wxQYcXu3efllwZMdowqX+30nai75Ndtg8hdNomfIw
	4fv+dbxGKIpr2tJpaldFCCIZzBu3ZCcB1PfyWbGieyOXfgw68PkGtdoEu9KrOWmV
X-Gm-Gg: ASbGncs+0CbbE43WwGEBEq8q/CcsMt9gcUp3zF59w5PHQna9+Um+lnexWwZLGwnrcLi
	j7PABoRSpmB42LsksGZpv/wLWZ8Idg8Ej7Vl4JfaZTDfovDoF8FA4xOEk5UwBluQklL6n+BnwSW
	PfRwl4AryFcqPgvKYZvCSrngCifyEDT7AzBe9v9YjDkgluLTevuFrhgofQwFLRxUXrDmPko/glR
	3bX1o7FF5B5SCn9i6axQRdKS9Pw5UQm7oCPcqZH2fGBV/Xb3vt1JCqhu0geG7hCttRFVLqk8OVj
	KxM8obEwUUokPt/P6FpqdOKk/hQDY8wLBnT0XSAo2Pt5eVtJ5gsm6rOhYLMTYtJo0p1VS9T1Jqh
	VjnCpz2GbVZ7Je0D+vdV2zLFnVTJl4FkODT/McsupH/BfAPHHobxL9PI9jBu2TOebTWQgt+/fWt
	wXSCbV51mCNwvkzKBFHW/v2oGR7FsEQMfE60x/EQ==
X-Google-Smtp-Source: AGHT+IGXtlyFgtPgr+6FfbpqPTWYinIxctSQjgG9MpeP/pjFgZmOEEcDDi5agSwAzZjVKqw9av/N9w==
X-Received: by 2002:a05:600c:b85:b0:45f:2c89:a873 with SMTP id 5b1f17b1804b1-462074c572bmr57451885e9.35.1758214143183;
        Thu, 18 Sep 2025 09:49:03 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00c3e9035ed76de3f3.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:c3e9:35e:d76d:e3f3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f16272e4sm55873205e9.9.2025.09.18.09.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 09:49:02 -0700 (PDT)
Date: Thu, 18 Sep 2025 18:49:00 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v3 4/5] selftests/bpf: Support non-linear flag in
 test loader
Message-ID: <0e922e8254e068b52dcbd19732e4e7002ef716e2.1758213407.git.paul.chaignon@gmail.com>
References: <cover.1758213407.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1758213407.git.paul.chaignon@gmail.com>

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
index 1004c4a64aaf..570906607c20 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -119,6 +119,9 @@
  *                   Several __arch_* annotations could be specified at once.
  *                   When test case is not run on current arch it is marked as skipped.
  * __caps_unpriv     Specify the capabilities that should be set when running the test.
+ *
+ * __linear_size     Specify the size of the linear area of non-linear skbs, or
+ *                   0 for linear skbs.
  */
 #define __msg(msg)		__attribute__((btf_decl_tag("comment:test_expect_msg=" XSTR(__COUNTER__) "=" msg)))
 #define __xlated(msg)		__attribute__((btf_decl_tag("comment:test_expect_xlated=" XSTR(__COUNTER__) "=" msg)))
@@ -150,6 +153,7 @@
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
index e065b467d509..5fe1c3cd4605 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -42,6 +42,7 @@
 #define TEST_TAG_EXPECT_STDERR_PFX_UNPRIV "comment:test_expect_stderr_unpriv="
 #define TEST_TAG_EXPECT_STDOUT_PFX "comment:test_expect_stdout="
 #define TEST_TAG_EXPECT_STDOUT_PFX_UNPRIV "comment:test_expect_stdout_unpriv="
+#define TEST_TAG_LINEAR_SIZE "comment:test_linear_size="
 
 /* Warning: duplicated in bpf_misc.h */
 #define POINTER_VALUE	0xbadcafe
@@ -100,6 +101,7 @@ struct test_spec {
 	int mode_mask;
 	int arch_mask;
 	int load_mask;
+	int linear_sz;
 	bool auxiliary;
 	bool valid;
 };
@@ -632,6 +634,11 @@ static int parse_test_spec(struct test_loader *tester,
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
 
@@ -906,10 +913,11 @@ static bool is_unpriv_capable_map(struct bpf_map *map)
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
@@ -919,6 +927,12 @@ static int do_prog_test_run(int fd_prog, int *retval, bool empty_opts)
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
@@ -1168,7 +1182,8 @@ void run_subtest(struct test_loader *tester,
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


