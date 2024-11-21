Return-Path: <bpf+bounces-45312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D239D9D4522
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 01:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92B5D282F48
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 00:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40048487A5;
	Thu, 21 Nov 2024 00:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpt/YYFH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0736343ACB
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 00:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732150414; cv=none; b=OenLDnlSfjlMoz4JjDnwyhfbheCq0xGY94jiatXeIpKiwqaD0ie6WU4KyJBkwOoIhmxbmIztT87Xg8IFpEifC4zmYaisib1dL7J+IHwdBXOfrUwMuJqlbuR/Q9RDDGtB9Fq968ecI/qgbxWlUu2Xa5Kf9YU90N4VvUbop7w9csw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732150414; c=relaxed/simple;
	bh=qnjBdR2e2ldmtPixeCRg8Dx30TcEkEKFQj6mZBC9gCU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ScKGqeyBTWToPChHzWUeX4YK2NY/hk3EZaGj9uJ/YWFVK2cGyJX3QeAFS0H5ueYCGQvcEqBTK5myg4vwIT/Ik3HiArIIjuCLmL2P/ng7/WrmBZ8pME05fh+VLRkY2zx8Wai0/6O0bf2l9CZBv++VlBaqUrHWJMH+gWSURBD808w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpt/YYFH; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-43161c0068bso2636665e9.1
        for <bpf@vger.kernel.org>; Wed, 20 Nov 2024 16:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732150411; x=1732755211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u1pHrYh1xm1FibEElssDPU98af9TzT40sSY4fm1Q/qM=;
        b=lpt/YYFHKrvcoBbu+wrt6zZvIzfI9NLo083H9jC5Gn/cJBFUK7D3Wrl0gYfappOHYn
         4tLZzcjoAfysw0gaF3Y4qELvZeo8p8TomSC00I08nBdgTJLJ1SoaDcJHxnnqQetX0wS2
         fQuRsVo0btPZGowWZtVXLSMiagmxvRH40Sy9EIyru+zlf48C+sKz3X/krDPHE9qS4SkZ
         U4qsNgxmcMdLe2OMxPEldQgNZ07ipzhMHWWGTwUlMcWJIPbm5N6vAp/1RsJRESIys6g+
         WegYIjGMQK991pHi9fhL8paaw9VE+GbfoGIRTdGojnR6JClQEMk3CGSZ5Y74Iar75Qw8
         0FGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732150411; x=1732755211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u1pHrYh1xm1FibEElssDPU98af9TzT40sSY4fm1Q/qM=;
        b=ToEIGGNCGSaMV6H9np6hfy9j2BgpgAyOK4zO1gz4Z6DHygH1jyHKfscTImI76CyBh2
         JXLR06Tl288PAi1mpqZJu7N5RyG/EGARbJqw+117klhpNHWZOAe+vKJ4pIoE4win6Plh
         M0uszCK3obU4UDELAuVmCdkviIyOuVcRPsdBGjflYqn+huGgDVPXRDEtf0cTLtIY1YYt
         tmY6imL1JolkeSdLy4rYj3JICF+D3fpaMNt1LDbJvwKUs4QMiId50A86vQ29/fV6+iO3
         ypO9FC3PeRuJySSjrJUFXZkovbqPPQ/S5HJxDgOpxpquZOh9L15d6q5W8wfvpoAJranZ
         +aOQ==
X-Gm-Message-State: AOJu0Yxn1htZvO/3Imjd3LzHtPOmeW6jDAjz9C6Cmg24JKlYHVMphXXh
	8qBLtL3aeodbX2epTGtLS1IkDBjTx69lnvcJf9zmoUJoKOTzkopSx58GZzCT
X-Google-Smtp-Source: AGHT+IH96RWIDbYTVhVpF+fBAizMyJWTqPxece44FR4SbpeSJyfNwIwcM/nf0JWU1S/vOZYXulwlUQ==
X-Received: by 2002:a05:600c:19ca:b0:431:52f5:f48d with SMTP id 5b1f17b1804b1-4334f02a6b9mr44568555e9.31.1732150410805;
        Wed, 20 Nov 2024 16:53:30 -0800 (PST)
Received: from localhost (fwdproxy-cln-019.fbsv.net. [2a03:2880:31ff:13::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b46343e7sm35590235e9.33.2024.11.20.16.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 16:53:30 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v1 0/7] IRQ save/restore
Date: Wed, 20 Nov 2024 16:53:22 -0800
Message-ID: <20241121005329.408873-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2839; h=from:subject; bh=qnjBdR2e2ldmtPixeCRg8Dx30TcEkEKFQj6mZBC9gCU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnPoQ26xchXZ+wI9ZWrsbLF7Loz3GVVO6PioFJJbm/ 2P4YlMaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZz6ENgAKCRBM4MiGSL8RysdcD/ 9m0RObo/yuKIfEafBK+am6XKXC8jJuvmM/6pQ+eeDBl8y+8wqIXmXbpBuBq8AOsD2q7lqnG1NPRGI7 f/oBIT2a6fack8Sfkcyu5HIFUnKkyryhJTITyn23ituS2ceGfyLPfw8yTcXmoEL2BBLwGp6UpEUP17 KLxQC5yjN1Y3o+05ppsAqXjgMy7Gkeck+99jE+PzluVXobkZcueUQ65JWkENGCRRjF70kNFPyeJVks n1AMrZT7/dVxmefUxXcdgfjLAL8BJ5xaFZ+3XDuAC7lSqFy2qTHSwkDEaRjuXVL1CpUObwB+GbpxT1 Wf6Nfk5CWWUJ1cYj3okPcdg+d9SLEggB4gWlRaa2jxx8FixefHi9uxUP0OQBnvvxr/UX18nUEfWeQB W/mjmgzusYa5Uh6fgHkrXQ3gyrgQIfSf9TR9WLa8mBKDQnqX53abHzB9+yvkQNXmC3f6aCFJbgbMlA ZdDEsHSWC+BysSR+t6xN1a6o4bkZ4Kiv23mHbOo3KXqUAF/Q3potv/yy3VJ7yTTd+xIbl+03SEaV/2 auXRym6E/h8vwsFE3MBg6qu4Hi9IaPA5i+0mwfJoOQnWyioZLyOH+QAu1b6wk6cen4JXIffvLzNHM3 DumUXXQh2sUyQzXmR5mNnJB7Hr9w1bYrpGeKRnHs6Bgqk8nRgW74Zr6cFDxw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

This set introduces support for managing IRQ state from BPF programs.
Two new kfuncs, bpf_local_irq_save, and bpf_local_irq_restore are
introduced to enable this functionality.

Intended use cases are writing IRQ safe data structures (e.g. memory
allocator) in BPF programs natively, and use in new spin locking
primitives intended to be introduced in the next few weeks.

The set begins with some refactoring patches before the actual
functionality is introduced. First, we rename bpf_reference_state to
bpf_resource_state, and stick to calling pointer resources as actual
references, as the meaning is right now mixed (with lock state
management functions calling acquire_reference_state and
check_reference_leak not considering lock resoures, causing confusion).

The first patch also takes this opportunity to eliminate code
duplication where possible. The second patch resolves an inconsistency
in the same set of functions for managing lock state, in preparation for
later patches that require passing bpf_func_state explicitly to find a
lock state.

Since we now manage locks in bpf_func_state alongside other resources,
this is a good opportunity to consolidate all other resources like RCU
read sections and preempt-disabled section tracking into bpf_func_state
as well, which is what patch 3 achieves.

After this, patch 4 refactors stack slot liveness marking logic to be
shared between dynptr, and iterators, in preparation for introducing
same logic for irq flag object on stack.

Finally, patch 5 and 7 introduce the new kfuncs and their selftests. For
more details, please inspect the patch commit logs. Patch 6 expands
coverage of existing preempt-disable selftest to cover sleepable kfuncs.

Kumar Kartikeya Dwivedi (7):
  bpf: Refactor and rename resource management
  bpf: Be consistent between {acquire,find,release}_lock_state
  bpf: Consolidate RCU and preempt locks in bpf_func_state
  bpf: Refactor mark_{dynptr,iter}_read
  bpf: Introduce support for bpf_local_irq_{save,restore}
  selftests/bpf: Expand coverage of preempt tests to sleepable kfunc
  selftests/bpf: Add IRQ save/restore tests

 include/linux/bpf_verifier.h                  |  47 +-
 kernel/bpf/helpers.c                          |  24 +
 kernel/bpf/log.c                              |  11 +-
 kernel/bpf/verifier.c                         | 540 ++++++++++++++----
 tools/testing/selftests/bpf/prog_tests/irq.c  |   9 +
 tools/testing/selftests/bpf/progs/irq.c       | 393 +++++++++++++
 .../selftests/bpf/progs/preempt_lock.c        |  12 +
 7 files changed, 889 insertions(+), 147 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/irq.c
 create mode 100644 tools/testing/selftests/bpf/progs/irq.c


base-commit: 2c8b09ac2537299511c898bc71b1a5f2756c831c
-- 
2.43.5


