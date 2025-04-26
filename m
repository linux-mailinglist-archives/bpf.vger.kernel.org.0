Return-Path: <bpf+bounces-56777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4C6A9DA2C
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 12:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57D9992688F
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 10:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5160D2253A7;
	Sat, 26 Apr 2025 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbYa/BlU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF131D5CD1
	for <bpf@vger.kernel.org>; Sat, 26 Apr 2025 10:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745664410; cv=none; b=bvkdTZTouXoMYz7owwaRWDcdGDXDzhzebNbaHSy6KRBXTSdQ0ucIEltb1bEd04PnkMKnoTGBxacWpwwsmtLNDvfk59kDi/8yGyxYRJwGel2al4LcCFstk1onWGw3k1IBkB5lfr7mQaFc1fvqXeTJA1OtrlC7UzLdbzcIHs7Pve0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745664410; c=relaxed/simple;
	bh=LXcOrQVYE6V/2a3IC9eLSG6xKwjmsTjgwPcP/VL02NI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LL2aaxxIlkvIq+xvGM03sEzPTF9UxB/X7zfbg31LoE0d8jEZpHhGgZ5qWajk0g/LThVzsQcMwx7FMr3VyPmkODzZ4HVlTpSD+yY4uU3Jk93N8uRoDuzjqSCHM+nPJcKaTq9zUlouwgk3L7JyQIyhkA1odgfRAYGP9Q3Hp/bVYZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbYa/BlU; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-224100e9a5cso38387955ad.2
        for <bpf@vger.kernel.org>; Sat, 26 Apr 2025 03:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745664408; x=1746269208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hetHpzybxkovlVX5s0pTEKfdz61qgVTE37cc31ApWrU=;
        b=DbYa/BlU1G71oIjtO3Qf3kbcYfSRgLP9rJacXvNRHDJ3mCLxrBjV1wH3KDpS3xMNW8
         wQ12QgOEhsMgURLykmwFLBpLSVcxSS5Uac1ygDl86MFjPDYcTHRMTn0KfFt0P2EOopIA
         w+L7rsObRhpTi6OiCCLpma9N5Vqz5mdONToGVdwV23HZXKc8VeCqHBXrZbB21vLEr7Jj
         QJsQGMwiPzcNx/MKTm5CWsthDx/vtaqrH2N0EgP663oKG7DS7fjjrTiHvOuWKZzF7IeX
         RrpvhgAzYJxftdWKE7yLngleBQXm/R2MYKaxYET3fUenPv9UHRd43mxmqmy+vmLu5cDU
         Q1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745664408; x=1746269208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hetHpzybxkovlVX5s0pTEKfdz61qgVTE37cc31ApWrU=;
        b=SoyRp+UQlQhRx46FCZBdfXxj1+gIn0WwgFB3coJUdDoY8X28918YJihb9CcBbS2Fza
         q83HF5Qjm8YEjvn7tS1t2NRKwqXZyZtwyoI9LwJXoAkOLHiuz00h80DeOw6X+ZeCuCOq
         fgsfYBXr0ecFKCYhLE0kwDZnJkMdqF1r2HShor16sDy/rxP3a3j6Hn0ViQbj7McNzY49
         G9l7VJaAMuK8JJSWRCv2q9xlEU7f/bNxECkh2Lxyd8vlVqnd/UH2RhD+T9gB9GNhZxgM
         0JqXgSFD+Q3YGkB600pCFo/OL2RobiunO9EZiWsyosdtmSVsjZP4zGPnZHwchGiOBnja
         SBgw==
X-Gm-Message-State: AOJu0YxrHXSi2lWMil53RUDh/lJGTzHpjcdw8ibrkzIKcZ3DsVRPNi9j
	DBaHM8zqTrONBlCDRXSWIZG/Lz8nbX1tojFmILc9xAcdQVu7HLoS2sP07Zhs
X-Gm-Gg: ASbGncs1CYfcnEQNWcl0sXJ8+ene/KzcyflFJlHUtp9dYsU0DNnyaIFeV4oBJ/hCsli
	djLDBWYDYm4QfBSWYNsipD7Lgk1vfWTkGcKn0BPRz4LM9plo1yMV271txw2mtLCn2331HrdCEX5
	NZc3+F18mcZez1ZA4E3w0KJLiQPQlBJutF/jMR2BlH1zaoVctOtVz2/Qyl/7gQ0ag31JRwjffcc
	PAN3b47lF3wwgCBhgH/qu+S/D7gVvLiEznwyTjiJdZeyTCCTJoG4Xkmg8XjnP4rAk5k74iem7Os
	Bl27clHdLQf8h4cKkBK1ndj1baJztyhZzqdm
X-Google-Smtp-Source: AGHT+IEYzjo5W91/vlE8OifGKoQMmyBZl0nfIcAiuLlEtgqs648KInf/2DH9h6wU/LL2OxYpEAIMPw==
X-Received: by 2002:a17:903:320b:b0:220:e362:9b1a with SMTP id d9443c01a7336-22dbf5f9367mr83235895ad.25.1745664408415;
        Sat, 26 Apr 2025 03:46:48 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5102e13sm47094115ad.201.2025.04.26.03.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 03:46:47 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 2/4] bpf: frame_insn_idx() utility function
Date: Sat, 26 Apr 2025 03:46:32 -0700
Message-ID: <20250426104634.744077-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250426104634.744077-1-eddyz87@gmail.com>
References: <20250426104634.744077-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A function to return IP for a given frame in a call stack of a state.
Will be used by a next patch.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9d1f912c12a8..67903270b217 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18235,6 +18235,14 @@ static void clean_verifier_state(struct bpf_verifier_env *env,
 		clean_func_state(env, st->frame[i]);
 }
 
+/* Return IP for a given frame in a call stack */
+static u32 frame_insn_idx(struct bpf_verifier_state *st, u32 frame)
+{
+	return frame == st->curframe
+	       ? st->insn_idx
+	       : st->frame[frame + 1]->callsite;
+}
+
 /* the parentage chains form a tree.
  * the verifier states are added to state lists at given insn and
  * pushed into state stack for future exploration.
@@ -18731,9 +18739,7 @@ static bool states_equal(struct bpf_verifier_env *env,
 	 * and all frame states need to be equivalent
 	 */
 	for (i = 0; i <= old->curframe; i++) {
-		insn_idx = i == old->curframe
-			   ? env->insn_idx
-			   : old->frame[i + 1]->callsite;
+		insn_idx = frame_insn_idx(old, i);
 		if (old->frame[i]->callsite != cur->frame[i]->callsite)
 			return false;
 		if (!func_states_equal(env, old->frame[i], cur->frame[i], insn_idx, exact))
-- 
2.48.1


