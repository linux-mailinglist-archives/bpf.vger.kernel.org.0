Return-Path: <bpf+bounces-1448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB21716AE8
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 19:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881E0281201
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 17:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB322099E;
	Tue, 30 May 2023 17:28:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024861F179
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 17:28:23 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C802134
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 10:27:55 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f4f89f71b8so3368258e87.3
        for <bpf@vger.kernel.org>; Tue, 30 May 2023 10:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685467673; x=1688059673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIFS8y5rj4rAdX41RUqJOAHDsWXXHlpZYgu8Gc4afiY=;
        b=QoQup8S4CZS+qta+78zwlZRX0DRCwpo6BP0lcMHXNGgRYBDtvsmf4slErmoXyVYhDg
         xhhhEF1ggvAXaeJmTDSgOwGuMhNcS967rOHxNQX1YUw7C8p6J4LFOYm7FHKH+V4NEsdh
         lk7qvNf6atWFR3Y9iUpDUV0BOQzp0HuHUxC5TgV7VIyxNowiiqyVyFwpydpHF5GPoTTR
         Y14zvJmloFEIjqmcuA7mP7MWfZg/EBMuO4vJ7GyAR7eTCKVu4qg314m3Vf+2aoFixKzi
         pg8dRCiS+jGGKvCfi0Pd7/3m8pcrrMP/UqpgkycpjWb8Ip197p02Qtoa3IzeJtPH76nI
         2/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685467673; x=1688059673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VIFS8y5rj4rAdX41RUqJOAHDsWXXHlpZYgu8Gc4afiY=;
        b=l1Y3voIkeUFfUEyPnpYE7kdv5OXV+R0NXX7relZP6UL5vPzx8r8WAbx+cfTdXKscdw
         TewXHEmktZXnaS4OmgBuQEKpxAY84MUhOe5sS10F1Cptb9d8f2r38tYXmfWwHBTDh49Q
         FmLyVLdJG0BFOmvdqm3R78YeK1Ej8ccNRtiFHunV4ZCC0AcXDgk3o1LiZ88g3ZG+27Sy
         0dFLmLqNouRDAaoiNR9w+Iw23flWyFFlIndhbZVNhi06EWbEbtMrQh1flC1vqY29BVbT
         6hZonyA2pixYlOTMomf0VPY25waisCkuFKOc411qJzB8MWszBz5Fn3GXXLeI1mIK0vJd
         uIdA==
X-Gm-Message-State: AC+VfDzNHEKWA6exFfWwBZVc9fh/DJBDUbyu97qtvbSZxmkoI3bK1c1c
	1cNCAlTujOAZ4Ts0UUpbeo2ODrJXcLKD0Q==
X-Google-Smtp-Source: ACHHUZ6oh7K8YEioeyGlYbtNEr79HC6Eg51+VXUgHNII9yFLX4NO24UQPJfzuxIXKnKiS4fxwzmnyQ==
X-Received: by 2002:a19:740f:0:b0:4f1:444e:6c5a with SMTP id v15-20020a19740f000000b004f1444e6c5amr1268084lfe.8.1685467673452;
        Tue, 30 May 2023 10:27:53 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id a1-20020a056512020100b004f262997496sm405985lfo.76.2023.05.30.10.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 10:27:53 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yhs@fb.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 1/4] bpf: verify scalar ids mapping in regsafe() using check_ids()
Date: Tue, 30 May 2023 20:27:36 +0300
Message-Id: <20230530172739.447290-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530172739.447290-1-eddyz87@gmail.com>
References: <20230530172739.447290-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Make sure that the following unsafe example is rejected by verifier:

1: r9 = ... some pointer with range X ...
2: r6 = ... unbound scalar ID=a ...
3: r7 = ... unbound scalar ID=b ...
4: if (r6 > r7) goto +1
5: r6 = r7
6: if (r6 > X) goto ...
--- checkpoint ---
7: r9 += r7
8: *(u64 *)r9 = Y

This example is unsafe because not all execution paths verify r7 range.
Because of the jump at (4) the verifier would arrive at (6) in two states:
I.  r6{.id=b}, r7{.id=b} via path 1-6;
II. r6{.id=a}, r7{.id=b} via path 1-4, 6.

Currently regsafe() does not call check_ids() for scalar registers,
thus from POV of regsafe() states (I) and (II) are identical. If the
path 1-6 is taken by verifier first, and checkpoint is created at (6)
the path [1-4, 6] would be considered safe.

This commit updates regsafe() to call check_ids() for scalar registers.

This change is costly in terms of verification performance.
Using veristat to compare number of processed states for selftests
object files listed in tools/testing/selftests/bpf/veristat.cfg and
Cilium object files from [1] gives the following statistics:

  Filter        | Number of programs
  ----------------------------------
  states_pct>10 | 40
  states_pct>20 | 20
  states_pct>30 | 15
  states_pct>40 | 11

(Out of total 177 programs)

In fact, impact is so bad that in no-alu32 mode the following
test_progs tests no longer pass verifiction:
- verif_scale2: maximal number of instructions exceeded
- verif_scale3: maximal number of instructions exceeded
- verif_scale_pyperf600: maximal number of instructions exceeded

Additionally:
- verifier_search_pruning/allocated_stack: expected prunning does not
  happen because of differences in register id allocation.

Followup patch would address these issues.

[1] git@github.com:anakryiko/cilium.git

Fixes: 75748837b7e5 ("bpf: Propagate scalar ranges through register assignments.")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index af70dad655ab..9c10f2619c4f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15151,6 +15151,28 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 
 	switch (base_type(rold->type)) {
 	case SCALAR_VALUE:
+		/* Why check_ids() for scalar registers?
+		 *
+		 * Consider the following BPF code:
+		 *   1: r6 = ... unbound scalar, ID=a ...
+		 *   2: r7 = ... unbound scalar, ID=b ...
+		 *   3: if (r6 > r7) goto +1
+		 *   4: r6 = r7
+		 *   5: if (r6 > X) goto ...
+		 *   6: ... memory operation using r7 ...
+		 *
+		 * First verification path is [1-6]:
+		 * - at (4) same bpf_reg_state::id (b) would be assigned to r6 and r7;
+		 * - at (5) r6 would be marked <= X, find_equal_scalars() would also mark
+		 *   r7 <= X, because r6 and r7 share same id.
+		 *
+		 * Next verification path would start from (5), because of the jump at (3).
+		 * The only state difference between first and second visits of (5) is
+		 * bpf_reg_state::id assignments for r6 and r7: (b, b) vs (a, b).
+		 * Thus, use check_ids() to distinguish these states.
+		 */
+		if (!check_ids(rold->id, rcur->id, idmap))
+			return false;
 		if (regs_exact(rold, rcur, idmap))
 			return true;
 		if (env->explore_alu_limits)
-- 
2.40.1


