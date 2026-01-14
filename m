Return-Path: <bpf+bounces-78934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9977BD20255
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 17:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D5E74300EBB3
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 16:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A931536B045;
	Wed, 14 Jan 2026 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1Eh0buT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972903A35CE
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 16:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768407486; cv=none; b=rP3LIGkPH5K1zhexy1KLoG76Wgeuv+BBwB789D34AiuVDTz7sifppOke/65/LzAGa7IKNvo1a+U6xH8kBa7Rc1zEzE4L0KUaRQL9jC9edmKVbsI6K3xTYtqEef3NeDtIN7vDzzBeHQpc8A7L5EvOkCBX9kbX1N130UIRNnTan5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768407486; c=relaxed/simple;
	bh=hgXJpH77hvcBVKHH1im1p86iTVxyWxbx+ia9CwbiWZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p1xnJl/V2e5c6WhdJ6uSfJQNWjoSXLko0R9XGHzWQTPBMU3MJzz795s1OmS1HXGybHqXNeI5cdyvFV/pNnMD/ZVYlwDZddizKITdD94xmnEoyUJz2AWHeI8FwKZ9Ivw3gI/rH0Fp8Zr1kPyHMdUVlu5WANgd6oXIrk9lGyyk06U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1Eh0buT; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b87693c981fso3510666b.1
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 08:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768407482; x=1769012282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGbsNX6gJa1WyRpXzSxqLCWBhCF/R+wAe4rBID2DyBE=;
        b=S1Eh0buTHmvnFDYQrTQPsltVlY2QH2EpA2GRRMoR2El8D15ZeyfUIYNbfknPOrP8k8
         pW0zegSW5B8tTjP3fdv4JlvcQtTk9/wOcruNtq4so+ya7Bk5Kwhrts1FENbK96t0hUpV
         WWJ9pcsO6vLkRNFQSxjNMSaOmbQlQ+Um7PUbt3KDtzqMO7ZmMtALNwvXwflbyPGn131U
         h7wmoGMVO07+Xg14nSUNSK2Wh+YMKuuvyNCMSIgMyECa4EbxiMWMwBgVCVGPKZ8Vr/xj
         lKi2M10L9XRerRIdp+LcfUZugFu5UJeM3j62my4oV14mTlMgJJQ1D6U2J1Tja5SbeVbR
         i5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768407482; x=1769012282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MGbsNX6gJa1WyRpXzSxqLCWBhCF/R+wAe4rBID2DyBE=;
        b=bJZXIEpud938z9RQhTcokGCPVSIA8lwhU/WToOIvPQXdPelxeVo232yGtpBrpgKr06
         Sxfv3M2yvqwoa+nqWoAogAM9eWP/Caa1L4DxEZ1QsijoVIxoEmnaKI+1pChIhUI9pkTI
         52MhVaU3gCXRHobGdudrm8bOlre1Kavg5iRPpAD8K5yO+19bwQytSU1ktItQ6PCtOa/6
         9J+RJXiyMnwC4PO0k4ACh3WtB0Mr5X04OY2HoUHpmmGMbOGIYtIg4LmkWKYOmG0pVrl6
         yjVGTBNio9+8Qa7G00hEgmrpw+h2vgyGLIjTks5ZLisfD0PCL3EFWmMyPfNXMrENEfIz
         XiYA==
X-Gm-Message-State: AOJu0YxjHTtj5gEvZaa6MVEoWo91r4qUcEcjUa2k+7+rMRnNOtx08LV1
	/tA9UQXzmfj1SS093hMzqHktMVrcltGJx6SlWQlV/JkSl5Df4rfTd8YAkv24oQ==
X-Gm-Gg: AY/fxX5WCA6iHlCD8RGQKKXIbC/8gxZzqKbtGHbC7c0nK9LCidfobxwCK0UzCeLWhCY
	aKQxSFDVZQqBgUqdeSY3YeYZILGBadhoLH8TTpW7kezpjAbDBxNibuKl3La9eAl8Mm7MOlBWaRN
	H7yJgtBge3sq4R8pZl4zxESAhfjcnCZrVEm7un8BNldMa3HRJI8gtXFSYtHw7SJbcxlyYI/F4Vb
	q3ZuxvSfh+UbZMcBwufWtOvJW8efZ1eHgD06a9wIu1zxn0qpAbSD7Og1LpZz0R9+bfjtAogLuA7
	3WBXhlD5dxawUhOHWKHWhgaOvkwCc1XlEL3pDX/2qnHhtAwS5H9cVvDTx2URHb1fKIQgSct3riG
	Ve3j3cARThpKFxEUk40udckapt8RoSw3XTxazoiVsWqCsPVoj4epQfbbWIuBqPFYZxDnt+2NN2b
	pzKYXD0lZouv37ZHWwuukW/m69Yclp7w==
X-Received: by 2002:a17:906:6a0f:b0:b87:fad:442b with SMTP id a640c23a62f3a-b876766e97bmr227011166b.3.1768407482088;
        Wed, 14 Jan 2026 08:18:02 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8713416418sm1055553866b.49.2026.01.14.08.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 08:18:00 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v2 bpf-next 1/2] bpf: Properly mark live registers for indirect jumps
Date: Wed, 14 Jan 2026 16:25:43 +0000
Message-Id: <20260114162544.83253-2-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114162544.83253-1-a.s.protopopov@gmail.com>
References: <20260114162544.83253-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For a `gotox rX` instruction the rX register should be marked as used
in the compute_insn_live_regs() function. Fix this.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 kernel/bpf/verifier.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index faa1ecc1fe9d..fdd65107a9e2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -24843,6 +24843,12 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
 	case BPF_JMP32:
 		switch (code) {
 		case BPF_JA:
+			def = 0;
+			if (BPF_SRC(insn->code) == BPF_X)
+				use = dst;
+			else
+				use = 0;
+			break;
 		case BPF_JCOND:
 			def = 0;
 			use = 0;
-- 
2.34.1


