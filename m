Return-Path: <bpf+bounces-60680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D643CADA164
	for <lists+bpf@lfdr.de>; Sun, 15 Jun 2025 10:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44CCF170EB3
	for <lists+bpf@lfdr.de>; Sun, 15 Jun 2025 08:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA994266565;
	Sun, 15 Jun 2025 08:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaJUP2Pw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62E9265603
	for <bpf@vger.kernel.org>; Sun, 15 Jun 2025 08:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749977739; cv=none; b=UQ0fChMbOTsjKZ6l24K3rlZoyuTyHyWGtUgUKL1jrI6bXJi/sSkVVYH42TGkKY2+n5iOkqNgND7FZn8+bFGmGis3ISsD3QV4tw9ROUki+7X4fHbAe5E2TT+LjtvxcsoVY640evI8fmHqTEI9wb5Wm8MsbOM14DP19H5FAM9AGCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749977739; c=relaxed/simple;
	bh=N+mO75PN4vdyvS4FIbt27XxyHNCY8m4C4tKGI9gzq8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pdt/kTCJXrMkfHW0Kk4iOBlgEapii3uSW7DMUUO3c7oZDcwBKkpsuVHPfDp2Uz4W+X/3y3drmr9+gkZwLFQJIS2yteXIXJmFLHeP18ucoZ1djgv1xqxwvPNVIUKLMjbzJvYvSmknkhhz7mQUObti6BXTDhquVaOF/vXck9W2qzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaJUP2Pw; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-441ab63a415so39137195e9.3
        for <bpf@vger.kernel.org>; Sun, 15 Jun 2025 01:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749977734; x=1750582534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E31w4MwwuirZofoGaaUh08iEETEXu+a5wZKOImLDwMs=;
        b=VaJUP2Pwaui9qLpvay9J8HwMVA1msZk6AKvIgLQl+qX/RscIkGPNBKf2rWvL0MW1Q6
         GDJBSN6v4zLXP80PjEPlS3R0fjEhWv5E8DxZ+uemiceGTf6FGL2GwemsaWhCO5NWSNNq
         hpg1fTZExRgMPe+Z5gEjA51JNw/PqbHHEJ7G+TqzzV1OgVGCtvBYgc4rnsP3XAaQOnoR
         qx4dYn8gYVPYO7NjO1NluJMN9y8E3tqALOc1QdUAnm+Z41sITeyCakCF/hMX9P5akOEO
         jMXpUnvs6MjwcojHtGpKb47sPqA5YBQiS89VbfIcUHJGxJmGUVru2Vtafw0ZTkCaV094
         YusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749977734; x=1750582534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E31w4MwwuirZofoGaaUh08iEETEXu+a5wZKOImLDwMs=;
        b=VyaiJ1oHAncEwmccSlylIY2w0pmYl5Axw5ecz2b45gtbwGT0CXI5nkPNA0CcVxMjcM
         jFIgLHTcv83fJk1u0llmHNpDPl37AuosR5bKvxix7N75nihprLK4+Bf+7tzTk0iUut0P
         EierSgSyvfmJl3+8ylN85KHofS61DjulY+7SMu9VX2B6Al1tDDj2cmyFViM+3vz6nZkn
         kNSuMHIez0yPl5TdZCbhfHdr+uYml7q9oY7o7oydI9wKXnszwW9Cyh+Ai5VgYIawsOBy
         BLEGMZhqD8Vf6DJ8L0PXYw+bj/natrK3iNA88/cFJcYBy89OEUbv2KfH0p/n7uDlIlEE
         +yjw==
X-Gm-Message-State: AOJu0YzIkrdgfGV4NBGH9GP7d25o5RE5DSBzAZT4rKQikQzc9lT4uC2B
	6xmAspCSvo7QjOLx3PJMZIeRxsxWucdwLd5KKWvSreqyXavkW1msZQRHQJJWow==
X-Gm-Gg: ASbGnculkap5e5/hUwdrI+S9+I1+L3vBaMMzyAyLZ+AQLUwbUenxofxGVX4N5WjD04P
	haYP7wUSPpQ4H/vsPCaCcyzR2hNbK08aFPVVBGJr15VOjJYtAbI4cIisMrOdFtu414eJqY62qA8
	8pxjtuXqrVJOMR1C08g4Yg6swlbpPHHzzQXfL4NUcCQSb4fHaZSE5e65JfpVSfkZLNlk4ai9uQ7
	wJ5efRuO453IkCFBe5PF38sqJlLCHfvqyDNlwhGb81y7ehihkAQmrHuwnQLMVwurn17Uz0m5hG9
	mHzF+tQuUbEzHOmaiVOMuUu2RFVp/3zJL041in7MhPNhPqximTZ+VcwkKSdbFFXVH4XvYeib1Xr
	TvuU9yA==
X-Google-Smtp-Source: AGHT+IGEi5jNzijR5CPnCM/AuW14vlYvcS5LQtoYbNk55gWR0+ARJfDHh8FtYtKzFxMRPMYI0BVohg==
X-Received: by 2002:a05:600c:8710:b0:43d:300f:fa1d with SMTP id 5b1f17b1804b1-4533cacb574mr61080415e9.31.1749977734029;
        Sun, 15 Jun 2025 01:55:34 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a633ddsm7196105f8f.26.2025.06.15.01.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 01:55:32 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [RFC bpf-next 7/9] bpf: disasm: add support for BPF_JMP|BPF_JA|BPF_X
Date: Sun, 15 Jun 2025 08:59:41 +0000
Message-Id: <20250615085943.3871208-8-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for indirect jump instruction.

Example output from bpftool:

   0: (79) r3 = *(u64 *)(r1 +0)
   1: (25) if r3 > 0x4 goto pc+666
   2: (67) r3 <<= 3
   3: (18) r1 = 0xffffbeefspameggs
   5: (0f) r1 += r3
   6: (79) r1 = *(u64 *)(r1 +0)
   7: (0d) gotox r1

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 kernel/bpf/disasm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 20883c6b1546..202b39864de4 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -183,6 +183,13 @@ static inline bool is_mov_percpu_addr(const struct bpf_insn *insn)
 	return insn->code == (BPF_ALU64 | BPF_MOV | BPF_X) && insn->off == BPF_ADDR_PERCPU;
 }
 
+static void print_bpf_ja_indirect(bpf_insn_print_t verbose,
+				  void *private_data,
+				  const struct bpf_insn *insn)
+{
+	verbose(private_data, "(%02x) gotox r%d\n", insn->code, insn->dst_reg);
+}
+
 void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 		    const struct bpf_insn *insn,
 		    bool allow_ptr_leaks)
@@ -358,6 +365,9 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 		} else if (insn->code == (BPF_JMP | BPF_JA)) {
 			verbose(cbs->private_data, "(%02x) goto pc%+d\n",
 				insn->code, insn->off);
+		} else if (insn->code == (BPF_JMP | BPF_JA | BPF_X) ||
+			   insn->code == (BPF_JMP32 | BPF_JA | BPF_X)) {
+			print_bpf_ja_indirect(verbose, cbs->private_data, insn);
 		} else if (insn->code == (BPF_JMP | BPF_JCOND) &&
 			   insn->src_reg == BPF_MAY_GOTO) {
 			verbose(cbs->private_data, "(%02x) may_goto pc%+d\n",
-- 
2.34.1


