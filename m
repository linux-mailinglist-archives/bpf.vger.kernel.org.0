Return-Path: <bpf+bounces-18402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED04B81A5F6
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 18:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E4F31C231FC
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 17:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29574777E;
	Wed, 20 Dec 2023 17:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvGFgH2G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C713C405ED
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 17:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78114b51f76so41570785a.2
        for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 09:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703092009; x=1703696809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOoUsjzX70+3vPJ3JndqsPgXXotGGggoTzLxvnVOKT0=;
        b=IvGFgH2GzzUl765TMUrshZIDx5qQDAope/Fsbw5fNcb6QU3LU5MIw9nLqCEKE7Y2cv
         ilazY6N9poocp/oipOZbXZgybOj6zQYSoEx2F9JrH5CF+DCsUB0dQ+Gz5eVHaUv6UiYR
         2aQijPaz2F/onl8v0c6mFKEgoTEK37oH1u5vfjzuLbNZ2Td13xJ6MwZCynoenIMrJVgc
         PMFj4blAsQg9dnQMHE65ULhqRxxr6r2g64Ntj4hKCdaU8Jp5cnYTpx5BZQLl3DFA26pD
         bkzZaxHnOvecHv9LNPFpkc98egSJ3WWdwZJiN4UEPqu4YPDW48OKif87DxLEzCCMnn+a
         Q5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703092009; x=1703696809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iOoUsjzX70+3vPJ3JndqsPgXXotGGggoTzLxvnVOKT0=;
        b=VHefTYJQAY9xeKdQB6QKaf91dYQWNuZAq297mc3zrZUWlFCXpnNoEIaOgHlPjGH5GN
         8ga3v6S4hh2awy6KkLri/OO8RmmCM1XCWiWUwYETWqwYZytNfbMAtvUrViE9rxxjMmfy
         Y31x0vf755+c/1Wc6hifFiyV/Z/0D2ILKoY3/zYXAI2H28unmmDsUTLnsbrmft16Aram
         N1Yfd0CbHjCCwPs2TvdaIq1kbp683nrHSbaWWoQhBCCXQeqPzpXOKWZOQRLI/8cb2Qds
         f2YTmcPrmhYzs9nk8HVamqzmhnqGNji2Ku1F//l9qIkx5E9S4A2ygBjKNxZeJhXkhuR6
         1Ydg==
X-Gm-Message-State: AOJu0Yx6ew/A6GLYT1rl+Lgy2XTjpWO+iz7Vy7IUpE/VSZBzEwxz4mpo
	P1710/X7i0Fj7ino5bZp+NPQyjeilVk=
X-Google-Smtp-Source: AGHT+IGE47tPTVXBdmR9Fr7YqmZm8Q2HWbJ+b27Uh1Mag3+lcQY0gqe6iS9kkEJ2HowkROo53m23Ag==
X-Received: by 2002:a05:6214:21e8:b0:67f:4824:72f6 with SMTP id p8-20020a05621421e800b0067f482472f6mr4387263qvj.128.1703092008681;
        Wed, 20 Dec 2023 09:06:48 -0800 (PST)
Received: from andrei-framework.taildd130.ts.net (098-030-123-082.res.spectrum.com. [98.30.123.82])
        by smtp.gmail.com with ESMTPSA id lg6-20020a056214548600b0067f08081c08sm37492qvb.12.2023.12.20.09.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 09:06:48 -0800 (PST)
From: Andrei Matei <andreimatei1@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii.nakryiko@gmail.com,
	eddyz87@gmail.com,
	Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf-next v3 1/2] bpf: Simplify checking size of helper accesses
Date: Wed, 20 Dec 2023 12:06:02 -0500
Message-Id: <20231220170604.183380-2-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231220170604.183380-1-andreimatei1@gmail.com>
References: <20231220170604.183380-1-andreimatei1@gmail.com>
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

Error messages change in this patch. Before, messages about illegal
zero-size accesses depended on the type of the pointer and on other
conditions, and sometimes the message was plain wrong: in some tests
that changed you'll see that the old message was something like "R1 min
value is outside of the allowed memory range", where R1 is the pointer
register; the error was wrongly claiming that the pointer was bad
instead of the size being bad. Other times the information that the size
came for a register with a possible range of values was wrong, and the
error presented the size as a fixed zero. Now the errors refer to the
right register. However, the old error messages did contain useful
information about the pointer register which is now lost. The next patch
will bring that information back.

(*) Besides standing to reason that the checks for a bigger size access
are a super-set of the checks for a smaller size access, I have also
mechanically verified this by reading the code for all types of
pointers. I could convince myself that it's true for all but
PTR_TO_BTF_ID (check_ptr_to_btf_access). There, simply looking
line-by-line does not immediately prove what we want. If anyone has any
qualms, let me know.

Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
---
 kernel/bpf/verifier.c                         | 28 ++++++++----
 .../bpf/progs/verifier_helper_value_access.c  | 45 +++++++++++++++++--
 .../selftests/bpf/progs/verifier_raw_stack.c  |  2 +-
 3 files changed, 61 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1863826a4ac3..4409b8f2b0f3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7267,6 +7267,7 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 			      bool zero_size_allowed,
 			      struct bpf_call_arg_meta *meta)
 {
+	const bool size_is_const = tnum_is_const(reg->var_off);
 	int err;
 
 	/* This is used to refine r0 return value bounds for helpers
@@ -7282,7 +7283,7 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 	/* The register is SCALAR_VALUE; the access check
 	 * happens using its boundaries.
 	 */
-	if (!tnum_is_const(reg->var_off))
+	if (!size_is_const)
 		/* For unprivileged variable accesses, disable raw
 		 * mode so that the program is required to
 		 * initialize all the memory that the helper could
@@ -7296,12 +7297,9 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
-	if (reg->umin_value == 0) {
-		err = check_helper_mem_access(env, regno - 1, 0,
-					      zero_size_allowed,
-					      meta);
-		if (err)
-			return err;
+	if (reg->umin_value == 0 && !zero_size_allowed) {
+		verbose(env, "R%d invalid zero-sized read\n", regno);
+		return -EACCES;
 	}
 
 	if (reg->umax_value >= BPF_MAX_VAR_SIZ) {
@@ -7309,9 +7307,21 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
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
-				      reg->umax_value,
-				      zero_size_allowed, meta);
+				reg->umax_value,
+				/* zero_size_allowed: we asserted above that umax_value is not
+				 * zero if !zero_size_allowed, so we don't need any further
+				 * checks.
+				 */
+				true,
+				meta);
 	if (!err)
 		err = mark_chain_precision(env, regno);
 	return err;
diff --git a/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c b/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c
index 692216c0ad3d..137cce939711 100644
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
+__failure __msg("R2 invalid zero-sized read")
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


