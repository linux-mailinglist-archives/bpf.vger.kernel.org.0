Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABD71C7D62
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 00:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbgEFWcN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 May 2020 18:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728888AbgEFWcM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 May 2020 18:32:12 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BDEC061A0F
        for <bpf@vger.kernel.org>; Wed,  6 May 2020 15:32:12 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i62so4459286ybc.11
        for <bpf@vger.kernel.org>; Wed, 06 May 2020 15:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=dAZbFcNNcrqaMDJSxZ8NNSIupNkALoG+H1k3vHmbQEg=;
        b=jxd18T3qpdHSoFOeOkP1+RW3DuJAP0ydFciP80dgv9rh5qMHswzIs93lbm4JCusun6
         5+W+lKxp8+3Q2HOSMGo0s8tJvg3rt6W3lsT3vHlpgOBpbXgVE4IGbfkjbWVjdHCHw73c
         7Zmy6kJYjv2TAcVs2lYrSHzHymKWqmccmP5K/06JrwxqrFuhKeDNq8e4UJ+/5sOnEACJ
         H1fK4URpbhccXgsH0FCcIGLeHZYbfwxDDKk4FkuFOIywkMhRu2x/OaR8U5o4fZfD9rUq
         ODuCjPS2LUBDrhzjFVUKxOOVWeD4yo/k/X6NhczxCFRaXM+YIC6zboiwYexsDvenBbT7
         aK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=dAZbFcNNcrqaMDJSxZ8NNSIupNkALoG+H1k3vHmbQEg=;
        b=e+qn1el7tavTbbhUh1KUC41Rrqr6xqI6VpZiY4u0FHX13d6hH01hd/+SFbmzW6KZEC
         kpqXdwV6XAV9XlydyGXsE8CkJH3xKLoa5GtHU+Z876fxcwkWp8llvl4uzMahnTlz++sd
         rXGvVYvap76MhxZ5gt0PH4CIfgUZ3IOjartlMjp/vNNV1H9rhRsXle/D3gOueJZNbKN3
         peo92PFiFaFT5PCIZXeXHMYDUDhyMu/Pfs80a6tuVeL9Gnk7kQ/HY5d9RMAHmpd3fVLH
         7M6vC2tc56gPxGSjnoYX0g0I+B4XRfmJckcc90d67sS4nuPM9lBy14E4oRxZfkHTaWCJ
         zReA==
X-Gm-Message-State: AGi0PuZxIVt2z+pYGD9WFVbhW1uxv0xU9EDWklry+bn4cmiVxAzIXGo5
        RgYfm/6YLJAjgOssR5P0OLWyiuQ=
X-Google-Smtp-Source: APiQypJztU2wIiQaI47vNdo6RECihXFhl/qizJP8bT8DXuaE45Aqq3RB+Fzgz+1PlQAO4upgu8iZ0mM=
X-Received: by 2002:a5b:443:: with SMTP id s3mr17123818ybp.14.1588804331609;
 Wed, 06 May 2020 15:32:11 -0700 (PDT)
Date:   Wed,  6 May 2020 15:32:05 -0700
Message-Id: <20200506223210.93595-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH bpf-next v3 0/5] bpf: allow any port in bpf_bind helper
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
2. selftests: make sure the helpers above don't get stuck forever
   in case the tests fails
3. selftests: move some common functionality into network_helpers
4. do small refactoring of __inet{,6}_bind() flags to make it easy
   to extend them with the additional flags
5. remove the restriction on port being zero in bpf_bind() helper;
   add new bind flag to prevent POST_BIND hook from being called

Acked-by: Andrey Ignatov <rdna@fb.com>
Cc: Martin KaFai Lau <kafai@fb.com>

Stanislav Fomichev (5):
  selftests/bpf: generalize helpers to control background listener
  selftests/bpf: adopt accept_timeout from sockmap_listen
  selftests/bpf: move existing common networking parts into
    network_helpers
  net: refactor arguments of inet{,6}_bind
  bpf: allow any port in bpf_bind helper

 include/net/inet_common.h                     |   8 +-
 include/net/ipv6_stubs.h                      |   2 +-
 include/uapi/linux/bpf.h                      |   9 +-
 net/core/filter.c                             |  16 +-
 net/ipv4/af_inet.c                            |  20 +-
 net/ipv6/af_inet6.c                           |  22 +-
 tools/include/uapi/linux/bpf.h                |   9 +-
 tools/testing/selftests/bpf/Makefile          |   2 +-
 tools/testing/selftests/bpf/network_helpers.c | 208 ++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  45 ++++
 .../bpf/prog_tests/connect_force_port.c       | 115 ++++++++++
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  |   1 +
 .../selftests/bpf/prog_tests/flow_dissector.c |   1 +
 .../prog_tests/flow_dissector_load_bytes.c    |   1 +
 .../selftests/bpf/prog_tests/global_data.c    |   1 +
 .../selftests/bpf/prog_tests/kfree_skb.c      |   1 +
 .../selftests/bpf/prog_tests/l4lb_all.c       |   1 +
 .../selftests/bpf/prog_tests/map_lock.c       |  14 ++
 .../selftests/bpf/prog_tests/pkt_access.c     |   1 +
 .../selftests/bpf/prog_tests/pkt_md_access.c  |   1 +
 .../selftests/bpf/prog_tests/prog_run_xattr.c |   1 +
 .../bpf/prog_tests/queue_stack_map.c          |   1 +
 .../selftests/bpf/prog_tests/signal_pending.c |   1 +
 .../selftests/bpf/prog_tests/skb_ctx.c        |   1 +
 .../selftests/bpf/prog_tests/sockmap_listen.c |  35 +--
 .../selftests/bpf/prog_tests/spinlock.c       |  14 ++
 .../selftests/bpf/prog_tests/tcp_rtt.c        | 116 +---------
 tools/testing/selftests/bpf/prog_tests/xdp.c  |   1 +
 .../bpf/prog_tests/xdp_adjust_tail.c          |   1 +
 .../selftests/bpf/prog_tests/xdp_bpf2bpf.c    |   1 +
 .../selftests/bpf/prog_tests/xdp_noinline.c   |   1 +
 .../selftests/bpf/progs/connect_force_port4.c |  28 +++
 .../selftests/bpf/progs/connect_force_port6.c |  28 +++
 tools/testing/selftests/bpf/test_progs.c      |  30 ---
 tools/testing/selftests/bpf/test_progs.h      |  23 --
 35 files changed, 522 insertions(+), 238 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/network_helpers.c
 create mode 100644 tools/testing/selftests/bpf/network_helpers.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/connect_force_port.c
 create mode 100644 tools/testing/selftests/bpf/progs/connect_force_port4.c
 create mode 100644 tools/testing/selftests/bpf/progs/connect_force_port6.c

-- 
2.26.2.526.g744177e7f7-goog
