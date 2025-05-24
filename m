Return-Path: <bpf+bounces-58899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B693AC310E
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 21:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECEB09E1771
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 19:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DDC1F09A8;
	Sat, 24 May 2025 19:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axgZSnqi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C701EFFB8
	for <bpf@vger.kernel.org>; Sat, 24 May 2025 19:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748114396; cv=none; b=qMYxKEOmu9trwl0sbC4Xtm2qHLzBCtG6AmJf+Sk4zTkZ20Z68ODCyGdcOKIST3AgwLlrso+GQSTymPp8y9L4RY4sT3mSwhzaGlYSIZapdXgtOMTVefWn3JSIU2iiDn5Kq8i7GKQT/jwiU2U938UhI/dcbAE9gK9gAt262uYoM1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748114396; c=relaxed/simple;
	bh=k9ZboN5jT7lFzPGcaAcB2LqfZmkcrolbtP58W9d9ZaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IqGiR16o/7RU5yQ6kwRzBVaCAMdeQsyi266HvD7L5OXckCem2cZed2i6hsDYpJL2fJtkEYwizDE8ntA6itHpolRpeOYHB0pyifESCrIKrrE8N5oOx4wog+coeInyskewNf6XUs/1KTCoTuGurMxj67CnYWtrZ7k0XUoI/w9TOyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axgZSnqi; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7376e311086so957257b3a.3
        for <bpf@vger.kernel.org>; Sat, 24 May 2025 12:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748114394; x=1748719194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOck+8H5EO7cyZ3h2Vp6vyXvFMrOMp43IfadFiJwhc4=;
        b=axgZSnqiogbCoUpvH5YxBplBogZSZ7vsgZ4Ex5wdRBhwS6/PCFE9YGPailpgHl2uQO
         Ih9gYLupLW7A0xAO7N40D7xet5pU5R0FoypVCG0N6nfz3udRL2PuHEknnosZkt0XIAVg
         EgvIQNDnzz4DlswkbjjkzY+A+1f3GR9srqLLUJ/Kr5+5AEhzsDObJuXd3w//TblPSoAz
         d0Sl5UIEmPcAdTcaKDLfbcf+GFJr9penb/ExabgDf9NC1qYqWiGc109Pg0YDlF0QJXUw
         N8E1G9bI/e+NXBTJqxkMYQeFIC1LkySZEbcggzoiV31gqJ3C95+xCLRmDNBWcbXAEAyB
         SEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748114394; x=1748719194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOck+8H5EO7cyZ3h2Vp6vyXvFMrOMp43IfadFiJwhc4=;
        b=m7ev1yM5K6jedgMDgDOf/tGDjiXveA8OIJKyHDDgyaU4w/JlENihLYaun+QZXByxxS
         3VKhwGOhXWnayn9Cj4emZZ+FR90XYDRN0M0U/zbSECdbD1bBulezekb+lebs4MXPQdFd
         1xLey7UH4E9SZF4XzQBTj5IfojbG14Laz9gMJBAEjw1R37BOycSweld4JD45gT+WNRve
         wY3zIlb9ClihQTnbjqZz8i2WV3RRHFLl+pr/3vTbX/OATjTVL0DnYgzMM4pPpRwDv9FD
         p3mlXuSP8nWEq/Pg1Gj2AZcIOsohnjOoqs3GoFkDDgoTOVnt66amZ9Vn8zsrIkNHXQ1h
         f78A==
X-Gm-Message-State: AOJu0Yzs1mSC4ybGQVihVdgSACt5AT7Bvic0z7ydryfa3i2qZMQRjwM8
	wHsFVVcauOz8iS5SsmDnA9g+iSKghpDPwK6OO6OiWORUqzN+i4ThZC0FrV+tUfn6
X-Gm-Gg: ASbGnct3fSZYpVRxXT1dhXHYf1JunjYj+I7J2OGaop8z14yxaJNAIzPExz2Akq7qNTj
	KPHwhvQL9Io4Xh1EGGD7eKacvylzzCgonMXeVbYZGvbuhCoekOVh+MC0W9mivBnaYmfPdScxHyS
	SAjN0EsxFf5bITBpQQdjcfPoZr/MED05EsLtOj/ocbeHIUlAiEqBf8++VxUhUxtAMdDiFOqWiHv
	gyQVvsHp1So+beTDQe2iigmtJiEw8IbPzNA0u13wqFCISYRlxMBo74HSfEPArR9KptebgTnEzJo
	7ZfWG29bs7yN8gNv1vjwFlwBlCUv7VRByD1Orwls4ElTdrM0tuRIytfvKg==
X-Google-Smtp-Source: AGHT+IE01rc1fzq/HRgxA0xlfZZSB+a3o67vSemsIwNLfkr1v6tnpZ3n58Q+4bJVxvPgkPHATwhHMw==
X-Received: by 2002:a05:6a21:2986:b0:218:cf0:fadb with SMTP id adf61e73a8af0-2188c3c1213mr6309768637.37.1748114393829;
        Sat, 24 May 2025 12:19:53 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a986b38bsm14558298b3a.129.2025.05.24.12.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 12:19:53 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 07/11] bpf: move REG_LIVE_DONE check to clean_live_states()
Date: Sat, 24 May 2025 12:19:28 -0700
Message-ID: <20250524191932.389444-8-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250524191932.389444-1-eddyz87@gmail.com>
References: <20250524191932.389444-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The next patch would add some relatively heavy-weight operation to
clean_live_states(), this operation can be skipped if REG_LIVE_DONE
is set. Move the check from clean_verifier_state() to
clean_verifier_state() as a small refactoring commit.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0d7fb2e0e1c6..e69e98733e61 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18280,10 +18280,6 @@ static void clean_verifier_state(struct bpf_verifier_env *env,
 {
 	int i;
 
-	if (st->frame[0]->regs[0].live & REG_LIVE_DONE)
-		/* all regs in this state in all frames were already marked */
-		return;
-
 	for (i = 0; i <= st->curframe; i++)
 		clean_func_state(env, st->frame[i]);
 }
@@ -18338,6 +18334,9 @@ static void clean_live_states(struct bpf_verifier_env *env, int insn,
 		if (sl->state.insn_idx != insn ||
 		    !same_callsites(&sl->state, cur))
 			continue;
+		if (sl->state.frame[0]->regs[0].live & REG_LIVE_DONE)
+			/* all regs in this state in all frames were already marked */
+			continue;
 		clean_verifier_state(env, &sl->state);
 	}
 }
-- 
2.48.1


