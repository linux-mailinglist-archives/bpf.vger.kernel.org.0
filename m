Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCFD6EAF1F
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 18:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjDUQbY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 12:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjDUQbX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 12:31:23 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70131444B
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 09:31:20 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-956ff2399b1so240151366b.3
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 09:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682094679; x=1684686679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PcxP/8Z++sdvHInrLVhxnGsApvqXVR8ubcoqa469K8I=;
        b=phfT2/gNF0GEiUZIMQfdekUaUh4P1M+zE9956PzVkJ03NsvHQkZB+kim9PdWIPfeWz
         MEhID6Oa3/Sop4JhTrf1v+IjtVStB1X9q+5iXHl4k+De5F7qB1lQ+marWPt4Lv9+D57c
         N3pYEy9/LXJu497xVa620AZW02d8alYP5a3N/IFiUpLh6wcNwVMFx+jDAF0Lkk1R6tDw
         piL6Q5l5NY1d8h/IpZvFE8+3NnOpouYPnJeyvSGLH+90oA9xBCXEUHvx20+HHFTF0afC
         22J0OiKqCykJNH72xLl+gsDQ6SxIqI8q047nL7nlpVZTKZgtTH4luKCQV98dFpuytvco
         lsTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682094679; x=1684686679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PcxP/8Z++sdvHInrLVhxnGsApvqXVR8ubcoqa469K8I=;
        b=FgZ/dVfS2ZLnw5THpHUmM9P49ZLPsrSSymZEsrnoL6Axc8tSR9GxhvIT/hnSf9wW+w
         MlBIAsKGgCiqyUFgywGFCnLQOAG4IHBqlVbEb8TVWd7eYdVCvnxucvvGMFftKCK3Vdy/
         5Ym8XoNSKQ21/9kbPR97KRlgBq33lpjPu7UpIpNOwPQSF21aKC4tvWPk6sLlpsqxutyE
         lOeYbDT8lp5KEXkrD8CCO+S25oyl/x7pZwE9Vjfq7+dh1x7tcCofaZFH4I4Xv7OHcuT0
         Va8KMwjYATDeN+1RbqR0WK6tERPJB8SQU0CznFTfmbj0eypOB0uTQjYmeLIIJcky+eIY
         N26w==
X-Gm-Message-State: AAQBX9eSlsh5qs7dRRPhY26tOgKFcMNt3fO89C/5dfx+WQUYQmn6vfNF
        z+COIgEvC2xF3FmvK4c4De1pUFUW0R59eQ==
X-Google-Smtp-Source: AKy350Zfsr6xhWf0oQc6WTAprX3yM9YcX6aWIAaUynmlC7erDSowywBwVNjt+XHMOWXShZoha3HKfA==
X-Received: by 2002:a17:907:c001:b0:94f:449e:75db with SMTP id ss1-20020a170907c00100b0094f449e75dbmr3473524ejc.52.1682094678715;
        Fri, 21 Apr 2023 09:31:18 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:864b:8201:e534:34f4:1c34:8de7])
        by smtp.googlemail.com with ESMTPSA id k9-20020a170906970900b009534211cc97sm2248578ejx.159.2023.04.21.09.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 09:31:18 -0700 (PDT)
From:   Daan De Meyer <daan.j.demeyer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Daan De Meyer <daan.j.demeyer@gmail.com>, martin.lau@linux.dev,
        kernel-team@meta.com
Subject: [PATCH bpf-next v3 00/10] Add cgroup sockaddr hooks for unix sockets
Date:   Fri, 21 Apr 2023 18:27:08 +0200
Message-Id: <20230421162718.440230-1-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Changes since v2:

* Configuring the sock addr is now done via a new kfunc bpf_sock_addr_set()
* The addrlen is exposed as u32 in bpf_sock_addr_kern
* Selftests are updated to use the new kfunc and access the sockaddr via
CORE
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

Daan De Meyer (10):
  selftests/bpf: Add missing section name tests for
    getpeername/getsockname
  selftests/bpf: Track sockaddr length in sock addr tests
  bpf: Allow read access to addr_len from cgroup sockaddr programs
  bpf: Add BTF_KFUNC_HOOK_SOCK_ADDR
  bpf: Add bpf_sock_addr_set() to allow writing sockaddr len from bpf
  bpf: Implement cgroup sockaddr hooks for unix sockets
  libbpf: Add support for cgroup unix socket address hooks
  bpftool: Add support for cgroup unix socket address hooks
  selftests/bpf: Add tests for cgroup unix socket address hooks
  documentation/bpf: Document cgroup unix socket address hooks

 Documentation/bpf/libbpf/program_types.rst    |  12 +
 include/linux/bpf-cgroup-defs.h               |   6 +
 include/linux/bpf-cgroup.h                    | 102 ++++---
 include/linux/filter.h                        |   1 +
 include/uapi/linux/bpf.h                      |  14 +-
 kernel/bpf/btf.c                              |   3 +
 kernel/bpf/cgroup.c                           |  27 +-
 kernel/bpf/syscall.c                          |  18 ++
 kernel/bpf/verifier.c                         |   7 +-
 net/core/filter.c                             |  69 ++++-
 net/ipv4/af_inet.c                            |   8 +-
 net/ipv4/ping.c                               |   8 +-
 net/ipv4/tcp_ipv4.c                           |   8 +-
 net/ipv4/udp.c                                |  17 +-
 net/ipv6/af_inet6.c                           |   8 +-
 net/ipv6/ping.c                               |   8 +-
 net/ipv6/tcp_ipv6.c                           |   8 +-
 net/ipv6/udp.c                                |  14 +-
 net/unix/af_unix.c                            | 102 ++++++-
 .../bpftool/Documentation/bpftool-cgroup.rst  |  21 +-
 tools/bpf/bpftool/cgroup.c                    |  17 +-
 tools/bpf/bpftool/common.c                    |   6 +
 tools/include/uapi/linux/bpf.h                |  14 +-
 tools/lib/bpf/libbpf.c                        |  12 +
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  13 +
 .../selftests/bpf/prog_tests/section_names.c  |  50 ++++
 .../testing/selftests/bpf/progs/bindun_prog.c |  59 ++++
 .../selftests/bpf/progs/connectun_prog.c      |  53 ++++
 .../selftests/bpf/progs/recvmsgun_prog.c      |  59 ++++
 .../selftests/bpf/progs/sendmsgun_prog.c      |  53 ++++
 tools/testing/selftests/bpf/test_sock_addr.c  | 263 ++++++++++++++----
 31 files changed, 917 insertions(+), 143 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bindun_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/connectun_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/recvmsgun_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/sendmsgun_prog.c

--
2.40.0

