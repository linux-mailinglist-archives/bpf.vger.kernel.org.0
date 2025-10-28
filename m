Return-Path: <bpf+bounces-72543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC89C15234
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 15:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99FC14047DE
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 14:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203113375AA;
	Tue, 28 Oct 2025 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BY8t3j1z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAE4334C36
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 14:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660919; cv=none; b=BeSgZdNiGfeeTn/n4Ys5Vx5mfXF0clQz6AXXHYvlvwjphFRaOSc5xdpOcPCKkGfhtYFTLLbEjdn+mn+JSWdjtQQjiessTzMyHszdGawvcdPYHeoArJdk8W3z4pvR7RchHxsvHIvk/cqEySTqg3Zfj/rkV/MzMDzjbVHK1RseEkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660919; c=relaxed/simple;
	bh=xFxeXQqPKAgcFOWf9VOQjhwob5K+AMyyXdaqOi1Ejpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VcEspuNIaMc+Hn7RHyqUw3tDo+NeY/VNtrNMY68sf88YFErftHz9GMuNQXxDFcftf8Hi3aNbAp9c7xrXOCBFt48QJm1XJ1hSwTQeOH/AACXrt3R9u7uHzFPVw2xOGFg+lanJ6x6BD7bEgllN9V3EqUGLEZMQrWvDYVA6ZDNx9Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BY8t3j1z; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4270a0127e1so4797331f8f.3
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 07:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761660916; x=1762265716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyM2gOPH+l6f1KcmV2qFGk/e0PY+DFT9pzpOXypKYpE=;
        b=BY8t3j1ze0PI3gOabTnwMXiPlQAmwifkStymXmAqxe34Y14mfZgJXPoFZRb0cQoRph
         CWwVne6tY1Qccp63LZnsBw6Ga6TiX3UVbgUM4cDhSt8qERU7TXSus4JFczg6PUvJyL7F
         nblau0QoSaaIQv19n93yRxHOUKRz3EPEJG+Ck/MHSqrE3uTajf4fDkvgNqZJfivjdMv/
         gIp+QKghMx9LwANWHs0KfwCYMgkIXapueJgL/PJQue12gidj+1gBWApLFxnxkcmnechy
         IbQ72TiZYGko3jk4mLn6l2mNxENoAd/8wdWOilYkGh29ZeYAbi4kYrKmO5YXITsEQi3T
         wxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761660916; x=1762265716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tyM2gOPH+l6f1KcmV2qFGk/e0PY+DFT9pzpOXypKYpE=;
        b=oisK1IMU7+kIHo6jO9osFR5EfZsOumyYYnBbQQJBKOF3aoN9SWfK7r7pGOQcRmeql1
         5O6Hn3stxPWTNzvNqgSaPrQXNe9YUDCRQwQizdWiwdVEWAfaUx1VPegrcuxVV7iB8Ok6
         VwBTfC0cCijEhEKeq25PgnxEAlsWxKrs3r7DBmZNIkn64Sa211BVto9B7YLIyCfaGTXn
         F8gFri4kZdR8mc1e3VN/2hcwhWozhJUjo2EsNfP2re1t0aNFXV32EdWITfc+h9JcxRpv
         X19DfsCtiRHYScYQ5ShcwolOq12VYqFFy1a9qUhF89PojCXGeLJsBIvlQKlZI7j2Ds9a
         BRUQ==
X-Gm-Message-State: AOJu0YyMesxj+CS3Zc9AWZg8kmjGXu+Z0jeXzbXSDgnepsjkDFKNgfgL
	Dmbv8z+CQLE7bozKfMxw+mziEdZ1aFoT+QRwG71ECozw94xXxLOUoP/mNsEFfQ==
X-Gm-Gg: ASbGncuec2molV1iZHwMReorv6E+Tb1aCxlewNlyOmHAIIJA5iZj4LYWdbQV6GeGLGb
	yythN58btKq+hpBIgqWALseHpUc5R/gNBtERZgOcFP6Z+KTI8BQ6HX10C8/vO17DZaCmWLmTUSi
	lxtp0KmWG81+lw4hVwzzFrzd5NTVwqEwsxScMBCHTQDnlLVi8/MYz8FS+hv707v4RJB7y4M1p1C
	A+hD5ZQpMvV23R65pPcHIICWZlOqy/Mw+4mMuZ7YITpoGz65v/OX8hPucFG6fz3O5fLt+9Oi+Ca
	Ar3YxV1xrtLkL2UptOSN80rGjjQ4W1LwkPWxyZusAybrTQingRztKJ+0OdOVQlpBCNjX6y0+vzd
	YVgb8KU9ouwKxuHRKI4oMUyhEir8A020l3wRkPO9wwArJO2H04WnjRHoUR90Dx/FK98ewcpoysj
	tKYcqHXf5Mw2GGiPTOnfo=
X-Google-Smtp-Source: AGHT+IGYJwKpXgsXmvJmMsnxJwAJBdtBpLERQjtkOFbivpYXOqBC7c0Q4CPSqBtgMFm1Lr9zHPnEyQ==
X-Received: by 2002:a05:6000:1848:b0:427:53e:ab3e with SMTP id ffacd0b85a97d-429a7e96e1bmr2994205f8f.56.1761660915955;
        Tue, 28 Oct 2025 07:15:15 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d4494sm20867060f8f.21.2025.10.28.07.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 07:15:15 -0700 (PDT)
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
Subject: [PATCH v8 bpf-next 07/11] bpf: disasm: add support for BPF_JMP|BPF_JA|BPF_X
Date: Tue, 28 Oct 2025 14:20:45 +0000
Message-Id: <20251028142049.1324520-8-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251028142049.1324520-1-a.s.protopopov@gmail.com>
References: <20251028142049.1324520-1-a.s.protopopov@gmail.com>
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


