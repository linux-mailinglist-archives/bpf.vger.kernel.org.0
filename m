Return-Path: <bpf+bounces-57012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 172E9AA3FCA
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 02:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1EF81887128
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 00:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA0E2DC772;
	Wed, 30 Apr 2025 00:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fIkLe+gg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0B5B640
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 00:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745974192; cv=none; b=f87Q/muXMNYGaUWbU7xVyvOmyyrKoqUaXmKe6yzzcWLeFaUYloVdK9/XtbPZiAzukDC/by0gwNtPIUG/DGF2mJmE7voONjPr+EbhvIHkzoEp2Omsgs5A1+F1NzXBWT6wd/Coq00UWcN7pW2xJqCWc4CmtKCAyC0mXH7BA7Nr3UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745974192; c=relaxed/simple;
	bh=yEUjYaeDDlAF5tuKvlWCruGq7x1qt3DIEsIyspyx7mY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SOWcVdUFzAuQCOSzeH93TwoY7wNrg71kcYLu2zv8IR/I3q0vvRXphvygjNtaDh9prN3jnFuYxCg7A2TDEVBKaHPOKW/AfBFHTkDkoapCI3fnp0bYgE9iQtE1cq3xz0Oz2dlO/ozmhEYqJ9Jkbtr9YVZAx9SwcJFCtF+IQKg6cs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fIkLe+gg; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-227e2faab6dso54052885ad.1
        for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 17:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745974191; x=1746578991; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uVJn6R8AyLKP9RLCMrKJhUthQHLHAwUZd1bqoncqyPg=;
        b=fIkLe+ggcIi+6TuyMiCt4ZNBYtMEGbqblGiQehLp+Y5NQIvUgKMlC9ZjjvCWzNn9oW
         /fRutw8sRU2lr4ags0OtPTGyUd1uzWwE2NZVfisYub+3lhQM1RYtDOkqNMzTrobnmzJy
         mfDPltJ6PebC8aUsGzzncAMBNkFrjWqVsZTNM/YZXopxo4t/bwGBT2K6UiPGf3UDmEyP
         SfHzTymawBwl7i76tbzH55crCCPMWFQTBVwx5ikNWp5Va3odRenGMjxKH+vIBS+gAmLn
         EKV7RZ19kUsiuHrIsz+meGSjd3nvvrRSs6nFAgrnkdiNbiqtcHeXaLkZe8obBN4/iZ9w
         adzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745974191; x=1746578991;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uVJn6R8AyLKP9RLCMrKJhUthQHLHAwUZd1bqoncqyPg=;
        b=wz7TConARObcHx9fSZ3srx2X+AuVA3ZnLxjqm23lcjC1idB/wdQSE43w16b+m7B4+D
         OocrQCByC1o1qLAgsFM0wucr8IDMnHM8TCnj8PDa9NuMk35o8M32DiRsViCCtFrk5V2l
         dAAqytEVLO5fpcpcr2L6QiIUWudrbPXkuSEX8OSZ/22iB3ysPhz+bbeHBKoSuXFZ8Uhm
         BH8xB4ltWT5TTfrI5UIzPT2ZnF2vXNpR0B16enBO6mg4JECuhRViIpT14Zsqb+lNT1wF
         QI/345Pa04ICDTVHEi4pwMOs72rgSDpSrpr5fonMeqXJlxcjH34Qres6CPwirlb86rt6
         1+Kg==
X-Gm-Message-State: AOJu0YwuFI+cHwlYI95WQZJxkywqKv0YOcbiHMTh2/9O+0Z1lxHGEsqZ
	q9wlb4rZIcNPamBOvn5ccA0D5p9GPeFibO9/93ZS/pji87Fb6JSyGlgq4YofT18xvrD43Sudtea
	6kIyTwceH+F0nbo1pbiYQSZuMjH8uPNT0P0qWbPceceMgMozbH8T9RoisNB84QMUVpChuuDlc+x
	naPQy6eT9n6tNfhUvK5pH05/nm4hUMJjfyV5kuR98=
X-Google-Smtp-Source: AGHT+IF9zsphPMP1HajZC8Eo2sh2+VzDRKm+YZlHx2A2vQLcAL4BFROSnhFTkQQBucvMfF5NEp7t7fHg/OmYfg==
X-Received: from pgbcr13.prod.google.com ([2002:a05:6a02:410d:b0:af2:4edb:7793])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2ec8:b0:223:60ce:2451 with SMTP id d9443c01a7336-22df57a5cabmr8537185ad.15.1745974190699;
 Tue, 29 Apr 2025 17:49:50 -0700 (PDT)
Date: Wed, 30 Apr 2025 00:48:53 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.901.g37484f566f-goog
Message-ID: <cover.1745970908.git.yepeilin@google.com>
Subject: [PATCH bpf-next 0/8] bpf, riscv64: Support load-acquire and
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

Hi all!

Patchset [1] introduced BPF load-acquire (BPF_LOAD_ACQ) and
store-release (BPF_STORE_REL) instructions, and added x86-64 and arm64
JIT compiler support.  As a follow-up, this patchset supports
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
 arch/riscv/net/bpf_jit_comp64.c               | 334 ++++++++++++------
 arch/riscv/net/bpf_jit_core.c                 |   3 +-
 kernel/bpf/verifier.c                         |  11 +-
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   5 +-
 .../bpf/progs/verifier_load_acquire.c         |  48 ++-
 .../selftests/bpf/progs/verifier_precision.c  |   5 +-
 .../bpf/progs/verifier_store_release.c        |  39 +-
 8 files changed, 314 insertions(+), 146 deletions(-)

-- 
2.49.0.901.g37484f566f-goog


