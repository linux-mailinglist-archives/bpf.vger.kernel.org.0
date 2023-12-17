Return-Path: <bpf+bounces-18104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6886815CED
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 02:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E7221C21727
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 01:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F2D4C9D;
	Sun, 17 Dec 2023 01:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQeduErv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8BD4C60
	for <bpf@vger.kernel.org>; Sun, 17 Dec 2023 01:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28af0b2898aso1639192a91.3
        for <bpf@vger.kernel.org>; Sat, 16 Dec 2023 17:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702775197; x=1703379997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zm6BsEjws0gUSzD+v+xg2vDh2b439uQnbOX/U36snoQ=;
        b=KQeduErv/0U1uMiFWv8QshNcLsznOVud1rqYckoi+yZlmXoytqY4DXj4XkVcMGIbq5
         55FqPVdkOqQHdog3v0CLkvy3uEkcslcsCP4Cbx1hAoviOiMtJH/seultcryS8SYq/PH7
         mBB36dyVPs9lkVT1T0WjysBTQRaHiwnrzbdg6A/eozyiiE4ZZYZqcBtIzthMLdu4Ry5u
         Hz/eBJ/8J+5Fw+RtpqKO0R03nthiuOwWjqVXGd5QnNfs9yDZnixp4YIzoSXtm/Qd3ccc
         v1w/NurBsgh8/Vi+3sN5tE5Gt0A/ZGjpttrGROXvQSJU0KdK/5XB9qPq+qVxwBkwArs8
         oqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702775197; x=1703379997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zm6BsEjws0gUSzD+v+xg2vDh2b439uQnbOX/U36snoQ=;
        b=MisbR6iWrmUydcNMI1T+7frccMO1fdEwRHvMtXpCt8lSW92i7+lVwmSeMrkuNeREqg
         7m1xxl/2V8DOy7AbniTiQ0UsT0YHZYKxex3AHx0ydWbNjjSxpg02kzR4IL3n8rjH6U4p
         kKp8yT4KllVHJl7Qr66XZ4r9PLfBLEdSlhZnMbhtWv0+79v94zAgs03I+Q0+dEBNqEAv
         /iWQHjkMTT4sMRnzT6ZMNBaH6v4KWFJhBu5JCys1owtYiNv2tgTT/ai94DONd4mGeIuO
         PhkD3drfWKhSe72S8BgFMDLmPg0yHLjVLfviWRRAZBQGf5yXy7s0T86h9737DOEAMT3s
         +WPA==
X-Gm-Message-State: AOJu0YzD8E0ZphQKinINYMJQzwumSBWX/r4NHGIo2Mst8S8wMElI0BmX
	f42gkEFOBIqP09YBtz5qt/Td4DBH6Jw=
X-Google-Smtp-Source: AGHT+IHa/BAvkSuuKMDJJbLy0io8mf/E9bO5+JcVlw+YLmG/jp5e5p1J/YbttA8iM+KQ+/vGafdEsQ==
X-Received: by 2002:a17:90b:4b0e:b0:28b:4a3e:28c with SMTP id lx14-20020a17090b4b0e00b0028b4a3e028cmr608191pjb.7.1702775197245;
        Sat, 16 Dec 2023 17:06:37 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::4:b48d])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a199700b0028afd8b1e0bsm6819541pji.57.2023.12.16.17.06.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 16 Dec 2023 17:06:36 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	dxu@dxuuu.xyz,
	memxor@gmail.com,
	john.fastabend@gmail.com,
	kernel-team@fb.com
Subject: [PATCH bpf-next] bpf: Introduce "volatile compare" macro
Date: Sat, 16 Dec 2023 17:06:32 -0800
Message-Id: <20231217010632.72047-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Compilers optimize conditional operators at will, but often bpf programmers
want to force compilers to keep the same operator in asm as it's written in C.
Introduce CMP(var1, conditional_op, var2) macro that can be used as:

-               if (seen >= 1000)
+               if (CMP(seen, >=, 1000))

The macro takes advantage of BPF assembly that is C like.

The macro checks the sign of variable 'seen' and emits either
signed or unsigned compare.

For example:
int a;
CMP(a, >, 0) will be translted to 'if rX s> 0 goto' in BPF assembly.

unsigned int a;
CMP(a, >, 0) will be translted to 'if rX > 0 goto' in BPF assembly.

The right hand side isn't checked yet. The macro needs more safety checks.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---

As next step we can remove all of bpf_assert_ne|eq|... macros.
Also I'd like to remove bpf_assert_with. Open coding it is imo cleaner.

 .../testing/selftests/bpf/bpf_experimental.h  | 28 +++++++++++++++++++
 .../testing/selftests/bpf/progs/exceptions.c  | 20 ++++++-------
 .../selftests/bpf/progs/iters_task_vma.c      |  3 +-
 3 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 1386baf9ae4a..a3248b086e4b 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -254,6 +254,34 @@ extern void bpf_throw(u64 cookie) __ksym;
 		}									\
 	 })
 
+#define __eauality(x) \
+	__builtin_strcmp(#x, "==") == 0 || __builtin_strcmp(#x, "!=") == 0
+
+#define is_signed_type(type) (((type)(-1)) < (type)1)
+
+#define __CMP(LHS, OP, SIGN, RHS) \
+	({ \
+		__label__ l_true; \
+		bool ret = true; \
+		asm volatile goto("if %[lhs] " SIGN #OP " %[rhs] goto %l[l_true]" \
+				  :: [lhs] "r"(LHS), [rhs] "ri"(RHS) :: l_true); \
+		ret = false; \
+l_true:\
+		ret;\
+       })
+
+#define CMP(LHS, OP, RHS) \
+	({ \
+		bool ret; \
+		if (__eauality(OP)) \
+			ret = __CMP(LHS, OP, "", RHS); \
+		else if (is_signed_type(typeof(LHS))) \
+			ret = __CMP(LHS, OP, "s", RHS); \
+		else \
+			ret = __CMP(LHS, OP, "", RHS); \
+		ret; \
+       })
+
 /* Description
  *	Assert that a conditional expression is true.
  * Returns
diff --git a/tools/testing/selftests/bpf/progs/exceptions.c b/tools/testing/selftests/bpf/progs/exceptions.c
index 2811ee842b01..4b55757eadbd 100644
--- a/tools/testing/selftests/bpf/progs/exceptions.c
+++ b/tools/testing/selftests/bpf/progs/exceptions.c
@@ -210,7 +210,7 @@ __noinline int assert_zero_gfunc(u64 c)
 {
 	volatile u64 cookie = c;
 
-	bpf_assert_eq(cookie, 0);
+	bpf_assert(CMP(cookie, ==, 0));
 	return 0;
 }
 
@@ -218,7 +218,7 @@ __noinline int assert_neg_gfunc(s64 c)
 {
 	volatile s64 cookie = c;
 
-	bpf_assert_lt(cookie, 0);
+	bpf_assert(CMP(cookie, <, 0));
 	return 0;
 }
 
@@ -226,7 +226,7 @@ __noinline int assert_pos_gfunc(s64 c)
 {
 	volatile s64 cookie = c;
 
-	bpf_assert_gt(cookie, 0);
+	bpf_assert(CMP(cookie, >, 0));
 	return 0;
 }
 
@@ -234,7 +234,7 @@ __noinline int assert_negeq_gfunc(s64 c)
 {
 	volatile s64 cookie = c;
 
-	bpf_assert_le(cookie, -1);
+	bpf_assert(CMP(cookie, <=, -1));
 	return 0;
 }
 
@@ -242,7 +242,7 @@ __noinline int assert_poseq_gfunc(s64 c)
 {
 	volatile s64 cookie = c;
 
-	bpf_assert_ge(cookie, 1);
+	bpf_assert(CMP(cookie, >=, 1));
 	return 0;
 }
 
@@ -258,7 +258,7 @@ __noinline int assert_zero_gfunc_with(u64 c)
 {
 	volatile u64 cookie = c;
 
-	bpf_assert_eq_with(cookie, 0, cookie + 100);
+	bpf_assert_with(CMP(cookie, ==, 0), cookie + 100);
 	return 0;
 }
 
@@ -266,7 +266,7 @@ __noinline int assert_neg_gfunc_with(s64 c)
 {
 	volatile s64 cookie = c;
 
-	bpf_assert_lt_with(cookie, 0, cookie + 100);
+	bpf_assert_with(CMP(cookie, <, 0), cookie + 100);
 	return 0;
 }
 
@@ -274,7 +274,7 @@ __noinline int assert_pos_gfunc_with(s64 c)
 {
 	volatile s64 cookie = c;
 
-	bpf_assert_gt_with(cookie, 0, cookie + 100);
+	bpf_assert_with(CMP(cookie, >, 0), cookie + 100);
 	return 0;
 }
 
@@ -282,7 +282,7 @@ __noinline int assert_negeq_gfunc_with(s64 c)
 {
 	volatile s64 cookie = c;
 
-	bpf_assert_le_with(cookie, -1, cookie + 100);
+	bpf_assert_with(CMP(cookie, <=, -1), cookie + 100);
 	return 0;
 }
 
@@ -290,7 +290,7 @@ __noinline int assert_poseq_gfunc_with(s64 c)
 {
 	volatile s64 cookie = c;
 
-	bpf_assert_ge_with(cookie, 1, cookie + 100);
+	bpf_assert_with(CMP(cookie, >=, 1), cookie + 100);
 	return 0;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/iters_task_vma.c b/tools/testing/selftests/bpf/progs/iters_task_vma.c
index e085a51d153e..d85e29e979b7 100644
--- a/tools/testing/selftests/bpf/progs/iters_task_vma.c
+++ b/tools/testing/selftests/bpf/progs/iters_task_vma.c
@@ -28,9 +28,8 @@ int iter_task_vma_for_each(const void *ctx)
 		return 0;
 
 	bpf_for_each(task_vma, vma, task, 0) {
-		if (seen >= 1000)
+		if (CMP(seen, >=, 1000))
 			break;
-		barrier_var(seen);
 
 		vm_ranges[seen].vm_start = vma->vm_start;
 		vm_ranges[seen].vm_end = vma->vm_end;
-- 
2.34.1


