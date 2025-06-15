Return-Path: <bpf+bounces-60673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7FAADA158
	for <lists+bpf@lfdr.de>; Sun, 15 Jun 2025 10:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ADBC3B36BC
	for <lists+bpf@lfdr.de>; Sun, 15 Jun 2025 08:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399A42641CC;
	Sun, 15 Jun 2025 08:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwixWRIm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23E41802B
	for <bpf@vger.kernel.org>; Sun, 15 Jun 2025 08:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749977729; cv=none; b=l2zvZPv8bFsJ4ZNf0GJqVxZrA6m3iUpeOccXKuu5LfiQpmbrAfb19P6JYN3P3/2bHrGqu4UsD50+ZRCIC58zQAfs2tDZdsQM5a6HeUlAni91NFJMvVJ5g1yl6nyN1ARLxS5yAKhJ/JU1itzso3XqdaQFm9DGki0ysV88kdZ2DVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749977729; c=relaxed/simple;
	bh=z85xPdCphjnVjwgE/yDtOoHsykq/vhtJbjxuDCzVKuE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=tz987ASLNTiLwFN2mzauX61TzvVRWBtmoIwi38DPR9Ssi+l2lUulcnI5PgjfqzKQBqEngxpq34qNZnCJJ6UqgIXGNVmCG9ydwr7eYgk7SvhWDo88iUQRjz4oJJbW1aBrMiz7hixDMiCMB8AvPAODfAoauExwoEg0uAZAon3K6EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TwixWRIm; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so3115531f8f.1
        for <bpf@vger.kernel.org>; Sun, 15 Jun 2025 01:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749977726; x=1750582526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BQtAnf0WNP5fZ3TEvuMU/hCUIZ9BKolXcKT+LOpiOJU=;
        b=TwixWRImo8tz7+uJ46MCseHXqP+V284YGNjAjVp6kR3pkTYbeGyzmv6CjpkPO2xIVu
         ePcbm54IXfahr4ORA8mMs88+sN2vei+imtUZOuGoVbZBkuEEJp2n4eAfZ0GnSM62KHNs
         e/xtLFRS4ls5eoqX7F3jXvs+V2O7UoeUW7xi8uA5M+KxlGfVVHURO3JCCFtzaJ0P9tKs
         m0dieNwYE8wPBtEu3JbXmDlCaQBqyiXWNCH0cv4Qb2gjREQGEL3oGOMsXVRma0w4Ms9O
         4SthuQUHfTW6Izuqs51Gw/3QUprH0TMcrdsEELYlcVd0c+J5cVF81S9lhpj6bg327MPQ
         F/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749977726; x=1750582526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BQtAnf0WNP5fZ3TEvuMU/hCUIZ9BKolXcKT+LOpiOJU=;
        b=TVVpITglBWLMPSRMWPWgbQFHR70yfR2j0f6PLwRiaAAYiWJr8VVts61qT+Zm7PJbWh
         kal9tx7xn3NWukHYF0ly6d9U2UR92SdLmzHd3OwSxZGfQFnU50XP5QyXZNDbu+2DwhfD
         eDOaPVTMo/g9toXONNlmeF1Ztz7DKsYh+XSjDb1IwKvb+CmLo5tmV60hoYkDuGAGGaDg
         RvP0oVLvpwcaSRJVjI2WBwTA5+hIDEGh6gy2iAhT/265O0Qnlf2lWj5snZzI26ppXI9l
         QgU0sMrJ1lhRQV1UfQJnCYerfl1JnNRt6ibS54EkecqPXMJ6mG+aQKr+p40fxPNquco0
         aAbg==
X-Gm-Message-State: AOJu0YxMXH7zi4TiVAHpforiSTfLntsUOPcIWR7A9j5kAPLmtqEKM7DB
	EyGaNqk4078C40k8K68unECNaK66cCoxVBbO/dHs8N0SNNQM5i2IrcLR8uxo9g==
X-Gm-Gg: ASbGncuBWDDpRWw4/YvEPcjnEJl5zjmcFoZMQTSpGzIXqUeKmZzSrVPurSJxXqsFga9
	+bRpgrW6Gz99jSr5mRoFqlaJgmhgc0/zzJcwaAz2GJ6V+jqiZn+4+N0HJjWw3UjgH7V7M/bCKqO
	1+ff7ery0YG0Ma1cxPdRZW8WmpWrgadgh5xr0xh01d165YgGzmQnX73+wWsV26xWnFN+vmFjJF1
	6ODJK3KSTq3UX8pWt5nje5iSGVY4Ok9Y4/Iq1yJ1I/qqYqV0TZKe1gqgiEv7ETcia96Hv5rvAFe
	+HzZwcEAPpM3+AlIkaLjj5xmWD8wqaT8gCU/asOn99cacQH/hHrvjlZqitzHIFaFX6pvBwuod9P
	xUZYdTw==
X-Google-Smtp-Source: AGHT+IGXpKtvCgq5uT9eeq+bBoLIrCwi2NIJoXv7dJenqN5U/dkvjGqwuQ020vltVF1CtSIlbuzaXw==
X-Received: by 2002:a05:6000:2307:b0:3a5:23c6:eeee with SMTP id ffacd0b85a97d-3a572e75399mr5314739f8f.21.1749977725669;
        Sun, 15 Jun 2025 01:55:25 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a633ddsm7196105f8f.26.2025.06.15.01.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 01:55:25 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [RFC bpf-next 0/9] BPF indirect jumps
Date: Sun, 15 Jun 2025 08:59:34 +0000
Message-Id: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset implements a new type of map, instruction set, and uses
it to build support for indirect branches in BPF (x86). (The same map
will be later used to provide support for indirect calls and static
keys.) See [1], [2] for more context.

Short table of contents:

  * Patches 1,2,3 implement the new map of type
    BPF_MAP_TYPE_INSN_SET. This map can be used to track the
    "original -> xlated -> jitted mapping" for a given program.

  * patches 4,5 implement the support for indirect jumps

  * 6,7,8,9 add support for LLVM-compiled programs containing
    indirect jumps. A special LLVM should be used for that, see [3]
    for the details and some related discussions.

There is a list of TBDs (mostly, more checks & selftests, faster
lookups, etc.), plus the tests only can be compiled by a custom
LLVM, thus this is an RFC. However, all the selftests which compile 
to contain an indirect jump work with this patchset, so it is looking
worth sending it as is already. Namely, the following selftests
will contain an indirect jump:

    * bpf_goto_x, cgroup_tcp_skb, cls_redirect, bpf_tcp_ca,
    * bpf_iter_setsockopt, tc_change_tail, net_timestamping,
    * user_ringbuf, tcp_hdr_options, tunnel, exceptions,
    * tcpbpf_user, tcp_custom_syncookie

See individual patches for more details on implementation details.

Links:
  1. https://lpc.events/event/18/contributions/1941/
  2. https://lwn.net/Articles/1017439/
  3. https://github.com/llvm/llvm-project/pull/133856

Anton Protopopov (9):
  bpf: save the start of functions in bpf_prog_aux
  bpf, x86: add new map type: instructions set
  selftests/bpf: add selftests for new insn_set map
  bpf, x86: allow indirect jumps to r8...r15
  bpf, x86: add support for indirect jumps
  bpf: workaround llvm behaviour with indirect jumps
  bpf: disasm: add support for BPF_JMP|BPF_JA|BPF_X
  libbpf: support llvm-generated indirect jumps
  selftests/bpf: add selftests for indirect jumps

 arch/x86/net/bpf_jit_comp.c                   |  44 +-
 include/linux/bpf.h                           |  24 +
 include/linux/bpf_types.h                     |   1 +
 include/linux/bpf_verifier.h                  |   6 +
 include/uapi/linux/bpf.h                      |  11 +
 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/bpf_insn_set.c                     | 407 +++++++++++++++
 kernel/bpf/core.c                             |   2 +
 kernel/bpf/disasm.c                           |  10 +
 kernel/bpf/syscall.c                          |  22 +
 kernel/bpf/verifier.c                         | 266 +++++++++-
 tools/include/uapi/linux/bpf.h                |  11 +
 tools/lib/bpf/libbpf.c                        | 333 +++++++++++-
 tools/lib/bpf/libbpf_internal.h               |   4 +
 tools/lib/bpf/linker.c                        |  66 ++-
 tools/testing/selftests/bpf/Makefile          |   4 +-
 .../selftests/bpf/prog_tests/bpf_goto_x.c     | 127 +++++
 .../selftests/bpf/prog_tests/bpf_insn_set.c   | 481 ++++++++++++++++++
 .../testing/selftests/bpf/progs/bpf_goto_x.c  | 336 ++++++++++++
 19 files changed, 2116 insertions(+), 41 deletions(-)
 create mode 100644 kernel/bpf/bpf_insn_set.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_goto_x.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_insn_set.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_goto_x.c

-- 
2.34.1


