Return-Path: <bpf+bounces-47818-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 883CDA00292
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 03:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 641F23A15A5
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 02:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24559153BE4;
	Fri,  3 Jan 2025 02:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ikJDigS8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BFE440C
	for <bpf@vger.kernel.org>; Fri,  3 Jan 2025 02:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735869804; cv=none; b=TBhlEi5culJdJkV2ErVADBm2MBBl8WvaUMRRyfKuhvdPYymcNUl/WGOeGMF5rMA2zkBvKbxR39iuuEG5oinE4gPz01lBDsuIWigr6nQYMZPAWKDKQD5OzsgaTOWsrQ/LSYS4xK8/JGk8R2+aYML2QM0V7RtFfDbIr8MgY7UxbQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735869804; c=relaxed/simple;
	bh=7M8KDiGWZcqb4au6OxwB5Xt1yz5IHJ9IJCKzqqw/0wI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=H1bdBP35v9MkMLvK77jcbsGTU1UyL4HkU/7B1eKe/YT0OaRf/kH1JzZ5xpwbzDD7yhudmbdqubXa7XrvJgPBSCEZo1GpSppSnx6PBumkBCXAya+9Q3Xc/WKBKMFbg72LzZ0oGv0xDq4aYgSYvxDAnLtRglM3P/QXvqE2BEsPV3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ikJDigS8; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef909597d9so24543890a91.3
        for <bpf@vger.kernel.org>; Thu, 02 Jan 2025 18:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735869802; x=1736474602; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ig6glpfwApy1o7Mm7Uu+S1mQRfa0XZ6/LLKszoVVhZ4=;
        b=ikJDigS8bBMw7iayY5EbWUCtR3YVpvoXaRR7/IzaUOyg8j8imcpyDoKMqWRavwBNkE
         oayXiBEudvPI2FGSuH/H2gwJId2UPiH3OnN3uO0covVacIJI1U+yz7CKuvQbcVLzoW4/
         3f6qgTXnyBv4iuL9XM+KnBkarETPqrr9JcVTisrNJGWN7WfUc2MM9P/yQXqEAvRLJy3c
         JKuuyJ8DDxQWKx59cOQ6yYNfeEtWDtMFen8YKi0htSpIJgCyOXoRkhm4wHJiiHkg5jr9
         6IeE+YcbBiisBooOENAz7E8kovwKIM2ZwxVVrOaFxxvK97wjHOtETvdvrdp4MlglYxkJ
         GzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735869802; x=1736474602;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ig6glpfwApy1o7Mm7Uu+S1mQRfa0XZ6/LLKszoVVhZ4=;
        b=dVEgPw6Laedmiz4iiDz7Hc9uPHudjI1PPlmE4BlQEH9WVnULAzohEQNlgNxDtYkFx/
         29pQ+AZlb/Q9SSvklWMnMPqv210rpsw6hRQrFGeHbuRBhM4BuuenmhATUnO3MSQNGfoT
         cmAEnn/OHVIlYg2DBW6mDxzrs2l6SPW0MyGRNSYZ9r//MBhlgYPz81TXYK7mA8aBmBkq
         nWF8oawpfqPk+7qPrFOF+O5ZuIxvjKE7ljGCVFU6dAXola2+3pihmo8PexSlTC7Cp9/S
         TwXaQtDVehueQhQjNQh7Lao/9xSgXkxAjHbLyX0xZ3DfzFRZfVENo5zIdzYtiTyIzfhS
         rHgA==
X-Gm-Message-State: AOJu0Yw7te5QjtX7tRyXABN0sHcAAMnRcGFc+bGBv6l2LyTC17TEzCFT
	+KKWXdk34DCeZXp6J+QJREnY8T2W70Aq6uoJWG2fUyu3Rd7VJ8IxdF0SwJkafOLLBhkpXvIAJeI
	mSNm6keMfJQ715aeptKHvtxH2WjnE3p3RzilMXNTtMr2I0k6qT0h+HmJAXHypwwgw3seBF7cXn+
	Y0HeMacklFcK2TgOznZxc955ND8ckVsDbNTNxn8+U=
X-Google-Smtp-Source: AGHT+IEL5evFIYGE70thXWV9wnfSiMcphGKAQ6COYmizEZzma8el/TiuwM5NuPGwXcKyaiMPRwLa0I52lt/X5Q==
X-Received: from pfbct13.prod.google.com ([2002:a05:6a00:f8d:b0:729:69d:93b6])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1944:b0:71d:f4ef:6b3a with SMTP id d2e1a72fcca58-72abdeb6e80mr69465699b3a.21.1735869802431;
 Thu, 02 Jan 2025 18:03:22 -0800 (PST)
Date: Fri,  3 Jan 2025 02:02:53 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <e8520e5503a489e2dea8526077976ae5a0ab1849.1735868489.git.yepeilin@google.com>
Subject: [PATCH bpf-next v2 1/3] bpf, arm64: Simplify if logic in emit_lse_atomic()
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

Delete that unnecessary outer if clause.  No functional change.

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


