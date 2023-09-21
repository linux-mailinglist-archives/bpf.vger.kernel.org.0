Return-Path: <bpf+bounces-10559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1830F7A9C3A
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 21:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4311AB220CD
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 19:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8DD3CD13;
	Thu, 21 Sep 2023 18:10:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C2F1A588;
	Thu, 21 Sep 2023 18:10:40 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47FFAE5D3;
	Thu, 21 Sep 2023 11:05:20 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4050bd2e33aso13545695e9.2;
        Thu, 21 Sep 2023 11:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695319519; x=1695924319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B71VH3ITp4Fy7KHXz/EpaCh3rxhhysXnD37J811sMRg=;
        b=WC0QxZklWFgIeiL7qt67aD/GaKE0NdnKRd+O08mNYcCwtv1g4kUmwFWMtTIbBX1w8Z
         pki1mlStny84efRYlw/Kz3mECG7qLMGgQ5q24jtdsIbuacKnNi9ZhrUy53eqVDYjuS+s
         HGWguvTGiesyKiOvFupOJHj7TsXvRENDzg7iPB0rFoDfRnQDWQW9Zw3kHePGwF/+ekL8
         ikkOlNkAWVQ80KKQQN8rpsdAn1jWqPlFTCh5wUv2FaYGnBPEjUFKf1vTFlecceLELgwC
         98p7BjqokNnkl/JRtOQc+ns/20xyv9LQhkrQA0XrEDURflY+iK1NYxNebf34RPOnBzBX
         poXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695319519; x=1695924319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B71VH3ITp4Fy7KHXz/EpaCh3rxhhysXnD37J811sMRg=;
        b=O2vr49KX/5Uaz4BXDISQudxKRWxtLMf77ZRLX4mAitTu0GbcbQgqKfPBbxaZKUNtZ/
         OjqC3SzFzN+x3TuCZtDlqmaZCJKETUNe/YZ7HUmSthxbu/wYeRLRek8NiQ39ULs//az4
         4ZwFxwleWnFTVAZFYv/lKEi2Tz2AFyV0ElU/Hgy8mG79dEG6jJm/Na93jSzOs6252PRG
         n8icRiijtv5Px8MFs6x9f2WEHTy+XfKMyfM5J0w5gSH5K9Th+hhkKcyqrjre/xwB2qBS
         mYEz94fy7kz3KzU4OREUE8JuACa30ZFnT57v/QpYIOA3PkHrUrCRl8aUmPClmCkruPD9
         w0uA==
X-Gm-Message-State: AOJu0Yw1YUAPwawQrCubFcT+N2UlVYNyYyRTZehLZ1WXl00VeJBS+BYu
	ICX6pzfiK5yQXG3Ced4jzCXK0RnFr/a/BznKdYs=
X-Google-Smtp-Source: AGHT+IFlOJE9EsIjpQZ4sKh3Vf0bwArcMij/fX0xxrX5JuhdXZRYOY6YV9DZmIviGx8SCY1vGBFP4Q==
X-Received: by 2002:a17:906:314b:b0:9a2:139:f45d with SMTP id e11-20020a170906314b00b009a20139f45dmr4819216eje.43.1695298168358;
        Thu, 21 Sep 2023 05:09:28 -0700 (PDT)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com ([2620:10d:c092:400::4:2a59])
        by smtp.googlemail.com with ESMTPSA id gx10-20020a170906f1ca00b0099cb349d570sm952258ejb.185.2023.09.21.05.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 05:09:27 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v5 0/9] Add cgroup sockaddr hooks for unix sockets
Date: Thu, 21 Sep 2023 14:09:02 +0200
Message-ID: <20230921120913.566702-1-daan.j.demeyer@gmail.com>
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

This patch series extends the cgroup sockaddr hooks to include support for
unix sockets. To add support for unix sockets, struct bpf_sock_addr is
extended to expose the unix socket path (sun_path) and the socket address
length to the bpf program. For unix sockets, the address length is writable,
for the other socket address hook types, the address length is only readable.

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
 include/linux/bpf-cgroup.h                    |  94 +--
 include/linux/filter.h                        |   1 +
 include/uapi/linux/bpf.h                      |  13 +-
 kernel/bpf/btf.c                              |   1 +
 kernel/bpf/cgroup.c                           |  29 +-
 kernel/bpf/syscall.c                          |  15 +
 kernel/bpf/verifier.c                         |   5 +-
 net/core/filter.c                             |  49 +-
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
 tools/testing/selftests/bpf/network_helpers.c |  34 ++
 tools/testing/selftests/bpf/network_helpers.h |   1 +
 .../selftests/bpf/prog_tests/section_names.c  |  45 ++
 .../selftests/bpf/prog_tests/sock_addr.c      | 570 ++++++++++++++++++
 .../selftests/bpf/progs/connectun_prog.c      |  40 ++
 .../selftests/bpf/progs/recvmsgun_prog.c      |  39 ++
 .../selftests/bpf/progs/sendmsgun_prog.c      |  40 ++
 35 files changed, 1076 insertions(+), 93 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_addr.c
 create mode 100644 tools/testing/selftests/bpf/progs/connectun_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/recvmsgun_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/sendmsgun_prog.c

--
2.41.0


