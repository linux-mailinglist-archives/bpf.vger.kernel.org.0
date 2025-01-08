Return-Path: <bpf+bounces-48308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EBBA067FF
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 23:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 196F87A1341
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 22:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECF82040B0;
	Wed,  8 Jan 2025 22:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=longjmp.de header.i=@longjmp.de header.b="rAZS1qfX"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10256202F97;
	Wed,  8 Jan 2025 22:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736374245; cv=none; b=KzJY+AxGeCjHm0rvbp9f0yawBhLL8nthps07lpwhUbhQ4fhFsPse1N8MIHsRfaV99H48AUXfoPOYga20c/nzkO/0WloYonikbgvSdm0n/GeOz6IJqwbMy5r2D6yRyXDzXEZOy16oJM+SUu+iu32DknpmSU7bIoaXhdHRTEryj1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736374245; c=relaxed/simple;
	bh=WwVEHWuKzEahLQi79q6dgZiumbtFJ8+5RiaKpvoTc6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VNliqxnE3J/uhByAZ19MFoDKBVZKdXxrBakvtjZcthNLVmZjLFYrUKmWKxMJrC5W8QwqB2c0brTzbclS9w3p43bBBuBRiomji3ypVAAoyjFOzBfuzAC7khk9KkCC55QB020dIfStSSYsra14zc0XmWNOtSdf9KzXJ+N62FNYlWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=longjmp.de; spf=pass smtp.mailfrom=longjmp.de; dkim=pass (2048-bit key) header.d=longjmp.de header.i=@longjmp.de header.b=rAZS1qfX; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=longjmp.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=longjmp.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4YT2D81Fldz9sQ6;
	Wed,  8 Jan 2025 23:10:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=longjmp.de; s=MBO0001;
	t=1736374232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=606o3fBHoXBQZM3NgPeAJyyHdT5pOFGET3otxLrYmRQ=;
	b=rAZS1qfX1XjbAgYpL/G0HI6JiI+xzzJVzNnQ9xVM5Lga5ezPmZ6gfHV0FL0VvRz4E6sElG
	6lRAgYzwGuX9rbGeXoTrr9FZWszLpZQX1WqYmPVRvjg24lBGePx/44lFPqORrqTst/f2za
	McQPdhhvNA8Lzrw6KtLI9laH0ggqCy8jkBKbpxgbEYKOyyujXhhdZ7ZtPrGUOKoImZcG2r
	Kj/DeXm5LbUF3yBAzWpZbmyUOAa+wKwFcIyxgqph2gg9LuvG8sOc1SqXs+FElD1BaaZe8w
	adt3zdSfICCsq79fFTsu04E4xQaTq0eB4SVz7qc7cTF7eA/gXfz/tN6zs/vYZA==
From: Christoph Werle <christoph.werle@longjmp.de>
To: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Christoph Werle <christoph.werle@longjmp.de>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bpftool: fix control flow graph segfault during edge creation
Date: Wed,  8 Jan 2025 23:09:37 +0100
Message-ID: <20250108220937.1470029-1-christoph.werle@longjmp.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4YT2D81Fldz9sQ6

If the last instruction of a control flow graph building block is a
BPF_CALL, an incorrect edge with e->dst set to NULL is created and
results in a segfault during graph output.

Ensure that BPF_CALL as last instruction of a building block is handled
correctly and only generates a single edge unlike actual BPF_JUMP*
instructions.

Signed-off-by: Christoph Werle <christoph.werle@longjmp.de>
---
 tools/bpf/bpftool/cfg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/bpftool/cfg.c b/tools/bpf/bpftool/cfg.c
index eec437cca2ea..e3785f9a697d 100644
--- a/tools/bpf/bpftool/cfg.c
+++ b/tools/bpf/bpftool/cfg.c
@@ -302,6 +302,7 @@ static bool func_add_bb_edges(struct func_node *func)
 
 		insn = bb->tail;
 		if (!is_jmp_insn(insn->code) ||
+		    BPF_OP(insn->code) == BPF_CALL ||
 		    BPF_OP(insn->code) == BPF_EXIT) {
 			e->dst = bb_next(bb);
 			e->flags |= EDGE_FLAG_FALLTHROUGH;
-- 
2.43.0


