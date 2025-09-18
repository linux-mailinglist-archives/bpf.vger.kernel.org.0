Return-Path: <bpf+bounces-68759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F7DB83D05
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 11:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 669C417BF10
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 09:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BB7227B83;
	Thu, 18 Sep 2025 09:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3soF2Hy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838152E264C
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 09:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187970; cv=none; b=pypUyA3yPtNL/wPSI2GXSBbX749eSvHxGCUBpZE1YFvEg8f8idx2euOcd/NIrWaiWoFQDnffavlUQDJ9z+OdHrJ5bwuPtuQyXK68jRcoI9E6WUp9/fOIoR7GEozl9EA4Vvcm4mZDYJ5Yprv28TWOsIRfUzwPf4mRw7gcGySPLMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187970; c=relaxed/simple;
	bh=p+1tb0+ufMR8mi9KHSlxFMXhJqZ6E01JDFhbXdcFfrg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lAtYrqWo3QCm/oYfwYL1aaYldzKgMPCwiVmPN/EXzV+hs1QxwgnDUNkiqf+fyUla0D336Vjk3+Un61OWPtvlAn/X8gbbf+q3Cj07OuVuuQQnEovV2E8eCA0WtkWN7MoO+x1KWevSlymBlTXu3nbB9UdY7q3zsKLRIrvoRzexz8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3soF2Hy; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45dfb8e986aso6253555e9.0
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 02:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758187966; x=1758792766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGFmglX9ntkMa21X1QYrI4OYcQl0TXe/Uyvf274nJOE=;
        b=D3soF2Hyp2eMWUG/+OEt0VuIXoDMg0HtoWoWEmfCDxNfvFRRDIimNHIjs01Wzf7H2a
         9ol/BKjdCfggT65qeFof/G1iz6buu30SXxiyVczuP32y8XwiDfnmIeV/kgc+2xit77wm
         fF7jmMgexfZmZje7gTFSA4dHoMKRfDq9Sn3bHd08eiRg85/ggG8HKBKdJIIr/3EmMs92
         0fU/cFdfJRCuzptpX0Y/ARvS7iOui4cRtHQbf7443OnJ3aue2MEbRWYezTCSOaiK5+Ye
         GJpH7mKHUXI7ghRy2jOB2cRspnqk9H5Nnxoa6yvgfWtr9NaauS2+T4xcW3iVdXGtLqfF
         KsiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758187966; x=1758792766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGFmglX9ntkMa21X1QYrI4OYcQl0TXe/Uyvf274nJOE=;
        b=gDVorDaPasAqz5id67Sj1ubxPS3fjZoe3DRltHke943T7dzaHUcD1VVik5w47jX4vc
         IT8aGGw2GmonluUWoITx3RD3geKy3O3Yl8FEozE5wLoERpIUJs6/7h5L97LRcCpctISU
         X9EBngaPoJg1xSt5jiskKt0Tu4QQ0WeMx8dIoS6QbTcAorwB1yugzvVme/wHH5mK7cZh
         BnQ+2N6b+dawDG0KsVI4aylAOMKXMWpDeS+x1Ubg3f9tnvAzsh+h/uzqotQFeYEVhzVm
         lV3Ic8ysJxxK39Q34FXWdQ7L+HvV7gZSfllkN/hwwmS2Wyco5iVyGY7OrnUBNMEQGE7P
         x9rQ==
X-Gm-Message-State: AOJu0Yw+NEH6PqeJ/mav949dPds6gWDr5bF2nKGprNOZ17O6/0w0ftv1
	+XdMAlaAfoHVRHyWa43q9F7GZKFVeGcI1+wLPaNXlPq2tOA7tqm835HHecF5LQ==
X-Gm-Gg: ASbGncuX8jPmJsrMCc5f1mfmuwPsPtHZYwh1oP5XzTeG0V8piydU53M+9B2uOoaBCht
	b2GWbuD+gumYwK5A1knSIhENFXNXsLWTiunqRZxEZqKuY09RnG7SSWzomFIkbijZm4sHYBbziCA
	+xs31ZwbjIRT7aqj7ukSkGEdIYQOmxk1QI4tRb8RdOOT9wucRkG6Q7gX2YC5+d3OhyEXV3MmwmX
	NfoHIDUzIWeR0ustuVejSRjCTLhKYi/LORSyLpUdXrVnIBaLxCc8NZWniGhETwN0XaBWd1ewnZ7
	i1gZ0ULRR4dh2+FOBUIt3yY7AmzcNJrZl+F0nrUmCA8DMIvLFVfu1hCMg0laJhyXyBebDOKOXoJ
	O8pxvtMmZDmoQyHf3ro5pQ967KqpiAUTjNHFB4IrTj1P/zBPAEGlLJCG5yVLp
X-Google-Smtp-Source: AGHT+IH2tEm/5HZBjZsCGvDsQhbDxViT+yGF2MiF0o5p3ULHj1Nwepe8pL0aiL+/Vcn666et/uhLmQ==
X-Received: by 2002:a05:600c:1c94:b0:45b:7d77:b592 with SMTP id 5b1f17b1804b1-466bb9514c3mr5627375e9.12.1758187966380;
        Thu, 18 Sep 2025 02:32:46 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbf0a4fsm2775026f8f.52.2025.09.18.02.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 02:32:45 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 09/13] bpf: disasm: add support for BPF_JMP|BPF_JA|BPF_X
Date: Thu, 18 Sep 2025 09:38:46 +0000
Message-Id: <20250918093850.455051-10-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918093850.455051-1-a.s.protopopov@gmail.com>
References: <20250918093850.455051-1-a.s.protopopov@gmail.com>
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


