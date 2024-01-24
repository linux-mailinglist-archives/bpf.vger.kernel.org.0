Return-Path: <bpf+bounces-20216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 158BD83A6D3
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 11:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8FE8288033
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 10:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9344A6AA6;
	Wed, 24 Jan 2024 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+TFDmzc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4C263B2;
	Wed, 24 Jan 2024 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706092232; cv=none; b=I6QaUT4LpywFIQRH9sbnv8miNdyHdHjP7ZuCmp2gWSBEHHLj9lHfZlhaBy/p9fmNGSLh5mOGb0BpMdqW0CvC+a+FUpbSlvkrUMKr90rrlRcXGCA0jIix2wTBkWzTowM73VoTSKDcXJ4o3Wv/oMytzNAtiCg/9YWu6pZ7OAFatQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706092232; c=relaxed/simple;
	bh=aW5AtCa7HXNpyKb0feXdplztHH1jKaVe0wBRnb/XW3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pUTxiMe09/4sYNpcKGSwNsJFgo+OuR8lvgQsaVyJXbwkvdy0eV826A3X+69wd6bVdXLsTDOv5bkeWI7IDV+3YDfS047O/VsRfjXVUKC0M+Vrxyg6gWcyzQZA8PJY6MGQcw1GNRjxG6YatfLUyQCn9L8trE0h4hTLtbVcBoTolRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+TFDmzc; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cdeb954640so62891261fa.3;
        Wed, 24 Jan 2024 02:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706092228; x=1706697028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+xaXvOg9nATJzG/O82cscnFir4ApsJXrCX0AxrjMsg4=;
        b=c+TFDmzckA4BkrrIwz1rcC5HUctkgUXnPOrzy0n1xTa9nnV/WfyTDiT8MEq81GB8Cv
         D+iNcXLdPxSyEnsf+CJaiuiNRbeh3qHjKGnNft8tILA/CA7OozMqg6trpg4Xk+WZ1pFn
         9vpvDDH4eA8Qv2f+rWazQDkWsYXqwrXpSWoPrAznetIU97GCoBHHa377QcoIOxbxdqXs
         C1hd6A85S6BKLAvHUgNa4uJQ04/Fh2BdZOKEb1KroD8mCFchrv82DVZTIp4IJbn5dktx
         nSmqjlGQnLYeWT2BgDcYSzBOrVKVZe5NBXlDRIi2OXh0Wys58Vwn/Gf4wBodLaiug70Y
         6Lxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706092228; x=1706697028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+xaXvOg9nATJzG/O82cscnFir4ApsJXrCX0AxrjMsg4=;
        b=hkrxYrU3v2TeGTrhgOJlYQia+1KXsyw85GMWgtDNn8zn4gK9Z0pgY4FaXiwYvmbRLF
         PUo2me096IGYlGewDrsUd1gV/UgpvfqoJD/mvb4Sbn41FfV+Glq+lLTaZ0eZGRGYLHQC
         jR7H2vo3ezi73S9abhDb1JTy2hZKS6pnXPcqjkBmRoR2oAAeVGZGU9yXhP+2ioONIV8u
         Ec8CnglwgAsWeAb8M/m9O4Y7wcePulRocOgy1HbOAjUkEHgw4ZyPKa2b2lSv9PseHbuj
         +Ogd9FHsX8VDUvQIsHju4sF+9iFHgEHtM+HHpxOKyDWUw81EwfAeKxNgu9fJiG2ox2hz
         Uijw==
X-Gm-Message-State: AOJu0YyMxF/hWGCMlV1Vt7Mx6ZexZ/6Gz7bA8q6k9uNtL7Bx4TrIEc/I
	raHE53+aQF1iDd6t0O/Dr/7RlV17izETgcojR2WzHxEIM06U1JPwnlBkRBA=
X-Google-Smtp-Source: AGHT+IHyS3VYWvxHH3M05S/tQiqHeMbNJgFsbZIQNds+0uK5rr2mFixcG4uzwhx4IMlohOg6WNvSnQ==
X-Received: by 2002:a2e:b0f1:0:b0:2cd:a311:6ae9 with SMTP id h17-20020a2eb0f1000000b002cda3116ae9mr608981ljl.5.1706092227677;
        Wed, 24 Jan 2024 02:30:27 -0800 (PST)
Received: from staff-net-cx-3510.intern.ethz.ch (2001-67c-10ec-5784-8000--16b.net6.ethz.ch. [2001:67c:10ec:5784:8000::16b])
        by smtp.gmail.com with ESMTPSA id i18-20020adffdd2000000b003393249d5dbsm8313945wrs.4.2024.01.24.02.30.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 24 Jan 2024 02:30:27 -0800 (PST)
From: Hao Sun <sunhao.th@gmail.com>
To: bpf@vger.kernel.org
Cc: andreimatei1@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	linux-kernel@vger.kernel.org,
	Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH bpf] bpf: Reject pointer spill with var offset
Date: Wed, 24 Jan 2024 11:30:10 +0100
Message-ID: <20240124103010.51408-1-sunhao.th@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_stack_write_var_off() does not reject pointer reg, this can lead
to pointer leak. When cpu_mitigation_off(), unprivileged users can add
var off to stack pointer, and loading the following prog enable them
leak kernel address:

func#0 @0
0: R1=ctx() R10=fp0
0: (7a) *(u64 *)(r10 -8) = 0          ; R10=fp0 fp-8_w=00000000
1: (7a) *(u64 *)(r10 -16) = 0         ; R10=fp0 fp-16_w=00000000
2: (7a) *(u64 *)(r10 -24) = 0         ; R10=fp0 fp-24_w=00000000
3: (bf) r6 = r1                       ; R1=ctx() R6_w=ctx()
4: (b7) r1 = 8                        ; R1_w=P8
5: (37) r1 /= 1                       ; R1_w=Pscalar()
6: (57) r1 &= 8                       ; R1_w=Pscalar(smin=smin32=0,smax=umax=smax32=umax32=8,var_off=(0x0; 0x8))
7: (bf) r2 = r10                      ; R2_w=fp0 R10=fp0
8: (07) r2 += -16                     ; R2_w=fp-16
9: (0f) r2 += r1                      ; R1_w=Pscalar(smin=smin32=0,smax=umax=smax32=umax32=8,var_off=(0x0; 0x8)) R2_w=fp(off=-16,smin=smin32=0,smax=umax=smax32=umax32=8,var_off=(0x0; 0x8))
10: (7b) *(u64 *)(r2 +0) = r6         ; R2_w=fp(off=-16,smin=smin32=0,smax=umax=smax32=umax32=8,var_off=(0x0; 0x8)) R6_w=ctx() fp-8_w=mmmmmmmm fp-16_w=mmmmmmmm
11: (18) r1 = 0x0                     ; R1_w=map_ptr(ks=4,vs=8)
13: (bf) r2 = r10                     ; R2_w=fp0 R10=fp0
14: (07) r2 += -16                    ; R2_w=fp-16
15: (bf) r3 = r10                     ; R3_w=fp0 R10=fp0
16: (07) r3 += -8                     ; R3_w=fp-8
17: (b7) r4 = 0                       ; R4_w=P0
18: (85) call bpf_map_update_elem#2   ; R0_w=Pscalar()
19: (79) r0 = *(u64 *)(r10 -8)        ; R0_w=Pscalar() R10=fp0 fp-8_w=mmmmmmmm
20: (95) exit
processed 20 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0

The prog first inits several slots, so it later can access, and then
adds var-off to fp, where it knows the off is -8. Finally, the prog
spills the ctx ptr and leaks it to a map, and unprivileged users can
read the pointer through a map lookup:

	Leaked Map Address: 0xffff98d3828f5700

Fix this by rejecting pointer reg in check_stack_write_var_off().
Applying the patch makes the prog rejected with "spilling pointer
with var-offset is disallowed".

Also add missed newline to error messages in this check.

Signed-off-by: Hao Sun <sunhao.th@gmail.com>
---

Note that it's hard to add this test to test_progs or test_verifier, as
this requires cpu_mitigation_off() setup, currently tested on my local.

 kernel/bpf/verifier.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f31868ba0c2d..c34b938fa06f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4627,6 +4627,11 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 	    (!value_reg && is_bpf_st_mem(insn) && insn->imm == 0))
 		writing_zero = true;
 
+	if (value_reg && __is_pointer_value(env->allow_ptr_leaks, value_reg)) {
+		verbose(env, "spilling pointer with var-offset is disallowed\n");
+		return -EINVAL;
+	}
+
 	for (i = min_off; i < max_off; i++) {
 		int spi;
 
@@ -4658,7 +4663,7 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 			 * later for CAP_PERFMON, as the write may not happen to
 			 * that slot.
 			 */
-			verbose(env, "spilled ptr in range of var-offset stack write; insn %d, ptr off: %d",
+			verbose(env, "spilled ptr in range of var-offset stack write; insn %d, ptr off: %d\n",
 				insn_idx, i);
 			return -EINVAL;
 		}
@@ -4694,7 +4699,7 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 		 * them, the error would be too confusing.
 		 */
 		if (*stype == STACK_INVALID && !env->allow_uninit_stack) {
-			verbose(env, "uninit stack in range of var-offset write prohibited for !root; insn %d, off: %d",
+			verbose(env, "uninit stack in range of var-offset write prohibited for !root; insn %d, off: %d\n",
 					insn_idx, i);
 			return -EINVAL;
 		}
-- 
2.34.1


