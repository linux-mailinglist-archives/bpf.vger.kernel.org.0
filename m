Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8481E24D254
	for <lists+bpf@lfdr.de>; Fri, 21 Aug 2020 12:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgHUKaP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Aug 2020 06:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbgHUKaM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Aug 2020 06:30:12 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10675C061386
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 03:30:10 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k8so1317013wma.2
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 03:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jQYG0BGezwb75avWb46nKmCGvRRkSOGM09wxiKUleCo=;
        b=j2wwRETPAhvpz6uv19N2pdptpg0yx34DepixeVoQE2DzHdVDTYRFVafNWaVadPmos7
         K+Ys0ZAj5wexvoVeyPQbiUtnDk76tWKmvM9naXSRYUJ+dFgpUImh9r2TdDRP+y5+osLu
         +dtQRdurOvf5iWnC12WqwaIEbodXoy8AkfN6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jQYG0BGezwb75avWb46nKmCGvRRkSOGM09wxiKUleCo=;
        b=tC1dP4X77n8/EzGHURQzap5BA+MuZzGqk4UyDkcqPFY8H/b0aA/dGnIu8HY/BxtJot
         S7KWUZICXQE8HotnZGEl03V9eAWhGOCZDmiiT4ZxJvGbFTjgBpv+7O0cL9AEJva959Q0
         XGDcu0/RRIyVNB0j7Vywl/oI6zjD8HHtJtKh5r/+61x44rJRe6tp1X4X/dI/gNuf3S2b
         iEiQB4aw1MnOHy2kC5s85c3+oVGkNMED1j3Sz7hOlPbRD0ZuUPTdnohE08GRaymQWIko
         iJ256+97eKVj36ZQ8lQ4Rh6eF8ZrHd3NUyjpErMSYnQ8b9uD/gn2zTi3mgPt+gsuKKIa
         JE4g==
X-Gm-Message-State: AOAM53371U+6x/nRRGrJ8+n4Va2xjFp8TNhB94sl+GegqIuCGd8et1Fg
        2y2CAKjJbk9gQRC6LRmxRquGrw==
X-Google-Smtp-Source: ABdhPJzgtPMSqVfHwwbCddCrKyRemrs+dG8AEaFXstyLrBPgU0d8BUKMnEKk/bAeGmJN7JQbqY6U/A==
X-Received: by 2002:a1c:f60e:: with SMTP id w14mr2372122wmc.19.1598005805392;
        Fri, 21 Aug 2020 03:30:05 -0700 (PDT)
Received: from antares.lan (2.2.9.a.d.9.4.f.6.1.8.9.f.9.8.5.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:589f:9816:f49d:a922])
        by smtp.gmail.com with ESMTPSA id o2sm3296885wrj.21.2020.08.21.03.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 03:30:04 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     jakub@cloudflare.com, john.fastabend@gmail.com, yhs@fb.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 0/6] Allow updating sockmap / sockhash from BPF
Date:   Fri, 21 Aug 2020 11:29:42 +0100
Message-Id: <20200821102948.21918-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We're currently building a control plane for our BPF socket dispatch
work. As part of that, we have a need to create a copy of an existing
sockhash, to allow us to change the keys. I previously proposed allowing
privileged userspace to look up sockets, which doesn't work due to
security concerns (see [1]).

In follow up discussions during BPF office hours we identified bpf_iter
as a possible solution: instead of accessing sockets from user space
we can iterate the source sockhash, and insert the values into a new
map. Enabling this requires two pieces: the ability to iterate
sockmap and sockhash, as well as being able to call map_update_elem
from BPF.

This patch set implements the latter: it's now possible to update
sockmap from BPF context. As a next step, we can implement bpf_iter
for sockmap.

===

I've done some more fixups, and audited the safe contexts more
thoroughly. As a result I'm removing CGROUP_SKB, SK_MSG and SK_SKB
for now.

Changes in v3:
- Use CHECK as much as possible (Yonghong)
- Reject ARG_PTR_TO_MAP_VALUE_OR_NULL for sockmap (Yonghong)
- Remove CGROUP_SKB, SK_MSG, SK_SKB from safe contexts
- Test that the verifier rejects update from unsafe context

Changes in v2:
- Fix warning in patch #2 (Jakub K)
- Renamed override_map_arg_type (John)
- Only allow updating sockmap from known safe contexts (John)
- Use __s64 for sockmap updates from user space (Yonghong)
- Various small test fixes around test macros and such (Yonghong)

Thank your for your reviews!

1: https://lore.kernel.org/bpf/20200310174711.7490-1-lmb@cloudflare.com/

Lorenz Bauer (6):
  net: sk_msg: simplify sk_psock initialization
  bpf: sockmap: merge sockmap and sockhash update functions
  bpf: sockmap: call sock_map_update_elem directly
  bpf: override the meaning of ARG_PTR_TO_MAP_VALUE for sockmap and
    sockhash
  bpf: sockmap: allow update from BPF
  selftests: bpf: test sockmap update from BPF

 include/linux/bpf.h                           |   7 +
 include/linux/skmsg.h                         |  17 ---
 kernel/bpf/syscall.c                          |   5 +-
 kernel/bpf/verifier.c                         |  73 +++++++++-
 net/core/skmsg.c                              |  34 ++++-
 net/core/sock_map.c                           | 137 ++++++++----------
 net/ipv4/tcp_bpf.c                            |  13 +-
 net/ipv4/udp_bpf.c                            |   9 +-
 .../selftests/bpf/prog_tests/sockmap_basic.c  |  78 ++++++++++
 .../bpf/progs/test_sockmap_invalid_update.c   |  23 +++
 .../selftests/bpf/progs/test_sockmap_update.c |  48 ++++++
 11 files changed, 326 insertions(+), 118 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_invalid_update.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_update.c

-- 
2.25.1

