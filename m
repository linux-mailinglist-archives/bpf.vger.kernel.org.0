Return-Path: <bpf+bounces-49236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B26BFA1598C
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 23:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 448393A6F47
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 22:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC77E1DB37B;
	Fri, 17 Jan 2025 22:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCVU+mfv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5F01D7E33
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 22:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737153479; cv=none; b=PGKZiU331PfNUg9/xrUI0WbM6jOG8JwO9h/8z+VgGSzWtE53vGJASaT6+FkXy19lel6UwYK71hy51qFfNXYEFJzdEtVFqS6yD7LxQCWXjX4nxkUE4322Ixd58r1Tri/DSG5e8P3bp8QcihJYwSTYZJpOERgy8XSq7H5qRyYp2hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737153479; c=relaxed/simple;
	bh=gTSprHR/hfigzaN19Bcv1Us9MLPYWThCnj0x2rHpgnI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EXiukYjObCVO6Mbn/D00QID157unJjfiN8GjB6U3XE3Sl+03cPHtXq6FI8ZSSRV8d3Du32TStEKF1hA1P6SuAeygdqq4uITjk3Jc8FHMLA431SlFaquLYf1xhtRxoNl55YH/+WU8aEow7zamuB+Rm9SEXr1HUvJHjVW/7OaFGCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCVU+mfv; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso17866105e9.0
        for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 14:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737153476; x=1737758276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tLRnxszRbqjGFVVXWEBWGth3QEQNaNJCYXh852jX+EM=;
        b=cCVU+mfvwTsIYplWiFFZwDOTDk8UjgHBhGWB0uXObwSL9bl5bS7UpGRICgmQIEUqdv
         agRsOC7mMokazo1b64wDcP2GQmnKl7RH45jYqzU8hDyzbKGI8JolbGsLsgIvN3PEXbQW
         2qiWGQrbFE5Zk0kR6TBbP5aV+KZzaMXj/CxGGaMSCpn/zTqBj77zBXf7M3zjH7CDvi8E
         yAAmhkbW6wjsW+5nRGzyaUfnPK9jlq76LKDSpr/y6UZCj1EEvQPehC4KIY3hVVL0AX1K
         jhaFeRAvNFjBU3y2bUsRca9fMtr3TjGbkX5NMF35bhNP7PIqx+dVE7C/jFVFV8M/Wbdp
         mJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737153476; x=1737758276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tLRnxszRbqjGFVVXWEBWGth3QEQNaNJCYXh852jX+EM=;
        b=CzqMGAokqLsbvHsJahgXsgNNboTAyfPt9SvEz3hejiCEXnJeyu5GFr6T1CrIdmKpLd
         71/bywLftqABrkHdkf6gaRmufhhvM0T2eK2BkbBbolGgITXiMWvzn6Et3CzJgo4nmGa5
         Q5Qn9eHPPa2l1eCZMSPqHYPtpGj1+YSAbC608R1/V+Wa1KKw4gObQ/Ro26B11MWdZweV
         ydgk09Xwxym48aE1TIwkoAuZtnPdGwv7xBiMdYXGVt+IuTeOtAoUgGABAq5s1U6Z3k73
         tyYRmGtlcKXgMZY4Ijrs/CmDsiUZOlbJuKXHhmhCSEW0TH+Fdiwn4HY4tw+qVexj1Fp9
         ezqQ==
X-Gm-Message-State: AOJu0YyEwxh3HFHbQz9ygRBFhDIphhsi//uboolOZmi1FSI2L9O7aPfd
	ENuy8FTqZr29sF1PexCCwFbdnkhwopPm+kVxY5WA/nikAf+5PdDZy9w32JtfeN8=
X-Gm-Gg: ASbGncuy4NsjoP72pTJOqber/NT9q8OK3UGcIGn2CJ6o2kdKp/JmX7N2l2WHp25E+Yg
	pVuNkx/8v0ha83NUtRyJbcnxVgrp6dgd670rrJrGVhlThs1iTPE+MhXKrJoXNHud02QIO03KNcz
	HN8KpEcmzfCFGARGjcLsKiHBwQRQPMcM6G88LcFnj5lHLyaGjMX+lvl5A/PEPstXQxy0IsOg9hK
	WfERbeC0PgFT2MoJMjCWw2IjdMqISDn3h4NW0DO6wGaJR6DfRBsBoya0YhN
X-Google-Smtp-Source: AGHT+IF6THGlYI0M5bzJ3CfMzeypkvvm/Qh4fhTxihvsywWUxTJKCnzpYN1EaAFNIjdDNAiydHK8MQ==
X-Received: by 2002:a05:600c:a03:b0:434:f7e3:bfbd with SMTP id 5b1f17b1804b1-4389142e8b5mr44857215e9.23.1737153475498;
        Fri, 17 Jan 2025 14:37:55 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:1a::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c7527fd1sm108784205e9.31.2025.01.17.14.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 14:37:54 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 0/2] Arena Queued Spin Lock
Date: Fri, 17 Jan 2025 14:37:52 -0800
Message-ID: <20250117223754.1020174-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1630; h=from:subject; bh=gTSprHR/hfigzaN19Bcv1Us9MLPYWThCnj0x2rHpgnI=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnitusPwHi18/wMpIOoS2VyDjokHoRLvkG/T+RLsxb 5hibv4aJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ4rbrAAKCRBM4MiGSL8Ryj60EA CaidxfKwcOaRsYRjdpTBWwEvg/gWcChxbF7oRb9cl+MXvekzm00paN9v5sC38zcoJ0gCN5ZEeSrrOO +2a4nls4w5jazYcz2ozbfm1IHdUwJttDbO89jZOKj4DSNc7Tf61iSP4KDws04HZbRaBOmzpzYokVcE UEl21FeteptUapy8rFQxnP5izmNVpEyaAziP6x4Gv7Toexf9Rw5WWlIx2BnZXdyVLliKr+UuL8Uhjw UayQsBYO9fI3cYnFCMWMWVxc7TmhR9HWkW9pO8pkY38XVGJTOJW4r8ZcMSpI6ON0b7v4eYVG3Zz92c ciyfLEoHKjHUtAboDOoV7dowQU7LSo0lS5q2dEx9wdTfkbjAko22K9o5HJZzdfTCFb0TQOssIAoUra 0jTwy4iNHmhjGVyZHrWOBOZF6UW33icDS/7sAK17Q9DotWN6+E8I9livs+IeORSd1wqpXX2U/eo+7s E+q7c4SDkq2TfMxfc893E2D+jdHkLER51tlGsEE3KWvw4fnWnSfmDrQjO4uPltPkXXtf0Cgq37r2Hl NRML8CzCEH6zQ84f5OPI7BWj1gEZAYi5kBBYQxA5kfv63ij7w2S3W8qckzgx4VqhcWvZFGKuJicEvm sqQOIk9XDLLn79B+nBMu93weX4FYPmkUAiYBgdOmMwl4wUqljrkSqdp0T9oA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Hello,

This set provides an implementation of queued spin lock for arena.
There is no support for resiliency and recovering from deadlocks yet.

These are split out from the rqspinlock patch set as independent pieces.

The maximum number of supported CPUs is 1024, but this can be increased
in the future if necessary.

The API supports returning an error, so resiliency support can be added
in the future.

I don't return ETIMEDOUT when cond_break fires. First we don't clean up
the queue properly when it fires, so the lock and arena is already
corrupt if a deadlock condition is triggered. Second, it's not trivial
to bubble up the error from xchg_tail and other helpers (like
smp_cond_load_*). It is better to instead implement resilient spin lock
support if we want to support proper unwinding in case of deadlock
errors.

Kumar Kartikeya Dwivedi (2):
  selftests/bpf: Introduce qspinlock for BPF arena
  selftests/bpf: Add tests for qspinlock in BPF arena

 .../selftests/bpf/bpf_arena_qspinlock.h       | 441 ++++++++++++++++++
 tools/testing/selftests/bpf/bpf_atomic.h      | 121 +++++
 .../bpf/prog_tests/arena_spin_lock.c          |  68 +++
 .../selftests/bpf/progs/arena_spin_lock.c     |  49 ++
 4 files changed, 679 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/bpf_arena_qspinlock.h
 create mode 100644 tools/testing/selftests/bpf/bpf_atomic.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_spin_lock.c


base-commit: 01f3ce5328c405179b2c69ea047c423dad2bfa6d
-- 
2.43.5


