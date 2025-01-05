Return-Path: <bpf+bounces-47887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC5EA0196A
	for <lists+bpf@lfdr.de>; Sun,  5 Jan 2025 13:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5B1818835F7
	for <lists+bpf@lfdr.de>; Sun,  5 Jan 2025 12:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0401014D430;
	Sun,  5 Jan 2025 12:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbrvpAaf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2089279CD;
	Sun,  5 Jan 2025 12:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736081062; cv=none; b=lyGRiEOoH9mXopsE7kS3BfoYEdEynlYTfFAD9PIusd/M9A+68vxtXuROxF/tg0QL556HYjmjANEDS+WuWnaeutHGvlmAR3OOHt0pzKDgdBS+9HN4lHjGIdqUAWkgzrei/DAQVHP0kFak3BKCODmmCQorko1aHnY5kAJYt4zEzwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736081062; c=relaxed/simple;
	bh=JLw7uV0JbAZfgDWMmFuixCD7mh21ZX2rx29xHALj1/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MSEjy0GzYDFD3BqRcejhSlHT42eqlNPNjBKM0sbUlhq7HZ7wzO73Y/HgKVZfWKS7ADp6/AS9U2JpGYcHxUxc1KcnysG/GpFk+AjBWBpIk+Um9y1qEZmVlXFTRpRvjBUIzPcWzOUZVjEdyLnkWX0JSQy4FC08++f73L8xqpyj2P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbrvpAaf; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21661be2c2dso174175845ad.1;
        Sun, 05 Jan 2025 04:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736081060; x=1736685860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lG88WZIPSHZ6QO09rXUqBTvDvvz/gCsLU+eJpTxo/8k=;
        b=GbrvpAafT4gXRzecPgBs4Emazeq6FUxx5HJcg1Cy01EokNpyxgqlBrYvsHHVUixwNr
         rjKKEtA/4x4TxQTpuua9Y5SFax0zxJ2GuhR0Tms1HgL7C6wzJIWfj925JNU4vbDoVF5U
         DZGpOY2wS2xVXIlULpFShn1cje7AVSXqnSMc3b52Gjw/8xTkMBYG62oqh4sDOoAFFRo2
         tvG3dRnXeirfLKmLJPUqzq9GG0lRfWldS/1ZoRT/Ps8xqIiVL1blUspp1Sf0gZKZ9Ba3
         DDl+AwH5uEAlqnCyuSOXcrHT0gtuFQqKBNCI6j7get44rSEz0svsjhpOSImAE+R4MLbh
         4IRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736081060; x=1736685860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lG88WZIPSHZ6QO09rXUqBTvDvvz/gCsLU+eJpTxo/8k=;
        b=mIMy/tF/eYhri9/uabHs4o2dZUjsScLuNxc48gx5X0ty0jxbEZU4stY5XMpfp99HER
         fXY007AtgvGhd8hTnvgjcFdBXOPWrcC2EjC/s5fCIsvJ3X3qXdJL8zYKfyf9agphYw2/
         VPq8KwJltOPYTvCWthx8JcFFDriovqGp3a7cS8DkSTz5ll1d3Uch/pFCjnxQWzgYHBdC
         kwqUqjTzOB134iTqwD9CUckUJKv4Q2OuWMN9M0IBZUrEjqwGdRMdRd1tjHQ5xWFlQl+S
         tbOxTXn8KnIFDp7tDyFjPGU25CdPp36PwjXIgkeDHUXdVuGdMoMmXtUzFMmTyjkZFA14
         oeyg==
X-Forwarded-Encrypted: i=1; AJvYcCW6ML2FsrWd7e1nLvGRd7C/QD+2G8jxDtfGwYBE/0HwfIr/uNcVHwMA2NhIac97j8iR4ORpd+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJoUR+JT0knoRC9ngFRcng8EgtDy4DrY8mzz9/KEqkC47h6q5a
	wQxsGHj0jxKKoJALHS7kZwFpWl+wQceAi+zT2+DdEb34N0vEXjq2
X-Gm-Gg: ASbGncvLvbvJiRnAcermFL+qjLM0Cc7OPkcSiQmzMRIkxN2Qy64OGO7SnVQTnXsScvd
	gAOTcGpApIvZcywX0s3g4tyzgDGTbsDcZxfedsCv7duxKYn5afaAsHE3yhypXlnB2o+54t/Hy9m
	8Uuyo01ATuzocc4YR6kMNnxoJEGGUE5Thbp47zVh8vbOwr9CppFjC7cWYSLoA3nOBv7mTySQGrs
	mLScARhxUKuaQhnN8Fg8ksQ9286UcgmeJPAejFIQly5uo2c4NQtWgDagdWYTJ2wlO2iUAXNz7Nt
	+1DSrco=
X-Google-Smtp-Source: AGHT+IFeFMPrmyEnIw5rB97Uqz6iwg5XnUbho9bZbv7cdNos65f/i0cuqvKY4fT27h4cSGVKoMRu1w==
X-Received: by 2002:a17:902:cf12:b0:215:a2e2:53ff with SMTP id d9443c01a7336-219e6e85cc3mr818179535ad.11.1736081060157;
        Sun, 05 Jan 2025 04:44:20 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca01415sm275427215ad.231.2025.01.05.04.44.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 05 Jan 2025 04:44:19 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	edumazet@google.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 1/2] libbpf: Add support for dynamic tracepoint
Date: Sun,  5 Jan 2025 20:44:02 +0800
Message-Id: <20250105124403.991-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250105124403.991-1-laoar.shao@gmail.com>
References: <20250105124403.991-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dynamic tracepoints can be created using debugfs. For example:

   echo 'p:myprobe kernel_clone args' >> /sys/kernel/debug/tracing/kprobe_events

This command creates a new tracepoint under debugfs:

  $ ls /sys/kernel/debug/tracing/events/kprobes/myprobe/
  enable  filter  format  hist  id  trigger

Although this dynamic tracepoint appears as a tracepoint, it is internally
implemented as a kprobe. However, it must be attached as a tracepoint to
function correctly in certain contexts.

This update adds support in libbpf for handling such tracepoints,
simplifying their usage and integration in BPF workflows.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/lib/bpf/libbpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 66173ddb5a2d..077bec761ebf 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9504,6 +9504,7 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("struct_ops.s+",	STRUCT_OPS, 0, SEC_SLEEPABLE),
 	SEC_DEF("sk_lookup",		SK_LOOKUP, BPF_SK_LOOKUP, SEC_ATTACHABLE),
 	SEC_DEF("netfilter",		NETFILTER, BPF_NETFILTER, SEC_NONE),
+	SEC_DEF("dynamic_tp+",          KPROBE, 0, SEC_NONE, attach_tp),
 };
 
 int libbpf_register_prog_handler(const char *sec,
@@ -12500,6 +12501,8 @@ static int attach_tp(const struct bpf_program *prog, long cookie, struct bpf_lin
 	/* extract "tp/<category>/<name>" or "tracepoint/<category>/<name>" */
 	if (str_has_pfx(prog->sec_name, "tp/"))
 		tp_cat = sec_name + sizeof("tp/") - 1;
+	else if (str_has_pfx(prog->sec_name, "dynamic_tp/"))
+		tp_cat = sec_name + sizeof("dynamic_tp/") - 1;
 	else
 		tp_cat = sec_name + sizeof("tracepoint/") - 1;
 	tp_name = strchr(tp_cat, '/');
-- 
2.43.5


