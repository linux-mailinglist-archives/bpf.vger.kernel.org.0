Return-Path: <bpf+bounces-17349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0193C80BDBD
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 23:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 470CA280BFF
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 22:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153D41D555;
	Sun, 10 Dec 2023 22:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G72yQL36"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C55E9
	for <bpf@vger.kernel.org>; Sun, 10 Dec 2023 14:55:53 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-67ab19339b4so27507056d6.0
        for <bpf@vger.kernel.org>; Sun, 10 Dec 2023 14:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702248951; x=1702853751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pQtAtwdFVM/V9Jl3Fn+lxXnqA+3f4Hc9Y0nUf2R530A=;
        b=G72yQL36OKUTdrh5GA0/SgRe8vAMg05ujCjFWS7peyEPv9f7dtxPFmPXms+dg31p09
         h/T/qIpNWgpKY3U6mhAlVhxNeYjcI01Q9yfGrUfuGyE94hknoRsOAdN9VlGg+iO2Hn05
         zBN5/G8v7ZyyWLahaSeSI/P9CVFEOLyE4qxHoAUIS2zg/V63R1Zumry62+8RKPbmzSSM
         XLyFfTF3yP8i2OdLErPMHz46QwdiiDu8O8qwz25y3UfXwEkqVkmYB+mF9PvXG59xt7Vv
         sYDcKMiI4pctW39PpcK073hBG8pxzUAQcTTkpEqg6FWiHANzRBCVnsgjOdcUfOfuNsRQ
         1qvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702248951; x=1702853751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pQtAtwdFVM/V9Jl3Fn+lxXnqA+3f4Hc9Y0nUf2R530A=;
        b=nN9GCoTZcPxaIQKbdP6KeUWlJshHj/xh8iyh0Uqns/ES2ctP0I73er/wJnzNt77AjV
         k2HghQSDumYkSOzEPNeVPC7Dr0unYRxeGkFNM9twOtGWKAh4yTUZZsa5nKDlHCb/U/H1
         i1pXa2x3Goc9FXK7y/bH7g666fVeaIZ5BegNdwYIlaK7MzUs5QjQdJEphQ1wY/Df2tmm
         tO2EuU63Gqe10xA9yMhtIcNo4hQPib7M9LAMs3FEuNLMVUDX1r7sY5VWRaaz6DIrP75/
         0bdT3t5/izZGu46+W/4/61zDHIuTV0d0sliVrN3eSnf9FaihyWhwOo1gxZUwxTod43cT
         a79Q==
X-Gm-Message-State: AOJu0Yx/E0b7s9aP/ME3UV2yg6q1j4o16VsgdsMuIcNeCntZexzOEh58
	v7rmQ9zQSvOCQUnTV58JKW0t+PJvVr88qg==
X-Google-Smtp-Source: AGHT+IE7xc/mmRyERD1SP9Kmg9wjlGEJGmcVjmNs0XXsv2Tpv+wRr11EQFrfgF2l60Uwyb+RURLhrw==
X-Received: by 2002:ad4:57b3:0:b0:67b:d68a:25a5 with SMTP id g19-20020ad457b3000000b0067bd68a25a5mr5009741qvx.51.1702248951223;
        Sun, 10 Dec 2023 14:55:51 -0800 (PST)
Received: from andrei-framework.taildd130.ts.net ([2600:4041:599b:1100:60a8:b515:8d17:4f21])
        by smtp.gmail.com with ESMTPSA id rr17-20020a05620a679100b0077f0ae46fd5sm2445421qkn.16.2023.12.10.14.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 14:55:50 -0800 (PST)
From: Andrei Matei <andreimatei1@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii.nakryiko@gmail.com,
	Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf-next] bpf: Simplify checking size of helper accesses
Date: Sun, 10 Dec 2023 17:55:36 -0500
Message-Id: <20231210225536.70322-1-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch simplifies the verification of size arguments associated to
pointer arguments to helpers and kfuncs. Many helpers take a pointer
argument followed by the size of the memory access performed to be
performed through that pointer. Before this patch, the handling of the
size argument in check_mem_size_reg() was confusing and wasteful: if the
size register's lower bound was 0, then the verification was done twice:
once considering the size of the access to be the lower-bound of the
respective argument, and once considering the upper bound (even if the
two are the same). The upper bound checking is a super-set of the
lower-bound checking(*), except: the only point of the lower-bound check
is to handle the case where zero-sized-accesses are explicitly not
allowed and the lower-bound is zero. This static condition is now
checked explicitly, replacing a much more complex, expensive and
confusing verification call to check_helper_mem_access().

Now that check_mem_size_reg() deals directly with the zero_size_allowed
checking, the single remaining call to check_helper_mem_access() can
pass a static value for the zero_size_allowed arg, instead of
propagating a dynamic one. I think this is an improvement, as tracking
the wide propagation of zero_sized_allowed is already complicated.

This patch also results in better error messages for rejected zero-size
reads. Before, the message one would get depended on the type of the
pointer and on other conditions, and sometimes the message was plain
wrong: in some tests that changed you'll see that the old message was
something like "R1 min value is outside of the allowed memory range",
where R1 is the pointer register; the error was wrongly claiming that
the pointer was bad instead of the size being bad. Other times the
information that the size came for a register with a possible range of
values was wrong, and the error presented the size as a fixed zero.

(*) Besides standing to reason that the checks for a bigger size access
are a super-set of the checks for a smaller size access, I have also
mechanically verified this by reading the code for all types of
pointers. I could convince myself that it's true for all but
PTR_TO_BTF_ID (check_ptr_to_btf_access). There, simply looking
line-by-line does not immediately prove what we want. If anyone has any
qualms, let me know.

Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
---
 kernel/bpf/verifier.c                         | 34 ++++++++++----
 .../bpf/progs/verifier_helper_value_access.c  | 45 +++++++++++++++++--
 .../selftests/bpf/progs/verifier_raw_stack.c  |  2 +-
 3 files changed, 68 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fb690539d5f6..022833903157 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7258,6 +7258,7 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 			      struct bpf_call_arg_meta *meta)
 {
 	int err;
+	const bool size_is_const = tnum_is_const(reg->var_off);
 
 	/* This is used to refine r0 return value bounds for helpers
 	 * that enforce this value as an upper bound on return values.
@@ -7272,7 +7273,7 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 	/* The register is SCALAR_VALUE; the access check
 	 * happens using its boundaries.
 	 */
-	if (!tnum_is_const(reg->var_off))
+	if (!size_is_const)
 		/* For unprivileged variable accesses, disable raw
 		 * mode so that the program is required to
 		 * initialize all the memory that the helper could
@@ -7286,12 +7287,17 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
-	if (reg->umin_value == 0) {
-		err = check_helper_mem_access(env, regno - 1, 0,
-					      zero_size_allowed,
-					      meta);
-		if (err)
-			return err;
+	if (reg->umin_value == 0 && !zero_size_allowed) {
+		if (size_is_const) {
+			verbose(env, "R%d invalid zero-sized read\n", regno);
+		} else {
+			char tn_buf[48];
+
+			tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
+			verbose(env, "R%d invalid possibly-zero-sized read: u64=[%#llx, %#llx] var_off=%s\n",
+				regno, reg->umin_value, reg->umax_value, tn_buf);
+		}
+		return -EACCES;
 	}
 
 	if (reg->umax_value >= BPF_MAX_VAR_SIZ) {
@@ -7299,9 +7305,21 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 			regno);
 		return -EACCES;
 	}
+	/* If !zero_size_allowed, we already checked that umin_value > 0, so
+	 * umax_value should also be > 0.
+	 */
+	if (reg->umax_value == 0 && !zero_size_allowed) {
+		verbose(env, "verifier bug: !zero_size_allowed should have been handled already\n");
+		return -EFAULT;
+	}
 	err = check_helper_mem_access(env, regno - 1,
 				      reg->umax_value,
-				      zero_size_allowed, meta);
+				      /* zero_size_allowed: we asserted above that umax_value is
+				       * not zero if !zero_size_allowed, so we don't need any
+				       * further checks.
+				       */
+				      true ,
+				      meta);
 	if (!err)
 		err = mark_chain_precision(env, regno);
 	return err;
diff --git a/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c b/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c
index 692216c0ad3d..7c99c7bae09e 100644
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
-__failure __msg("invalid access to map value, value_size=48 off=0 size=0")
+__failure __msg("R2 invalid zero-sized read")
 __naked void access_to_map_empty_range(void)
 {
 	asm volatile ("					\
@@ -113,6 +118,38 @@ l0_%=:	exit;						\
 	: __clobber_all);
 }
 
+/* Like the test above, but this time the size register is not known to be zero;
+ * its lower-bound is zero though, which is still unacceptible.
+ */
+SEC("tracepoint")
+__description("helper access to map: possibly-empty range")
+__failure __msg("R2 invalid possibly-zero-sized read: u64=[0x0, 0x4] var_off=(0x0; 0x4)")
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
@@ -221,7 +258,7 @@ l0_%=:	exit;						\
 
 SEC("tracepoint")
 __description("helper access to adjusted map (via const imm): empty range")
-__failure __msg("invalid access to map value, value_size=48 off=4 size=0")
+__failure __msg("R2 invalid zero-sized read")
 __naked void via_const_imm_empty_range(void)
 {
 	asm volatile ("					\
@@ -386,7 +423,7 @@ l0_%=:	exit;						\
 
 SEC("tracepoint")
 __description("helper access to adjusted map (via const reg): empty range")
-__failure __msg("R1 min value is outside of the allowed memory range")
+__failure __msg("R2 invalid zero-sized read")
 __naked void via_const_reg_empty_range(void)
 {
 	asm volatile ("					\
@@ -556,7 +593,7 @@ l0_%=:	exit;						\
 
 SEC("tracepoint")
 __description("helper access to adjusted map (via variable): empty range")
-__failure __msg("R1 min value is outside of the allowed memory range")
+__failure __msg("R2 invalid zero-sized read")
 __naked void map_via_variable_empty_range(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_raw_stack.c b/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
index f67390224a9c..3dbda85e2997 100644
--- a/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
@@ -64,7 +64,7 @@ __naked void load_bytes_negative_len_2(void)
 
 SEC("tc")
 __description("raw_stack: skb_load_bytes, zero len")
-__failure __msg("invalid zero-sized read")
+__failure __msg("R4 invalid zero-sized read")
 __naked void skb_load_bytes_zero_len(void)
 {
 	asm volatile ("					\
-- 
2.40.1


