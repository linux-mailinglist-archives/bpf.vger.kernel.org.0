Return-Path: <bpf+bounces-57161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3828CAA6633
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 00:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 708E53BEC74
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 22:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB831A0728;
	Thu,  1 May 2025 22:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIfWmsci"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322E61D6DBF;
	Thu,  1 May 2025 22:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746138628; cv=none; b=Td95UENczt2qoyWAgFlQ2+LuxX0XhWBeyl0LlvMEwJpfWOLuHgq0OcygeZMaYhh2eyfIq9KRcc9KHUUopfkLG0JTLt2+rCvSoEhMcvhPjikFpXqb+8jA7sFSe+CGeLIkNY0Nb5YO4uIQN1gIcxST5B4MtIQ5VbGLicIb8OkpkwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746138628; c=relaxed/simple;
	bh=J2xlN2MKg+jZFLM4cidgDunn23asrqY5ojuLidh+RJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RIXyqHI2+WiambfuAnFZ/jrwm2iAqkfCRk8GCKmzc+i3lWxWv0TAa8n8JQEIEza3tWaswSNR2Kpt/vNss1ABePdnoHdH08xUtg7YgAS02ECtTDq5VpR5VJ7WFqG1vQI+QVTMK0Xkcb7a2YdqKxJwZr7rgiiJpqPD1Gc4n4gOiys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIfWmsci; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ff64550991so1179787a91.0;
        Thu, 01 May 2025 15:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746138626; x=1746743426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vGJYNqx3x4F1f1Flq8KMEpewuVHohO9K6jvScQ08hq0=;
        b=JIfWmscivJpBSLRvVhpLP2FujYPnbqKmzoJgra0q+3W/g8Qp6wExYHU7vNh6iVCOmS
         pcJshcOfP/osHW0+eWg5P0W4AUAZsiua7Wt9GVLWiGYWuXOn+ufNyruh4mE1nXNmzF0p
         xjpCstXtUiHmpYOF8TzRF/w56e/VOTLNCsRv0l3nSW9KU2BxWyCJRdFvS+uakZ7wwu7m
         6CxAuzvd1ibn/FLcJpjKjGmdjVf1BUikeuTbaNWAOLA6QaIX8ToPh/tdQZc8BQdmeMz1
         5Pxl4aaXqDEysnGhSHZWTPo7hEMvN8q1cyh71pK9AIVm0nK19vkawJvtLFD2jnYImh8r
         zxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746138626; x=1746743426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vGJYNqx3x4F1f1Flq8KMEpewuVHohO9K6jvScQ08hq0=;
        b=kt2PxGtqtLb7fKirlG9iqI95sZrkNek+qUF36hKP74E9EcY9MdfybNLRqqRdljUBj8
         z2pllPE7ymhHkc+EJEL5/pxTeo0hqVsJoAPRGgdpNwPUGDiwm+mwWrgI4yo8HrKM+g/T
         L5kgmhjR0IM/p/FvlqUnmkszFo9/kxa9gTt/RWdPvhD8TaNitu2iWjxISFnUNwLPd59s
         xfCUHK9tZgv/OiwwPRBXdg/QG9CFrryW0n4t5kY86yqVo2Sj1FXA5RpRex5XSqZLSeFF
         KuNPlF1WgLwGWrzc8ZLRtpcD+Zuk/Bf9iIiuNN48YvczS6ayrbe/AVf1YXS2gh7Pk1D7
         S7JA==
X-Gm-Message-State: AOJu0Yy/BjzPXVzmOgjJbw8CW+8o3c57MR7RUEu+u1dQt2AyNn8DHBJ/
	qtWI9IB59ljrpkS4teQ8SI6mcm31ulEL2ntlAPZ1pMX/tnKaFEDdhYnlOQ==
X-Gm-Gg: ASbGncvABXeayCBnqiqqrnEyuNkc4EkkZg+1VR5f+Pk1tBn9r0AYSHIYe7c7gFFB0XP
	xFhXaospt/LsOTD5iNOw9YqmDT0rpAyQz5rtwceoHiscP57gKBbUjnZ6xMqOd6pvJZQ7ynISVfG
	/CtW9wIMVeyHeFu1sgOtIrT8sxZ3akMOoLQABZYY5vVvwil1zGjoW4BizJelf3OeZPGV8RR3WmF
	ylxanbkJiipDzgaflkcSNO4Cz1kIR5Jtsq+KwX/gBbxLaWv7fXqMdJkA3q8BRqmOg9IsRD5etUP
	ff46jhL80ZgWfseVwiH6/iVm2ii2vEU=
X-Google-Smtp-Source: AGHT+IFoq+QTJSbfNwfFYD/N4bfU29bvNeqEEhS1rCRtIh8hEWh+U+HudWqCQWfCJ0/JFAkFWOOPqw==
X-Received: by 2002:a17:90b:51c5:b0:2fe:a0ac:5fcc with SMTP id 98e67ed59e1d1-30a4e6b5c59mr849156a91.34.1746138626041;
        Thu, 01 May 2025 15:30:26 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a474768eesm1472074a91.16.2025.05.01.15.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 15:30:25 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	xiyou.wangcong@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next/net v1 0/5] Fix bpf qdisc bugs and cleanup
Date: Thu,  1 May 2025 15:30:20 -0700
Message-ID: <20250501223025.569020-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset fixes the following bugs in bpf qdisc and cleanup the
selftest.

- A null-pointer dereference can happen in qdisc_watchdog_cancel() if the
  timer is not initialized when 1) .init is not defined by user so
  init prologue is not generated. 2) .init fails and qdisc_create()
  calls .destroy

- bpf qdisc fails to attach to mq/mqprio when being set as the default
  qdisc due to failed qdisc_lookup() in init prologue

Amery Hung (5):
  bpf: net_sched: Fix bpf qdisc init prologue when set as default qdisc
  selftests/bpf: Test setting and creating bpf qdisc as default qdisc
  bpf: net_sched: Make some Qdisc_ops ops mandatory
  selftests/bpf: selftests/bpf: Test attaching a bpf qdisc with
    incomplete operators
  selftests/bpf: Cleanup bpf qdisc selftests

 net/sched/bpf_qdisc.c                         | 24 ++++-
 .../selftests/bpf/prog_tests/bpf_qdisc.c      | 95 ++++++++++++++++++-
 .../selftests/bpf/progs/bpf_qdisc_common.h    |  6 --
 .../bpf/progs/bpf_qdisc_fail__incompl_ops.c   | 41 ++++++++
 .../selftests/bpf/progs/bpf_qdisc_fifo.c      |  6 ++
 .../selftests/bpf/progs/bpf_qdisc_fq.c        |  6 ++
 6 files changed, 164 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__incompl_ops.c

-- 
2.47.1


