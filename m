Return-Path: <bpf+bounces-77504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B058CE8DDA
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 08:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30DFF302B75F
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 07:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BFE2F8BD0;
	Tue, 30 Dec 2025 07:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6BpYX4U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9AD2F3C07
	for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 07:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767078810; cv=none; b=ijbAbaUDc7LRV4NSCnyhvX8gDB8koDZtpMsIP2Ozu3jXddxSHXtTqYwKdWZ4wQHlvV7ppzjSen8uTr1YtchoPg52d2cDSZjR6nRModldnKq7v6MMmQrvv5kFjHc8Md1Hqy9UxpRO2Dfn5h+OmjTBtTienNsAWjvPQexJTFdP3Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767078810; c=relaxed/simple;
	bh=td2r/7r2fR0ea4eKTiiWL2qDTt1g/sa7gSUXH+m9BrU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g6UhsnC0qBHKH4vJphLDSFHHjIOy2XivlkMZ7XZIVonWP/FAAwfZpYl9/XFaoRAd6CEJOHm7DDSRg/R/aJSzC0OcfuESeSNxSXnjWj67Whja8E8ASDVpdrQ1dKR4FnbUpaBNJ5k9nGp2boLeLKIbXUqDY8y1YEitf8/30BvaZHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6BpYX4U; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so8357356b3a.3
        for <bpf@vger.kernel.org>; Mon, 29 Dec 2025 23:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767078807; x=1767683607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xJz6NgaWCb2qaXDuRrNDREMtuLJHuzwHPslg7t5UBfE=;
        b=b6BpYX4U3VD8+cd8atICEPp7ccdSmQfKFmnS7otxuXb6cMl2t8aSLLnTXBR2puuJT5
         TJAaG89k5xoAe5YFm5HbpsY5OhYUk8E9VD1e0DOrc4g0bTnqQkruyYZQxDFChOA77U+h
         lsz6RR6Y+Aqf8y0Uc4GSeV/srLnq7SvU+D8C5Gp1q7d6NObCidTK1s8Xbkkk/kdMl/rh
         n11X9dtEcH9HwFaAXL3GoM1mDyk3WaWZxiRSAcTAnTvOWAcInTBGHJin1WdOwqMedIC4
         janpbbuTuX1cGD/KD77cQLDYDWNXZ0Ni6jtY2lmyi458WeXuUvorzJuWP4zDiHKTMgUT
         2YtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767078807; x=1767683607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJz6NgaWCb2qaXDuRrNDREMtuLJHuzwHPslg7t5UBfE=;
        b=mxFizkMNVkbGrVs18YNW2kJ0Vd47Egy7k95GwRxE3roe85szE1h/TKgE4U3PssZLhD
         Kzts61QmxOvklpKHU76+fjxAqk7Fz7bQbgpRvvpmwD+gWJJB0n2bqoDODd6Ivlez72Ae
         dwoY4ggLq+ikpxj+X69n/eEcgs5N6dI7/FdI1p26r7sMKDMH/POLxjiFiy8FIZxeaCxk
         IAfFLmhPeDW+OKP+Zy+NVw5PDL1Ylt0NYujj9PNcFDL7oG02duCLfR78faAFc+ysIawb
         SwdoL/v435LNlMoJ6Y6OvYTGdMBIaw7PtQx5gat2OmgbfWkhmwwAJNP045ONn/xCOtjZ
         yNtA==
X-Gm-Message-State: AOJu0YwBhHO8OEuIgLiES2loMw5VFNIclyqvpeJfR4XSBR1pSQJbAkre
	mqnRXbn+swvP8aUSkpdPkoFnsI65//I+A0wJXkDtkoUULlR5w/qS1sT98DiDdMEHAGRgGQ==
X-Gm-Gg: AY/fxX4giZavC6Wib5va72MPRNVC7HKGziSfND6D3zr9+vDgsEKnEo41XaybcujYbli
	Bi3xkdN8blPBC0H+j9oKH6alTxaBAuvfkd2Ejozr1b2QIhLZpdphvYG+/QGVEr9unr9RUAjwlJ6
	M7yc6fd2DLvMitBwKy/DOovjtgiL4AdGY4E+MufQ6UDD4RgFxF3xcnCpwgwNdRvOEBvR4JCajq9
	oMzC4mLmHK9q15KGO6FrtnH/84WR86B+8kDzCz3QQKJw0z6NG+CVmr7HTr8AU4UiHoyLcTQdXLv
	q2xpPmZrPFcDocO/wUUBCj9J3COMlg3/5kOvaE4nAYErINPCBchU0Z4koPlRfWqxWgd6cUsOkbo
	rOBbj8p5pHOESV0fcRvVnPxQha1nRkPY6WVw4GhiwshYkv2wGfVuBP0tQJV1DDftBfSTRfCS+7u
	9dF5gi1GmWXCKXDjPcTua3KqM=
X-Google-Smtp-Source: AGHT+IF9V+J1H/LAfOR6IlDn04Xk3T45oVOdPAJfDMirL2nywsbvikPfuZ1w1+aZ0Gk0JhPLZUVrlA==
X-Received: by 2002:a05:6a20:7349:b0:35f:5fc4:d88c with SMTP id adf61e73a8af0-376a75f54fcmr28802195637.13.1767078807540;
        Mon, 29 Dec 2025 23:13:27 -0800 (PST)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e7723b3a8sm15578514a91.3.2025.12.29.23.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 23:13:27 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH 0/2] bpf: calls to bpf_loop() should have an SCC and accumulate backedges
Date: Mon, 29 Dec 2025 23:13:06 -0800
Message-ID: <20251229-scc-for-callbacks-v1-0-ceadfe679900@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20251219-scc-for-callbacks-d6d94faa2e43
Content-Transfer-Encoding: 8bit

This is a correctness fix for the verification of BPF programs that
work with callback-calling functions. The problem is the same as the
issue fixed by series [1] for iterator-based loops: some of the states
created while processing the callback function body might have
incomplete read or precision marks.

An example of an unsafe program that is accepted without this fix can
be found in patch #2.

There is some impact on verification performance:

File                             Program               Insns (A)  Insns (B)  Insns      (DIFF)
-------------------------------  --------------------  ---------  ---------  -----------------
pyperf600_bpf_loop.bpf.o         on_event                   4247       9985   +5738 (+135.11%)
setget_sockopt.bpf.o             skops_sockopt              5719       7446    +1727 (+30.20%)
setget_sockopt.bpf.o             socket_post_create         1253       1603     +350 (+27.93%)
strobemeta_bpf_loop.bpf.o        on_event                   3424       7224   +3800 (+110.98%)
test_tcp_custom_syncookie.bpf.o  tcp_custom_syncookie      11929      38307  +26378 (+221.12%)
xdp_synproxy_kern.bpf.o          syncookie_tc              13986      23035    +9049 (+64.70%)
xdp_synproxy_kern.bpf.o          syncookie_xdp             13881      21022    +7141 (+51.44%)

Total progs: 4172
Old success: 2520
New success: 2520
total_insns diff min:    0.00%
total_insns diff max:  221.12%
0 -> value: 0
value -> 0: 0
total_insns abs max old: 837,487
total_insns abs max new: 837,487
   0 .. 5    %: 4163
   5 .. 15   %: 2
  25 .. 35   %: 2
  50 .. 60   %: 1
  60 .. 70   %: 1
 110 .. 120  %: 1
 135 .. 145  %: 1
 220 .. 225  %: 1

[1] https://lore.kernel.org/bpf/174968344350.3524559.14906547029551737094.git-patchwork-notify@kernel.org/

---
Eduard Zingerman (2):
      bpf: bpf_scc_visit instance and backedges accumulation for bpf_loop()
      selftests/bpf: test cases for bpf_loop SCC and state graph backedges

 kernel/bpf/verifier.c                     | 13 ++++--
 tools/testing/selftests/bpf/progs/iters.c | 75 +++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+), 4 deletions(-)
---
base-commit: f14cdb1367b947d373215e36cfe9c69768dbafc9
change-id: 20251219-scc-for-callbacks-d6d94faa2e43

