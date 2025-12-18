Return-Path: <bpf+bounces-76994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4C9CCC59E
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 15:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA3923032FF6
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 14:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B251330B08;
	Thu, 18 Dec 2025 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+PcNlRe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBD4246768
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766069730; cv=none; b=LRPoTkVgoSl2rMeJBNBIkvhRW3cqRZc61Srn08KiFB3kwzLMDIdeOGlFlTtGaw2Bh3gSra/viNFFaiACoTzlHV9c5cWDK0PMpuCsDQYvC/o4xUTRsChzBLhCFCWxaW48ABTiYm1A1tJaZf1AC7kxrkWOmRiJK7tPeD9FMDq1OkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766069730; c=relaxed/simple;
	bh=cx33bmzxXszIejBxrTvJOwS1Z0VaEt6LoikK3IxdywY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KujQwWmRzPr1j33G3nG70di5qTfeId3VgUxUDF517Q6y6MBBPO8wpacvFR6G21zKABO7jFJR9yiAWbrX3Zwsoj/SRaZrBJWJL73klzEm0OBNMAO1JPAWVh6YK56hj4Jde/ZzsthNHW0QouM94786yU1rfvf+RCJDeeI4bIUU4Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+PcNlRe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D845C116B1;
	Thu, 18 Dec 2025 14:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766069729;
	bh=cx33bmzxXszIejBxrTvJOwS1Z0VaEt6LoikK3IxdywY=;
	h=From:To:Cc:Subject:Date:From;
	b=j+PcNlRe2fdHE+N+HFb4t6vETHmfRuuOf9ql0kEudUyRzdpVqczm+SyAlcpQiZLRV
	 isXntc4mVlTRH+QJHMkOQ5e0AX0IC0638E9r9LdILYwqVed0ME9xyD5pT5cIxeBEpw
	 xF25yHoWf3V2D4Y8PEGStrNQbtEQrbDDuny5UJbOzL4Jryk8MtHli5JjKrdGAWIC3g
	 omKfktUWfP003QRqjXeH3X1Vfb0gnBq7bE2/fQ6vbfrskJvOgWm8VpSVSHjh7w4d7o
	 vIMp4VMaMkCxuath2e8RBvHY1bgrT087psmMh362PZxQozHjmonNJq8z+VncU3g0Ed
	 ULEFm2U10twkQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next] bpf: allow calling kfuncs from raw_tp programs
Date: Thu, 18 Dec 2025 06:55:13 -0800
Message-ID: <20251218145514.339819-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Associate raw tracepoint program type with the kfunc tracing hook. This
allows calling kfuncs from raw_tp programs.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/btf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0de8fc8a0e0b..539c9fdea41d 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8681,6 +8681,7 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
 		return BTF_KFUNC_HOOK_STRUCT_OPS;
 	case BPF_PROG_TYPE_TRACING:
 	case BPF_PROG_TYPE_TRACEPOINT:
+	case BPF_PROG_TYPE_RAW_TRACEPOINT:
 	case BPF_PROG_TYPE_PERF_EVENT:
 	case BPF_PROG_TYPE_LSM:
 		return BTF_KFUNC_HOOK_TRACING;

base-commit: ec439c38013550420aecc15988ae6acb670838c1
-- 
2.47.3


