Return-Path: <bpf+bounces-31711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C699021CD
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 14:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEA3B1F211CC
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 12:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2919C80BFC;
	Mon, 10 Jun 2024 12:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibEUFlMu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CD280633
	for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 12:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718023361; cv=none; b=DbojX8R7iIstSvYLNwrKRlj41WmZl3KD/9QypQEpblXUdU5ZsWanni0TJVmQSQZh548gPENIwykXbwcjPG02KyM+FcrJw7cTyBnvzub85HNsvg3tKaPMH9I8Eo7RgFuEg0OaihP4W8l4d0Qf53rFhTW8N8RRKwQkhNiyuHQ2Zxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718023361; c=relaxed/simple;
	bh=kqUQlpaIaDNnrdFw6Q+b+9xVWbGOp2eIMpScWPMeJFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgLruO4LLjrCmtoDiVSA8O7EZLve8H6GdVsvLLd4UDfvWpfQ/iyTo/ZpfwVoJkuNjdHYXWqKju79hyGVVbfDi14KWMup4tBuPewXq+kMGo1M76P1h7kFwNXAi2QOw0zuHj4vGprNMszyRk1F5xp1w3pezYwV2x12iCRbYk6dhkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibEUFlMu; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-681ad081695so3252278a12.3
        for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 05:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718023359; x=1718628159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZWjnYHQtTCBKPuAw0CdIGNLHtOZ3VLe66fV6kQYPvs=;
        b=ibEUFlMuMQbMM0F+t8aG45xFin1wTqSOTHvAkRrPU8+0so3pbTR5Cm5XYkObiGEtzs
         kKKerE3X55tpSS5HbpzPaxVuey+yJxZEN6oGplRDSKyknbHFLdS9JUJ4k29TpvMr8QL5
         o83NlLtjWmd10v2orzgH/2q/ZFLZgSTiZG/70fjKzowf0aSUSkpa4dCBEuTp48iDcRRt
         wqHLaXGc9F7Kiy6+WYmo8krrLQbcXzZbJA0K0hGN7T3x4pXdmZm6iuWMji3hn0DCWK7n
         Ib0yS2VrXY0xmV3LMe+EZKI/PaeTPTZcYxDsh5itHpp1/orqN4XTn2X0HTrzUj95BhpY
         9Ecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718023359; x=1718628159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZWjnYHQtTCBKPuAw0CdIGNLHtOZ3VLe66fV6kQYPvs=;
        b=CknopvfYQYMTIWvfXgp56lrvmDw0h4GVbigb9JpcPYspZicosAiZ7wRvngcaih/g9f
         d0zBMbD7zl1SeSeap4Ora+Qew48c8cGKx167vGsiU3Ty4/wR9jkmNap83l8xQPJmq8OR
         6wkL17lfw35iBpcZEomYq6sYiU9BbbCg8rOwAqHF998JW/g0c/ICQUTIRGips7ktt0Go
         4rG+2zRuynMAYlBZ2Y+GYbPogOriIxKzh2ku7qiaMxabHegS8wfKuYlTkxpJpFztxeQM
         3qD++JY3owINKC72IY9f/Wh1RYkBpOn+7PBXTVEpQB3JHiBH2wfFV3JzD5XiuZVYL1mL
         T59g==
X-Gm-Message-State: AOJu0Yx0DQ9SG7YuQDBqK7R5QTapGE/WkCu7fSmo8UAp2tXdZoHlx6dK
	lUq3Bebem5Z8kKaZt/QpTeLoswWnDkHwbiv32SD3J6nvr8aQYRJ20QvcQw==
X-Google-Smtp-Source: AGHT+IH6DDHaL2r2Jmevtw2fhiAafGhTHcsHfvyH3bjnEUddcYjoXs63WsY2tIW+BCc4giGzPIJqvQ==
X-Received: by 2002:a17:902:e752:b0:1f7:234b:4f3d with SMTP id d9443c01a7336-1f7234b8fadmr4568265ad.39.1718023358498;
        Mon, 10 Jun 2024 05:42:38 -0700 (PDT)
Received: from localhost.localdomain (bb116-14-181-187.singnet.com.sg. [116.14.181.187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6d859ea3csm61578855ad.178.2024.06.10.05.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 05:42:38 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	hffilwlqm@gmail.com,
	kernel-patches-bot@fb.com
Subject: [PATCH v2 bpf-next 2/2] bpf, x64: Remove tail call detection
Date: Mon, 10 Jun 2024 20:42:24 +0800
Message-ID: <20240610124224.34673-3-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240610124224.34673-1-hffilwlqm@gmail.com>
References: <20240610124224.34673-1-hffilwlqm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As 'prog->aux->tail_call_reachable' is correct for tail call present,
it's unnecessary to detect tail call in x86 jit.

Therefore, let's remove it.

Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 5159c7a229229..7c130001fbfe7 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1234,13 +1234,11 @@ bool ex_handler_bpf(const struct exception_table_entry *x, struct pt_regs *regs)
 }
 
 static void detect_reg_usage(struct bpf_insn *insn, int insn_cnt,
-			     bool *regs_used, bool *tail_call_seen)
+			     bool *regs_used)
 {
 	int i;
 
 	for (i = 1; i <= insn_cnt; i++, insn++) {
-		if (insn->code == (BPF_JMP | BPF_TAIL_CALL))
-			*tail_call_seen = true;
 		if (insn->dst_reg == BPF_REG_6 || insn->src_reg == BPF_REG_6)
 			regs_used[0] = true;
 		if (insn->dst_reg == BPF_REG_7 || insn->src_reg == BPF_REG_7)
@@ -1324,7 +1322,6 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 	struct bpf_insn *insn = bpf_prog->insnsi;
 	bool callee_regs_used[4] = {};
 	int insn_cnt = bpf_prog->len;
-	bool tail_call_seen = false;
 	bool seen_exit = false;
 	u8 temp[BPF_MAX_INSN_SIZE + BPF_INSN_SAFETY];
 	u64 arena_vm_start, user_vm_start;
@@ -1336,11 +1333,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 	arena_vm_start = bpf_arena_get_kern_vm_start(bpf_prog->aux->arena);
 	user_vm_start = bpf_arena_get_user_vm_start(bpf_prog->aux->arena);
 
-	detect_reg_usage(insn, insn_cnt, callee_regs_used,
-			 &tail_call_seen);
-
-	/* tail call's presence in current prog implies it is reachable */
-	tail_call_reachable |= tail_call_seen;
+	detect_reg_usage(insn, insn_cnt, callee_regs_used);
 
 	emit_prologue(&prog, bpf_prog->aux->stack_depth,
 		      bpf_prog_was_classic(bpf_prog), tail_call_reachable,
-- 
2.44.0


