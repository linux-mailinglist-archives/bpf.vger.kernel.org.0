Return-Path: <bpf+bounces-65173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40369B1CFFC
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 03:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B30B018C2C01
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 01:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4DB18DF9D;
	Thu,  7 Aug 2025 01:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhorD9sl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3666E7404E
	for <bpf@vger.kernel.org>; Thu,  7 Aug 2025 01:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754528544; cv=none; b=AgKt0css3dFyas6/y8pA38t0GPyHLh16CzmCV3vOO0iocR2DfS3g5LaZGmWOa8dVibYxGngxPLUlGtU+F+JkJfwq9tWQgiMDTcwgLye/QQF/HDWc4PEyuQE55TN3XZgEL2I19ADtFjOWv7XtS+fCN+W1fibwTGqCOrOUvsC9r5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754528544; c=relaxed/simple;
	bh=mJXQtW7ZIj3V9fxk0hqQNKVsbu3BxFiPBjghC9167g8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K5SOJbTaJuqxFSV3QYlOflm+0vhQ/CJklDKCMEDH2Q0yQWjjPnr1GeysMlTBqz4dEKErQ9+ONlBMy3WAQwI3Nfw0qDD7KvIev7TfCnsXUwYGyHaKZ7PT0eNInAeeC3BGUoHeSxBUQhS97+/xdny6rasEwumlB3Bg6kvSjZIi+I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhorD9sl; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76bee58e01cso659644b3a.1
        for <bpf@vger.kernel.org>; Wed, 06 Aug 2025 18:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754528542; x=1755133342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGS3Tjn/xqkWNMQsSwknBjUJkTJ1WHO38UT5hJVmUu4=;
        b=XhorD9slcd5vSG06EhLh+J2HkmL0CQpbMN3CqrqieHU8Qm+ovcAgCDW7PKiCcfbJ01
         MPecv6ahEssOW9+cqLR/sjS64nsAZJrUSMySK3EwHlABzqWqeV3oY3IZpsH/1w0Foha6
         kkomV3SXf41d5+qQu2Mihj6z+SHLG8nG1GME9aTVNgXDs20ChcHddRlcrDJdsjoD6bHM
         z0mkyUfszxZD4jT037put2SA+egVL5wgV3VsqjcHd4IGzzKQ0/BtKZR8Vc9E898Y6QJ2
         VWMkvf9+RUQegY7dCqJzG/v1MUOG+JYlTHUt1re7EyuzmRiDuDA51//1tXon4LS2MqI3
         D2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754528542; x=1755133342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGS3Tjn/xqkWNMQsSwknBjUJkTJ1WHO38UT5hJVmUu4=;
        b=vlDC1PKGykV3M72cZsW7R6zXzhJIC54W/RMXP5RV6wu9vq4gkYzVscypGKiJYji+kQ
         aZceq8qyKCzYVbOUch9iZurhRDfcMlGkaHowTGKW+5yUlNn6fOk+UPx6BqDRHDK0zn8w
         oEO4AnJ+Woix5tGCUy1sn9ZHvJp3eGxf9bPZz5R2jvEUxgD58lPxE3sHWOBQYx91yoY4
         18aoct4YoUzDOu0myoUd2+pb5PiVE8UK7o/cgzAbodqVKt+LDMY5AgVcLWHPn8mWmhm0
         R2LbLwPTUw+LAV9LmqQVvOU0hkqi7S9iQcha8lgIDblskSnhQATkgAtEFpU6F8Uv+8YD
         SihA==
X-Gm-Message-State: AOJu0YzhAMYbZBVltubs5RNIKHpbThSM8c07t7SIjv0FQNM2FifWJ+Vo
	O+lSxjiPAKnhuzYEc+pi1zb0Ws0znRkb6OUjMAbQ77uyr4lolSj9NON6N3c1eLDC
X-Gm-Gg: ASbGncsU31deH3XTwQCTSubbiztdxmQHSQ62ssqfUYxeiBlfOxCvXUcduYVFx/OQWZD
	kv0XSHYH9cYx1WUAYSimUb9G5C39TmEQqpRUhjqS/WhbM93zDQaB8pDTsxxZNdACzPPLllhuAq4
	dI06ouCr7z79VvLUW+h9Z+wDoNyG1Edp7fMAGG6Yc2Ef2ztd7HnY+nVTrbTLO56SqdvABLpX22j
	KVuQp1RYLOK9bWTtD/mzCXMWKvjp/pX4edXFNcqTIWpXmsnM4ITsVdUU0tvKBgp84NHb0HgwJsj
	XEBcr16bB8D5aOASpfzvJIutYdsZsco4wECG4gF0ml1cDvcIpvdUAm8Xz5I3/LZ+08gAiZRXW2c
	HYYM0vc1RmV+juldmurIwUBqAdTp6MeIS2ediZfh2JnXuhzEIKqCkgI0=
X-Google-Smtp-Source: AGHT+IG12FgJBJRWKP+LaiEEV7G1BPJrkJeFSmU+sdE9j2Ks+aMGX/U9UcbpKm4+GTZWM0Ncw3YzwQ==
X-Received: by 2002:a05:6a21:99a8:b0:220:4750:1fb1 with SMTP id adf61e73a8af0-24033018860mr7391996637.4.1754528542023;
        Wed, 06 Aug 2025 18:02:22 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:600::1:e57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7828a0sm14483348a12.2.2025.08.06.18.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 18:02:21 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH bpf-next v2 2/2] bpf: use realloc in bpf_patch_insn_data
Date: Wed,  6 Aug 2025 18:02:05 -0700
Message-ID: <20250807010205.3210608-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250807010205.3210608-1-eddyz87@gmail.com>
References: <20250807010205.3210608-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid excessive vzalloc/vfree calls when patching instructions in
do_misc_fixups(). bpf_patch_insn_data() uses vzalloc to allocate new
memory for env->insn_aux_data for each patch as follows:

  struct bpf_prog *bpf_patch_insn_data(env, ...)
  {
    ...
    new_data = vzalloc(... O(program size) ...);
    ...
    adjust_insn_aux_data(env, new_data, ...);
    ...
  }

  void adjust_insn_aux_data(env, new_data, ...)
  {
    ...
    memcpy(new_data, env->insn_aux_data);
    vfree(env->insn_aux_data);
    env->insn_aux_data = new_data;
    ...
  }

The vzalloc/vfree pair is hot in perf report collected for e.g.
pyperf180 test case. It can be replaced with a call to vrealloc in
order to reduce the number of actual memory allocations.

This is a stop-gap solution, as bpf_patch_insn_data is still hot in
the profile. More comprehansive solutions had been discussed before
e.g. as in [1].

[1] https://lore.kernel.org/bpf/CAEf4BzY_E8MSL4mD0UPuuiDcbJhh9e2xQo2=5w+ppRWWiYSGvQ@mail.gmail.com/

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 69eb2b5c2218..a61d57996692 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20699,12 +20699,11 @@ static void convert_pseudo_ld_imm64(struct bpf_verifier_env *env)
  * [0, off) and [off, end) to new locations, so the patched range stays zero
  */
 static void adjust_insn_aux_data(struct bpf_verifier_env *env,
-				 struct bpf_insn_aux_data *new_data,
 				 struct bpf_prog *new_prog, u32 off, u32 cnt)
 {
-	struct bpf_insn_aux_data *old_data = env->insn_aux_data;
+	struct bpf_insn_aux_data *data = env->insn_aux_data;
 	struct bpf_insn *insn = new_prog->insnsi;
-	u32 old_seen = old_data[off].seen;
+	u32 old_seen = data[off].seen;
 	u32 prog_len;
 	int i;
 
@@ -20712,22 +20711,20 @@ static void adjust_insn_aux_data(struct bpf_verifier_env *env,
 	 * (cnt == 1) is taken or not. There is no guarantee INSN at OFF is the
 	 * original insn at old prog.
 	 */
-	old_data[off].zext_dst = insn_has_def32(insn + off + cnt - 1);
+	data[off].zext_dst = insn_has_def32(insn + off + cnt - 1);
 
 	if (cnt == 1)
 		return;
 	prog_len = new_prog->len;
 
-	memcpy(new_data, old_data, sizeof(struct bpf_insn_aux_data) * off);
-	memcpy(new_data + off + cnt - 1, old_data + off,
-	       sizeof(struct bpf_insn_aux_data) * (prog_len - off - cnt + 1));
+	memmove(data + off + cnt - 1, data + off,
+		sizeof(struct bpf_insn_aux_data) * (prog_len - off - cnt + 1));
+	memset(data + off, 0, sizeof(struct bpf_insn_aux_data) * (cnt - 1));
 	for (i = off; i < off + cnt - 1; i++) {
 		/* Expand insni[off]'s seen count to the patched range. */
-		new_data[i].seen = old_seen;
-		new_data[i].zext_dst = insn_has_def32(insn + i);
+		data[i].seen = old_seen;
+		data[i].zext_dst = insn_has_def32(insn + i);
 	}
-	env->insn_aux_data = new_data;
-	vfree(old_data);
 }
 
 static void adjust_subprog_starts(struct bpf_verifier_env *env, u32 off, u32 len)
@@ -20765,10 +20762,14 @@ static struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 of
 	struct bpf_insn_aux_data *new_data = NULL;
 
 	if (len > 1) {
-		new_data = vzalloc(array_size(env->prog->len + len - 1,
-					      sizeof(struct bpf_insn_aux_data)));
+		new_data = vrealloc(env->insn_aux_data,
+				    array_size(env->prog->len + len - 1,
+					       sizeof(struct bpf_insn_aux_data)),
+				    GFP_KERNEL_ACCOUNT | __GFP_ZERO);
 		if (!new_data)
 			return NULL;
+
+		env->insn_aux_data = new_data;
 	}
 
 	new_prog = bpf_patch_insn_single(env->prog, off, patch, len);
@@ -20780,7 +20781,7 @@ static struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 of
 		vfree(new_data);
 		return NULL;
 	}
-	adjust_insn_aux_data(env, new_data, new_prog, off, len);
+	adjust_insn_aux_data(env, new_prog, off, len);
 	adjust_subprog_starts(env, off, len);
 	adjust_poke_descs(new_prog, off, len);
 	return new_prog;
-- 
2.47.3


