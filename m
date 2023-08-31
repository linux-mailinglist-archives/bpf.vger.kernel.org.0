Return-Path: <bpf+bounces-9073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C7B78F067
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 17:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B1E61C20AC9
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 15:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D294F13AF1;
	Thu, 31 Aug 2023 15:35:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F638946C;
	Thu, 31 Aug 2023 15:35:16 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A24E4C;
	Thu, 31 Aug 2023 08:35:14 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99357737980so113197366b.2;
        Thu, 31 Aug 2023 08:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693496113; x=1694100913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i9H+znWhrzzrULMhPJQYbJWVDUdDGWv9uas+Tpt/lY4=;
        b=TS/k0o7hqqXVaej2g+aC+bOly03p2bNWGFwmDpCRFfCdUSa4Z1iIJzVEIJAgVx/ger
         E+gX345pDtFegleFag5pYE3TpRDaMEbxWzj/gB1DfraZh770KvXzvEuOFunJ5nYo0oWA
         3JgbklJOBzxUdcyWFirDNzpzFD0WO+tuCpI8V9HUwta6PCjXrHRiFgJgikfapv4Gv57z
         sTzmTm77pdgHHDVLXh/bDF7qQcyQ/3z93b1kGzS8IWCQcIH8tzX29+89tR4m1QUMej1u
         Q3pHbSvD4nw6jDB2GimDHfAXRDj3/DdENFpeJKwY1PBo2XGYI4/v6XWG8jqDoEAZgJkd
         fBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693496113; x=1694100913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i9H+znWhrzzrULMhPJQYbJWVDUdDGWv9uas+Tpt/lY4=;
        b=WlYCksoMYlDQIUtMJsCfV8RrH1Rw5oP9bYaISWByvBZ28+cVu2bUMA2psZfW63QGDm
         BxiigJmqHJvRLMmZo+4pYpkNeuVI6ylavtTr8/OPvP9V/8SkOHQ0dJuJvsn+Rwlpsy/g
         MUxu3KOzaaw0gQGLbLbi7serfJCC1ghQO7sUnpX+NAEF465k3GzhqJdou1myatRA0Itm
         ck3WS+xn4GYQNeFNZX4ioePv3cUuI0YL0UMyEH0NaugSQZTLp4JCNMb/UlnVhyLPswAz
         x54B4LKOCOlIIGt7X8KgyaIPBS7zGTtXDc3rU1V3gFwIVSnS9hDRm8Ghx+iwAM4x6whf
         YNcA==
X-Gm-Message-State: AOJu0YzcDDmzjUyqgoED2EPY1FD1v2Q136iRkb/PeWmGbZSppy1eYcqD
	Mf0SHb2d1FDvIjNqa2pfc7W/dP2z+F5BL3HBp2w=
X-Google-Smtp-Source: AGHT+IEYcw8Fc4Km64ihaGFEPTH5FibjpWTikNlHesklC8tUJi+w3O7TbL+P8V6dH2f87wlGRppJ6g==
X-Received: by 2002:a17:906:538a:b0:9a0:9558:82a3 with SMTP id g10-20020a170906538a00b009a0955882a3mr4320573ejo.58.1693496112583;
        Thu, 31 Aug 2023 08:35:12 -0700 (PDT)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com ([2620:10d:c092:400::5:a62f])
        by smtp.googlemail.com with ESMTPSA id ds11-20020a170907724b00b0099bcf9c2ec6sm868583ejc.75.2023.08.31.08.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 08:35:11 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v4 0/9] Add cgroup sockaddr hooks for unix sockets
Date: Thu, 31 Aug 2023 17:34:44 +0200
Message-ID: <20230831153455.1867110-1-daan.j.demeyer@gmail.com>
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

 Documentation/bpf/libbpf/program_types.rst    |  12 +
 include/linux/bpf-cgroup-defs.h               |   6 +
 include/linux/bpf-cgroup.h                    | 102 ++--
 include/linux/filter.h                        |   1 +
 include/uapi/linux/bpf.h                      |  14 +-
 kernel/bpf/btf.c                              |   1 +
 kernel/bpf/cgroup.c                           |  33 +-
 kernel/bpf/syscall.c                          |  18 +
 kernel/bpf/verifier.c                         |   7 +-
 net/core/filter.c                             |  50 +-
 net/ipv4/af_inet.c                            |   6 +-
 net/ipv4/ping.c                               |   2 +-
 net/ipv4/tcp_ipv4.c                           |   2 +-
 net/ipv4/udp.c                                |   8 +-
 net/ipv6/af_inet6.c                           |   9 +-
 net/ipv6/ping.c                               |   2 +-
 net/ipv6/tcp_ipv6.c                           |   2 +-
 net/ipv6/udp.c                                |   6 +-
 net/unix/af_unix.c                            |  90 +++-
 .../bpftool/Documentation/bpftool-cgroup.rst  |  23 +-
 .../bpftool/Documentation/bpftool-prog.rst    |  10 +-
 tools/bpf/bpftool/bash-completion/bpftool     |  14 +-
 tools/bpf/bpftool/cgroup.c                    |  17 +-
 tools/bpf/bpftool/prog.c                      |   9 +-
 tools/include/uapi/linux/bpf.h                |  14 +-
 tools/lib/bpf/libbpf.c                        |  12 +
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  14 +
 tools/testing/selftests/bpf/cgroup_helpers.c  |   5 +
 tools/testing/selftests/bpf/network_helpers.c |  34 ++
 tools/testing/selftests/bpf/network_helpers.h |   1 +
 .../selftests/bpf/prog_tests/section_names.c  |  50 ++
 .../selftests/bpf/prog_tests/sock_addr.c      | 461 ++++++++++++++++++
 .../testing/selftests/bpf/progs/bindun_prog.c |  39 ++
 .../selftests/bpf/progs/connectun_prog.c      |  40 ++
 .../selftests/bpf/progs/recvmsgun_prog.c      |  39 ++
 .../selftests/bpf/progs/sendmsgun_prog.c      |  40 ++
 36 files changed, 1087 insertions(+), 106 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_addr.c
 create mode 100644 tools/testing/selftests/bpf/progs/bindun_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/connectun_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/recvmsgun_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/sendmsgun_prog.c

--
2.41.0


