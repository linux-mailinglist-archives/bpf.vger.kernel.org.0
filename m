Return-Path: <bpf+bounces-71683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 719A3BFAC09
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 10:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A9D2D341C18
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 08:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708D7301002;
	Wed, 22 Oct 2025 08:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNpOxUlk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99442FF15E
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 08:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120132; cv=none; b=tJTAXaO/ZWEW0pMSJJfrDjLPjdEG97nWlncinWgmJI0a7eGXDjmkYka0udV4caHFFg+swL4Yb7Wk5PqU5F+YasjJkoSc5XxMnh/i8r2tw9u4POPQRMJEPg3imMDG5D9RY0CIXf2WwSn9os+z5m1cKhC728L14F/1r502jfVTwgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120132; c=relaxed/simple;
	bh=KES1rqhhzVkWHCaQsx5xIA87TR29YUXJ/eVpvlSxQpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B84byX9uK1T42sPqeRwFohBjwZ8JDYM7cUffM7Cq6jQu6OqPirSxrn0ED1KBNLyQNS2k8azaB55jGSmSVDG570mXkeAqXcKYvhMgEWkJl0sJ/Bb0ksEgLF+b1JY8+jjttwP70thWB+c93Z8csTDUYNw3N637DSoCp9NrlUg3anI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNpOxUlk; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-290aaff555eso64280955ad.2
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 01:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761120129; x=1761724929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8IULEjah58/8/ttFr7hd4dbKkGYaqM5HUaRTvDTqwJA=;
        b=LNpOxUlkLx6W9UIs/CKAvDGW1SsciwZUL0sK46l9oxL3wTNyFT6Z1End3h5mTQ8TX1
         +7XeLsPXOXHed5O4WYtogL6Z5YB8aUJWEyna8m11RnxAD08qTbzXgDEHdwGTLj3Yrzuo
         vBjcJv1SZM5poDElEVyC3y4nACyuwfUGkeLWDaBWuDuDtG95BsKz4a6zCssp+tYn0r/I
         F0fK0VLZaTCWk9cWehJ8dFewGArLaiYZAmkTsJj1vc7GPTPwa3gftQE7MkdisIoVBY1U
         Um+7HWtIUeKbD1Ekhu/z0t/lc3vtKBlsqS2CnKIySGX9XKfoZ4caET6HuaOXQpnLJZGW
         1phg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120129; x=1761724929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8IULEjah58/8/ttFr7hd4dbKkGYaqM5HUaRTvDTqwJA=;
        b=WfS5FASjtNWFVDXAxrDEhnXGd8zTfLVV4J6EQwJ0MlU9NdG9pXlNlQV4yv1+dzyZPp
         xgiBSFG0SSQgsXdykxp8l6ThmsAYTqBHKmtHo/BPXIIkXB5rPnxE9viG55WJwWlx/ycn
         V1aBTxOGMUGqU/3RbOILX1LKhB4hL/Gt4JqvVNcoxNMcfW39K9RNQ+tcs5KaTB87+IiX
         Tv0Hi4LmpunroGkzv6pWplnsHI5AP0uPGVQwlzEh8C6smlVPU/pE7UoEL5md6A4/wWRu
         D7lu2T5IVEbmASyIc4ZBLGorbiXGU71bf2477mQ+PFvd9eZ+N6h2kzDlTGH7ntmsjY1Q
         3XJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ/4prfl4mmRsg7u904am9TwuVmkL4lxy0orZQbzZ6guRIKv4uOPIT5eXGIhjl1onZ9jc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4QgCeLMpje+57j07vu9RVSKmGmn07yw7xsFtjeEvlXV7i9G3Q
	zAV9PjqCcDY3flk8JbiFx5OTWPxYTCdCXoi40JY9dAlsDqOCBlyFyXH+
X-Gm-Gg: ASbGncuReLsfpGp1EJ6pIzK4GILy/kD7nGQH3eXTp6rSYsRGeT9TJ9oTWthN+x5scIb
	ifW0ysc6d6wmEW/k7/IrcPDcWrVi6vXnybc6IVaVSnF8IfaCQtM8b3o4mZzR27FvzdyN2v9954I
	Nvn/iCoZvqcy3+TMCZ2+j1613ybGKQzzvO4QdCqh/6E4eorG4QmuwaCfSHjoZe+ntm0yUSeRZNz
	D1rUIKrRiwyUFCwXERPD529byrqHMua2BvHopD2j9q0hRS8FdC83cbUbObaF6/+ee1vB5wIvDsx
	dR6cOeHixKcwXRG15nDE7we5Rpx6Wox4jWFh0a4efPqSEUyC97NZN/O0l1Ac4IOeWLzSFKJscmR
	/le2iQ23OWEsuDI9/Xg4xUjn48weSvI4el7E3NcCdfox+mzX7DbJhgKxiGcglHiEAG7YRg5SgKl
	sB3R4jx7I=
X-Google-Smtp-Source: AGHT+IHUvFNEb8ueoRDJavJW321o3FS33gCYT8NQTFkfClnVpzJ7UDlFH8bs4uMSU13s5U8IClXzXw==
X-Received: by 2002:a17:903:244f:b0:261:e1c0:1c44 with SMTP id d9443c01a7336-290cc2f83a5mr263831745ad.40.1761120128951;
        Wed, 22 Oct 2025 01:02:08 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d7e41sm131947785ad.57.2025.10.22.01.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:02:08 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	jolsa@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	leon.hwang@linux.dev,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 00/10] bpf: tracing session supporting
Date: Wed, 22 Oct 2025 16:01:49 +0800
Message-ID: <20251022080159.553805-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes, we need to hook both the entry and exit of a function with
TRACING. Therefore, we need define a FENTRY and a FEXIT for the target
function, which is not convenient.

Therefore, we add a tracing session support for TRACING. Generally
speaking, it's similar to kprobe session, which can hook both the entry
and exit of a function with a single BPF program. Meanwhile, it can also
control the execution of the fexit with the return value of the fentry.
Session cookie is also supported with the kfunc bpf_fsession_cookie().

The kfunc bpf_tracing_is_exit() and bpf_fsession_cookie() are both inlined
in the verifier.

We allow the usage of bpf_get_func_ret() to get the return value in the
fentry of the tracing session, as it will always get "0", which is safe
enough and is OK.

The while fsession stuff is arch related, so the -EOPNOTSUPP will be
returned if it is not supported yet by the arch. In this series, we only
support x86_64. And later, other arch will be implemented.

Changes since v1:
* session cookie support.
  In this version, session cookie is implemented, and the kfunc
  bpf_fsession_cookie() is added.

* restructure the layout of the stack.
  In this version, the session stuff that stored in the stack is changed,
  and we locate them after the return value to not break
  bpf_get_func_ip().

* testcase enhancement.
  Some nits in the testcase that suggested by Jiri is fixed. Meanwhile,
  the testcase for get_func_ip and session cookie is added too.

Menglong Dong (10):
  bpf: add tracing session support
  bpf: add kfunc bpf_tracing_is_exit for TRACE_SESSION
  bpf: add kfunc bpf_fsession_cookie for TRACING SESSION
  bpf,x86: add ret_off to invoke_bpf()
  bpf,x86: add tracing session supporting for x86_64
  libbpf: add support for tracing session
  selftests/bpf: test get_func_ip for fsession
  selftests/bpf: add testcases for tracing session
  selftests/bpf: add session cookie testcase for fsession
  selftests/bpf: add testcase for mixing fsession, fentry and fexit

 arch/arm64/net/bpf_jit_comp.c                 |   3 +
 arch/loongarch/net/bpf_jit.c                  |   3 +
 arch/powerpc/net/bpf_jit_comp.c               |   3 +
 arch/riscv/net/bpf_jit_comp64.c               |   3 +
 arch/s390/net/bpf_jit_comp.c                  |   3 +
 arch/x86/net/bpf_jit_comp.c                   | 214 ++++++++++++++++--
 include/linux/bpf.h                           |   2 +
 include/uapi/linux/bpf.h                      |   1 +
 kernel/bpf/btf.c                              |   2 +
 kernel/bpf/syscall.c                          |   2 +
 kernel/bpf/trampoline.c                       |   5 +-
 kernel/bpf/verifier.c                         |  45 +++-
 kernel/trace/bpf_trace.c                      |  59 ++++-
 net/bpf/test_run.c                            |   1 +
 net/core/bpf_sk_storage.c                     |   1 +
 tools/bpf/bpftool/common.c                    |   1 +
 tools/include/uapi/linux/bpf.h                |   1 +
 tools/lib/bpf/bpf.c                           |   2 +
 tools/lib/bpf/libbpf.c                        |   3 +
 .../selftests/bpf/prog_tests/fsession_test.c  | 161 +++++++++++++
 .../bpf/prog_tests/get_func_ip_test.c         |   2 +
 .../bpf/prog_tests/tracing_failure.c          |   2 +-
 .../selftests/bpf/progs/fsession_cookie.c     |  49 ++++
 .../selftests/bpf/progs/fsession_mixed.c      |  45 ++++
 .../selftests/bpf/progs/fsession_test.c       | 175 ++++++++++++++
 .../selftests/bpf/progs/get_func_ip_test.c    |  14 ++
 26 files changed, 776 insertions(+), 26 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fsession_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/fsession_cookie.c
 create mode 100644 tools/testing/selftests/bpf/progs/fsession_mixed.c
 create mode 100644 tools/testing/selftests/bpf/progs/fsession_test.c

-- 
2.51.1.dirty


