Return-Path: <bpf+bounces-21130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2582848407
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 06:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AAF41C23B3F
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 05:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FB1111B0;
	Sat,  3 Feb 2024 05:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8MrHACI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E636111A0
	for <bpf@vger.kernel.org>; Sat,  3 Feb 2024 05:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706939485; cv=none; b=gv773V5RprW8dTouGzAHMpHy3Hk2s6bA1s3EqSVJyN11Mhc2GrjirG9Lvp0G3nx/CN7xO9rvRzY8d7JPorij09gNFFQI5HMJGxIfkK66vz2Pxtx6zCGDqZLRcRjHhOwPztDAShBFhx5aCTcv/cVmpaARmUd0yVlPdSEJjIpi+4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706939485; c=relaxed/simple;
	bh=Fyrmq2ifvYeFH/iZKNZAZQpf3RUi27W7kBT61PEABpE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bGhsg2ryXaaUHiCK5UxzK2dtrrxI3/lXYQU3D2LoikZhIkoMZA9efo6cy6FxNkITds6meuia4QMmttUQq4xLpWKicocjce8h0mi4AXb68S7GhsyjQk3WKNh+fGu+4pKNgrXj8W2OInCinHvP/hjg6n8Vv4xGpYHrIYjB8Y1ZkOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8MrHACI; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-604059403e9so28284777b3.3
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 21:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706939483; x=1707544283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bc9EbQP4KhvlO8qubUZVLEubty2koZN9aeQrs7M1L1g=;
        b=I8MrHACIIBxidDxwV41+nR3YZcS22WC+IrQ5h57AQeP45oTLFcWS4ooiRzY0kt0QsB
         VyodnJ+2OKJdRHvojPWaHcWcMnnSwtuHqYs4UxzdrKXYx+8mTyIN8QgV8Vq5kHlj9NuD
         vD8ap2GHLPqUEqDMrVZYI8KJ+BfHw+thGxNBIRKcdt8Mj/WM7tmwo5Mc9xcHaHnbdADS
         YUxMKfca5aCVSfDZNGcx+3uMp0Hj+ET416oLeGKqs6ZTpyibqOsg7QCoTxtU/UW+AQ+B
         6M9XfvWSJ4oNTIqfXFGSEpRsu7QfqEKCMJn6FTwO6pOfJJiX0tgPcJvdzvmLrEUggoWj
         IHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706939483; x=1707544283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bc9EbQP4KhvlO8qubUZVLEubty2koZN9aeQrs7M1L1g=;
        b=E8aAX1pePTKlqZYiVhjziQy4lpwxbEje5taNePFEDRyNFjEWdGgNbrOuV3Dnbjy9Ee
         WU5f6Q3wkM2FtooySOOGuOjzLKm85lReOVQBs37zuSRmgWwcKRsLjAZRy4a8KtmOCzl1
         KuYir5Zj08GLxNB/XV8bdwKabsQrNhdECG9RHMwtoPHtt1lGVMt0ZHMgAqLNu9/igWhY
         EIDubzKzDm/5e0PupIixJpvchoHxlAC0EBHF0ZYZhKysnpeJywP2UiR0FLr1DMTJWzVJ
         zakrPBJQS5qIc5SNAfcXSuda6wQsiBssddnLXXUI5FIPKJObKb7UmVM8pRk8hVcDpxHt
         IUCw==
X-Gm-Message-State: AOJu0YxChO6d+NKi7OQyeyZzp2g6Pguanpg4huVQd0B/yCBHKdr41P6m
	xm3kJd3J8EIt4b+eV5N5QvWn7PipmDY5KSXGG+op3DfG/Ai27nIa3vNQhXhH1Fs=
X-Google-Smtp-Source: AGHT+IGyYj/TyUP8mMrOPVtXeXyRqXbeFbk6F/c2sA1D5vXfCDmReBJ5vD2NWjerKOHdTx5QTlTpAQ==
X-Received: by 2002:a81:4e51:0:b0:604:774:a232 with SMTP id c78-20020a814e51000000b006040774a232mr8452052ywb.43.1706939482643;
        Fri, 02 Feb 2024 21:51:22 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVV0MFcjbvz1kU3yZCljIoiEMVq666OcWo7lT0RUQTRX6j3Ya3rTESjKQke5VjlbydQFN68sHkjiq/VSfB33srO3ySSjNll/DWML/YY20Gvc732YWTRKf2+9FwNKfFIl7qL3vNBS+zwOl8A+gZQufXq+33xMVudtTQaxTPI15AUePUSag6d26LAnF+pkIyhz6heuYnL60SpNL2JYBqpQquCWJw1pgGT3bw/nfTNwnVB0ia34sIonQ==
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:6983:14d5:2531:ee53])
        by smtp.gmail.com with ESMTPSA id r198-20020a819acf000000b005e73fde0804sm817182ywg.78.2024.02.02.21.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 21:51:22 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next] bpf: Remove an unnecessary check.
Date: Fri,  2 Feb 2024 21:51:19 -0800
Message-Id: <20240203055119.2235598-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

The "i" here is always equal to "btf_type_vlen(t)" since
the "for_each_member()" loop never breaks.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/bpf_struct_ops.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 0decd862dfe0..f98f580de77a 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -189,20 +189,17 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 		}
 	}
 
-	if (i == btf_type_vlen(t)) {
-		if (st_ops->init(btf)) {
-			pr_warn("Error in init bpf_struct_ops %s\n",
-				st_ops->name);
-			return -EINVAL;
-		} else {
-			st_ops_desc->type_id = type_id;
-			st_ops_desc->type = t;
-			st_ops_desc->value_id = value_id;
-			st_ops_desc->value_type = btf_type_by_id(btf,
-								 value_id);
-		}
+	if (st_ops->init(btf)) {
+		pr_warn("Error in init bpf_struct_ops %s\n",
+			st_ops->name);
+		return -EINVAL;
 	}
 
+	st_ops_desc->type_id = type_id;
+	st_ops_desc->type = t;
+	st_ops_desc->value_id = value_id;
+	st_ops_desc->value_type = btf_type_by_id(btf, value_id);
+
 	return 0;
 }
 
-- 
2.34.1


