Return-Path: <bpf+bounces-53170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF982A4D533
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 08:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E23143B0168
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 07:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790681FBC82;
	Tue,  4 Mar 2025 07:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aV8ugoXt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707C11F9A83
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 07:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741074224; cv=none; b=LWHwMifVQurF7lBuqYbiz9rZWx/Zgky5aNKf/H6u8xtMgfp2vqExfJYoeWyb8VKWBCT5ZK3q3i/d/qLJINYsLgxcDTavQhFKxTvzIeX03/ebSXiDJO8pt+gjOcmqFPjbb/6nnRUkWhb0Lrrmjyg/PBwv4YXjRs4erlWjJk837Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741074224; c=relaxed/simple;
	bh=hSp9ao7hvzRr2iO5Mp3H3YgWUajloZ/Lw/CDax4ils0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iY50bRgnnl9zhhqALk6Hlgbl/WOyX08ocdESeu58itwg7wXj8w6cywTzjd+x3+9pFSsLAqeu3YoBcbSOzoSgpCD+wM2oqzogCkWEmu6R9Za5jc5lsUFlbdbOmLBd3dCsqU/AcPzbVl+Dym2vzTDMA0W7MLQ+EZqajWz9jWZTuiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aV8ugoXt; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2f44353649aso8440566a91.0
        for <bpf@vger.kernel.org>; Mon, 03 Mar 2025 23:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741074221; x=1741679021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTuh+Ebz89LvmqO9DItlVl/GvCvtRJOYt4hWet4SWic=;
        b=aV8ugoXtn7s1QmcpE3ssjVFGE6ScSD85ZDVNRu10foaHIXomdvxBBYnG48VlAVSjpQ
         eo4Pg6xaVKFBGbk54txLiflafdPH2NKa+Zd9L7fDCXY9yNws4NoK0NWx1wwuqP77IDhk
         fssMB50BWPiN4nY7KLD4lLUeP3NGuNwJD+lOLPeoBvePaCUYQkM2RixfYnrJ1BQKVAVc
         I5S8a53uzROJDnbJfQFtXXRTc2Y8JjZe8F1aiP9wXdB1NPBBF7KbBZ89BeNONye7Fc0R
         soCVv3s3cdRxE0v3mwc+nLuZbX0sOG5KGf5Zjc8BFInqE9K0RWuTy5WNfO00VJ3dwvvj
         4V4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741074221; x=1741679021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZTuh+Ebz89LvmqO9DItlVl/GvCvtRJOYt4hWet4SWic=;
        b=AtVot28JS9aH6S6oHs2mK37NqqsuTiG4zZT7r5uNPRrb7w+FJOuS/eI+p62EP+gzU5
         z2aS7O1ZGmHSeIoKmIfiaSSbphXnd7Hr4BSvQyOMVZs7eiWJ43PSOFln6+TxxDDBA/5v
         bH5nBNDqVxpikW4vZn3CwHpUTQC8B53jOlCe85Hh1m+/nl+g+Pjo1oHpyiGKHtZiWrhJ
         GWKssXSEI0K/MCRNBjJI0xiJP1p/MIAWASroKcwf0bR+7NT7ktE3foxOdZmQFAbj/7h9
         1AEYheNsEINfiZaYLs6iIg9DlQcL9gTc1hW3oh5NK84vDAcGdk5s+eLuK8aXg7tb0HJz
         cjsw==
X-Gm-Message-State: AOJu0YwW2okFx2TwN4jajAZ+7/M1IHa7mUhBuAzsZ4t1L2TPfWKZQJtj
	q6w00G+BkALz8xjHPM8SIdmzjMBGgvj20mkcX82CImP5dLcZmSUG1LxnSA==
X-Gm-Gg: ASbGncvR7izW8Lb5uFf68h8bwMg0ZUaOQJaHKD/FV5UoqWzDwdbKj7IT6lbsCGA2V8h
	HnQvVKzlx008gA07ImazHSiUGHy7C4LcDE8WIpdz0bdFZeVJ0RFmzPDYbbYgWuemaHOxyDa2sNf
	yeW2dB7cVenLrxyCxdxsZUsCTy8TXJNCy6abLpFpc3V1FIcKw4vqEZMTBPqBRmH3dap2skHifRN
	9rvvaGaMEF/w6TYUjiaXezpxQ90zmkVXMF95amBfsMHR3E8GYOPH0NlUikHZOSTAB8tMYk7OIGk
	vOfYeW51YZLyIKkymXJ298NsB/JJqdvbw+rPT3C1
X-Google-Smtp-Source: AGHT+IFDoTRdifM52GWZc6JYPAlaG/AEl/DyaE5kzgCvgaM2Q0NGNakmAyLQnp6CAlotDIMOdys9+Q==
X-Received: by 2002:a17:90b:17cf:b0:2fe:9e6c:add9 with SMTP id 98e67ed59e1d1-2febab70151mr27550889a91.18.1741074221574;
        Mon, 03 Mar 2025 23:43:41 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2235050d7c1sm89545125ad.198.2025.03.03.23.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 23:43:41 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	tj@kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 4/5] bpf: use register liveness information for func_states_equal
Date: Mon,  3 Mar 2025 23:42:38 -0800
Message-ID: <20250304074239.2328752-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304074239.2328752-1-eddyz87@gmail.com>
References: <20250304074239.2328752-1-eddyz87@gmail.com>
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
listing using `-f "insns_pct>5" -f "!insns<200"`

selftests:

File                  Program                        States (A)  States (B)  States  (DIFF)
--------------------  -----------------------------  ----------  ----------  --------------
arena_htab.bpf.o      arena_htab_llvm                        37          35     -2 (-5.41%)
arena_htab_asm.bpf.o  arena_htab_asm                         37          33    -4 (-10.81%)
arena_list.bpf.o      arena_list_add                         37          22   -15 (-40.54%)
dynptr_success.bpf.o  test_dynptr_copy                       22          16    -6 (-27.27%)
dynptr_success.bpf.o  test_dynptr_copy_xdp                   68          58   -10 (-14.71%)
iters.bpf.o           checkpoint_states_deletion            918          40  -878 (-95.64%)
iters.bpf.o           clean_live_states                     136          66   -70 (-51.47%)
iters.bpf.o           iter_nested_deeply_iters               43          37    -6 (-13.95%)
iters.bpf.o           iter_nested_iters                      72          62   -10 (-13.89%)
iters.bpf.o           iter_pass_iter_ptr_to_subprog          30          26    -4 (-13.33%)
iters.bpf.o           iter_subprog_iters                     68          59    -9 (-13.24%)
iters.bpf.o           loop_state_deps2                       35          32     -3 (-8.57%)
iters_css.bpf.o       iter_css_for_each                      32          29     -3 (-9.38%)
pyperf600_iter.bpf.o  on_event                              286         192   -94 (-32.87%)

Total progs: 3577
Old success: 2060
New success: 2060
States diff min:  -95.64%
States diff max:    0.00%
-100 .. -90  %: 1
 -55 .. -45  %: 3
 -45 .. -35  %: 2
 -35 .. -25  %: 5
 -20 .. -10  %: 12
 -10 .. 0    %: 6

sched_ext:

File               Program                 States (A)  States (B)  States   (DIFF)
-----------------  ----------------------  ----------  ----------  ---------------
bpf.bpf.o          lavd_dispatch                 8950        7065  -1885 (-21.06%)
bpf.bpf.o          lavd_init                      516         480     -36 (-6.98%)
bpf.bpf.o          layered_dispatch               662         501   -161 (-24.32%)
bpf.bpf.o          layered_dump                   298         237    -61 (-20.47%)
bpf.bpf.o          layered_init                   523         423   -100 (-19.12%)
bpf.bpf.o          layered_init_task               24          22      -2 (-8.33%)
bpf.bpf.o          layered_runnable               151         125    -26 (-17.22%)
bpf.bpf.o          p2dq_dispatch                   66          53    -13 (-19.70%)
bpf.bpf.o          p2dq_init                      170         142    -28 (-16.47%)
bpf.bpf.o          refresh_layer_cpumasks         120          78    -42 (-35.00%)
bpf.bpf.o          rustland_init                   37          34      -3 (-8.11%)
bpf.bpf.o          rustland_init                   37          34      -3 (-8.11%)
bpf.bpf.o          rusty_select_cpu               125         108    -17 (-13.60%)
scx_central.bpf.o  central_dispatch                59          43    -16 (-27.12%)
scx_central.bpf.o  central_init                    39          28    -11 (-28.21%)
scx_nest.bpf.o     nest_init                       58          51     -7 (-12.07%)
scx_pair.bpf.o     pair_dispatch                  142         111    -31 (-21.83%)
scx_qmap.bpf.o     qmap_dispatch                  174         141    -33 (-18.97%)
scx_qmap.bpf.o     qmap_init                      768         654   -114 (-14.84%)

Total progs: 216
Old success: 186
New success: 186
States diff min:  -35.00%
States diff max:    0.00%
 -35 .. -25  %: 3
 -25 .. -20  %: 6
 -20 .. -15  %: 6
 -15 .. -5   %: 7
  -5 .. 0    %: 6

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 09298e0e4b73..9685b283224a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18500,15 +18500,17 @@ static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *c
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
 
@@ -18529,6 +18531,7 @@ static bool states_equal(struct bpf_verifier_env *env,
 			 struct bpf_verifier_state *cur,
 			 enum exact_level exact)
 {
+	u32 insn_idx;
 	int i;
 
 	if (old->curframe != cur->curframe)
@@ -18552,9 +18555,12 @@ static bool states_equal(struct bpf_verifier_env *env,
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
2.48.1


