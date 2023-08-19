Return-Path: <bpf+bounces-8112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F6F7816E9
	for <lists+bpf@lfdr.de>; Sat, 19 Aug 2023 05:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4CED281E54
	for <lists+bpf@lfdr.de>; Sat, 19 Aug 2023 03:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E76ED2;
	Sat, 19 Aug 2023 03:01:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DA2653
	for <bpf@vger.kernel.org>; Sat, 19 Aug 2023 03:01:48 +0000 (UTC)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1AA3C34
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 20:01:47 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-58c4f6115bdso16284467b3.1
        for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 20:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692414106; x=1693018906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z6gobYdTH3OAJCpRq7gUye7d1SlMo6/PpCV5ikq0UDA=;
        b=rPxeAzShEM2ihIn+1yLxXwRfYgyy93HaLm/862MUog1Oyusr+B9qI2up+9vj3fcuKu
         94QOic/CWSmAd9YFNbgF5vUsf0ukuxV5vxIMRDcsdUW/ilj96O8w/iNSBuJFK18FdCDx
         pI3CsTPQLsYCLD+EAvpnpAw7buX0bIVMSeomr3K4BeHmqvGbc2uLSN9S0p4ij9p5rdG0
         qESr2tP/qsXJL6l59Q01diJ4l0hyhn+aEHRkdOp33nURjivoQO7E0N7EDnlezqeepBAJ
         tEULyvMbzHTJq+bJge1SuyTAwjReZdXIxvCYxFjkzF+IEU3bF9ox6oqGw7TLMrE6Wnwd
         SkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692414106; x=1693018906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z6gobYdTH3OAJCpRq7gUye7d1SlMo6/PpCV5ikq0UDA=;
        b=Xi86UQhtRGhdv+6P5Ak+afmvgezxMUMW8Z47YczlfTgbZoitEWRZwdAzRqVAsvNHfb
         qxaSUuJNjymCcVXYEkwMXA2pNvvfmJARkhAoT83x8atYthJUMHyxpya8n2OyqYRlpcXe
         4YvUNhX3K0oCivaAtWTbMLZGE/WpgxWft/XjGQIvjjmacEUJ7ylCctI50gAecR6z7R0U
         cvGYFcWrH2nsIhr4hvUUoySG3q8j6ilfLKQVwO0JmPoARXg/16s7H8WqODyJXBDDMA1I
         pwhoryfTilZpdnuZxF7THmWnAWCd5wRjntqwAuktQzN/qBYZGgqwC7ouhEXSzw6pNMXl
         Pukg==
X-Gm-Message-State: AOJu0YwZ+Awz6UosV9qCrZYGzZ7YHwLo7TOfIouJ7bfmQvPlyLdkkjRA
	Ao7ZpBkgTSrJFxGJgII7Y5KTZ6LMOibE6A==
X-Google-Smtp-Source: AGHT+IGrJnw3699078oLK9t8TyfpcGXgATr4XY2/72cFRvr6pWkjym88uoyBhsjipPgZsUNlFK/u/Q==
X-Received: by 2002:a0d:d8d0:0:b0:56d:4d34:20c with SMTP id a199-20020a0dd8d0000000b0056d4d34020cmr1098725ywe.37.1692414106261;
        Fri, 18 Aug 2023 20:01:46 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:a059:9262:e315:4c20])
        by smtp.gmail.com with ESMTPSA id o199-20020a0dccd0000000b005704c4d3579sm903897ywd.40.2023.08.18.20.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 20:01:45 -0700 (PDT)
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
Subject: [RFC bpf-next v4 0/6] Sleepable BPF programs on cgroup {get,set}sockopt
Date: Fri, 18 Aug 2023 20:01:37 -0700
Message-Id: <20230819030143.419729-1-thinker.li@gmail.com>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <thinker.li@gmail.com>

Major Changes from v3:

 - Remove bpf_sockopt_dynptr_copy_to() and bpf_sockopt_dynptr_install().

 - Rename bpf_sockopt_dynptr_from() to bpf_dynptr_from_sockopt().

 - Add PTR_TO_AUX[_END] and use it for optval and optval_end.

 - bpf_dynptr_write() and bpf_dynptr_read() will write to/read from
   the user space buffer directly if necessary.

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
details.  (bpf_sockopt_dynptr_copy_to() and
bpf_sockopt_dynptr_copy_to_r())

---
v1: https://lore.kernel.org/bpf/20230722052248.1062582-1-kuifeng@meta.com/
v2: https://lore.kernel.org/all/20230811043127.1318152-1-thinker.li@gmail.com/

Kui-Feng Lee (6):
  bpf: enable sleepable BPF programs attached to
    cgroup/{get,set}sockopt.
  libbpf: add sleepable sections for {get,set}sockopt()
  Add PTR_TO_AUX
  bpf: Prevent BPF programs from access the buffer pointed by
    user_optval.
  bpf: Add a new dynptr type for CGRUP_SOCKOPT.
  selftests/bpf: Add test cases for sleepable BPF programs of the
    CGROUP_SOCKOPT type

 include/linux/bpf.h                           |  15 +-
 include/linux/bpf_verifier.h                  |   6 +-
 include/linux/filter.h                        |  10 +
 kernel/bpf/btf.c                              |   3 +
 kernel/bpf/cgroup.c                           | 227 +++++++++++---
 kernel/bpf/helpers.c                          | 140 +++++++++
 kernel/bpf/verifier.c                         | 288 +++++++++++-------
 tools/lib/bpf/libbpf.c                        |   2 +
 .../testing/selftests/bpf/bpf_experimental.h  |  22 ++
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  22 ++
 .../selftests/bpf/prog_tests/sockopt_sk.c     | 112 ++++++-
 .../testing/selftests/bpf/progs/sockopt_sk.c  | 254 +++++++++++++++
 .../selftests/bpf/verifier/sleepable.c        |   2 +-
 13 files changed, 947 insertions(+), 156 deletions(-)

-- 
2.34.1


