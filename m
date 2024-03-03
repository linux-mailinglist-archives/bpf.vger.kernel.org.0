Return-Path: <bpf+bounces-23259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B63486F369
	for <lists+bpf@lfdr.de>; Sun,  3 Mar 2024 03:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51D6E1C210D6
	for <lists+bpf@lfdr.de>; Sun,  3 Mar 2024 02:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D260053BE;
	Sun,  3 Mar 2024 02:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z54ksamC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F787F
	for <bpf@vger.kernel.org>; Sun,  3 Mar 2024 02:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709433470; cv=none; b=J2yevyc8U+H2CAmpiBHDdT6TOX94Arm6Z38i0rb1P5zWiZqnO22omp/h8VNLO8QXL4jdKXUf1/C/VgAkprQEo76Rexagy3F1dQ3tcxr5zMiDAzqYYYcTAQum5y764hvonMhIkw/3h44uqUA9/PAacXZyGkCHycLuoMVixRVo990=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709433470; c=relaxed/simple;
	bh=sk6KyWQ9MbJNew15vbm8fRBz72Yo8GgmN8zINve/zlE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AGzZOemDqeT2MyfBU8g3w87SNh0t9wIDnp9bCy7HValkRqf8OS7cNeBZyGJuXgCZ0gL7zV18kJYGRsziaO0KrYiCeNoIcGndw5QcJHjnrOZyj20rMCWulyBv62yN4fAYZmVF+JnCj6r+/PQWGQeqYz1krEauEEfMt6M/EkBngn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z54ksamC; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33ddd1624beso2093230f8f.1
        for <bpf@vger.kernel.org>; Sat, 02 Mar 2024 18:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709433467; x=1710038267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hCb8vzZjbVGluUXGD8HrGcYGR0SO2RvW2mjX4QeMLDY=;
        b=z54ksamCOPaBGSpJKXzrjeieTxyE1D1rYk0BOf/AEwzc5AFpXkNHP/MbYQzzKnDtDJ
         F28BmqAqkPyJ64+bd5wzfN9Ile7TCNPjDFbwjFpkoGBl6X8h7fszNjvAOgDfKFdI33Dw
         qgiffzedN4wu6CismElhMrq2YatxGNTvfDx9+JChIiogR/Da47XTvFt1IWkoPROCdoHg
         ztyKpba8M19BNQa+RJ+NtpmvkGNcJxisJ0fkallbMtJh42HeUDiWHt9A5iTPCgQbO0F+
         6+qc6cgN1R0YIYU0huOcWMItLcaq5Wa4cJgHdg3GYcYQHWmkl5GeI/V8ygGSlCPdx6lI
         +syw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709433467; x=1710038267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hCb8vzZjbVGluUXGD8HrGcYGR0SO2RvW2mjX4QeMLDY=;
        b=DnsDRj4dIrkrrmnSkF9smEwV+TmMoS0RSm+9ojJE2/Aq3/UUZp4Kg5VFfFlcwtsZYX
         lqTpC0qZs8HH/6IQmnTLueZgS/yrB2QTmrS/JULVFkyb85USfDnWvQJ65YLweNSZNq0k
         ZEvpOO8XzfwmYmfuXU+cAvjl4SrtKLnwW045WZLns8xkCBorcRPZ3A4zuuBEWEK+ZsFv
         TPbq/QtdXmjkxlggv/cbD8ewOxpALnEYnhRmj6sLTEAxHfoWWZpqsG3SUqUogwg0zMmL
         NpkvPZuAFHpxq1OSajH3eiNeRnhQvWpDoWBazsUeoj9OiTNOkZjeBP3sXGp3MZ+uRb7E
         ZdAg==
X-Gm-Message-State: AOJu0Yy0x1+LbcRDMUoXBvvJvSG6p1Lhe+sTNKwdMeHZOzNLCrGB5tdj
	H2fLD5Xov2NuTrjTGp5Jdw/s875Ts2Zt1fnXU6j0trQsc+ey+etEaxzsIE2f8f4zb1TSVVKC9lZ
	xgCY=
X-Google-Smtp-Source: AGHT+IFoTmeXT9t3FN7s+fkkV04x5T1lNCB+I8UVLFURoIiUOspj9/TaGIwYy1Of8XD/JGO+P+ro5w==
X-Received: by 2002:adf:c042:0:b0:33d:3f23:eea7 with SMTP id c2-20020adfc042000000b0033d3f23eea7mr4515986wrf.35.1709433466745;
        Sat, 02 Mar 2024 18:37:46 -0800 (PST)
Received: from localhost.localdomain ([213.146.155.2])
        by smtp.googlemail.com with ESMTPSA id h14-20020a05600016ce00b0033e25e970c2sm3685803wrf.88.2024.03.02.18.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 18:37:46 -0800 (PST)
From: Haojian Zhuang <haojian.zhuang@linaro.org>
To: bpf@vger.kernel.org
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH] bpf: check mem for dynptr type
Date: Sun,  3 Mar 2024 02:37:32 +0000
Message-Id: <20240303023732.1390919-1-haojian.zhuang@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When user sends message to bpf prog by a user ring buffer, a callback
in bpf prog should load data from the user ring buffer.

By default, check_mem_access() doesn't handle the type of
CONST_PTR_TO_DYNPTR. So verifier reports an invalid memory access issue.

So add the case of CONST_PTR_TO_DYNPTR type. Make bpf prog to handle
content in the user ring buffer.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org
---
 kernel/bpf/verifier.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 65f598694d55..84066e7246f9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6862,6 +6862,15 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 
 		if (!err && value_regno >= 0 && (rdonly_mem || t == BPF_READ))
 			mark_reg_unknown(env, regs, value_regno);
+	} else if (reg->type == CONST_PTR_TO_DYNPTR) {
+		if (t == BPF_WRITE) {
+			verbose(env, "R%d cannot write into %s\n",
+				regno, reg_type_str(env, reg->type));
+			return -EACCES;
+		}
+
+		if (value_regno >= 0)
+			mark_reg_unknown(env, regs, value_regno);
 	} else {
 		verbose(env, "R%d invalid mem access '%s'\n", regno,
 			reg_type_str(env, reg->type));
-- 
2.43.0


