Return-Path: <bpf+bounces-66167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 914FEB2F42E
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 11:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B605CAA4483
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 09:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D702EE5E1;
	Thu, 21 Aug 2025 09:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgDVSRUZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D922E3AE8;
	Thu, 21 Aug 2025 09:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755769099; cv=none; b=mBsGZU4nsXGVBF+8kbaF7+EiGiGqkpPJf0XUAvW+adYrKYcixgNB7UN1K4tItOBFZw5Kv+89huytd8YfcpRm4AxxBhgctWKebaRC/3G7hXRt9Dm9o7h8LRoSvYlcO7iJXWAiDAdHUy29OuSx2pp3ZKd7zOU1Nd7Cd6ehMMHhqDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755769099; c=relaxed/simple;
	bh=2XrUdi8SUVpgPaidlAGWpu/Up4QsrbyQfxqd7e+rGC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qSaSkcQfbqMG2xzhH8mb5DCikGUOnhGKvXzePcfNncH9uciCQwCE+e7U0Kfp30p94uM3SG/RYDeJbGstCtSzniZZfwppS/hOmYDOVvwHnwzSLNCZ7rShMy35tUvY49b+D422qNMzXBlwcC6YMfcEQu7ZzPquXk2y/EanetLmbmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgDVSRUZ; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-246151aefaaso1916345ad.1;
        Thu, 21 Aug 2025 02:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755769096; x=1756373896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=brKzv9sooymaBmDhs3Jfxb4RejEsd1WJhfh15Y7/Gto=;
        b=UgDVSRUZnklQJP8tQwntBF6M7vV2CYZJdIk7s92jo7nJcyZVNt1MmzhJ/ZG8y0weSK
         ggMVdVd2+wuDTfET1PycqAj+RGWVm5/H8cNdB40XAgPhKRiAHRO91rDx9ahnOukEalij
         fbtRWQLycQKzl5pbiPRxdFl8LmaQr9R338TJKs+ElFwma/aE76zOnQ2C08aQd6EDsD1D
         THUUFhMkdK5xB91s19acN6i9IePn2AhAAl78nLIhR2j3lHu7cRKmFJlBfZiXW92AjNYV
         4UVaANLSfUv4PRZ3sWz5dVAraK3y0phfu2cTwiVQ9lA+zfbBKpKUuTghTxedoC4IvUEO
         ty/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755769096; x=1756373896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=brKzv9sooymaBmDhs3Jfxb4RejEsd1WJhfh15Y7/Gto=;
        b=U3KAPGxNtx24pscPIclusiP90wuu8SebU5Q2sXRZ7Frv0VyoW1O4KCV2/vTuogNK/8
         yU3bfqmg653g3KX9TjwukR/1FcS61ZJmuukm+LsfSnIICKF1PD53DryZaaTrZ46dX7Sh
         C8djOefdBUC83UvqnRTjfcKp58fmPSczdnZ1CACcepz8ru29xBMx4L3Fxr/8DI5tEuo3
         Stm0+RT7f0isz15Jdiye9MgDlH4BUzjqLpJAsc2EONif/9s89S2z+/IhG+D9EGEO2p6W
         FPBbB/ubqsLwIsgt7xUgGmESZM23YmGJtp46zb30lRHg1IQP0TlxQ8VZp7x/wlMg6EfI
         QzcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5Tec+0Ylf2MV+XMvklpCVxmNtuCuMJ/iL/uyQoqnpH5i293/NVmgwLxim813mCa39QoE=@vger.kernel.org, AJvYcCVU2j4+cvOsgst1fWF2M1+CKeZVTzWoYSCtwour3RABW4DJhaM8BAmHDS/BrblUazW1ew2YeCmMyDYYdf4t@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo+HQIUuhwNFVXVGwCSjzU9DUvSdPRxDOh5WGXDVSK6DMoGV68
	+w5uupzNRg/W/k09QghC8VFWNUk1f/dXlCu59Jz6fLHffmW4JJ0C/Ohs
X-Gm-Gg: ASbGncvkIb/IYdFi1oHC/eg8ngficWp2sMpYA+wRxO5jnViZ3ry0E2KP/+dO8drMhwz
	1yLINOltL/2pd9bmsYD3DWgqnn2Z11m4QjoR/ACSZD8dhkeKKCRDG0oHuIdyUeos41jCzg8xkE5
	ePtCjguc7zOKLhpm5dU/2JRCssofAFU3FMB07L3c7oMnGnjidwx8XgkiUZto98rr7Srp9Qgyff6
	j1+YXWCLG9mWY+kfH9XWRDaLV+QqicXxVbdQ3e/y9voGYhPVLW4olxFCtyg5s9poMh4uMqZYCSE
	+oCQGISxjZoKq8XlmhM7o+ZLfWZtQKo04FKCoWHKm2d2639D/aGu6g2ddIZFd0x/L6abzxyfqUX
	EoOZLw+7ACdSpddbLmc02bWI=
X-Google-Smtp-Source: AGHT+IFG7O09pY9guGg2y+fdi2v+q2JBqjSLwwQ2iBHKaDlDTuu9lLo/v5vgwv9t7+HZldQ+Gz5aYA==
X-Received: by 2002:a17:902:e5ce:b0:240:86b2:ae9c with SMTP id d9443c01a7336-2460622c663mr20255705ad.14.1755769096140;
        Thu, 21 Aug 2025 02:38:16 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed540040sm49652085ad.163.2025.08.21.02.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 02:38:15 -0700 (PDT)
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
	tzimmermann@suse.de,
	simona.vetter@ffwll.ch,
	jani.nikula@intel.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v3 0/3] sched: make migrate_enable/migrate_disable inline
Date: Thu, 21 Aug 2025 17:38:04 +0800
Message-ID: <20250821093807.49750-1-dongml2@chinatelecom.cn>
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

Changes since V2:
* some modification on the 2nd patch, as Peter advised:
  - don't export runqueues, define migrate_enable and migrate_disable in
    kernel/sched/core.c and use them for kernel modules instead
  - define the macro this_rq_pinned()
  - add some comment for this_rq_raw()

Changes since V1:
* use PERCPU_PTR() for this_rq_raw() if !CONFIG_SMP in the 2nd patch

Menglong Dong (3):
  arch: add the macro COMPILE_OFFSETS to all the asm-offsets.c
  sched: make migrate_enable/migrate_disable inline
  sched: fix some typos in include/linux/preempt.h

 Kbuild                               |  13 +++-
 arch/alpha/kernel/asm-offsets.c      |   1 +
 arch/arc/kernel/asm-offsets.c        |   1 +
 arch/arm/kernel/asm-offsets.c        |   2 +
 arch/arm64/kernel/asm-offsets.c      |   1 +
 arch/csky/kernel/asm-offsets.c       |   1 +
 arch/hexagon/kernel/asm-offsets.c    |   1 +
 arch/loongarch/kernel/asm-offsets.c  |   2 +
 arch/m68k/kernel/asm-offsets.c       |   1 +
 arch/microblaze/kernel/asm-offsets.c |   1 +
 arch/mips/kernel/asm-offsets.c       |   2 +
 arch/nios2/kernel/asm-offsets.c      |   1 +
 arch/openrisc/kernel/asm-offsets.c   |   1 +
 arch/parisc/kernel/asm-offsets.c     |   1 +
 arch/powerpc/kernel/asm-offsets.c    |   1 +
 arch/riscv/kernel/asm-offsets.c      |   1 +
 arch/s390/kernel/asm-offsets.c       |   1 +
 arch/sh/kernel/asm-offsets.c         |   1 +
 arch/sparc/kernel/asm-offsets.c      |   1 +
 arch/um/kernel/asm-offsets.c         |   2 +
 arch/xtensa/kernel/asm-offsets.c     |   1 +
 include/linux/preempt.h              |  11 +--
 include/linux/sched.h                | 106 +++++++++++++++++++++++++++
 kernel/bpf/verifier.c                |   1 +
 kernel/sched/core.c                  |  63 ++++------------
 kernel/sched/rq-offsets.c            |  12 +++
 26 files changed, 173 insertions(+), 57 deletions(-)
 create mode 100644 kernel/sched/rq-offsets.c

-- 
2.50.1


