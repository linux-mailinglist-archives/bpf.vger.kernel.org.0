Return-Path: <bpf+bounces-11190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DD17B5314
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 14:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D8736283F4C
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 12:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CB318034;
	Mon,  2 Oct 2023 12:28:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8831775D;
	Mon,  2 Oct 2023 12:28:12 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A25A6;
	Mon,  2 Oct 2023 05:28:10 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32336a30d18so8249585f8f.2;
        Mon, 02 Oct 2023 05:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696249688; x=1696854488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ye/apGXBENrsAEYTohI+sNE+FpImcBjNsjNh5B9Eg9Y=;
        b=XmMVes+Aa8OmKCMoH4IQs4Qi1z6gRirWOHIFOqtG5gPM2ZyOsHD5NkbwFz4KVK8r/I
         OAsAio/GA95j7+y7DBV6BmyheHgbHk8IwQkfteZHsK18X0V+r4i8S6oQ+lXNrpaUSLZs
         nmloLKfonaWcBs9B+/ocPikpbqeCSoYXug8YzeW5drKd8hCqxmKqYovMsdp/vcj200+L
         jz8Os2LoCXyrb7ROWZNGN2IF/a7k+zEbkM8qdIValzue5uuwudmIjCz6fm6z0M3GLWtb
         q5MfxIqoVMAsyOhtPXqVou/rvVgSZEv/9jmIAbCOB62/KdbkI9/7c+HTwM3f3VdgmRoj
         E2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696249688; x=1696854488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ye/apGXBENrsAEYTohI+sNE+FpImcBjNsjNh5B9Eg9Y=;
        b=XI7A0xdXR8fL0J+ibR2NgvlGCpKKng69ZZHHu/PVCFtFvZhf9JuO+F+PbcQfFWoQm0
         Yv+SQbw093WZqQGAxfCmvbCFWpD8w+Xk2IBKq3nDrhQNq6IN7ypsEDDX3bZD+KdDzPp8
         AFa/a2sbDPpPa0P+c459+N8GvhlvtxkQ917goAL3xFL3SV0q/Ylx1lpeVdncMGrLX/EE
         9dSLFU3IcXR4V9VaYn9Vj3ws6ITBmTzh3egRT/7cqznaC0ju2tnZjnTSZTSy35fHGbYO
         tdpjZKsz4WJeBnY9h3CdnB7XltjxXV0Z5gtDf5sqKnQ6wwt9ukP56zdy3N/5bbZxP1/A
         rQRA==
X-Gm-Message-State: AOJu0Yx+gy2n320EIu1heXbpFWOISrl7Ky+TJG1Sr3+wHLnQ8Llti5eM
	Qq+9T0mNoOUYFArXWn55nZcexWXxwOMUczC7
X-Google-Smtp-Source: AGHT+IGM+vuoYmx7Vn9eYT+1+zgL/3jechDhmbysiD5Udf6VJMWkLHJtvo+8iy//RxoYP0iPVubUjQ==
X-Received: by 2002:adf:de11:0:b0:319:74b5:b67d with SMTP id b17-20020adfde11000000b0031974b5b67dmr9412689wrm.66.1696249687748;
        Mon, 02 Oct 2023 05:28:07 -0700 (PDT)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com (2001-1c05-3310-3500-aa0d-0bb2-d029-8797.cable.dynamic.v6.ziggo.nl. [2001:1c05:3310:3500:aa0d:bb2:d029:8797])
        by smtp.googlemail.com with ESMTPSA id v10-20020aa7dbca000000b005330b2d1904sm15263099edt.71.2023.10.02.05.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 05:28:07 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v7 0/9] Add cgroup sockaddr hooks for unix sockets
Date: Mon,  2 Oct 2023 14:27:46 +0200
Message-ID: <20231002122756.323591-1-daan.j.demeyer@gmail.com>
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
kfunc bpf_sock_addr_set_unix_addr() is added to safely allow modifying an
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
  bpf: Add bpf_sock_addr_set_unix_addr() to allow writing unix sockaddr
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
 kernel/bpf/cgroup.c                           |  31 +-
 kernel/bpf/syscall.c                          |  15 +
 kernel/bpf/verifier.c                         |   5 +-
 net/core/filter.c                             |  48 +-
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
 .../selftests/bpf/progs/connectun_prog.c      |  40 ++
 .../selftests/bpf/progs/getpeernameun_prog.c  |  39 ++
 .../selftests/bpf/progs/getsocknameun_prog.c  |  39 ++
 .../selftests/bpf/progs/recvmsgun_prog.c      |  39 ++
 .../selftests/bpf/progs/sendmsgun_prog.c      |  40 ++
 37 files changed, 1193 insertions(+), 93 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_addr.c
 create mode 100644 tools/testing/selftests/bpf/progs/connectun_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/getpeernameun_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/getsocknameun_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/recvmsgun_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/sendmsgun_prog.c

--
2.41.0


