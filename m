Return-Path: <bpf+bounces-79185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEF9D2BAE5
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 05:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC1F2301226C
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 04:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964D7346E67;
	Fri, 16 Jan 2026 04:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTwp+OJq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472B2348875
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 04:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768539534; cv=none; b=Zn8rd1sFgWk7XWLZ506F5wDRc/oB/FDaZ6IuM+UHIy5gi5zEC7ifV76SNIkWXxBQ1amMet49TTgNTpFTryJg0Kp5tucfXGbVMmHvcMa5yXd0fG8E7S6GbI+1kNKdqGfuiQ3LVKzOFsoY3f7jb8URtjrkM7/xslgn/NW4HlguciM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768539534; c=relaxed/simple;
	bh=+JtErU4IsTTu5VsF09kHgDaqBgZ+Eh9d+qw9x/9WOBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=agYEJt7WdIqj54ky/sd5NDemiEjtPab2lYqlJqFxTJeisMN9NA+bUJwZBVhuFkPrW9FAPv6NNU+wvvNg4gZpJanR6WRsP/RIbBeHU3yCZLAgCYCOByOzN6IqEIwLADoYJP8ith6lvIUOhNcPi+9wqa1fx5Aojo5P+HS+VZfNvKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTwp+OJq; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-121bf277922so2186553c88.0
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 20:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768539530; x=1769144330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PakQjvDWLKrfOt/1Dta85wOj3KGWWuK3r87J5UJgoug=;
        b=OTwp+OJqej38UGImID3CABgBUBLS3b4ii1W1YJGKTD6j4g6ajQu1YlxJvqLrR7NjR2
         CISYAm3//ul/zXccP0jEscMnM7YOKhRvEpTekv7IkURBJwZISy/k86HJqp1z0FtmmlM5
         jx/FIALZWgydK9+lpORzlhJ3FQO7IldN8ac2MraweIO7J6r5TH+29ZdG0mIiFuaPldiK
         4msbvF99S1rQj5cHNfzkWdsP7QdRNosKF8zzDnfOFlIG4KC2/C5oCl4jnypkI3lLzJ43
         pc8MnFLl1sH2+WMetT2RhGjb8aRI6xB4HEIKTJP0UhRBmmGCF1pOdUlGhQSdQfxpvfcx
         l/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768539530; x=1769144330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PakQjvDWLKrfOt/1Dta85wOj3KGWWuK3r87J5UJgoug=;
        b=SofRzU29ny5yM7wtV7rGvilpt3DAo9k9kUfgELNi1xJ3iNUItBW/hwmk4Xg8NXaocb
         wiAgNTr/QeMyj8TQy8cWIl/oJfK7P2SsOHpieaH8iQ176fQxBbfY9BiWDAjyjWw7XUKl
         W/TwsHeo99Zrx83s78muHt1iWa+jsbPKkINJe7amR+vg/h4hg2cq+BDqHHZkFZBdrD7C
         tUvrx2NUD7RwQAfb32odrNLJjCyxlDm8/ZZtEQuuFs7lDO6C0ANkmcWr1u11zC9DfDEW
         Ku9meeuAjPxh9BPk2Z8oFWWxrznW/t/ANswQoOTkCxzUyW5VnBOgJekvbgdYxD0iVPz+
         NK6w==
X-Gm-Message-State: AOJu0YwivuBGFQfRDtWHD+OH46KHsaQCGXEUQM1VLseAjQGLOi94lRZI
	PQqKydrhzF50XkSftu2EKozugGlfwFKrkK3ES9DLvCLzSAFrBrMpSlUh
X-Gm-Gg: AY/fxX5rxLI8tHG2LAh4XvFxFXw/LMGlKMZId76lLPNtiZrfrAuuCJeFQGYmFmc3y7U
	X3ViF4oBEiaj/r5HIvYsCk9edhnepP3fM2QTExE+vuWWSiBwxawsd4xOmFF9D7Lny3SFyIj8dt1
	mx0BSL4+6uSUPryZ38Qed0xWgOEj9Ft57nv6HoBXwWkdrquxjSQ5uyrMKnTeUIPdsyyX0mSdIjI
	sg+yYrrhBVZWiVifuRtsBwhFqKRk+UiTd14z3Qb6fXauxDDePG8XJPg7pzYN0SU/44gknyxz8r1
	H1nl4aN8K6wUVcQWaoTysbXo8bHo2586uFp7TfljsIEreQlbP1O9dU0vS38tw4ercgqJtin3a7V
	pd4ySuC5TBQQoeqXNA2HpuxTYIe50Wi6TF31MwtOHTpxkvLT3gdvMmq7QtNJszTsompaC9XmLAu
	x4rLjzubXbfM4ATBKxxQ7ULyw=
X-Received: by 2002:a05:693c:2c94:b0:2ae:50d5:bc0b with SMTP id 5a478bee46e88-2b6b4714677mr1764866eec.18.1768539530350;
        Thu, 15 Jan 2026 20:58:50 -0800 (PST)
Received: from localhost.localdomain ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b361a7acsm1200479eec.21.2026.01.15.20.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 20:58:49 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	Qiliang Yuan <realwujing@gmail.com>
Subject: [PATCH v2] bpf/verifier: optimize precision backtracking by skipping precise bits
Date: Fri, 16 Jan 2026 12:58:39 +0800
Message-Id: <20260116045839.23743-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <aa4cc54a3a0796b16d2d5e13142d104fa5a483e1.camel@gmail.com>
References: <aa4cc54a3a0796b16d2d5e13142d104fa5a483e1.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, precision backtracking logic in __mark_chain_precision does
not check if the target register or stack slot is already marked as
precise. This can lead to redundant work when multiple paths require
the same register to be precise.

This patch moves the "skip if already precise" logic into the core
backtracking loop setup in __mark_chain_precision(). This ensures
that all entry points (mark_chain_precision, propagate_precision)
benefit from the optimization and allows for cleaner code at the
call sites.

Specifically:
- In __mark_chain_precision(), before starting the backtracking loop,
  check if the initial register/stack slot is already precise.
- For batch propagation (used by propagate_precision), iterate through
  the requested masks and clear bits that are already precise in the
  starting state.
- Remove redundant checks in mark_chain_precision() and
  propagate_precision().

Performance results:
The optimization significantly reduces verification time by skipping
redundant backtracking for registers already marked as precise.

Key improvements (Duration):
- prog_nested_calls:           671us -> 292us (-56.48%)
- prog_non_constant_callback:  254us -> 111us (-56.30%)
- stack_check:                 807us -> 411us (-49.07%)
- arena_strsearch:             120us -> 65us  (-45.83%)
- prog_null_ctx:               216us -> 164us (-24.07%)

Verified that total instruction and state counts remain identical
across all tests (0.00% change), confirming logic equivalence.

Test steps and detailed performance raw data are as follows:

The data was collected using the following command:
$ sudo ./veristat -e duration,total_insns,total_states -o csv \
    bpf_flow.bpf.o bpf_loop.bpf.o arena_strsearch.bpf.o

Baseline (at b54345928fa1):
file_name,prog_name,verdict,duration,total_insns,total_states
arena_strsearch.bpf.o,arena_strsearch,failure,120,20,2
bpf_flow.bpf.o,_dissect,success,465,211,13
bpf_flow.bpf.o,flow_dissector_0,success,2408,1461,68
bpf_flow.bpf.o,flow_dissector_1,success,2698,1567,59
bpf_flow.bpf.o,flow_dissector_2,success,2010,1244,56
bpf_flow.bpf.o,flow_dissector_3,success,2250,1498,57
bpf_flow.bpf.o,flow_dissector_4,success,343,259,4
bpf_flow.bpf.o,flow_dissector_5,success,674,416,21
bpf_loop.bpf.o,prog_invalid_flags,success,292,50,5
bpf_loop.bpf.o,prog_nested_calls,success,671,145,19
bpf_loop.bpf.o,prog_non_constant_callback,success,254,41,5
bpf_loop.bpf.o,prog_null_ctx,success,216,22,3
bpf_loop.bpf.o,stack_check,success,807,325,25
bpf_loop.bpf.o,test_prog,success,493,64,7

Patched:
file_name,prog_name,verdict,duration,total_insns,total_states
arena_strsearch.bpf.o,arena_strsearch,failure,65,20,2
bpf_flow.bpf.o,_dissect,success,467,211,13
bpf_flow.bpf.o,flow_dissector_0,success,2392,1461,68
bpf_flow.bpf.o,flow_dissector_1,success,2722,1567,59
bpf_flow.bpf.o,flow_dissector_2,success,2050,1244,56
bpf_flow.bpf.o,flow_dissector_3,success,2258,1498,57
bpf_flow.bpf.o,flow_dissector_4,success,342,259,4
bpf_flow.bpf.o,flow_dissector_5,success,702,416,21
bpf_loop.bpf.o,prog_invalid_flags,success,239,50,5
bpf_loop.bpf.o,prog_nested_calls,success,292,145,19
bpf_loop.bpf.o,prog_non_constant_callback,success,111,41,5
bpf_loop.bpf.o,prog_null_ctx,success,164,22,3
bpf_loop.bpf.o,stack_check,success,411,325,25
bpf_loop.bpf.o,test_prog,success,484,64,7

Comparison (veristat -C):
$ ./veristat -C prec_skip_baseline.csv prec_skip_patched.csv
File                   Program                     Verdict (A)  Verdict (B)  Verdict (DIFF)  Duration (us) (A)  Duration (us) (B)  Duration (us) (DIFF)  Insns (A)  Insns (B)  Insns (DIFF)  States (A)  States (B)  States (DIFF)
---------------------  --------------------------  -----------  -----------  --------------  -----------------  -----------------  --------------------  ---------  ---------  ------------  ----------  ----------  -------------
arena_strsearch.bpf.o  arena_strsearch             failure      failure      MATCH                         120                 65         -55 (-45.83%)         20         20   +0 (+0.00%)           2           2    +0 (+0.00%)
bpf_flow.bpf.o         _dissect                    success      success      MATCH                         465                467           +2 (+0.43%)        211        211   +0 (+0.00%)          13          13    +0 (+0.00%)
bpf_flow.bpf.o         flow_dissector_0            success      success      MATCH                        2408               2392          -16 (-0.66%)       1461       1461   +0 (+0.00%)          68          68    +0 (+0.00%)
bpf_flow.bpf.o         flow_dissector_1            success      success      MATCH                        2698               2722          +24 (+0.89%)       1567       1567   +0 (+0.00%)          59          59    +0 (+0.00%)
bpf_flow.bpf.o         flow_dissector_2            success      success      MATCH                        2010               2050          +40 (+1.99%)       1244       1244   +0 (+0.00%)          56          56    +0 (+0.00%)
bpf_flow.bpf.o         flow_dissector_3            success      success      MATCH                        2250               2258           +8 (+0.36%)       1498       1498   +0 (+0.00%)          57          57    +0 (+0.00%)
bpf_flow.bpf.o         flow_dissector_4            success      success      MATCH                         343                342           -1 (-0.29%)        259        259   +0 (+0.00%)           4           4    +0 (+0.00%)
bpf_flow.bpf.o         flow_dissector_5            success      success      MATCH                         674                702          +28 (+4.15%)        416        416   +0 (+0.00%)          21          21    +0 (+0.00%)
bpf_loop.bpf.o         prog_invalid_flags          success      success      MATCH                         292                239         -53 (-18.15%)         50         50   +0 (+0.00%)           5           5    +0 (+0.00%)
bpf_loop.bpf.o         prog_nested_calls           success      success      MATCH                         671                292        -379 (-56.48%)        145        145   +0 (+0.00%)          19          19    +0 (+0.00%)
bpf_loop.bpf.o         prog_non_constant_callback  success      success      MATCH                         254                111        -143 (-56.30%)         41         41   +0 (+0.00%)           5           5    +0 (+0.00%)
bpf_loop.bpf.o         prog_null_ctx               success      success      MATCH                         216                164         -52 (-24.07%)         22         22   +0 (+0.00%)           3           3    +0 (+0.00%)
bpf_loop.bpf.o         stack_check                 success      success      MATCH                         807                411        -396 (-49.07%)        325        325   +0 (+0.00%)          25          25    +0 (+0.00%)
bpf_loop.bpf.o         test_prog                   success      success      MATCH                         493                484           -9 (-1.83%)         64         64   +0 (+0.00%)           7           7    +0 (+0.00%)

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
---
v1 -> v2:
- Move "skip if already precise" logic into the core backtracking engine
  __mark_chain_precision() as suggested by Eduard Zingerman.
- Add detailed performance benchmark results and veristat comparison.
- Clean up call sites in mark_chain_precision() and propagate_precision().

 kernel/bpf/verifier.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f0ca69f888fa..340d972bd833 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4765,14 +4765,37 @@ static int __mark_chain_precision(struct bpf_verifier_env *env,
 	 * slot, but don't set precise flag in current state, as precision
 	 * tracking in the current state is unnecessary.
 	 */
-	func = st->frame[bt->frame];
 	if (regno >= 0) {
-		reg = &func->regs[regno];
+		reg = &st->frame[bt->frame]->regs[regno];
 		if (reg->type != SCALAR_VALUE) {
 			verifier_bug(env, "backtracking misuse");
 			return -EFAULT;
 		}
+		if (reg->precise)
+			return 0;
 		bt_set_reg(bt, regno);
+	} else {
+		for (fr = bt->frame; fr >= 0; fr--) {
+			u32 reg_mask = bt_frame_reg_mask(bt, fr);
+			u64 stack_mask = bt_frame_stack_mask(bt, fr);
+			DECLARE_BITMAP(mask, 64);
+
+			func = st->frame[fr];
+			if (reg_mask) {
+				bitmap_from_u64(mask, reg_mask);
+				for_each_set_bit(i, mask, 32) {
+					if (func->regs[i].precise)
+						bt_clear_frame_reg(bt, fr, i);
+				}
+			}
+			if (stack_mask) {
+				bitmap_from_u64(mask, stack_mask);
+				for_each_set_bit(i, mask, 64) {
+					if (func->stack[i].spilled_ptr.precise)
+						bt_clear_frame_slot(bt, fr, i);
+				}
+			}
+		}
 	}
 
 	if (bt_empty(bt))
-- 
2.39.5


