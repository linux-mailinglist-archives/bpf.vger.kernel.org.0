Return-Path: <bpf+bounces-18567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4A181C1E1
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 00:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E5011F223BB
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 23:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514687AE6B;
	Thu, 21 Dec 2023 23:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBXlA/yk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3597AE65
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 23:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78101108e3fso78462385a.1
        for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 15:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703200964; x=1703805764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5XSYGnAJtPlH2lyKrEfGNwaAGBYpV2eRC7RvNLtKf4=;
        b=KBXlA/ykEJWPc6pvdS7fJbk8wdIAyPRfqjdBxf97Llz18CwCh43e2BP7/WQ8JEWUBX
         Yg9/wcnVi3gpdERqv+olVCnde97F6YQVjq+3SJkmchPZAdyKaunBcD0+pcy9GtvqSJGQ
         1JoMLHxyfWDi1pmcw7Q/rDsj/DGT/En2jiuVGHNs5K/1icZ2b1S1Abf2Z8zyEIlCR0EV
         /0CU4pr+XG1SqQ3mJoXx5ItVo/srUxulkxvKB0J7DNqnku5szMRQ0QRDqL+eR9mhYdYe
         WVubuMU7tEYXQyIca1gXeNR9C+1GGVWIal54DOigh9w4Nf+FWm9cmhLnqfX9rtLfChDH
         ewkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703200964; x=1703805764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s5XSYGnAJtPlH2lyKrEfGNwaAGBYpV2eRC7RvNLtKf4=;
        b=C2ANKsYrWnD0wuBEPZ2n4C4FvGjg5ASb4VYYy5vADz4DNl3rm5Z0elZ4amPbljzN8A
         qwzj2b+68341qeshXMvR3O8TGY9bkvLI+//shDyrfBsoxMiZAvLx59gMsk8LqCnhzl/p
         prg9+/6hI7GdkRaQbuz1lKhzQFJ6d6OLeq7m8h2N9hrrw26m/S4RrSwRYAsebZBIFFIC
         jcErvRGBA5JaY3tqkYuluF15/DRr3iCNyrkSRe+iizhzQIuZB4MRugruY33HmvmNsZim
         bdA0c0uPchymY9Q+GixPPHNe4+Z8A0q/FsAmuSUyJZ6SyDv8jhvKTB6+U21DMVq5PVUd
         b8+A==
X-Gm-Message-State: AOJu0Yxiiw9cNeno0EUscrxPVMLmHP0U/FwxpbvjRAahgg/vTUyQmet4
	aE/+YLnSyU1NVzAQXOlFp7xjhfdroqk=
X-Google-Smtp-Source: AGHT+IGqjyNVbiiF5Uby4YOGhHUjUpkTlpoJhtu39fzsCddOsnBkZ7pzNjK/dzP6Un4aCXYT0ulpHg==
X-Received: by 2002:a05:620a:5598:b0:77f:b2ab:3f34 with SMTP id vq24-20020a05620a559800b0077fb2ab3f34mr584734qkn.48.1703200964284;
        Thu, 21 Dec 2023 15:22:44 -0800 (PST)
Received: from andrei-framework.taildd130.ts.net (098-030-123-082.res.spectrum.com. [98.30.123.82])
        by smtp.gmail.com with ESMTPSA id l12-20020a05620a0c0c00b00781121dcc24sm981281qki.119.2023.12.21.15.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 15:22:43 -0800 (PST)
From: Andrei Matei <andreimatei1@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii.nakryiko@gmail.com,
	eddyz87@gmail.com,
	Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf-next v4 2/2] bpf: add a possibly-zero-sized read test
Date: Thu, 21 Dec 2023 18:22:25 -0500
Message-Id: <20231221232225.568730-3-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231221232225.568730-1-andreimatei1@gmail.com>
References: <20231221232225.568730-1-andreimatei1@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a test for the condition that the previous patch mucked
with - illegal zero-sized helper memory access. As opposed to existing
tests, this new one uses a size whose lower bound is zero, as opposed to
a known-zero one.

Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
---
 .../bpf/progs/verifier_helper_value_access.c  | 39 ++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c b/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c
index 3e8340c2408f..886498b5e6f3 100644
--- a/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c
@@ -89,9 +89,14 @@ l0_%=:	exit;						\
 	: __clobber_all);
 }
 
+/* Call a function taking a pointer and a size which doesn't allow the size to
+ * be zero (i.e. bpf_trace_printk() declares the second argument to be
+ * ARG_CONST_SIZE, not ARG_CONST_SIZE_OR_ZERO). We attempt to pass zero for the
+ * size and expect to fail.
+ */
 SEC("tracepoint")
 __description("helper access to map: empty range")
-__failure __msg("R2 invalid zero-sized read")
+__failure __msg("R2 invalid zero-sized read: u64=[0,0]")
 __naked void access_to_map_empty_range(void)
 {
 	asm volatile ("					\
@@ -113,6 +118,38 @@ l0_%=:	exit;						\
 	: __clobber_all);
 }
 
+/* Like the test above, but this time the size register is not known to be zero;
+ * its lower-bound is zero though, which is still unacceptable.
+ */
+SEC("tracepoint")
+__description("helper access to map: possibly-empty ange")
+__failure __msg("R2 invalid zero-sized read: u64=[0,4]")
+__naked void access_to_map_possibly_empty_range(void)
+{
+	asm volatile ("                                         \
+	r2 = r10;                                               \
+	r2 += -8;                                               \
+	r1 = 0;                                                 \
+	*(u64*)(r2 + 0) = r1;                                   \
+	r1 = %[map_hash_48b] ll;                                \
+	call %[bpf_map_lookup_elem];                            \
+	if r0 == 0 goto l0_%=;                                  \
+	r1 = r0;                                                \
+	/* Read an unknown value */                             \
+	r7 = *(u64*)(r0 + 0);                                   \
+	/* Make it small and positive, to avoid other errors */ \
+	r7 &= 4;                                                \
+	r2 = 0;                                                 \
+	r2 += r7;                                               \
+	call %[bpf_trace_printk];                               \
+l0_%=:	exit;                                               \
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_trace_printk),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
 SEC("tracepoint")
 __description("helper access to map: out-of-bound range")
 __failure __msg("invalid access to map value, value_size=48 off=0 size=56")
-- 
2.40.1


