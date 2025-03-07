Return-Path: <bpf+bounces-53588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC92A56C4A
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 16:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4CF5162533
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 15:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23DA21E082;
	Fri,  7 Mar 2025 15:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="ohRXJIT2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1C621D590
	for <bpf@vger.kernel.org>; Fri,  7 Mar 2025 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741361937; cv=none; b=QrgINGdBeKELAHjdKdZktEIFhD2xMcWXhhOiRMpvUeXVlJkY3cgzNmjX/x3KIfo1bTEEsL6IY5T8vDwu59hcSxw5qNIRYZDmsFkxLw0xxUIhG32TBTRHh17QY2rX7UbBUboRf/vBFqWi+cj02O9z/lmZiz9o2z6ncnrPY3pQBd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741361937; c=relaxed/simple;
	bh=gdazFW1apSN79+3Z18MP7RSxLu5cGxKGUqoPiVi/lVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NeIm6ix+7t9xzWSRA9NjNtVCaka6j/Rjxs/0dkqAoegEMe/1UFt83/QvI4qj2J/BIAvwtzRDMDayo6ppVufLCINFUsa2FC/St/bICMLjXJxP4xYFTLbhl455eodzp4iOCyeU8KOprHuVH0wpc9dsMfz6B4Cv9Ekhw0v3rDXp4YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=ohRXJIT2; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c3c91060d0so243271185a.0
        for <bpf@vger.kernel.org>; Fri, 07 Mar 2025 07:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1741361934; x=1741966734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=woKeEB0XfstwYoXnSQLgcq62qAgRcRMxjyKXXAOpGuw=;
        b=ohRXJIT2qYdMrrNnfkPY+zZ6q/PYDxTeOJur0cHQYZPraco7Rz+SShKF8RJwsilEYk
         ZyH/ZX0/uurzKYRoLjuPSNqzCoGCtNqIqGH+5DmVqw/Pmha/EuX6mR+BBa8n2axM5GAo
         sSLC5N7Xe3tHgBMBgreT8a1dTZKSXViFS3JhL75ynlpRdsGwl3xoCUIeW05cxYN1IX/l
         8N4Er9BhZG9wuBXjXIsguKGXHNrychGfa+YcgGKcBXxG7Ow6JWfNXKq2HcGGuqxAoHVm
         0U+k6rCaATkuaB9EZqDhRzZe0hzxc3b+Kmjgt0xthqlz/A1nn8X3Q+E64obMIfRzYcxz
         Zryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741361934; x=1741966734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=woKeEB0XfstwYoXnSQLgcq62qAgRcRMxjyKXXAOpGuw=;
        b=GBfC+C83lYxoS/5UdH5GzyL9f1uh2xmoY5MlH6qVgci8oJWXbIRMMVzxapyHdMy/bB
         Ic4Ona2jRiklF8Uw0TkWg1cwsnboxug94DYDAcgrTVRTB6mF0RKIQi5OTebPIQZQNKOH
         fMI96W9B7sxuZ1yddn/GspxCRignyZ2mAr5mmgI5tmgIdeubhnTkfi6KCA6/f+3prZU9
         jwjSyRA5fic1OO4HNnnyqVKfhyWSPZhpQxZFoaJpXv7McLUuRbpX9SZIt2VOY8howNjv
         MlBecyLRoK3FZr3NorvADA9lKCO752h+zT9wCadMSfaCnIqJoYqDMg4Ib30LsL6NAO44
         P0Xw==
X-Gm-Message-State: AOJu0YzANHt7ypFqrCAYrvcxKbqvTn/IK9l/994ACeKKmuMDwAFjunVm
	mPnKl1t6uTELoeeK1dofqFcL9emCDqy6Lbe2lJi0uQOIDHroWTDYfM5SclmR8M7VvJJWGrKcAzs
	8MMDVnw==
X-Gm-Gg: ASbGncuY1I1Ss8nqA4UdGt4F+cKhI0KL3fcxqBpzRSB0hWyw0iMnXYWyuXo0orvjpSh
	b3N+UuE4l/R73iHrIRxhJL7RBY50vnfUADSGbdgBYOZ9yacfvXkr2XTujJf2v8/kkgWK/xxWtQf
	NkKOOIXYPZX3lWzAoo3POKottyzCJwlQoc5dIH1DytxbKbmKTF79D1TIqmJNgxerq2xSPQTAoPA
	xW19IN0gFVHRvjFU0akpGw8m6SXd/eNDyN7QM4BCBKGAejBGpZRkhBeDsSat7iYID/Sm/IFpTdZ
	1co8HM1u26yxzoohmqXBjFsSx71uGfaEN13JCsBdhA==
X-Google-Smtp-Source: AGHT+IEZkRT56yFHIJVAXuDhg64KYYz6vx5t6DpccOrk5kp7/M7wrXjc2EBohHUOVzr5TkMh29Fqiw==
X-Received: by 2002:a05:620a:268b:b0:7c0:9df3:a0cb with SMTP id af79cd13be357-7c4e61b96d5mr669882485a.53.1741361934349;
        Fri, 07 Mar 2025 07:38:54 -0800 (PST)
Received: from boreas.. ([140.174.215.88])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e5511c63sm253828585a.113.2025.03.07.07.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:38:54 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	tj@kernel.org,
	memxor@gmail.com,
	houtao@huaweicloud.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v6 4/4] selftests: bpf: add missing test to runner
Date: Fri,  7 Mar 2025 10:38:47 -0500
Message-ID: <20250307153847.8530-5-emil@etsalapatis.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307153847.8530-1-emil@etsalapatis.com>
References: <20250307153847.8530-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF cpumask selftests need to be added to bpf/prog_tests/cpumask.c to be
run. However, the test_refcount_null_tracking is missing from the main
test file. Add the missing test name to properly trigger the selftest.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
---
 tools/testing/selftests/bpf/prog_tests/cpumask.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/cpumask.c b/tools/testing/selftests/bpf/prog_tests/cpumask.c
index 9b09beba988b..447a6e362fcd 100644
--- a/tools/testing/selftests/bpf/prog_tests/cpumask.c
+++ b/tools/testing/selftests/bpf/prog_tests/cpumask.c
@@ -25,6 +25,7 @@ static const char * const cpumask_success_testcases[] = {
 	"test_global_mask_nested_deep_rcu",
 	"test_global_mask_nested_deep_array_rcu",
 	"test_cpumask_weight",
+	"test_refcount_null_tracking",
 	"test_populate_reject_small_mask",
 	"test_populate_reject_unaligned",
 	"test_populate",
-- 
2.47.1


