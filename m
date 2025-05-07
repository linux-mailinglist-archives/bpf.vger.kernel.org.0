Return-Path: <bpf+bounces-57615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B068AAD426
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 05:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DCA01BA739F
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 03:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671591B4257;
	Wed,  7 May 2025 03:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZiWw+Mgc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8040E42048
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 03:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746589364; cv=none; b=gZLMPerPIHTpmC+UQ4cv8Pyp+29o3NjX4/rvvLDelHszriTcKe1wHKvHXiIvybfJ6w3LJDHjZHOGsIu/vT6ZRj+9kMwPVtfWmvz6DFTeR89jWZnJWOdY2WdJEXo8gka+VkOj7lKlcpagRjTDTMVDA9C/JOfraC0fxcfMXCAU3pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746589364; c=relaxed/simple;
	bh=rYtMXE5cLE8zY8WFH+q8HO9qUi0HyYA+pRbraSnijIQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TBLvwduXs6W2GOdFeCmzZSSTt9CN9SUN30vv3QYjHumaiOLtmcjaSboK2oQSxPFyA6FU/3TKt60POgltCjuLtS8LHbOMQK/H2Z1418MoDfvbjZift8hOmBmuYo7dvwtkhwaVnl/N+dd8/N9K7Q9G8/WBWAOdE3CvLMTj+aY5ET0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZiWw+Mgc; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-736b431ee0dso4769037b3a.0
        for <bpf@vger.kernel.org>; Tue, 06 May 2025 20:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746589363; x=1747194163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zq7LU3JKFzJT28CjBFkNg7IAHXfKJMWuEZp8c2mW00c=;
        b=ZiWw+MgcD1Nb08cdPwB0eHuk1dY/6b6r3rDB/vlbqMzT1UxaMBhX/XkbLQubWTWCrk
         2ZX+A2mX0jtzTySdZeB3q+SRy9aOAcLZ7oUMvoYZhIi9rdgzF/i4hLy50oTos3mMBzVl
         MQa4zwCE4Br6VkmUjpDJKpyhh01NhpkVDvc9A8vYGKott1jjX1NCX2R8z3V6Ug5vn8xz
         cQY2SHeZEDPLsG4sA0GAIuf/h5ZA9hP6YqZewQDjrYRqMiqEwQiX1WomDY69rg9caZdB
         1JTNm64zHMnZEwnwB267MK9Ht7fY+3bPUvmAvc2peR0GbEP/GXtj9xWU38IerNUVCXC9
         syag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746589363; x=1747194163;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zq7LU3JKFzJT28CjBFkNg7IAHXfKJMWuEZp8c2mW00c=;
        b=lN+kEhs9vI8jMVUCviPnUy5gOyze+juxV1VxsWFw2EfBiPE3J0MVszj7obwLuRrJ+D
         9pyDE7oi77n5lkoGTTBSoKfADnAI1S4JWKyesSb9K19RcQNfzSsjJGzL+2aYCqX2RsD9
         yJcK0XTktkStKdhyYsEYCO/T0niLulv62eV5KnyV7HZMVfsA/4OORcQ2pIImPZdUY+/k
         /98QlStXjS2daJ973aMq9ZrNkGPE4N/KGaCw7PS8niaIvUlewiJhpDZKmoaXkvyUK/In
         iM5oAncUEUpw/bM9BXc1dGXtzi3r3vtFND5V1Bh/ulST9DnVyqj05oxdP7qVUtHq74zY
         S4tA==
X-Gm-Message-State: AOJu0YxClbbEeG9bPkDHgZnLF5jLa50asJVyDcZoVTGyR4w3EmA74C0c
	WpPgLCzms10yZSY3HGm2X3PZ6hTC/K3SsaBVO+yw1dl7qMBql+kAxzxMmDjNvpJhAzf6JqDlVM3
	zKteiTxMl33bN+rIPUyYQy3MiLuI6Gh6V13SXXlAixgfsQ0g5rk5dxypin0E+u+qlEmvcN92FGs
	inLg8L+YXTDBf3v6ZvwDdKpBYPoXKsP+SMVXlOQNs=
X-Google-Smtp-Source: AGHT+IFgAfqWvX5PEh1cmn/u8Yxf4LfZBK3LA1v4JaXGtqfLL/0kW1PeCJmxk05AdT4eeV56gWtBEcduQpTx6A==
X-Received: from pgcl20.prod.google.com ([2002:a63:7014:0:b0:b16:7375:98d2])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:d70f:b0:1ee:c8e7:203c with SMTP id adf61e73a8af0-2148bf0678amr2882726637.24.1746589362544;
 Tue, 06 May 2025 20:42:42 -0700 (PDT)
Date: Wed,  7 May 2025 03:42:29 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <cover.1746588351.git.yepeilin@google.com>
Subject: [PATCH bpf-next v2 0/8] bpf, riscv64: Support load-acquire and
 store-release instructions
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org
Cc: Peilin Ye <yepeilin@google.com>, linux-riscv@lists.infradead.org, 
	Andrea Parri <parri.andrea@gmail.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@kernel.org>, Pu Lehui <pulehui@huawei.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, 
	Neel Natu <neelnatu@google.com>, Benjamin Segall <bsegall@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all!

Patchset [1] introduced BPF load-acquire (BPF_LOAD_ACQ) and
store-release (BPF_STORE_REL) instructions, and added x86-64 and arm64
JIT compiler support.  As a follow-up, this v2 patchset supports
load-acquire and store-release instructions for the riscv64 JIT
compiler, and introduces some related selftests/ changes.

Specifically:

 * PATCH 1 makes insn_def_regno() handle load-acquires properly for
   bpf_jit_needs_zext() (true for riscv64) architectures
 * PATCH 2, 3 from Andrea Parri add the actual support to the riscv64
   JIT compiler
 * PATCH 4 optimizes code emission by skipping redundant zext
   instructions inserted by the verifier
 * PATCH 5, 6 and 7 are minor selftest/ improvements
 * PATCH 8 enables (non-arena) load-acquire/store-release selftests for
   riscv64

v1: https://lore.kernel.org/bpf/cover.1745970908.git.yepeilin@google.com/
Changes since v1:

 * add Acked-by:, Reviewed-by: and Tested-by: tags from Lehui and Bj=C3=B6r=
n
 * simplify code logic in PATCH 1 (Lehui)
 * in PATCH 3, avoid changing 'return 0;' to 'return ret;' at the end of
   bpf_jit_emit_insn() (Lehui)

Please refer to individual patches for details.  Thanks!

[1] https://lore.kernel.org/all/cover.1741049567.git.yepeilin@google.com/

Andrea Parri (2):
  bpf, riscv64: Introduce emit_load_*() and emit_store_*()
  bpf, riscv64: Support load-acquire and store-release instructions

Peilin Ye (6):
  bpf/verifier: Handle BPF_LOAD_ACQ instructions in insn_def_regno()
  bpf, riscv64: Skip redundant zext instruction after load-acquire
  selftests/bpf: Use CAN_USE_LOAD_ACQ_STORE_REL when appropriate
  selftests/bpf: Avoid passing out-of-range values to __retval()
  selftests/bpf: Verify zero-extension behavior in load-acquire tests
  selftests/bpf: Enable non-arena load-acquire/store-release selftests
    for riscv64

 arch/riscv/net/bpf_jit.h                      |  15 +
 arch/riscv/net/bpf_jit_comp64.c               | 332 ++++++++++++------
 arch/riscv/net/bpf_jit_core.c                 |   3 +-
 kernel/bpf/verifier.c                         |  12 +-
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   5 +-
 .../bpf/progs/verifier_load_acquire.c         |  48 ++-
 .../selftests/bpf/progs/verifier_precision.c  |   5 +-
 .../bpf/progs/verifier_store_release.c        |  39 +-
 8 files changed, 313 insertions(+), 146 deletions(-)

--=20
2.49.0.967.g6a0df3ecc3-goog


