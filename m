Return-Path: <bpf+bounces-69883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1B4BA59D2
	for <lists+bpf@lfdr.de>; Sat, 27 Sep 2025 08:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59123327861
	for <lists+bpf@lfdr.de>; Sat, 27 Sep 2025 06:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7369D265CBB;
	Sat, 27 Sep 2025 06:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPCzd3pL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A109525F97C
	for <bpf@vger.kernel.org>; Sat, 27 Sep 2025 06:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758953544; cv=none; b=D4Z3C1cumc5lrqQn1c9Nyh5BxG/O/XsdlmPM5pTjpmT+2jgJh/rDW+KHgGfnb0RR58UM91KneUWnTNG8qQ2Sp87cW4neczMCT6QhJHAaFgeOaqVutELGVLaSLHYUoAFj+QTx9bdQY/SRZ5fmm2LPzQpsEfJBbkCyVk5020jjb+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758953544; c=relaxed/simple;
	bh=1mzduihlymOwOuUzpa230b/9HplV9BYgnGrs5Bj/ugc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dM+9L+ybss0xKKYh4LahXTr6OELD/ZolS0u4EAwk7/pWpaAMhMRxtdgQh79MJ09zAn7htTumpV//UPr3yd09meUJ6hIyKO45FSzil41UXxQ31qaUTunly1ol2UZSbzpj4kZXzi0GlsrM5owqJbjojnl1AJFTp17uQ8xemZLr2pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPCzd3pL; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso51705b3a.0
        for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 23:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758953542; x=1759558342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8sAn5hC327aMiooFzuB7A3KTTq87gTWKySZ/wTATxc=;
        b=ZPCzd3pLkhaqWECEhiuJ/tHnvpXSN7WfsfCYyrZbRDiOndC8xU06LPbAV83YWmW9Q/
         /66kbK1WhfawpSW4coriAfWq39rj0zgrSRSlxY7YKZk0V/tf5Pp0MBMBZpc1iq6jsMB0
         t8ofOtirSd3RgvvPjoXFmZoY9fJKxEseSzffEdyqOPO1emwl8RKGRveSJpFrU5jVGCCM
         f2vYuzdrM2J95x/2hNSLcJyKSxwGddxnkhDkNgARTkBEp/pkAU2WgbWX3yl+tzIcwb3G
         aCU5qqzKOkN/F00EXfQCCjBoWmoS8WE2swQqXyambMjztI60vc0/XNJlI5woJAOTC9ga
         QtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758953542; x=1759558342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S8sAn5hC327aMiooFzuB7A3KTTq87gTWKySZ/wTATxc=;
        b=Qu0OiLybESuFsF6ZATpCIlCArtHAkJdBVGeLsE2c+v0F/9pLpx8re3YMAISwM1aMrE
         3CahnCUuzSf/Sh+2do4MK6+qZ5vnLoEIZtz5jpyEs5jFdbmdTjA5hSCyO1jsGr12zTf8
         NlHYfdMYHtR22tVtJX4G8o1WTbJkGoTELii3hpf3GuGKp7iw1mtDgTg+rIgRsbRAXHeY
         eC5ymGCNAClDQxh0ktmXYU4HpDAWeTKV3EUMIhBzvhPoQjvMt4Di7y5foCFBL/9aFD//
         2vpbfdV9EZUlMxoiZzzHdQ+FRaVNojfoefz381mG1wcfl6qLHX1sctaY+iRV7IIwWB6i
         6S9g==
X-Gm-Message-State: AOJu0Yxbq6PbQ7AedHnl4M/82oQKdPA7UJ25jrHLhkxx32ldEc5ZMt0b
	VQUdrM0IzIWLVpsiWrbN5pioHvfd8uZzSoFlo+QutpJBzyNgTz2nubx4
X-Gm-Gg: ASbGncvdX8jrjxfgJ+/dLuTiMT8Fsl/mc5rQpiCsW72CeKtjRBBHD5/nLqs+V4iJOPS
	PA+CNtB7uol3GWBJ4A6xWTJ8r9o/yxtOxWZX6Ust4q0Qz5WEdXIECSYxTuPaXcheOVli61keYHw
	vVte0whkktuWwL4wg2+97KUntgxhgF9YTRUyBP1xsehTUUpbB2JX/Ar5+ac39YPmcJsmpVWwCKO
	UfLsZCLMaJCdO+cX56bCv+VHYE8M7da9CYIqy2814LZVLI0sngn/VFfjPkNpNIPLkJPqk8F5iEA
	dk5FRDfllzNke4Td9pcYzYKlWrouxOlD+hdLi89PL9MjBQwtuSPwsJ+0mnzedxNCVkQ6GolYhni
	rL45dAmyIMLhxFmpe8oMbNfp2Q9cZYg==
X-Google-Smtp-Source: AGHT+IE6mkLCpiGbrwrJeQJpeI8hUbeD8pN++q6vBROWRxM+SfOiGWJswZDLpzroKY3f/4THyxpj9Q==
X-Received: by 2002:a05:6a21:32a0:b0:24a:c995:e145 with SMTP id adf61e73a8af0-2e7c1bc5581mr11500386637.19.1758953541864;
        Fri, 26 Sep 2025 23:12:21 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023edda8sm5891178b3a.43.2025.09.26.23.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 23:12:21 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <menglong.dong@linux.dev>
To: ast@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	jiang.biao@linux.dev
Subject: [PATCH RFC bpf-next 2/3] x86,bpf: use bpf_prog_report_probe_violation for x86
Date: Sat, 27 Sep 2025 14:12:09 +0800
Message-ID: <20250927061210.194502-3-menglong.dong@linux.dev>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250927061210.194502-1-menglong.dong@linux.dev>
References: <20250927061210.194502-1-menglong.dong@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use bpf_prog_report_probe_violation() to report the memory probe fault
in ex_handler_bpf().

Signed-off-by: Menglong Dong <menglong.dong@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index fc13306af15f..03d4d8385f4c 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1470,6 +1470,8 @@ bool ex_handler_bpf(const struct exception_table_entry *x, struct pt_regs *regs)
 		off = FIELD_GET(DATA_ARENA_OFFSET_MASK, x->data);
 		addr = *(unsigned long *)((void *)regs + arena_reg) + off;
 		bpf_prog_report_arena_violation(is_write, addr, regs->ip);
+	} else {
+		bpf_prog_report_probe_violation(is_write, regs->ip);
 	}
 
 	/* jump over faulting load and clear dest register */
-- 
2.51.0


