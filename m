Return-Path: <bpf+bounces-19495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2E982C6F2
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 23:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9272A1C21F00
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 22:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A8D17726;
	Fri, 12 Jan 2024 22:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZU3KvNoR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8216175A3
	for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 22:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5cdfed46372so5437065a12.3
        for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 14:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705096898; x=1705701698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d8gZOgcUrgihaYXOb3ZMBT6Hyk2qViNqyq9lVjvfPcQ=;
        b=ZU3KvNoRGMUmXofculP3BB7o4mqzVQ0Z2aHNzs79vDFi/HWMvMgin6ArQ2VpzLgBJi
         CEi9Z7oN0mTv51Lcx7w1Fbb/ZoLbHWQuqsyd4dfV5dZgEOab7R4+q5VPjbFnw/G0hEp4
         jqZhXHOWBBDfsGZwp7bTG3USPse3CDgrAVR28+aWpvDFENx+r7pdK2Wy+V1h5l136MyK
         kJNr1IITfMRL/lFbLxBcGZpLJ0E25W1cQowrFZ5OAUw2EyBJo3fORoonbYn7gbQvJWSC
         6WG45sCQ0vepID9Jvyi2G8SgRlI6GGySNphlIEQejmXCgLgE04VmCVVfVFTpOeHk9PYu
         kOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705096898; x=1705701698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d8gZOgcUrgihaYXOb3ZMBT6Hyk2qViNqyq9lVjvfPcQ=;
        b=Z8o8xlE9BtGp9cvEJeqnJb9prGZqIrrbcQcODuIV41L4QXIi65YGa8zW+VDifEm/TB
         zpWVz1WcwTQ0ud9XjszfIkSX4O+xSRzMbZb+UYqHHoWQP7DSfBXCef+oj04uU3rI2GR6
         Pw2B2V/HvRyCgxNgOfd5TfMU3r1SMkowcUHHFxHw4oB2w4QUucmb9BMmsof5I2QTBhed
         Cpjq4s7bhK7NJ5bYL2bnhLw/5bZDai02SW+GDAC3i168n7zviEc9z1ej2xeJEQYbzOvD
         ipJGvFJ52tkdIe1pVjqQlNF/XxuwW6CupG4YrSDdWZOL4qnMp/KAJR8GmJ5GzbzDLTcI
         oBxg==
X-Gm-Message-State: AOJu0YxXCIMUxidqkYJ+UhbsLVHGEKPmVpf664F8vZBQ9S4pqpqftjvL
	dCy97/+EpqMabvggiLbJe/+mXepQB1A=
X-Google-Smtp-Source: AGHT+IFaQPk1Uy8nNMq0p9v0uLUOUnMjXN+OdisNHVbnxEI799MXbPaMWanpz2Xf6dKJeUj5+qrxIg==
X-Received: by 2002:a05:6a20:d411:b0:19a:4508:775 with SMTP id il17-20020a056a20d41100b0019a45080775mr1511380pzb.73.1705096897799;
        Fri, 12 Jan 2024 14:01:37 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::4:9b3a])
        by smtp.gmail.com with ESMTPSA id nd15-20020a17090b4ccf00b0028e2827c8d1sm25805pjb.35.2024.01.12.14.01.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 12 Jan 2024 14:01:37 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next] bpf: Minor improvements for bpf_cmp.
Date: Fri, 12 Jan 2024 14:01:34 -0800
Message-Id: <20240112220134.71209-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Few minor improvements for bpf_cmp() macro:
. reduce number of args in __bpf_cmp()
. rename NOFLIP to UNLIKELY
. add a comment about 64-bit truncation in "i" constraint
. use "ri" constraint for sizeof(rhs) <= 4
. improve error message for bpf_cmp_likely()

Before:
progs/iters_task_vma.c:31:7: error: variable 'ret' is uninitialized when used here [-Werror,-Wuninitialized]
   31 |                 if (bpf_cmp_likely(seen, <==, 1000))
      |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../bpf/bpf_experimental.h:325:3: note: expanded from macro 'bpf_cmp_likely'
  325 |                 ret;
      |                 ^~~
progs/iters_task_vma.c:31:7: note: variable 'ret' is declared here
../bpf/bpf_experimental.h:310:3: note: expanded from macro 'bpf_cmp_likely'
  310 |                 bool ret;
      |                 ^

After:
progs/iters_task_vma.c:31:7: error: invalid operand for instruction
   31 |                 if (bpf_cmp_likely(seen, <==, 1000))
      |                     ^
../bpf/bpf_experimental.h:324:17: note: expanded from macro 'bpf_cmp_likely'
  324 |                         asm volatile("r0 " #OP " invalid compare");
      |                                      ^
<inline asm>:1:5: note: instantiated into assembly here
    1 |         r0 <== invalid compare
      |            ^

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../testing/selftests/bpf/bpf_experimental.h  | 21 +++++++++++--------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index f44875f8b367..0d749006d107 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -260,11 +260,11 @@ extern void bpf_throw(u64 cookie) __ksym;
 
 #define __is_signed_type(type) (((type)(-1)) < (type)1)
 
-#define __bpf_cmp(LHS, OP, SIGN, PRED, RHS, DEFAULT)						\
+#define __bpf_cmp(LHS, OP, PRED, RHS, DEFAULT)						\
 	({											\
 		__label__ l_true;								\
 		bool ret = DEFAULT;								\
-		asm volatile goto("if %[lhs] " SIGN #OP " %[rhs] goto %l[l_true]"		\
+		asm volatile goto("if %[lhs] " OP " %[rhs] goto %l[l_true]"		\
 				  :: [lhs] "r"((short)LHS), [rhs] PRED (RHS) :: l_true);	\
 		ret = !DEFAULT;									\
 l_true:												\
@@ -276,7 +276,7 @@ l_true:												\
  * __lhs OP __rhs below will catch the mistake.
  * Be aware that we check only __lhs to figure out the sign of compare.
  */
-#define _bpf_cmp(LHS, OP, RHS, NOFLIP)								\
+#define _bpf_cmp(LHS, OP, RHS, UNLIKELY)								\
 	({											\
 		typeof(LHS) __lhs = (LHS);							\
 		typeof(RHS) __rhs = (RHS);							\
@@ -285,14 +285,17 @@ l_true:												\
 		(void)(__lhs OP __rhs);								\
 		if (__cmp_cannot_be_signed(OP) || !__is_signed_type(typeof(__lhs))) {		\
 			if (sizeof(__rhs) == 8)							\
-				ret = __bpf_cmp(__lhs, OP, "", "r", __rhs, NOFLIP);		\
+				/* "i" will truncate 64-bit constant into s32,			\
+				 * so we have to use extra register via "r".			\
+				 */								\
+				ret = __bpf_cmp(__lhs, #OP, "r", __rhs, UNLIKELY);		\
 			else									\
-				ret = __bpf_cmp(__lhs, OP, "", "i", __rhs, NOFLIP);		\
+				ret = __bpf_cmp(__lhs, #OP, "ri", __rhs, UNLIKELY);		\
 		} else {									\
 			if (sizeof(__rhs) == 8)							\
-				ret = __bpf_cmp(__lhs, OP, "s", "r", __rhs, NOFLIP);		\
+				ret = __bpf_cmp(__lhs, "s"#OP, "r", __rhs, UNLIKELY);		\
 			else									\
-				ret = __bpf_cmp(__lhs, OP, "s", "i", __rhs, NOFLIP);		\
+				ret = __bpf_cmp(__lhs, "s"#OP, "ri", __rhs, UNLIKELY);		\
 		}										\
 		ret;										\
        })
@@ -304,7 +307,7 @@ l_true:												\
 #ifndef bpf_cmp_likely
 #define bpf_cmp_likely(LHS, OP, RHS)								\
 	({											\
-		bool ret;									\
+		bool ret = 0;									\
 		if (__builtin_strcmp(#OP, "==") == 0)						\
 			ret = _bpf_cmp(LHS, !=, RHS, false);					\
 		else if (__builtin_strcmp(#OP, "!=") == 0)					\
@@ -318,7 +321,7 @@ l_true:												\
 		else if (__builtin_strcmp(#OP, ">=") == 0)					\
 			ret = _bpf_cmp(LHS, <, RHS, false);					\
 		else										\
-			(void) "bug";								\
+			asm volatile("r0 " #OP " invalid compare");				\
 		ret;										\
        })
 #endif
-- 
2.34.1


