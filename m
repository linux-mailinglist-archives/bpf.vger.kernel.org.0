Return-Path: <bpf+bounces-50716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AABEA2B897
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 03:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE5BC3A6419
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 02:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B440149C4A;
	Fri,  7 Feb 2025 02:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jnPPLqHO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F195364D6
	for <bpf@vger.kernel.org>; Fri,  7 Feb 2025 02:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738893932; cv=none; b=gQmPfPZVLFUlrzemRk/OCEpHpZz5VImvcAcE/wHYCPiOOrDwnDd5XcSuAqYbjb/nnnWzLchxQwEShfk1gKE3rPjbeL6pLqiLPj1iBwA76uqY/mG6adrYaM9min0e1I9gQTHb6SDEDkWJqKXev9vok3ApVpB3POetiEZPvW/uYMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738893932; c=relaxed/simple;
	bh=6gJQBoMJvd11kabG0mAvazNwvvNUp+qYDK9d+B95w4A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sJ8oFkP45KYdj6NeU72QIeyqEoiArHbIQyWCy5iMgBQeaTtfuyUDy6Exvs0lk12roYzMtiFTiSfEtvHTCM69DIprPpPwdeJd0AtGHYZai6kzvUPqT0YdaKYJh0z9Nl5vCcLE9r+iNdEMBBbHnOyAp5hPnyFDDe062VD+Zw3CiEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jnPPLqHO; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2f9f2bf2aaeso3264150a91.1
        for <bpf@vger.kernel.org>; Thu, 06 Feb 2025 18:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738893930; x=1739498730; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rnyfeyX5KsaoejFCT4Pvz88fBme+Wvr3R6AqYNdoRSY=;
        b=jnPPLqHOLKGxsXCbQSKdHMada4V6RsENu4S9ge19PEmTp0HQZX1FL5QsZxJOcvvr+O
         8TCZsCQJDyPBXXx9cRr6m4TKRbEAAW9oLiH3ciysEaLkwbmediXJxoygVhZYn76pMOm9
         shq73/nEQRRdFtSKhgVb2BxrXnu1vxM2f5uC8IEgk8+QE/XcpdsO6+kQxtlId7r5blX4
         2WMk219NdbDkNNB7f2O1TdjryEdRUczvnmG7qykg3jmpptdq50syZ11hyRRbJJq2Qsjv
         Q2MCqc2FLlypqiMAFNjJCS1ZXRBq4mqSxek94a7DL3yjFFfgjEsuQVY37xAsGqcv9Ae7
         cEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738893930; x=1739498730;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rnyfeyX5KsaoejFCT4Pvz88fBme+Wvr3R6AqYNdoRSY=;
        b=GEh8zUN36SU6zwDc2YBQnzm2gQD/3DAqW/7VX03YNn9LxvoHTIG7WwOz5x9krFzXVk
         Rb2otqkjrb1M4owCicTqy9piMHjNiHykrW/DVYmAAtXKmeB4jbkiTMc3fTlfne7Z6p3D
         E11K+v0n0MEg9QYV964m2vfPa6lFRkcqjtI6szbPKgms4D9vSBAGzwVB2A7JJYeN4Wg2
         FtouvgH4hMuwiGH9zhu3OMQBnQUkMyzpu+ru3ZFR4MEbBOwAMfY5xpS+fxScfXFY19bN
         j7yfF+XTFeU9zU2yeh+2G/NtPzKZf16XcSnEvvcvg8DNTSt6zNc2YHi84WZAtDBZLuQb
         fDnw==
X-Gm-Message-State: AOJu0YzOoUA9JZADvO3H3nKckU3QF8KUeYisNZ8TJxN9HPzpiU2uilHy
	giNb4lGbW/VPtZvSQXYhvOclMW8HLNd5yH+b/cdIUPDxOCRjYhI8OGP6UFKDTUYfiyEnqHkj8iQ
	/YxerwZtAXfAitM9VLFR7+bFEqBrOFuuoi5Cfgi9RacZv0zl9uDxlOutE+rOyTsVSY20ldpTxf0
	aJTgQ7L8Qq3hFKfdYRya0ye1a20CnibxWEtrNJB1s=
X-Google-Smtp-Source: AGHT+IF7v6kmdiGCxp2a0C++c/LlhPUZNvA/P6MK7nWPEghpqss2oNpv+9B3PTntoS5TGpQxBNw7FSCUTIfdEw==
X-Received: from pjbsl12.prod.google.com ([2002:a17:90b:2e0c:b0:2e2:44f2:9175])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4cd1:b0:2fa:157e:c78e with SMTP id 98e67ed59e1d1-2fa23f5ebb1mr2349911a91.7.1738893930308;
 Thu, 06 Feb 2025 18:05:30 -0800 (PST)
Date: Fri,  7 Feb 2025 02:05:23 +0000
In-Reply-To: <cover.1738888641.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1738888641.git.yepeilin@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <a9eddb6ce44a44bd9c9ea4fb14282b25fcd8c882.1738888641.git.yepeilin@google.com>
Subject: [PATCH bpf-next v2 2/9] bpf/verifier: Factor out check_atomic_rmw()
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Peilin Ye <yepeilin@google.com>, bpf@ietf.org, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, David Vernet <void@manifault.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Yingchi Long <longyingchi24s@ict.ac.cn>, 
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>, 
	Benjamin Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently, check_atomic() only handles atomic read-modify-write (RMW)
instructions.  Since we are planning to introduce other types of atomic
instructions (i.e., atomic load/store), extract the existing RMW
handling logic into its own function named check_atomic_rmw().

Remove the @insn_idx parameter as it is not really necessary.  Use
'env->insn_idx' instead, as in other places in verifier.c.

Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 kernel/bpf/verifier.c | 53 +++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0935b72fe716..39eb990ec003 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7536,28 +7536,12 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 static int save_aux_ptr_type(struct bpf_verifier_env *env, enum bpf_reg_type type,
 			     bool allow_trust_mismatch);
 
-static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_insn *insn)
+static int check_atomic_rmw(struct bpf_verifier_env *env,
+			    struct bpf_insn *insn)
 {
 	int load_reg;
 	int err;
 
-	switch (insn->imm) {
-	case BPF_ADD:
-	case BPF_ADD | BPF_FETCH:
-	case BPF_AND:
-	case BPF_AND | BPF_FETCH:
-	case BPF_OR:
-	case BPF_OR | BPF_FETCH:
-	case BPF_XOR:
-	case BPF_XOR | BPF_FETCH:
-	case BPF_XCHG:
-	case BPF_CMPXCHG:
-		break;
-	default:
-		verbose(env, "BPF_ATOMIC uses invalid atomic opcode %02x\n", insn->imm);
-		return -EINVAL;
-	}
-
 	if (BPF_SIZE(insn->code) != BPF_W && BPF_SIZE(insn->code) != BPF_DW) {
 		verbose(env, "invalid atomic operand size\n");
 		return -EINVAL;
@@ -7619,12 +7603,12 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 	/* Check whether we can read the memory, with second call for fetch
 	 * case to simulate the register fill.
 	 */
-	err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
+	err = check_mem_access(env, env->insn_idx, insn->dst_reg, insn->off,
 			       BPF_SIZE(insn->code), BPF_READ, -1, true, false);
 	if (!err && load_reg >= 0)
-		err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
-				       BPF_SIZE(insn->code), BPF_READ, load_reg,
-				       true, false);
+		err = check_mem_access(env, env->insn_idx, insn->dst_reg,
+				       insn->off, BPF_SIZE(insn->code),
+				       BPF_READ, load_reg, true, false);
 	if (err)
 		return err;
 
@@ -7634,13 +7618,34 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 			return err;
 	}
 	/* Check whether we can write into the same memory. */
-	err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
+	err = check_mem_access(env, env->insn_idx, insn->dst_reg, insn->off,
 			       BPF_SIZE(insn->code), BPF_WRITE, -1, true, false);
 	if (err)
 		return err;
 	return 0;
 }
 
+static int check_atomic(struct bpf_verifier_env *env, struct bpf_insn *insn)
+{
+	switch (insn->imm) {
+	case BPF_ADD:
+	case BPF_ADD | BPF_FETCH:
+	case BPF_AND:
+	case BPF_AND | BPF_FETCH:
+	case BPF_OR:
+	case BPF_OR | BPF_FETCH:
+	case BPF_XOR:
+	case BPF_XOR | BPF_FETCH:
+	case BPF_XCHG:
+	case BPF_CMPXCHG:
+		return check_atomic_rmw(env, insn);
+	default:
+		verbose(env, "BPF_ATOMIC uses invalid atomic opcode %02x\n",
+			insn->imm);
+		return -EINVAL;
+	}
+}
+
 /* When register 'regno' is used to read the stack (either directly or through
  * a helper function) make sure that it's within stack boundary and, depending
  * on the access type and privileges, that all elements of the stack are
@@ -19076,7 +19081,7 @@ static int do_check(struct bpf_verifier_env *env)
 			enum bpf_reg_type dst_reg_type;
 
 			if (BPF_MODE(insn->code) == BPF_ATOMIC) {
-				err = check_atomic(env, env->insn_idx, insn);
+				err = check_atomic(env, insn);
 				if (err)
 					return err;
 				env->insn_idx++;
-- 
2.48.1.502.g6dc24dfdaf-goog


