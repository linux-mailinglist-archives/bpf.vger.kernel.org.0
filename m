Return-Path: <bpf+bounces-21370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C889E84BFB6
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 23:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 510F21F231B2
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 22:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1D01BDDC;
	Tue,  6 Feb 2024 22:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4N94U0G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F181BC20
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 22:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707257107; cv=none; b=BKenH6lhqeOtnOOOzaBGcrZ8PaMiCtOAAZ8ani2FGP5y0KEacbwobCDcBEBzltC/Hda0prcLaYA921PnZfGn8v49wbzoiJzBoovt+Phsd9505MlUUnyXQzsLw6kuTzyhx4Bj6puHcEsksR43zxu+gHAdUSenavtupr6h9ehuk+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707257107; c=relaxed/simple;
	bh=q/Oh4UGLAUx5nS2repzDRhenYLeGL9xgTdHnvBGVAfw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FKudm6fWh3rYMuGs5qyJMzbc57bp8QZ7Roj94dRASHMaxEWt0caRt2Bu8NQJ7qpJEVOTgoRrHV/LYUivmSPJGkciSfVXTOGCvGuqLhRmCcILFcp4G/FjZ7k2UrFEEeLiePnSTGpgdhCuQp3M+s6N1SiQ/8JDwlxqerWlIklLBNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4N94U0G; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6da6b0eb2d4so12093b3a.1
        for <bpf@vger.kernel.org>; Tue, 06 Feb 2024 14:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707257105; x=1707861905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dj+O15ERlc2oNccgk7u96NynUdtw7IljkhhXG+cbct8=;
        b=E4N94U0GZY5xcnfZ4D00TDphvrkr/tGgJfTZD3z1Rlr4nlF9WShVYUta26B12rbMpS
         8SPjn9AiZhuxjqi4lT/n0qQid7hlyVUz4nd7snylibDtJOh0HkSexlLw+BmeVFoDJspF
         XVUclwkRB3n7Wcu7+XPcrZ1BFtVNwlOuUUvvIm5Ycbhqkk8T07bwzYVulKZSgwdp2sbD
         brXte8dVK8Gtro1r1xb6iXmMnvNnOQ0sDzcNg4+mATRJIWS6RIJBkNTciPfs5V5/h1Yc
         xbgpMCVXmFWZJJESIpcIZYu9/la80wDCBlIHwr0LvOqgAmLg44xM6BbDG4J2MYlHBb/O
         YVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707257105; x=1707861905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dj+O15ERlc2oNccgk7u96NynUdtw7IljkhhXG+cbct8=;
        b=EN7Tv1gWV8fN/AHry5b/ZisRBrPxOCkQHQbY02vJSPKpaVC1azPZQnrOTd1ouKfbiT
         zjV8lQGKs1K9igPhijATsTI14obbmuWRetvUTvu2QOoxxe03VLuuovDQHnGoO3QEFylf
         4furHjaJmXP8JsqKgFknrOgakrRYWpA2DVBLxB3esYD4Hz9gOOSQWqK+GRbxchtT+EjB
         Lpm2bQo70do7I6wWBJnPxtsnTm9sX5weAPsaHsH/oj7Q3DoJ2if+udoVcmPq9bMwwQMS
         mFtdKIVZv6iYSmAg7k4P33KfpNiU+dY5MQJt9usBEwOV8BlNdF2ifFtyE93nqYYNWlVG
         dt4w==
X-Gm-Message-State: AOJu0YztByVlQk5G32LnXGqhbWnAaaizQ1L76HfSLpTu7sSpKRz+klQI
	iluDV82LNEj0ueVZkjp4K4h2s+94zmoRPgKn69kK9TQS7sZmDxMvT8/KOlFs
X-Google-Smtp-Source: AGHT+IF7ufxUlX2aXoymen9Yws0uT15WBLonSQYDvE1rmVUQQKdyNHEjxdlBQPSGpbNEV8D1c9ZwsQ==
X-Received: by 2002:a05:6a21:3a97:b0:19e:a19f:f4de with SMTP id zv23-20020a056a213a9700b0019ea19ff4demr1218529pzb.41.1707257105150;
        Tue, 06 Feb 2024 14:05:05 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXj2AKcZu7kXri6G+OwPqAfvSb7LujQdy2VsFPv9eQ5TTr8zwqyW+OhhQE42K7slkCGEV7sQJxPbSPGLxYy8wHDClhLz9RnrYV7FZ+YKL6xYzjNjxvM+EanhnVJ7dKX24XsaCGCfAiX9N3zPMVgAVfAp5dRizJWf8lYj3JR7V1VJkb1D7jhXy5H1h4GflKBzqGRglGhP2MSRAtPNqQSMMAPaPzrVj0mH2kZaapd1a8eYTmbX1n+M3iNC1d1P9HzYC0d5elXhE2qkBHHLnqX9578jlxiWafpgkAE
Received: from localhost.localdomain ([2620:10d:c090:400::4:27bf])
        by smtp.gmail.com with ESMTPSA id e26-20020aa798da000000b006dd810cdd91sm2519731pfm.88.2024.02.06.14.05.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Feb 2024 14:05:04 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	tj@kernel.org,
	brho@google.com,
	hannes@cmpxchg.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next 05/16] bpf: Disasm support for cast_kern/user instructions.
Date: Tue,  6 Feb 2024 14:04:30 -0800
Message-Id: <20240206220441.38311-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

LLVM generates rX = bpf_cast_kern/_user(rY, address_space) instructions
when pointers in non-zero address space are used by the bpf program.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/uapi/linux/bpf.h       |  5 +++++
 kernel/bpf/disasm.c            | 11 +++++++++++
 tools/include/uapi/linux/bpf.h |  5 +++++
 3 files changed, 21 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index f6648851eae6..3de1581379d4 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1313,6 +1313,11 @@ enum {
  */
 #define BPF_PSEUDO_KFUNC_CALL	2
 
+enum bpf_arena_cast_kinds {
+	BPF_ARENA_CAST_KERN = 1,
+	BPF_ARENA_CAST_USER = 2,
+};
+
 /* flags for BPF_MAP_UPDATE_ELEM command */
 enum {
 	BPF_ANY		= 0, /* create new element or update existing */
diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 49940c26a227..37d9b37b34f7 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -166,6 +166,12 @@ static bool is_movsx(const struct bpf_insn *insn)
 	       (insn->off == 8 || insn->off == 16 || insn->off == 32);
 }
 
+static bool is_arena_cast(const struct bpf_insn *insn)
+{
+	return insn->code == (BPF_ALU64 | BPF_MOV | BPF_X) &&
+		(insn->off == BPF_ARENA_CAST_KERN || insn->off == BPF_ARENA_CAST_USER);
+}
+
 void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 		    const struct bpf_insn *insn,
 		    bool allow_ptr_leaks)
@@ -184,6 +190,11 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 				insn->code, class == BPF_ALU ? 'w' : 'r',
 				insn->dst_reg, class == BPF_ALU ? 'w' : 'r',
 				insn->dst_reg);
+		} else if (is_arena_cast(insn)) {
+			verbose(cbs->private_data, "(%02x) r%d = cast_%s(r%d, %d)\n",
+				insn->code, insn->dst_reg,
+				insn->off == BPF_ARENA_CAST_KERN ? "kern" : "user",
+				insn->src_reg, insn->imm);
 		} else if (BPF_SRC(insn->code) == BPF_X) {
 			verbose(cbs->private_data, "(%02x) %c%d %s %s%c%d\n",
 				insn->code, class == BPF_ALU ? 'w' : 'r',
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index f6648851eae6..3de1581379d4 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1313,6 +1313,11 @@ enum {
  */
 #define BPF_PSEUDO_KFUNC_CALL	2
 
+enum bpf_arena_cast_kinds {
+	BPF_ARENA_CAST_KERN = 1,
+	BPF_ARENA_CAST_USER = 2,
+};
+
 /* flags for BPF_MAP_UPDATE_ELEM command */
 enum {
 	BPF_ANY		= 0, /* create new element or update existing */
-- 
2.34.1


