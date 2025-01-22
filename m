Return-Path: <bpf+bounces-49471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16960A19119
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 13:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97B6E3AB3ED
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 12:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D479212B11;
	Wed, 22 Jan 2025 12:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5G1WLIq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5A3211A2D
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 12:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737547504; cv=none; b=HSWnzLWbeVi0Eh6HK795VtURvFigypa5Ze3guXjBH6EdLIkVBUFyHjWS7MVfJwcBGa+wF76TbkTmqjoAlIHgUq2cujU3QclxraaTBeBAM1L6yJ3NthLkxzQIrzG+XfJzy6wBKiUc54wK7S1Gm4zk3acQt2qJiYRHVJaQUs+9X+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737547504; c=relaxed/simple;
	bh=jMTSymEefxUmchMhlprnFt1mX/c+7lNsFNWcUW8Y12c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ENanmK8JnJpwhAN2wfECAeKr2NCoxtn1MKFpp48dIAPH/a1Ei5I88MPj/X1ICHwDW3joxt7RJQr3ZjceF0oG9XGFITcxxoHS6D85+px2Iq3v/249goO2co5icrgZkfrIFO0zH9SORzqYjWbvNWHEaGVa7Y9ntumit0tJ7TMObAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5G1WLIq; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-216426b0865so116489805ad.0
        for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 04:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737547501; x=1738152301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9m15PhxS3SDAVDAGndcYvrgTV4MB+kIx+3mFednYfY=;
        b=T5G1WLIqclimidfxe/YlJUCvGAHtmVUpGI2HzlqycHofko3otmUHUl74ni50/5VnBU
         bXjWQ8tL0ePAfHsWqXvDyIhyX9u9i3Mit1IKcxrWozY7gaxYrxjty4ilWWiF+GTcZI3x
         rNMCcN6XPpBsezpY2PpVUmCae7lqfwf20mUjNEEvJsS78TbHHoruq9aohF7/NMFDjzC7
         BKGTHYLF+bCNDkOqNz5EJkc64POwvBp3k1l2nlCznc0Z+eAZWfn4ykD/iO1Wri1WuLAX
         S0ZFRJB8bGjnwOXtJo1hXvXl2aHvQZTuuNDL3DhVzZx2CDxNwGiaBJDSoszJLCWqIPRi
         x8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737547501; x=1738152301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9m15PhxS3SDAVDAGndcYvrgTV4MB+kIx+3mFednYfY=;
        b=OKJoX5J++NWN5ycAnM6aEjwso4M/GoWw+m3Mt3IhOcFzxcK2XEASygcHIW+UDfLxr7
         kPRuQKGvZ0uLLPYglByKDWcI0Xf/s2oyk6LNsJYzasjRKogRRvJrW8Vd9fBRXhVt2FtO
         MO6qIiVhY6RjQ0JqU7UpOb0k2gHYqAkeosRP5LwdCKcB8s6PTJMAn5O5XqLroMOpb/4Z
         VDFYo8b//qlvL+1jyUf2Pk7q2P9KI69efsKtf5j0OmDyACiyoUk/MxmNlaU6zUd0QvpT
         dDwQuQ4flcsIZpa9iBZDiLJngg7IbomuHjCiPPxev0ptpoU/J3w1/7S+PsBDDLcufxs6
         3w3A==
X-Gm-Message-State: AOJu0YypP3E6RBGGjvpF61loAG64WackvchSFcpS2gv9+ZhzTLugua9d
	iAc+5axZxZGFJfpauT0QWFMD064PL/u+V6SNRq4dYEa/WNQqprCt/eoNbA==
X-Gm-Gg: ASbGnctiSa+urQ5Rx6bvsSbL+FK1TRuOpW9vkxPs3BjLW46v89oaEvMVEfpRqRx1pw0
	LBFEWhlqBUKhxGuRhMvI90Vq/IsOiFx0Lo7Rg/e8/SVyrmtt3FeL8ToM5zJWYfDJrEnjmtevHES
	OP2bhcYQPsyBNJPL4dwo6afo1PZUzdicODgbQJYyldTCOhIAIaPvRF44AjgR/KG8OR/m+tKyVtw
	UnBPvHwhJaDnIcMLBrpmzGoT4psIyW0ds6ax+bVAPsPVU1s0Wf/3fxUOHzS754Npw==
X-Google-Smtp-Source: AGHT+IEuVv6JUZcG36U4wsUrBi3hKCII5MN2lF36yS9K5xDrERtnoimzZePGhe/9V0h3zDxvqvQe5Q==
X-Received: by 2002:a05:6a20:841c:b0:1e1:ae9a:6316 with SMTP id adf61e73a8af0-1eb215ec18amr38956730637.35.1737547501435;
        Wed, 22 Jan 2025 04:05:01 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab816412sm11055732b3a.66.2025.01.22.04.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 04:05:00 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next v1 1/7] bpf: copy_verifier_state() should copy 'loop_entry' field
Date: Wed, 22 Jan 2025 04:04:36 -0800
Message-ID: <20250122120442.3536298-2-eddyz87@gmail.com>
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

Program                       Insns   (DIFF)  States (DIFF)
----------------------------  --------------  -------------
arena_htab_llvm               -291 (-40.59%)  -20 (-35.09%)
arena_htab_asm                -152 (-25.46%)  -10 (-21.28%)
arena_list_del                  -30 (-9.71%)   -9 (-39.13%)
checkpoint_states_deletion       -5 (-0.03%)    -1 (-0.12%)
iter_nested_deeply_iters        -26 (-4.38%)    -4 (-5.97%)
iter_subprog_check_stacksafe    -14 (-9.03%)    -1 (-6.67%)
iter_subprog_iters              -91 (-8.32%)    -5 (-5.68%)
loop_state_deps2              +246 (+51.36%)  +17 (+36.96%)
open_coded_iter                  -4 (-6.35%)   -1 (-14.29%)
on_event                       -320 (-2.59%)  -80 (-18.14%)
big_alloc2                       +7 (+0.24%)    +1 (+0.65%)
max_words                        -8 (-8.70%)   -1 (-12.50%)
cond_break2                      -6 (-5.31%)    +0 (+0.00%)

And significant negative impact for sched_ext:

Program                 Insns         (DIFF)  States      (DIFF)
----------------------  --------------------  ------------------
lavd_cpu_offline                 +4 (+0.09%)         -1 (-0.32%)
lavd_cpu_online                  +4 (+0.09%)         -1 (-0.32%)
lavd_enqueue                     -4 (-0.08%)         +0 (+0.00%)
lavd_init                   +7684 (+109.40%)     +649 (+133.26%)
layered_dispatch               -937 (-8.16%)       -86 (-10.14%)
layered_dump            +992580 (+13375.29%)  +30497 (+4478.27%)
layered_enqueue              -2733 (-20.91%)      -260 (-22.07%)
layered_runnable              -435 (-13.52%)       -38 (-12.88%)
refresh_layer_cpumasks   +658273 (+3992.68%)  +63600 (+3593.22%)
rustland_init                   -22 (-4.42%)         -4 (-9.76%)
rustland_init                   -22 (-4.42%)         -4 (-9.76%)
rusty_init                   +1917 (+12.72%)      +175 (+22.76%)
rusty_init_task                +135 (+0.32%)        +10 (+0.45%)
rusty_select_cpu          +75128 (+3580.93%)   +5807 (+3208.29%)
rusty_set_cpumask           -15799 (-78.00%)     -1349 (-81.02%)
central_dispatch            +2051 (+322.48%)     +164 (+260.32%)
nest_init                     +179 (+28.14%)       +13 (+21.67%)
qmap_dispatch                +1187 (+49.60%)       +57 (+29.08%)
qmap_dump                      +85 (+36.48%)        +8 (+36.36%)
qmap_init                     +1069 (+6.53%)       +66 (+10.95%)

Note 'layered_dump' program, which now hits 1M instructions limit.
This impact would be mitigated in the next patch.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 74525392714e..c7ceb59d3a19 100644
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
@@ -19230,6 +19231,8 @@ static int do_check(struct bpf_verifier_env *env)
 						return err;
 					break;
 				} else {
+					if (WARN_ON_ONCE(env->cur_state->loop_entry))
+						env->cur_state->loop_entry = NULL;
 					do_print_state = true;
 					continue;
 				}
-- 
2.47.1


