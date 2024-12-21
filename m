Return-Path: <bpf+bounces-47502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF8D9F9DBA
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 02:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 810D4188C282
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 01:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDC62D613;
	Sat, 21 Dec 2024 01:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VWXxyRsF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F6A1DA3D
	for <bpf@vger.kernel.org>; Sat, 21 Dec 2024 01:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734744263; cv=none; b=bRTaMJB4BnZeiwf6O9BMQ/AR5ZI1Lfv4TdHySrbxaHZ4w8fhNN3V+rFegdlokiVo235Mom9ZeabcWmZrV7mvMo5Pcw3OUA/b5fUcfS/esQHtrxAV0JDMPg0ZA/Ybf55DR7p9EeQdv9kWTqOsgnwscWI0T3kpPB6DmzqS+jUhbPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734744263; c=relaxed/simple;
	bh=rBG+AsI9uSAETmCL6GbWWVsOK3Oe1VshvCQ+iEEvVBU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ER7brHc3IJKzic1IkduDbWDKcz4orZB8W5hU84uIYAtyrwfBdZ9LQAu0HXO41iW0dHWUSC+0W7INAYTAuMVzsCapeWM3/0fRf9GF36qIMb/3RC9Xpl75RRohODTgBUUUum6Za3diVXW0/j0YYaPY2l8oJxWoILgpnuPyGZQ+afI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VWXxyRsF; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-72907f58023so2859813b3a.3
        for <bpf@vger.kernel.org>; Fri, 20 Dec 2024 17:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734744261; x=1735349061; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zrn35WjRTAXV/q0fGp4quX7tww+ddKAXEAGON/HplnE=;
        b=VWXxyRsFQ77P63rS6FmD6NH8FYe8roC65o/wMR6g7XlLtvZWq6yIK9blP9G3h7oB8Q
         DLk+dR+bLaY/QKHLwcLSE6GungHX7qC0GYyLYHm8XfIlbI/oe+Ri2CvAGx9OaS+jJnVp
         9Jx39KbAHOOVHRaMXtVyETrpSFAJ3fVmQ/ydPaCMq1lsif6qCIeN15K0UcYvUbOreg7u
         ULcrE052dkSE0X4GbVNsq5ks2wjr83XnFqTCyRw5429Kje+TRD5pPbfWg1zf+7ZqWTU8
         v+J7FnZwrcRFV4c7LQtyxupW4dr49k7H2amt1yVQa4b24gticCs1wwSIWJEu+KD8m+z4
         UQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734744261; x=1735349061;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zrn35WjRTAXV/q0fGp4quX7tww+ddKAXEAGON/HplnE=;
        b=mGodENB/BDmXR0dkM9A/ly9+GqySTA5t1R1nQ8NjQ1M1+9gb6NCV/2LY7ghAgYn0As
         NgjOKZiOPkEgfRYqEhSkOszt9GCC91VpjRsyYypAKckwk3lksL6bwh4ZoTkM+IGauLAB
         UHGrQk6ZWu1BU8rYqNCDvr2MTbCnOJxcqNVkERH/ZeEtkYuF9+KaTSeeDYHTVMbD7gvw
         K1x529KGvu/Kln/Xx9TJUvSozaYL2JJAwGVvcpvkbfCk+wNDcsoF3k9zXI6vWQhGQ2XZ
         XbndUZ2pn7O6k+VgnyT9EP+m0iXHkC/HaISV5jMt/ALpuyTXQ60SNAHzK3lKfVpheFC8
         pmhw==
X-Gm-Message-State: AOJu0Yyv/ipyx6oPfK5DPK5xYWwxdN43neO9h909+ApDkHt/0tawXTri
	Slg42o53/LDYAHpvbBQ/2cEiMpdU1iynr9BFOR1T8CbUxiPnYgrOUNaxLHGSppzuApZzYg1/w/Z
	zNLVAChdISXfrlaYzuk7k7en85zNhIvYTLv0VlKB7dX3/sLgi3M7pcG7Sa6YV+l2ALGXa8G69gO
	y/+yXpBMP2AK+qB7lPfWhSgXXmlxUlerm5zQ6vq7w=
X-Google-Smtp-Source: AGHT+IFbscAq9apWLBUd7Erh+ffNiilAXLjwg3/pHWhedK7m5HIwODQAO6Bo6uwHyxt7qauW6JqF+Y3GDmamXA==
X-Received: from pgum3.prod.google.com ([2002:a65:6a03:0:b0:7fd:4497:f282])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:d80d:b0:1e0:d848:9e8f with SMTP id adf61e73a8af0-1e5e046decbmr9957435637.13.1734744261235;
 Fri, 20 Dec 2024 17:24:21 -0800 (PST)
Date: Sat, 21 Dec 2024 01:24:04 +0000
In-Reply-To: <cover.1734742802.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1734742802.git.yepeilin@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <44fd0483ebdb9f84e6d069fdf890bc5801e0d130.1734742802.git.yepeilin@google.com>
Subject: [PATCH RFC bpf-next v1 1/4] bpf/verifier: Factor out check_load()
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org
Cc: Peilin Ye <yepeilin@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, 
	Neel Natu <neelnatu@google.com>, Benjamin Segall <bsegall@google.com>, 
	David Vernet <dvernet@meta.com>, Dave Marchevsky <davemarchevsky@meta.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

No functional changes intended.  While we are here, make that comment
about "reserved fields" more specific.

Reviewed-by: Josh Don <joshdon@google.com>
Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 kernel/bpf/verifier.c | 56 +++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 23 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f27274e933e5..fa40a0440590 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7518,6 +7518,36 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 static int save_aux_ptr_type(struct bpf_verifier_env *env, enum bpf_reg_type type,
 			     bool allow_trust_mismatch);
 
+static int check_load(struct bpf_verifier_env *env, struct bpf_insn *insn, const char *ctx)
+{
+	struct bpf_reg_state *regs = cur_regs(env);
+	enum bpf_reg_type src_reg_type;
+	int err;
+
+	/* check src operand */
+	err = check_reg_arg(env, insn->src_reg, SRC_OP);
+	if (err)
+		return err;
+
+	err = check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK);
+	if (err)
+		return err;
+
+	src_reg_type = regs[insn->src_reg].type;
+
+	/* check that memory (src_reg + off) is readable,
+	 * the state of dst_reg will be updated by this func
+	 */
+	err = check_mem_access(env, env->insn_idx, insn->src_reg,
+			       insn->off, BPF_SIZE(insn->code),
+			       BPF_READ, insn->dst_reg, false,
+			       BPF_MODE(insn->code) == BPF_MEMSX);
+	err = err ?: save_aux_ptr_type(env, src_reg_type, true);
+	err = err ?: reg_bounds_sanity_check(env, &regs[insn->dst_reg], ctx);
+
+	return err;
+}
+
 static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_insn *insn)
 {
 	int load_reg;
@@ -18945,30 +18975,10 @@ static int do_check(struct bpf_verifier_env *env)
 				return err;
 
 		} else if (class == BPF_LDX) {
-			enum bpf_reg_type src_reg_type;
-
-			/* check for reserved fields is already done */
-
-			/* check src operand */
-			err = check_reg_arg(env, insn->src_reg, SRC_OP);
-			if (err)
-				return err;
-
-			err = check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK);
-			if (err)
-				return err;
-
-			src_reg_type = regs[insn->src_reg].type;
-
-			/* check that memory (src_reg + off) is readable,
-			 * the state of dst_reg will be updated by this func
+			/* Check for reserved fields is already done in
+			 * resolve_pseudo_ldimm64().
 			 */
-			err = check_mem_access(env, env->insn_idx, insn->src_reg,
-					       insn->off, BPF_SIZE(insn->code),
-					       BPF_READ, insn->dst_reg, false,
-					       BPF_MODE(insn->code) == BPF_MEMSX);
-			err = err ?: save_aux_ptr_type(env, src_reg_type, true);
-			err = err ?: reg_bounds_sanity_check(env, &regs[insn->dst_reg], "ldx");
+			err = check_load(env, insn, "ldx");
 			if (err)
 				return err;
 		} else if (class == BPF_STX) {
-- 
2.47.1.613.gc27f4b7a9f-goog


