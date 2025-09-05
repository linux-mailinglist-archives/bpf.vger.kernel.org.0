Return-Path: <bpf+bounces-67579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7233B45E7A
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 18:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95A2F1C81E03
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 16:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59251306B0F;
	Fri,  5 Sep 2025 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZarhkUW+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1811D31D725
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 16:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757090716; cv=none; b=pH5oT68HiCRS+Qy5WHGVuq3QaDJOFLaqf7GAZcFbMn1E6Cu7/8q3RT86I+S5x7MswhnIobEuIorrOJueUlXABvPyXUkzVcBjB5P1SJynNvPgzgMsdNB3sjBm478BtJ6VLk6yx3nuf4u5JknOviUwDVM+UNRweGSbXP5dyVe3heg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757090716; c=relaxed/simple;
	bh=WglVOJbgim0b44fpOu8pVfB12ZvpG5suLjI11Ttqyrs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o1FYTy391/jYdgBpHHjwdvWgTo/cVg7QDppWMP5nl+5+l37cgEuvhAyDXM25ic23YtUyiqO9/nh7pX/M5DwhGAFKgaWf7ENNAzEc0LG7lLJmeLcHsB4wLTCZbSi5hgmBMGUIC3d318WAQqKwIqN0xhfkPEmU0jBhn7XGvUr74nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZarhkUW+; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3df15fdf0caso1911126f8f.0
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 09:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757090713; x=1757695513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Gg+KScSrbqHq6a0NCUlrZmulU5LS2c2gfkdvaj4o1A=;
        b=ZarhkUW+lPwKcCVx3uwudFAiHjyUgUYn865IEI+BRYBy9RtAezR80EoO7Uhcm3xEbb
         JISUV447gWC0iOCz9Lg2xb31wdoZROg/NGEZGhMz0I4tEXTwPa16fOBec94dKCQZNie6
         x3dk00oqUQ8HvWeXlcE9GZm6Z7Db0nn9RKYloF/IoZSpx3hYHxYaxgWa/bsgEKz61Hvg
         IYMHiHFLXLLBJr1mDjf6V3saUVlXQwA/z5+amAobMAtm56uJ4RbtMK2l9xMx2GVPV62l
         xDCCPyogAfsKzcEW3zDwa/4rZAWD/HPapyjw1hIxvJTOQpS/MW2x5Dz7YphBNnlpgpas
         vxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757090713; x=1757695513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Gg+KScSrbqHq6a0NCUlrZmulU5LS2c2gfkdvaj4o1A=;
        b=CxyUsF4BUTHBeRH1UDPuJBu3GcoKIV8HYZ03AfXfcR9C9yjHEFTaNHN7eziQtXFp9E
         RXalnM90EqYHkmdZTLRjqfGCpMbLpCBlhT+POb6pi7SABoKZNiw4eJBwXMlbEyqk346Z
         rkevamIrkx1s/PGaI3LxrVl4Ou4GxukCmmrLu2GhxagVAlfSldbSG6yDZlz7nw5N6Z1T
         5C6UlylvrJJlYNEIfaQjLh5l05MvntaQn+rEBs+0Dj+aCVaRxyfiUpVaUJkkPrB4hx4q
         i2Y3jMUKrew6uNBPs0h3EilGciqd87NsbYoHLdN/pJPzriLgUmBWuOO5aZQAvLB8z4PO
         VD+g==
X-Gm-Message-State: AOJu0YxF+5Xtfo12XSp6MocqgdLFef04v8tnrCYF5CC+c7G8uKoD8QHa
	pc9WNJ6GbR+sCbCg1guc7h6qhoSw3lW0pGV2YuQAuFCSVtQidw/RcmUexRTtAg==
X-Gm-Gg: ASbGncuGnzBhwBX4JqjX3v1ck08gOIl/sk26Rjn+t+yoRkdbiXTAGNkcO1K3WJsmm88
	Aycapzo3l1yikq12p9OZNI52eR/sKxpHJjhX4RsA1YCh+HAmR/ZuFBrRZXOzM7pJP5iAjfi3Ort
	E2L7rzUTG2iDdyVhEr6kCLilAGz/V18sdqLPL0j+DfyRIU6Nbu7C0T9bc0a3ykVuQta7p/1Yafn
	2xuDENu8puB0qJgzX2V7lcmVokI06Xf3ELgdgKPh55uHkjDZJ1+MWZ6qABqC75ddVYDBVFQSW8Q
	/V2XqQn4BLj/Hh7MbqFw5PXk5G/J9cART7yyAq9HEe2NpYRx02PbtmrXS0oT/EAi6+TiwkLi9ee
	HTuoQ38+mZ/fIDbVDflZMR2dTtkwbZCAiJk8gI/L9hA==
X-Google-Smtp-Source: AGHT+IHrFTmc6P/pbvVBnhr4DTDdDycBr+cfyLcAqPWe6ce250bcEepyA3u4w9QDwmfGXTWSRug7uw==
X-Received: by 2002:a05:6000:2388:b0:3e1:9b75:f0b8 with SMTP id ffacd0b85a97d-3e19b75f526mr6219538f8f.47.1757090713100;
        Fri, 05 Sep 2025 09:45:13 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9a6ecfafsm179928275e9.21.2025.09.05.09.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 09:45:12 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v3 0/7] bpf: Introduce deferred task context execution
Date: Fri,  5 Sep 2025 17:44:58 +0100
Message-ID: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
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
to different modes used by task_work (TWA_SIGNAL or TWA_RESUME).

The implementation manages scheduling state via metadata objects (struct
bpf_task_work_context). Pointers to bpf_task_work_context are stored
in BPF map values. State transitions are handled via an atomic
state machine (bpf_task_work_state) to ensure correctness under
concurrent usage and deletion, lifetime is guarded by refcounting and
RCU Tasks Trace.
Kfuncs call task_work_add() indirectly via irq_work to avoid locking in
potentially NMI context.

v2 -> v3
 * Introduce ref counting
 * Add patches with minor verifier and btf.c refactorings to avoid code
duplication
 * Rework initiation of the task work scheduling to handle race with map
usercnt dropping to zero

Mykyta Yatsenko (7):
  bpf: refactor special field-type detection
  bpf: extract generic helper from process_timer_func()
  bpf: htab: extract helper for freeing special structs
  bpf: bpf task work plumbing
  bpf: extract map key pointer calculation
  bpf: task work scheduling kfuncs
  selftests/bpf: BPF task work scheduling tests

 include/linux/bpf.h                           |  11 +
 include/uapi/linux/bpf.h                      |   4 +
 kernel/bpf/arraymap.c                         |   8 +-
 kernel/bpf/btf.c                              |  63 ++-
 kernel/bpf/hashtab.c                          |  43 +-
 kernel/bpf/helpers.c                          | 386 +++++++++++++++++-
 kernel/bpf/syscall.c                          |  16 +-
 kernel/bpf/verifier.c                         | 136 +++++-
 tools/include/uapi/linux/bpf.h                |   4 +
 .../selftests/bpf/prog_tests/test_task_work.c | 149 +++++++
 tools/testing/selftests/bpf/progs/task_work.c | 108 +++++
 .../selftests/bpf/progs/task_work_fail.c      |  98 +++++
 12 files changed, 932 insertions(+), 94 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_task_work.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_work.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_work_fail.c

-- 
2.51.0


