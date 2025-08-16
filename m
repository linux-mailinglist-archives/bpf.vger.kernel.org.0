Return-Path: <bpf+bounces-65826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEADB29002
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 20:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36E5A7B46DA
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 18:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059D1302CBA;
	Sat, 16 Aug 2025 18:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDTgkSsj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17AA1EBA14
	for <bpf@vger.kernel.org>; Sat, 16 Aug 2025 18:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755367332; cv=none; b=mw+OT+nNotur6tIZGm6DOg9LBRMuuMawvhX53+gE4hUh0QSoW3slKydyvN16aCd8NLZUf0p9lK7uh2Y7OI9/IKqinyI969XASBJL2pZw6/zkOdHyCsa3BzOEM8LnKy63Ox6IpTUlMLiL5SZ0v5xiJ0CuRP3u8cpLcIqa4b2Z9I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755367332; c=relaxed/simple;
	bh=p+1tb0+ufMR8mi9KHSlxFMXhJqZ6E01JDFhbXdcFfrg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U6kLUfpXEVzaMXBxcajnFqIYWLz2cZPVWdwPkU4N6NV5nhdJyGJPN/+rSX4uef4fi+5+GuMj8pW76AykKQ49hk9vebkIJkJPrEC4nEqXAtt2a9+V6esRiUOKtedzY6YLTotNaG3OpBOCvr/U5UBY14WGPlIfEHv0ITaGV2agE7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDTgkSsj; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b9edf36838so1864562f8f.3
        for <bpf@vger.kernel.org>; Sat, 16 Aug 2025 11:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755367329; x=1755972129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGFmglX9ntkMa21X1QYrI4OYcQl0TXe/Uyvf274nJOE=;
        b=mDTgkSsj7BrWzVBXA+k5YK7yp7qCRVagENcym5si0OBUa3jDKMT52sGLLAaVmdLzlA
         1RHJEYBIiGkHboeIhDHNMGuny7YvTAoJhszjULnn2XcU0iSWUHR9EWe8lLdApym/58Xh
         ARGrAfpRlNOQUzIpJ5UUS+khScDN6NZc8wkCVebPl/S3IwsovLd2yEJ+W9MDHPxQZqK4
         Je/M6aJemZfLi0WPlH6dqL/kHp1XYpMmitULy3jel04hwsO9kxfBkU40jWJqj8Xz6wJf
         tz5Z3PzZUiFDpThos5F5K4TXLvDt8d0GWRHMdKYpZdJz8+CDdMpd3WuDrSS+o5znJqPD
         AOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755367329; x=1755972129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGFmglX9ntkMa21X1QYrI4OYcQl0TXe/Uyvf274nJOE=;
        b=BrBFBYK77LUW0HjNvHkpvnex1xoU+Vc4tBPzwjuv8p9kVVaSrt5jaUyUfpeSVYm5Ed
         HS6CdHgEPYGAZM09iE2kAo+SJgHxeoih2fJdRlfpRyeUHWYTHgNumrSaRTYcDJkHDm0r
         MxHey2uXdZVtGWbGKB9dZ1TpvKPdnj51cAGVO6rYm6olG4YznLqpiGmqk7ZI2jbWA7id
         KnjvU9TPWJYsO0F45TwNlwZZEQX4K7gqk/5X7vpSoGKidMssetZmx6zMEkqOvVSOxIgn
         GMsm3F6TOJ1U/IUKy12yrddtM+Bm4EbXlicw6eT+1/fsZ78+29pmz8OluLP9hC2FINO/
         ECOA==
X-Gm-Message-State: AOJu0YxU8QO39XdNB327hoBekvUDRJREnOD+xoA27aaE/GmunFQ2FCKt
	rfKnRUPHjaM6Jvjz0sLiS0lHjGFgI9BzWZFJZlq9wKvCxUfOWjt3vQ1Gludnhg==
X-Gm-Gg: ASbGncveQFh6LHhRzDlwpIrI+L1CRausyxtGFi/anZmqmUthtt8T2bi2xAOO9vKyJCv
	E41xzRb5WVALqnCYTBIadzO3nyq4a9blNWA4Q2jNJS9IQRJIDXqecqzs//QmWmXXbvponEqjwgd
	uV9ZkvGkdcIZUSoTho7TPGb+YOF7ibuENDaneUO6pum3h41WlelM6yQ2YgzyaDIVep5ktF9j5jh
	5LuHFdD31LTb9KE8F5EC7o3aUJLzy0WuMDIRe5batrTolZZrNgUaw3Sq7A6SDXCN0xFYq4X2B9f
	NuhZ5y5VgckAOQtMFxWNz1Y5T5/+yyWqG31upmBZbeLr7MwHhCI3fZHSHe1ZqpzIYoSvmCe2uga
	J64vN3qRefIr2huLauCjiDg90OmVVFzkBkMtuie/WSlc=
X-Google-Smtp-Source: AGHT+IFkGmrGLex+S0JQj7Fj0bD65eKyUyNHWB7dNgyzcjMXVM6j5oQ9hsjXiDaHZn1BwSiq3+WJ4A==
X-Received: by 2002:a5d:5f96:0:b0:3a5:1cc5:aa6f with SMTP id ffacd0b85a97d-3bb6863ff1amr5297534f8f.34.1755367328613;
        Sat, 16 Aug 2025 11:02:08 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bd736b88besm1080193f8f.67.2025.08.16.11.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 11:02:07 -0700 (PDT)
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
Subject: [PATCH v1 bpf-next 09/11] bpf: disasm: add support for BPF_JMP|BPF_JA|BPF_X
Date: Sat, 16 Aug 2025 18:06:29 +0000
Message-Id: <20250816180631.952085-10-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250816180631.952085-1-a.s.protopopov@gmail.com>
References: <20250816180631.952085-1-a.s.protopopov@gmail.com>
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


