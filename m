Return-Path: <bpf+bounces-65304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 500A5B1F832
	for <lists+bpf@lfdr.de>; Sun, 10 Aug 2025 05:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0283B3BD009
	for <lists+bpf@lfdr.de>; Sun, 10 Aug 2025 03:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C081E19C54E;
	Sun, 10 Aug 2025 03:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NC3hcJQY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB037B67A;
	Sun, 10 Aug 2025 03:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754795102; cv=none; b=MtIkjRe6tL3/Q77vcqCBSFX3xI5KdTwCV+DeB+ukiyuspe+pU/+rNvLBRtApwODsTzYz7Fe3bMGCsiylNPUC/gFxLGEn0pSHbO48lI8QEZ0xZvvU3l+Uuv3Qjc+6WIUPNBmLNgUD78Nl2Ivx2LwouBTwe5Rp6KLqsTvk86kbg58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754795102; c=relaxed/simple;
	bh=tJIyLoVen00TFS7CFexCyg+QlNWAM3Io9QD0is4GV04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MrJOoEHU/CsXUWzYVqphxmPrJxvtOCnIxSSl78qeDOJPjM7x8N7vGCwUA3oGXFqs8hLqQcT4V5mUvyzCtQqJqQ2bHn8Lf3pnJcT5VLlCMSMPFyi33OzcBWpd3VjMGjvslEpACgsaTIAc6YKW+hq4TGX+l98FH3CpMgY/QANIH18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NC3hcJQY; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-76bdea88e12so2905833b3a.0;
        Sat, 09 Aug 2025 20:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754795100; x=1755399900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cwdAOJ4KPTMRDroI+xF3hbOwCSpb5MtrSRa/mIsBulk=;
        b=NC3hcJQYlaaSoICpUtmlR/8IjwFed2qF5DE1MEQLh+4WwW7mCLtm2q4aBXdqoo+ltY
         dQqllIjBqsDN99HjbN3pupMRuWInsi1atI6tlLWznYckV9QWm8UBIxo7yaaYuVbo53CT
         OI1/iqsN1n/bzelf+XJk6RuTJukGdpl+2XJ6HB2nE3Eas2dPWykFGIJwmjT1zFZTiwkK
         vXzmU2FpYnKgdU0edtmDez92Pkdgkwi46Segp2VjVw0QRqdHLvQFGH1mp5Iy7CQHm1G+
         T0hMVGb8pP9p521XKRaD65IzbWDi0GokP9FFiXHBfI96Tye1pnGkULtClIM+C/JYeupJ
         SItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754795100; x=1755399900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cwdAOJ4KPTMRDroI+xF3hbOwCSpb5MtrSRa/mIsBulk=;
        b=WwnJ7w54dVtie4bI1lnkDTDfCwGXlCI55MioByeGiq0be9nbNvUayo/O3f/gzzQEg9
         qxStTtbTLxeXqilqToXi/+CujmR0bjDfdajFf68b/ypv2Q1Itv6O54AZQf15FvqE/Mke
         O/Tvejm44zzoVFB7ajD2IRETZmApbpD3iATZCMH3PfNA5O6cbeOiIWX80P7kRNTTcd1I
         4tr0xDu2zq+41TduraHcN8vqAtTEj1FhR5Kk7zGGRZKqTbrIrVWdPpxbfV+nGG8934kd
         2oh996seqNfQC/RzI9nytlZoiHfeAtVrQnt1bg7Wu1xmyCsza7He+2mNzt5mGV5ZxMpM
         lHYw==
X-Forwarded-Encrypted: i=1; AJvYcCVAywDrhH7jIYaO8ydv7s2IOszs/ffEIJ3NPUX/j1Fc/gDUfdk2YUUQH2TTfnHRSrz5kWFFf1CWx/6d/rjG@vger.kernel.org, AJvYcCWagggBytvscB4aZjbRiby01sLPfL9nMWjFJlxWGtfxMgButt6hwVCOMRg6jGeHUTcXgZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo5mRGpjxYtfH3yL1XSFOLen1zMhXwRM3qQkPxewExMdXDn98+
	HR07F1fbIgs8kiUbhGtF3XtpaKZPvrhBtTeDNdfnvvBbsb/YXbb9Vvrb
X-Gm-Gg: ASbGnctOluQaa/b8adclJJvYOWEsVoHpWo6pfyb4CExmgIaP8iLQQ6k7myxUdGSncyV
	YEsw0eTiBgpi859Zg1nMJRVdMYI2uBkEfCnlYGV4OjchZUXIW0f2HP4PUNu1N6QZ52WhUFTPa0n
	pp6nJs1pjfoCeBa+UngwdU8MPPyQDqSCK9HxQEbGUC0Brcm7zWx/8PYZ3nKJbKuG+cbazOuX4pK
	F419y+hoayl5J4XhFvuQLzpeoVoK+QlqO96pOTAurgSsxM1B3tVXUFYnUHTEycjOwCEBjgH5CyM
	UX9uUdjEaZfv4kS8sFqWmE9dOXH4XjhZLIKuTYWTkfCyjsw58XGS36lkRR3E7D5TENDfI4Y4zyG
	PNAMgp//VJf+qTy85HTc=
X-Google-Smtp-Source: AGHT+IFVianFXVWgo6jiksMtr+YChn3EwsvzYT5esShUKfVdzVk3KI1n+GUa2PK7C4TyXRdOuX+H9g==
X-Received: by 2002:a05:6a00:22d0:b0:76b:dee5:9af4 with SMTP id d2e1a72fcca58-76c46153061mr12701634b3a.13.1754795099822;
        Sat, 09 Aug 2025 20:04:59 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bdd2725c9sm21276265b3a.6.2025.08.09.20.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 20:04:59 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: peterz@infradead.org,
	alexei.starovoitov@gmail.com
Cc: mingo@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	jani.nikula@intel.com,
	simona.vetter@ffwll.ch,
	tzimmermann@suse.de,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH tip 0/3] sched: make migrate_enable/migrate_disable inline
Date: Sun, 10 Aug 2025 11:04:39 +0800
Message-ID: <20250810030442.246974-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In this series, we make migrate_enable/migrate_disable inline to obtain
better performance in some case.

In the first patch, we add the macro "COMPILE_OFFSETS" to all the
asm-offset.c to avoid circular dependency in the 2nd patch.

In the 2nd patch, we generate the offset of nr_pinned in "struct rq" with
rq-offsets.c, as the "struct rq" is defined internally and we need to
access the "nr_pinned" field in migrate_enable and migrate_disable. Then,
we move the definition of migrate_enable/migrate_disable from
kernel/sched/core.c to include/linux/sched.h.

In the 3rd patch, we fix some typos in include/linux/preempt.h.

One of the beneficiaries of this series is BPF trampoline. Without this
series, the migrate_enable/migrate_disable is hot when we run the
benchmark for FENTRY, FEXIT, MODIFY_RETURN, etc:

  54.63% bpf_prog_2dcccf652aac1793_bench_trigger_fentry [k]
                 bpf_prog_2dcccf652aac1793_bench_trigger_fentry
  10.43% [kernel] [k] migrate_enable
  10.07% bpf_trampoline_6442517037 [k] bpf_trampoline_6442517037
  8.06% [kernel] [k] __bpf_prog_exit_recur
  4.11% libc.so.6 [.] syscall
  2.15% [kernel] [k] entry_SYSCALL_64
  1.48% [kernel] [k] memchr_inv
  1.32% [kernel] [k] fput
  1.16% [kernel] [k] _copy_to_user
  0.73% [kernel] [k] bpf_prog_test_run_raw_tp

Before this patch, the performance of BPF FENTRY is:

  fentry         :  113.030 ± 0.149M/s
  fentry         :  112.501 ± 0.187M/s
  fentry         :  112.828 ± 0.267M/s
  fentry         :  115.287 ± 0.241M/s

After this patch, the performance of BPF FENTRY increases to:

  fentry         :  143.644 ± 0.670M/s
  fentry         :  149.764 ± 0.362M/s
  fentry         :  149.642 ± 0.156M/s
  fentry         :  145.263 ± 0.221M/s

Menglong Dong (3):
  arch: add the macro COMPILE_OFFSETS to all the asm-offsets.c
  sched: make migrate_enable/migrate_disable inline
  sched: fix some typos in include/linux/preempt.h

 Kbuild                               | 13 ++++-
 arch/alpha/kernel/asm-offsets.c      |  1 +
 arch/arc/kernel/asm-offsets.c        |  1 +
 arch/arm/kernel/asm-offsets.c        |  2 +
 arch/arm64/kernel/asm-offsets.c      |  1 +
 arch/csky/kernel/asm-offsets.c       |  1 +
 arch/hexagon/kernel/asm-offsets.c    |  1 +
 arch/loongarch/kernel/asm-offsets.c  |  2 +
 arch/m68k/kernel/asm-offsets.c       |  1 +
 arch/microblaze/kernel/asm-offsets.c |  1 +
 arch/mips/kernel/asm-offsets.c       |  2 +
 arch/nios2/kernel/asm-offsets.c      |  1 +
 arch/openrisc/kernel/asm-offsets.c   |  1 +
 arch/parisc/kernel/asm-offsets.c     |  1 +
 arch/powerpc/kernel/asm-offsets.c    |  1 +
 arch/riscv/kernel/asm-offsets.c      |  1 +
 arch/s390/kernel/asm-offsets.c       |  1 +
 arch/sh/kernel/asm-offsets.c         |  1 +
 arch/sparc/kernel/asm-offsets.c      |  1 +
 arch/um/kernel/asm-offsets.c         |  2 +
 arch/xtensa/kernel/asm-offsets.c     |  1 +
 include/linux/preempt.h              | 11 ++---
 include/linux/sched.h                | 72 ++++++++++++++++++++++++++++
 kernel/bpf/verifier.c                |  3 +-
 kernel/sched/core.c                  | 56 ++--------------------
 kernel/sched/rq-offsets.c            | 12 +++++
 26 files changed, 129 insertions(+), 62 deletions(-)
 create mode 100644 kernel/sched/rq-offsets.c

-- 
2.50.1


