Return-Path: <bpf+bounces-43944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF019BBE85
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 21:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF4611C2179C
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 20:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE1A1D514E;
	Mon,  4 Nov 2024 20:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="KaSIvP3W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF5C1D3564
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 20:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730750701; cv=none; b=iq5wR8nmGUyjkJKSFFDE1HYGO9tHdBAvoI+ZsK6lC64Ka/E1nwJxxLbU3gI5Dfjw9UMK5IH3iR6x5hD3KH7Ubqcvln8J21cRdL4wqab/xE6TnJ0o69rdBtsuGaCmLu0gvZ4MoQMpD8K6WtB16IMd6/UwHXinwgHCU2RFo/BXOF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730750701; c=relaxed/simple;
	bh=pqrbgqXGtCMj2h1S7WLv4tMOXS0QwAOtEV4ZJmi6sLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fb9TLrR2GsbUVE1/VhJT1aiWVdAmK1yiFqHFGl4cFTOYLiqXUm/MshTF4YRvIIdqNRbHYfLsZiRFWuYVPJLStAtDSccKzhG9LS7eqmWRPt0ENxTaHJwJBpxsSGxs32xxvodcyQkYOnOIr6Ua3W/Qxk5LNJidUCIM8J7P4SviCjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net; spf=pass smtp.mailfrom=opensrcsec.com; dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b=KaSIvP3W; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37f52925fc8so2920254f8f.1
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2024 12:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1730750698; x=1731355498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=meYoa9C/Gt7fI82dSK9qvSdAvPbU+XLmJPn0uNuFWBw=;
        b=KaSIvP3WTkMrmXX5nhMDb4mubvzkdwo8O3IH6GnTKjsxkooBGQm3x5S8R6N3fZLbTK
         uurp1K/JHq8q3tbwXdu5OnZrd+m77fPqDKaBjLDTRuoLn7q66qnbSQW/mJb9g2NvdEL0
         lCdu4cxp81vUqelGfzUbVgt2A2Qas1Z9agw2LU7mvXZqnmkbGffnLd0ECGBVL67Qmahc
         +J+Vlkc3AJ1u6FacYGKA+iX12kYIsag2d85YcX8hOA00Bc6vs3++kKpPim8XNdkutdIa
         UNrFzIFMBwDCmaLE59mGxWgE1kiuOAK5cFhjdhf52jS1MsdRukkMyD6QrR20REPJ+aeO
         76zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730750698; x=1731355498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=meYoa9C/Gt7fI82dSK9qvSdAvPbU+XLmJPn0uNuFWBw=;
        b=o3UjdKFD2xH9Xu5ZFWmeTNFEqdQp6J1cOu6UvzY4z8OD0I4gF9zV/pafLuNxUmBj4N
         15PsGtRdT7sjyxl/J99spGHNwjk+GAP4/sFxJd1u8cL9gKUVosAXgsdG0d6QWad7BWe/
         p2BmpODNYYFgVAtitMlWwASmzsYjhWVEAnqmuiBtdBZ3Y2HXHWcL6N7PwSxU16l8xl2u
         FxUxM2vZv7StHCuf8ljBtePvQQYK9I1n6mW6WZVXpgFyFmfeVw67Fio7Ip/pvoky9qtc
         QCGCHe8/yQd5kO8cIG86TPwNV6+tsDAJPUbudEjILoufziCOC6Ib5U7+GRlaGbEm67GX
         EoHQ==
X-Gm-Message-State: AOJu0Yx4cDZrA4F7bhTSm5smlm9jxZsFi4EYGrL7YRrokiS3aV/maZB1
	U2zRkO/yrXJXAzaAs/kjOiOC+An5zwefdW/au6IfYPsxecTNkOE8PRrPyJ+wuRTMGSrkzQrkQM/
	8Llk=
X-Google-Smtp-Source: AGHT+IGpNZLMecgK+/z3zufk3TepXY1BKrmNTILr1Aa25Dsp+EQ5o7RCD6SH5KKwwQhRzyGo93LCwg==
X-Received: by 2002:a05:6000:1faf:b0:37d:890c:f485 with SMTP id ffacd0b85a97d-381c7a6bf98mr10856166f8f.25.1730750697780;
        Mon, 04 Nov 2024 12:04:57 -0800 (PST)
Received: from bell.fritz.box (p200300f6af056e00c6570c15b61f00e3.dip0.t-ipconnect.de. [2003:f6:af05:6e00:c657:c15:b61f:e3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cee6a9a5c6sm249160a12.17.2024.11.04.12.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 12:04:56 -0800 (PST)
From: Mathias Krause <minipli@grsecurity.net>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mathias Krause <minipli@grsecurity.net>,
	Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf-next 1/3] bpf/tests: Make max jump tests constant blinding compatible
Date: Mon,  4 Nov 2024 21:04:50 +0100
Message-Id: <20241104200452.2651529-2-minipli@grsecurity.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241104200452.2651529-1-minipli@grsecurity.net>
References: <20241104200452.2651529-1-minipli@grsecurity.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Constant blinding may expand instructions that make use of immediate
values into multiple, resulting in preceding jump instructions to get a
bigger target offset. The "max jump" tests specifically attempt to test
the biggest possible jump offset, requiring to take special care about
the final (after blinding) offset while crafting the input program.

To make these tests independent of constant blinding's instruction
expansion, use a register-only operation to load R0 with the intended
value.

This fixes the "Long conditional jump" tests with enabled blinding.

Fixes: f1517eb790f9 ("bpf/tests: Expand branch conversion JIT test")
Cc: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Signed-off-by: Mathias Krause <minipli@grsecurity.net>
---
 lib/test_bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index fa5edd6ef7f7..c1140bab280d 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -491,7 +491,7 @@ static int __bpf_fill_max_jmp(struct bpf_test *self, int jmp, int imm)
 	i = __bpf_ld_imm64(insns, R1, 0x0123456789abcdefULL);
 	insns[i++] = BPF_ALU64_IMM(BPF_MOV, R0, 1);
 	insns[i++] = BPF_JMP_IMM(jmp, R0, imm, S16_MAX);
-	insns[i++] = BPF_ALU64_IMM(BPF_MOV, R0, 2);
+	insns[i++] = BPF_ALU64_REG(BPF_ADD, R0, R0);
 	insns[i++] = BPF_EXIT_INSN();
 
 	while (i < len - 1) {
-- 
2.30.2


