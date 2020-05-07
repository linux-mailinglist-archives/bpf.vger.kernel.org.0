Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3021C9A87
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 21:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgEGTMT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 May 2020 15:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726367AbgEGTMT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 7 May 2020 15:12:19 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C886AC05BD43
        for <bpf@vger.kernel.org>; Thu,  7 May 2020 12:12:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m138so8185640ybf.12
        for <bpf@vger.kernel.org>; Thu, 07 May 2020 12:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0tlYRaj7lhMdI4XPbVvuIVqtiibyp+RvfgyT5Ei0m54=;
        b=Vw31G/os3EqN9sA46Thl1G98VhGDYWF6KVQZVX7E4yS85T7yRjc7FaYxRUjH9+yA+x
         TbOAIL4/l/+QEt58Kx8bjwY3UCedcHjp7m8iSsLTbzSZg1hFWH4rcaAgZ3AJSmmosDi5
         dGv5W/ukXbkOnN6Pw6UQmN5SC/NYM8U+vAf6o9QvDEK1NS7R3qd0lJQNEiZTGBUJ92+4
         uqGkRFOlRJmAWbGCtUnqwZefWSFVjQmZt9BgrSfB3SdUjG0QxfdrGRO4IthRM0xXB3wD
         SlymMJXI4xHB+e+KrPo2xMZ7uYNwsIqlth+jTrr0XcS2GWTnqXwr4fM8i+ellofvS3FW
         7EWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0tlYRaj7lhMdI4XPbVvuIVqtiibyp+RvfgyT5Ei0m54=;
        b=h5Q1LbZtIP79KH30Pgjr2cz+70kzVHgYIXa131RU6UGa9kMZwitdROQD7bbyQEOTyu
         ecFEWcmo4d8kadR0fMVoXrc9McjT5TPK9ODjwNvQLWt2HKxME3ZflUCwFGk++9Nfw4N5
         emid6Elt5LIp4wQUqi1PPH2PkRDZALqyLSq9NFvu4Lqs37U193zA+r2IUFiJoNLZt+pu
         X1tUOWgYSqmIpyW1lkqggHs+elQvuuyhAfIM+RXB2Y1zRnGqR68lvgs12QyyYHouAyWn
         pMiUeyeyrtzx7tHvnWSLCmgLjkmjnly1hTcpn1SDvEqXd4BFhg0UvFI+hzzf4YzDgC70
         NDfA==
X-Gm-Message-State: AGi0PuZGoV3BW/jdXDBcruDI1UYyGOXuL77N8PuwavvV4FutMXsQkEDQ
        qCNX60qnxI4P/EOogPnAnD+D3GI=
X-Google-Smtp-Source: APiQypIqElBrfKXCSCUGpPx8+SvuqinA/UFmFSWkbh7mO4JDQlxhEHlRwLsoT7s4q3hCURR1q+aOCko=
X-Received: by 2002:a25:d7c5:: with SMTP id o188mr25102645ybg.241.1588878736973;
 Thu, 07 May 2020 12:12:16 -0700 (PDT)
Date:   Thu,  7 May 2020 12:12:11 -0700
Message-Id: <20200507191215.248860-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH bpf-next v4 0/4] bpf: allow any port in bpf_bind helper
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Andrey Ignatov <rdna@fb.com>, Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We want to have a tighter control on what ports we bind to in
the BPF_CGROUP_INET{4,6}_CONNECT hooks even if it means
connect() becomes slightly more expensive.

The series goes like this:
1. selftests: move existing helpers that make it easy to create
   listener threads into common test_progs part
2. selftests: move some common functionality into network_helpers
3. do small refactoring of __inet{,6}_bind() flags to make it easy
   to extend them with the additional flags
4. remove the restriction on port being zero in bpf_bind() helper;
   add new bind flag to prevent POST_BIND hook from being called

Acked-by: Andrey Ignatov <rdna@fb.com>
Cc: Martin KaFai Lau <kafai@fb.com>

Stanislav Fomichev (4):
  selftests/bpf: generalize helpers to control background listener
  selftests/bpf: move existing common networking parts into
    network_helpers
  net: refactor arguments of inet{,6}_bind
  bpf: allow any port in bpf_bind helper

 include/net/inet_common.h                     |   8 +-
 include/net/ipv6_stubs.h                      |   2 +-
 include/uapi/linux/bpf.h                      |   9 +-
 net/core/filter.c                             |  16 ++-
 net/ipv4/af_inet.c                            |  20 +--
 net/ipv6/af_inet6.c                           |  22 ++--
 tools/include/uapi/linux/bpf.h                |   9 +-
 tools/testing/selftests/bpf/Makefile          |   2 +-
 tools/testing/selftests/bpf/network_helpers.c | 103 ++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  39 ++++++
 .../bpf/prog_tests/connect_force_port.c       | 115 +++++++++++++++++
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  |   1 +
 .../selftests/bpf/prog_tests/flow_dissector.c |   1 +
 .../prog_tests/flow_dissector_load_bytes.c    |   1 +
 .../selftests/bpf/prog_tests/global_data.c    |   1 +
 .../selftests/bpf/prog_tests/kfree_skb.c      |   1 +
 .../selftests/bpf/prog_tests/l4lb_all.c       |   1 +
 .../selftests/bpf/prog_tests/map_lock.c       |  14 +++
 .../selftests/bpf/prog_tests/pkt_access.c     |   1 +
 .../selftests/bpf/prog_tests/pkt_md_access.c  |   1 +
 .../selftests/bpf/prog_tests/prog_run_xattr.c |   1 +
 .../bpf/prog_tests/queue_stack_map.c          |   1 +
 .../selftests/bpf/prog_tests/signal_pending.c |   1 +
 .../selftests/bpf/prog_tests/skb_ctx.c        |   1 +
 .../selftests/bpf/prog_tests/spinlock.c       |  14 +++
 .../selftests/bpf/prog_tests/tcp_rtt.c        | 116 +-----------------
 tools/testing/selftests/bpf/prog_tests/xdp.c  |   1 +
 .../bpf/prog_tests/xdp_adjust_tail.c          |   1 +
 .../selftests/bpf/prog_tests/xdp_bpf2bpf.c    |   1 +
 .../selftests/bpf/prog_tests/xdp_noinline.c   |   1 +
 .../selftests/bpf/progs/connect_force_port4.c |  28 +++++
 .../selftests/bpf/progs/connect_force_port6.c |  28 +++++
 tools/testing/selftests/bpf/test_progs.c      |  30 -----
 tools/testing/selftests/bpf/test_progs.h      |  23 ----
 34 files changed, 410 insertions(+), 204 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/network_helpers.c
 create mode 100644 tools/testing/selftests/bpf/network_helpers.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/connect_force_port.c
 create mode 100644 tools/testing/selftests/bpf/progs/connect_force_port4.c
 create mode 100644 tools/testing/selftests/bpf/progs/connect_force_port6.c

-- 
2.26.2.526.g744177e7f7-goog
