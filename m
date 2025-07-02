Return-Path: <bpf+bounces-62075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E5CAF0CAF
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 09:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 989BA4E0E1C
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 07:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C987122D795;
	Wed,  2 Jul 2025 07:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4N1PL+p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070AA219E8C
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 07:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751441791; cv=none; b=G3RhWo01H83GEz0ks1v91LmoujLupKaiaNkBPtaHaysFA/L+7+XKpTuukEd2G489gBKe3c3CQCW7KfbsDWef85+ZiiHo+VI2Lv485lQhBNtCh/XizuE7L4BmnWtUFtzEoPZgjoTAvBvZH4/sIoVnuf+G4k2sL80IItCRcpLOEJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751441791; c=relaxed/simple;
	bh=t7GENUDKI9GKBt+ib829I09rpfAE18pqQo5gBefc6z8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fty5BV/5sVl2JPAJCeD9CpvRtatmK/03pqVTeJCTD26tbSrc0FRnrnIml5m5rvAxggizMJIgXPJwddNzCYVQ38qc1g5pQHEJgeDOv1Mf1JmDzOWQWRDyUvRVNNEqE0fSCaO8fDUh6eQBv/QaDWkBt+sCMC7K89RRAADtcqbrrpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4N1PL+p; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-748d982e92cso4946709b3a.1
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 00:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751441789; x=1752046589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GSIVK0ZNUoVj2b8BnYNIyZMvvVDF8nRwB0n7Tq4tYMM=;
        b=b4N1PL+p6i/HewxwxfovXfi6CM4SllaMFQJAZngkDqQn1jovfhAafeEo3nZWLfUSHr
         rtxjbw+wOhZtTlDTK+j+paSrO/AihQTozMM5G8KweHFymlJPCqGoSgQizMROg2+8xdF+
         hDr3cEnySEE39XoBbLvQ7yvDSUKzwCX17FhpY8U5NokmuohgX4YdwSfojurN0eQ0tKW3
         CRxFfFLawtprQMwlQHNxUDxERfroVo4mecT5mVlKBz95Gjno4k0cnUmj/D5HvwUyI9Qv
         8s82FC0BXB1F8tUWlpgN2zq6aPO/ryY2n8G8ste8lsyoTEQi4l+9vxcpcHsa9OiyHKxZ
         vTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751441789; x=1752046589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GSIVK0ZNUoVj2b8BnYNIyZMvvVDF8nRwB0n7Tq4tYMM=;
        b=UWMGeddlkG8gAxRFVnzXAKYwNpq0MJOP/HxJ0j306ULH3DZbUexjV2dH/I9WsxWtkc
         iKQmSslmzo4PGMSRBrSEGiseZF97YNUxy080XULoYtzWWROm+4zlqJqkdqtmlRxLR7MS
         xQ3vkzPrOvaLfgDETjWpnfQjN3ti+GtLVzZF2W+p4RXX9drSl1C02KRmq0iUl/zQNXmn
         qYJ00l3plLE+epN42XYSJGXbU1EuxCpM1cauQCgsmKCLlcKREctt8oI4bRoKWKqic3nH
         nQ8zeX2uMFeybkdyU+XJZx8ihOTL3xdojhDJ/phuZbGVViD/4E6e+x+BAKuXjM6pr6dx
         0G6A==
X-Gm-Message-State: AOJu0YzHOwFBFIwEHV9ht0COTkwiVbL3loBwz0/vzWkQa2lynP0oBRSL
	pc6weUIYWD/zpz6C+y3Ng8uOVw9A0miZvWnYV5vaGKQEro/xh0QjwJsrA37KqQ==
X-Gm-Gg: ASbGncv4m/mBQ2NGiCbLY4VlhwQGx1sTDnT7tXWTK9dhXD+cKUQE9rYv9cTMqfrnmuy
	24U3Y6ihqObQ+SohgNvpN+WTxz5lYHX3BwtQSr6SEMLMY0uAfoy2OYSVO9Zv5soQmvY+nqYzXFY
	ZPmIwVkelHwer8zDpRMJPUvrox6Zs2g4J1eaJCwETExoUP6SuP5qiYnvfn9iUGaPF6eeeoJOrR+
	YLnwrIWcxGnrehbuYjV7Xrw9mlUWzNNRKABvne0fNzfj2/rCMjuUNkwjtliZyspuydY3A3DiJSG
	2cN3aMhTseJKYN/1yHMHa7FT6Lrq9OoVCEmfyPMaQKas5pOmFIjjDvR5mw==
X-Google-Smtp-Source: AGHT+IGbNv7lGy3KICq/C0fFcvV4Ut5zac/mF3h4H4mTILj6ysevL9HhDxtgoRaTqhE4sfqFik2jhg==
X-Received: by 2002:a05:6a20:7f9e:b0:21f:ed74:7068 with SMTP id adf61e73a8af0-222d7e9bfbcmr3802348637.23.1751441789034;
        Wed, 02 Jul 2025 00:36:29 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af57e1699sm13122736b3a.149.2025.07.02.00.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 00:36:28 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH bpf-next v1 1/2] bpf: avoid jump misprediction for PTR_TO_MEM | PTR_UNTRUSTED
Date: Wed,  2 Jul 2025 00:36:19 -0700
Message-ID: <20250702073620.897517-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit f2362a57aeff ("bpf: allow void* cast using bpf_rdonly_cast()")
added a notion of PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED type.
This simultaneously introduced a bug in jump prediction logic for
situations like below:

  p = bpf_rdonly_cast(..., 0);
  if (p) a(); else b();

Here verifier would wrongly predict that else branch cannot be taken.
This happens because:
- Function reg_not_null() assumes that PTR_TO_MEM w/o PTR_MAYBE_NULL
  flag cannot be zero.
- The call to bpf_rdonly_cast() returns a rdonly_untrusted_mem value
  w/o PTR_MAYBE_NULL flag.

Tracking of PTR_MAYBE_NULL flag for untrusted PTR_TO_MEM does not make
sense, as the main purpose of the flag is to catch null pointer access
errors. Such errors are not possible on load of PTR_UNTRUSTED values
and verifier makes sure that PTR_UNTRUSTED can't be passed to helpers
or kfuncs.

Hence, modify reg_not_null() to assume that nullness of untrusted
PTR_TO_MEM is not known.

Fixes: f2362a57aeff ("bpf: allow void* cast using bpf_rdonly_cast()")
Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a352b35be479..525a21dbcce3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -410,7 +410,7 @@ static bool reg_not_null(const struct bpf_reg_state *reg)
 		type == PTR_TO_MAP_KEY ||
 		type == PTR_TO_SOCK_COMMON ||
 		(type == PTR_TO_BTF_ID && is_trusted_reg(reg)) ||
-		type == PTR_TO_MEM ||
+		(type == PTR_TO_MEM && !(reg->type & PTR_UNTRUSTED)) ||
 		type == CONST_PTR_TO_MAP;
 }
 
-- 
2.49.0


