Return-Path: <bpf+bounces-77297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 917F3CD6E8B
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 19:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94E38301355F
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 18:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACF5306B3D;
	Mon, 22 Dec 2025 18:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNc1aCLw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45718248176
	for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 18:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766429916; cv=none; b=Iotm16X6wh2YPo4DhgRD2622tfar7ohekWjN8vLKAKHKY/dmAzwMAXtJIGalRyEqVuXgmBLieLcD8WNGZAQ/sKKP051GMXL/CtEqvHs0Ta6pzeAPZ0Ipj9z8PPA+B24aK+l0ArtfzA1UXb2X9kcLjmkFzLuWrYWcOzfXPbWo7/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766429916; c=relaxed/simple;
	bh=wBXin+HmlPLDftoIA3Gx+6mA5tdxYXTVE3xcvodQnZU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AyJ+3qujFDijypUyiskqzkWtGAv/1/KBRPvdsbhuGIneh6TKe2sc3SIO4l3qrCvK9AGb3A2hJPtCoFSg/iKZEcGTCcq5P7VjjbsWX/7PXtGxa6/QAXOFWJWFR52cz7DJxsthQV2Jtr1yBq+bZK3SRdlPba4l5crTT0ZX4UHgLfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNc1aCLw; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42fbc305914so3249938f8f.0
        for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 10:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766429912; x=1767034712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LAqvyC3oBc+HjvBJ1Wxnq0zsruOgZpBNwjaomyZ4sqA=;
        b=cNc1aCLwKwBB2fc0NeJBHEue5uduzCxsCf9Ns7fATEJTmf/BiWSRiaYdW8UAxLbXmQ
         qWvczDkvHwJ4NIwRGzXfy/aQhikSPGPWQFXAY2v+Q178ysakRQ6VjpkKv6Aqp7241B+4
         sUumWvk0lpHSZAaPNPma7NH3GtVnoQB95pCCRiQR9BR/UB+SmJ95h6S2WselN0ELNrie
         PN30nm9yeBGZdHMQiHIiSdZl3w6MecG+npM37MudQAv+9MVQbeA1ihV2yly+KwgsZ9Px
         bNHecCgPX59nlM37UbgrkZcdbNP+te9vheyTR29TF5GZhbayiW6jViWqF4QI4S/0PZBv
         KM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766429912; x=1767034712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAqvyC3oBc+HjvBJ1Wxnq0zsruOgZpBNwjaomyZ4sqA=;
        b=KIpLJcb6MqRMISBxgmFApAlaf2/Waa5S/qg+K4Q4E16e7INzbG1CdmPYZYZHuSw8Mm
         kzL8TQp2DuofFvD8TeU3xBmYnEnF0qEGF694BlvO3tSMRJtbvJPMXTmlFkDjPfgHlJQT
         mQPo3w5ud7hApIhD/yfKSLUP/l16xNJRsGu6zFvf8hmolL7WNFjmYZqoE4FBTQ+kEvZt
         tytU8GI1ngQhCa7AAn8fM4PT2GWSZHQF1hOFxzmQ53Ferw68Nlb9iU7h25sbUDZOGcR4
         Cd86fEdfapY96as9Gdd0b5xQfqhoX90R69FrGv/z7NXrBkN+zolD1wDJQe1wOH/zhB8s
         vi2Q==
X-Gm-Message-State: AOJu0Ywg+Cu7YEQvtwtr9zdxgrjakXwJP6wcWUcEKkKpv/6oNS0nbEZO
	V8jPmWYq2qScbgegRFKCv4KcY0ZDYU+oWCpmsIhkegzjOsb/aFTcUWszlVBoaA==
X-Gm-Gg: AY/fxX49qwWg/AeB6JAlX17/KceVqj+QLqGYQPHX9nQhNyIraujO972LPNSya7Z46Qe
	O7sip297VxGXPLbCN6mfQoqVGuXuvLKS4R/M+/YCRziO7iW7nzxfoiUPwHaLZTcDouXLabqL/fk
	VqCVZ7NMkjN7oLcUWu2JWNw7HtDoSmHBhPbsvcSTOjXaTT0ArFoGLQD93ubfbeJg31rPw1dyJBF
	wX+q89mzJ4mzMWfzzpmjogPfmC4xnBZSZs+3nELo6+WYyCNVXk7VU0GwWhsPXOLNOHOi/2VHGWu
	RQIzrOjcQUPBsKmCZPBNK/a5zu/kLkm1q8aQAqcuqkGKB+W9uUQNctu/a/FUnIsm0g4a+R6kCYq
	re4t3qNxAH3FCyLvqtuO0w9c1xw1oz5qcd4DjAjj9qjnELNb97GXU0qEnBPTuAQpUqSC2DSSb88
	Twf4oEhUUgl++hzrI=
X-Google-Smtp-Source: AGHT+IGtmySuEdCUCmNU2tr1/8roibcVLb5swr/c82cbH6w79ghlv+yWBZBxTjQveFOWLRTxPizbYA==
X-Received: by 2002:a05:6000:26d1:b0:430:f463:b6a7 with SMTP id ffacd0b85a97d-4324e50ec19mr14478225f8f.45.1766429912219;
        Mon, 22 Dec 2025 10:58:32 -0800 (PST)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-43264613923sm6794708f8f.26.2025.12.22.10.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 10:58:31 -0800 (PST)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	eddyz87@gmail.com,
	andrii@kernel.org,
	paul.chaignon@gmail.com,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next] verifier: add prune points to live registers print
Date: Mon, 22 Dec 2025 18:58:13 +0000
Message-Id: <20251222185813.150505-1-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Explicitly printing where prune points are placed within the
instructions allows for better debugging of state pruning issues.

	Live regs before insn, prune points (p), and force checkpoints (P):
	      0: ..........   (b7) r1 = 0
	      1: .1........   (63) *(u32 *)(r10 -4) = r1
	      2: ..........   (bf) r2 = r10
	      3: ..2.......   (07) r2 += -4
	      4: ..2.......   (18) r1 = 0xffff8cb747b16000
	      6: .12.......   (85) call bpf_map_lookup_elem#1
	      7: 0..345.... p (bf) r6 = r0
	      8: ...3456... p (15) if r6 == 0x0 goto pc+6
	      9: ...3456...   (b7) r1 = 5
	     10: .1.3456...   (b7) r2 = 3
	     11: .123456... p (85) call pc+5
	     12: 0.....6... p (67) r0 <<= 32
	     13: 0.....6...   (c7) r0 s>>= 32
	     14: 0.....6...   (7b) *(u64 *)(r6 +0) = r0
	     15: .......... p (b7) r0 = 0
	     16: 0.........   (95) exit
	     17: .12....... p (bf) r0 = r2
	     18: 01........   (0f) r0 += r1
	     19: 0.........   (95) exit

Also uses uppercase P for force checkpoints, which are a subset of prune
points (a force checkpoint should already be a prune point).

	Live regs before insn, prune points (p), and force checkpoints (P):
	      0: .......... p (b7) r1 = 1
	      1: .1........ P (e5) may_goto pc+1
	      2: ..........   (05) goto pc-3
	      3: .1........ p (bf) r0 = r1
	      4: 0.........   (95) exit

Existing tests on liveness tracking had to be updated with the new
output format including the prune points.

This proposal patch was presented at Linux Plumbers 2025 in Tokyo along
the "Making Sense of State Pruning" presentation[^1] with the intent of
making state pruning more transparent to the user.

[^1]: https://lpc.events/event/19/contributions/2162/

Co-developed-by: Paul Chaignon <paul.chaignon@gmail.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 kernel/bpf/verifier.c                         |   9 +-
 .../bpf/progs/compute_live_registers.c        | 172 +++++++++---------
 .../selftests/bpf/progs/verifier_live_stack.c |  18 +-
 3 files changed, 102 insertions(+), 97 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d6b8a77fbe3b..a82702405c12 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -24892,7 +24892,7 @@ static int compute_live_registers(struct bpf_verifier_env *env)
 		insn_aux[i].live_regs_before = state[i].in;

 	if (env->log.level & BPF_LOG_LEVEL2) {
-		verbose(env, "Live regs before insn:\n");
+		verbose(env, "Live regs before insn, pruning points (p), and force checkpoints (P):\n");
 		for (i = 0; i < insn_cnt; ++i) {
 			if (env->insn_aux_data[i].scc)
 				verbose(env, "%3d ", env->insn_aux_data[i].scc);
@@ -24904,7 +24904,12 @@ static int compute_live_registers(struct bpf_verifier_env *env)
 					verbose(env, "%d", j);
 				else
 					verbose(env, ".");
-			verbose(env, " ");
+			if (is_force_checkpoint(env, i))
+				verbose(env, " P ");
+			else if (is_prune_point(env, i))
+				verbose(env, " p ");
+			else
+				verbose(env, "   ");
 			verbose_insn(env, &insns[i]);
 			if (bpf_is_ldimm64(&insns[i]))
 				i++;
diff --git a/tools/testing/selftests/bpf/progs/compute_live_registers.c b/tools/testing/selftests/bpf/progs/compute_live_registers.c
index 6884ab99a421..10da72518423 100644
--- a/tools/testing/selftests/bpf/progs/compute_live_registers.c
+++ b/tools/testing/selftests/bpf/progs/compute_live_registers.c
@@ -21,18 +21,18 @@ struct {

 SEC("socket")
 __log_level(2)
-__msg(" 0: .......... (b7) r0 = 42")
-__msg(" 1: 0......... (bf) r1 = r0")
-__msg(" 2: .1........ (bf) r2 = r1")
-__msg(" 3: ..2....... (bf) r3 = r2")
-__msg(" 4: ...3...... (bf) r4 = r3")
-__msg(" 5: ....4..... (bf) r5 = r4")
-__msg(" 6: .....5.... (bf) r6 = r5")
-__msg(" 7: ......6... (bf) r7 = r6")
-__msg(" 8: .......7.. (bf) r8 = r7")
-__msg(" 9: ........8. (bf) r9 = r8")
-__msg("10: .........9 (bf) r0 = r9")
-__msg("11: 0......... (95) exit")
+__msg(" 0: ..........   (b7) r0 = 42")
+__msg(" 1: 0.........   (bf) r1 = r0")
+__msg(" 2: .1........   (bf) r2 = r1")
+__msg(" 3: ..2.......   (bf) r3 = r2")
+__msg(" 4: ...3......   (bf) r4 = r3")
+__msg(" 5: ....4.....   (bf) r5 = r4")
+__msg(" 6: .....5....   (bf) r6 = r5")
+__msg(" 7: ......6...   (bf) r7 = r6")
+__msg(" 8: .......7..   (bf) r8 = r7")
+__msg(" 9: ........8.   (bf) r9 = r8")
+__msg("10: .........9   (bf) r0 = r9")
+__msg("11: 0.........   (95) exit")
 __naked void assign_chain(void)
 {
 	asm volatile (
@@ -53,13 +53,13 @@ __naked void assign_chain(void)

 SEC("socket")
 __log_level(2)
-__msg("0: .......... (b7) r1 = 7")
-__msg("1: .1........ (07) r1 += 7")
-__msg("2: .......... (b7) r2 = 7")
-__msg("3: ..2....... (b7) r3 = 42")
-__msg("4: ..23...... (0f) r2 += r3")
-__msg("5: .......... (b7) r0 = 0")
-__msg("6: 0......... (95) exit")
+__msg("0: ..........   (b7) r1 = 7")
+__msg("1: .1........   (07) r1 += 7")
+__msg("2: ..........   (b7) r2 = 7")
+__msg("3: ..2.......   (b7) r3 = 42")
+__msg("4: ..23......   (0f) r2 += r3")
+__msg("5: ..........   (b7) r0 = 0")
+__msg("6: 0.........   (95) exit")
 __naked void arithmetics(void)
 {
 	asm volatile (
@@ -76,12 +76,12 @@ __naked void arithmetics(void)
 #ifdef CAN_USE_BPF_ST
 SEC("socket")
 __log_level(2)
-__msg("  1: .1........ (07) r1 += -8")
-__msg("  2: .1........ (7a) *(u64 *)(r1 +0) = 7")
-__msg("  3: .1........ (b7) r2 = 42")
-__msg("  4: .12....... (7b) *(u64 *)(r1 +0) = r2")
-__msg("  5: .12....... (7b) *(u64 *)(r1 +0) = r2")
-__msg("  6: .......... (b7) r0 = 0")
+__msg("  1: .1........   (07) r1 += -8")
+__msg("  2: .1........   (7a) *(u64 *)(r1 +0) = 7")
+__msg("  3: .1........   (b7) r2 = 42")
+__msg("  4: .12.......   (7b) *(u64 *)(r1 +0) = r2")
+__msg("  5: .12.......   (7b) *(u64 *)(r1 +0) = r2")
+__msg("  6: ..........   (b7) r0 = 0")
 __naked void store(void)
 {
 	asm volatile (
@@ -99,9 +99,9 @@ __naked void store(void)

 SEC("socket")
 __log_level(2)
-__msg("1: ....4..... (07) r4 += -8")
-__msg("2: ....4..... (79) r5 = *(u64 *)(r4 +0)")
-__msg("3: ....45.... (07) r4 += -8")
+__msg("1: ....4.....   (07) r4 += -8")
+__msg("2: ....4.....   (79) r5 = *(u64 *)(r4 +0)")
+__msg("3: ....45....   (07) r4 += -8")
 __naked void load(void)
 {
 	asm volatile (
@@ -116,9 +116,9 @@ __naked void load(void)

 SEC("socket")
 __log_level(2)
-__msg("0: .1........ (61) r2 = *(u32 *)(r1 +0)")
-__msg("1: ..2....... (d4) r2 = le64 r2")
-__msg("2: ..2....... (bf) r0 = r2")
+__msg("0: .1........   (61) r2 = *(u32 *)(r1 +0)")
+__msg("1: ..2.......   (d4) r2 = le64 r2")
+__msg("2: ..2.......   (bf) r0 = r2")
 __naked void endian(void)
 {
 	asm volatile (
@@ -131,13 +131,13 @@ __naked void endian(void)

 SEC("socket")
 __log_level(2)
-__msg(" 8: 0......... (b7) r1 = 1")
-__msg(" 9: 01........ (db) r1 = atomic64_fetch_add((u64 *)(r0 +0), r1)")
-__msg("10: 01........ (c3) lock *(u32 *)(r0 +0) += r1")
-__msg("11: 01........ (db) r1 = atomic64_xchg((u64 *)(r0 +0), r1)")
-__msg("12: 01........ (bf) r2 = r0")
-__msg("13: .12....... (bf) r0 = r1")
-__msg("14: 012....... (db) r0 = atomic64_cmpxchg((u64 *)(r2 +0), r0, r1)")
+__msg(" 8: 0.........   (b7) r1 = 1")
+__msg(" 9: 01........   (db) r1 = atomic64_fetch_add((u64 *)(r0 +0), r1)")
+__msg("10: 01........   (c3) lock *(u32 *)(r0 +0) += r1")
+__msg("11: 01........   (db) r1 = atomic64_xchg((u64 *)(r0 +0), r1)")
+__msg("12: 01........   (bf) r2 = r0")
+__msg("13: .12.......   (bf) r0 = r1")
+__msg("14: 012.......   (db) r0 = atomic64_cmpxchg((u64 *)(r2 +0), r0, r1)")
 __naked void atomic(void)
 {
 	asm volatile (
@@ -167,9 +167,9 @@ __naked void atomic(void)

 SEC("socket")
 __log_level(2)
-__msg("2: .12....... (db) store_release((u64 *)(r2 -8), r1)")
-__msg("3: .......... (bf) r3 = r10")
-__msg("4: ...3...... (db) r4 = load_acquire((u64 *)(r3 -8))")
+__msg("2: .12.......   (db) store_release((u64 *)(r2 -8), r1)")
+__msg("3: ..........   (bf) r3 = r10")
+__msg("4: ...3......   (db) r4 = load_acquire((u64 *)(r3 -8))")
 __naked void atomic_load_acq_store_rel(void)
 {
 	asm volatile (
@@ -192,8 +192,8 @@ __naked void atomic_load_acq_store_rel(void)

 SEC("socket")
 __log_level(2)
-__msg("4: .12....7.. (85) call bpf_trace_printk#6")
-__msg("5: 0......7.. (0f) r0 += r7")
+__msg("4: .12....7..   (85) call bpf_trace_printk#6")
+__msg("5: 0......7.. p (0f) r0 += r7")
 __naked void regular_call(void)
 {
 	asm volatile (
@@ -211,8 +211,8 @@ __naked void regular_call(void)

 SEC("socket")
 __log_level(2)
-__msg("2: 012....... (25) if r1 > 0x7 goto pc+1")
-__msg("3: ..2....... (bf) r0 = r2")
+__msg("2: 012....... p (25) if r1 > 0x7 goto pc+1")
+__msg("3: ..2.......   (bf) r0 = r2")
 __naked void if1(void)
 {
 	asm volatile (
@@ -226,8 +226,8 @@ __naked void if1(void)

 SEC("socket")
 __log_level(2)
-__msg("3: 0123...... (2d) if r1 > r3 goto pc+1")
-__msg("4: ..2....... (bf) r0 = r2")
+__msg("3: 0123...... p (2d) if r1 > r3 goto pc+1")
+__msg("4: ..2.......   (bf) r0 = r2")
 __naked void if2(void)
 {
 	asm volatile (
@@ -243,7 +243,7 @@ __naked void if2(void)
 /* Verifier misses that r2 is alive if jset is not handled properly */
 SEC("socket")
 __log_level(2)
-__msg("2: 012....... (45) if r1 & 0x7 goto pc+1")
+__msg("2: 012....... p (45) if r1 & 0x7 goto pc+1")
 __naked void if3_jset_bug(void)
 {
 	asm volatile (
@@ -258,15 +258,15 @@ __naked void if3_jset_bug(void)

 SEC("socket")
 __log_level(2)
-__msg("0: .......... (b7) r1 = 0")
-__msg("1: .1........ (b7) r2 = 7")
-__msg("2: .12....... (25) if r1 > 0x7 goto pc+4")
-__msg("3: .12....... (07) r1 += 1")
-__msg("4: .12....... (27) r2 *= 2")
-__msg("5: .12....... (05) goto pc+0")
-__msg("6: .12....... (05) goto pc-5")
-__msg("7: .......... (b7) r0 = 0")
-__msg("8: 0......... (95) exit")
+__msg("0: ..........   (b7) r1 = 0")
+__msg("1: .1........   (b7) r2 = 7")
+__msg("2: .12....... p (25) if r1 > 0x7 goto pc+4")
+__msg("3: .12.......   (07) r1 += 1")
+__msg("4: .12.......   (27) r2 *= 2")
+__msg("5: .12.......   (05) goto pc+0")
+__msg("6: .12....... p (05) goto pc-5")
+__msg("7: .......... p (b7) r0 = 0")
+__msg("8: 0.........   (95) exit")
 __naked void loop(void)
 {
 	asm volatile (
@@ -287,11 +287,11 @@ __naked void loop(void)
 #ifdef CAN_USE_GOTOL
 SEC("socket")
 __log_level(2)
-__msg("2: .123...... (25) if r1 > 0x7 goto pc+2")
-__msg("3: ..2....... (bf) r0 = r2")
-__msg("4: 0......... (06) gotol pc+1")
-__msg("5: ...3...... (bf) r0 = r3")
-__msg("6: 0......... (95) exit")
+__msg("2: .123...... p (25) if r1 > 0x7 goto pc+2")
+__msg("3: ..2.......   (bf) r0 = r2")
+__msg("4: 0.........   (06) gotol pc+1")
+__msg("5: ...3...... p (bf) r0 = r3")
+__msg("6: 0......... p (95) exit")
 __naked void gotol(void)
 {
 	asm volatile (
@@ -310,11 +310,11 @@ __naked void gotol(void)

 SEC("socket")
 __log_level(2)
-__msg("0: .......... (b7) r1 = 1")
-__msg("1: .1........ (e5) may_goto pc+1")
-__msg("2: .......... (05) goto pc-3")
-__msg("3: .1........ (bf) r0 = r1")
-__msg("4: 0......... (95) exit")
+__msg("0: .......... p (b7) r1 = 1")
+__msg("1: .1........ P (e5) may_goto pc+1")
+__msg("2: ..........   (05) goto pc-3")
+__msg("3: .1........ p (bf) r0 = r1")
+__msg("4: 0.........   (95) exit")
 __naked void may_goto(void)
 {
 	asm volatile (
@@ -331,8 +331,8 @@ __naked void may_goto(void)

 SEC("socket")
 __log_level(2)
-__msg("1: 0......... (18) r2 = 0x7")
-__msg("3: 0.2....... (0f) r0 += r2")
+__msg("1: 0.........   (18) r2 = 0x7")
+__msg("3: 0.2.......   (0f) r0 += r2")
 __naked void ldimm64(void)
 {
 	asm volatile (
@@ -347,11 +347,11 @@ __naked void ldimm64(void)
 /* No rules specific for LD_ABS/LD_IND, default behaviour kicks in */
 SEC("socket")
 __log_level(2)
-__msg("2: 0123456789 (30) r0 = *(u8 *)skb[42]")
-__msg("3: 012.456789 (0f) r7 += r0")
-__msg("4: 012.456789 (b7) r3 = 42")
-__msg("5: 0123456789 (50) r0 = *(u8 *)skb[r3 + 0]")
-__msg("6: 0......7.. (0f) r7 += r0")
+__msg("2: 0123456789   (30) r0 = *(u8 *)skb[42]")
+__msg("3: 012.456789   (0f) r7 += r0")
+__msg("4: 012.456789   (b7) r3 = 42")
+__msg("5: 0123456789   (50) r0 = *(u8 *)skb[r3 + 0]")
+__msg("6: 0......7..   (0f) r7 += r0")
 __naked void ldabs(void)
 {
 	asm volatile (
@@ -373,9 +373,9 @@ __naked void ldabs(void)
 #ifdef __BPF_FEATURE_ADDR_SPACE_CAST
 SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
 __log_level(2)
-__msg(" 6: .12345.... (85) call bpf_arena_alloc_pages")
-__msg(" 7: 0......... (bf) r1 = addr_space_cast(r0, 0, 1)")
-__msg(" 8: .1........ (b7) r2 = 42")
+__msg(" 6: .12345....   (85) call bpf_arena_alloc_pages")
+__msg(" 7: 0......... p (bf) r1 = addr_space_cast(r0, 0, 1)")
+__msg(" 8: .1........   (b7) r2 = 42")
 __naked void addr_space_cast(void)
 {
 	asm volatile (
@@ -408,17 +408,17 @@ static __used __naked int aux1(void)

 SEC("socket")
 __log_level(2)
-__msg("0: ....45.... (b7) r1 = 1")
-__msg("1: .1..45.... (b7) r2 = 2")
-__msg("2: .12.45.... (b7) r3 = 3")
+__msg("0: ....45....   (b7) r1 = 1")
+__msg("1: .1..45....   (b7) r2 = 2")
+__msg("2: .12.45....   (b7) r3 = 3")
 /* Conservative liveness for subprog parameters. */
-__msg("3: .12345.... (85) call pc+2")
-__msg("4: .......... (b7) r0 = 0")
-__msg("5: 0......... (95) exit")
-__msg("6: .12....... (bf) r0 = r1")
-__msg("7: 0.2....... (0f) r0 += r2")
+__msg("3: .12345.... p (85) call pc+2")
+__msg("4: .......... p (b7) r0 = 0")
+__msg("5: 0.........   (95) exit")
+__msg("6: .12....... p (bf) r0 = r1")
+__msg("7: 0.2.......   (0f) r0 += r2")
 /* Conservative liveness for subprog return value. */
-__msg("8: 0......... (95) exit")
+__msg("8: 0.........   (95) exit")
 __naked void subprog1(void)
 {
 	asm volatile (
diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index 2de105057bbc..105b453be6d3 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -136,12 +136,12 @@ static __used __naked void write_first_param(void)
 SEC("socket")
 __log_level(2)
 /* caller_stack_read() function */
-__msg("2: .12345.... (85) call pc+4")
-__msg("5: .12345.... (85) call pc+1")
-__msg("6: 0......... (95) exit")
+__msg("2: .12345.... p (85) call pc+4")
+__msg("5: .12345.... p (85) call pc+1")
+__msg("6: 0......... p (95) exit")
 /* read_first_param() function */
-__msg("7: .1........ (79) r0 = *(u64 *)(r1 +0)")
-__msg("8: 0......... (95) exit")
+__msg("7: .1........ p (79) r0 = *(u64 *)(r1 +0)")
+__msg("8: 0.........   (95) exit")
 /* update for callsite at (2) */
 __msg("(2,7) frame 0 insn 7 +live -8")
 __msg("(2,7) live stack update done in 2 iterations")
@@ -177,10 +177,10 @@ SEC("socket")
 __flag(BPF_F_TEST_STATE_FREQ)
 __log_level(2)
 /* read_first_param2() function */
-__msg(" 9: .1........ (79) r0 = *(u64 *)(r1 +0)")
-__msg("10: .......... (b7) r0 = 0")
-__msg("11: 0......... (05) goto pc+0")
-__msg("12: 0......... (95) exit")
+__msg(" 9: .1........ p (79) r0 = *(u64 *)(r1 +0)")
+__msg("10: ..........   (b7) r0 = 0")
+__msg("11: 0.........   (05) goto pc+0")
+__msg("12: 0......... p (95) exit")
 /*
  * The purpose of the test is to check that checkpoint in
  * read_first_param2() stops path traversal. This will only happen if
--
2.34.1


