Return-Path: <bpf+bounces-65952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8D1B2B680
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 03:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7270C1B24E69
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 01:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE34F286410;
	Tue, 19 Aug 2025 01:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+UbIsZH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA18886347;
	Tue, 19 Aug 2025 01:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755568723; cv=none; b=FkGfOCrIjkzBiRHdniPyWsnYqeZiGBXoXmtn/jJdXi/hTZBQgOX1LFCfvsPqNoaSTY8RSBx9tDIitvWgNQb5PhS59nvhY6+2Deku0wNHYndU1eVyxX0Ns+SYc3bZxzfWV76Av+b7iHDmtb2GB82QPtkkh2obeOF0Oo4+6kYD4tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755568723; c=relaxed/simple;
	bh=occo/InGWfo2XF4CZv0Pc9+wcm+POFRgVo//Vx5P2uw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pj138OnxNw590XT06TATsF4CnzB+faKM4o4sA0mn9rdCWOhndOtqbsbDfpMhOm7GDCdx50CYDW33BomcN5pSq7P5u3IvOSExsj1YTT2AC8YwroLyU6FKnEX3tG+dbUNdc4c6YAdNbSBsPrk+XTRRBthcKdOzkisA6CYpLE/LBco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+UbIsZH; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-76e2eb09041so3979603b3a.3;
        Mon, 18 Aug 2025 18:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755568721; x=1756173521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VeE5lbJFwiA14jNEsV/ZePvtvfVJ+NdIzAb7yTj6C18=;
        b=k+UbIsZHIs/RcCor5g4yTCipQ4d/wYaUsU4xgIoGrfzxSFwRLS++tvzF/H+EeLLa+Z
         a6jAtKFV4eDMDzB0NqIdP84srYGuc+rLR5Q2A/r9KGwgvl5Tgmbdd5rD1pmWYOOKfiTO
         37fOzbU2Gbn+DiglW7ExKDb3GSCx1m1+uRLLs4kLwz8IcBqh80ydAAII8NgWgOp1Nyqp
         GKNH6wdFC/SvW1iyqYLh38N+Xcn7vfcAhaJSv9KNJXGIqsqJRs+eAQiK50C5rCLWSKcd
         p5dDShL55flcpKWl/J7RmDfYPrFql3AqHmyYbWmW4a2K/OHCCFZd70SkDbVT/7SJLNdt
         kYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755568721; x=1756173521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VeE5lbJFwiA14jNEsV/ZePvtvfVJ+NdIzAb7yTj6C18=;
        b=T0ewxEw88m3QE6IxluCifbsSNeW6ZuqS1GHgmosyTe3DXAj7nBnTpW3f1SXOWeDvin
         1reHgFQTLgFV9MiJipdDvik361ZZOGFNclQ98+OrD3R/eo1gsHfyTmTIu1HCJkqy7hVO
         giY9xKwMBT1oDOD/czfiCziKHm8nzcRydO5c044gQT9I+lDhYzGBbGcKGUk/YIV2ubBD
         mCn6QkxIkoRsDSQ5FdDFjYx/xxVDeXFAqxUH/Nh/I+GEBpEbwNVmu7guxF4zeejF+4CH
         NoQtSjnC6wZ0F7BP/U8QiMIMqlN6dMnybGcEtPZVD2at2phOFR5YQ4qFsf1VrpmTRyEi
         XjSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5wHtiOoKA4hfopuBrs8a8c11eki5WAh5KPYLaKiPKxfPkW7AhsW0ZnkBzj1LIhtsuZiBixoHqSiVfd2Zh@vger.kernel.org, AJvYcCWOHq7e88HR1iIED8nT5y8d1p32ysPRZ8jjIlBBkp1mpLGoseJLB0514x7pvUDd1l0UQEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHRWpgmaueXrcQAQuIQqsr3Z0GpIK/Jd8AYKPcwFi19exmxBDN
	e8neBJDO5/obAPUZ1L4dJU3qJjcicPymuHz8j6CsG28jp4BI5lDOg+AX
X-Gm-Gg: ASbGnct8NYF4pRUF0b9TKSPRskco+MKtHxUVFjv07qJa35oPH4Fab+1WsX6nunxSFOA
	Ydy9zO1AckjnlQHfqzsj+zLefjoXXtPVXvIGxm1JYDLIZxdRm6yeGwJbXiCVfQFDr2O5Z5LeF8a
	XSZF4hOHvyZLCkwRQABZYFsG6LGIvJL0EAJZdT2Z1Pt4PR+JPK4A3ZWQ8Mt9JB0KRhHiM360t3H
	tUirSxT11b9D5kseApFUe3DV5xhuY3ciNWBbZceehhSaz+JtcJz6r2fwG36ur4nnwtpx8khefdQ
	TDuwIgyj+ERjxHo/NwRkcWtrLMZeRcQTsXsP2rEu4dQAZiYuxS8NvBcr4Z5Y8mDPiyKJFtfUKZO
	Q9x4pF7REKd+cNliaVBs=
X-Google-Smtp-Source: AGHT+IEJbif96i/lie5irIUrzQ/O7p7w95kPM8UTge9QCBelGRtjtMRCrM/WSSnSAUbN9zn+l5xL8g==
X-Received: by 2002:a05:6a21:3289:b0:243:755:58b5 with SMTP id adf61e73a8af0-2430d4ed2c6mr1040598637.54.1755568721112;
        Mon, 18 Aug 2025 18:58:41 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b474f22665bsm1952013a12.20.2025.08.18.18.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 18:58:40 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: peterz@infradead.org
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
	simona.vetter@ffwll.ch,
	tzimmermann@suse.de,
	jani.nikula@intel.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2 0/3] sched: make migrate_enable/migrate_disable inline
Date: Tue, 19 Aug 2025 09:58:29 +0800
Message-ID: <20250819015832.11435-1-dongml2@chinatelecom.cn>
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

Changes since V1:
* use PERCPU_PTR() for this_rq_raw() if !CONFIG_SMP in the 2nd patch

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
 include/linux/preempt.h              | 11 ++--
 include/linux/sched.h                | 77 ++++++++++++++++++++++++++++
 kernel/bpf/verifier.c                |  3 +-
 kernel/sched/core.c                  | 56 ++------------------
 kernel/sched/rq-offsets.c            | 12 +++++
 26 files changed, 134 insertions(+), 62 deletions(-)
 create mode 100644 kernel/sched/rq-offsets.c

-- 
2.50.1


