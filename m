Return-Path: <bpf+bounces-68318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC539B56A0F
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 17:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B9D7177CD8
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 15:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B970A2D641F;
	Sun, 14 Sep 2025 15:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7cLB39f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4F84502A
	for <bpf@vger.kernel.org>; Sun, 14 Sep 2025 15:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757862721; cv=none; b=e1MGrD89uBenHMLyo4fZq+g34/dPS9WH112TRUPgKxvrKSwGVwIxSgqXSRqj99uWyAUAGg/C+uaMxd1adPEm1qLbIThkHWAEWTdWus5vkikQ87ztx9Ckdp2lC4Ez+mAD778kDUnYkwmYaP6TlaR1ATDWp6CtrhscFp+YrWrjmR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757862721; c=relaxed/simple;
	bh=J02GcIHOFWdXQS5oGViQV3auoxKjdOax3QiVQeq5PQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fU7Yhe+doqjZuF7SDzKp2AbniVix1HrxFDl6mvxU6M8XlLE+CV2RJgKED2qSzAF4c7gk3226n4CfkzgoRE2r3ei/V++WPQhWNLxs+nVuYc1wO8RAH1IVUrtlhOZaC2+uPQlGa/iUsuNQzoHRyhMxy4wM0sW9F53JcLVbwvU2xzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7cLB39f; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3df726ecff3so1838309f8f.3
        for <bpf@vger.kernel.org>; Sun, 14 Sep 2025 08:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757862718; x=1758467518; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lyNVziChjjSABEOANmocjwPsfc1Pbd29gfmRge+GjtQ=;
        b=k7cLB39frtU0GArO2KvPOkhmKQqpV+hR2tfWx6nLbxl5MQx4guRh/FWLgsKF2S7/kR
         WY0lJyXkZNpoZnSOI8jTF5mIo9/sspgjUzqlQRglhhKwQ8vXtFxqNxrp+prAc2UItEz+
         qI+ea/SEaAHl2Et45v3gJ5bi6PoW924tKrXvA9Qf1js/bPpLWSP2bho+l2mqSaOfb/ZD
         5t8Kfhnlw4fBl1kQwystzQzLNl8tIlRFm33+No93BV/ABuF33egVKfaglio5rIE9ejyn
         Z61/ITxrbafvbYLoy8kHBJ6dHALU3Jk1ckJIWeTFXtKHkOpRaheDCoIDCT/K2xRF1qnr
         GRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757862718; x=1758467518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lyNVziChjjSABEOANmocjwPsfc1Pbd29gfmRge+GjtQ=;
        b=p1rxr+UDxDhTkb5nFg1XEezXbSgS4T+DCWTt1hsTLoZvEzJ5+hPXJF8MYgDnbr0G5p
         ASvZ/lW/vEbSpZx5VHNGJ/B3SHY2AEsUi7okaJn+DFqLCBK05Fh8WjNXMcItr3OZC+w5
         pJbqRl7Wa1hWtS+XRz1p6/I8W9ada4+QEG8WZBS/pe+YaZvVd3AnpkgYWbotFV6lBfEb
         tzUKagULc92PjWeK/OTzH3jryxYkdMwb3wakZ/zdBRqEsEwmwEURM4eUd8+nMtKHES6R
         a94n8H+5F2zwebd4fc5JqL2FHzpR5EO9FFqXzclv6kNhePUe1+mX1sGngXGFqwUKGxnQ
         U+og==
X-Gm-Message-State: AOJu0YwSskEs+c0yK+YKfb3e6ravhflw2at8mmY3eiSiuMEWHmJ4zhZe
	KjZ4tHBVOCnYVh+rU0dDQuTmoffoQSdq2u5Y3T27kx7qMGgOEK1wwxtWjj1jL51G
X-Gm-Gg: ASbGnctv+Hp/HIkv47B31Inn6eXsG1QYny4665vxMziGisrQnfVlqs0HsDNNCUXJLHN
	QQ+Ok0MXZOpJumdfNcsDiDtUw/RHs4huuKBFQqHX6N5mu0v/pb9Pkjn9TiB5VkvQRSQoof45seL
	BXX9uBFXQ91iZhD1Lo0QPEiuCjLmtIYNi5FmQCVeH4bYeU/huXDAmlyLlpTYLDKtJXPS/XtggZa
	g9DCsZpaPi9n4a1UqJcsn3LNtzROuQMCmjBdDW+kV12uZ4wAEGRI2K96wtJADgrHts7vFion+WW
	wpEuCTJpaf6223aqFWRY+asn6Kcn+7aHI6/yoXqZ+EABDhBss1RZDD22VROz4oWjhw4h5c5ivl0
	by78cd6jzU1bCJi5EdkJzu2dw85Cn8slHhaV7ra2+46KYgJCNwvYO44u3FyZTC/pdWarSq9wWtm
	J6MS1oSb/zM3vC2GloSBwM1K8jJTSzlw==
X-Google-Smtp-Source: AGHT+IGNG96UUyhETWjpevJwXRkx4w4qbMvzz8jcRfUb2PjC3zT/P4pKX2ii60/Gyvq341EVolVIOw==
X-Received: by 2002:a05:6000:1885:b0:3c8:29eb:732e with SMTP id ffacd0b85a97d-3e765a08791mr8000102f8f.59.1757862717387;
        Sun, 14 Sep 2025 08:11:57 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00829f05581a33a178.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:829f:558:1a33:a178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f27f44624sm63448525e9.3.2025.09.14.08.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 08:11:56 -0700 (PDT)
Date: Sun, 14 Sep 2025 17:11:55 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v2 3/4] selftests/bpf: Support non-linear flag in
 test loader
Message-ID: <25ff4576263461f0461ad3387c025a0a903bf77e.1757862238.git.paul.chaignon@gmail.com>
References: <cover.1757862238.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1757862238.git.paul.chaignon@gmail.com>

This patch adds support for a new tag __linear_size in the test loader,
to specify the size of the linear area in case of non-linear skbs. If
the tag is absent or null, a linear skb is crafted.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  4 ++++
 .../bpf/progs/verifier_direct_packet_access.c |  1 +
 tools/testing/selftests/bpf/test_loader.c     | 20 +++++++++++++++++--
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 7905396c9cc4..5406f1e76048 100644
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
+#define __linear_size(sz)	__attribute__((btf_decl_tag("comment:test_linear_size="XSTR(sz))))
 
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
index e065b467d509..18117973cd16 100644
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
@@ -919,6 +927,13 @@ static int do_prog_test_run(int fd_prog, int *retval, bool empty_opts)
 		.repeat = 1,
 	);
 
+	if (linear_sz) {
+		topts.flags = BPF_F_TEST_SKB_NON_LINEAR;
+		ctx.data_end = linear_sz;
+		topts.ctx_in = &ctx;
+		topts.ctx_size_in = sizeof(ctx);
+	}
+
 	if (empty_opts) {
 		memset(&topts, 0, sizeof(struct bpf_test_run_opts));
 		topts.sz = sizeof(struct bpf_test_run_opts);
@@ -1168,7 +1183,8 @@ void run_subtest(struct test_loader *tester,
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


