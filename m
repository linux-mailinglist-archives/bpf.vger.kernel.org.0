Return-Path: <bpf+bounces-70695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAE0BCAC4A
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 22:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 98343353537
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 20:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0523264A7F;
	Thu,  9 Oct 2025 20:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCOmyOyE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78237264619
	for <bpf@vger.kernel.org>; Thu,  9 Oct 2025 20:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760040724; cv=none; b=VDamF9sJnfo2CBqUJCnf4HaPkNat4j6eeoAGqWc5MhyEv3CSVrCKTogITAoxhlcDtoYFIqzhQBtRpCyhueX5iBoUAOVyS+6ZX1hTz3PY2NEP/8hmLCZtzD6X6IqZbr2z8Ysq7S9CJWy/OXgVPoHGQKys1/ksvYM7IWTWAKh8zfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760040724; c=relaxed/simple;
	bh=qscwDyuxuArD0LugcbclR7EMndgMiifQsOv329VVpcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTbrOFUtr4yTMdHkJ0GW1debeN0yB2GPC9UtQjwFeEemkkdmH0geIPP392lqz+PbG4bIWiLOvTlI2I7Y5Q/V8TxHa8WjoPJzjCHYDXwBrG1JvGZ59On3VklAAK/BfAy5WRk1yUIhAafl17hTuvsZSggrL4HgpjrlM3wwmiVYhLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCOmyOyE; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ee12332f3dso109815f8f.2
        for <bpf@vger.kernel.org>; Thu, 09 Oct 2025 13:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760040721; x=1760645521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bh716rRoqAtspxmpt1DV/WxEDSiF98ZZB/p6o3fNybI=;
        b=RCOmyOyE+33VAYgeaCKvgAFCALEp6+uNV7w0BLFdWngFokN4ABAg961yXtD2zfU67p
         05drY09GlkqD1yVIpjuQ7zz0HGGx3qwJoC13N/p11aeuhQeZVfcZ3Tsa2CvV8w22phOu
         xilK2sg5rkzJTB/i5RTpVK3JXsu0VHh0+rIgsv2PlyAVyEX7ii4ms7Nkh1S9bJh1dlnY
         lWhFzr+l2mqgdTBkGVCd6Tu4sAWIYWuLajCg0yJ+r8tdhpb39GjE8j6x2+yBX7fUtCza
         Od7/JrAS1tlpyExlgEfMlPdxG/1zOwnfIXikxI/ujL7Tj6yAvPK8/JPY0JE7ptFdarKK
         nCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760040721; x=1760645521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bh716rRoqAtspxmpt1DV/WxEDSiF98ZZB/p6o3fNybI=;
        b=ErAMeq+Wj27bCUb1xt99jDHaZxMY5l/pOzxtUBrtxmMWOCkOLS0cxTjMLL3r/dMrIC
         AVt3ImrJcPYdNQyOr1wKG6nM/0NN2jR/jx+cFy6FZxHkQwW93tTeIwPyn+pmXAIFrCBj
         iyzq+AiFYguysuKNsd2CL5aQH/D0dARsjmgEqajdPoQY5SI1uBVQb8I+NnSBb1VOerlp
         uQidxr9Xq9vezWSfRD/J2HzkLaL//5JCam/gZ502VxnkjR6ieKuMtGukq48N50b8LhEF
         61NJjjaPp54SV0zPlYKfWRsBrTynJ8Cck1u7FH2Gk1oROX8NsatdSPT1omEckg0uizjN
         wHcQ==
X-Gm-Message-State: AOJu0YykBPf6VwnBfSJHJIRKX5iCPJfZHL2S4tcGWDrWcTufxCPLu94t
	LaR2yr/zlvCE2tfMMpYC0WnFaT7QhEKwgmh8JIWmJTzykzYPd6vGHPCAK+jwvQ==
X-Gm-Gg: ASbGncu8XU09b5LflPxKtvIifE3QJ6l8YpR/DGkUpS4JkaxwFbpGpm/HHs361A4axGS
	/jjbCTEzGo46I74OfazZgbej7R/b/5e/jdnCWaSiJyZx+37ZfmKKdvyM9BOHU33AAGKZg1lJ3Rc
	B3afDead6Zy4A7VXldAgjFW7pU8N8YmH3p8PzMN/D4ToB6SntlatHJolELn029LpCcivBrXpWhh
	qjDt+DXcDlxyMvC2btIjaAt6b2HzrJxWP/eQdv8mnsleUJYf6jREVMhAORQLvUg/StZFhkDiKbE
	K1SAWmCrdTYN0L8FMSOCxr60tE2utRkLoeyVYS/YsFSjL89b16TFQ+fXqyh3Gb6PuEv5Yszd8XW
	K93dkFns/ec0pYLxTpSVyHBsfeEvhh8y2cnUb6WyXG9r7dA6hE/jds5aP8+Npyse7vQ7vOLCTSV
	voycVd5uLEHyvsWrJVJqf0mZrZ9q9BzbT4R/wjhOA3Z8I7gA==
X-Google-Smtp-Source: AGHT+IGCqTZ3XUfG6Z8oNghXlQovWTBmpBik3Sq54tNQ4IsBzm303H5CR/aR+cDTUaKe4kZjcSi5JA==
X-Received: by 2002:a05:6000:2505:b0:3ee:1279:6e68 with SMTP id ffacd0b85a97d-42672425b82mr5757379f8f.47.1760040720669;
        Thu, 09 Oct 2025 13:12:00 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00b81184fd69385167.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:b811:84fd:6938:5167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce582b44sm613335f8f.16.2025.10.09.13.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 13:12:00 -0700 (PDT)
Date: Thu, 9 Oct 2025 22:11:58 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v8 4/5] selftests/bpf: Support non-linear flag in
 test loader
Message-ID: <7ad928ec7591daef4f1b84032aeb86c918b3e5a7.1760037899.git.paul.chaignon@gmail.com>
References: <cover.1760037899.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1760037899.git.paul.chaignon@gmail.com>

This patch adds support for a new tag __linear_size in the test loader,
to specify the size of the linear area in case of non-linear skbs. If
the tag is absent or null, a linear skb is crafted.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  4 +++
 .../bpf/progs/verifier_direct_packet_access.c |  1 +
 tools/testing/selftests/bpf/test_loader.c     | 29 +++++++++++++++++--
 3 files changed, 32 insertions(+), 2 deletions(-)

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
index 74ecc281bb8c..338c035c3688 100644
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
@@ -633,6 +635,21 @@ static int parse_test_spec(struct test_loader *tester,
 					      &spec->unpriv.stdout);
 			if (err)
 				goto cleanup;
+		} else if (str_has_pfx(s, TEST_TAG_LINEAR_SIZE)) {
+			switch (bpf_program__type(prog)) {
+			case BPF_PROG_TYPE_SCHED_ACT:
+			case BPF_PROG_TYPE_SCHED_CLS:
+			case BPF_PROG_TYPE_CGROUP_SKB:
+				val = s + sizeof(TEST_TAG_LINEAR_SIZE) - 1;
+				err = parse_int(val, &spec->linear_sz, "test linear size");
+				if (err)
+					goto cleanup;
+				break;
+			default:
+				PRINT_FAIL("__linear_size for unsupported program type");
+				err = -EINVAL;
+				goto cleanup;
+			}
 		}
 	}
 
@@ -1007,10 +1024,11 @@ static bool is_unpriv_capable_map(struct bpf_map *map)
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
@@ -1020,6 +1038,12 @@ static int do_prog_test_run(int fd_prog, int *retval, bool empty_opts)
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
@@ -1269,7 +1293,8 @@ void run_subtest(struct test_loader *tester,
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


