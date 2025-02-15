Return-Path: <bpf+bounces-51650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4677A36D8F
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 12:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112883B196F
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 11:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E5C1A8401;
	Sat, 15 Feb 2025 11:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRseqG09"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE80A567D
	for <bpf@vger.kernel.org>; Sat, 15 Feb 2025 11:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739617474; cv=none; b=VCcVPRjABOJHgyKTNXFCV+5/Jp1Z9638JfqEhswtej38crzRrJE06Cudu/b90qqIcsz3cxD6ZpaFZVDdFIUei/FmVjnmjeBHCRkS5NJvgIvPX4wBHWYDE+f9QDAMSm87XGW+riJ1r004KzBSR0ExrXuBYnh/nau/CUtzZ9GLnXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739617474; c=relaxed/simple;
	bh=3tF1Xq37jo54OXD9rvanfjQVKZSCBCxDR1nXCrusP28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPTCP0zI0uq4lQfvgwUP1zXLYIzOowxMuXRtfUemiXq6n3lE+Tq8KdS6NJEk6TBja2pLezSRQADZeNyLAQGy5tuzWPUGPpzh7wwKCBJ3BwuP5fij5SL6dtL98ymy7kZYsI9oyXePNxnth4q13MFQlVcla6TakG8CDUD4rDKBeQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRseqG09; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-220c8cf98bbso57950955ad.1
        for <bpf@vger.kernel.org>; Sat, 15 Feb 2025 03:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739617472; x=1740222272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDb/gdeQU/PSQ/UUil4dmXW1Hd6+EUYI3l5WuidH/TU=;
        b=SRseqG09ekVMaJIn4//REmZXdeQSTHKqpNmqU7bfHG2AZ+zN6Fg1o67klKXG91f0wR
         2NAWmJbZFB9L6Ey5+txnD5mgI5lyoSofYQQsoFAkbyaSwq8spCFY7zdjgWLyMDCHykX4
         kavoUugoPI375LLRy6YOcQU5CnYjVe1CAbiU3IxZpN4FTJnPpvKAlbKBYmL9o/4smzTk
         hEDCD3UCV8F7cKuF8SRK2Q4GB92GP2iL3CLvfJs/2AxqoRp2hi5ReEUZfPKZgMp9BfyF
         aQ4aeplrCYBHhNsF9FjIE+QRMcuXuYiS/EdKdtcworaOV7gupDHR5HaWXkUYCCeGDyVT
         mnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739617472; x=1740222272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDb/gdeQU/PSQ/UUil4dmXW1Hd6+EUYI3l5WuidH/TU=;
        b=ltnh2jiek7coPJB5CjrsWwGO+lBwJuwDhsQLwpNew0MzmtotK2saoQWhRhtzv2zIMt
         tx+o2wul9/kYvR5v0l5MwMiibBorR2IX3gWSDXFg/3lZLopLYg07VaL5470XcfSflcqj
         CAzRdp6nwJ6FGxL8kYHcDpxHw8fgWWIVgBZpR/SPHRd/2z4AAyfXp0ZIDJnsYs/KEuir
         5pgb4PKnX50WL7UMiVjLe9Ped/mfgm+ysMZacWci5uslfxzobKSTM8No5kvKnHdhRHVr
         bbkKmd0pz8ri+rDZd5xRXiJPcVdxL0wPpemTHLoh719CK3umxajPRvc+LFU9X0zH6WLr
         KhBQ==
X-Gm-Message-State: AOJu0YyI3TWF7uFtxu1fDZFve+zUUHCwVs9OKuca3cuhnoTmCQ5H8Z1R
	y61mtLoGusGKukSqrMkAZ+ZHLjv7kPf6vt2YfE+fkmIyhgc+ay/a6IVgiQ==
X-Gm-Gg: ASbGncsy/K9QsfH3KEtdv6HzQCA/auNZEf+wPZgPAC2CVUZBoVsNMCcfBfVp2mmMyZl
	mLrLwob+wJTQ63x/u2Id6Pyx9aqOEdN16RHhytTxqjINCtXwbGOYPzojkSNwMlUj0LzhqS/W6pO
	qEDqULEbJL8YpjncMD2xAqsJdZ1IZ+ql9avih/hCYxyQGE66kKkOEt0xCWB0YDdQGPGvYos03kX
	Ul4IpE/Sv2MWYaBRF8VXIJRHZ73YqCxZ5AkE//09oSIHFwgnqrP/RyEHGnWZ3VNBlzHO2xL/1cw
	f8SPBc7OIok=
X-Google-Smtp-Source: AGHT+IFSlaD0AncONg+3xUUfqvzoMkINFPuEdpgyn0zfVa2FRV5BktRnHMmRq20kQ7yBhe6mdTimcA==
X-Received: by 2002:a05:6a20:3948:b0:1ee:64c4:89b9 with SMTP id adf61e73a8af0-1ee8cbe8197mr4010369637.33.1739617471655;
        Sat, 15 Feb 2025 03:04:31 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7326d58d4d0sm72435b3a.94.2025.02.15.03.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 03:04:30 -0800 (PST)
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
Subject: [PATCH bpf-next v1 03/10] bpf: don't do clean_live_states when state->loop_entry->branches > 0
Date: Sat, 15 Feb 2025 03:03:54 -0800
Message-ID: <20250215110411.3236773-4-eddyz87@gmail.com>
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

verifier.c:is_state_visited() uses RANGE_WITHIN states comparison rules
for cached states that have loop_entry with non-zero branches count
(meaning that loop_entry's verification is not yet done).

The RANGE_WITHIN rules in regsafe()/stacksafe() require register and
stack objects types to be identical in current and old states.

verifier.c:clean_live_states() replaces registers and stack spills
with NOT_INIT/STACK_INVALID marks, if these registers/stack spills are
not read in any child state. This means that clean_live_states() works
against loop convergence logic under some conditions. See selftest in
the next patch for a specific example.

Mitigate this by prohibiting clean_verifier_state() when
state->loop_entry->branches > 0.

This undoes negative verification performance impact of the
copy_verifier_state() fix from the previous patch.
Below is comparison between master and current patch.

selftests:

File                                Program                       Insns (A)  Insns (B)  Insns    (DIFF)  States (A)  States (B)  States  (DIFF)
----------------------------------  ----------------------------  ---------  ---------  ---------------  ----------  ----------  --------------
arena_htab.bpf.o                    arena_htab_llvm                     717        423   -294 (-41.00%)          57          37   -20 (-35.09%)
arena_htab_asm.bpf.o                arena_htab_asm                      597        445   -152 (-25.46%)          47          37   -10 (-21.28%)
arena_list.bpf.o                    arena_list_add                     1493       1822   +329 (+22.04%)          30          37    +7 (+23.33%)
arena_list.bpf.o                    arena_list_del                      309        261    -48 (-15.53%)          23          15    -8 (-34.78%)
iters.bpf.o                         checkpoint_states_deletion        18125      22154  +4029 (+22.23%)         818         918  +100 (+12.22%)
iters.bpf.o                         iter_nested_deeply_iters            593        367   -226 (-38.11%)          67          43   -24 (-35.82%)
iters.bpf.o                         iter_nested_iters                   813        772     -41 (-5.04%)          79          72     -7 (-8.86%)
iters.bpf.o                         iter_subprog_check_stacksafe        155        135    -20 (-12.90%)          15          14     -1 (-6.67%)
iters.bpf.o                         iter_subprog_iters                 1094        808   -286 (-26.14%)          88          68   -20 (-22.73%)
iters.bpf.o                         loop_state_deps2                    479        356   -123 (-25.68%)          46          35   -11 (-23.91%)
iters.bpf.o                         triple_continue                      35         31     -4 (-11.43%)           3           3     +0 (+0.00%)
kmem_cache_iter.bpf.o               open_coded_iter                      63         59      -4 (-6.35%)           7           6    -1 (-14.29%)
mptcp_subflow.bpf.o                 _getsockopt_subflow                 501        446    -55 (-10.98%)          25          23     -2 (-8.00%)
pyperf600_iter.bpf.o                on_event                          12339       6379  -5960 (-48.30%)         441         286  -155 (-35.15%)
verifier_bits_iter.bpf.o            max_words                            92         84      -8 (-8.70%)           8           7    -1 (-12.50%)
verifier_iterating_callbacks.bpf.o  cond_break2                         113        192    +79 (+69.91%)          12          21    +9 (+75.00%)

sched_ext:

File               Program                 Insns (A)  Insns (B)  Insns      (DIFF)  States (A)  States (B)  States    (DIFF)
-----------------  ----------------------  ---------  ---------  -----------------  ----------  ----------  ----------------
bpf.bpf.o          layered_dispatch            11485       9039    -2446 (-21.30%)         848         662    -186 (-21.93%)
bpf.bpf.o          layered_dump                 7422       5022    -2400 (-32.34%)         681         298    -383 (-56.24%)
bpf.bpf.o          layered_enqueue             16854      13753    -3101 (-18.40%)        1611        1308    -303 (-18.81%)
bpf.bpf.o          layered_init              1000001       5549  -994452 (-99.45%)       84672         523  -84149 (-99.38%)
bpf.bpf.o          layered_runnable             3149       1899    -1250 (-39.70%)         288         151    -137 (-47.57%)
bpf.bpf.o          p2dq_init                    2343       1936     -407 (-17.37%)         201         170     -31 (-15.42%)
bpf.bpf.o          refresh_layer_cpumasks      16487       1285   -15202 (-92.21%)        1770         120   -1650 (-93.22%)
bpf.bpf.o          rusty_select_cpu             1937       1386     -551 (-28.45%)         177         125     -52 (-29.38%)
scx_central.bpf.o  central_dispatch              636        600       -36 (-5.66%)          63          59       -4 (-6.35%)
scx_central.bpf.o  central_init                  913        632     -281 (-30.78%)          48          39      -9 (-18.75%)
scx_nest.bpf.o     nest_init                     636        601       -35 (-5.50%)          60          58       -2 (-3.33%)
scx_pair.bpf.o     pair_dispatch             1000001       1914  -998087 (-99.81%)       58169         142  -58027 (-99.76%)
scx_qmap.bpf.o     qmap_dispatch                2393       2187      -206 (-8.61%)         196         174     -22 (-11.22%)
scx_qmap.bpf.o     qmap_init                   16367      22777    +6410 (+39.16%)         603         768    +165 (+27.36%)

'layered_init' and 'pair_dispatch' hit 1M on master, but are verified
ok with this patch.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 01b31b718f4f..945a13b2cfeb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17814,12 +17814,16 @@ static void clean_verifier_state(struct bpf_verifier_env *env,
 static void clean_live_states(struct bpf_verifier_env *env, int insn,
 			      struct bpf_verifier_state *cur)
 {
+	struct bpf_verifier_state *loop_entry;
 	struct bpf_verifier_state_list *sl;
 
 	sl = *explored_state(env, insn);
 	while (sl) {
 		if (sl->state.branches)
 			goto next;
+		loop_entry = get_loop_entry(&sl->state);
+		if (loop_entry && loop_entry->branches)
+			goto next;
 		if (sl->state.insn_idx != insn ||
 		    !same_callsites(&sl->state, cur))
 			goto next;
-- 
2.48.1


