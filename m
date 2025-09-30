Return-Path: <bpf+bounces-70041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF03BACEA1
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 14:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18DDF4E1258
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 12:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B344302160;
	Tue, 30 Sep 2025 12:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBNhpK56"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA8C3019CE
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 12:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759236353; cv=none; b=cmn5r5WDc3d1F55DrAEafve6KR4pMW2X0pPNqTaBSDFwF6qtWddKmfVIU2kR4L8pbcyh3zUplIOkul7DXajitsPVptHXCQVfWLyKaOvInoIXjTcfTxBkSGF1QMIP0NPQqFdEP7FfCPEtQcrLz93Z5h0nwL+rOoSmjelMroSHc4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759236353; c=relaxed/simple;
	bh=p+1tb0+ufMR8mi9KHSlxFMXhJqZ6E01JDFhbXdcFfrg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HRQ7Q7vYjqdJAxJEcILhH5Z1XQYncPTM/9EpNw/VWXScQwGENaAoCpQ+mZz5AKZcp/Whi5k+TF4HNWENZ9hie8wdfpEFkSbMM/J5Di8wqoF0MpHGoiWEXxty7XAeXzaWpdGbUgWWHujdaCuI1RF/5aK9HgX1sFQ3AORULBpo9aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBNhpK56; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3f2ae6fadb4so1010718f8f.1
        for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 05:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759236347; x=1759841147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGFmglX9ntkMa21X1QYrI4OYcQl0TXe/Uyvf274nJOE=;
        b=iBNhpK56x4hM4o9Iy0BUx0fr1hdoJJhcf1e09fZJCzKwUGq0VDw010jvcZEGmfUixN
         Waxs/mRediLs2l2PGi4AbSXR8YD91uVRqijLOXLl3rfo1jliqFPke5DMWsUYN+6JKEtI
         BY7haY15gbwXYOw+3kS9Zl4b7KOXTRy/EguYo5Rv8PePv5mfAAHS4GS4Tv6WiuQYChSo
         +aGqfvR1DYKtlOpncKAikxgpt4uQys8UECI7VkLV9CFndgc5pBV5cPT2KErFOgs9ET0e
         3PrWt8klVJWpu1JNfrky/3unvI3I2ogbTF+3ISVpw4ouvs5zyzYZZM8SCOhJ1yidZMOx
         116A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759236347; x=1759841147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGFmglX9ntkMa21X1QYrI4OYcQl0TXe/Uyvf274nJOE=;
        b=S38/vCtaNxnb94yO5Wr1kPnx3xdXVca/BsRPit6waetVFsb0pUjOL6Wj8XyR/9cA4d
         JrOuT9MMaZiK6KbDBYDD5eoP4fZt0ES8UZ+j1DLf1/eukxl2Amlwwq63cz/OFGPJdA6a
         Y5vrTZAjZ7h1FvaQQ7og8CHy6ObolnOE0KHjyJKHt9Mqa3gJ7aTO5FQjaQxcU5661ybT
         RzElVp2ltRh/+BaaQUCR3lXlEph6ndEFd5MtGzSMJ+0PJmO/bkTO1LpPgXgRdu+R+Ljz
         n0mUQv2DFaHITecXmHCQHuMXRcBfNqPHmpDg9OcmEmTXtZnQOiMFIQGJRyRYIuHgwZd2
         nwfw==
X-Gm-Message-State: AOJu0YxANpfL8vARTMTgyLmbg3GgGbz+NN6pTQCqOMQ/gTkwoX2Nw15X
	gbkcP1MmITtmVOuxFCsm+xM981PPr07p3UEXmbKcwCoqRwm9tzilNpd7dDsVMg==
X-Gm-Gg: ASbGncuRxUqZw4fI0hkJF/1AL+dKvMzA6sLCMwx1t4pI+qMjrI4TGy70+G0JKvtMas6
	d0KEg1Am0XpuwvgB0hM+uBnDQuCoiJR7NF2nHsrR5zlK108VkyK9HDOkoDL1KcHMcR0Xc/MW2IN
	Y6876x8GX+psh+3TSx07np5Ef254ssriNcNJJy1FBhErdtDvoeB0Gi8sIy1foIXkFb9cKUp/ASb
	MD48fFWN6kmZQsDXvCmqCKKszNy/pzYwhBNa3PLAoR+SKJlPXJuvBRPr7u7N3QvOFsRecthjTzK
	ExK5S2oAMQF+VUAeXJJmfxmPcwUdR4envOLBp+U2FScEuyw3TmfkqfK92JEN4x11L08D0KfecWz
	EGzXyUelHTleSNb8Rrr8bMypG2iQ7VqdX9ZoerVcoOA+PZJHHPMqBBw4Z0Rcf7suNA2+HvyjhDc
	Hk
X-Google-Smtp-Source: AGHT+IHzYSlmImboy96kYm8HSl9BaQijFB1xJhJdyh6XQfQRTxtg/oOnfR0Ps/PljBPwPwc8Z4QSgw==
X-Received: by 2002:a05:6000:2f87:b0:3ea:a694:ae0a with SMTP id ffacd0b85a97d-40e49aa113amr19652133f8f.48.1759236347132;
        Tue, 30 Sep 2025 05:45:47 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc8aa0078sm22392586f8f.59.2025.09.30.05.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:45:46 -0700 (PDT)
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
Subject: [PATCH v5 bpf-next 11/15] bpf: disasm: add support for BPF_JMP|BPF_JA|BPF_X
Date: Tue, 30 Sep 2025 12:51:07 +0000
Message-Id: <20250930125111.1269861-12-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
References: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
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


