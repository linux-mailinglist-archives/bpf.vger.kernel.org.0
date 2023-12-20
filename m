Return-Path: <bpf+bounces-18403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A473A81A5F7
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 18:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B486283F84
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 17:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F218247789;
	Wed, 20 Dec 2023 17:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkeVoSot"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138B646B99
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78117c8b6ccso26241285a.0
        for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 09:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703092012; x=1703696812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpqkTPFTNTmEmQT8ks5ICEWCHJynPa2XTAuYlefMXVU=;
        b=XkeVoSotSKPE6CdXecZLSOZAHB22znAnrvHQFCUn3UKAnFaOYvAhnpFTzTKAa0p9t5
         I+CcbZ6dDHGZWpP+bwawF5KEGeg6G6wAx7H4HX6mTwa7Ffdq6x8pWHDbZIn/awxT3/og
         CrxExSr+uEnuKcDmetBTySSCKQEmraJ1sYfrRnzTgK8F2IpWbGgTEq5JaqX8QuR/Yy19
         nUSqvzYQOp79eruburfMEssChzbRxSfn3drmNPyhpjLE9lqzGqKZBZb4KLhICln6haj+
         5xrCybkwfLigvmsX/R1aRtvQ8rDPdRwipD1dsupU7ooUWl/zZOWAPzuI+wEh0eKdYFLO
         ug/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703092012; x=1703696812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wpqkTPFTNTmEmQT8ks5ICEWCHJynPa2XTAuYlefMXVU=;
        b=me/P55Xh/WDAFCwYUVSntq6SIOnr5mMuzSCn9Z/pS9pt2VEXhNq5xC+gJ3WZn8Dk57
         1wibjaojx5cwBvp5VqPoc+ACrdgoLXWDHSi+BWFZy75dJNf6HGCDW1//Xe9oM/v5efn/
         HXaCHDingLutpbvaE0Cfehr4HVxbRBsYF1CjkI49zWKK/EAU7iQ9r1s6xhJ/VZNiFyF4
         CAa/nBNo3h/tW8MaMP74clH58xqi/yCiEk3gQGMjUgzwXKzmhdkSxbOrAc0VS/aBFl8M
         ZAEZ8xq9o1MJGHkgNbvD0kZKfVRJL/zdm7PQg3oMVO/EmhrbxH+zaTAj2c+rSpKuVjDN
         F5gw==
X-Gm-Message-State: AOJu0Yw6kqCtnkPAQ73R/VVejLwPD+eHL/Ez5zVeqQ//M64SyhKGA1RL
	CmwR0NByRSqH0JFv5EYdWh5+64HK4zQ=
X-Google-Smtp-Source: AGHT+IH0KJQl18Pd6KJvzjlBiCGwNfZwczg5nxIi/Oy7Nt1DKNOgTeM3qR8qHIdu/a/O1AEPqUmHaA==
X-Received: by 2002:a0c:d788:0:b0:67a:9cd5:1178 with SMTP id z8-20020a0cd788000000b0067a9cd51178mr18595251qvi.14.1703092012365;
        Wed, 20 Dec 2023 09:06:52 -0800 (PST)
Received: from andrei-framework.taildd130.ts.net (098-030-123-082.res.spectrum.com. [98.30.123.82])
        by smtp.gmail.com with ESMTPSA id lg6-20020a056214548600b0067f08081c08sm37492qvb.12.2023.12.20.09.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 09:06:52 -0800 (PST)
From: Andrei Matei <andreimatei1@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii.nakryiko@gmail.com,
	eddyz87@gmail.com,
	Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf-next v3 2/2] bpf: improve error logging for zero-sized accesses
Date: Wed, 20 Dec 2023 12:06:03 -0500
Message-Id: <20231220170604.183380-3-andreimatei1@gmail.com>
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

This patch improves the verifier error messages for illegal zero-sized
memory accesses. The previous patch made these messages focus on the
register containing the size of the access, instead of focusing on the
register containing the dereferenced pointer. This was more correct, but
removed useful information about the pointer. This patch brings this
information back and then some. We now have complete error messages that
are also consistent across pointer types.

Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
---
 kernel/bpf/verifier.c                         | 63 ++++++++++++++++++-
 .../bpf/progs/verifier_helper_value_access.c  | 10 +--
 .../selftests/bpf/progs/verifier_raw_stack.c  |  4 +-
 3 files changed, 69 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4409b8f2b0f3..6f333c5c47f8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7256,6 +7256,67 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
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
+	char size_range_buf[32] = {0}, max_size_buf[32] = {0}, off_buf[64] = {0};
+	s64 min_off, max_off;
+
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
+		snprintf(max_size_buf, sizeof(max_size_buf), "mem_size=%d", ptr_reg->mem_size);
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
@@ -7298,7 +7359,7 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 	}
 
 	if (reg->umin_value == 0 && !zero_size_allowed) {
-		verbose(env, "R%d invalid zero-sized read\n", regno);
+		log_zero_size_access_err(env, regno-1, regno);
 		return -EACCES;
 	}
 
diff --git a/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c b/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c
index 137cce939711..9fe10f63c931 100644
--- a/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c
@@ -96,7 +96,7 @@ l0_%=:	exit;						\
  */
 SEC("tracepoint")
 __description("helper access to map: empty range")
-__failure __msg("R2 invalid zero-sized read")
+__failure __msg("invalid zero-size read. Size comes from R2=0. Attempting to dereference *map_value R1: off=0 value_size=48")
 __naked void access_to_map_empty_range(void)
 {
 	asm volatile ("					\
@@ -123,7 +123,7 @@ l0_%=:	exit;						\
  */
 SEC("tracepoint")
 __description("helper access to map: possibly-empty range")
-__failure __msg("R2 invalid zero-sized read")
+__failure __msg("invalid possibly zero-size read. Size comes from R2=[0,4]. Attempting to dereference *map_value R1: off=0 value_size=48")
 __naked void access_to_map_possibly_empty_range(void)
 {
 	asm volatile ("                                         \
@@ -258,7 +258,7 @@ l0_%=:	exit;						\
 
 SEC("tracepoint")
 __description("helper access to adjusted map (via const imm): empty range")
-__failure __msg("R2 invalid zero-sized read")
+__failure __msg("invalid zero-size read. Size comes from R2=0. Attempting to dereference *map_value R1: off=4 value_size=48")
 __naked void via_const_imm_empty_range(void)
 {
 	asm volatile ("					\
@@ -423,7 +423,7 @@ l0_%=:	exit;						\
 
 SEC("tracepoint")
 __description("helper access to adjusted map (via const reg): empty range")
-__failure __msg("R2 invalid zero-sized read")
+__failure __msg("invalid zero-size read. Size comes from R2=0. Attempting to dereference *map_value R1: off=0 value_size=48")
 __naked void via_const_reg_empty_range(void)
 {
 	asm volatile ("					\
@@ -593,7 +593,7 @@ l0_%=:	exit;						\
 
 SEC("tracepoint")
 __description("helper access to adjusted map (via variable): empty range")
-__failure __msg("R2 invalid zero-sized read")
+__failure __msg("invalid zero-size read. Size comes from R2=0. Attempting to dereference *map_value R1: off=[0,4] value_size=48")
 __naked void map_via_variable_empty_range(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_raw_stack.c b/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
index 3dbda85e2997..c133d9d2c45e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
@@ -64,7 +64,7 @@ __naked void load_bytes_negative_len_2(void)
 
 SEC("tc")
 __description("raw_stack: skb_load_bytes, zero len")
-__failure __msg("R4 invalid zero-sized read")
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


