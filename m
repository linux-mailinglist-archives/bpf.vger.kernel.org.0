Return-Path: <bpf+bounces-32549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D3090F9DD
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 01:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01B0F1F22668
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 23:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6362515383B;
	Wed, 19 Jun 2024 23:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5Wh1oTP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0281E515
	for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 23:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718841242; cv=none; b=t44pFKHz9R3cakmABbwj1KN0vaitQg+nV4x2QiGkeWUQ3fhSWHOYNLwACQWag5m9J0EB9+x1/9T+OYJ+0eb+DVwaELUYoj8DLcr3pbpYlJyI/6HmpyepJRZbgZUnFYg8tqf6mHWOLQ7lJDbP+YdZW7NSDbVXmSCRpDeXZAMMlSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718841242; c=relaxed/simple;
	bh=uLPQp76Pr5CsySRpH4YOhG6wK1Cc8HlUu+B5miMpMlo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tuUHMjJKUkcABUwo1mvppg602Xg5woqltDhbUiDVMhkStknb2FmHCgmBeSpYF8tHlDnffsIt4zS2QP+cgr/XrS4T1QRWxKqarDRiwfrCI40ZvRD3zYIbqQFdzeqW+4vIoA7PBFOUIhtSWH3BrgGcgGvx9/3yWWSmKThdjwceTXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5Wh1oTP; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-705fff50de2so242132b3a.1
        for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 16:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718841240; x=1719446040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qk+dEawLpaZatOnQPDUSem7ShPDKFJJ3iJ+3pIhW5dQ=;
        b=N5Wh1oTPMrTI7QKD9JsJopFfz9CHGtHILSoXk6AMmBReDyVhKjHNMsa8csTFQPWHSL
         ZsZL98+LwkMmotT9BcErzvxNhHZ/6yucxiAMahuSiOBYwZ6W2kflonctLkItbuq/jFtt
         8u9I8Puh8gRufzfp7d+FuUEj921XYVLIvQaRdRn/ayLvGG0cSAW2VRLLSiq3sfy7Z6/l
         tuA9Yu8huQ2+Yx2hiZb2Rt1Bks4e/TzsM37StlV1eUyQKIDfcMX/S/7uKXyl9bGcu/TO
         Wvgct3TDf8Mr6M0pVE33F52D1kn8Fz8wNnwMgnxhr2UiyrWmJYI94txQBL3p5fF6F+5r
         Lfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718841240; x=1719446040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qk+dEawLpaZatOnQPDUSem7ShPDKFJJ3iJ+3pIhW5dQ=;
        b=awGClQ4kzfg+qUVUSpGuXPTZoiCEJ0F0TwzkktpJ8XU5mg+9Ua0dHPuusxWumguUFJ
         PsgLRJ5tU1iDtwrG+YEM0NLnY1yG4EZdw2Wod3WoS8ZdW6s7SQKiZTp/d3JY58sLs4fN
         aJzfte14nonherCK76DyoqKluMekcMuKeVUk3I7SF/YTFDPFbwuKF8VL4xZX2dlhF/0W
         y0y9bsnXlAxzRWO5lgGB+uSO1TPFT5Eh359pta+IwYSRac9GdYws1r/I/KNlpJSGuQeR
         eNzzVdjGzSDE9Y9Uh5vvFsb7vC4WjPVIkf3CqUhPWPk62K9JqlzWK6fSlhqmYBi4mw8w
         B2Tg==
X-Gm-Message-State: AOJu0YyNrgkRQuXFLV/sdX/66qaYfgaa++Bft2tE9hIfeHWZ8BY2LuQi
	D3dKKURrv6dhX+iw4G+rr+hR+ojSyXlM7AgpSqiqgUoIsAqmD6MKLivc5A==
X-Google-Smtp-Source: AGHT+IE3LBGlItbo8jzAsUDk3DeMnJzgVvqLR440eRPwWY+GdgWskzdIKq3Zsh8U8JtZQMY2OIbCpw==
X-Received: by 2002:a05:6a00:d0:b0:6f6:76c8:122c with SMTP id d2e1a72fcca58-706290a2d5cmr5005155b3a.16.1718841239796;
        Wed, 19 Jun 2024 16:53:59 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:7a04])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb92b47sm11205376b3a.214.2024.06.19.16.53.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Jun 2024 16:53:59 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	zacecob@protonmail.com,
	kernel-team@fb.com
Subject: [PATCH bpf 1/2] bpf: Fix may_goto with negative offset.
Date: Wed, 19 Jun 2024 16:53:54 -0700
Message-Id: <20240619235355.85031-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Zac's syzbot crafted a bpf prog that exposed two bugs in may_goto.
The 1st bug is the way may_goto is patched. When offset is negative
it should be patched differently.
The 2nd bug is in the verifier:
when current state may_goto_depth is equal to visited state may_goto_depth
it means there is an actual infinite loop. It's not correct to prune
exploration of the program at this point.
Note, that this check doesn't limit the program to only one may_goto insn,
since 2nd and any further may_goto will increment may_goto_depth only
in the queued state pushed for future exploration. The current state
will have may_goto_depth == 0 regardless of number of may_goto insns
and the verifier has to explore the program until bpf_exit.

Reported-by: Zac Ecob <zacecob@protonmail.com>
Closes: https://lore.kernel.org/bpf/CAADnVQL-15aNp04-cyHRn47Yv61NXfYyhopyZtUyxNojUZUXpA@mail.gmail.com/
Fixes: 011832b97b31 ("bpf: Introduce may_goto instruction")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5586a571bf55..214a9fa8c6fb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17460,11 +17460,11 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 				goto skip_inf_loop_check;
 			}
 			if (is_may_goto_insn_at(env, insn_idx)) {
-				if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
+				if (sl->state.may_goto_depth != cur->may_goto_depth &&
+				    states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
 					update_loop_entry(cur, &sl->state);
 					goto hit;
 				}
-				goto skip_inf_loop_check;
 			}
 			if (calls_callback(env, insn_idx)) {
 				if (states_equal(env, &sl->state, cur, RANGE_WITHIN))
@@ -20049,7 +20049,10 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 
 			stack_depth_extra = 8;
 			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_AX, BPF_REG_10, stack_off);
-			insn_buf[1] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, insn->off + 2);
+			if (insn->off >= 0)
+				insn_buf[1] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, insn->off + 2);
+			else
+				insn_buf[1] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, insn->off - 1);
 			insn_buf[2] = BPF_ALU64_IMM(BPF_SUB, BPF_REG_AX, 1);
 			insn_buf[3] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_AX, stack_off);
 			cnt = 4;
-- 
2.43.0


