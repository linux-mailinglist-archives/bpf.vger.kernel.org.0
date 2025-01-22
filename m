Return-Path: <bpf+bounces-49473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7D6A1911B
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 13:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2F82165A86
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 12:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946CA212B2E;
	Wed, 22 Jan 2025 12:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WY6y5Azy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6075212B14
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 12:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737547506; cv=none; b=NdxA/VcR9rypS/jZok8odwjio769cjPrXzCdCxik6TrdrJX5UlHxeQLb9KYKQDqaQtYu3TFm/ZPEdwziN0kKG61L/FQ2mw15saWs2v3kP5CM4vL1SOCMCR1i4JMGRAfWvDSlPJRF0Sm1oerkZHQD3hwD3ypnDU8l6ut/ikhnF0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737547506; c=relaxed/simple;
	bh=cYYfh13zoiuouqQ3GjfIjGgTjjIH5PgBdU03m4vsMHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JRHMnoaPahAAcNjRlCHxGRBKWY1CrVBFjevgTrbvDHFtjWRzjYrEdW4VbWWQ0oqCKILcr2AIuFQAElzMr/xU/+cPcDCBomp3kwfabVAOmChWpJTUZTyEYgF51PBvTOycEqkdJoM/daKVZoIpYzxqipvmt53WMtE73bu0eittbxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WY6y5Azy; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ef87d24c2dso8932407a91.1
        for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 04:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737547503; x=1738152303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jr6Xk5Yu/6fmW4G5zgRffPcow/7eTHW8sKlPQZSp8VU=;
        b=WY6y5Azy5oDfv4eFlCyHK9cvbpHLfh2Bgp3LiUYtwhKOQnRJWBVYMHFnGSJ4k5Z/9L
         ASCYOC6XbwjWd4RslXp7uFU2h88SHXuEruRWfQt0+oj5dicLWp//yWp8CeHsoRDpDfSY
         gVesKEJk98B++Xyrczdqni92sbFo0975mcJpuTDCcw+F9Komo23DXkdr6N3UtRbYyXhA
         TLnNbDud8zYi73c8owgViBPAwCKBD4D5o2f/YOoRSVQN02+Cq2sByyvr5W9cUvlZsgWF
         YsXiNNSfOG/8+UmX2dn5RQX9qq8wsjJup+3rv/gd1UkwGG88O6ZB2upu9/ER46ILdjEz
         Iq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737547503; x=1738152303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jr6Xk5Yu/6fmW4G5zgRffPcow/7eTHW8sKlPQZSp8VU=;
        b=NpW0X9tE4MWcYHngIgCMlUfLDeZbqhSnI8JaWtydQZYC+WoaxoaE++uZ4hKtrdJ1OC
         CQ2amOqYmyYRc3ONCtbfEIi4QewkJaat4o4JTmIdHBlmb5KQEP5tn/DEtLKVHdV20GcL
         A0OSsikqIMoZzdZ8uWB39E11zmoOHK5RuoMuJlRczbqxjsgme7iK79qgL08WdlNqvjyv
         DTHbBYAFApegWwuu8V+zBNxH7wEakegDME04E7Uu8t1EERYdrQ/t96JaB3sDB51QGDqs
         5jEdSi5vUI3jSprIq8oiVcK0q3mT1uOP6HkfNFHpVRYTm04DyZNLGKFBimewsW1zWqFX
         4R/w==
X-Gm-Message-State: AOJu0YyIDw84nFeyhyyPMUFYFFw9H2Wn3Z9XKha5RDrXCiGIKlbInbch
	CjbfXm8OpcN5JlGovM31uVEQ+T9FDq+/x2usAfRtfQbPcOuPzi9b6z4Ogw==
X-Gm-Gg: ASbGnctmjVqAXGnEmSPbZzh8fu8GRm0wNX0waoWBvHwf0PnTFcovfelqKrHsY+gYPs2
	ljLtm78o+81qS04IT9pSQPXBdqAos/aMqr9URoDQzueDy2FjXCRYShBJY2iQQhFQmM6k36phe8H
	FoffwIfD8pNymPb1thdws+fTkY/8wHqEniRZTqSVDdBhYuyR6M8m0KecZn74T5OFA8gtaLCPVYW
	fAqwopeDV/MtHFxT31T+D6wTr3B2Wp6TBz6dWj0kLcfh3AhK7frFhOjWImEpCXaIA==
X-Google-Smtp-Source: AGHT+IHWZ6/8YpDT8Blilce0frjQyVCM+SdsIYzih/z2p2hb7g5y4XaTaj8r1mr5HziXdKgociZk5g==
X-Received: by 2002:a05:6a00:428d:b0:725:ae5f:7f06 with SMTP id d2e1a72fcca58-72dafadbc37mr29955546b3a.23.1737547503450;
        Wed, 22 Jan 2025 04:05:03 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab816412sm11055732b3a.66.2025.01.22.04.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 04:05:03 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next v1 3/7] bpf: don't do clean_live_states when state->loop_entry->branches > 0
Date: Wed, 22 Jan 2025 04:04:38 -0800
Message-ID: <20250122120442.3536298-4-eddyz87@gmail.com>
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

File                  Program                       Insns      (DIFF)  States    (DIFF)
--------------------  ----------------------------  -----------------  ----------------
arena_htab.bpf.o      arena_htab_llvm                  -294 (-41.00%)     -20 (-35.09%)
arena_htab_asm.bpf.o  arena_htab_asm                   -152 (-25.46%)     -10 (-21.28%)
arena_list.bpf.o      arena_list_add                   +329 (+22.04%)      +7 (+23.33%)
arena_list.bpf.o      arena_list_del                    -51 (-16.50%)      -8 (-34.78%)
iters.bpf.o           checkpoint_states_deletion      -8297 (-45.78%)    -451 (-55.13%)
iters.bpf.o           clean_live_states             -998653 (-99.87%)  -90126 (-99.85%)
iters.bpf.o           iter_nested_deeply_iters         -226 (-38.11%)     -24 (-35.82%)
iters.bpf.o           iter_subprog_check_stacksafe      -20 (-12.90%)       -1 (-6.67%)
iters.bpf.o           iter_subprog_iters               -286 (-26.14%)     -20 (-22.73%)
iters.bpf.o           loop_state_deps2                 -123 (-25.68%)     -11 (-23.91%)
iters.bpf.o           triple_continue                    -4 (-11.43%)       +0 (+0.00%)
mptcp_subflow.bpf.o   _getsockopt_subflow               -55 (-10.98%)       -2 (-8.00%)
pyperf600_iter.bpf.o  on_event                        -6025 (-48.83%)    -160 (-36.28%)

(arena_list_add requires further investigation)

sched_ext:

Program                 Insns      (DIFF)  States    (DIFF)
----------------------  -----------------  ----------------
layered_dispatch          -3570 (-31.08%)    -227 (-26.77%)
layered_dump              -2746 (-37.00%)    -411 (-60.35%)
layered_enqueue           -3781 (-28.93%)    -341 (-28.95%)
layered_init            -994488 (-99.45%)  -84153 (-99.39%)
layered_runnable          -1467 (-45.59%)    -160 (-54.24%)
refresh_layer_cpumasks   -15202 (-92.21%)   -1650 (-93.22%)
rusty_select_cpu           -647 (-30.84%)     -53 (-29.28%)
rusty_set_cpumask        -15934 (-78.67%)   -1359 (-81.62%)
central_init               -330 (-36.18%)     -10 (-20.83%)
pair_dispatch           -998092 (-99.81%)  -58249 (-99.76%)

'layered_init' and 'pair_dispatch' hit 1M on master, but are verified
ok with this patch.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c7ceb59d3a19..1c2199a3f38f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17801,12 +17801,16 @@ static void clean_verifier_state(struct bpf_verifier_env *env,
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
2.47.1


