Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B74A64906A
	for <lists+bpf@lfdr.de>; Sat, 10 Dec 2022 20:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiLJTg3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Dec 2022 14:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLJTg2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Dec 2022 14:36:28 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E44167CD
        for <bpf@vger.kernel.org>; Sat, 10 Dec 2022 11:36:27 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id w15so8280723wrl.9
        for <bpf@vger.kernel.org>; Sat, 10 Dec 2022 11:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QN4PDOgiRV8KzF83RzsT7kz9qNjj5y/YwF4yFxG/aqQ=;
        b=MXJ7B0eCUTWwfOVesz5BAKsElV5K/ZopPNoAwAOehf438ZFZJPYwLcBTyJDEVY1qYd
         TjbVWiybnAYtJoOcEuVh/qjjQWfFdQhW4NT2c7aJWuXdAtkfdzqryaDFdJifsVHTM/C+
         kPv+P1+KOYvHyj8HuFhLECoL+ickUaAqkW53OD6tOik8/JfvGHxp93uHj5w+jwmCCEUn
         FTzVDT2bVTQFPwl9t6I0HTDXge+E6ZSiC+k35vVY/SBi4jxuFlKLMZUiarYgvtk7VS5A
         2JD/tQXMExXucwioHKol0TOEYfIrA//qtxC1w5/haBVi+rC3P2GPEaCnMPl0F6Luf4lq
         Kr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QN4PDOgiRV8KzF83RzsT7kz9qNjj5y/YwF4yFxG/aqQ=;
        b=6k0g7NNH56obioKWOdHW//qgLWDJI8wRwIji4fVOjBPcX5nFJ3Su+ycOAD2pl0ERFu
         GdPH0YjkNE21cbjr6XZjWdiQXQKA+7kQ8eK7uhTTFySSFSCyacUdq89iri44mDifftil
         QOMxE4AozRPgqHb7ADhqQRcjHzwQh7Qh1DqjMSaHwJZfdrR0TZmX/ubEs7LNkNCuDseB
         lfYGFHrQMr6V1ubjjghqartv8vynwXPJBEuGZdGbXdk1LOP6ZRuEF0KCUfu2xYVCMAXS
         HluQxqpBqGtfqyBZMfm4Wc0fKAtJSoauwCeLSJYe+cMA8bcpvARBt5ijuSiX4T0+gyk7
         SUAg==
X-Gm-Message-State: ANoB5pntYSZYAdZiBMdhbbeM2xtpI6W6UtEg/aHYi+Tv4i67m5YG729h
        DU1m8LN5XId78gEXlnbzWzjeEqpUNoaxPw==
X-Google-Smtp-Source: AA0mqf4Iwaf8bZUQOjWOCLqIqqg0BTnKZEktQaImLJSgNVisneDNLzDhc/Y+RVaftou+Rgo0RPV6lA==
X-Received: by 2002:a05:6000:1e1d:b0:242:15d5:2c0b with SMTP id bj29-20020a0560001e1d00b0024215d52c0bmr6834560wrb.22.1670700985122;
        Sat, 10 Dec 2022 11:36:25 -0800 (PST)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com ([2620:10d:c092:400::5:366e])
        by smtp.googlemail.com with ESMTPSA id az18-20020adfe192000000b002423a5d7cb1sm4584676wrb.113.2022.12.10.11.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 11:36:24 -0800 (PST)
From:   Daan De Meyer <daan.j.demeyer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Daan De Meyer <daan.j.demeyer@gmail.com>, martin.lau@linux.dev,
        kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/9] Add cgroup sockaddr hooks for unix sockets
Date:   Sat, 10 Dec 2022 20:35:50 +0100
Message-Id: <20221210193559.371515-1-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

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
  bpf: Allow read access to addr_len from cgroup sockaddr programs
  bpf: Support access to sun_path from cgroup sockaddr programs
  selftests/bpf: Track sockaddr length in sock addr tests
  bpf: Implement cgroup sockaddr hooks for unix sockets
  libbpf: Add support for cgroup unix socket address hooks
  bpftool: Add support for cgroup unix socket address hooks
  selftests/bpf: Add tests for cgroup unix socket address hooks
  documentation/bpf: Document cgroup unix socket address hooks

 Documentation/bpf/libbpf/program_types.rst    |  12 +
 include/linux/bpf-cgroup-defs.h               |   6 +
 include/linux/bpf-cgroup.h                    | 153 +++++-----
 include/linux/filter.h                        |   1 +
 include/uapi/linux/bpf.h                      |  16 +-
 kernel/bpf/cgroup.c                           |  14 +-
 kernel/bpf/syscall.c                          |  18 ++
 kernel/bpf/verifier.c                         |   7 +-
 net/core/filter.c                             | 109 +++++++-
 net/ipv4/af_inet.c                            |   9 +-
 net/ipv4/ping.c                               |   2 +-
 net/ipv4/tcp_ipv4.c                           |   2 +-
 net/ipv4/udp.c                                |  11 +-
 net/ipv6/af_inet6.c                           |   9 +-
 net/ipv6/ping.c                               |   2 +-
 net/ipv6/tcp_ipv6.c                           |   2 +-
 net/ipv6/udp.c                                |  12 +-
 net/unix/af_unix.c                            |  85 +++++-
 .../bpftool/Documentation/bpftool-cgroup.rst  |  21 +-
 tools/bpf/bpftool/cgroup.c                    |  17 +-
 tools/bpf/bpftool/common.c                    |   6 +
 tools/include/uapi/linux/bpf.h                |  16 +-
 tools/lib/bpf/libbpf.c                        |  12 +
 .../selftests/bpf/prog_tests/section_names.c  |  50 ++++
 .../testing/selftests/bpf/progs/bindun_prog.c |  36 +++
 .../selftests/bpf/progs/connectun_prog.c      |  28 ++
 .../selftests/bpf/progs/recvmsgun_prog.c      |  36 +++
 .../selftests/bpf/progs/sendmsgun_prog.c      |  28 ++
 tools/testing/selftests/bpf/test_sock_addr.c  | 263 ++++++++++++++----
 29 files changed, 815 insertions(+), 168 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bindun_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/connectun_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/recvmsgun_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/sendmsgun_prog.c

--
2.38.1

