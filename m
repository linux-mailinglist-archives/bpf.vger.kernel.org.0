Return-Path: <bpf+bounces-68301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1EDB562C9
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 21:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59C8B48048D
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 19:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B18258CDA;
	Sat, 13 Sep 2025 19:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWGOUB23"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9129B24A078
	for <bpf@vger.kernel.org>; Sat, 13 Sep 2025 19:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757792031; cv=none; b=eQZ1Uy6KuKzb8UEDHyddGwDSej7lzWTjU2xlLMtxfULMjFNKyv2ywbk9sYYD7T/d6c/LzaAQVdtEpap4vPPXmvY3D2nI2lSDxkADeO3aIQojREfXcffahILE4E1uHTTJ8wcjL18LUQMHW8asqgTGRqdUDOojOd3h73peCcOE9iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757792031; c=relaxed/simple;
	bh=p+1tb0+ufMR8mi9KHSlxFMXhJqZ6E01JDFhbXdcFfrg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lR6G6i9eBOiHk9ggaqVfnQbzESOhAvQEZScqAo2XyDVlixtN6y6k69BDLqsqTeNhm7CasJ9yiCIZqG6IhroXOiALfP4GpepMWwl87d3m/flNi9HmlMm9J2AQXS8xiGeDDgQvnpXdQ2SW1sVgRkjrbGqStQlyjvnQWh5jef5+kaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWGOUB23; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45f29d2357aso2073315e9.2
        for <bpf@vger.kernel.org>; Sat, 13 Sep 2025 12:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757792027; x=1758396827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGFmglX9ntkMa21X1QYrI4OYcQl0TXe/Uyvf274nJOE=;
        b=AWGOUB23wHQw39EZJSzdUjGYSNRExlZnValbEogzsMPspf/z3YZdw2k3ZzUMk1KLqC
         XYzWHXlxgO/yANL5qiA7FUTlbwi8eyzEZMpVQv68W2xaxbrULvdOlyAQrtvgGhfcrmvK
         NF/QIRmksyjusgUWxEzh2Za04STG4VszI+yXtevgixL/FCPEzI6+CwLIKB4dCrHsU51+
         Wk7plYnkmFoOjqqRglXrU2XZd2DRaMjCnpYjgUzqONcs6/kZPJRLzk7LVSqX8TbednpI
         VTu7oP9l1zGixItWiC5MSfFTV/YeuN7/hijodPzL6W4Rn0g3SKxUard/8ih8XfeSjRVW
         8Hzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757792027; x=1758396827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGFmglX9ntkMa21X1QYrI4OYcQl0TXe/Uyvf274nJOE=;
        b=KH9Dw1bI1KM1uF8Jx280TCwlLcdfI+btusnlYIVTMJJSlBjH7YQGncO2+zcYV5s8xX
         JhblOSftkWXSH1vG2K7r/TpttxnX8+QCtHCjx0A0WtReDECgiIUMUEVzc81yEVwcjlaN
         HrgGwjzezglxwUNvA9yYoC6SF01n5KCtToGVB4aO7+x1XaGo0nvVAamdpJtwywfbHBX+
         GR91Aio+wT1msVP5/J0SJOzbu33jDMTfzDAWTlVU04hieK6KmHvus4pBQJqTY9t977kj
         Fn8+R1fvmoy7jPV6EsH6FO0b1ln8PHQmHFxxuHIt/nIzpTRkEec1BDam3NV/c6tvu04+
         FYvw==
X-Gm-Message-State: AOJu0Yw4TG8RfYkpfom1xZRqDscjjtCnn3R7953u+VMBwl+o1Z2sy/et
	6dhnrUZo1ez5gSwZgqd6hXgJna6E0WiBqzu/bEkOQgmKxCBJweg6zfmsuWE3vw==
X-Gm-Gg: ASbGncs6sWaOHCf31we3ZJEh+p/J7HoJHXPgAIlJBKXkv9iVf1KePtSpd92CYjf5meT
	szwWtUrbCLYk0JevglHy9Z6y0rVnTbK03w9cBF/netyApIKbDjjp8c4ALdAyixX5BidLesap6Qu
	bMTK/W/lFfCop37HDJ+FyjE5goSlS2N/zWV4KNsYBUvO94TyIyYEtW0QBUFzCXBPzQMmNAfIx3S
	eNW03gwrShJfM4NnhcVPLjvn9I3ugANVIHiAj+4r4y1rSbwq8WWz7iyxGpgs59PYnGeiwlTftYc
	0Uco+9m6o/KAQWQL7eWEB6t106t5OBWKL8rdyh1+G9ceTCG6zPcfGHW8g1sMZ2hDfUogjD/UlFc
	LVLHXKeHRIzucVmMyg2d7nOerBPsPiHX3lJwbA5myYH8t7anB7PBv
X-Google-Smtp-Source: AGHT+IGi4+UkGKdKqIQbnfMSMU6sxf9e8CDL/X67x7ZSzUD3DKs22+PSi2mEqsrjd7e2ACUzKDsbTA==
X-Received: by 2002:a05:600c:c8d:b0:45d:f7e4:87a3 with SMTP id 5b1f17b1804b1-45f214ac212mr49799005e9.3.1757792027445;
        Sat, 13 Sep 2025 12:33:47 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7ff9f77c4sm4948753f8f.27.2025.09.13.12.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 12:33:46 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 09/13] bpf: disasm: add support for BPF_JMP|BPF_JA|BPF_X
Date: Sat, 13 Sep 2025 19:39:18 +0000
Message-Id: <20250913193922.1910480-10-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250913193922.1910480-1-a.s.protopopov@gmail.com>
References: <20250913193922.1910480-1-a.s.protopopov@gmail.com>
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
 kernel/bpf/disasm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 20883c6b1546..4a1ecc6f7582 100644
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
@@ -358,6 +365,8 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 		} else if (insn->code == (BPF_JMP | BPF_JA)) {
 			verbose(cbs->private_data, "(%02x) goto pc%+d\n",
 				insn->code, insn->off);
+		} else if (insn->code == (BPF_JMP | BPF_JA | BPF_X)) {
+			print_bpf_ja_indirect(verbose, cbs->private_data, insn);
 		} else if (insn->code == (BPF_JMP | BPF_JCOND) &&
 			   insn->src_reg == BPF_MAY_GOTO) {
 			verbose(cbs->private_data, "(%02x) may_goto pc%+d\n",
-- 
2.34.1


