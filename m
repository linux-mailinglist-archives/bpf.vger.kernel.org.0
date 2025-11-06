Return-Path: <bpf+bounces-73841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1E4C3B0E7
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 14:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 171EA501C38
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 12:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFC03385BC;
	Thu,  6 Nov 2025 12:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bx+O8LXv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAD033032D
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 12:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433624; cv=none; b=gGzqUCQ15K04dnYv18hMhedNGgWJ9x9kVN+mEjBOzWqgfLN7RMiPI4A0eDQtJb1udi1OHMfDo+WzD9OpxZV/Z/PlWwvCqkwue8d2v7RD9SO9V+EhLLMbVLe41Jzc1TEv/epJwvuuPNYRtMxGMgIqXhNAjTDktDEvWzQBolJWAG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433624; c=relaxed/simple;
	bh=nJMaLGpKEmP3DsyD+IyFFczvrWgzDb+7/77EaIxg+NE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qNwiDU6Qi64eAa32krLq5jM8s6FLSjsAkLsB8811GVI4GuluzPrSNJZav0OhGz/pLdjH3JagmHL4N4YW4+h2tX0hVChQfwyMA81+V2ak7jMeovGEe3zXNzBpfNgd3jc9x+SVuahVWJOrW4Bqwdg37xTtiwN7ua7fBEGkCV6iD5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bx+O8LXv; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-429c7f4f8a2so1098571f8f.0
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 04:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762433619; x=1763038419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gboyt37Ov9MOTTH/KPaW8uj5vESoPgNEDU8dO3DpPF0=;
        b=Bx+O8LXvxiiSTcAE6E8Z0YHAr8UcvU4LFsOvQf/bttKd2WtVNM80bh9xYhBuQ7Scoy
         WdIIb5Fa+y/+3p6Hy6T+viHpCkl55dsvdGLw9ZCBA0nI89NiCk3MBGMSR+aGDRIk1+Ic
         hbPgXhSPulZ7VGIAtkFDUX7LRVayoa0gwRiSBazFfpCf5+M2Fx/EkJhBYYTUqM8SrMwK
         0hCGuSS4wnPXikaQob3ZuWDPTFCrXuTvXceP66MxUNadN+3ToqJet1EnIkqJCD3SupQW
         znBNlqMxmQOrqhbEp37Mf0NwSL64nsAgZX4OCyAkrBydRvfpPcuh6tvckDD1qht2HRxt
         6i9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762433619; x=1763038419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gboyt37Ov9MOTTH/KPaW8uj5vESoPgNEDU8dO3DpPF0=;
        b=m5au9jw0JDpfK9vl0cJ29TMhAOhq2889vQ/FLUl52RY4n6Uv/iEt6y+colPWqImz5T
         0U9ZbUhWd6R914ljgLYHO/rRTubeBnXt/EyQ5iN8cLOu8XLDPYfnfu6IFNN/hejVD4ju
         smhVheqrvSs6rnyFO8Y+PM/VdqchJY3gbYS72yezQ5GcNBiuFFkaKieekvFtKQ2KcFIQ
         OTdwI7EB6Q/jG/5tAx6blCyh1j2R2El5jr/loUHSMfpG+Qd7ahTfFD5vTnmLGtgr5Y6/
         2AH94PKAKEQetMsyGxOK2s8AfIUhXnwZqaLRo73FmJOVLS9ooRY5Mct+C/OqUlBJcLQs
         SVSg==
X-Gm-Message-State: AOJu0YzSeQKef3Cs9mZXnmaBtVV+1RPERybGllCw3Um6r0IEEGu/R074
	1WEEvEANPBtZMRY9mH4xsa3kNcEuBdaLZxSypXlE7JtYCVeq+/d4fhsm8rXq
X-Gm-Gg: ASbGncvMvkZ5EkX0lwab9z6BAKjnFk883b6DSWMX0xXzRYTShuZYagYHLII94rWnNNb
	X0h65hoFELf1IPIAiCCut9XVIjcJYSWyTWXDikfBM5/FvCeDyQ5JfhtX/PTHnZ/Grp/ehvVWTzB
	vwFEu8/8NDd3A9B+Gu6UyhNBdy/MmfjAanksCu7h2/jeFquGrz98eJbfD+HGB7/gxwNVsgH9RS0
	YPOI3URDIdMQxWiO5Y+c4RWoBuY333sYmvQekJpgv0VMqHWc9AXWyrM3Ckqq3Z8zE3Jbxk8iWtT
	NpQLIUjuQyy9I1W5ZA40aHU5V+EFj1IPIPjDEWR5pL5os8lYqKpvUyebDTlKXIUnDKIze/lKHeP
	/nTbP0AzgnZK+eaRtEKIfYnU2UyIfi+ChYplJWpfSA+UzjDZpYVKLTY0ujCTB1KfOjjKNplf4jI
	KjqaEfI47PJbDZ5Qmt67uJP8POpcO9nS53CpQ8N2ZQxb5GC39RHHxIGM0=
X-Google-Smtp-Source: AGHT+IE2d3CRUrs2Qxa0+9muOrmRjSuRP78wlr1433ZpQlc/ZIYdsLyGsliVtRU0kPFyTQ8p1N80tw==
X-Received: by 2002:a5d:5f54:0:b0:429:bb77:5deb with SMTP id ffacd0b85a97d-429eb1d0d12mr3086191f8f.31.1762433619310;
        Thu, 06 Nov 2025 04:53:39 -0800 (PST)
Received: from ast-epyc5.inf.ethz.ch (ast-epyc5.inf.ethz.ch. [129.132.161.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb40379esm4788856f8f.9.2025.11.06.04.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 04:53:39 -0800 (PST)
From: Hao Sun <sunhao.th@gmail.com>
X-Google-Original-From: Hao Sun <hao.sun@inf.ethz.ch>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	linux-kernel@vger.kernel.org,
	sunhao.th@gmail.com,
	Hao Sun <hao.sun@inf.ethz.ch>
Subject: [PATCH RFC 06/17] bpf: Add bcf_match_path() to follow the path suffix
Date: Thu,  6 Nov 2025 13:52:44 +0100
Message-Id: <20251106125255.1969938-7-hao.sun@inf.ethz.ch>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251106125255.1969938-1-hao.sun@inf.ethz.ch>
References: <20251106125255.1969938-1-hao.sun@inf.ethz.ch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add `bcf_match_path()` to constrain `bcf_track()` to the recorded path suffix
from parent states. The function consumes the per-state jump history arrays in
order and compares each (prev_idx, idx) pair against the verifier’s current
(prev_insn_idx, insn_idx):

- If the current pair matches the top entry, advance to the next history entry;
  when the last entry is consumed and the last state's last_insn matches, stop
  tracking (PATH_DONE).
- If the pair mismatches at a branch point, abandon the current fork
  (PATH_MISMATCH) so the tracker pops the path.
- Otherwise, continue (PATH_MATCH).

`do_check()` is updated under tracking mode to call `bcf_match_path()` before
processing each instruction and to terminate early on PATH_DONE, ensuring only
suffix instructions are symbolically analyzed.

Signed-off-by: Hao Sun <hao.sun@inf.ethz.ch>
---
 kernel/bpf/verifier.c | 66 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 725ea503c1c7..3ecee219605f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20082,6 +20082,63 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 	return 0;
 }
 
+static struct bpf_jmp_history_entry *
+get_top_jmp_entry(struct bpf_verifier_env *env)
+{
+	struct bcf_refine_state *bcf = &env->bcf;
+	struct bpf_verifier_state *vstate;
+next:
+	if (bcf->cur_vstate >= bcf->vstate_cnt)
+		return NULL;
+	vstate = bcf->parents[bcf->cur_vstate];
+	if (bcf->cur_jmp_entry >= vstate->jmp_history_cnt) {
+		bcf->cur_vstate++;
+		bcf->cur_jmp_entry = 0;
+		goto next;
+	}
+	return &vstate->jmp_history[bcf->cur_jmp_entry];
+}
+
+enum { PATH_MATCH, PATH_MISMATCH, PATH_DONE };
+
+static int bcf_match_path(struct bpf_verifier_env *env)
+{
+	struct bcf_refine_state *bcf = &env->bcf;
+	struct bpf_jmp_history_entry *top = get_top_jmp_entry(env);
+	struct bpf_verifier_state *last_state;
+	int prev_idx;
+
+	last_state = bcf->parents[bcf->vstate_cnt - 1];
+	if (!top)
+		return last_state->last_insn_idx == env->prev_insn_idx ?
+			       PATH_DONE :
+			       PATH_MATCH;
+
+	prev_idx = top->prev_idx;
+	/* entry->prev_idx is u32:20, compiler does not sign extend this */
+	if (prev_idx == 0xfffff)
+		prev_idx = -1;
+
+	if (prev_idx == env->prev_insn_idx) {
+		if (top->idx == env->insn_idx) {
+			bcf->cur_jmp_entry++;
+			/* Check if we have consumed the last entry */
+			top = get_top_jmp_entry(env);
+			if (!top &&
+			    last_state->last_insn_idx == env->prev_insn_idx)
+				return PATH_DONE;
+			return PATH_MATCH;
+		}
+		return PATH_MISMATCH;
+	}
+
+	/* cur_state is branch taken, but the recorded one is not */
+	if (is_jmp_point(env, env->insn_idx))
+		return PATH_MISMATCH;
+
+	return PATH_MATCH;
+}
+
 static int do_check(struct bpf_verifier_env *env)
 {
 	bool pop_log = !(env->log.level & BPF_LOG_LEVEL2);
@@ -20144,6 +20201,15 @@ static int do_check(struct bpf_verifier_env *env)
 				return err;
 		}
 
+		if (env->bcf.tracking) {
+			int path = bcf_match_path(env);
+
+			if (path == PATH_MISMATCH)
+				goto process_bpf_exit;
+			else if (path == PATH_DONE)
+				return 0;
+		}
+
 		if (signal_pending(current))
 			return -EAGAIN;
 
-- 
2.34.1


