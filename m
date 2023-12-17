Return-Path: <bpf+bounces-18106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D7A815CF0
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 02:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0485DB232AE
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 01:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C817522A;
	Sun, 17 Dec 2023 01:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCPTxJ26"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207295223
	for <bpf@vger.kernel.org>; Sun, 17 Dec 2023 01:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-77f31239797so135876285a.2
        for <bpf@vger.kernel.org>; Sat, 16 Dec 2023 17:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702775232; x=1703380032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7uz0W6hBOskCzRceUlFgfcZRRDMV46x11dsRc7301Y=;
        b=WCPTxJ26/RW1WIw3v0frUriL1o3oXMTGqXos26szCaKKwomrUC9X+ATmK7asUaD+OT
         5HqfCO5TMd9sBvYCVvq8f/nysT5M+bQG+raMM9YJKbTiNaM6J1zspUqkMsUJcSSkCm2/
         F/HOVrBiKOo/b+kO0urjBRftldDGrWNyj9Nr2gkQxMNvWdmwgaOB92eNT0tJmKsI4R7N
         Oj5oZrehxsHCGtlZNisOgqmhoNgYsqKc9scB2IQZhxmdOiqvqjXc7tUKYIkl/RKWhyOq
         ER6LlGlorNLb22Ke1NKegn9GcBVnaNsq4hLeV73a3o6Urhr4Y1Aktyk1zkeSMNpECtrz
         5y+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702775232; x=1703380032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7uz0W6hBOskCzRceUlFgfcZRRDMV46x11dsRc7301Y=;
        b=oWDS5FTgkVW19mfxb5RCCeypzFzJJQl5jzW6v1BvTiFbRhIffYFnCVPp/WXTbUrN2N
         2JS1flNIj9MchR0oUzSWtL8UrkqtE7hpOfxRTY7yyavt0AnILRc0wu4303HUaRo65zUz
         RHIgncWFpxpQaT/r2KX/czUWZ4zda7mq2I72Z4PvQzjWs0g49YF6U2hrrL6uPDYMV1MQ
         d2DwgeVbUM9o7TwkfxMyKK+IS42uEVkb7tnEZ3r17WeAqHnEtyh+oxKe14r40kqHqc/C
         fQoZ0zWXNzkLTB83FvX9KyEaAk8XHsRCC2TJZhBvmdinEQD5iMitFd3u5ZdjBLgTVzsr
         yY/w==
X-Gm-Message-State: AOJu0YxJpDOM4l50bbQNCHdNqewF6md6RIyEan0zwhslzEGlk0N/nFp4
	DTpM0dYXjl7DwpyLcsMLgrDdBtV+6QuOhw==
X-Google-Smtp-Source: AGHT+IGj7syyuK0z9+BoFyFAqr8kNcEy1KdA8k1kWbfbKVFHbQ81h/Dy/ge+ZE2tDMBsMcZGf/7dkQ==
X-Received: by 2002:a05:620a:2946:b0:77e:fe81:8bb1 with SMTP id n6-20020a05620a294600b0077efe818bb1mr15632299qkp.17.1702775230620;
        Sat, 16 Dec 2023 17:07:10 -0800 (PST)
Received: from andrei-framework.taildd130.ts.net ([2600:4041:599b:1100:8905:84c7:4c95:beb4])
        by smtp.gmail.com with ESMTPSA id c16-20020a05620a11b000b0076efaec147csm7180242qkk.45.2023.12.16.17.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 17:07:10 -0800 (PST)
From: Andrei Matei <andreimatei1@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii.nakryiko@gmail.com,
	Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf-next v2 1/1] bpf: Simplify checking size of helper accesses
Date: Sat, 16 Dec 2023 20:06:49 -0500
Message-Id: <20231217010649.577814-2-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231217010649.577814-1-andreimatei1@gmail.com>
References: <20231217010649.577814-1-andreimatei1@gmail.com>
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
 kernel/bpf/verifier.c                         | 85 +++++++++++++++++--
 .../bpf/progs/verifier_helper_value_access.c  | 45 +++++++++-
 .../selftests/bpf/progs/verifier_raw_stack.c  |  4 +-
 3 files changed, 120 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1863826a4ac3..cf2a09408bdc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7256,6 +7256,65 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 	}
 }
 
+/* Helper function for logging an error about an invalid attempt to perform a
+ * (possibly) zero-sized memory access. The pointer being dereferenced is in
+ * register @ptr_regno, and the size of the access is in register @size_regno.
+ * The size register is assumed to either be a constant zero or have a zero lower
+ * bound.
+ *
+ * Logs a message like:
+ * invalid zero-size read. Size comes from R2=0. Attempting to dereference *map_value R1: off=[0,4] value_size=48
+ */
+static void log_zero_size_access_err(struct bpf_verifier_env *env,
+			      int ptr_regno,
+			      int size_regno)
+{
+	struct bpf_reg_state *ptr_reg = &cur_regs(env)[ptr_regno];
+	struct bpf_reg_state *size_reg = &cur_regs(env)[size_regno];
+	const bool size_is_const = tnum_is_const(size_reg->var_off);
+	const char *ptr_type_str = reg_type_str(env, ptr_reg->type);
+	/* allocate a few buffers to be used as parts of the error message */
+	char size_range_buf[64] = {0}, max_size_buf[64] = {0}, off_buf[64] = {0};
+	s64 min_off, max_off;
+	if (!size_is_const) {
+		snprintf(size_range_buf, sizeof(size_range_buf),
+			"[0,%lld]", size_reg->umax_value);
+	}
+
+	if (tnum_is_const(ptr_reg->var_off)) {
+		min_off = (s64)ptr_reg->var_off.value + ptr_reg->off;
+		snprintf(off_buf, sizeof(off_buf), "%lld", min_off);
+	} else {
+		min_off = ptr_reg->smin_value + ptr_reg->off;
+		max_off = ptr_reg->smax_value + ptr_reg->off;
+		snprintf(off_buf, sizeof(off_buf), "[%lld,%lld]", min_off, max_off);
+	}
+
+	/* attempt to figure out info about the maximum offset that could be allowed */
+	switch (ptr_reg->type) {
+	case PTR_TO_MAP_KEY:
+		snprintf(max_size_buf, sizeof(max_size_buf), "key_size=%d", ptr_reg->map_ptr->key_size);
+		break;
+	case PTR_TO_MAP_VALUE:
+		snprintf(max_size_buf, sizeof(max_size_buf), "value_size=%d", ptr_reg->map_ptr->value_size);
+		break;
+	case PTR_TO_PACKET:
+	case PTR_TO_PACKET_META:
+		snprintf(max_size_buf, sizeof(max_size_buf), "packet_size=%d", ptr_reg->range);
+		break;
+	case PTR_TO_MEM:
+	default:
+		snprintf(max_size_buf, sizeof(max_size_buf), "max_size=N/A");
+	}
+
+	verbose(env, "invalid %szero-size read. Size comes from R%d=%s. "
+		"Attempting to dereference *%s R%d: off=%s %s\n",
+		size_is_const ? "" : "possibly ",
+		size_regno, size_is_const ? "0" : size_range_buf,
+		ptr_type_str, ptr_regno, off_buf, max_size_buf);
+}
+
+
 /* verify arguments to helpers or kfuncs consisting of a pointer and an access
  * size.
  *
@@ -7268,6 +7327,7 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 			      struct bpf_call_arg_meta *meta)
 {
 	int err;
+	const bool size_is_const = tnum_is_const(reg->var_off);
 
 	/* This is used to refine r0 return value bounds for helpers
 	 * that enforce this value as an upper bound on return values.
@@ -7282,7 +7342,7 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 	/* The register is SCALAR_VALUE; the access check
 	 * happens using its boundaries.
 	 */
-	if (!tnum_is_const(reg->var_off))
+	if (!size_is_const)
 		/* For unprivileged variable accesses, disable raw
 		 * mode so that the program is required to
 		 * initialize all the memory that the helper could
@@ -7296,12 +7356,9 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
-	if (reg->umin_value == 0) {
-		err = check_helper_mem_access(env, regno - 1, 0,
-					      zero_size_allowed,
-					      meta);
-		if (err)
-			return err;
+	if (reg->umin_value == 0 && !zero_size_allowed) {
+		log_zero_size_access_err(env, regno-1, regno);
+		return -EACCES;
 	}
 
 	if (reg->umax_value >= BPF_MAX_VAR_SIZ) {
@@ -7309,9 +7366,21 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
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
index 692216c0ad3d..9fe10f63c931 100644
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
+__failure __msg("invalid zero-size read. Size comes from R2=0. Attempting to dereference *map_value R1: off=0 value_size=48")
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
+__failure __msg("invalid possibly zero-size read. Size comes from R2=[0,4]. Attempting to dereference *map_value R1: off=0 value_size=48")
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
+__failure __msg("invalid zero-size read. Size comes from R2=0. Attempting to dereference *map_value R1: off=4 value_size=48")
 __naked void via_const_imm_empty_range(void)
 {
 	asm volatile ("					\
@@ -386,7 +423,7 @@ l0_%=:	exit;						\
 
 SEC("tracepoint")
 __description("helper access to adjusted map (via const reg): empty range")
-__failure __msg("R1 min value is outside of the allowed memory range")
+__failure __msg("invalid zero-size read. Size comes from R2=0. Attempting to dereference *map_value R1: off=0 value_size=48")
 __naked void via_const_reg_empty_range(void)
 {
 	asm volatile ("					\
@@ -556,7 +593,7 @@ l0_%=:	exit;						\
 
 SEC("tracepoint")
 __description("helper access to adjusted map (via variable): empty range")
-__failure __msg("R1 min value is outside of the allowed memory range")
+__failure __msg("invalid zero-size read. Size comes from R2=0. Attempting to dereference *map_value R1: off=[0,4] value_size=48")
 __naked void map_via_variable_empty_range(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_raw_stack.c b/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
index f67390224a9c..c133d9d2c45e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
@@ -64,7 +64,7 @@ __naked void load_bytes_negative_len_2(void)
 
 SEC("tc")
 __description("raw_stack: skb_load_bytes, zero len")
-__failure __msg("invalid zero-sized read")
+__failure __msg("invalid zero-size read. Size comes from R4=0. Attempting to dereference *fp R3: off=-8 max_size=N/A")
 __naked void skb_load_bytes_zero_len(void)
 {
 	asm volatile ("					\
@@ -333,7 +333,7 @@ __naked void load_bytes_invalid_access_5(void)
 
 SEC("tc")
 __description("raw_stack: skb_load_bytes, invalid access 6")
-__failure __msg("invalid zero-sized read")
+__failure __msg("invalid zero-size read. Size comes from R4=0. Attempting to dereference *fp R3: off=-512 max_size=N/A")
 __naked void load_bytes_invalid_access_6(void)
 {
 	asm volatile ("					\
-- 
2.40.1


