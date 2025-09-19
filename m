Return-Path: <bpf+bounces-68889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0374AB87B5B
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 04:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DB9C1CC1F3C
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 02:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985F5270542;
	Fri, 19 Sep 2025 02:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXTVGL2x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C235244693
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 02:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758248346; cv=none; b=fvHG73rNfOYdLQ3K+ptSFL6tieRzvUY5Jl97Z9uUXEwhk+BsNHO2gx4XqsWjuWJ5LleJjjdBVyIhGL0EvGrV5TFfTETiD86xHI6o4mMHhip4PB8Py3m4o47Ge3ozLiyPYktw8dewAHfbDEpNDh4oQa0OWw1pfaGB1L4CdxIuKrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758248346; c=relaxed/simple;
	bh=tQEwavZW8I3QPZTtdV2GRVDFEUSqPb6DPgbIr2MRLpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GRJIWqqLAMsHPwiiNR+pJ0qNPr8GyGQv8n9kr6CW8zLEFB1Urv73QSEZcE/iOXKyG5IO7b8QgYfMgZTSmkxjkfuIm78zFNHg1ouCa1VdHWjeyKzugfY5MrJTB1KMDu76tGJ070efZpvpLdtf+oNMwcL1Bc1kzDGUFFpCYPJkIgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXTVGL2x; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-25669596921so17592065ad.1
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 19:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758248343; x=1758853143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4VJbpQ3MhGq9sXiotBn4IS7UlUwQONwZgzY7RcqO9ME=;
        b=TXTVGL2xp13O6tiCN7780GMLl/F+djknCNAbeLA80PIo8NxELZ+yiKzdlnKAwo0ZVB
         8nFl12XVngiOzZCggRwb6iH6HY4VB8tEhsvUUgH2ID/NVcmB+sMeitCVGVP7zQYH39mu
         njK8DoxSCgT9ho/6InbjpgMNMVoaXJD7lPLXcD1g3CMnQUUUkkCD3i6xcRHpRwAbS3u9
         D089LszMBCpjX22ticQ7wsEhjfip3cpQaOymet8xdSZUwQXsKmmnV5JnqFHLlI9AtvT1
         kIRp2v1I9H0nH6MMNQTQCosoTMmm+GgmGZsHqIeSIMF6RbJMPvnNNX7yGwHH5FzkHTJk
         3H+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758248343; x=1758853143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4VJbpQ3MhGq9sXiotBn4IS7UlUwQONwZgzY7RcqO9ME=;
        b=OIlFpHSnvhw2RNw4YDGZfse8TvL8kUHBhDItBHMyq4LNhTMm2Px8I55TzSAbMs6Jxh
         R1NXAHVFZ+irxmlnQTg/2PuuOuIutdp184NGIZDPjF9Cx9zQqOsbj5shfWgdZufo8djU
         HNvTO2LsbE0EMsz5CSatKpyjqzEzepFsiD6c66vY5ChSy+PmHsLRqDwOIJ5fMD/1keH5
         fI3eCzr8vt0++pIul5Cydcf2e6jaTnTDAta62Hd94FJLUaVqMqGxDe/SBoJDm67i9bom
         6ZrW2iczP9zbX/HgNFikUW3zJIbZC8sFbKcw3U/6fF33jdGEE+MYMSkFT/OiqFE9oygf
         VUEg==
X-Gm-Message-State: AOJu0Yxj/QLn+ZXDL7o+E5GqausrFIi5LMYoq0Xw1k0WeWJAp4XTP+mW
	289gu/F8xG2vkEBCmQBxmCiyXT3IzewnB5ke7O0JSc8rhxZS9DWZs+bFtT14zQ==
X-Gm-Gg: ASbGncvXMjsKH2jpOWNQlU7CGuUJbPis+Oxo5W+PAyz9XtxoUeKs8E7hUPA4gBgS+Mb
	GTX7JiOif43asRLBGJagijPtjCRbCjQKPmq4GzWKNls+2/a6jChDpHddAng/QesAWIYVFoghdna
	KyDdbxtWrAKhfsIfs/Dqdby1NmnntywVYD8Qsev3o+A8vYqSFJtecdSBzeq0Kitp89y1DHhMhzf
	y4WuU1oOLqU83mr+CIigFdPXulZ5cEC7K2JwShlkf1Or6ebHwDIwPDJO1HjdJ0n5Fzex7DvFs9a
	5x426SxMfzAAe3Q24TpIIh9CLlLzFmraZQ9OSGmnMxQ4yx+FRVBDsl+EQ0YyOhOFQy4nQcGUHih
	Hmnlijs5kTIrE1Thz
X-Google-Smtp-Source: AGHT+IFotUPXnRSAo+/Qltcf/BzbkMfIs8T4qX3p86k4tHje/EmPU+8CVxDIwsremoYUmHRSFqCZwQ==
X-Received: by 2002:a17:903:2283:b0:249:1234:9f7c with SMTP id d9443c01a7336-269ba57f1c0mr20767665ad.60.1758248343531;
        Thu, 18 Sep 2025 19:19:03 -0700 (PDT)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698033a3e5sm39186235ad.126.2025.09.18.19.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 19:19:03 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 03/12] bpf: remove redundant REG_LIVE_READ check in stacksafe()
Date: Thu, 18 Sep 2025 19:18:36 -0700
Message-ID: <20250918-callchain-sensitive-liveness-v3-3-c3cd27bacc60@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918-callchain-sensitive-liveness-v3-0-c3cd27bacc60@gmail.com>
References: <20250918-callchain-sensitive-liveness-v3-0-c3cd27bacc60@gmail.com>
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
index 62eb6e92e897d12e12226fd9ff172cb0ccf76119..04cd5a66968dc81c130933517135e135d61cb4f1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18785,13 +18785,6 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
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

