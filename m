Return-Path: <bpf+bounces-26635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D15A8A3410
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 18:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 058DD285771
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 16:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B3154F87;
	Fri, 12 Apr 2024 16:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CG2YHcOn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F140F14B077
	for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 16:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712940767; cv=none; b=fU/Y/Uecc3p2xs9cQ+y8alKl6AYicF+A/0mHnBrKn2wsBVq6NYWj1zEkDZ1zWd181AxHOTCy0NbNqkJe9EK3SkJ5yvRXk4MZ3/dXfoRKsuoveEKnXVFxbPCmB4Y6MJcAUihSsvMPYCJo7IEcF3vXRS4vNR+gsTa1RkRE/2A35Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712940767; c=relaxed/simple;
	bh=usmj1mNoKthI5m8l3Dk3m0aCP+Dn54ILjAR1+C5OQ2w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=W+/vEYjXvrwS1cRrPttscdJG25zeF1n+WsMwVVL0BQw+gfBR6LgDRX8iW/aEvC6Oq4Z6WJ1e1566IDAePzSaXTLUE5rV2M27dljGwN8yWTypvtNGFeCyyPlUM5afZvodlezAUm8PBulmFn0tjK8Cz1bs5o5X4YQLzF76uO4dkuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CG2YHcOn; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61869a4320bso18991147b3.0
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 09:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712940765; x=1713545565; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vQ3wry0bRnSowFxbBNPWKPghb31lBBPlIMBNxACr2OA=;
        b=CG2YHcOni6AEmlQmicX+mS5T8GEIbabjEioW43Twavrb7oS7ALRRZZu5owzqsGNEyR
         qlvHOvHmVpsN3sfYMRIZuz6DRLDwFf7QFj++azKzXYkNlayAh70uxajwA4MYOC4SqdfH
         HMXzKLuQRnHTOZvm+bkY3g6gK8ynJK2d3evXEyD8mVjkHUk2KA5ZRJ0nDIp9WRmJ8Qw8
         QFYWQwXheg1LE1W9HRkznh32p4iGWY1RPK+SNt5LY+m3bgd6PSafZcWg6A91DZ9+Y3RZ
         1G7/ZCepk90a9uLuZxDznMZ2f+XYvIuYatPZgMsYRoURUPk0SATnQ3jULWQVrVAY6AQ5
         ONTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712940765; x=1713545565;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vQ3wry0bRnSowFxbBNPWKPghb31lBBPlIMBNxACr2OA=;
        b=YlTQ/Ygv0pR7r9EkY+J+hVqz/a0ByVc4qTr1Ae9RexUd9J6xnlWpR89sE9rrEUZ/JE
         renrDSCiCVhL2mVfmtcJ5JS5ftwUwIiHu3IM1hE2E37TTI5aPSbLYzHOC4cBoYJZ81MH
         zACOEyqUxfNNTZwINiFyyK9Qn2ju/jQamWavAJXX1+oHzdWBfLY93vC/t10h9kzKGj0R
         1thNbBusYdyNHNwSw2zQZXHVdq6tYTNUJjksghZ8kiUk5p4d+YmAYBoihiUyU5PAoLyF
         NdvlcJDcrSw8x4xEb8er29eFSZi4WaI/QHevBT32zNtGpF6H464xy7jOZkJjtUOTZ842
         2/bg==
X-Gm-Message-State: AOJu0Yy5B9i2quAwCuG2bP/J/IMPNh1FzrCEUjI/Pfu546Wggh2pvHyP
	/YHg0O9fvzlkWDtN4Xx/ULGKbg7KnYmXpxVn1Fpr96wN5oeHYPqsVRftzuMyVEAL5vfkGaMnCxn
	OK84u9AgbWi8QcwXRCOBY1BoMmsQR4Hl6ieW1hHBurreoOaio53AIOXRSsAqisJm4b0FsQKOctT
	fhyRp/t2UaOI1qHr2NRJiFabg=
X-Google-Smtp-Source: AGHT+IF9WYo61DUMT0LJwtbVzY7nTOoh6B3GbB8pT2/kXoroFpERZxCmf6idfLJrdqRCRd+UeikUEizhGg==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a81:4c55:0:b0:618:3525:2bb4 with SMTP id
 z82-20020a814c55000000b0061835252bb4mr1435298ywa.3.1712940765015; Fri, 12 Apr
 2024 09:52:45 -0700 (PDT)
Date: Fri, 12 Apr 2024 11:52:21 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240412165230.2009746-1-jrife@google.com>
Subject: [PATCH v2 bpf-next 0/6] selftests/bpf: Add sockaddr tests for kernel networking
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Kui-Feng Lee <thinker.li@gmail.com>, Artem Savkov <asavkov@redhat.com>, 
	Dave Marchevsky <davemarchevsky@fb.com>, Menglong Dong <imagedong@tencent.com>, Daniel Xu <dxu@dxuuu.xyz>, 
	David Vernet <void@manifault.com>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"

This patch series adds test coverage for BPF sockaddr hooks and their
interactions with kernel socket functions (i.e. kernel_bind(),
kernel_connect(), kernel_sendmsg(), sock_sendmsg(),
kernel_getpeername(), and kernel_getsockname()) while also rounding out
IPv4 and IPv6 sockaddr hook coverage in prog_tests/sock_addr.c.

As with v1 of this patch series, we add regression coverage for the
issues addressed by these patches,

- commit 0bdf399342c5("net: Avoid address overwrite in kernel_connect")
- commit 86a7e0b69bd5("net: prevent rewrite of msg_name in sock_sendmsg()")
- commit c889a99a21bf("net: prevent address rewrite in kernel_bind()")
- commit 01b2885d9415("net: Save and restore msg_namelen in sock_sendmsg")

but broaden the focus a bit.

In order to extend prog_tests/sock_addr.c to test these kernel
functions, we add a set of new kfuncs that wrap individual socket
operations to bpf_testmod and invoke them through set of corresponding
SYSCALL programs (progs/sock_addr_kern.c). Each test case can be
configured to use a different set of "sock_ops" depending on whether it
is testing kernel calls (kernel_bind(), kernel_connect(), etc.) or
system calls (bind(), connect(), etc.).

=======
Patches
=======
* Patch 1 fixes the sock_addr bind test program to work for big endian
  architectures such as s390x.
* Patch 2 introduces the new kfuncs to bpf_testmod.
* Patch 3 introduces the BPF program which allows us to invoke these
  kfuncs invividually from the test program.
* Patch 4 lays the groundwork for IPv4 and IPv6 sockaddr hook coverage
  by migrating much of the environment setup logic from
  bpf/test_sock_addr.sh into prog_tests/sock_addr.c and adds test cases
  to cover bind4/6, connect4/6, sendmsg4/6 and recvmsg4/6 hooks.
* Patch 5 makes the set of socket operations for each test case
  configurable, laying the groundwork for Patch 6.
* Patch 6 introduces two sets of sock_ops that invoke the kernel
  equivalents of connect(), bind(), etc. and uses these to add coverage
  for the kernel socket functions.

=======
Changes
=======
v1->v2
------
* Dropped test_progs/sock_addr_kern.c and the sock_addr_kern test module
  in favor of simply expanding bpf_testmod and test_progs/sock_addr.c.
* Migrated environment setup logic from bpf/test_sock_addr.sh into
  prog_tests/sock_addr.c rather than invoking the script from the test
  program.
* Added kfuncs to bpf_testmod as well as the sock_addr_kern BPF program
  to enable us to invoke kernel socket functions from
  test_progs/sock_addr.c.
* Added test coverage for kernel socket functions to
  test_progs/sock_addr.c.

Link: https://lore.kernel.org/bpf/20240329191907.1808635-1-jrife@google.com/T/#u

Jordan Rife (6):
  selftests/bpf: Fix bind program for big endian systems
  selftests/bpf: Implement socket kfuncs for bpf_testmod
  selftests/bpf: Implement BPF programs for kernel socket operations
  selftests/bpf: Add IPv4 and IPv6 sockaddr test cases
  selftests/bpf: Make sock configurable for each test case
  selftests/bpf: Add kernel socket operation tests

 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 139 +++
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |  27 +
 .../selftests/bpf/prog_tests/sock_addr.c      | 940 +++++++++++++++---
 .../testing/selftests/bpf/progs/bind4_prog.c  |  18 +-
 .../testing/selftests/bpf/progs/bind6_prog.c  |  18 +-
 tools/testing/selftests/bpf/progs/bind_prog.h |  19 +
 .../selftests/bpf/progs/sock_addr_kern.c      |  65 ++
 7 files changed, 1077 insertions(+), 149 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bind_prog.h
 create mode 100644 tools/testing/selftests/bpf/progs/sock_addr_kern.c

-- 
2.44.0.478.gd926399ef9-goog


