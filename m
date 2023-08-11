Return-Path: <bpf+bounces-7514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09101778681
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 06:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1FBD28184A
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 04:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E5410F9;
	Fri, 11 Aug 2023 04:31:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4E6A44
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 04:31:34 +0000 (UTC)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA9B2696
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 21:31:32 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d0548cf861aso1397053276.3
        for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 21:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691728292; x=1692333092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mZc1FT18lC7bzY+qGsnnJYQoQB7lSRVyzAUr5R6ry+4=;
        b=D6BpKib6V8NroU0RXsLrXrj7+q7lZgq/7RsAxZ03LiWbWf0DJ2G5vu9/3+PtOMosWp
         xu48n/z7ZkZPCkAZWkxT1tnDw9Z3vz2bvHtyJuWy/0gasXvKvOLPqaWuoY7ekoc6OLhP
         a3rwIvh4FM0se+y0rLZy52MBE5+xNacGjnNs6MvWbtelIsT6xFt+XL1Hfhf6KkM9nVqD
         FN9Lp8YpOdgRYok7wY1zoObdidaWIuFNmFqkMKSfozJjwi6lCfl8JvIcpChKQZZoPWwK
         cc7Xp7ZZtrPjo2WsD902xPwnd9LxXMOmUn0zvWAGWJziHo30ZkFyu9+B5ZLH6VdlmBVS
         1xQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691728292; x=1692333092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mZc1FT18lC7bzY+qGsnnJYQoQB7lSRVyzAUr5R6ry+4=;
        b=B2uFTjW/fmTkUwLgDJBc98MmNub4WNsASO1kgJiVSnvGjuiVJS/Q/Gzt0GGqhQTxQ/
         LXWRZSFBSzZiYLspkvGAstbc+xtOtSg+pmKIR0wYL2YYLhx/DoEcuOHEVfZwhdQS9Mj8
         Mvt3mwfETUg66xHDLGR6A5uLxFhdmn1swdP7cq320cEX0tdSqxYMSPFjqBNHcrFCVfAZ
         a6dQekTirjQCZXBiD2DgayiQM+GJVLxQA7bWQtonEgehPKFpPdlqMWphpTXQJbGwP2fK
         MohQt1OYWtqQQGt27OELiinGHyNPyh2nd35r+rBi3KOVXtKtj3P2dXQIwr4iq/+47KTV
         cY+Q==
X-Gm-Message-State: AOJu0YzIq6Sy33peci5qtwvwR4txnHtybIRjFOdBazTuIdn2FKcWP7hq
	CBPu30mzzQOf3WSajPf6h5CmAWSRIqQOFw==
X-Google-Smtp-Source: AGHT+IHgL8p8hgzCJBMYE2kpHrmjCF9DwGMMYfS00qRd7N22dr+uSebr0KXDrEiKSAr56f50T3kR6Q==
X-Received: by 2002:a81:dd0f:0:b0:585:ef4e:6d93 with SMTP id e15-20020a81dd0f000000b00585ef4e6d93mr935077ywn.47.1691728291673;
        Thu, 10 Aug 2023 21:31:31 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:16da:9387:4176:e970])
        by smtp.gmail.com with ESMTPSA id n15-20020a819c4f000000b00583e52232f1sm767961ywa.112.2023.08.10.21.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 21:31:31 -0700 (PDT)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	sdf@google.com,
	yonghong.song@linux.dev
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [RFC bpf-next v2 0/6] Sleepable BPF programs on cgroup {get,set}sockopt
Date: Thu, 10 Aug 2023 21:31:21 -0700
Message-Id: <20230811043127.1318152-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <thinker.li@gmail.com>

Major Changes from v1:

 - Add bpf_so_optval_copy_to() and bpf_so_optval_copy_to_r() to copy
   data from a dynptr or raw buffer to the optval of a context, either
   in the kernel or user space, to simplify BPF programs.

 - Restrict to having atmost one instance of dynptr initialized by
   bpf_so_optval_from() at any moment.  It simplifies the memory
   management of the optval buffer in kernel.

 - Fix the issue of bpf_prog_array_free() by replacing it with
   bpf_prog_array_free_sleepable().


Make BPF programs attached on cgroup/{get,set}sockopt hooks sleepable
and able to call bpf_copy_from_user() and bpf_copy_to_user(), a new
kfunc.

The Issue with CGroup {get,set}sockopt Hooks
============================================

Calling {get,set}sockopt from user space, optval is a pointer to a
buffer. The format of the buffer depends on the level and optname, and
its size is specified by optlen. The buffer is used by user space
programs to pass values to setsockopt and retrieve values from
getsockopt.

The problem is that BPF programs protected by RCU read lock cannot
access the buffers located in user space. This is because these
programs are non-sleepable and using copy_from_user() or
copy_to_user() to access user space memory can result in paging.

The kernel makes a copy of the buffer specified by optval and optlen
in kernel space before passing it to the cgroup {get,set}sockopt
hooks. After the hooks are executed, the content of the buffer in
kernel space is copied to user space if necessary.

Programs may send a significant amount of data, stored in buffer
indicated by optval, to the kernel. One example is iptables, which can
send several megabytes to the kernel. However, BPF programs on the
hooks can only see up to the first PAGE_SIZE bytes of the buffer. The
optlen value that BPF programs observe may appear to be PAGE_SIZE, but
in reality, it is larger than that. On the other hand, the value of
optlen represents the amount of data retrieved by
getsockopt(). Additionally, both the buffer content and optlen can be
modified by BPF programs.

Kernel may wrongly modify the value of optlen returned to user space
to PAGE_SIZE. This can happen because the kernel cannot distinguish if
the value was set by BPF programs or by the kernel itself.

To fix it, we perform various hacks; for example, the commit d8fe449a9c51
("bpf: Don't return EINVAL from {get,set}sockopt when optlen > PAGE_SIZE")
and the commit 29ebbba7d461 ("bpf: Don't EFAULT for {g,s}setsockopt with
 wrong optlen").

Make CGroup {get,set}sockopt Hooks Sleepable
============================================

The long term solution is to make these hooks sleepable to enable BPF
programs call copy_from_user() and copy_to_user(),
a.k.a. bpf_copy_from_user() and bpf_copy_to_user(). It prevents
manipulation of optval and optlen values, and allows BPF programs to
access the complete contents of the buffer referenced by optval.

Mix Sleepable and Non-Sleepable Programs
========================================

Installing both sleepable and non-sleepable programs simultaneously on
the same hook leads to the mixing of sleepable and non-sleepable
programs. For programs that cannot sleep, the kernel first copies data
from the user buffer to a kernel buffer before invoking BPF
programs. This process introduces intricate interactions between
sleepable and non-sleepable programs.

For instance, due to kernel copies for non-sleepable programs, a
sleepable program may receive optval in either the user space or the
kernel space. These two scenarios require different handling
approaches to update the buffer pointed to by optval. Consequently,
sleepable programs can become significantly complex.

To simplify the programs, we introduce a set of kfuncs that enable
data copying to optval without requiring knowledge of the underlying
details.  (bpf_so_optval_copy_to() and bpf_so_optval_copy_to_r())

---
v1: https://lore.kernel.org/bpf/20230722052248.1062582-1-kuifeng@meta.com/

Kui-Feng Lee (6):
  bpf: enable sleepable BPF programs attached to
    cgroup/{get,set}sockopt.
  bpf: Prevent BPF programs from access the buffer pointed by
    user_optval.
  bpf: rename bpf_copy_to_user().
  bpf: Provide bpf_copy_from_user() and bpf_copy_to_user().
  bpf: Add a new dynptr type for CGRUP_SOCKOPT.
  bpf: Add test cases for sleepable BPF programs of the CGROUP_SOCKOPT
    type.

 include/linux/bpf.h                           |   7 +-
 include/linux/filter.h                        |   1 +
 include/uapi/linux/bpf.h                      |  11 +
 kernel/bpf/btf.c                              |   3 +
 kernel/bpf/cgroup.c                           | 254 ++++++++++++++----
 kernel/bpf/helpers.c                          | 233 ++++++++++++++++
 kernel/bpf/syscall.c                          |   8 +-
 kernel/bpf/verifier.c                         | 120 ++++++---
 tools/include/uapi/linux/bpf.h                |  11 +
 tools/lib/bpf/libbpf.c                        |   2 +
 .../testing/selftests/bpf/bpf_experimental.h  |  44 +++
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  47 ++++
 .../selftests/bpf/prog_tests/sockopt_sk.c     |  34 ++-
 .../testing/selftests/bpf/progs/sockopt_sk.c  | 242 +++++++++++++++++
 .../selftests/bpf/verifier/sleepable.c        |   2 +-
 15 files changed, 927 insertions(+), 92 deletions(-)

-- 
2.34.1


