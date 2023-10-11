Return-Path: <bpf+bounces-11934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA197C59DB
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 19:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2E621C210D7
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 17:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC603F4B3;
	Wed, 11 Oct 2023 17:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1J3OrrC"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AF220321;
	Wed, 11 Oct 2023 17:03:34 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3E4A9;
	Wed, 11 Oct 2023 10:03:32 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3226cc3e324so18921f8f.3;
        Wed, 11 Oct 2023 10:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697043810; x=1697648610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O8f6jft0ZVNF03kdg1HTcElCVATk781aUKVxKqnuxVA=;
        b=N1J3OrrCQcY4jLNH0zV1ZSURd0Z7dVf4hL4Sh+jCZnIykNqKmN2Znsh0PRd7oMHDQq
         bpP4RYWweiz928/UJFNQcFLHuhzapseAZMsbduLiOrNI5/XP1bS8PhvX/Dd0/+b1MM/H
         bgSRw58DqDkhSI1HioZAPvWPWRwjrLmShpDYoHVByY8DmV/1yCqIva6wB+AgUI8Tsijr
         FhPMc90i0IxV2QZe9BYS9v8EQ+IqjlBJ5axTobtIoLW3AuJ0y9EyjD+WqLXj+BA2Ypmc
         Mm+OuTx55ubW/5Qg7w2TLZF/bE03Eotqr9Rv5yzBTwilh07IPH0EmDHA0f+SV1sPThnC
         oREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697043810; x=1697648610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O8f6jft0ZVNF03kdg1HTcElCVATk781aUKVxKqnuxVA=;
        b=QYRWQeXoeu/0jxHCsl633f47YpeGFjuEyNaO8Dm58eB8djgBoTwFApFEZAVL4x2nrA
         yE9ubNokv5Ti0iNz4tvITYviZ7XghXeClUMDLcQup+NARaZ50ozoKSgPLhGFte4hrab2
         Xq0Pn0930QNPgvysng0pjdmkb/uWj0oWZSz3Gtpcvtp+rjJMnB0QRhPwlT4JpqIv3YTi
         LB28luqlVSLOuvHTNup96eVg7P8pumILu8EJQBncWL88LRRVL5kwRuK2A7yqjxPCpT4T
         v/oeNIIGYs+MhINnC+2qbFqCPmH/5eJK7ydkyGDvtwmLymVFdjkNtDl4CswOBgyooqUP
         HCWw==
X-Gm-Message-State: AOJu0YzLfAkQLC8YLYKqoavTWrf4Dy0XA9kgUfX7jd+wC/2zN1Fxrn8z
	xNINy57OFm2f5B9W7WuQCpIDzrKiCraYsFs1
X-Google-Smtp-Source: AGHT+IGFi5qnUz9apn/9l8MRxNQoCGxZx9gahWbxfT+3x0uAfNjAQ+TJCzL+Ejac9Oab1p7ekmLLtQ==
X-Received: by 2002:adf:e892:0:b0:31f:a503:c05c with SMTP id d18-20020adfe892000000b0031fa503c05cmr19841850wrm.38.1697043809968;
        Wed, 11 Oct 2023 10:03:29 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:864b:8201:e534:34f4:1c34:8de7])
        by smtp.googlemail.com with ESMTPSA id h28-20020adfa4dc000000b003296b913bbesm2335480wrb.12.2023.10.11.10.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 10:03:29 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v10 0/9] Add cgroup sockaddr hooks for unix sockets
Date: Wed, 11 Oct 2023 19:03:09 +0200
Message-ID: <20231011170321.73950-1-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
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

Changes since v9:

* Renamed bpf_sock_addr_set_unix_addr() to bpf_sock_addr_set_sun_path() and
  rennamed arguments to match the new name.
* Added an extra check to bpf_sock_addr_set_sun_path() to disallow changing the
  address of an unnamed unix socket.
* Removed unnecessary NULL check on uaddrlen in
  __cgroup_bpf_run_filter_sock_addr().

Changes since v8:

* Added missing test programs to last patch

Changes since v7:

* Fixed formatting nit in comment
* Renamed from cgroup/connectun to cgroup/connect_unix (and similar for all
  other hooks)

Changes since v6:

* Actually removed bpf_bind() helper for AF_UNIX hooks.
* Fixed merge conflict
* Updated comment to mention uaddrlen is read-only for AF_INET[6]
* Removed unnecessary forward declaration of struct sock_addr_test
* Removed unused BPF_CGROUP_RUN_PROG_UNIX_CONNECT()
* Fixed formatting nit reported by checkpatch
* Added more information to commit message about recvmsg() on connected socket

Changes since v5:

* Fixed kernel version in bpftool documentation (6.3 => 6.7).
* Added connection mode socket recvmsg() test.
* Removed bpf_bind() helper for AF_UNIX hooks.
* Added missing getpeernameun and getsocknameun BPF test programs.
* Added note for bind() test being unused currently.

Changes since v4:

* Dropped support for intercepting bind() as when using bind() with unix sockets
  and a pathname sockaddr, bind() will create an inode in the filesystem that
  needs to be cleaned up. If the address is rewritten, users might try to clean
  up the wrong file and leak the actual socket file in the filesystem.
* Changed bpf_sock_addr_set_unix_addr() to use BTF_KFUNC_HOOK_CGROUP_SKB instead
  of BTF_KFUNC_HOOK_COMMON.
* Removed unix socket related changes from BPF_CGROUP_PRE_CONNECT_ENABLED() as
  unix sockets do not support pre-connect.
* Added tests for getpeernameun and getsocknameun hooks.
* We now disallow an empty sockaddr in bpf_sock_addr_set_unix_addr() similar to
  unix_validate_addr().
* Removed unnecessary cgroup_bpf_enabled() checks
* Removed unnecessary error checks

Changes since v3:

* Renamed bpf_sock_addr_set_addr() to bpf_sock_addr_set_unix_addr() and
  made it only operate on AF_UNIX sockaddrs. This is because for the other
  families, users usually want to configure more than just the address so
  a generic interface will not fit the bill here. e.g. for AF_INET and AF_INET6,
  users would generally also want to be able to configure the port which the
  current interface doesn't support. So we expose an AF_UNIX specific function
  instead.
* Made the tests in the new sock addr tests more generic (similar to test_sock_addr.c),
  this should make it easier to migrate the other sock addr tests in the future.
* Removed the new kfunc hook and attached to BTF_KFUNC_HOOK_COMMON instead
* Set uaddrlen to 0 when the family is AF_UNSPEC
* Pass in the addrlen to the hook from IPv6 code
* Fixed mount directory mkdir() to ignore EEXIST

Changes since v2:

* Configuring the sock addr is now done via a new kfunc bpf_sock_addr_set()
* The addrlen is exposed as u32 in bpf_sock_addr_kern
* Selftests are updated to use the new kfunc
* Selftests are now added as a new sock_addr test in prog_tests/
* Added BTF_KFUNC_HOOK_SOCK_ADDR for BPF_PROG_TYPE_CGROUP_SOCK_ADDR
* __cgroup_bpf_run_filter_sock_addr() now returns the modified addrlen

Changes since v1:

* Split into multiple patches instead of one single patch
* Added unix support for all socket address hooks instead of only connect()
* Switched approach to expose the socket address length to the bpf hook
instead of recalculating the socket address length in kernelspace to
properly support abstract unix socket addresses
* Modified socket address hook tests to calculate the socket address length
once and pass it around everywhere instead of recalculating the actual unix
socket address length on demand.
* Added some missing section name tests for getpeername()/getsockname()

This patch series extends the cgroup sockaddr hooks to include support for unix
sockets. To add support for unix sockets, struct bpf_sock_addr_kern is extended
to expose the socket address length to the bpf program. Along with that, a new
kfunc bpf_sock_addr_set_sun_path() is added to safely allow modifying an
AF_UNIX sockaddr from bpf programs.

I intend to use these new hooks in systemd to reimplement the LogNamespace=
feature, which allows running multiple instances of systemd-journald to
process the logs of different services. systemd-journald also processes
syslog messages, so currently, using log namespaces means all services running
in the same log namespace have to live in the same private mount namespace
so that systemd can mount the journal namespace's associated syslog socket
over /dev/log to properly direct syslog messages from all services running
in that log namespace to the correct systemd-journald instance. We want to
relax this requirement so that processes running in disjoint mount namespaces
can still run in the same log namespace. To achieve this, we can use these
new hooks to rewrite the socket address of any connect(), sendto(), ...
syscalls to /dev/log to the socket address of the journal namespace's syslog
socket instead, which will transparently do the redirection without requiring
use of a mount namespace and mounting over /dev/log.

Aside from the above usecase, these hooks can more generally be used to
transparently redirect unix sockets to different addresses as required by
services.

Daan De Meyer (9):
  selftests/bpf: Add missing section name tests for
    getpeername/getsockname
  bpf: Propagate modified uaddrlen from cgroup sockaddr programs
  bpf: Add bpf_sock_addr_set_sun_path() to allow writing unix sockaddr
    from bpf
  bpf: Implement cgroup sockaddr hooks for unix sockets
  libbpf: Add support for cgroup unix socket address hooks
  bpftool: Add support for cgroup unix socket address hooks
  documentation/bpf: Document cgroup unix socket address hooks
  selftests/bpf: Make sure mount directory exists
  selftests/bpf: Add tests for cgroup unix socket address hooks

 Documentation/bpf/libbpf/program_types.rst    |  10 +
 include/linux/bpf-cgroup-defs.h               |   5 +
 include/linux/bpf-cgroup.h                    |  90 +--
 include/linux/filter.h                        |   1 +
 include/uapi/linux/bpf.h                      |  13 +-
 kernel/bpf/btf.c                              |   1 +
 kernel/bpf/cgroup.c                           |  29 +-
 kernel/bpf/syscall.c                          |  15 +
 kernel/bpf/verifier.c                         |   5 +-
 net/core/filter.c                             |  54 +-
 net/ipv4/af_inet.c                            |   7 +-
 net/ipv4/ping.c                               |   2 +-
 net/ipv4/tcp_ipv4.c                           |   2 +-
 net/ipv4/udp.c                                |   9 +-
 net/ipv6/af_inet6.c                           |   9 +-
 net/ipv6/ping.c                               |   2 +-
 net/ipv6/tcp_ipv6.c                           |   2 +-
 net/ipv6/udp.c                                |   6 +-
 net/unix/af_unix.c                            |  36 +-
 .../bpftool/Documentation/bpftool-cgroup.rst  |  16 +-
 .../bpftool/Documentation/bpftool-prog.rst    |   8 +-
 tools/bpf/bpftool/bash-completion/bpftool     |  14 +-
 tools/bpf/bpftool/cgroup.c                    |  16 +-
 tools/bpf/bpftool/prog.c                      |   7 +-
 tools/include/uapi/linux/bpf.h                |  13 +-
 tools/lib/bpf/libbpf.c                        |  10 +
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  14 +
 tools/testing/selftests/bpf/cgroup_helpers.c  |   5 +
 tools/testing/selftests/bpf/network_helpers.c |  34 +
 tools/testing/selftests/bpf/network_helpers.h |   1 +
 .../selftests/bpf/prog_tests/section_names.c  |  45 ++
 .../selftests/bpf/prog_tests/sock_addr.c      | 612 ++++++++++++++++++
 .../selftests/bpf/progs/connect_unix_prog.c   |  40 ++
 .../bpf/progs/getpeername_unix_prog.c         |  39 ++
 .../bpf/progs/getsockname_unix_prog.c         |  39 ++
 .../selftests/bpf/progs/recvmsg_unix_prog.c   |  39 ++
 .../selftests/bpf/progs/sendmsg_unix_prog.c   |  40 ++
 37 files changed, 1197 insertions(+), 93 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_addr.c
 create mode 100644 tools/testing/selftests/bpf/progs/connect_unix_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/getpeername_unix_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/getsockname_unix_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/recvmsg_unix_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/sendmsg_unix_prog.c

--
2.41.0


