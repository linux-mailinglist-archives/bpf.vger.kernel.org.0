Return-Path: <bpf+bounces-29236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8831E8C15F1
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 22:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3AFFB2422A
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 20:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69272128362;
	Thu,  9 May 2024 20:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AwLtsB6C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C099580635
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 20:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284871; cv=none; b=VsF5/CRR5Io/I6Z3Us6RHLO0yzmCA+hpFwZsWxl8FYGpvo8X9OAUq6zMA3hcXifVR/0FX5jBLA/suc/Kvslt77EygsfLQ6ovbRa3XaLwwnKjsYENmkSg8Ev/vV3pyt+cuZdFsh7CVJ1KGjylksUHlorjQ3lFa9scYy1SAs8Ntoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284871; c=relaxed/simple;
	bh=BywuTfRWMV89KZ9QCNZ0lzu6VQ7k0zP/IBsIKLI3ytA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ot8wOl0RSU4an6AR0sl6vnQ/TDXelYMOX2Ri3+xLbOp22EkAiGMQZiE1sgbfTeXBw9f1f0VS+JGwFMyqk8S1QpYvSpcCse8iI/thlZcimmsljYwD2xoDQZB19fkBdIEqn0Nk1EkRaFX10gWj0xHwm601Bh1m+A/lOZw+3wGIH5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AwLtsB6C; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6efefc57621so783671b3a.2
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 13:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284867; x=1715889667; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YbNfWdZqwCgP5Pz0h9FCkFX5FCC2CTEzcGds39PN8sE=;
        b=AwLtsB6C0HI6y+pSxYtqSPHtIAKFQAVJPVEDL8Lu0QoDL0rthHO0EZi7A6PDUiCt4f
         Iiuf70T/7GlGpDkmP3DfKAj4E/axmpM3Y8/jvL5BRFq1gJGyb6GgLMC2Lsp8booma2q8
         lM/03vv69PNH65b4UQZKVdnzmucsMYe+Jh2waUPd+mLyqu1biG6uexL+MH3vqlOuHBNL
         h+9ERA4EPnAVYpcTOGit70ZmNsvQxBGqL7YR23jepBYt2eo9WxcF+THujq0kvF6mnNM9
         W1ts7Fnb38Pz6bKJcRQ/Tlb5iQZOc8xdxnsBKoZUfejL9/1PaS8jvRDEhlxdQfA9oVUU
         trWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284867; x=1715889667;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YbNfWdZqwCgP5Pz0h9FCkFX5FCC2CTEzcGds39PN8sE=;
        b=O637b96BedyTg52CgtD69Qkhyr/A2IbPKST6muFI19IR8fOQYLiQCPANGfWufDX1rg
         udztdlDZ/jjGzI2/cXXaJrOhlwqHLauZB9nErPdbyQFrN2qTjc9ep0cKIvXbwgf0SupN
         3liwob+uUoWcMofwOg7k6h8TxxpC4kLm6AhjKvx729JFdH9TXkOU11TFy7N1B6CYDsRH
         716d8R0waK1QUO1mYh4fzjKG9H2jqs3+b9o8ttClEITtpHPZwNSpH07N0pguPGNRk537
         ClRIvjhSv+PQHZwSiSvtSGGlaAdQX7Zm+TK3270fk1IcQkk6Fw4qfitXp8qApthzamgu
         Hz8A==
X-Forwarded-Encrypted: i=1; AJvYcCWPnxRkJwIdR6bwpUMjQRuQKS3O/T3FBqEsuYdPfmGj+aTmzJTa6u06JSl3VWzv6bJKscwUYUaZKTxxjdKm9ov7OHec
X-Gm-Message-State: AOJu0Yz1rYWSwWlfV79kfKUD7jhPCTrYTkkjbO6rGk4CZ3K4MGdWQ8LA
	9CmNHzGXIpJSXff7Sx6QaTGoNZGKuTMktgyIWleH3Dt0JOVmR3f3f+dmokIDNZtXaE9cY8FO66R
	khA==
X-Google-Smtp-Source: AGHT+IEWn0NJLdJVm8i3nXGNqhMT3erMoL6+SEwGmAotS98GMnAZKIncf6dhlt5bk6pE2nlhU8Kro/+E0ms=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:3c91:b0:6ea:aafa:815c with SMTP id
 d2e1a72fcca58-6f4e0263dd0mr24703b3a.1.1715284867136; Thu, 09 May 2024
 13:01:07 -0700 (PDT)
Date: Thu,  9 May 2024 19:57:58 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-7-edliaw@google.com>
Subject: [PATCH v3 06/68] selftests/bpf: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, "=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Edward Liaw <edliaw@google.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/bpf/bench.c                            | 1 -
 tools/testing/selftests/bpf/benchs/bench_trigger.c             | 1 -
 tools/testing/selftests/bpf/cgroup_helpers.c                   | 1 -
 tools/testing/selftests/bpf/map_tests/task_storage_map.c       | 1 -
 tools/testing/selftests/bpf/network_helpers.c                  | 2 --
 tools/testing/selftests/bpf/prog_tests/bind_perm.c             | 1 -
 tools/testing/selftests/bpf/prog_tests/bpf_cookie.c            | 1 -
 tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c   | 1 -
 tools/testing/selftests/bpf/prog_tests/bpf_obj_pinning.c       | 1 -
 tools/testing/selftests/bpf/prog_tests/btf_endian.c            | 1 -
 tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c   | 2 --
 tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c            | 2 --
 tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c    | 2 --
 tools/testing/selftests/bpf/prog_tests/cls_redirect.c          | 3 ---
 tools/testing/selftests/bpf/prog_tests/connect_ping.c          | 2 --
 tools/testing/selftests/bpf/prog_tests/core_retro.c            | 1 -
 tools/testing/selftests/bpf/prog_tests/d_path.c                | 1 -
 tools/testing/selftests/bpf/prog_tests/deny_namespace.c        | 1 -
 tools/testing/selftests/bpf/prog_tests/fexit_sleep.c           | 1 -
 .../testing/selftests/bpf/prog_tests/flow_dissector_reattach.c | 2 --
 tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c      | 1 -
 tools/testing/selftests/bpf/prog_tests/htab_reuse.c            | 1 -
 tools/testing/selftests/bpf/prog_tests/htab_update.c           | 1 -
 tools/testing/selftests/bpf/prog_tests/map_in_map.c            | 1 -
 tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c   | 2 --
 tools/testing/selftests/bpf/prog_tests/perf_branches.c         | 1 -
 tools/testing/selftests/bpf/prog_tests/perf_buffer.c           | 1 -
 tools/testing/selftests/bpf/prog_tests/perf_event_stackmap.c   | 1 -
 tools/testing/selftests/bpf/prog_tests/perf_link.c             | 1 -
 tools/testing/selftests/bpf/prog_tests/perf_skip.c             | 2 --
 tools/testing/selftests/bpf/prog_tests/preempted_bpf_ma_op.c   | 1 -
 tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c         | 2 --
 tools/testing/selftests/bpf/prog_tests/reg_bounds.c            | 2 --
 tools/testing/selftests/bpf/prog_tests/ringbuf.c               | 1 -
 tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c         | 1 -
 tools/testing/selftests/bpf/prog_tests/setget_sockopt.c        | 2 --
 tools/testing/selftests/bpf/prog_tests/sk_assign.c             | 2 --
 tools/testing/selftests/bpf/prog_tests/sk_lookup.c             | 2 --
 tools/testing/selftests/bpf/prog_tests/sock_fields.c           | 2 --
 tools/testing/selftests/bpf/prog_tests/task_kfunc.c            | 2 --
 tools/testing/selftests/bpf/prog_tests/task_local_storage.c    | 2 --
 tools/testing/selftests/bpf/prog_tests/task_pt_regs.c          | 1 -
 tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c  | 2 --
 tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c       | 2 --
 tools/testing/selftests/bpf/prog_tests/test_bpf_ma.c           | 1 -
 .../testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c  | 1 -
 tools/testing/selftests/bpf/prog_tests/test_bpffs.c            | 1 -
 tools/testing/selftests/bpf/prog_tests/test_overhead.c         | 1 -
 tools/testing/selftests/bpf/prog_tests/token.c                 | 1 -
 tools/testing/selftests/bpf/prog_tests/trace_ext.c             | 2 --
 tools/testing/selftests/bpf/prog_tests/trampoline_count.c      | 1 -
 tools/testing/selftests/bpf/prog_tests/user_ringbuf.c          | 2 --
 tools/testing/selftests/bpf/prog_tests/xdp_bonding.c           | 2 --
 tools/testing/selftests/bpf/prog_tests/xdp_synproxy.c          | 2 --
 tools/testing/selftests/bpf/test_flow_dissector.c              | 3 ---
 tools/testing/selftests/bpf/test_lru_map.c                     | 1 -
 tools/testing/selftests/bpf/test_progs.c                       | 1 -
 tools/testing/selftests/bpf/test_sock_addr.c                   | 3 ---
 tools/testing/selftests/bpf/test_tcpnotify_user.c              | 1 -
 tools/testing/selftests/bpf/veristat.c                         | 1 -
 tools/testing/selftests/bpf/xskxceiver.c                       | 2 --
 61 files changed, 90 deletions(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 627b74ae041b..ab06bd67a22c 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
-#define _GNU_SOURCE
 #include <argp.h>
 #include <linux/compiler.h>
 #include <sys/time.h>
diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index 4b05539f167d..dc84469cbfa6 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
-#define _GNU_SOURCE
 #include <argp.h>
 #include <unistd.h>
 #include <stdint.h>
diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index 23bb9a9e6a7d..3040ba7cc9ba 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 #include <sys/mount.h>
 #include <sys/stat.h>
diff --git a/tools/testing/selftests/bpf/map_tests/task_storage_map.c b/tools/testing/selftests/bpf/map_tests/task_storage_map.c
index 7d050364efca..89ff4ed5c59b 100644
--- a/tools/testing/selftests/bpf/map_tests/task_storage_map.c
+++ b/tools/testing/selftests/bpf/map_tests/task_storage_map.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2022. Huawei Technologies Co., Ltd */
-#define _GNU_SOURCE
 #include <sched.h>
 #include <unistd.h>
 #include <stdlib.h>
diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 054d26e383e0..e4020cf19424 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#define _GNU_SOURCE
-
 #include <errno.h>
 #include <stdbool.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/bind_perm.c b/tools/testing/selftests/bpf/prog_tests/bind_perm.c
index f7cd129cb82b..c3839f425ba5 100644
--- a/tools/testing/selftests/bpf/prog_tests/bind_perm.c
+++ b/tools/testing/selftests/bpf/prog_tests/bind_perm.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 #include <stdlib.h>
 #include <sys/types.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
index 4407ea428e77..a47f453dd7e8 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2021 Facebook */
-#define _GNU_SOURCE
 #include <pthread.h>
 #include <sched.h>
 #include <sys/syscall.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c
index b52ff8ce34db..be8a401eb07a 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2021 Facebook */
-#define _GNU_SOURCE
 #include <sched.h>
 #include <test_progs.h>
 #include "network_helpers.h"
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_obj_pinning.c b/tools/testing/selftests/bpf/prog_tests/bpf_obj_pinning.c
index ee0458a5ce78..e33129203194 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_obj_pinning.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_obj_pinning.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
-#define _GNU_SOURCE
 #include <test_progs.h>
 #include <bpf/btf.h>
 #include <fcntl.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_endian.c b/tools/testing/selftests/bpf/prog_tests/btf_endian.c
index 5b9f84dbeb43..460b117507bb 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_endian.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_endian.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
-#define _GNU_SOURCE
 #include <string.h>
 #include <byteswap.h>
 #include <test_progs.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c b/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c
index ef4d6a3ae423..1a90d6638147 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
-
-#define _GNU_SOURCE
 #include <netinet/in.h>
 #include <arpa/inet.h>
 #include <unistd.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c b/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
index adda85f97058..7f1a6ffdda98 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
-
-#define _GNU_SOURCE
 #include <cgroup_helpers.h>
 #include <test_progs.h>
 
diff --git a/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c b/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
index 747761572098..accd25c2b638 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2022 Meta Platforms, Inc. and affiliates.*/
-
-#define _GNU_SOURCE
 #include <unistd.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/cls_redirect.c b/tools/testing/selftests/bpf/prog_tests/cls_redirect.c
index 34b59f6baca1..598461560fa1 100644
--- a/tools/testing/selftests/bpf/prog_tests/cls_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/cls_redirect.c
@@ -1,8 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 // Copyright (c) 2020 Cloudflare
-
-#define _GNU_SOURCE
-
 #include <arpa/inet.h>
 #include <string.h>
 
diff --git a/tools/testing/selftests/bpf/prog_tests/connect_ping.c b/tools/testing/selftests/bpf/prog_tests/connect_ping.c
index 40fe571f2fe7..f315f09391f7 100644
--- a/tools/testing/selftests/bpf/prog_tests/connect_ping.c
+++ b/tools/testing/selftests/bpf/prog_tests/connect_ping.c
@@ -3,8 +3,6 @@
 /*
  * Copyright 2022 Google LLC.
  */
-
-#define _GNU_SOURCE
 #include <sys/mount.h>
 
 #include "test_progs.h"
diff --git a/tools/testing/selftests/bpf/prog_tests/core_retro.c b/tools/testing/selftests/bpf/prog_tests/core_retro.c
index 4a2c256c8db6..bb1b2ae3502f 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_retro.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_retro.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2020 Facebook
-#define _GNU_SOURCE
 #include <test_progs.h>
 #include "test_core_retro.skel.h"
 
diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c b/tools/testing/selftests/bpf/prog_tests/d_path.c
index ccc768592e66..7f172296c4a1 100644
--- a/tools/testing/selftests/bpf/prog_tests/d_path.c
+++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <test_progs.h>
 #include <sys/stat.h>
 #include <linux/sched.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/deny_namespace.c b/tools/testing/selftests/bpf/prog_tests/deny_namespace.c
index 1bc6241b755b..ff8d03a906a3 100644
--- a/tools/testing/selftests/bpf/prog_tests/deny_namespace.c
+++ b/tools/testing/selftests/bpf/prog_tests/deny_namespace.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <test_progs.h>
 #include "test_deny_namespace.skel.h"
 #include <sched.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_sleep.c b/tools/testing/selftests/bpf/prog_tests/fexit_sleep.c
index f949647dbbc2..4f58a08db082 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_sleep.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_sleep.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2021 Facebook */
-#define _GNU_SOURCE
 #include <sched.h>
 #include <test_progs.h>
 #include <time.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector_reattach.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector_reattach.c
index 9333f7346d15..1f64ffc9a036 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector_reattach.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector_reattach.c
@@ -2,8 +2,6 @@
 /*
  * Tests for attaching, detaching, and replacing flow_dissector BPF program.
  */
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <sched.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c b/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c
index 858e0575f502..080a94cde2dc 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <pthread.h>
 #include <sched.h>
 #include <sys/socket.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/htab_reuse.c b/tools/testing/selftests/bpf/prog_tests/htab_reuse.c
index a742dd994d60..c80f97405cc2 100644
--- a/tools/testing/selftests/bpf/prog_tests/htab_reuse.c
+++ b/tools/testing/selftests/bpf/prog_tests/htab_reuse.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2023. Huawei Technologies Co., Ltd */
-#define _GNU_SOURCE
 #include <sched.h>
 #include <stdbool.h>
 #include <test_progs.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/htab_update.c b/tools/testing/selftests/bpf/prog_tests/htab_update.c
index 2bc85f4814f4..37fa7fd75858 100644
--- a/tools/testing/selftests/bpf/prog_tests/htab_update.c
+++ b/tools/testing/selftests/bpf/prog_tests/htab_update.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2022. Huawei Technologies Co., Ltd */
-#define _GNU_SOURCE
 #include <sched.h>
 #include <stdbool.h>
 #include <test_progs.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/map_in_map.c b/tools/testing/selftests/bpf/prog_tests/map_in_map.c
index d2a10eb4e5b5..51157f4f4ad6 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_in_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_in_map.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2023. Huawei Technologies Co., Ltd */
-#define _GNU_SOURCE
 #include <unistd.h>
 #include <sys/syscall.h>
 #include <test_progs.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
index e72d75d6baa7..fa8c570584d3 100644
--- a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
+++ b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Carlos Neira cneirabustos@gmail.com */
-
-#define _GNU_SOURCE
 #include <test_progs.h>
 #include "test_ns_current_pid_tgid.skel.h"
 #include <sys/stat.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/perf_branches.c b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
index bc24f83339d6..d7b6e9405260 100644
--- a/tools/testing/selftests/bpf/prog_tests/perf_branches.c
+++ b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <pthread.h>
 #include <sched.h>
 #include <sys/socket.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/perf_buffer.c b/tools/testing/selftests/bpf/prog_tests/perf_buffer.c
index 5fc2b3a0711e..d3775af00b0b 100644
--- a/tools/testing/selftests/bpf/prog_tests/perf_buffer.c
+++ b/tools/testing/selftests/bpf/prog_tests/perf_buffer.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <pthread.h>
 #include <sched.h>
 #include <sys/socket.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/perf_event_stackmap.c b/tools/testing/selftests/bpf/prog_tests/perf_event_stackmap.c
index f4aad35afae1..5edbeaf45459 100644
--- a/tools/testing/selftests/bpf/prog_tests/perf_event_stackmap.c
+++ b/tools/testing/selftests/bpf/prog_tests/perf_event_stackmap.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2020 Facebook
-#define _GNU_SOURCE
 #include <pthread.h>
 #include <sched.h>
 #include <test_progs.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/perf_link.c b/tools/testing/selftests/bpf/prog_tests/perf_link.c
index 3a25f1c743a1..083680a47748 100644
--- a/tools/testing/selftests/bpf/prog_tests/perf_link.c
+++ b/tools/testing/selftests/bpf/prog_tests/perf_link.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2021 Facebook */
-#define _GNU_SOURCE
 #include <pthread.h>
 #include <sched.h>
 #include <test_progs.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/perf_skip.c b/tools/testing/selftests/bpf/prog_tests/perf_skip.c
index 37d8618800e4..92bee9815834 100644
--- a/tools/testing/selftests/bpf/prog_tests/perf_skip.c
+++ b/tools/testing/selftests/bpf/prog_tests/perf_skip.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-
 #include <test_progs.h>
 #include "test_perf_skip.skel.h"
 #include <linux/compiler.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/preempted_bpf_ma_op.c b/tools/testing/selftests/bpf/prog_tests/preempted_bpf_ma_op.c
index 3a2ec3923fca..63356b8410e8 100644
--- a/tools/testing/selftests/bpf/prog_tests/preempted_bpf_ma_op.c
+++ b/tools/testing/selftests/bpf/prog_tests/preempted_bpf_ma_op.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2023. Huawei Technologies Co., Ltd */
-#define _GNU_SOURCE
 #include <sched.h>
 #include <pthread.h>
 #include <stdbool.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c b/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
index a1f7e7378a64..da4391d9105d 100644
--- a/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2022 Meta Platforms, Inc. and affiliates.*/
-
-#define _GNU_SOURCE
 #include <unistd.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
index eb74363f9f70..ba59d6ef1c57 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
-
-#define _GNU_SOURCE
 #include <limits.h>
 #include <test_progs.h>
 #include <linux/filter.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
index 4c6f42dae409..0091a42f88ce 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <linux/compiler.h>
 #include <asm/barrier.h>
 #include <test_progs.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
index 58522195081b..3dce8575fbb4 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <test_progs.h>
 #include <sys/epoll.h>
 #include "test_ringbuf_multi.skel.h"
diff --git a/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c b/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c
index 7d4a9b3d3722..fc20202d87c8 100644
--- a/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c
+++ b/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) Meta Platforms, Inc. and affiliates. */
-
-#define _GNU_SOURCE
 #include <sched.h>
 #include <linux/socket.h>
 #include <linux/tls.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
index 0b9bd1d6f7cc..da3e2e98a894 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_assign.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
@@ -7,8 +7,6 @@
  * socket, regardless of whether the port or address destination of the traffic
  * matches the port.
  */
-
-#define _GNU_SOURCE
 #include <fcntl.h>
 #include <signal.h>
 #include <stdlib.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index 597d0467a926..86d4831133db 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -13,8 +13,6 @@
  *
  * Tests run in a dedicated network namespace.
  */
-
-#define _GNU_SOURCE
 #include <arpa/inet.h>
 #include <assert.h>
 #include <errno.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/sock_fields.c b/tools/testing/selftests/bpf/prog_tests/sock_fields.c
index 7d23166c77af..8159bcac07df 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_fields.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_fields.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2019 Facebook */
-
-#define _GNU_SOURCE
 #include <netinet/in.h>
 #include <arpa/inet.h>
 #include <unistd.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
index d4579f735398..a3964524120f 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
-
-#define _GNU_SOURCE
 #include <sys/wait.h>
 #include <test_progs.h>
 #include <unistd.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
index c33c05161a9e..6ba2ea723d4e 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2021 Facebook */
-
-#define _GNU_SOURCE         /* See feature_test_macros(7) */
 #include <unistd.h>
 #include <sched.h>
 #include <pthread.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c b/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c
index f000734a3d1f..87237ecdb3eb 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <test_progs.h>
 #include "test_task_pt_regs.skel.h"
 
diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c b/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
index eaf441dc7e79..05f1b3aa5ebd 100644
--- a/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright Amazon.com Inc. or its affiliates. */
-
-#define _GNU_SOURCE
 #include <sched.h>
 #include <stdlib.h>
 #include <net/if.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c b/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
index 56685fc03c7e..664d8c111c25 100644
--- a/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
+++ b/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
-
-#define _GNU_SOURCE
 #include <sched.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpf_ma.c b/tools/testing/selftests/bpf/prog_tests/test_bpf_ma.c
index ccae0b31ac6c..fbc510772bf8 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_bpf_ma.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_bpf_ma.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2023. Huawei Technologies Co., Ltd */
-#define _GNU_SOURCE
 #include <sched.h>
 #include <pthread.h>
 #include <stdbool.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c b/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
index 2900c5e9a016..fcc045e1942d 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright 2022 Sony Group Corporation */
-#define _GNU_SOURCE
 #include <fcntl.h>
 #include <sys/prctl.h>
 #include <test_progs.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
index ea933fd151c3..c685d13bd6f8 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <sched.h>
 #include <sys/mount.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/test_overhead.c b/tools/testing/selftests/bpf/prog_tests/test_overhead.c
index f27013e38d03..f9d9ee8f2fa4 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_overhead.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_overhead.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2019 Facebook */
-#define _GNU_SOURCE
 #include <sched.h>
 #include <sys/prctl.h>
 #include <test_progs.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testing/selftests/bpf/prog_tests/token.c
index fc4a175d8d76..0b43aeda54a2 100644
--- a/tools/testing/selftests/bpf/prog_tests/token.c
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
-#define _GNU_SOURCE
 #include <test_progs.h>
 #include <bpf/btf.h>
 #include "cap_helpers.h"
diff --git a/tools/testing/selftests/bpf/prog_tests/trace_ext.c b/tools/testing/selftests/bpf/prog_tests/trace_ext.c
index aabdff7bea3e..f389bd922ef3 100644
--- a/tools/testing/selftests/bpf/prog_tests/trace_ext.c
+++ b/tools/testing/selftests/bpf/prog_tests/trace_ext.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <test_progs.h>
 #include <network_helpers.h>
 #include <sys/stat.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/trampoline_count.c b/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
index 6cd7349d4a2b..f21d7b7dd05e 100644
--- a/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
+++ b/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#define _GNU_SOURCE
 #include <test_progs.h>
 
 struct inst {
diff --git a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
index e51721df14fc..7532139c8dbd 100644
--- a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
-
-#define _GNU_SOURCE
 #include <linux/compiler.h>
 #include <linux/ring_buffer.h>
 #include <pthread.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
index 6d8b54124cb3..ca2e652a0716 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
@@ -8,8 +8,6 @@
  * are correctly loaded onto the slave devices and XDP_TX'd
  * packets are balanced using bonding.
  */
-
-#define _GNU_SOURCE
 #include <sched.h>
 #include <net/if.h>
 #include <linux/if_link.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_synproxy.c b/tools/testing/selftests/bpf/prog_tests/xdp_synproxy.c
index 8b50a992d233..9496b576e6f5 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_synproxy.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_synproxy.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
 /* Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
-
-#define _GNU_SOURCE
 #include <test_progs.h>
 #include <network_helpers.h>
 #include <ctype.h>
diff --git a/tools/testing/selftests/bpf/test_flow_dissector.c b/tools/testing/selftests/bpf/test_flow_dissector.c
index 571cc076dd7d..e427c7e5dd94 100644
--- a/tools/testing/selftests/bpf/test_flow_dissector.c
+++ b/tools/testing/selftests/bpf/test_flow_dissector.c
@@ -6,9 +6,6 @@
  * GRE/GUE/BARE outer layer 4, where bare is IPIP/SIT/IPv4-in-IPv6/..
  * IPv4/IPv6    inner layer 3
  */
-
-#define _GNU_SOURCE
-
 #include <stddef.h>
 #include <arpa/inet.h>
 #include <asm/byteorder.h>
diff --git a/tools/testing/selftests/bpf/test_lru_map.c b/tools/testing/selftests/bpf/test_lru_map.c
index 4d0650cfb5cd..82ca6df67eab 100644
--- a/tools/testing/selftests/bpf/test_lru_map.c
+++ b/tools/testing/selftests/bpf/test_lru_map.c
@@ -2,7 +2,6 @@
 /*
  * Copyright (c) 2016 Facebook
  */
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <unistd.h>
 #include <errno.h>
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 89ff704e9dad..87b77f4f1ee5 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2017 Facebook
  */
-#define _GNU_SOURCE
 #include "test_progs.h"
 #include "testing_helpers.h"
 #include "cgroup_helpers.h"
diff --git a/tools/testing/selftests/bpf/test_sock_addr.c b/tools/testing/selftests/bpf/test_sock_addr.c
index aa2198a0f24d..5c0a304ecd84 100644
--- a/tools/testing/selftests/bpf/test_sock_addr.c
+++ b/tools/testing/selftests/bpf/test_sock_addr.c
@@ -1,8 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2018 Facebook
-
-#define _GNU_SOURCE
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
diff --git a/tools/testing/selftests/bpf/test_tcpnotify_user.c b/tools/testing/selftests/bpf/test_tcpnotify_user.c
index 595194453ff8..b415f6457a49 100644
--- a/tools/testing/selftests/bpf/test_tcpnotify_user.c
+++ b/tools/testing/selftests/bpf/test_tcpnotify_user.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <pthread.h>
 #include <inttypes.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index b2854238d4a0..d720947a7896 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 /* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
-#define _GNU_SOURCE
 #include <argp.h>
 #include <string.h>
 #include <stdlib.h>
diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 2eac0895b0a1..101e37a0cb1b 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -70,8 +70,6 @@
  * To enable L2 - L4 headers and payload dump of each packet on STDOUT, add
  * parameter -D to params array in test_xsk.sh, i.e. params=("-S" "-D")
  */
-
-#define _GNU_SOURCE
 #include <assert.h>
 #include <fcntl.h>
 #include <errno.h>
-- 
2.45.0.118.g7fe29c98d7-goog


