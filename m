Return-Path: <bpf+bounces-60378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C44EAD5FE0
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 22:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAE9A1BC24A0
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 20:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2578F2BDC25;
	Wed, 11 Jun 2025 20:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ct0Gbl53"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2425D2882A1
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 20:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749672543; cv=none; b=KAuwB12CnOCtPj0JwzFh/7eYcwm71o8J3OwjOFBRr1PoKoESGPvl4ukbKT/CKg/6WwrDUkz+3b1nQ3QJgNEICX2AfSHDJWDnUUjsS71X71K+gOS74c2terH2Z4T9H8h10k4oRqv/ybg7tFGXReCiDAa5YqemFnMAaGxrKe3t4mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749672543; c=relaxed/simple;
	bh=w/gPRFhqTZjvXyZlqLPCEE3gG3ylTNJpeh99wL4Yytg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Svr5yo5ZDoOYLfb+Wwdm/OpcCpJs5L1t0v/t/Su6ElQvvEauMPkbRYjb8yMqmBRIoHlGNIajPS9O4HSSIbZM8FsWd/iL0fopaZfekgrYncqoVUfARbGeOU00vp0/WCXDklDW/M3PTtsytQf7x10dHhXPalGBpJMip3NlrOFSNcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ct0Gbl53; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e7d9d480e6cso160703276.2
        for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 13:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749672541; x=1750277341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1QMPUM9II0GnjLJgSJohB0jYKbUp2wNxAknVxYbcGLY=;
        b=ct0Gbl53M43dPl1Kw5RseL7iagOWt1Nb0UJnxPo7O3+O7wWwCyr6BCDY1/cBIv+rQx
         Mu86ae5mhIu5XAI5avMyQ9JPVDcpqPK1IohWwHisGrE/wnx2fr+b7EMrEowlTz49t2BV
         +eyWW1/rBtQH/DJO48yHWWjCcei9pIEkdrfU9RQ0HXycg5L0uLCvi4Ip2foHjxPsRME9
         m/hPfueH6N71x4lFM1zjRCt311lGYwPxqAgpXBzVaRytGxEtOcvmbwv9UlPwpH3jYBeV
         0s/I1YaJcgU+ldObc3F71sortTxc+R3UOhOCv27WFR+nIhxGl5I2yYzDqZSqxkGXV1wq
         EKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749672541; x=1750277341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1QMPUM9II0GnjLJgSJohB0jYKbUp2wNxAknVxYbcGLY=;
        b=SEDY1YOpfMZwbr53lIMg5Uih2CFkD2OvFagVNdSZ3SbZCHwycN4SyRM+P1LPlFRh0p
         2iOvYqx1F/g9YF0B0BcOmWjsoOYaorf5LyJu1itSeW+5SZPRrePsu6SuFBuR9V/dgp2p
         4Yk81OAGG02W4RukIESgnlacKFNwtNFX2a3/Ub9LC5K4QuwgQIA4ofE0RNn9SoZfhjZ3
         YFvJ9vxD+4YAlbxYJfnALNt3Z6q4vbksJW5p38Xyn42aRKLtoKkWNOe/H+C8Y4zNTDJG
         /mVjCTmElPdEG7qrDz23pgCS0G/HBWIL6efiavMivSvaaOsT2AqpIpTeB9XYx9VdPmaE
         vD7w==
X-Gm-Message-State: AOJu0Yw0bHWJYLnfcxPI+DmiBYx6I1o8pkcHV7GXdDaPRpU4DtS6YXaJ
	gGjfFIsph2YbOFQkJAchSqO22kud1iZwug/9bdyE9mOCTw421sloA7loRDd92RpZ
X-Gm-Gg: ASbGncva286+wnc+7XEP89kpNbZiZfBw4RFEmie2QWukzaRG9ZES1xIQh3y8RmeNW7v
	sLuad3A7OvnTzn597XRJhCJPRExbZHRnQh4bG18Sgll/J/FVDyFjm6ad4AW2jSMdr+m2M8/aFT8
	hgPLMLwdeONCFYaJ+HCFxwe1T6wNTb9I60LCvOhOofjW0RHGX5hFwJfBGx7FtvJCkCL1z35aqvQ
	8uou1b7CPlYQIgfJdD6VhJlTzcOorQYvAwt3bwElV6JPlFSJy9iyqigW9GJIQTqeojmHAH2KdG7
	g2jqYnArvZP/rAMXXIvDkVOFAiJojgl5GoPsRPSRDkfwY3LLaXbBEg==
X-Google-Smtp-Source: AGHT+IGHbsejXCv+ySNvdBXYQway1Tc+zjPCjI/nh/ZZScCVDMVmv6QcRSnoJs5kdMXhnWuKZgAKgg==
X-Received: by 2002:a05:690c:3503:b0:70c:bb54:ccfb with SMTP id 00721157ae682-71150a77db4mr7712667b3.21.1749672540909;
        Wed, 11 Jun 2025 13:09:00 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5e::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71152059a06sm162297b3.11.2025.06.11.13.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 13:09:00 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v3 07/11] bpf: move REG_LIVE_DONE check to clean_live_states()
Date: Wed, 11 Jun 2025 13:08:32 -0700
Message-ID: <20250611200836.4135542-7-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250611200836.4135542-1-eddyz87@gmail.com>
References: <20250611200836.4135542-1-eddyz87@gmail.com>
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
index e060d1060a37..4e03e5a5938f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18305,10 +18305,6 @@ static void clean_verifier_state(struct bpf_verifier_env *env,
 {
 	int i;
 
-	if (st->frame[0]->regs[0].live & REG_LIVE_DONE)
-		/* all regs in this state in all frames were already marked */
-		return;
-
 	for (i = 0; i <= st->curframe; i++)
 		clean_func_state(env, st->frame[i]);
 }
@@ -18363,6 +18359,9 @@ static void clean_live_states(struct bpf_verifier_env *env, int insn,
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
2.47.1


