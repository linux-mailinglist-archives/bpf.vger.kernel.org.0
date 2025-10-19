Return-Path: <bpf+bounces-71325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A351BBEEC12
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 22:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2C63BD124
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 20:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D892ECD37;
	Sun, 19 Oct 2025 20:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FocOgdYz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91F72ECD13
	for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 20:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760904937; cv=none; b=igrsA+h9Uy2jbS4GQ24/HXijKtpaATp0sFy7y/4wj84e0DZ9P1hJcM0hXUzxW50Vn+DP/CyeDOqaA4HB75R36hS7bj3gLq8kGMgh5Bu4SYQfiY8YFzPp/4TloCYhhxVU599BluuLoViNbhtg+ZxGfoGdaFriloYAhUg2yeGIpCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760904937; c=relaxed/simple;
	bh=dv3IB7agqBtAl6ZPYWYK/glsgbHeGXX84EKDW9MnrNU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i+KZG85jyXixmCHmTKM/PfesHlF17GARQrJLYzXC9h7AGPoo3C+tHqnxZ36/THVFYdRaGN3mQRgJV39tj4KVm9hngYL7Fl/paoenruLDGi+NjZX33w/r6TjEZiHf1z2uEnT9DACL2CJQskzmEwFlDkjgl10ANlTQLWyVR68J5c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FocOgdYz; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so3346121f8f.3
        for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 13:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760904933; x=1761509733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjjSYlQuORdtWGg3/k5hrLGsGpe80zoPXVxHJ8QiqKs=;
        b=FocOgdYzKS/o+PoeKKkvxYFJ/DEQNm7NT4gPq9JjNBDq3t80N3CcCNam9g3vXnCB1+
         BLKnIgAo3Z0QiwYD9pi58NmvAlBK6HnO/wSGAqoVyQ5G0rbP7GE+5wOBFWR9xHxbD5K2
         x1HeSgQwKTpRpJ7VMlPSaUuBJcPhEUYK/C/NCF9LUrcA7hsx13ICz+wWS5Rs+4JdAQCC
         UodohqhkuIJ8UMCSgTf6R4egeYdQN+ka9sqkuOUwY/kVtWAToKI04ufXsouV+a1yVKtv
         YLJhNAvMKJKoMo1igF5uXjfafwpmJaH5i7Vokx6/bD1iDSTtEyOnpcpY0CVdri8hiqlC
         tlbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760904933; x=1761509733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QjjSYlQuORdtWGg3/k5hrLGsGpe80zoPXVxHJ8QiqKs=;
        b=w+//YVG3T26JdZUeoY1eDHgZOIV/rVjM6SqJzI9+XhAji4SAhM75lp6DaeJu3YKCYB
         hWHTMtLyiKRDhjbK2GAvU78TYB9SrWe6s5ZYCEej+HDZT0xJ9wbt+j0SbUoOG+XzLOPx
         HgQdScI0z2RUhYN/mb9pOfAyOIO++fMwEj+AgPTtsXC1fbd6KrOXNNPBs1yR+rL51qKA
         l820KvPeCwOVbCSeh8H++LCr+NFA1zBlaO9fN3flqa6ZxQxSGrsSjhxiw1CvR1rENB5s
         WvvilrZ77kBrg7V4PwKXRYXKCFI6ImXwYH78hveR2C+YNbZOV/QmDKdtxHN7Pdd9UHzG
         UwqA==
X-Gm-Message-State: AOJu0YxB6je8ODDdEWA6klM7laXH6yBRhQpl/PD6O078i7TWgLYiy2H5
	x30wgDZ3ICJ9jngFTX+BindYg318wQgM4hU/BUPAThtIaASDXa7xTLM9OjhsGQ==
X-Gm-Gg: ASbGnctATybL2TvqpNOlmA6nXL5tc+RiIQy3kH5J4rb0IET34em89TSWQkYvrImUbiL
	AOflkgVzA/hc+3i8eDF2YPzt7Whkf1bm25d55L62V7jEMPirEBEbmV7teWE5fDR9QhUMacd4C33
	mFI3dLsDSSQHoh6ChLBZE2pIjrrQB0vyqIORShM9ToeJLtGj4XBl8ZNlWRY0341+2R7MlBh0GpL
	1UEtHrLJS9fCfm4toHEYT7dSQcxImgwyHR8Z6aRuvfrctLvbD6cCxczTEIjfVsqtM0Ehcku/iLD
	6rSeB1RR8YmcUwEaGqpUJSLsYELsumarUFT6rZ8Abkj2Na2cE3LhoQORRw6lZT/Wjrhb/ziZH/M
	zhu0FRnxqPS2X9JALz5QEpJD6Fl0UY30KgQOSL8pHYk+a/H6G2+riFDd92mNY6Z3YEB9iG9N49+
	LPX/tHoOEXeank4AN2HRs=
X-Google-Smtp-Source: AGHT+IGqe4S0itUoAoNvXyZ0WnCHK7eVo9EfEApqZXfzKR+/uklrrKtwewJV7GMDTfPnZKMLkbn5tg==
X-Received: by 2002:a05:6000:2911:b0:426:ffaa:8e9c with SMTP id ffacd0b85a97d-42704d83d30mr7586677f8f.13.1760904933543;
        Sun, 19 Oct 2025 13:15:33 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144c831asm190460105e9.13.2025.10.19.13.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 13:15:33 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 11/17] bpf: disasm: add support for BPF_JMP|BPF_JA|BPF_X
Date: Sun, 19 Oct 2025 20:21:39 +0000
Message-Id: <20251019202145.3944697-12-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
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
 kernel/bpf/disasm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 20883c6b1546..f8a3c7eb451e 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -358,6 +358,9 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 		} else if (insn->code == (BPF_JMP | BPF_JA)) {
 			verbose(cbs->private_data, "(%02x) goto pc%+d\n",
 				insn->code, insn->off);
+		} else if (insn->code == (BPF_JMP | BPF_JA | BPF_X)) {
+			verbose(cbs->private_data, "(%02x) gotox r%d\n",
+				insn->code, insn->dst_reg);
 		} else if (insn->code == (BPF_JMP | BPF_JCOND) &&
 			   insn->src_reg == BPF_MAY_GOTO) {
 			verbose(cbs->private_data, "(%02x) may_goto pc%+d\n",
-- 
2.34.1


