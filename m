Return-Path: <bpf+bounces-70020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A41BAC8F5
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 12:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B7E83AA2A9
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 10:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1772B2FB625;
	Tue, 30 Sep 2025 10:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DukK58xR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29002F5482
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 10:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759229398; cv=none; b=DCPayBVvNihVyrya9dbiVx62qGhq1CQhl2NdmpdDqN8XDN1Ug72zVDcLYDtWbjsMy6l4bAkSdV9UUdekGT5M6cAeAkwBs7Jk3+UliDYe60pLVd+t32hibbRTV2ZmM1k74U6h+qRE/3iSwE5UYfAXj+PobUwllgQPn22GO4wqL6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759229398; c=relaxed/simple;
	bh=p+1tb0+ufMR8mi9KHSlxFMXhJqZ6E01JDFhbXdcFfrg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cBAMVlVMyw+QXNxOh40nRFO6hZQaFBy4oABXHu0NxgGuzpH7oc1LkktNddZRpT3Y/oBqAbIbzCFdvYzS1cFypG4Yi3vFZvqvkYD3KQ6sPnhJkGwOyozD2FQxYSrCF1aftMEIlFa+GBpnQkHM518KPfilA7Tc3oZhU1py/XFsC7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DukK58xR; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so3427679f8f.3
        for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 03:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759229395; x=1759834195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGFmglX9ntkMa21X1QYrI4OYcQl0TXe/Uyvf274nJOE=;
        b=DukK58xRmRJvLgGLi0rWnzRm6PObLTMZDa08fkKJKnTqfu7oe+rFJUN0dH5RYbpHnY
         SKaCkiTbCrJIfcbJAqMUBiYtTA37P0+3ve3Ci6SgkcpkvDFXb1CRtdZhIZVNPBa1WTN8
         wRFbqWZ9P0lDjdoxKLOdpqweAEfy4bDuRmpKVz/o6lrz7n4Go4XhM6p5Cv+pM/oFCDcD
         Nw0xfPLKT9LyLdUYqczHj9RmxYN4i84VBs7R5qzwATs5B01l3/24wtd/epVYPsvMeceL
         NRT2xEQeQ4JUBgYH3jpSBnly/swQVoDwqBOaXVOoCfQEiRG9/6MNLVaEJiM3Yj8LpAKV
         4hlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759229395; x=1759834195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGFmglX9ntkMa21X1QYrI4OYcQl0TXe/Uyvf274nJOE=;
        b=UD301yyQX48uqMOTaTntb/NmZbzSABOc5uhZqtUdz8ehVs3wHtWWyiuO+Kr4h8eThS
         mJhfyZvlDcrF8QwhNJ2v4zq+qRryJpjAmljocM2YJWAErBTDYhkMazal/v54UFURZnV6
         MvRvTN3MKcvTCvN+JThWVcWBllOedty6TQlTG8RwJSYd5aETlvkJl7O/MepK4J7Eu1Wp
         BDY4oPVLRDZS+3cVMvMGRknguGh/9pub71Y2ax5/YAsWk9fNlhdc4XiLFhaUeAUi4TUK
         oPikik2YVLHHzdBwbFNQP3qpQS0DqAEDbrgjhPY/cr3lMGcUFfeFW5k6TUv8ignpwkSx
         jKng==
X-Gm-Message-State: AOJu0Yw3PnHiZin6dl/IYzGTeMRdXv1TfavQu9X7rf8yXhD2ToTm/YZR
	0pZf6WogbvCf1w0nTnCUK6XAeEKvzLu/RkaeeO1pV1JankXL0QSJCPiv1yOm6g==
X-Gm-Gg: ASbGncuVzAkNMRSL6zGYpjk/CK6sEuuT0Av/LZZdP6ypfvBkNxmeI+A8wo4fP3XCYms
	Ub3di5vpOEDq8nmCFdHkK09CNNc0tEgnLgSkubyYevGb2fveG14IJn26USp8EcjCnmmFqMpLcrg
	/S3eGN2YdnHTECjga6Dq1iY9kue8OcgSSFX8c/Q09k2FWm44iaehVFfXvU/J7nGVCiM1KZXFIT2
	SMkdBrdlkVB5QE5+RcBJfWZ4xdJWRhuaEQnZlzLz37T76limOowKmYZbCqQrBg/we40ObZ5jXAa
	6u2G6WQ/RmORegcrWQtZ2vDpvJwGPOKeaEk0a3jybX/JpFt1tsttnxWrWoBzGp0UB+c+kuslqNx
	MRBRiEath/7J/bbKnIjMUOOmz+D+o/n0A06WG+rOLrSSlMtFww+szL448sqrlJWZreQ==
X-Google-Smtp-Source: AGHT+IH7BRzppQLmMv/KO+TyuN/psisydz2TguNUvPzrqv5ZerQxz7eu0zRXOV7tBDr10d6mHPm+Cg==
X-Received: by 2002:a05:6000:2204:b0:3eb:4681:acbc with SMTP id ffacd0b85a97d-40e45c7c60bmr18859584f8f.23.1759229394683;
        Tue, 30 Sep 2025 03:49:54 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5602dfdsm21982161f8f.33.2025.09.30.03.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 03:49:54 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 11/15] bpf: disasm: add support for BPF_JMP|BPF_JA|BPF_X
Date: Tue, 30 Sep 2025 10:55:19 +0000
Message-Id: <20250930105523.1014140-12-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250930105523.1014140-1-a.s.protopopov@gmail.com>
References: <20250930105523.1014140-1-a.s.protopopov@gmail.com>
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


