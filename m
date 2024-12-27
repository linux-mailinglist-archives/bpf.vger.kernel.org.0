Return-Path: <bpf+bounces-47678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A82AF9FD850
	for <lists+bpf@lfdr.de>; Sat, 28 Dec 2024 00:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 941733A2583
	for <lists+bpf@lfdr.de>; Fri, 27 Dec 2024 23:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40981158D96;
	Fri, 27 Dec 2024 23:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B9PPhQkb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EE814A62A
	for <bpf@vger.kernel.org>; Fri, 27 Dec 2024 23:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735342570; cv=none; b=NNdji3AOajALtAmifRK23pa4cDYgX865KNIO+LTfZzOaTyh4hVAMrrsR5j1KU8pf2SmKO4LfyEyw7Pd0+nj300HYPbX9dY1lKiOzN0IkztWROk/DCVGipbrLqbtRKb7LZcxrzKtm+ZuURQ+kjO/khh8+LvUQV48O949LVmzy2+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735342570; c=relaxed/simple;
	bh=zj9QD3cmZP02xldwZjs7upJ7C/GGh59eo6541tM3L70=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fJzzgH14NjVj5QQ/1WGp8+E1zoC1Dyq+vOPy6oEkF0dHxSGXRuYaWieJw90tgtI9v1NrkVEBMADnwXFTTzW4fTEeyTICIpOVd2Z0uo4x0TWUCijlBjo6kbQLZ5PeSXb/tpw5WPOjfnE97IP1VhDB5ArD0aY7WMwsvn5kGf7BBg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B9PPhQkb; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ee86953aeaso9722615a91.2
        for <bpf@vger.kernel.org>; Fri, 27 Dec 2024 15:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735342569; x=1735947369; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U1cvaO69byw0nGHFeA9yilXkgu6gKVdyllDmswCVIx8=;
        b=B9PPhQkbz369xUZxOSgkCy2UMIZwlqqRshl+qG+3lwnrcQqXamg8xeUAmsXR+QZ+7Z
         2iGNnwNqngBrd9EaOLxF8d3QMj8jsN9iS9bimeYi1Nd5I5p1lM8hK3ca5wVS7RXW0eQR
         ZF/jWQPLPJri54m2lTO6pEWC7kYmodmb0//zyzP4yscWsaLUWJx+MVj5cBmjSX8EfooZ
         2+fcSgZNI7iKm4CS81fMybEKls/dixaWAmPp6AJIZmMjoRN5JmMwl0u2tTTD46ult1Go
         E12/AYWIlsGfDpPQQuB/r/YU5oOML/J4wOlLHltuvPxejsGBIDu0iByStDhrniitbtce
         jIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735342569; x=1735947369;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U1cvaO69byw0nGHFeA9yilXkgu6gKVdyllDmswCVIx8=;
        b=bxKo66WHXuOBYB55kkp2gNkG+0oNn7kyQocmEvAkHsvrWg1yLD8KTorzr8yQ6uUwBE
         Lp5IWXUCknwvR4N9y+TXIzHZH8vMBP8jpFxLEHIej0gjYUWv29RvaZkOcDadCdzZpYBL
         PhyhLbHM7V9dGWIExhNmwg1t47+U3+brj1WmGLbNh2ymQjSm8hudEos9GXTjlEeMoMT/
         3dW7/hP65NavIdovKYAD/x4JIJCe9fXfcsR8t7Jyp4/oLpFO7CCRTP6eir2YXt/rxNxo
         jXwSS02cOkFKWbSmP9BLk4WdjgTffQZYKxsf5cTdTWwe5I0uuge3urh8QQHHB7jadukb
         oaxQ==
X-Gm-Message-State: AOJu0YxjsHgPM3vCI22ZsgSh0uW/wZTGh8v5lSI71ZTHPOTnlpMowNuc
	mMlC+mZZU2+mFAUhIXoz/0er5MVNYDp5GAMncftkGCt1brY6+NWOWaXshyHlPUBhNlzcGKum2l3
	/KipDGjMoq4zncfO7b93qeqQcNsiC5pcAmTHRQvmvLtD3oGBkTq07vOqfWnpnlvgbGdJeopW2IB
	Slz49ECD8zsWHX8iAy2boxHOMHDtahA+uJFLqJY7M=
X-Google-Smtp-Source: AGHT+IFuJUZ9jsTKQSDCXDTwgQyNyL9rJWt4gk6hZ4XtzDy2D3InD9OFNgdY2aj5V6x5Yf9TAhT2yfJZ4RY9nQ==
X-Received: from pjbsw12.prod.google.com ([2002:a17:90b:2c8c:b0:2ef:82c0:cb8d])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:270d:b0:2ee:dd9b:e3e8 with SMTP id 98e67ed59e1d1-2f452dfd3b6mr46753319a91.8.1735342568743;
 Fri, 27 Dec 2024 15:36:08 -0800 (PST)
Date: Fri, 27 Dec 2024 23:35:46 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <3b84fa17ab72f3f69e09e0032452d17eb13b80db.1735342016.git.yepeilin@google.com>
Subject: [PATCH bpf-next 1/2] bpf, arm64: Simplify if logic in emit_lse_atomic()
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

Delete that unnecessary outer if clause.  No functional changes.

Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 arch/arm64/net/bpf_jit_comp.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 66708b95493a..9040033eb1ea 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -648,16 +648,14 @@ static int emit_lse_atomic(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	const s16 off = insn->off;
 	u8 reg = dst;
 
-	if (off || arena) {
-		if (off) {
-			emit_a64_mov_i(1, tmp, off, ctx);
-			emit(A64_ADD(1, tmp, tmp, dst), ctx);
-			reg = tmp;
-		}
-		if (arena) {
-			emit(A64_ADD(1, tmp, reg, arena_vm_base), ctx);
-			reg = tmp;
-		}
+	if (off) {
+		emit_a64_mov_i(1, tmp, off, ctx);
+		emit(A64_ADD(1, tmp, tmp, dst), ctx);
+		reg = tmp;
+	}
+	if (arena) {
+		emit(A64_ADD(1, tmp, reg, arena_vm_base), ctx);
+		reg = tmp;
 	}
 
 	switch (insn->imm) {
-- 
2.47.1.613.gc27f4b7a9f-goog


