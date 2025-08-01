Return-Path: <bpf+bounces-64940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9380B18968
	for <lists+bpf@lfdr.de>; Sat,  2 Aug 2025 01:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C132AA5547
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 23:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BF82367A3;
	Fri,  1 Aug 2025 23:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7As4OZl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA191917E3
	for <bpf@vger.kernel.org>; Fri,  1 Aug 2025 23:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754090640; cv=none; b=uOHo/9vx1bbxguZR2TCNXmRmfOOeICD03BWKFxOjJ/aCo7vm6iRR4LyZPNXzKvaS9rUCx3Gh5841z4/VMbLR8JcnQabocX20LVYrikrOeWqq/AJhGZPansRCgQavzL1vsVbhVn7Ver5a+DTlZ6iEL0UgJujuv5CjBpufGu1xxUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754090640; c=relaxed/simple;
	bh=3OqKsAZ8iWja4FLE6EDULOk3Eo96bs+uHL2zoAiuPu8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TYz3Co7d5sofuMuYeo6N9cUxge40RsxvNNEDv3bNUzin0hGoUpBpyCE/LrC0Qw0B1DGJWmgAXlV38En98G/jMx9/ieAbXfViYaav6vAmHRT1Msn7bSVeKng/MSgotYm16nLOfyFYBKQyeiuJwO8TW+kAlTNjCrxttziCAgnyDVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7As4OZl; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76b0724d64bso2471486b3a.1
        for <bpf@vger.kernel.org>; Fri, 01 Aug 2025 16:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754090638; x=1754695438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jUUA+TycWzgKUxSRYa5Uyh/xLusmCjTnVEZqEIU8/no=;
        b=X7As4OZlwjiBmMR3W+DRXwshIkH9Ozgk8VyiaOrWxS6mEQmVuHLsdSDQYSQiHlRWPO
         8BXg/r+jW9rnjKG9EE02GtIT9Jb9E6jmfsZv3lNumnRrxIIeZ3N0KmGUP1+Qxb0p0h3l
         XTXhyLdjnlMm6ApHOitmwmXBbZcnEqJpyjqHsj7N8MxPjanDMXQPX66oeWUCRmfJtTX3
         p6JsxSt8I4RbyGqWvAUWr45ZyWSdd2p+FZZVoDarWDiUBzAt2sUzK9Aoalk+oH5EapLZ
         q6TMEgfsjjnDFpWsPqciV4pZ1WMKnO+MWOATvYd5EHFJ+TyHV0Ym6sKqsOk6D9qT/nEw
         efGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754090638; x=1754695438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jUUA+TycWzgKUxSRYa5Uyh/xLusmCjTnVEZqEIU8/no=;
        b=UWtjJcPdszN5FhPQPD9QkAqyNDf2RX5+mIxOgUnUsPMlNVE2PEVyydyyvXt9Ueftny
         2xFhjA7l5y3RSTQCS3hYriiZXjkNBV2DV3cyb8Z6uFoBcESxwFnIBhi00/3ibsWkeUNH
         DAvDitJeWVdw4qzlYbPXhDgVnOtsbp89fSRvK0ZFrgpg1zGyuB2IsOOArUHpt8fFRO+y
         ccbwkQpp5rzjiInxf4hn1+hvJlpej5ZfL4MJW/Ikl6/Cy1dkPTKrNRskqcID1ELDhzIu
         BffeTdD6fE40buPxQ2sgiQbUnWsaQ8BQQjSYYx6Qo2YEdfFGnzhRVt51RCdfZEoDU9mj
         eV1Q==
X-Gm-Message-State: AOJu0Yzmz6PiJ5x2CelFTsAtRXXtZjAM1UroenYIUyYK1habXBpWMAYf
	gxz+Uvck6X9KV3AH6P/I+fAO4bRIXY+pi/UKJSlX1trEQVg3cKmpayZj7KyXZb04
X-Gm-Gg: ASbGncsgWcgzxtViPeaVDiABqu3czlxgJJNW8XKgrwPbR7Km82p/oIWW74pbe8cXaEX
	DwjC7OK2Y+AFv3AJ0iPrPvHlz1Nt5xgtJ3DZLtXQ6Ovm3PEu7r72vlwZPu2rS3EvLiS2PLUPitu
	E6ThFp6GixD8V5YYZhO6b0AgB9+ilft89jKFZgKEOQX+R6jz+bLi5r7VANkdGJIFXv7y1xZlAUe
	tlwygJyWl3DJINExOFYnD9ZKIIEAwAMVOQ/zT72y6g7n8/aOS2GFRJtltxcEdDDCiubfU9lWWNC
	3t6n5sLc3WEBIyPj/NwQENyZ8umbqbTEEnv8QHZZ/SZRyiEVBXWmiorYJfgNz10x2AFN3vGyE/m
	CxOtPvUfo7Mup+JY=
X-Google-Smtp-Source: AGHT+IHqoqFZGrA2ESdWIoPh6SDs7Jetpxgm+nGhLOY4lrqSI3oooggT4pmkRPPwo2r4Sg2S3f5hDQ==
X-Received: by 2002:a05:6a20:9154:b0:220:396b:991e with SMTP id adf61e73a8af0-23df90d1e42mr2091186637.32.1754090637697;
        Fri, 01 Aug 2025 16:23:57 -0700 (PDT)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7e4b75sm4281685a12.27.2025.08.01.16.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 16:23:57 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH bpf v1] bpf: correctly free bpf_scc_info objects referenced in env->scc_info
Date: Fri,  1 Aug 2025 16:23:30 -0700
Message-ID: <20250801232330.1800436-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

env->scc_info array contains references to bpf_scc_info objects
allocated lazily in verifier.c:scc_visit_alloc().
env->scc_cnt was supposed to track env->scc_info array size
in order to free referenced objects in verifier.c:free_states().
Initialization of env->scc_cnt was omitted in
verifier.c:compute_scc(), which is fixed by this commit.

To reproduce the bug:
- build with CONFIG_DEBUG_KMEMLEAK
- boot and load bpf program with loops, e.g.:
  ./veristat -q pyperf180.bpf.o
- initiate memleak scan and check results:
  echo scan > /sys/kernel/debug/kmemleak
  cat /sys/kernel/debug/kmemleak

Fixes: c9e31900b54c ("bpf: propagate read/precision marks over state graph backedges")
Reported-by: Jens Axboe <axboe@kernel.dk>
Closes: https://lore.kernel.org/bpf/CAADnVQKXUWg9uRCPD5ebRXwN4dmBCRUFFM7kN=GxymYz3zU25A@mail.gmail.com/T/
Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0806295945e4..c4f69a9e9af6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23114,6 +23114,8 @@ static void free_states(struct bpf_verifier_env *env)
 
 	for (i = 0; i < env->scc_cnt; ++i) {
 		info = env->scc_info[i];
+		if (!info)
+			continue;
 		for (j = 0; j < info->num_visits; j++)
 			free_backedges(&info->visits[j]);
 		kvfree(info);
@@ -24554,6 +24556,7 @@ static int compute_scc(struct bpf_verifier_env *env)
 		err = -ENOMEM;
 		goto exit;
 	}
+	env->scc_cnt = next_scc_id;
 exit:
 	kvfree(stack);
 	kvfree(pre);
-- 
2.50.1


