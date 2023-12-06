Return-Path: <bpf+bounces-16897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 716A58075E6
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 17:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A13B1F21688
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 16:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E7449F69;
	Wed,  6 Dec 2023 16:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEe1/TY2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819A1D3
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 08:58:45 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-58db7d8f2ebso4610769eaf.0
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 08:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701881924; x=1702486724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFNY4aAGR7NerwCwtVfqRbMoEy7iMW2l2HbBMz/O8hY=;
        b=BEe1/TY2zonzSMDtF6mXCy9/f3yITt9OGCiQrH1bwBlC1QUCsFSfgtwa4t0s5xKvry
         CD6/2oOb8lqWYMLSHT8e3kzWeYPSfOS036xXA/o9gi9Ke8qRF1o4dyxXBM4XV9hRiz4l
         v2C9qpR7PQNs0IdzsRzOcGyScphIJ6qbFLZLi31T9dxAI5uj9vSRdMu8ltBQZTGMdSOX
         e1hXibdb4TiwfZLE4rZZsjMOT6CGwySYP60SNHbUOtvfCyembKYX5IU7DHJsHOkJMr+s
         1R19g2M4rkdrSO6SNygJn6eF2utK5eDZxbKP7XrXci21jatV7in0/SushPZ8yqcJhyde
         wpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701881924; x=1702486724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SFNY4aAGR7NerwCwtVfqRbMoEy7iMW2l2HbBMz/O8hY=;
        b=nWhzRRg6RDJ03plU3yaPkIrNHTtwW1MmjNpCzTsrlqzKwAbpdGQ3+Y1pddOkWSscHL
         mCEkBv7c3ZR619Usp73shSmQI+5nOs8ZwozhmokG9ij2psdQ7GMCxFI5DDZ5x1t0OPB/
         /KaP0lRpU/YvME5Jf/ylHUJl/A0l9ReM+MiVleMy7V+utt5sRmNDgZ7hXUB543gsvhk/
         Za9dmgoQ0GpSeTpG+OnPEk+qQcIK5KIESq7YTsfs/+rh/ScH51SA6WyT5HpaN4BBqNHO
         Nave6qC7Nn4OyvEcfPBEIo2y7w2i0OJdkKKYHFmxFl71N0MTcb1dYYJnONPNGnbXGHoz
         HxQw==
X-Gm-Message-State: AOJu0YxcKDUP/CVx4ZGfaDDYW4HvHGkHHKUDQhKTI5wMZqTPr7Mbh3ot
	739EJhQuCGwa/3tjxQUiKN0HKtGpQh8=
X-Google-Smtp-Source: AGHT+IHImopTMdgGMfvnvT3saTSLrJYtWJeSzrFaghAFUADUdjT5XE6i0ePHDQSvWEdv4e8BkBKrXA==
X-Received: by 2002:a05:6358:5922:b0:16b:f950:3d83 with SMTP id g34-20020a056358592200b0016bf9503d83mr1568712rwf.31.1701881923647;
        Wed, 06 Dec 2023 08:58:43 -0800 (PST)
Received: from andrei-desktop.taildd130.ts.net ([71.125.252.241])
        by smtp.gmail.com with ESMTPSA id h17-20020a0cf8d1000000b0067a3991d002sm118372qvo.30.2023.12.06.08.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 08:58:43 -0800 (PST)
From: Andrei Matei <andreimatei1@gmail.com>
To: bpf@vger.kernel.org,
	andrii.nakryiko@gmail.com,
	sunhao.th@gmail.com,
	eddyz87@gmail.com
Cc: Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf-next v4 1/2] bpf: fix verification of indirect var-off stack access
Date: Wed,  6 Dec 2023 11:58:01 -0500
Message-Id: <20231206165802.380626-2-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231206165802.380626-1-andreimatei1@gmail.com>
References: <20231206165802.380626-1-andreimatei1@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes a bug around the verification of possibly-zero-sized
stack accesses. When the access was done through a var-offset stack
pointer, check_stack_access_within_bounds was incorrectly computing the
maximum-offset of a zero-sized read to be the same as the register's min
offset. Instead, we have to take in account the register's maximum
possible value. The patch also simplifies how the max offset is checked;
the check is now simpler than for min offset.

The bug was allowing accesses to erroneously pass the
check_stack_access_within_bounds() checks, only to later crash in
check_stack_range_initialized() when all the possibly-affected stack
slots are iterated (this time with a correct max offset).
check_stack_range_initialized() is relying on
check_stack_access_within_bounds() for its accesses to the
stack-tracking vector to be within bounds; in the case of zero-sized
accesses, we were essentially only verifying that the lowest possible
slot was within bounds. We would crash when the max-offset of the stack
pointer was >= 0 (which shouldn't pass verification, and hopefully is
not something anyone's code attempts to do in practice).

Thanks Hao for reporting!

Reported-by: Hao Sun <sunhao.th@gmail.com>
Fixes: 01f810ace9ed3 ("bpf: Allow variable-offset stack access")
Closes: https://lore.kernel.org/bpf/CACkBjsZGEUaRCHsmaX=h-efVogsRfK1FPxmkgb0Os_frnHiNdw@mail.gmail.com/
Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
---
 kernel/bpf/verifier.c                         | 14 +++------
 .../selftests/bpf/progs/verifier_var_off.c    | 29 +++++++++++++++++++
 2 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e5ce530641ba..137240681fa9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6620,10 +6620,7 @@ static int check_stack_access_within_bounds(
 
 	if (tnum_is_const(reg->var_off)) {
 		min_off = reg->var_off.value + off;
-		if (access_size > 0)
-			max_off = min_off + access_size - 1;
-		else
-			max_off = min_off;
+		max_off = min_off + access_size;
 	} else {
 		if (reg->smax_value >= BPF_MAX_VAR_OFF ||
 		    reg->smin_value <= -BPF_MAX_VAR_OFF) {
@@ -6632,15 +6629,12 @@ static int check_stack_access_within_bounds(
 			return -EACCES;
 		}
 		min_off = reg->smin_value + off;
-		if (access_size > 0)
-			max_off = reg->smax_value + off + access_size - 1;
-		else
-			max_off = min_off;
+		max_off = reg->smax_value + off + access_size;
 	}
 
 	err = check_stack_slot_within_bounds(min_off, state, type);
-	if (!err)
-		err = check_stack_slot_within_bounds(max_off, state, type);
+	if (!err && max_off > 0)
+		err = -EINVAL; /* out of stack access into non-negative offsets */
 
 	if (err) {
 		if (tnum_is_const(reg->var_off)) {
diff --git a/tools/testing/selftests/bpf/progs/verifier_var_off.c b/tools/testing/selftests/bpf/progs/verifier_var_off.c
index 83a90afba785..9fb32b292017 100644
--- a/tools/testing/selftests/bpf/progs/verifier_var_off.c
+++ b/tools/testing/selftests/bpf/progs/verifier_var_off.c
@@ -224,6 +224,35 @@ __naked void access_max_out_of_bound(void)
 	: __clobber_all);
 }
 
+/* Similar to the test above, but this time check the special case of a
+ * zero-sized stack access. We used to have a bug causing crashes for zero-sized
+ * out-of-bounds accesses.
+ */
+SEC("socket")
+__description("indirect variable-offset stack access, zero-sized, max out of bound")
+__failure __msg("invalid variable-offset indirect access to stack R1")
+__naked void zero_sized_access_max_out_of_bound(void)
+{
+	asm volatile ("                     \
+	r0 = 0;                             \
+	/* Fill some stack */               \
+	*(u64*)(r10 - 16) = r0;             \
+	*(u64*)(r10 - 8) = r0;              \
+	/* Get an unknown value */          \
+	r1 = *(u32*)(r1 + 0);               \
+	r1 &= 64;                           \
+	r1 += -16;                          \
+	/* r1 is now anywhere in [-16,48)*/ \
+	r1 += r10;                          \
+	r2 = 0;                             \
+	r3 = 0;                             \
+	call %[bpf_probe_read_kernel];      \
+	exit;                               \
+"	:
+	: __imm(bpf_probe_read_kernel)
+	: __clobber_all);
+}
+
 SEC("lwt_in")
 __description("indirect variable-offset stack access, min out of bound")
 __failure __msg("invalid variable-offset indirect access to stack R2")
-- 
2.39.2


