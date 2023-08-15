Return-Path: <bpf+bounces-7831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DABB77D149
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 19:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F1791C20DC6
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 17:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7255715AE9;
	Tue, 15 Aug 2023 17:47:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4683413AFD
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 17:47:30 +0000 (UTC)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E46FD1
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 10:47:28 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-58c55d408daso11596317b3.2
        for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 10:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692121647; x=1692726447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eYJP0jjKl3XsDyH2pRkyecAuFjwbnKb2rPJTWE/SZMM=;
        b=gvCpIv4L3h7xCy1A98bGP0iesaGqQ/iqNuQ3r24XWdL2zgC1DPyIM2oXrYM34yKX2W
         bSYyAY7e0LhCZNZoN/rWIczireBILicmpWX6pTPzkfAsMSFpH8v+Ouj0xFhj8AVdi4qz
         Kp12613VwzM/oIwzDgUR0QXbqqIcpob1BtP2soeDfP/kLWSnpCbjE3bRtLH9utV548BN
         uGB/FSlICos2R7D+BStV1H5F81qR2zBumGF/R0sqWb4xYX61cJxuEaG6qdyVERjNtAJr
         9XJXZwY62kTpr6/cGXDsw+Wd8Cmjs0nf2v6+f6NJGRsUWgTyVEWLUabPZ7k7MqmeKPyS
         632A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692121647; x=1692726447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eYJP0jjKl3XsDyH2pRkyecAuFjwbnKb2rPJTWE/SZMM=;
        b=Pr7mkBRiKU7lI8+ViXHT2UgdNxrdKLXrLJuDnXSKD87PQYB9AJuoGnIAn389CX2CSX
         ConksvPReo/qG/18kIad4LfoHk7nYwb8RTgkqCes0uy2cKhxQ7w02FAlMbxvlG863AlN
         hys37Ca7/c+r8FSXf9XX/imyHrKQrna1Top/ACpO2X79LY2GByD8F8IW4yrlZvBbsLA6
         TQzPtbAHduh9Y1wFg2aL+tjjv2Rino0oMc6wAJkXFrdJxmStLz0WZz2z8Gt5G5blzTYa
         3uomF7Qcr7oIUPj52EUev/Bz8QubwDfdI1rcx5yX2F0iYoJUESXDIKQnd8LSK2GVOSDM
         ldsQ==
X-Gm-Message-State: AOJu0YxBzuS0P2yh34i2JKH4+JhJKFyUb0/egzCAJbsj3bosy28WEpny
	jH1Guq1gKMhhyK8r7Q8cp14Lx7/KlHenkA==
X-Google-Smtp-Source: AGHT+IGW2IEBT7IPB6ZUl11eHFYws2PStoKrMFlXzE+co1R6oS6aPbP1xyfFbkKqir5p1lmS/4+pmQ==
X-Received: by 2002:a81:6586:0:b0:586:b686:8234 with SMTP id z128-20020a816586000000b00586b6868234mr16534163ywb.8.1692121647057;
        Tue, 15 Aug 2023 10:47:27 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:84ee:9e38:88fa:8a7b])
        by smtp.gmail.com with ESMTPSA id o128-20020a0dcc86000000b00577139f85dfsm3509404ywd.22.2023.08.15.10.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 10:47:25 -0700 (PDT)
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
Subject: [RFC bpf-next v3 0/5] Sleepable BPF programs on cgroup {get,set}sockopt
Date: Tue, 15 Aug 2023 10:47:07 -0700
Message-Id: <20230815174712.660956-1-thinker.li@gmail.com>
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

Major Changes from v2:

 - Add test cases mixing sleepable and non-sleepable BPF programs.

 - Don't expose bpf_sockopt_kern.flags to BPF programs.

 - Rename kfuncs to *_sockopt_dynptr_*()

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
v2: https://lore.kernel.org/all/20230811043127.1318152-1-thinker.li@gmail.com/

Kui-Feng Lee (5):
  bpf: enable sleepable BPF programs attached to
    cgroup/{get,set}sockopt.
  libbpf: add sleepable sections for {get,set}sockopt()
  bpf: Prevent BPF programs from access the buffer pointed by
    user_optval.
  bpf: Add a new dynptr type for CGRUP_SOCKOPT.
  selftests/bpf: Add test cases for sleepable BPF programs of the
    CGROUP_SOCKOPT type

 include/linux/bpf.h                           |  13 +-
 include/linux/filter.h                        |  10 +
 kernel/bpf/btf.c                              |   3 +
 kernel/bpf/cgroup.c                           | 226 +++++++++++----
 kernel/bpf/helpers.c                          | 197 ++++++++++++++
 kernel/bpf/verifier.c                         | 118 +++++---
 tools/lib/bpf/libbpf.c                        |   2 +
 .../testing/selftests/bpf/bpf_experimental.h  |  36 +++
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  41 +++
 .../selftests/bpf/prog_tests/sockopt_sk.c     | 112 +++++++-
 .../testing/selftests/bpf/progs/sockopt_sk.c  | 257 ++++++++++++++++++
 .../selftests/bpf/verifier/sleepable.c        |   2 +-
 12 files changed, 929 insertions(+), 88 deletions(-)

-- 
2.34.1


