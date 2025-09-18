Return-Path: <bpf+bounces-68841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF3FB86841
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 20:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57F227C0376
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 18:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7832D24BC;
	Thu, 18 Sep 2025 18:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtk6ciKw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D862E2D29D7
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 18:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758221289; cv=none; b=hM7MoT5E/SsC20inuytCmExlsHv2dEX8+nSY0SnBo0/oQuVSR3/cZLwEt6rSfog08K5EB4+eWXqXMnPRZLFJ+QkvFk+SSHwHpRMyW6FYknGEHXGHhzXq30wnMJZDIuZ2GhW93pbIN0qhb4qoAwn5uRE3z+GuOG3EiKTIen/8nJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758221289; c=relaxed/simple;
	bh=FlmJy/7Xd/2pwSTTC6rgG49jDSNFNFq0mOFAPJK6ZAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LJYHs4vFp3dtFcIPtJgLPmzcndybJ9gkZPdIQrK1Vj2M9U0uvVrsjluLY3Z9Ve07b7tsLC9kDamU1mEDObPGwv4pI/pCUD42DZb1sGXje+w2ODqgMZrVkRc0Q0pnUlUtM/Bu/v5fgYLSRd0/z25F9DMCa9WehZX8/NUGAZIb/Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtk6ciKw; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2445824dc27so13646715ad.3
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 11:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758221287; x=1758826087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNHL0Vsc8z7LZGkZI+uZAC5R+ShkWy60mDY+U+Rewbs=;
        b=mtk6ciKwWGLabtpXn18LODkXFeRwiiDie08ADmauVc6Yl48+SceU/qaB7KDeOliaxI
         oMxFzzmgQjz/YVbSOZgqGoUo0bVO+K64e4j9S521S2mEPnWVerE1EcbJ9vjotP++ctSj
         kcXgZM9xiNP+fajJSACGB299QuQjuO1oKOYEx2O1mHJcgWknR2Q5rs8N8AKRPeW9fBan
         1cwtgIQc+BjKgD139ZWaj93JM4oJfYSTjQSdj01vGHZvlBU+EoJ50ob3eRZ2vDAatSbt
         WjeQrbKOWG6DnLtPm+pQPxBuU5/nGzOdblIHnrsWYCONoEpEQKYyE15nCqqKY9b8ZZdi
         HP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758221287; x=1758826087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yNHL0Vsc8z7LZGkZI+uZAC5R+ShkWy60mDY+U+Rewbs=;
        b=g04dqM1KuSYqnsOgk2SJ5YkpI9e2FpS15tfeqPdE0j79DxGo+07TIrbMh+9smWdvvS
         +IY5GNfynIUdaY1oZi7/N6hUd1EOL1O2VsQsI0XYlIgUQwtN804sSWjhiaFrxuBZf/IE
         eiWgn6qErCXyeag0hGCmUkFBIBNvtmHAcuZ97Tn0kh7tOGIiVxdFWuZvadvb4FFveWVJ
         kR/2nwpBfXZhZoF2W3PEL1gtUgo62GYt6FMOTIndoyfe70hKQ4I6KT9gHIl+UfucEMhl
         Dh70y45byna/XteJX0NJuUrttpZhn6JpXMDJ651GzKW9gA5niat+n6vBK1/u9tVjNh6p
         kx2w==
X-Gm-Message-State: AOJu0YygXG0ZEVEePbWUwAwX1RG6W+tczqEEuZpdJpC9nNiKEJNJKgaE
	RHoK8XsqEz6Lh8eYalEEqOFr44SchmYxOeJyOnpQo7whkse8BEOFuul4x5UKpz4p
X-Gm-Gg: ASbGncv/584cC4UII0uhTqKpP4m/HorwMoxf5uvUGrJGoHADg7YuxUH+f0W5Ua58SG0
	qwNiN3/oAw9qQmrlcjFvnNuKSa0CMzeH81Uz8NQnzZhFoSTOgOkg0MB1zwJGVmKsidZUyvU2vDQ
	SfGPaI5uiKyrjJwrz8HC2XxTEMEQTuhVhsjU5GXpb7tgS6mPVBJcEvpo4n4UKXynrq/DB6xYvji
	yGV/WF+MSpKT5lQTkMMPNgPE+qHg619eoykg8PRgUkiFa3mLVlWfNsBwNew1KCXfxZYcPh2Daf6
	KDsGk0x8Fem46wZt+TOScHJB2ikMchZpp7bLbJcgRLV87YnHixoxQ1NNLmO5enU9hhW8JncpV5s
	we/irI/q/OfRk8mrn3zC1pgqhj/ZPzNSWjls=
X-Google-Smtp-Source: AGHT+IH22fQFecfLN0MpqSXxoxkKZfWDp3ENXCyFGzcrC/Unp14tAdWDm8rGeDRxu1YPbplWTgCeYw==
X-Received: by 2002:a17:903:19e7:b0:264:f714:8dce with SMTP id d9443c01a7336-269ba5081d8mr7945835ad.36.1758221286993;
        Thu, 18 Sep 2025 11:48:06 -0700 (PDT)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802e00b3sm32361505ad.90.2025.09.18.11.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 11:48:06 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 03/12] bpf: remove redundant REG_LIVE_READ check in stacksafe()
Date: Thu, 18 Sep 2025 11:47:32 -0700
Message-ID: <20250918-callchain-sensitive-liveness-v2-3-214ed2653eee@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918-callchain-sensitive-liveness-v2-0-214ed2653eee@gmail.com>
References: <20250918-callchain-sensitive-liveness-v2-0-214ed2653eee@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

stacksafe() is called in exact == NOT_EXACT mode only for states that
had been porcessed by clean_verifier_states(). The latter replaces
dead stack spills with a series of STACK_INVALID masks. Such masks are
already handled by stacksafe().

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 42157709fd6b2ceb5ac056f1008d7a34f4aac292..edda360a3c370e5fbe036ae55c9b16cd37a58486 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18760,13 +18760,6 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 		     cur->stack[spi].slot_type[i % BPF_REG_SIZE]))
 			return false;
 
-		if (!(old->stack[spi].spilled_ptr.live & REG_LIVE_READ)
-		    && exact == NOT_EXACT) {
-			i += BPF_REG_SIZE - 1;
-			/* explored state didn't use this */
-			continue;
-		}
-
 		if (old->stack[spi].slot_type[i % BPF_REG_SIZE] == STACK_INVALID)
 			continue;
 

-- 
2.51.0

