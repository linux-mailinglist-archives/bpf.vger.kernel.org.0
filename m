Return-Path: <bpf+bounces-54314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1A6A67661
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 15:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93D7C3B3218
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 14:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FB120E31B;
	Tue, 18 Mar 2025 14:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="XR1stPQH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE6320E016
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 14:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308196; cv=none; b=VP1DhAYZJ7cYJKvuqRMdidkP5vD3LI1GBMdi7hewslMQXZh6mMqIHf1otvFtBflBiB/ScEOFHa6bnSZN4gaPcP8GeSv082C32X3wp/bPLlHiKbhXYSW9HVHDWrAcYNfTzjLx+YrnMuVwEr3fs9nOKgujunuUytXvQyO08kdbdL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308196; c=relaxed/simple;
	bh=rmL46f/Xg8CEGsbrFbksCNzROXEsR69txJtpeQ+NxWs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G3JgVP72duFF8iknrQNZf472cetCed9i133TsIx5doOx6QWbv4BCT357OlIXN4KgPJXSoG7KlY4a1P83EPE3MTgIiMg66Yj8DtaLyfP6rdh8vTYDHLoV0LlRBvYk3K18HGdEaM2gIj7hRpkSif9w1oSz3xy56wf7mc8AfFyOhkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=XR1stPQH; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39127512371so3448350f8f.0
        for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 07:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1742308191; x=1742912991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AXSWhjbqNBEpN4xJopWj8BDR0KIUeaVxyGaDWxfQKDs=;
        b=XR1stPQHwYdgAsTKJwrlE2jcAAMzEE2F1j+dqmTBHZZKHsukbZzfOH5ssCWi5Chlip
         PcJ4qiUj/oE+UGZgNuQGO47npRArEIohPoyNXVjWM82yPR74eZpfPNxc5LzVq2Uo57js
         x0Up+hRG1JBFlbRibaoPa8s3RSFMsAIx+PdyVIeQFomFQH02fkgA6WzO7JrT1hsO+dle
         B/dOtQy4EfhBqsxBVT3ypchjsNPJjL1FAn3jcx88s+O7ekQweFEkIwRq/oU2qUpDaGlZ
         0YTxcrQQ5aoq8Zm04YU1ojMR1oQmkmvs4HiJJN9QUfTh0litnOdHIIiuasp+Lsa9Q0Zf
         39dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742308191; x=1742912991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AXSWhjbqNBEpN4xJopWj8BDR0KIUeaVxyGaDWxfQKDs=;
        b=mT6jsH3XqL9zg+lx1fhuxin89WJMHN361WGNg34PQfyqP0mO9wvCpZFuoYxiwLz9ba
         qxP0yVsWHqKr4R6WhY8AiVxgImS5dNXAwYvJOUsmE9Xv93RIbgMUO4Ni/32fr17WRGa3
         /1bGBBaKoD3n4FsCjo9HUKD62qKg1jde7M7TE4OgbKnXNHnoxgY0Cr7h7WmvjKQTmXM9
         6CXU/cWuY841l5Mmx23Kg19pfR80DWpN+8EyjXAj8Ur+Zb3SyONVba5K1JjFO5pmBBhl
         ZqqZU3m6t/532KkeQMNy8x94CndVwAxVOVI/X1Xl8jxdj2ePd1Xyb2QGjG+ixuJgIkPw
         DJwg==
X-Gm-Message-State: AOJu0YwvCtdKy6mTPr0do9kn8YmiL/M97661N1ADIhxENtdLqqSk4VeR
	Bku1aUibgCQ8hagFVjovdQJ2BqhrNM9iYaUvt3C96tiYgJhaGvC5PirmkKDXP1rfDkrx09F1F6z
	N
X-Gm-Gg: ASbGncusKvapMzugJJoZTSVWgrRauROoaM24PPLhJPD9ODYPkKHoIAEJ4k9NPjXKvu0
	otZ/Z2P8ez0zPp5kPuPeabuP/qCTgV3Ro3EgjsuqOcjOmLiOS+zVz5rQsVCa2imdJhzV344duqL
	udSUQSdZeHyR1XQpPsgiPczd1Gr7cJRPL3Ph4SF4J8Ks+Vx8+PG7dipYYOBRS4Kajv4kHCSfArc
	mTanMC3ulNmCUkco3f3mmsp6L50ZHOOii8tYun4GL4e27o/UPLzhBogg7LL6s0/g+/lmYMbIqyQ
	62C1fH9Ul2U/TRTOtkgxMNgPeuctYOHybeRqFGH2w0XCMGB4q/nvpM/M3w==
X-Google-Smtp-Source: AGHT+IGwIG8zE8PxYO4XCN6eo5w7AGElzuLs0djfBgqz4sQEYR7sFJ4Hkz7mqJjXKlmPh6s+x3Ejhg==
X-Received: by 2002:a05:6000:1a88:b0:391:300f:749e with SMTP id ffacd0b85a97d-3971d2344d8mr17003898f8f.11.1742308190940;
        Tue, 18 Mar 2025 07:29:50 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cdd0sm18348071f8f.77.2025.03.18.07.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 07:29:50 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [RFC PATCH bpf-next 05/14] bpf: Add kernel/bpftool asm support for new instructions
Date: Tue, 18 Mar 2025 14:33:09 +0000
Message-Id: <20250318143318.656785-6-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318143318.656785-1-aspsk@isovalent.com>
References: <20250318143318.656785-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add asm support for new JA* instructions so kernel verifier and bpftool
xlated insn dumps can have proper asm syntax.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 kernel/bpf/disasm.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 20883c6b1546..fd6e0e85412a 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -183,6 +183,30 @@ static inline bool is_mov_percpu_addr(const struct bpf_insn *insn)
 	return insn->code == (BPF_ALU64 | BPF_MOV | BPF_X) && insn->off == BPF_ADDR_PERCPU;
 }
 
+static void print_bpf_ja_insn(bpf_insn_print_t verbose,
+			      void *private_data,
+			      const struct bpf_insn *insn)
+{
+	bool jmp32 = insn->code == (BPF_JMP32 | BPF_JA);
+	int off = jmp32 ? insn->imm : insn->off;
+	const char *suffix = jmp32 ? "l" : "";
+	char op[16];
+
+	switch (insn->src_reg & BPF_STATIC_BRANCH_MASK) {
+	case BPF_STATIC_BRANCH_JA:
+		snprintf(op, sizeof(op), "goto%s_or_nop", suffix);
+		break;
+	case BPF_STATIC_BRANCH_JA | BPF_STATIC_BRANCH_NOP:
+		snprintf(op, sizeof(op), "nop_or_goto%s", suffix);
+		break;
+	default:
+		snprintf(op, sizeof(op), "goto%s", suffix);
+		break;
+	}
+
+	verbose(private_data, "(%02x) %s pc%+d\n", insn->code, op, off);
+}
+
 void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 		    const struct bpf_insn *insn,
 		    bool allow_ptr_leaks)
@@ -355,16 +379,13 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 							tmp, sizeof(tmp)),
 					insn->imm);
 			}
-		} else if (insn->code == (BPF_JMP | BPF_JA)) {
-			verbose(cbs->private_data, "(%02x) goto pc%+d\n",
-				insn->code, insn->off);
+		} else if (insn->code == (BPF_JMP | BPF_JA) ||
+			   insn->code == (BPF_JMP32 | BPF_JA)) {
+			print_bpf_ja_insn(verbose, cbs->private_data, insn);
 		} else if (insn->code == (BPF_JMP | BPF_JCOND) &&
 			   insn->src_reg == BPF_MAY_GOTO) {
 			verbose(cbs->private_data, "(%02x) may_goto pc%+d\n",
 				insn->code, insn->off);
-		} else if (insn->code == (BPF_JMP32 | BPF_JA)) {
-			verbose(cbs->private_data, "(%02x) gotol pc%+d\n",
-				insn->code, insn->imm);
 		} else if (insn->code == (BPF_JMP | BPF_EXIT)) {
 			verbose(cbs->private_data, "(%02x) exit\n", insn->code);
 		} else if (BPF_SRC(insn->code) == BPF_X) {
-- 
2.34.1


