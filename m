Return-Path: <bpf+bounces-68559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F97CB5A44B
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 23:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 29A1F4E252A
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 21:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E253131FEE4;
	Tue, 16 Sep 2025 21:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ri3QQ6nh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47308287515;
	Tue, 16 Sep 2025 21:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758059613; cv=none; b=OhpLVahuZnQ9enlvDP3NoKQvxjy/dYasuL15EcGIPj6+TOvxwnsnIMFfu3GjS2B60XQYKMelcmIiBRMlpiIKH5X2rvjKw7IulecEr60tm4WmFBaDnPrJvEFQ1wvrMm+YC+hvB3aT0AjvaYNhKYxC+DzcqA46yPgGO39+k9V+EXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758059613; c=relaxed/simple;
	bh=8EBfcHDmTJFDZsBygObtTJtulBbopVoDqDbqo+5ESa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e7V+nfr9DJaAH9kX9H21z/ZYw78Dj4a2xzPGqUbxafwFzccefcAHpJX/1zi7Drp+w0wvRj2oAB9sOffptkCX54IWmvJBdVISjb3kZ7VnZ7ycRgOSz0QYRX5bl5gEt0KJ8VVBQ1R6nVWILP7fKtV+GkCGxrAr0ob3V+p2Ep1IscY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ri3QQ6nh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B797C4CEEB;
	Tue, 16 Sep 2025 21:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758059613;
	bh=8EBfcHDmTJFDZsBygObtTJtulBbopVoDqDbqo+5ESa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ri3QQ6nhvmJEwpnvPOPZc8uvbaygQDRheWlfvpiX/RKTMZWhfYXIGbRIu2D98VFXy
	 VfmQkhFXSaOoYRBNsJB3Ll8+F6JwU1J43TEOknrEwnUOAhN1ssFRrxnZZbbt0znGQv
	 P9e8Yvj6CT1kXLi6wWJ5EWnYFFutH5mY/EkZp0d5kFfNtA4F8G44/ymeGd8xbaz9ma
	 sU+z9Wz2Y7dp3y3dzi2HeRJRo3jS1+/jNxZ9N6oHW9jQkKmLOyskjQ1BxTC3fF2M+F
	 UiPoM6WU4w+X8+xAKlUYqaCR9fEdVk04537KZWLoc+Xgy92X3RXz9SNsO4XoYZB26T
	 tB+mIHJ97rr8Q==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCHv4 bpf-next 2/6] uprobe: Do not emulate/sstep original instruction when ip is changed
Date: Tue, 16 Sep 2025 23:52:57 +0200
Message-ID: <20250916215301.664963-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916215301.664963-1-jolsa@kernel.org>
References: <20250916215301.664963-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If uprobe handler changes instruction pointer we still execute single
step) or emulate the original instruction and increment the (new) ip
with its length.

This makes the new instruction pointer bogus and application will
likely crash on illegal instruction execution.

If user decided to take execution elsewhere, it makes little sense
to execute the original instruction, so let's skip it.

Acked-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/events/uprobes.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 7ca1940607bd..2b32c32bcb77 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2741,6 +2741,13 @@ static void handle_swbp(struct pt_regs *regs)
 
 	handler_chain(uprobe, regs);
 
+	/*
+	 * If user decided to take execution elsewhere, it makes little sense
+	 * to execute the original instruction, so let's skip it.
+	 */
+	if (instruction_pointer(regs) != bp_vaddr)
+		goto out;
+
 	if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
 		goto out;
 
-- 
2.51.0


