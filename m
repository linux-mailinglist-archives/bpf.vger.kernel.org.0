Return-Path: <bpf+bounces-75749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BE872C934AE
	for <lists+bpf@lfdr.de>; Sat, 29 Nov 2025 00:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0BB824E1173
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 23:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F2E2F12D3;
	Fri, 28 Nov 2025 23:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJ5lsTot"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46232F12BD
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 23:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764372487; cv=none; b=Y0BDZm2uuYMdEPh4C3gtP8P+20jWD1BtZumvg8jG7WN08lg36P8DeYcb/NP6zIGB3QcRheGQMnd03M66ItvTY3jQxItr7hO8I2LIcfm/D+pRVCFh9oCrjcKyiGsY/LQuD1yc7yjYVRiyjgLyjDc9xib1voKqI8CXMsP7PrUyY4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764372487; c=relaxed/simple;
	bh=qce1bJWVy9XZMOthFy3QNZjqYtSGZsYTx+qE/SWDYMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R2XGUUWTy1Ekmx3+migkHzPdWA54MIwGQoS+oJ9QtcY8t/q+7/KrGPb3SDiHs8lDikkQK4oryUEp8iyK2zy56p8phV6HPyED84qZVIdWhNdS67C4B1U78Opl9PmBEFSer/MVif9wjgGhIPLQ888BFemsNUebqnEFxSkTKkxu88w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJ5lsTot; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-47774d3536dso18837915e9.0
        for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 15:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764372484; x=1764977284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RQZRM9M44r8tSEveackOFEeZKH3D2GnTasb4Kq502SA=;
        b=nJ5lsTottrULnX6QuA+bmzaQk9G/a9LHFr64J177wumB3CiUSUwgWzAr9mvHW9O6ey
         NcZ6PUz2mgI5geXQHi65g2Ond2hDJ4IOf6BOVc1T5UkNT4li8kqeAPIXDSjLPBmai9cA
         ucqB+6h2wcb6Tl81hEcbAF37cssxCTYaF/UXOJ1arF1uGebGGoLdRhHwGiQD8/JR0kw4
         PObRth/y91hKqY7FWxS1b8DD4oMJMhOxhre/PvOnWx080vmdBgYpk3cYE+Oqic6/EVg7
         6wT8kVJe4JdFssGq5uTHhyLaEDuOqrPeOezP+bVZnZTBBZef4N13/1TVnk7IRbNbzaFe
         6+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764372484; x=1764977284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQZRM9M44r8tSEveackOFEeZKH3D2GnTasb4Kq502SA=;
        b=Vwq9TLvJqpbgqRG+GKWapIYt4Zu726I2ZB2Ed+C5k8TFcjxLxwUaMF3IGS0xNrnDmR
         wJAgIk65aMTw7bqGLEnJivhTeF7WTislMv/Z+7Qq/nB8hC9f9QfxDe1XFno3/56+bpIg
         zun4x0xxIn/0JPE4NrvkcXInf/pO/vFiHTp58tewsRZUSN/C00VeK6LzIWOLcCN7DSCf
         4a6GAIQqgr43C0KmIf5QSFE933ogHnEu016ajhVmbXct2SpyOt36tJVHiHokVjoSWRLT
         vbIa/28LmqFsI8BtF9hfypEhNfenvCQiScolc0yMqrV16pGX9pmNBgNBwcOKWSsoiPvq
         EhBw==
X-Gm-Message-State: AOJu0YyOfgV8JtMwuuG1Xr5DrMD8Im5qOVCdzpWQALtmRHXeUqRW/AbM
	4QF4jR4y7P+R1TOJmX4V4RGyuxkIuREOViTjjHS+Pc6RWN7Lz0851h06PDO9layp
X-Gm-Gg: ASbGncuvDgE8pQH0iiE8/+J5NxCv6da3JdbCFMP59JPWTU6mwnvlYLRfyS/CdQU8KYN
	lrBZnPp0zBiHgP7gIKlxa6jh1Juc9aJwYNMLVcGM3NlZx6ePgjnEHxuhTf4Zny0VICGi1xbUauY
	s+WIIs/UAe5flTDVp4mJH4y+rr0Upe6YEqCPhns6Yq1thmxtvLq/dBBCj5XB5Un8U7cfhSA74K4
	Gij86x6hJNf8BjLY3e7srjgT4sw3lpC7iZ9Tbiqc2vUdY+3iR4kYnnIt8E/pQgJzXdfG5wToVqj
	V5DhRF3392rk5ibOE+B5aBkQ++YEUfSHnbCPinCSSyS3utuaZi4dRDQdo/twzH928nJdaYnn1AH
	wsPxUaZ6p0CACsT34uwhWs+uQNgfV7mAp1krMHPsahBq3yGzPYuDq+Mzl7Fi0kU0JUEQ7IQy+NV
	YccQbglC40HRPskKlIthqZQtFFBhYKCU5qTezvtcrLyWoAADPpY3mrYeZOlb3R/FmZMgEgvqYVU
	18=
X-Google-Smtp-Source: AGHT+IFIK+q+bQMK4R79eUpbg2bkAjEpNkdIyrC7xcHKE0X/WM1a4NmUbPV0AZVfScPWEywgl3NtTw==
X-Received: by 2002:a05:600c:3549:b0:477:9fa0:7495 with SMTP id 5b1f17b1804b1-477c053069fmr290939735e9.14.1764372483681;
        Fri, 28 Nov 2025 15:28:03 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-479111565a1sm107232365e9.5.2025.11.28.15.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 15:28:03 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ritesh Oedayrajsingh Varma <ritesh@superluminal.eu>,
	Jelle van der Beek <jelle@superluminal.eu>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/6] Limited queueing in NMI for rqspinlock
Date: Fri, 28 Nov 2025 23:27:56 +0000
Message-ID: <20251128232802.1031906-1-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2044; i=memxor@gmail.com; h=from:subject; bh=qce1bJWVy9XZMOthFy3QNZjqYtSGZsYTx+qE/SWDYMc=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBpKi/wnfGR5RFZ5pZVVsJ8R4Cl7MB9cLBLWk8qc fV1oeolJ36JAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaSov8AAKCRBM4MiGSL8R yhq+EACxG6O6kYAbnEOiohC/e3q5WzsrPTBagFuOddiRwKn1XietSGVUg9k3NU5QPzaNkjK9dSy K+sKi0HFoLgY11439TNJK46p3ou2hN0QTnPyewezMqYNhhhTjkCeIQlMdbMHho4n9z4zU+agF/c no/txQImBDtu38Qm8K4LtnEYcTDFrS/33j38qnmiWLMYWcrWTryaZqzMekQhI6lknTblnE6Y6JL kSpSaqSht1ju2yjaVEGVz70wjK74vKBfyK8OJJgCZgzYmsOeWPBaOLylzHDiut3RVnPzPgqYU0n GX+s9u6Jh3JPAz5HGs8MR7uEigXcl5dFpYUHcc7YLVRWBtmaRjGr0K4Z2BZHfJSwm+7AP0qB1UK JYu7OBcWT2bDZlXinLZuWQIzAkr8X6Gd4bos7FZPKxjooldL/f24TurN3btC9SYy4L5aJf54sl7 9+2Ax1c/x3VJHRU59knaDcTjR5EDVUaMkfGYzIe3MsXLWacXLanTY5hw9ViOE7TfASne4oMCMFs nEHU38VLCuYH5Txo79TrWCtImcBjBgSSZBAlCK1eMsEyLz/0h4O/Dsya2WcUCWueM9eNl68Zn5r OeSEN3sbeDXwjOXcLNoIJ8Sf1OzZ2NKYZIM8JYk+Z0FhzcsKrO0iAyuKVgXaA5uhaMSyqFltECD X2dR6kytAjW5l0g==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Ritesh reported that he was frequently seeing timeouts in cases which
should have been covered by the AA heuristics. This led to the discovery
of multiple gaps in the current code that could lead to timeouts when
AA heuristics could work to prevent them. More details and investigation
is available in the original threads. [0][1]

This set restores the ability for NMI waiters to queue in the slow path,
and reduces the cases where they would attempt to trylock. However, such
queueing must not happen when interrupting waiters which the NMI itself
depends upon for forward progress; in those cases the trylock fallback
remains, but with a single attempt to avoid aimless attempts to acquire
the lock.

It also closes a possible window in the lock fast path and the unlock
path where NMIs landing between cmpxchg and entry creation, or entry
deletion and unlock would miss the detection of an AA scenario and end
up timing out.

This virtually eliminates all the cases where existing heuristics can
prevent timeouts and quickly recover from a deadlock. More details are
available in the commit logs for each patch.

  [0]: https://lore.kernel.org/bpf/CAH6OuBTjG+N=+GGwcpOUbeDN563oz4iVcU3rbse68egp9wj9_A@mail.gmail.com
  [1]: https://lore.kernel.org/bpf/20251125203253.3287019-1-memxor@gmail.com

Kumar Kartikeya Dwivedi (6):
  rqspinlock: Enclose lock/unlock within lock entry acquisitions
  rqspinlock: Perform AA checks immediately
  rqspinlock: Use trylock fallback when per-CPU rqnode is busy
  rqspinlock: Disable spinning for trylock fallback
  rqspinlock: Precede non-head waiter queueing with AA check
  selftests/bpf: Add success stats to rqspinlock stress test

 include/asm-generic/rqspinlock.h              | 60 ++++++++--------
 kernel/bpf/rqspinlock.c                       | 69 +++++++++----------
 .../bpf/test_kmods/bpf_test_rqspinlock.c      | 55 +++++++++++----
 3 files changed, 108 insertions(+), 76 deletions(-)


base-commit: 688b745401ab16e2e1a3b504863f0a45fd345638
-- 
2.51.0


