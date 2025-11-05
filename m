Return-Path: <bpf+bounces-73595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC170C34A67
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 10:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E683A427851
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 08:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E73D2F0C66;
	Wed,  5 Nov 2025 08:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSYMgRKO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EDD2EA479
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 08:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762333090; cv=none; b=RydOzJTe37foLneCbhVVUOtJogNPZfBvRktU7u16l2pdBhM3b3QeFpXz/WPN+NRQKbTIcieQN6uqqq3NRlWH9vZ9VnBhJWUiraDDCha8IHeJMjxwiGnEpb0dCwMIVr0mFuyDzEoiSsikzw5Ju9mUPMGLPERYBMoNdfriypzOZ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762333090; c=relaxed/simple;
	bh=xFxeXQqPKAgcFOWf9VOQjhwob5K+AMyyXdaqOi1Ejpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oceDclnSgbmy1K2tNeCICUlof0emE9KAW4jVpD1CdfXkHnXbUOqeWMwqKKkGVUaGLtZXpjcERbO3Vfqn6GJHnPcSvP/YR9HkK7+LvF+Mg3NL+nXEM3YVQKYTPg7jeULqkL19gPrxNvS5gVqfHu/FN1prE+6KnNPS3vMDxxGGTX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSYMgRKO; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6406f3dcc66so11189435a12.3
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 00:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762333086; x=1762937886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyM2gOPH+l6f1KcmV2qFGk/e0PY+DFT9pzpOXypKYpE=;
        b=jSYMgRKORpx+oJi7vbDMNTWK+JYVEY4x+qpKO9z5N/biknuYqYDsRDup5O+ytjrC6/
         eV40uRtukCWsdOwgFAmgYweOP9x2xs/KR7fcowXk5KEHZod4d4EuYs5JtPbE2Zhfjrk2
         5fc5mvE4cLi9dtTGheWmc3cYQttpcj+mSnRK1l5uIzVJSsw/cCH+liBZH+F+ekBZnKCy
         2gSQ+YHTrz79jR8ssLmWlkBaRg8gPafZToQEOvq8QGPnOaL7zW77ad2N0IKkmsG9Y39P
         jYGbNbMvE8k64W7eqN1C1e9WqjyHwvba5AvxKR8KvLVyDAysVBuKoQ0LXXlt+R0jWye4
         oOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762333086; x=1762937886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tyM2gOPH+l6f1KcmV2qFGk/e0PY+DFT9pzpOXypKYpE=;
        b=QSHndsUdgMM6ALZnUC+k0e4BuKyiRjYpk6u/2A6EE5OnL7o/jAwOL93uJ/UGyGGyOw
         Vqlo0CaJ9u0McI+TaQWDT6DDE0+VzO3g05fAA1r/f1qUykhSNbi8lIZT5RwrNyrs62a9
         VFJ2lXfzr5a7Hhym8UPTbDPOQcyZ8KSPQ1QfwAU+KuoPEGo86N+gy4czHrj7c0vMlBcc
         lsIiAd8pTM4zzrP2g3de7+rVQnroWus8dRfei/k0Lxlh12S03jqGC5DSvY7BvTrjZcqQ
         BOE3yoCBSxkw4bA4dOjQicnI+i6dGs1LbNee5Ppbrq/dwcmhC0DXhohQ0562oANmwClN
         WH0A==
X-Gm-Message-State: AOJu0YxtHtl4KyRRIy07+qt1tbp0zDt6sOk4e3tNSMAhvmzNKzCTbD1V
	7JBpq6l+ZaHiU6Su8vukHFvN4U2bgc8MlkWW6EfK6CYiWwwqC0Ics0ZfMqy/+w==
X-Gm-Gg: ASbGncvZ8nogdiWSP0idEdT8szL3dNL51XyA2V8XNnfKoX02ThE0f+xowT+4xENtW21
	w8KLDC0UmoiE5KDzcKDFKDAXUL0z0OlvxQgoiwWHc+Xu/k/kh1Dd3CNd6cBiUcC40R8RpJLvPEy
	rf7nq0N5FGKP0NQ4pGou9A82Hw7/cXsFQ1+9WJIZdgT2L9PjOF/C041DrfAI7BdOGeTvCyYxC48
	1RLzcEkQTwRWYJSoJFu7fBiAz6u7bF//tN/FKWDhL8G61SmhTs9iMzB6qFSZ7rDK1kyMPxKSdaH
	xkQEYQaK7hPqKiSnn5rjs5e6fW6h6tWbz8rpiA4AqUkdYSh/YwXPtgRttatwMrv9sQNFe/ED/HI
	7nktcJTqCTPveZY4KWQWcW8xFvZ8WxO08JKiPd+ak4wRi685Lnk/SZXqZ5nPcwu/wMEVJr/nfc8
	j0JoWo529hkaOWML/NW1PKMtPljOfKEQ==
X-Google-Smtp-Source: AGHT+IEk+unJABbr5tFbup4r9Hm5Zyzv+XBN7ut/pOLmOQNaUOqA6WYei4wWCfxFpsnP4Or9yj29VA==
X-Received: by 2002:a17:907:3e90:b0:b4a:d60d:fb68 with SMTP id a640c23a62f3a-b7265154edamr204556766b.6.1762333086375;
        Wed, 05 Nov 2025 00:58:06 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723db0fd12sm429685466b.32.2025.11.05.00.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 00:58:06 -0800 (PST)
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
Subject: [PATCH v11 bpf-next 09/12] bpf: disasm: add support for BPF_JMP|BPF_JA|BPF_X
Date: Wed,  5 Nov 2025 09:04:07 +0000
Message-Id: <20251105090410.1250500-10-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105090410.1250500-1-a.s.protopopov@gmail.com>
References: <20251105090410.1250500-1-a.s.protopopov@gmail.com>
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
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
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


