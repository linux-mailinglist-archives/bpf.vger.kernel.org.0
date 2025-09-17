Return-Path: <bpf+bounces-68626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A8EB7C7FC
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D98401B26221
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 06:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AF426656F;
	Wed, 17 Sep 2025 06:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLjj6oGE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B3623D7E6
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 06:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758089369; cv=none; b=LvIxv+kGICXiDhdJYH/f//sNq0tyPMcLrvgLN+JKEaMAt5aOiMPufbhY1RdSzQNVNeqGgRZgKxXhN+2MA62ddplWquXOoWSRc8tgrYrnMGR687BShjECkcYrIhY86xsTu8kqpL6YHYelSJDTmBh3H+0yQSK+JL+gy7lINH2nMoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758089369; c=relaxed/simple;
	bh=537NIBkFJBhNReff0J+Fy8gW6xggBG+duu5koX4j760=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S1Vs2XEymU00iAYfP0ZYyGX4eljvaANO8j54lCXEMTzoB8jV20491QniVjY7rsvilMq2TgdiWycsToH3imGlOqC490uTFf3NT/iU+T9SS5G/xHJ7RCgt3r3l/pG12iF0eQ6Udi7Z0CwhoX/RRiQBLSrOIsD4tFeUR5kkINq4Cs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLjj6oGE; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-b52047b3f19so4347668a12.2
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 23:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758089366; x=1758694166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1xAxRdoiO93y051F82K7suHB9wkzh4QlY9VZ+qgcZbE=;
        b=gLjj6oGEQW9WBYcVPtkMIUofAWs4HEnt3DLX3J6PK8OmvWRyFlULJh5nYWVjFEUlRS
         /Ls9ODwGJn3RBQ1foLdA8Jdh6ZG2D/VwQ7jyOoAVP9Pcwwi9zCh0p3OxBC7k7zzyj9cZ
         HHX3jbCcaFsqu55S2iXjgq3EHJqan328wRywxpuQpddWlDod7CyLCOwwgmu851M6NJyx
         Lgt0ZdUPm7t/xfKgYVaMqVZAAPWXDoV7gSI90F2UWMJR0Y6S+tTg+FA9rmfOyKBg6xlG
         cvObCRf97zj1GNOpO+cgug2e/lKXs8P8JCJQlP2X+t7UgBMcf3MwSFcHurnYBXj8gaXj
         x5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758089366; x=1758694166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1xAxRdoiO93y051F82K7suHB9wkzh4QlY9VZ+qgcZbE=;
        b=OKqYKN5k0Da9qAnC6j4cdaLZAZd30mV6YDTasP9rvP3S3WJ9/8Rg3v1ElvwSAymG4l
         5T/2MsZ1Y8LeH+twdYgyDwEBybWrIMyyiBqXDtt+mjS2AI03IcUGsTdaui3yoSGtHqDb
         fSIefigY09HiwoNIEkAwGYDTsONDZNfbX1AWw4EmXGuCE01JAL37edY1bGjstlupYTs8
         7AwMMo7hNiVFT8soXKFWXSqOzMOf/xQJzEV+ir9obDy9TaOvPo9pg50rPopOGltQQeRf
         DzT5YsZVzQU1txl84r22zoo1yjF8Gr9L8uMjYMJARjsfLqnqnJAAxqc8NefRH9f+7r4C
         jDpg==
X-Forwarded-Encrypted: i=1; AJvYcCVWyCemqr/ZYz5DwlTrs0Wh7HS5fHe3koNZjvJco3Df9pUyN+UO6319V40vSuHsHF6X8O8=@vger.kernel.org
X-Gm-Message-State: AOJu0YznpeJKT87P7YlvvZ+xoShKo0H7FlllSeGLZL3hSK90lxFsi+Wm
	4U/kLjLkcHJEmnBOF3lJqD/omlOcSqNIHVuGfI2Wr2B41qIxzIwsAjgy
X-Gm-Gg: ASbGncstiQZcPSWUPkVEvgStTHnh2w1ogmEhlZZV9OjDGn7L9nv0gXDOEnV50ZgYqVG
	22C5MxNP+S1fY+RrdPk2ajNuVBLWh9gZn0Osj/eztW529wELgEXRRn4hgsI1WAi6Mv/dux3W2Yt
	SwVagkyJc0XTW0p8+/4flXw9zNxmcu0VSSp9y6Cn2ZYtjUYOJ/CJ4Wp4BGjR1qhPV/31cc1D2fK
	k+S/5QUaLYhG2pmij33rwGvYACvAY8JZ6bxuEEb2SyexDi1ZzLmWg/tAtuwdslbp3dyUW7th3Yc
	MqgQJflXmseK6hvXp1ejCn84ub9oPGC05vr4kLaMyzcnGnvJ3nVk8IRMphuxYpDZq8Mhp6CYzf/
	bAMeXO8/qsJoX3QwsQlA=
X-Google-Smtp-Source: AGHT+IHnf2vcgwnne5LMBr01jvI4u6V0HHloejQpirvRzUIkVjeaIv5zalCRylDHZilavjHCejOVgg==
X-Received: by 2002:a05:6a20:3d07:b0:249:d3d:a50b with SMTP id adf61e73a8af0-27ab286ee39mr1195856637.59.1758089365956;
        Tue, 16 Sep 2025 23:09:25 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a3aa1c54sm15845427a12.50.2025.09.16.23.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 23:09:25 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: peterz@infradead.org,
	ast@kernel.org
Cc: mingo@redhat.com,
	paulmck@kernel.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
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
Subject: [PATCH v5 0/4] sched: make migrate_enable/migrate_disable inline
Date: Wed, 17 Sep 2025 14:09:12 +0800
Message-ID: <20250917060916.462278-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
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
asm-offset.c to avoid circular dependency in the 3rd patch.

In the 2nd patch, we replace preempt.h with sched.h in
include/linux/rcupdate.h to fix potential compiling issue.

In the 3rd patch, we generate the offset of nr_pinned in "struct rq" with
rq-offsets.c, as the "struct rq" is defined internally and we need to
access the "nr_pinned" field in migrate_enable and migrate_disable. Then,
we move the definition of migrate_enable/migrate_disable from
kernel/sched/core.c to include/linux/sched.h.

In the 4th patch, we fix some typos in include/linux/preempt.h.

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

Changes since V4:
* add the 2nd patch to fix potential compiling issue
* fix the comment style problem in the 3rd patch

Changes since V3:
* some modification on the 2nd patch, as Alexei advised:
 - rename CREATE_MIGRATE_DISABLE to INSTANTIATE_EXPORTED_MIGRATE_DISABLE
 - add document for INSTANTIATE_EXPORTED_MIGRATE_DISABLE

Changes since V2:
* some modification on the 2nd patch, as Peter advised:
  - don't export runqueues, define migrate_enable and migrate_disable in
    kernel/sched/core.c and use them for kernel modules instead
  - define the macro this_rq_pinned()
  - add some comment for this_rq_raw()

Changes since V1:
* use PERCPU_PTR() for this_rq_raw() if !CONFIG_SMP in the 2nd patch

Menglong Dong (4):
  arch: add the macro COMPILE_OFFSETS to all the asm-offsets.c
  rcu: replace preempt.h with sched.h in include/linux/rcupdate.h
  sched: make migrate_enable/migrate_disable inline
  sched: fix some typos in include/linux/preempt.h

 Kbuild                               |  13 ++-
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
 include/linux/rcupdate.h             |   2 +-
 include/linux/sched.h                | 113 +++++++++++++++++++++++++++
 kernel/bpf/verifier.c                |   1 +
 kernel/sched/core.c                  |  63 ++++-----------
 kernel/sched/rq-offsets.c            |  12 +++
 27 files changed, 181 insertions(+), 58 deletions(-)
 create mode 100644 kernel/sched/rq-offsets.c

-- 
2.51.0


