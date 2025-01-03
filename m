Return-Path: <bpf+bounces-47819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A85A00294
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 03:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD0E43A1D67
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 02:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C011534FB;
	Fri,  3 Jan 2025 02:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PZH1RjQ8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B09C881E
	for <bpf@vger.kernel.org>; Fri,  3 Jan 2025 02:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735869856; cv=none; b=vGsDLD1P3os39MxI3LFCT1hMt+NuecTDO2VtJUNCkzx7ZG67jAFt3++pbLUZZH5jaTl18DJ967/5tPsQW56Ss0wWFMgNcTlc6KTU18QQSpN2EeF1KWON1y+8uZ8vN5th35BWMluiMaxv6erBJmMG4J/AXPXBr552poxGHgR7RnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735869856; c=relaxed/simple;
	bh=ZLiyialT+0DxhDmBYMrB/1yqgRGE7s2UacOAT4wHHxk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eHWLSFZRlQE+IgdbbgLdg5Vj4QIKiaDmO9Bl8Se1rrzytJM4V1vv7MBXA6u5PBrljBrtcbjw3Fud7UJKeg/wKc3pQT8qM8TTRS1tWm9/HGYb1PBEcYl/jPlHc2jQVg1AOsSgOvmyBWv19NRjJVYn6uWwxx1ihsRCZQq1g6C19PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PZH1RjQ8; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef9864e006so24546912a91.2
        for <bpf@vger.kernel.org>; Thu, 02 Jan 2025 18:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735869854; x=1736474654; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CRJO5sUVsBrx9NfUdY8awEzhAYM8yo71RmYXdt5ov18=;
        b=PZH1RjQ85iCrklNzmn/rPVRrv9+VORNsrIWfK15Boh8qEQWbuUKb1d55TOQFvVud8c
         tSpQkWjsSqUjFGzphgjL+wAfXE1hUzF29VyXjdBSFzZbbdWK6nH56m4W4HLQei3BjlVU
         AIqkPAeoY2DEDdVfa6+wHFp9yN241G0p5tbHTr7QHgV50twtEJ8CIEl1sGGuSOf163bl
         Mjdlnz+1v80p9wDM7s5/0F1jouSXJ+a8g/tT4+xPIo39jJq6cVJfFkhD5bcUkc7YHadF
         OWxj7k3Dqf8lKNCKbn6itmKGZkgg/CxCdIv2b6TZQaFq0ZVF25oxRVHRfSwrAKF97n2u
         Z4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735869854; x=1736474654;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CRJO5sUVsBrx9NfUdY8awEzhAYM8yo71RmYXdt5ov18=;
        b=fv4Wdc8wZYqVChEEAvEM7mdIz/ln0GFphOHYtsXokHpnABpqoq9vJR6Sl9lpKxySCI
         AFwjo/TfyolmkXcZVaGlYtN8KYT9mI6AwhKeTKFyUjitFZ5R8sWcajZ0rUoOu/7TwnBp
         Rv7c3Q2VsQQWG4VW3p3iCPYFRwv54mrxbgvXPyLMxcdlnq0f8xh5E4oHlWDnZ5wNlfWQ
         UHfCAcDKrzhDe9n0vXlrNfyvhC4UDkaa0EDql2UQnlFyKxs8YCXOK3FQp+z1rpiDZpIg
         p70qpWbRMAFuNmsdUqB1wBAczHs899Q6q0/giw2eKDQXZ5AbfJCv1Vg8b4An7QkP3Wpp
         1w2Q==
X-Gm-Message-State: AOJu0Yxo6qP/09YK89651Tn+3fY5dztSJbi4ypUfuPGGwdEbsBK2LDor
	n24pFtByOk4myPLe1eqeCCfNfBlyx1d+mWVPw3SLysjpYz7K9ySTVnA+ins31nmqUiG5eD6yrhh
	BCOVxA6MqLShhGVUeT4e/v/TYTAORxRL+XmycdDpmqhSjXJofC8NJhWwBnRH7Ym+CgQg3VeaB0X
	p8LzTeocQypg4l6aTWQvA4U8qj4DePFdCo5BlvPvk=
X-Google-Smtp-Source: AGHT+IHZadCFsRAvM/8s8XCvSBmeC0l850mBUK5zckCFiZPbJN2N7ovFIIHdSAEoiRRH/qyjjHZNBrMLvPsyVA==
X-Received: from pjbsm15.prod.google.com ([2002:a17:90b:2e4f:b0:2ea:9d23:79a0])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:50c7:b0:2ee:d96a:5831 with SMTP id 98e67ed59e1d1-2f452ec713fmr73098024a91.30.1735869854278;
 Thu, 02 Jan 2025 18:04:14 -0800 (PST)
Date: Fri,  3 Jan 2025 02:03:42 +0000
In-Reply-To: <e8520e5503a489e2dea8526077976ae5a0ab1849.1735868489.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <e8520e5503a489e2dea8526077976ae5a0ab1849.1735868489.git.yepeilin@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <fedbaca80e6d8bd5bcba1ac5320dfbbdab14472e.1735868489.git.yepeilin@google.com>
Subject: [PATCH bpf-next v2 2/3] bpf, arm64: Factor out emit_a64_add_i()
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org
Cc: Peilin Ye <yepeilin@google.com>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Josh Don <joshdon@google.com>, 
	Barret Rhoden <brho@google.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

As suggested by Xu, factor out emit_a64_add_i() for later use.  No
functional change.

Suggested-by: Xu Kuohai <xukuohai@huaweicloud.com>
Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 arch/arm64/net/bpf_jit_comp.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 9040033eb1ea..8ee9528d8795 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -267,6 +267,19 @@ static bool is_addsub_imm(u32 imm)
 	return !(imm & ~0xfff) || !(imm & ~0xfff000);
 }
 
+static inline void emit_a64_add_i(const bool is64, const int dst, const int src,
+				  const int tmp, const s32 imm, struct jit_ctx *ctx)
+{
+	if (is_addsub_imm(imm)) {
+		emit(A64_ADD_I(is64, dst, src, imm), ctx);
+	} else if (is_addsub_imm(-imm)) {
+		emit(A64_SUB_I(is64, dst, src, -imm), ctx);
+	} else {
+		emit_a64_mov_i(is64, tmp, imm, ctx);
+		emit(A64_ADD(is64, dst, src, tmp), ctx);
+	}
+}
+
 /*
  * There are 3 types of AArch64 LDR/STR (immediate) instruction:
  * Post-index, Pre-index, Unsigned offset.
@@ -1144,14 +1157,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	/* dst = dst OP imm */
 	case BPF_ALU | BPF_ADD | BPF_K:
 	case BPF_ALU64 | BPF_ADD | BPF_K:
-		if (is_addsub_imm(imm)) {
-			emit(A64_ADD_I(is64, dst, dst, imm), ctx);
-		} else if (is_addsub_imm(-imm)) {
-			emit(A64_SUB_I(is64, dst, dst, -imm), ctx);
-		} else {
-			emit_a64_mov_i(is64, tmp, imm, ctx);
-			emit(A64_ADD(is64, dst, dst, tmp), ctx);
-		}
+		emit_a64_add_i(is64, dst, dst, tmp, imm, ctx);
 		break;
 	case BPF_ALU | BPF_SUB | BPF_K:
 	case BPF_ALU64 | BPF_SUB | BPF_K:
-- 
2.47.1.613.gc27f4b7a9f-goog


