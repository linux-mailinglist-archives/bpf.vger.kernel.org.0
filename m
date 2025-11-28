Return-Path: <bpf+bounces-75737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 05315C9347B
	for <lists+bpf@lfdr.de>; Sat, 29 Nov 2025 00:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DCD14E102D
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 23:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA8F233704;
	Fri, 28 Nov 2025 23:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVcFspGJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4457225F7A9
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 23:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764371749; cv=none; b=rJIeu8yYe7BV1rqi3HqTsvPBI4fzAcrFEI1t3/v7e/XFLGeGtPFgsOfSphr08NbpLxRh9GTtfG2pOh9rL4NFyEkaHZ1ciE3OGHCIDd9/mHiel+T77r6Sb8L2dnxxR1DHh03uJdmMdOLGRzNHENVUQ2IwbT32aZNl9GoUmdXqVz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764371749; c=relaxed/simple;
	bh=keruzwDSvWDu/kUJKCToJsGsSZVyVDLp7caPlYe+0XQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S0a/NOptrQ8pOUHYnO3SHytOgXcOENB/BS4B0k6KjxUgPGBz04w1m168vJg6hM96UtlkQWUOt9z9dPoOijbHmDxniCiou3DC6qcK0SgVD2xFEXx8vaM/9wuFBwDxtcj7au9JJ9LxOqWfzCeZ36rey+RkwzEwfE4wqOLZU40eWTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVcFspGJ; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4779a4fc95aso22617145e9.1
        for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 15:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764371745; x=1764976545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9R+2lNVxnl/8OosIbXyK16HD/6wbvcxsInG8E8NzAn0=;
        b=EVcFspGJIDpGglkb4rGuXftsCJ6MWkvRThkgEZ4QLU9WruKXeeEvcVOV5H35jWeTH3
         oFBHs6xar0WvPJT7ytog3M4fKQZxjzy2nuOW5VM1XQfj9c+ZdLrGuHsWtGsD8uAcWhLg
         d/9PkCEXuOGwizKIdcpvIhfOJgLL7Xb+fXkb73TtC6I2Yj1oPtXuPqNVUYg4bFRXTkEZ
         LCnuhqvgJJ/8aCIUyTVyTSU6wUFFbVtJVfP0WCGs/74leyB4pdxRTBY6JTiWCyQFecRe
         WI/eAoCZ4cgm77ARrXN9GJQJmhAhwJyLou+xLi3t4ucSGdcRYnlkFhnFr+OyFZ5QJw0V
         nLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764371745; x=1764976545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9R+2lNVxnl/8OosIbXyK16HD/6wbvcxsInG8E8NzAn0=;
        b=PZwvg0ltOLG6Nx7kL/+ALKT4TTHyjLyAp813f469GxL0+Ah1k47agt5chXwG+CnfPP
         UUc/eW/AqSEeeHjPqfBfrlw3syi1S42b7xpJHFiQaPJJ1feBSjbbQpogGtKZWP/oMM2u
         c4HecDcMl6boG6nYb0Qkvi5Sbw9FIUfNoE+My8VXy342vZdkGO9DINwt6YEf2FDomSat
         RRlwJ9k3SAYQbE0iGNJR6wpVTzL1pAzt5x/kxby+pHPrTELviZENfLzImpJqQgHTAsup
         6NQ5R2e0X2E12UlbMO+P8sVqOmn74o8njLGHySaTS0p7aIQ2960hNqZJiBSBcgvd9Bko
         ZDdw==
X-Gm-Message-State: AOJu0YzGkN1d4obVm5p9xxRCzwKB+RVdKMEUCtuwhWg1HYjrFIgRTUpO
	hoZqsmMLKaWqOgl/XnlD02+ZFligsOM0mgTZ9uPaljG7jr7IYpdf18bVFMONKdNz
X-Gm-Gg: ASbGncsyIZD3SB63kxDgb3B4pg/PSfsSBllFIK+of6zAugI8OgyPDdejTmaJ4ItFkeJ
	I/9QoTu++APQx7s+slKTepdj6tiIm0rYGsOc2hM20hgb/MwCfmLqJhduK6+RglrmcfTIjUGk0/9
	joFNgB/Lm87VMbXWy9Ivhsm5u4OKPi4tPDXKrUdUBOBSslNmizOOyGbp6lOsj6zxUDhS2JSqHyQ
	s+CTYdE2B7629MQyY7KHBqu8ovkvHvP0oqXPUwSgsnKtggty7BxByYi4IZAWTk64qZ1zKaTgDa4
	/J6YMiahg8MvsSH+m0pE3Lenqpzs9GLa58CiqdouJKkHOIa8sgJmou+ThJlPICASnorfz94LDol
	4CEPeZ4f2BDLfqtZfY5U8rmfGeejY76UUxy3ikEhsSdNddWrNunpevZJ9xIRXzWPYllBUE7rZrT
	WPsl4r2cGhIF7mWNeWxCDlUi7dA3O+e36Br4T1NIFZl1cv1sXxVHaqYKl/6ROiyVaW
X-Google-Smtp-Source: AGHT+IFZ987aBP3hIHHMb4At8Xe4FJtf/TSd5GMJp2SZ3b87q3WBz5wYTqj2/iY7RtnWKoussof5wQ==
X-Received: by 2002:a05:600c:444f:b0:471:665:e688 with SMTP id 5b1f17b1804b1-4791529a337mr60696305e9.17.1764371744990;
        Fri, 28 Nov 2025 15:15:44 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4790b0cc39csm180891915e9.14.2025.11.28.15.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 15:15:44 -0800 (PST)
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
Subject: [PATCH bpf-next v1 0/6] Limited queueing in NMI for rqspinlock
Date: Fri, 28 Nov 2025 23:15:37 +0000
Message-ID: <20251128231543.890923-1-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2045; i=memxor@gmail.com; h=from:subject; bh=keruzwDSvWDu/kUJKCToJsGsSZVyVDLp7caPlYe+0XQ=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBpKiyMlwG8kkxTjjpQjPw1jYmUpzLHDioF+2sIe iIFQym7YmCJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaSosjAAKCRBM4MiGSL8R yj9kEAC65t81fcTEgBNbUQSvc5ljU725V8i6DKajxTITJDk8TyWLqUGYtRiz98UrJ1Bjs6GnUGB R+/bJkjKsj6N9A2L/NRVSMwldiGOg+e5zW3ZoMgZGTdEacC/AxO0MUufgzGObSmvOeN7l+GkzG4 rjmZFTs0uDORC23uLKoQKMDbSofrWl2Kxv6n4teuFf0GnIxdRm6/w2oEhnva/kAs3bkzmCqEQsE lNv79aDMrvMRJ1zrj27h0hzhCrRdLHe5ZtYAxrEphyg1UVFW4Gp5MnLDtNfJ+TSAjOZAxk9ULYu plpSBpA683T74n95DABicYVpegYjr5Zhk4YGLebjG95FFRG3fR5txYbG6jtlJKt/Mh8/wT6TvLX mXVoDHNlbf8PPx1xIaMWTXXTpG4TUzR2Z2Gcg2n/0TzIPE29YTzKB8d9eOUMTCJwSqLw2F9dOS+ 4/PQlozfHneiPjttWLKg3C0529oESXIS5lgStBx1RBJAJk7pO3teXAKpl2Nzyr+AAeO4R6AbpJ8 iH96n86ng5krww4mR+zgp/Nxks9aBVIDsVqAk5RdT62XvBai1HlJjTW8gaZcj60ARIC2RsK9l/q BhOAJKBDQ1LhqD8pLXMk+kOgs9Lxm5PqePlQu5UMIZWpeEv4ViP2QgMoq77B9Eq9XvE2ZVIcDOY xCBaPmxPDWKwijw==
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

 include/asm-generic/rqspinlock.h              | 60 +++++++++--------
 kernel/bpf/rqspinlock.c                       | 67 +++++++++----------
 .../bpf/test_kmods/bpf_test_rqspinlock.c      | 55 +++++++++++----
 3 files changed, 106 insertions(+), 76 deletions(-)


base-commit: 688b745401ab16e2e1a3b504863f0a45fd345638
-- 
2.51.0


