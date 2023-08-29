Return-Path: <bpf+bounces-8897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9680F78C235
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 12:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F4CE280FC6
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 10:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A1914F88;
	Tue, 29 Aug 2023 10:19:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2AB14F82
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 10:19:22 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826991B7
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 03:19:10 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-5007c8308c3so6659124e87.0
        for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 03:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693304348; x=1693909148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PYlYdazOW6zFrrOM6laFFV04myGVExWFq04hxa5ViCQ=;
        b=RZONnd7fIk1aPEfijI5NL3u2pJ//YPzhowlswWQ0Rb6/o1kUA705zTTNoF71ZiXYsE
         niZDnh0AkDobdVj6V0lTf/f+dL9PSVWdAin/Ya9nz3dH+mgBFkCnoNP/cV0fTJ+zWh9Z
         hqF4LziP2AZBKL1rAGAdzsqzj1KJe/Isd3n0IrhlPquS+16saHZONwvDinBhDNMO27fn
         RgNpP2JXyjEpqOY5hKqI/ChHCNEzJ/llRsXVfLZ56JLpZSDnqZnpUsdQPNGS0N6YcymL
         j8IHJp+bIRocs+4HQpg89yy/HVBDarPWHpCND+VRWL0L6O/THXdv7cjpNQPTPXuJcivY
         PoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693304348; x=1693909148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PYlYdazOW6zFrrOM6laFFV04myGVExWFq04hxa5ViCQ=;
        b=Kq2Hl01Vk7ZbNSpOh39C2k5WOwmTxh4vYp9GH0N6OZVARDNKxxWekCnLMtnnCG9v01
         qzkP3R5BWIQrBrCxmHwaEx2KtuqwCj0z78sFmHputX3G3Kc9TGl7iAuhAm+VR8xLXna2
         pckNjs0U6bYr2jDxlVpJXQeiVO6WLZwmJP1GFNYAXDqdz2lVWIDpZ7F+kK+BtzOfBeGF
         jxB4ofDtN6+e2uJi/0FmPkzcATsIbBXc9/QgerLXrWllnNNZI/KMcy4XK5d+2UkImKcO
         cqWnwueoSHEQ+soPF3TrCNbnaqowCadujFB/dzvrkxytv3o+/n2fk2xzWMvw2mzhaZoP
         cm6g==
X-Gm-Message-State: AOJu0YyNdQsEvAGdfM9kl4vaCHGbCAigzrtK/66oHfXv6ABg5LPpJtI7
	VrC297fZGUBypnjBB9Eio5s4p0Gg6u95ywpKxkc=
X-Google-Smtp-Source: AGHT+IH+itmoWP7fXcXB+VBe7+JEKDTDogtukjAkuNsr4GADjVkuwpKgcY3COXn0umsselsB1KuDAg==
X-Received: by 2002:a05:6512:39d3:b0:500:b301:d8db with SMTP id k19-20020a05651239d300b00500b301d8dbmr6176679lfu.28.1693304347900;
        Tue, 29 Aug 2023 03:19:07 -0700 (PDT)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com (2001-1c05-3310-3500-67a4-023c-67c4-b186.cable.dynamic.v6.ziggo.nl. [2001:1c05:3310:3500:67a4:23c:67c4:b186])
        by smtp.googlemail.com with ESMTPSA id f15-20020a50ee8f000000b0051e2670d599sm5545606edr.4.2023.08.29.03.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 03:19:07 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 0/9] Add cgroup sockaddr hooks for unix sockets
Date: Tue, 29 Aug 2023 12:18:24 +0200
Message-ID: <20230829101838.851350-1-daan.j.demeyer@gmail.com>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
  bpf: Add bpf_sock_addr_set() to allow writing sockaddr len from bpf
  bpf: Implement cgroup sockaddr hooks for unix sockets
  libbpf: Add support for cgroup unix socket address hooks
  bpftool: Add support for cgroup unix socket address hooks
  documentation/bpf: Document cgroup unix socket address hooks
  selftests/bpf: Make sure mount directory exists
  selftests/bpf: Add tests for cgroup unix socket address hooks

 Documentation/bpf/libbpf/program_types.rst    |  12 +
 include/linux/bpf-cgroup-defs.h               |   6 +
 include/linux/bpf-cgroup.h                    | 102 +++---
 include/linux/filter.h                        |   1 +
 include/uapi/linux/bpf.h                      |  14 +-
 kernel/bpf/btf.c                              |   3 +
 kernel/bpf/cgroup.c                           |  33 +-
 kernel/bpf/syscall.c                          |  18 +
 kernel/bpf/verifier.c                         |   7 +-
 net/core/filter.c                             |  68 +++-
 net/ipv4/af_inet.c                            |   6 +-
 net/ipv4/ping.c                               |   2 +-
 net/ipv4/tcp_ipv4.c                           |   2 +-
 net/ipv4/udp.c                                |   8 +-
 net/ipv6/af_inet6.c                           |   6 +-
 net/ipv6/ping.c                               |   2 +-
 net/ipv6/tcp_ipv6.c                           |   2 +-
 net/ipv6/udp.c                                |   6 +-
 net/unix/af_unix.c                            |  90 ++++-
 .../bpftool/Documentation/bpftool-cgroup.rst  |  21 +-
 .../bpftool/Documentation/bpftool-prog.rst    |  10 +-
 tools/bpf/bpftool/bash-completion/bpftool     |  14 +-
 tools/bpf/bpftool/cgroup.c                    |  17 +-
 tools/bpf/bpftool/prog.c                      |   9 +-
 tools/include/uapi/linux/bpf.h                |  14 +-
 tools/lib/bpf/libbpf.c                        |  12 +
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  13 +
 tools/testing/selftests/bpf/cgroup_helpers.c  |   5 +
 tools/testing/selftests/bpf/network_helpers.c |  34 ++
 tools/testing/selftests/bpf/network_helpers.h |   1 +
 .../selftests/bpf/prog_tests/section_names.c  |  50 +++
 .../selftests/bpf/prog_tests/sock_addr.c      | 313 ++++++++++++++++++
 .../testing/selftests/bpf/progs/bindun_prog.c |  25 ++
 .../selftests/bpf/progs/connectun_prog.c      |  26 ++
 .../selftests/bpf/progs/recvmsgun_prog.c      |  25 ++
 .../selftests/bpf/progs/sendmsgun_prog.c      |  26 ++
 36 files changed, 899 insertions(+), 104 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_addr.c
 create mode 100644 tools/testing/selftests/bpf/progs/bindun_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/connectun_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/recvmsgun_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/sendmsgun_prog.c

--
2.41.0


