Return-Path: <bpf+bounces-78500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 433B0D0F923
	for <lists+bpf@lfdr.de>; Sun, 11 Jan 2026 19:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F5613021E66
	for <lists+bpf@lfdr.de>; Sun, 11 Jan 2026 18:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533BE34F46D;
	Sun, 11 Jan 2026 18:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQMiICfa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB4D34EEF9
	for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 18:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768156249; cv=none; b=RYb5X0a9VBGKxACLeSrDXf1NChZ05vlXzISYQ5uCMbBMGWrDnTgzvdhGbfi4v/AUIBkuY4AxpCPfSV7cbRuGfzmQ5d8wVNET6lNINfmWgkSqmA0+FzuKJCrQGl3VRD/PAKN0M1FZMBmzCDu5ZW8iFSY3uGId/rfL+/O3MuzO9/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768156249; c=relaxed/simple;
	bh=27/hwHfRplEYOsAj/mEqpxA0rzfoNrjPMXEP/7OgZEA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pdKhpsXNA7dsqwYhF0RXqWCcH5ydNwTLF2CqEnyKhY55HO2sdbtPhJXS0eWpMzGK8OFy4ULQMHkbsr68PMZUUzoaEUOJgX7bRRvaktgB/39f8CDmVtl7WlmPrJibjWIOnWLLE6G4gzT+vq4pRr/zgEDcqHT17xaqC3I52yr09Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQMiICfa; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29f0f875bc5so47065165ad.3
        for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 10:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768156239; x=1768761039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VLXCGVwOxr4nQIa+VGVURzIZv8X8WoVvvqo03YCIdJE=;
        b=IQMiICfa/D1ZQCRMG/bpglaZYjFnfY6X/fV5lZDie7bP3KAbnoD4XeqpA10OJWccox
         gfoOvAAQtXGAjpRAFP03ABSycsxAX59bKWbFoPOLctu5VoNodjErjyv74TzDgS3tIIy5
         tJPQWTyytTkMXMpzNC+RsfAMvg4xatD0AWaTh6aI0Sp7JB/sWTS9uizjptE+fS18To/F
         4fJ9/xNqjHAFgtVPqnPsFQskjA2nv4qbqkAb9+Ejj3fbmmL9MsPatdjIP3+SgOnsroyI
         U794V+4J2mJFMOTrKDo70xG8tUw1dWP86V/pvO6YdfzrUayPJ3UwmcM07pFwpu/eTZTQ
         ykxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768156239; x=1768761039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLXCGVwOxr4nQIa+VGVURzIZv8X8WoVvvqo03YCIdJE=;
        b=HnpoGTyeyHlz36wPtMWcmyugkF4XFDXQ9gR2dhRASXvnHfXWgPO7htgWaxaBUQZ1rp
         sjxi9yu3pWkwucm019Q//nlBulnRAypuZxlyaT/wh/t0cwe/IsUX+pty1faKk18RSbps
         18TdxXzN5AqNNIgNTSOMwJ/jyrT9C3AEIXZBixXtOCj0sTRZySIrtOKM5rPkJcP0HDrd
         TV3HGdCSPHy/jDuLwnJVEQoWY84j0s1y2u8yUqKP3GZ6QMvwRsagrufCOtFlxuSf/dng
         DIq1p609EVxr+JKyDf9LbTRMYzfthtxJAqcVnWsdLukGjDNYDXkGjTNmXuyfobQHYd/A
         +Ovg==
X-Forwarded-Encrypted: i=1; AJvYcCXebAXh1g5IMgtF/Zqq52/NBqoDPnEbu4nJVW9MzpuNS6KdqBIeS+lcKLpN1rhD9fQf3d0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvw2vLlM2vQZvwSe9OHbvZ5CzMRdcoP4LAZslo2JccgLulmz5m
	/zjLzFS/VMZCCEOnH9yGZXNVSfaRImtjWmf3i6rEkxBwZp+FF95fdEQ=
X-Gm-Gg: AY/fxX541aHpZ9qdGeL/kwjgeuWCA8ZjiDkoZf6S9Lw0cwiwM7bFmF1EE55dwXiPR8K
	jOZS9j0NG7seuqCpRsVyKHDRcpzsDApYTihrL5tbe4kDoATSk9vSGYpvBj3TAiN72mEF+L9HyUy
	1nVmZ8AAd5BA4Nziyusyfj5MlPsFm8vg5p7nRb32eIdkBcQw096nbyI/PeuFwwtx82X7WbZ1Ys+
	goCFaG6ytxwoqF9XwRMmZmmdfYc5TNQyHmAUl+Lpl+anjFGRaWEVACZ6tCo155SpfTNDNXGwrfc
	nBKN5Mvm3OKH5ejxNlwlNnaTIv28gZ09QqqlA7vIeln5Z9/pJb4dwHhzsWC0oXjPNDRnXrH7mmz
	BIOdn2SnUWGj5gqj0ra/+kPWmeeq3skljOIn98id+MTNQToQJqoJpYCnGU+Kg69WNd9ED7myexB
	V9YWxhrKfP123a8PWsJCSnZvH2DhQ=
X-Google-Smtp-Source: AGHT+IG7tGdXNVW+K8M3zBdcOr6kzP17WJTO0ouLD6AX7yzqCXjKgsGl8uc5QXDKvcm8spRxsXZ06Q==
X-Received: by 2002:a17:903:1104:b0:297:d45b:6d97 with SMTP id d9443c01a7336-2a3ee47d2b6mr129007745ad.14.1768156239347;
        Sun, 11 Jan 2026 10:30:39 -0800 (PST)
Received: from DESKTOP-BKIPFGN ([45.136.255.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3ba03f9sm152585615ad.0.2026.01.11.10.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 10:30:39 -0800 (PST)
From: Kery Qi <qikeyu2017@gmail.com>
To: andrii@kernel.org
Cc: martin.lau@linux.dev,
	bpf@vger.kernel.org,
	Kery Qi <qikeyu2017@gmail.com>
Subject: [PATCH] selftests/bpf: wq: fix skel leak in serial_test_wq()
Date: Mon, 12 Jan 2026 02:30:24 +0800
Message-ID: <20260111183024.2273-1-qikeyu2017@gmail.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

serial_test_wq() returns early when ASSERT_OK_PTR(wq_skel, "wq_skel_load")
fails. In that case wq__open_and_load() may still have returned a non-NULL
skeleton, and the early return skips wq__destroy(), leaking resources and
triggering ASAN leak reports in selftests runs.

Jump to the common clean_up label instead, so wq__destroy() is executed on
all exit paths. Also fix the missing semicolon after 'goto clean_up'.

Fixes: 8290dba51910 ("selftests/bpf: wq: add bpf_wq_start() checks")
Signed-off-by: Kery Qi <qikeyu2017@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/wq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/wq.c b/tools/testing/selftests/bpf/prog_tests/wq.c
index 1dcdeda84853..b32e22876492 100644
--- a/tools/testing/selftests/bpf/prog_tests/wq.c
+++ b/tools/testing/selftests/bpf/prog_tests/wq.c
@@ -17,11 +17,11 @@ void serial_test_wq(void)
 
 	wq_skel = wq__open_and_load();
 	if (!ASSERT_OK_PTR(wq_skel, "wq_skel_load"))
-		return;
+		goto clean_up;
 
 	err = wq__attach(wq_skel);
 	if (!ASSERT_OK(err, "wq_attach"))
-		goto clean_up
+		goto clean_up;
 
 	prog_fd = bpf_program__fd(wq_skel->progs.test_syscall_array_sleepable);
 	err = bpf_prog_test_run_opts(prog_fd, &topts);
-- 
2.34.1


