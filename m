Return-Path: <bpf+bounces-29512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B44938C2A5A
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 21:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68BAD285349
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 19:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842EA482CA;
	Fri, 10 May 2024 19:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NB5PNy7q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BFC45034
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 19:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715368164; cv=none; b=GlJ8yi7sWmcyk1HF+4ZMzg/zpGwKxrIY8KNLwX1xeT+5HWsF6cqYF3xw2FymddE4qyQvcpNadwl61CesUl4vhH2ms5Wz4Z9j5hsFrEIWZtIbUuvbKVcY3ED8IeiVc7sfVV5ZsqcqVjmxEmgc0OqR+xGUpF0T6ZqBX5+/0ePsE7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715368164; c=relaxed/simple;
	bh=046+K2rooJaiWehncD1DjTIcHY7f2phEuhcBFTeaDGU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=eimTsB/u6vNS4e/yMhVl5QDsw+fisORJ2Ka7m9oAqtKhIN5KhdHpq8Qe2chgD4ownaeCwqwTtaEVPpQGjJVHDDeh+3yQzu1EL6G4M4zVMIfp7rlFMYmN4yMYnEObRTS//MD9mUgx4+SEzGilqTrf6OL1MB3cNY5V7DjsZgZUxnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NB5PNy7q; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6a0dd95cbc6so24464396d6.1
        for <bpf@vger.kernel.org>; Fri, 10 May 2024 12:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715368161; x=1715972961; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hZP8DSrrJ7HH0ntIonPMO4nthwrGJnEqqpwjTbUOSDM=;
        b=NB5PNy7qMHzd8wCX6G5iIeqqVEMik50vHBuQiGep+S2xlxFYv5XD5qwwpAsc8EQT0a
         hJcI+VkvqunSneIoNmYAZa8cYm194GI/QjQFNQ6q13ULMfpAw2VspUcH+OsEL9jzJN2S
         gVobOL/MIRjqQVIz5+8CWfqWj8Z/u/bnItwet3B1ePCgrJ9q5Fli8J3Vc8uOnu6vpJKF
         TpLWUR2vtazc89Q2MOzakXspZScGf5fsHe4yjJOXUZ1hgTI5ZthUWHkKBH+dwN+NJmZ+
         x07b0mSpwg9FdBtt6MWl+pg4ybsUWYEC9HGg6eHMzh9ETGnw8dKGzbKtp10+X4hBzaoh
         ag5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715368161; x=1715972961;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hZP8DSrrJ7HH0ntIonPMO4nthwrGJnEqqpwjTbUOSDM=;
        b=stUnJQuEo815bPe/3n2wSHc5ayozj55DYnps0FfPzQogQGQ2tWdErEbEwqBZdWyR0o
         MsGG9g3iFeFhraW3vBmdc3rxSdcRwDkwIbB6vQbkQGecUQiS152nEuNYTQROBdFiZv9L
         ueClwdxodGBG40H2UniUN9Up+g2s9qMfRpddwkvm1tT2YqQMp/N2CZ/PXAe2u/w1uyRA
         FPfQCGe0MgXcJpGkYULIifs8ikWbJ88TZSZtXW0IaGUtTqL0apPd9AzvbSQxcNRrSs0+
         A42gEvmB8dP1cz6sqy5ENY4XdLn7gA1aYq+PyfB929mMYu5s56W0lKW/HMAAyXGw1LD9
         A2YQ==
X-Gm-Message-State: AOJu0YxLrFuBHC8DX6Wo3cLEy63NknFiaiveMD+Qrzu0RsMROMULU6rN
	wwb5pOStQh4WyrkK6ZOMxOC02EGOGcB0E+5KUma2RDfYKQw0iX366nL71v1pHRiK4oXpyZSbBaN
	3cYYQS07pdvxar5lgwy/bEcy73b6X4jiQSPRx1dRLzjmj0bw1ooJzGNzz47b1t4FYgOIM61nb2O
	pqya0//QQdW/+zJKjP0ql/8Gs=
X-Google-Smtp-Source: AGHT+IGGsXZTPzxHdEkJ5KE1P5Ipo87Hv5nbFQ8da3X3dwC+l4U11PMrYCVwh4lKpb4TjrVQnINN73hlnA==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a92:dd01:0:b0:36c:2ed4:8d4c with SMTP id
 e9e14a558f8ab-36cc14fde56mr743125ab.4.1715367768757; Fri, 10 May 2024
 12:02:48 -0700 (PDT)
Date: Fri, 10 May 2024 14:02:17 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510190246.3247730-1-jrife@google.com>
Subject: [PATCH v1 bpf-next 00/17] Retire progs/test_sock_addr.c
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Geliang Tang <tanggeliang@kylinos.cn>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch series migrates remaining tests from bpf/test_sock_addr.c to
prog_tests/sock_addr.c and progs/verifier_sock_addr.c in order to fully
retire the old-style test program and expands test coverage to test
previously untested scenarios related to sockaddr hooks.

This is a continuation of the work started recently during the expansion
of prog_tests/sock_addr.c.

Link: https://lore.kernel.org/bpf/20240429214529.2644801-1-jrife@google.com/T/#u

=======
Patches
=======
* Patch 1 moves tests that check valid return values for recvmsg hooks
  into progs/verifier_sock_addr.c, a new addition to the verifier test
  suite.
* Patches 2-5 lay the groundwork for test migration, enabling
  prog_tests/sock_addr.c to handle more test dimensions.
* Patches 6-11 move existing tests to prog_tests/sock_addr.c.
* Patch 12 removes some redundant test cases.
* Patches 14-17 expand on existing test coverage.

Jordan Rife (17):
  selftests/bpf: Migrate recvmsg* return code tests to
    verifier_sock_addr.c
  selftests/bpf: Use program name for skel load/destroy functions
  selftests/bpf: Handle LOAD_REJECT test cases
  selftests/bpf: Handle ATTACH_REJECT test cases
  selftests/bpf: Handle SYSCALL_EPERM and SYSCALL_ENOTSUPP test cases
  selftests/bpf: Migrate WILDCARD_IP test
  selftests/bpf: Migrate sendmsg deny test cases
  selftests/bpf: Migrate sendmsg6 v4 mapped address tests
  selftests/bpf: Migrate wildcard destination rewrite test
  selftests/bpf: Migrate expected_attach_type tests
  selftests/bpf: Migrate ATTACH_REJECT test cases
  selftests/bpf: Remove redundant sendmsg test cases
  selftests/bpf: Retire test_sock_addr.(c|sh)
  selftests/bpf: Expand sockaddr program return value tests
  sefltests/bpf: Expand sockaddr hook deny tests
  selftests/bpf: Expand getsockname and getpeername tests
  selftests/bpf: Expand ATTACH_REJECT tests

 tools/testing/selftests/bpf/.gitignore        |    1 -
 tools/testing/selftests/bpf/Makefile          |    4 +-
 .../selftests/bpf/prog_tests/sock_addr.c      | 1821 +++++++++++++++--
 .../selftests/bpf/prog_tests/verifier.c       |    2 +
 .../testing/selftests/bpf/progs/bind4_prog.c  |    6 +
 .../testing/selftests/bpf/progs/bind6_prog.c  |    6 +
 .../selftests/bpf/progs/connect4_prog.c       |    6 +
 .../selftests/bpf/progs/connect6_prog.c       |    6 +
 .../selftests/bpf/progs/connect_unix_prog.c   |    6 +
 .../selftests/bpf/progs/getpeername4_prog.c   |   24 +
 .../selftests/bpf/progs/getpeername6_prog.c   |   31 +
 .../selftests/bpf/progs/getsockname4_prog.c   |   24 +
 .../selftests/bpf/progs/getsockname6_prog.c   |   31 +
 .../selftests/bpf/progs/sendmsg4_prog.c       |    6 +
 .../selftests/bpf/progs/sendmsg6_prog.c       |   57 +
 .../selftests/bpf/progs/sendmsg_unix_prog.c   |    6 +
 .../selftests/bpf/progs/verifier_sock_addr.c  |  331 +++
 tools/testing/selftests/bpf/test_sock_addr.c  | 1140 -----------
 tools/testing/selftests/bpf/test_sock_addr.sh |   58 -
 19 files changed, 2142 insertions(+), 1424 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/getpeername4_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/getpeername6_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/getsockname4_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/getsockname6_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_sock_addr.c
 delete mode 100644 tools/testing/selftests/bpf/test_sock_addr.c
 delete mode 100755 tools/testing/selftests/bpf/test_sock_addr.sh

-- 
2.45.0.118.g7fe29c98d7-goog


