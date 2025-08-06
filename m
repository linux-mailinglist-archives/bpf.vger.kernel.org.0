Return-Path: <bpf+bounces-65128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E8DB1C7D4
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 16:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA5E6622A46
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 14:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0741865FA;
	Wed,  6 Aug 2025 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRGphKpk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF6E27455
	for <bpf@vger.kernel.org>; Wed,  6 Aug 2025 14:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754491574; cv=none; b=Onoz1Kn11Da8sADIs1/8v6s2Q3yEQQWYjV/snzj7qEKZNBIxhIUjiqGkEIj2HIGEtLDUXyyGInmJSj1E0HlqlmL0GtCMBz+Qg9+K3gzXp05DstM5urIkJWHdR6Bybw/axi3qiVM59rbl1USJpvjk9SW8kmI0uEuOWdf3hasH1zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754491574; c=relaxed/simple;
	bh=rWn64dnsCTbTRVR7bxgVk7YwIpTWv7JHu8vU6PhhzQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A2b5A+hRLzy5hMTm75Q9Fi+tUwNeWzWSRCkiD5TBEMjCpd8Du65GhvyQRIMU7hRoJtuF5XY59Qpm1/zjIzvEkoO4poTt3au8p6Ddn1LPj9YxMEAkmLcMNt9EIi5nnZxRBorbnrr7ZgvtScFeZomEm3m5asbyl7FLMINbxfBagAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRGphKpk; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-459eb4ae596so4270645e9.1
        for <bpf@vger.kernel.org>; Wed, 06 Aug 2025 07:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754491572; x=1755096372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x6Y5/hU69HTtDjci1CKe5TdXtgQzQhi4jSJ7SjzSiJ0=;
        b=CRGphKpkM2yd4Is+kLN4wJ057apcLrJSEDyjrMkzvh8nqa4V3PrbbFxUuHGN1NUUTD
         zdGcbcBwpANeOfTLVYmeUuymtygwhaE2MPuLaIa/NwB+114JL8e2sZ5sL2RiYWllBA30
         IFSSxJ2MCSGRM3vyO1RUnKUPEG11qmJD4Frhj9259NRsZq0Bb7EZaBqMaRxOJ+UVFXyp
         rswglYohfALysNW3FDxkOYyw3c2Y1TKbezm8RGhOeqFMXB52Elmi7Frhow8cdqdrBWPG
         ZTMemaef90X4+jDtkIrevSJkMYQrdoNCC2+9tk3u7ldsCxay7C/fSJ3d2ZXUa/3msCd6
         BR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754491572; x=1755096372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x6Y5/hU69HTtDjci1CKe5TdXtgQzQhi4jSJ7SjzSiJ0=;
        b=fhCEgN+J1Zo4RAnO3UwgSZDOgmhy7vHS+6oAwVi9NyI60PmOie4FbuIGZ/BRBZawXJ
         PygSszokmMvBtkk8aBSNRVDXpMTiqNM8DsfutX0mOE0cO28D9QcRFROBF+BIiApyHOQU
         Ui4+bQKEj44e6lxKCEXeBkb62/aYT+PfPJdIfuKyuKrB3iLUTsHBjOfO7EkarjBRmS1G
         Y/9g7U41hCLr9aDaUh8adfwF9IK41iEKwsx9xx/sjsBGUuQOmlbFrDVNWrnXMWjzHF8l
         w6eWfvraLwji4U0usMswA3Tb+A27cjWhpTYtzhT2piaHt3MUkSy+8ZIMsI9B27y3biyq
         8xTQ==
X-Gm-Message-State: AOJu0YwVmN909bA8jbN09c2AXEAcMR2yGFiijyXNg6obad1BDKojFHYz
	YaPrCShwALwI7SdjEeCoKu3CKi8ExwFQUd0F0YFRqttXr095J/c7DbsF7Uc40g==
X-Gm-Gg: ASbGncspWUnVpL6LQM/o+uCAnh5M4Jgu4r1/1XrSASm3XwJcXDWkrEgvJBrKSYazTk4
	OvHM0MuwGfPJ4PNAyMO5FAjEpQlw4P8SpUNDBMrxbNvXtziLawnnKeSw64MPJZhG5U92A4Cmnvf
	wctxINweWpdfL8Zq4F3eJaqjsegVlpfKo+LwGOhWLSG+rNrEsuknx1Sgaj3IdGo+vCiurvEXygm
	iV8ueZly92X48n0oFJjvqFcNhhA3JrOLZ35eOz8TiHJ/mwggZRlOzTysN2BiX0ZSfDFeA4vBbS8
	wlUPM6sDp+NQxeFM8nARwPFgmXbJLMOUbkEynAFV51NAAdmrndIlEZcdSohH+xWM2ObZtIaA0eu
	3
X-Google-Smtp-Source: AGHT+IGHxE47YbPYvgvkXA4nz8o5XRrk3r008IBXQtJoGgbSWJQAULVtNxxUm65IO2St0ULnmZz42g==
X-Received: by 2002:a05:600c:3b0a:b0:456:1a69:950b with SMTP id 5b1f17b1804b1-459e7462de3mr25935415e9.22.1754491571340;
        Wed, 06 Aug 2025 07:46:11 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::7:ba0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5869cccsm58488315e9.17.2025.08.06.07.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 07:46:11 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next 0/4] bpf: Introduce deferred task context execution
Date: Wed,  6 Aug 2025 15:45:20 +0100
Message-ID: <20250806144554.576706-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

This patch introduces a new mechanism for BPF programs to schedule
deferred execution in the context of a specific task using the kernel’s
task_work infrastructure.

The new bpf_task_work interface enables BPF use cases that
require sleepable subprogram execution within task context, for example,
scheduling sleepable function from the context that does not
allow sleepable, such as NMI.

Introduced kfuncs bpf_task_work_schedule_signal() and
bpf_task_work_schedule_resume() for scheduling BPF callbacks correspond
to different modes used by task_work (TWA_SIGNAL or
TWA_RESUME/TWA_NMI_CURRENT).

The implementation leverages BPF maps for storing callback metadata.
Indirectly call task_work_add() via irq_work to avoid locking in
potentially NMI context. State transitions are managed via an atomic
state machine (bpf_task_work_state) to ensure correctness under
concurrent usage and deletion.

Mykyta Yatsenko (4):
  bpf: bpf task work plumbing
  bpf: extract map key pointer calculation
  bpf: task work scheduling kfuncs
  selftests/bpf: BPF task work scheduling tests

 include/linux/bpf.h                           |  11 +
 include/uapi/linux/bpf.h                      |   4 +
 kernel/bpf/arraymap.c                         |   8 +-
 kernel/bpf/btf.c                              |  15 +
 kernel/bpf/hashtab.c                          |  22 +-
 kernel/bpf/helpers.c                          | 260 ++++++++++++++++--
 kernel/bpf/syscall.c                          |  23 +-
 kernel/bpf/verifier.c                         | 131 ++++++++-
 tools/include/uapi/linux/bpf.h                |   4 +
 .../selftests/bpf/prog_tests/test_task_work.c | 149 ++++++++++
 tools/testing/selftests/bpf/progs/task_work.c | 108 ++++++++
 .../selftests/bpf/progs/task_work_fail.c      |  98 +++++++
 12 files changed, 800 insertions(+), 33 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_task_work.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_work.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_work_fail.c

-- 
2.50.1


