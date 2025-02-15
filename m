Return-Path: <bpf+bounces-51648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F124EA36D8D
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 12:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE4D0169C90
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 11:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639381A3168;
	Sat, 15 Feb 2025 11:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csuBRfTs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755FB567D
	for <bpf@vger.kernel.org>; Sat, 15 Feb 2025 11:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739617471; cv=none; b=fW9iRZaIOk8YVTgOp8Z7/Hfu+pNmXWiW3B6XAjeOunZgk1gmshDZk/YPFfPEZL3O7X1Dsl1D+LvCoCF+2/e5fn1VGEfXDoOULcBrsxxL/+slBlszyA/qn3Vjz8TVcpy6/sQQjen9iykMG5JhYYKZdOiMpQiUdlCsrCHrizwUibc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739617471; c=relaxed/simple;
	bh=WkCPlxXztbh4fxcmSu4WiZv7V4WDMRd9RR5F8AEMpBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZH1oUpyRsb9MdppwgvjROIL/vD7+9fvoED5PXL7I+gk7qI7hi5PlZD7SM9QAKzUdEVKpJCqrtQY2o9enNiF9RsHRtmDSkOyq5nAtO+kBqLluy72O5dMrFTITkjdnC2slM7v816kfyKZuvhubEER/DMKf2pjFW1g+mzem7KlPf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csuBRfTs; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220d601886fso37846315ad.1
        for <bpf@vger.kernel.org>; Sat, 15 Feb 2025 03:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739617469; x=1740222269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Al1gouzPQIoojWQkgz4Tm7UeYY8vUvaXcnuySNT5o1A=;
        b=csuBRfTspUuLLgBROT76Ysf//pWAZFIxR7LObJNDMgwFUopmYP5pPPa8H33gRIeNIL
         GvmC2SQlq+Z+B9Hsf/MXXP9uw/Yx5QZ2OGgJF0y4liC08i7w1IM6nEMcl7r+txaswTvs
         H7mDiAT0BUXPnk3UzkrWKzT1CtWBz5DnWWm6+bhHfJQqPvMeWD7wGc+FbZH1O3w0MpNI
         W9S8halvx1VH7nJeBGIiiILe8BdorH6k6HjKOa3LkmMEvsw6D+A/3b0KfFc259Tl0c3x
         tUU8EqOREbZTBUu99JQeV215f+CwLNLqrzXpZ0i9ba2YLD1Wols73J89Zl0dved0q6Sn
         HDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739617469; x=1740222269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Al1gouzPQIoojWQkgz4Tm7UeYY8vUvaXcnuySNT5o1A=;
        b=nCWm4JCmszu7MkU7yd2p6qino32X3qAisbp3qiv4nIT+ikqAEyCE9ixeywdVg8emkW
         0w+kYjqUeVh6NkXikTDsbcvmFL99WoNPF+VEECQE5b8TyiWPVfxOIQWhk08/gmnt4K6/
         vfhJ0KKmJ0g0p3KrKMDoTkT+nru+HrH91WcAoIHq9PbVy3fP+aA5vWEykNqGXI4fjb1A
         o6O5L4pHx5tJAJ9Ez5VrrQjPTuzDPID3y3vkVb95wxxwmAjp0HYOVM74u6GamoJgarPG
         D3+eSry32AmBbC+VHLGAzaidBPA8s+i6eelZ0lBYCaxCcCSQKOZaiy3Bm7YKLMS4r6qH
         0xhw==
X-Gm-Message-State: AOJu0Yx7mnWovTOAKq2TM/oL8A7IhAuFk/qEWWSWnWRJp1N/r5ktriTh
	1r7H2L8J3RrmyB++A3gk6XyVUiVnFPXkyGTtmyaKnSz8wij8gx6S3RFniA==
X-Gm-Gg: ASbGncsXCeAYWtMy83XjCyBEqcYqRc9rbrI+jp3a5m4s7KiKE9M2vFIoMKFci/BohdU
	7pfRFxoe/40onuRg8Dqb6bXNWpcza/wVSKSkzPm1a/iz5NzPKs54J9GRWhn6kS7XkNsZPyC0R3M
	DdRBsXWRsvxIOaBzqazrdXg7q1cWdFD4/28D6IyETHlvj1ijtNfC/ayBxF/WvoM+pxtZXu5bIGO
	0s7DnD15QEBFcEncvo72ioWqRnpeHLYWvk4IScGooVdQsy3NRW0DVMH1ga2aOIUiDIEXQ3MgRPu
	oJRIa38KQ6U=
X-Google-Smtp-Source: AGHT+IG04Sd8tTP3fhqex/mq6o+SojIPDFiV4j4U3Ba2t9hOZs3ZZ99Rfsp55rv3NhRru4cESFs1Ug==
X-Received: by 2002:a05:6a20:430b:b0:1e0:d87a:f67 with SMTP id adf61e73a8af0-1ee8cb5d455mr4903916637.13.1739617469407;
        Sat, 15 Feb 2025 03:04:29 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7326d58d4d0sm72435b3a.94.2025.02.15.03.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 03:04:28 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	tj@kernel.org,
	patsomaru@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 01/10] bpf: copy_verifier_state() should copy 'loop_entry' field
Date: Sat, 15 Feb 2025 03:03:52 -0800
Message-ID: <20250215110411.3236773-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250215110411.3236773-1-eddyz87@gmail.com>
References: <20250215110411.3236773-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bpf_verifier_state.loop_entry state should be copied by
copy_verifier_state(). Otherwise, .loop_entry values from unrelated
states would poison env->cur_state.

Additionally, env->stack should not contain any states with
.loop_entry != NULL. The states in env->stack are yet to be verified,
while .loop_entry is set for states that reached an equivalent state.
This means that env->cur_state->loop_entry should always be NULL after
pop_stack().

See the selftest in the next commit for an example of the program that
is not safe yet is accepted by verifier w/o this fix.

This change has some verification performance impact for selftests:

File                                Program                       Insns (A)  Insns (B)  Insns   (DIFF)  States (A)  States (B)  States (DIFF)
----------------------------------  ----------------------------  ---------  ---------  --------------  ----------  ----------  -------------
arena_htab.bpf.o                    arena_htab_llvm                     717        426  -291 (-40.59%)          57          37  -20 (-35.09%)
arena_htab_asm.bpf.o                arena_htab_asm                      597        445  -152 (-25.46%)          47          37  -10 (-21.28%)
arena_list.bpf.o                    arena_list_del                      309        279    -30 (-9.71%)          23          14   -9 (-39.13%)
iters.bpf.o                         iter_subprog_check_stacksafe        155        141    -14 (-9.03%)          15          14    -1 (-6.67%)
iters.bpf.o                         iter_subprog_iters                 1094       1003    -91 (-8.32%)          88          83    -5 (-5.68%)
iters.bpf.o                         loop_state_deps2                    479        725  +246 (+51.36%)          46          63  +17 (+36.96%)
kmem_cache_iter.bpf.o               open_coded_iter                      63         59     -4 (-6.35%)           7           6   -1 (-14.29%)
verifier_bits_iter.bpf.o            max_words                            92         84     -8 (-8.70%)           8           7   -1 (-12.50%)
verifier_iterating_callbacks.bpf.o  cond_break2                         113        107     -6 (-5.31%)          12          12    +0 (+0.00%)

And significant negative impact for sched_ext:

File               Program                 Insns (A)  Insns (B)  Insns         (DIFF)  States (A)  States (B)  States      (DIFF)
-----------------  ----------------------  ---------  ---------  --------------------  ----------  ----------  ------------------
bpf.bpf.o          lavd_init                    7039      14723      +7684 (+109.16%)         490        1139     +649 (+132.45%)
bpf.bpf.o          layered_dispatch            11485      10548         -937 (-8.16%)         848         762       -86 (-10.14%)
bpf.bpf.o          layered_dump                 7422    1000001  +992579 (+13373.47%)         681       31178  +30497 (+4478.27%)
bpf.bpf.o          layered_enqueue             16854      71127     +54273 (+322.02%)        1611        6450    +4839 (+300.37%)
bpf.bpf.o          p2dq_dispatch                 665        791        +126 (+18.95%)          68          78       +10 (+14.71%)
bpf.bpf.o          p2dq_init                    2343       2980        +637 (+27.19%)         201         237       +36 (+17.91%)
bpf.bpf.o          refresh_layer_cpumasks      16487     674760   +658273 (+3992.68%)        1770       65370  +63600 (+3593.22%)
bpf.bpf.o          rusty_select_cpu             1937      40872    +38935 (+2010.07%)         177        3210   +3033 (+1713.56%)
scx_central.bpf.o  central_dispatch              636       2687      +2051 (+322.48%)          63         227     +164 (+260.32%)
scx_nest.bpf.o     nest_init                     636        815        +179 (+28.14%)          60          73       +13 (+21.67%)
scx_qmap.bpf.o     qmap_dispatch                2393       3580       +1187 (+49.60%)         196         253       +57 (+29.08%)
scx_qmap.bpf.o     qmap_dump                     233        318         +85 (+36.48%)          22          30        +8 (+36.36%)
scx_qmap.bpf.o     qmap_init                   16367      17436        +1069 (+6.53%)         603         669       +66 (+10.95%)

Note 'layered_dump' program, which now hits 1M instructions limit.
This impact would be mitigated in the next patch.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 04d1d75d9ff9..01b31b718f4f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1659,6 +1659,7 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 	dst_state->callback_unroll_depth = src->callback_unroll_depth;
 	dst_state->used_as_loop_entry = src->used_as_loop_entry;
 	dst_state->may_goto_depth = src->may_goto_depth;
+	dst_state->loop_entry = src->loop_entry;
 	for (i = 0; i <= src->curframe; i++) {
 		dst = dst_state->frame[i];
 		if (!dst) {
@@ -19243,6 +19244,8 @@ static int do_check(struct bpf_verifier_env *env)
 						return err;
 					break;
 				} else {
+					if (WARN_ON_ONCE(env->cur_state->loop_entry))
+						env->cur_state->loop_entry = NULL;
 					do_print_state = true;
 					continue;
 				}
-- 
2.48.1


