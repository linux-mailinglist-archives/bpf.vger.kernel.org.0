Return-Path: <bpf+bounces-49746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 866C8A1C06A
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 03:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DB2A7A1A7B
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 02:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605FD204689;
	Sat, 25 Jan 2025 02:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="arEkWCsV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6181FBC97
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 02:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737771504; cv=none; b=C9EloEzGm4w8lupROZESAy4X2xD3ZxiTCjNV5jiSZPyI4aa/VQlwfEMKsESFQZwAMCzjnFjK0X/ynJPtVECJXBr1LRYT7MKMjRYjb8pTrxh1PLrG8w5q5kOqXxnlQUxM9ASaNjhuUp4RX4ggMIYBFhKEwlpsLyQUWw99PhkSOOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737771504; c=relaxed/simple;
	bh=kFoFaLQFjmnNAe/PdLNntt6jCeH0z3LN13BfMuDLEkU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Uj1R9K6C25pLmsVDH9w3l9p0276VNYNgnFO3mJyDyY1KF3n/3UXvnMHxVVItxbbFhdS8Cvtb0UHnbyYrqiMLJPDugRlQxLccrsdQV1XfuF4BzP59EjsThjvCaZKHVIsY0WC+sjB3U3wefs8xSw1A9YoPD8mgg/q02Vlv8YbrK0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=arEkWCsV; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2164fad3792so44524435ad.0
        for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 18:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737771503; x=1738376303; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GIRUjVUPGvvoC/G+tLqvrHi6mwo3DeIvXXHsctD0qOI=;
        b=arEkWCsVzBAGlzri2qR9a5HKAysJjvu54JfOHzxqcupM2ZOBQPBW6zF19AurdEl9Js
         5In+LhSjWuCQjZN5FepkNBHDd50/nDK7M+qgYus5S3Ww5MJvGCJioF+egfSihYvM+KUh
         PfH5IH/aQha8pEhMXEGRvCWv1NpYqXrRrpuMQc+99KPezEVH/tFBfEkUSArMGWUx8yNG
         U63cqx5yo1Oe3MbO3dUEZfMrcNE6pzABB4Z3n+R3TzLZmQ9NTNqGko4+49hH2ev19mqW
         gqAQXDQUDp5c9f82XnVXfQqtb4uX1plntFhI3SDuy9sBfnN9+ar9dDZbIqUbkLdATQIw
         dRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737771503; x=1738376303;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GIRUjVUPGvvoC/G+tLqvrHi6mwo3DeIvXXHsctD0qOI=;
        b=jv2kMwRch1z5GdjgYOk1gTOMD3okius67b5gWlFkgnQb03NiBexPsMzS0kZe6GB5RD
         5tXOq4uQElJSuvQ/kr+NyXhItxGJhkQdiFkPLpK0/TyP/mpTc/1kGe7TeZ2znDvg31Cy
         x9ciRREHm1EGj+Pa93i/G4Zn8nyRXvFXJKb3n4lG30WPicr4xVT5GpiHkrNA/cFiunvR
         463gjrBfCEtHom433gmLjkfwRcPOqRVO/3AWpbfiobtIRryWWgAcviXArIq4UGR3hc+W
         5V+N+y7l+gm5ahbtbTGuURkvA407kAXb8wF8Donkrz9KKVxy3byjsfZmjLJX3hR8xnmA
         xEpA==
X-Gm-Message-State: AOJu0Ywn9gTtchkL0eEgYA29/wSw/6mitsLEv6e+kZ5irszAXcLh4HkE
	cbx9vYWQlZJ0ewjSRsNObbH/TTVttn2kqo0yE10e0WnPRsKkq0I/KjeZ4PiFeW0YY+M5UJVvEaP
	eK08VRp3Er6lN/mDvb3O7u9oZ8bOCOuldi6c3Oup4ekwHTOxi8y1eGJRlzjjiR2As6E+KLm/ebr
	6SdlBx0L9PoPI7p3Jfd8TVrVOnBWrsuwMv8kccS8M=
X-Google-Smtp-Source: AGHT+IHg0VQQH90pQuEfyGGIfiVpVl5OiI/iOGIaKUaWYcp8ziT8hehv5mLQYN4xTkvy2RPykSchBVyc1gr7cw==
X-Received: from plxd18.prod.google.com ([2002:a17:902:ef12:b0:216:5566:3c11])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e751:b0:215:9d29:9724 with SMTP id d9443c01a7336-21c355c6146mr550619555ad.38.1737771502432;
 Fri, 24 Jan 2025 18:18:22 -0800 (PST)
Date: Sat, 25 Jan 2025 02:18:17 +0000
In-Reply-To: <cover.1737763916.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1737763916.git.yepeilin@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <4831a11659532873c20f0c693c248e5cefaddcbf.1737763916.git.yepeilin@google.com>
Subject: [PATCH bpf-next v1 2/8] bpf/verifier: Factor out check_atomic_rmw()
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
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>, 
	Benjamin Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently, check_atomic() only handles atomic read-modify-write (RMW)
instructions.  Since we are planning to introduce other types of atomic
instructions (i.e., atomic load/store), extract the existing RMW
handling logic into its own function named check_atomic_rmw().

Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 kernel/bpf/verifier.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0935b72fe716..2b3caa7549af 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7536,28 +7536,12 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 static int save_aux_ptr_type(struct bpf_verifier_env *env, enum bpf_reg_type type,
 			     bool allow_trust_mismatch);
 
-static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_insn *insn)
+static int check_atomic_rmw(struct bpf_verifier_env *env, int insn_idx,
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
@@ -7641,6 +7625,26 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 	return 0;
 }
 
+static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_insn *insn)
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
+		return check_atomic_rmw(env, insn_idx, insn);
+	default:
+		verbose(env, "BPF_ATOMIC uses invalid atomic opcode %02x\n", insn->imm);
+		return -EINVAL;
+	}
+}
+
 /* When register 'regno' is used to read the stack (either directly or through
  * a helper function) make sure that it's within stack boundary and, depending
  * on the access type and privileges, that all elements of the stack are
-- 
2.48.1.262.g85cc9f2d1e-goog


