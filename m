Return-Path: <bpf+bounces-49475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7418FA1911D
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 13:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E71203AB629
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 12:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A68D212D62;
	Wed, 22 Jan 2025 12:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hssHHfYi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A03C212B39
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 12:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737547509; cv=none; b=QWWQCTOfqTQO4vUejpgqHyYXcjxOalXo9s78JXoOgeFVHmmcZl1cCViKCIl/b/hZAD83Q7cHFcJDONFsDfHDOdAsRWPoldZH8v+TUtn8rjhzDzxUiQKCZV3mrwQGYUuKADczDBzDkGAoOPRffDxeYQ/nitS62OXN6VoiRuwNoEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737547509; c=relaxed/simple;
	bh=ZFBW98UPTvZU4Vhis/qY77Tw000t8sOskTvhA3T9pY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMKFXtdDRRfd+MWSB3XRTCrhBQrlrgav1mfKooGqKFbcsCNb5pTtfgdNlWdgBuL7bkKmHki6p0oqBhV52ozfxwVsBM3kBLoxYRZL38zF+TwHBAGSnfUlACJu8N1itPJHR8Jv4dDY2bqSP5MtLB0//WiqKI9n0NtkmPdfmDFnStA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hssHHfYi; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21628b3fe7dso118808105ad.3
        for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 04:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737547506; x=1738152306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G9YnhYhlAwSR/bgJ6my/TfsoOeWkMATKaBOpbfFyQJM=;
        b=hssHHfYiVhQSTMm+SnfX8fBgSk+KJEbqWM616s1FoIqy3MU4OzJmArOQ1QrhNDNsXe
         +LhOz68Rz8wUNTQsz8eJQiemXojfhbUXLGRBEEUZKoHYu+zXAEOAvfaktjKUJK0iQpgI
         1MPnd/Ojtd5DVWScLcTTd3mTmwI+pP0caKOGndnSK0kGArSX0ZExqsVQjy5sYqlwi2Bg
         WG0h8an3ACmpqKpn52DmlFGhKyZwrr1we1K6bUKAPjFtXjtk/IuOLQ/P9xSRXZbE87ar
         tsQaFemycxihjkcFL46SN38rBrxcWp9+q+mSR7ChJsa/OTd+qud+YbQVat/aevfb1uSY
         XCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737547506; x=1738152306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G9YnhYhlAwSR/bgJ6my/TfsoOeWkMATKaBOpbfFyQJM=;
        b=CXrlEWSnDRcRWc83S12S63FsPNtlxDESe1ysSdkKio3cqR+eEzrs+aHrHMqwCK3zTG
         mipk9REl+s87YbuhEXH1RJBQ7e134KKe2sKSsl8FjFHPAfrmE7wA2CpS0IAL1usAkl54
         /cpSdFdPPtkFM48hW6t0cKCdkI8YWV/49kN1lY5zAnJTeRL/JdpGIMv2yhy6vpImNLVZ
         rcjnwkj49pWp2sGuhbDSJWeg9DT04FyKgLLtZQoe0qATTWVQ89okz1Kj/e1xVeCyRE/J
         AlNASgAM6PPu6Ef8ZwbT+Xk2bHNxWxRFXJlyofi/us3EAMxr6sWX2YHJ7t8Xq7LdEHiJ
         hQ/A==
X-Gm-Message-State: AOJu0YzcZklx//zqUe0+nmIcuk7isXDRG2YcsNbGNY4LMwqn1tXQ8Vs/
	7X9P0Cjp2Xh+IiQ3ArhTf1Uqq0tT3bAPrDQm3CfmDVm+t8iKOO0jK+f0aA==
X-Gm-Gg: ASbGncuu2sZX+oxXmN1sNYX6eL/5qh6aR+b9p/dh2b2I/SpnRkGyZ4zX98+d2n+jRoc
	qv1bSUjZfFJar/rrfe7yVqCljYkFje2U9Dm/OSrziQTwu9cFhn0JfGCC1JOs3qPmyZDUoKTTLZB
	QlwZLO5Iy8M172+aTHb66lsdFU9AyJBH9/AA7K7gXqEcz9OVx3F/1nKy9LKhiCziI33hVqTP5bY
	xVKzeYNRcC4sfbODhRCt28zIZ24OftXtUb2vfNBgymG1jxDHq4nVA2/KicMSojVY1Q0T59j34/i
X-Google-Smtp-Source: AGHT+IHBeW92ho/JRKYDVU24bfGR8WLwQPUIG70nwsqxdecJ8E/fU02hQKoHD5e2UaSPhhLlaMjo0g==
X-Received: by 2002:a05:6a00:4fcb:b0:727:99a8:cd31 with SMTP id d2e1a72fcca58-72daf97b5d3mr32020615b3a.14.1737547506322;
        Wed, 22 Jan 2025 04:05:06 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab816412sm11055732b3a.66.2025.01.22.04.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 04:05:05 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next v1 6/7] bpf: use register liveness information for func_states_equal
Date: Wed, 22 Jan 2025 04:04:41 -0800
Message-ID: <20250122120442.3536298-7-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250122120442.3536298-1-eddyz87@gmail.com>
References: <20250122120442.3536298-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Liveness analysis DFA computes a set of registers live before each
instruction. Leverage this information to skip comparison of dead
registers in func_states_equal(). This helps with convergance of
iterator processing loops, as bpf_reg_state->live marks can't be used
when loops are processed.

This has certain performance impact for selftests, here is a veristat
listing for bigger ones (this patch compared to previous patch):

File                  Program                     Insns    (DIFF)  States  (DIFF)
--------------------  --------------------------  ---------------  --------------
iters.bpf.o           checkpoint_states_deletion  -8617 (-87.68%)  -327 (-89.10%)
iters.bpf.o           iter_nested_iters            -140 (-18.13%)   -10 (-13.89%)
pyperf600_iter.bpf.o  on_event                    -2608 (-41.31%)   -29 (-10.32%)

Impact on sched_ext:

Program                 Insns     (DIFF)  States   (DIFF)
----------------------  ----------------  ---------------
lavd_dispatch           -34018 (-22.00%)  -1885 (-21.06%)
layered_dispatch         -1808 (-22.83%)    -86 (-13.85%)
layered_dump              -943 (-20.17%)    -44 (-16.30%)
layered_init              -995 (-18.05%)    -80 (-15.41%)
refresh_layer_cpumasks    -395 (-30.74%)    -34 (-28.33%)
rustland_init              -63 (-13.24%)      -3 (-8.11%)
rustland_init              -63 (-13.24%)      -3 (-8.11%)
tp_cgroup_attach_task      -53 (-26.24%)     -4 (-22.22%)
central_init              -146 (-25.09%)      -2 (-5.26%)
pair_dispatch             -331 (-17.34%)    -15 (-10.56%)
qmap_dispatch             -375 (-17.15%)    -26 (-14.94%)
userland_dispatch          -34 (-21.79%)     -4 (-23.53%)

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d36c5a3309e9..babc2e179c08 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18223,15 +18223,17 @@ static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *c
  * the current state will reach 'bpf_exit' instruction safely
  */
 static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_state *old,
-			      struct bpf_func_state *cur, enum exact_level exact)
+			      struct bpf_func_state *cur, u32 insn_idx, enum exact_level exact)
 {
-	int i;
+	u16 live_regs = env->insn_aux_data[insn_idx].live_regs_before;
+	u16 i;
 
 	if (old->callback_depth > cur->callback_depth)
 		return false;
 
 	for (i = 0; i < MAX_BPF_REG; i++)
-		if (!regsafe(env, &old->regs[i], &cur->regs[i],
+		if (((1 << i) & live_regs) &&
+		    !regsafe(env, &old->regs[i], &cur->regs[i],
 			     &env->idmap_scratch, exact))
 			return false;
 
@@ -18252,6 +18254,7 @@ static bool states_equal(struct bpf_verifier_env *env,
 			 struct bpf_verifier_state *cur,
 			 enum exact_level exact)
 {
+	u32 insn_idx;
 	int i;
 
 	if (old->curframe != cur->curframe)
@@ -18275,9 +18278,12 @@ static bool states_equal(struct bpf_verifier_env *env,
 	 * and all frame states need to be equivalent
 	 */
 	for (i = 0; i <= old->curframe; i++) {
+		insn_idx = i == old->curframe
+			   ? env->insn_idx
+			   : old->frame[i + 1]->callsite;
 		if (old->frame[i]->callsite != cur->frame[i]->callsite)
 			return false;
-		if (!func_states_equal(env, old->frame[i], cur->frame[i], exact))
+		if (!func_states_equal(env, old->frame[i], cur->frame[i], insn_idx, exact))
 			return false;
 	}
 	return true;
-- 
2.47.1


