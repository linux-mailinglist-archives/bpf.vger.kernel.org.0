Return-Path: <bpf+bounces-70155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48528BB1DB3
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 23:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E11A71C0134
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 21:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E72E311C20;
	Wed,  1 Oct 2025 21:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrZYuj3A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F0231195B
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 21:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759354300; cv=none; b=b3rEAXTE/ltP0khAyzOldoBarHYOcZ6j7004jT7ToN+XxfsdSY7T2i4XKYaI+e2wwEq5udjTmCo3mO5EYyHWsJZ/oMXCxefnm3z2qxl2wbEb4tp2JHcTJjkCga9kpz2gVZhIkL2FDXZkB/Ka5snxjEM9LNvlBUqvvZCt7aggv4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759354300; c=relaxed/simple;
	bh=np4B6Dcvwn1dTa2ukaBRLomS5/EqF3Vd2s46p5+oj2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSjchwNNwBzaJMfjqDLc33XkMvDw4Jn1Rae8xoeqqKfEgQKjmGt+LbVJ/N49Ld5rbOSSUSHUpzL9XQrOECm/avax2zqT3yAzx6bj1u/hoRsVIQjTLhrLXOzA+MKk5CEKa0DaG7DQ0oSBqVCnTVU9Qkjiknsy0WyeluDmbNBuDjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrZYuj3A; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e61ebddd6so2760095e9.0
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 14:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759354297; x=1759959097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ma+pbiVq6Y9+sUaOpiOPEynkbEVW/eMv8yb6AhQR5Wk=;
        b=mrZYuj3AvW6+DC4V3S+gLkI6UxhI0mo57bw1rHJaIQ+N3wxPW/WtHQmQaO9E4/RCD8
         cuvZ92LsrTCtEHGLs8HalznvbNfRIaRur8poSF2hMTwfTTU5k/VGirijOCziycHh0/dj
         Tb826SRJ3HtXx3tSS5XyLb6jQXU2LzWwZES7k48v9XscmEwVVu+P3gKAdyuBNDBwW5pZ
         jkhEwXsvCHEGIRUARPLUnPFnt66OALc1W5lHo4X8y5iFuA3nV20WBO8Nu5iRVJvogsjW
         y82pd2lOcah2yxTuHy1IlQq8FiMAUpCVL0UfhYJVbn3tgJquoYnM06EL/BLLCQS582wI
         yl3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759354297; x=1759959097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ma+pbiVq6Y9+sUaOpiOPEynkbEVW/eMv8yb6AhQR5Wk=;
        b=JjdeppjNtz9V4fwmqYsMq/XVBjw9WwJvXfgnFvH/Hnn72b+P2rrtiuegE2X9Jbd7vS
         vt15mmplap9doNmDEk74pcc4wxadPf2bx0vLashtr48BplwOfqeV3OsWa4vNHJ8/eWK8
         ufm4cDn3feL8F53HJ35UaWOcYfaQMRIRqdzp+laptRJBL/vzLJUaEMqUx937eqCWoPJ2
         /dzKQa8hCF/lNRYXDT0Qz74BxD7D7DZZTxZLKshTzqnGKDMmCqWOcQEIAnNm+msyH3Vo
         mdAJKg6mPNmCotxR9LidoE+xvaryDACtfDqGg8PGEtlPGsJnJxCqA1xJusEL0ZsBr4jP
         krFw==
X-Gm-Message-State: AOJu0YwHfXuoi7WSNneSLisfO4lEUxNn+r6KXhkyuZFuVO4++MV++aBN
	wda5YETXbOA2+ARjZMTa8/kxQ7oaUlISXg/hKLfBOmlVibwk/hJPRSyvU1GUYLfG
X-Gm-Gg: ASbGnctR3gHMy7NHjPznQuQBirkWoJJ1739dajxVycAcLNnGhsyMqb6Tt/GfUxWMtIa
	2D8nkndvxKU5vj8Xybxnfmt8c9jU419xbpmTUOUAC6hZWLaaR75yItrl6f0GzGE81jJ0T/eWQ+f
	EgKAkGKWjDdMXGnShPqEpmFc2h0kr4EtI0T0GwFV9Py44GF93Gip1uhK8vo9cjv2dL0ZDk/MeTn
	gLGgGAwWu+JuIfRhDzSPNSxCyuZjEVZSSFYSfBY4j29199MtCthVlbZO47EdA9sM5KU00dhPe2H
	pl0B1ytKm+mRQM42XpCGurp1fiRXROZN53cWTU1M7+oaLCuc4DiIt6RBQm6fZLI28znbZsW8efF
	W1yWPzC90x+G5DhKIgS/rfukp86NL69b+BOxwZ2+aAhz8VsshnKKGYhV+oAfSJt4CTOGUibQ1Jk
	AXTjOeN9WTrvx3r1fR8GAH+4C8jMy3O5YsjiUNSRvMWIvo
X-Google-Smtp-Source: AGHT+IFoQHggN18Sx+Jh7NMdKoIjEP/G0S/WWJPZk+/lfFmuQYyA8kb/PxHgrrBuDTjBgWmd/7wx4w==
X-Received: by 2002:a05:600c:1d1a:b0:45d:cfee:7058 with SMTP id 5b1f17b1804b1-46e612be155mr36287635e9.22.1759354297249;
        Wed, 01 Oct 2025 14:31:37 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e006ac507786c22ef92.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:6ac5:778:6c22:ef92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8abe49sm739293f8f.21.2025.10.01.14.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 14:31:36 -0700 (PDT)
Date: Wed, 1 Oct 2025 23:31:35 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v4 4/5] selftests/bpf: Support non-linear flag in
 test loader
Message-ID: <deb9c73f3bbcbdb36c550ac2bdc0a19c5b4ef17b.1759341538.git.paul.chaignon@gmail.com>
References: <cover.1759341538.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759341538.git.paul.chaignon@gmail.com>

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


