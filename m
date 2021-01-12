Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10DBB2F3FDF
	for <lists+bpf@lfdr.de>; Wed, 13 Jan 2021 01:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438355AbhALWjb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 17:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405950AbhALWja (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jan 2021 17:39:30 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6E5C061575
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 14:38:50 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id i1so66340qtw.4
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 14:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=uYjWSybbEIV7mChgWoiIRHSFx0xsdV/9tDDWjrluTcY=;
        b=S2FjHxg/7pRA6tZlMnr7VTTJKZbHQEAm2wmx/vf/mRpeAvgM5zvXpM4dQZ8M1n7rsK
         m47Kna+h7TzfioNwibieocygIsxBDOcdh5H1Qx1b94Mf/W2s8fjidxgp3k94ZV42cqU9
         HWvhWR8RLaEyvvkazrFPFCVZDneHZrxBS+rH7x/3dD/4VlK5Qg3hB2fJdaXTeGdVgg/M
         phmqtVajhVGroh2FtnL5W0y4p7DMmapaLHUAAGZa53Xup5vk5wELGB1O7ubJyHjRXq+B
         8eGRo2OgiZ3TYQma1dqkDvKlpMTTx5gD7fDYCoYSuHBzKKD5YoFgNCIh7P/x9vkXCQlr
         CR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=uYjWSybbEIV7mChgWoiIRHSFx0xsdV/9tDDWjrluTcY=;
        b=im9c/3kFDLDiSAm/yk3kv81G7Tc/JGhVVdX3IFfCczEhkW3tcmRuZ2A/cSCtLe0dAy
         1J+xTIzy7hHgq0Py8vdOh3qvDk4ZLW/B3C4x7zsxRFEf1ibLong0MFxAqZi96RBdQnMB
         B6x9ePjHiHpqNUUVbQgJEZpzogBRUo+tA7Gg3j1rBB9eLzVb9ELQJTy447KcUN8wGWV+
         7b9vwquwfHzDv8zr8FhbxECTZPsri7sBZFqVSOriBpNoVn5Lzp7TY700VIjep3uG0zhB
         Uy96V7r2NOaVj2333iEBm2GGtO3H0TQjD5dofe/eFojUzznIrkYaOKlC01u9Ue4zcZF9
         FEGA==
X-Gm-Message-State: AOAM533hb4xVesuCLX20s+ZEty9DMtmez/1yiBvONrz2ajjb0BKE5Ce0
        MyzL/pc3VVfmSrq5YO1GXFMf80U=
X-Google-Smtp-Source: ABdhPJxMDmILQ7IuNuzGTIwp7O/Q8oDFC7l+o9E46QzTQbQ08wiOCSaC4Rh/plxE+lYuvFmfLKkyrO4=
Sender: "sdf via sendgmr" <sdf@sdf2.svl.corp.google.com>
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:7220:84ff:fe09:7732])
 (user=sdf job=sendgmr) by 2002:a0c:f2cd:: with SMTP id c13mr1575713qvm.11.1610491129461;
 Tue, 12 Jan 2021 14:38:49 -0800 (PST)
Date:   Tue, 12 Jan 2021 14:38:43 -0800
Message-Id: <20210112223847.1915615-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH bpf-next v7 0/4] bpf: misc performance improvements for cgroup hooks
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

First patch adds custom getsockopt for TCP_ZEROCOPY_RECEIVE
to remove kmalloc and lock_sock overhead from the dat path.

Second patch removes kzalloc/kfree from getsockopt for the common cases.

Third patch switches cgroup_bpf_enabled to be per-attach to
to add only overhead for the cgroup attach types used on the system.

No visible user-side changes.

v7:
- add comment about buffer contents for retval != 0 (Martin KaFai Lau)
- export tcp.h into tools/include/uapi (Martin KaFai Lau)
- note that v7 depends on the commit 4be34f3d0731 ("bpf: Don't leak
  memory in bpf getsockopt when optlen == 0") from bpf tree

v6:
- avoid indirect cost for new bpf_bypass_getsockopt (Eric Dumazet)

v5:
- reorder patches to reduce the churn (Martin KaFai Lau)

v4:
- update performance numbers
- bypass_bpf_getsockopt (Martin KaFai Lau)

v3:
- remove extra newline, add comment about sizeof tcp_zerocopy_receive
  (Martin KaFai Lau)
- add another patch to remove lock_sock overhead from
  TCP_ZEROCOPY_RECEIVE; technically, this makes patch #1 obsolete,
  but I'd still prefer to keep it to help with other socket
  options

v2:
- perf numbers for getsockopt kmalloc reduction (Song Liu)
- (sk) in BPF_CGROUP_PRE_CONNECT_ENABLED (Song Liu)
- 128 -> 64 buffer size, BUILD_BUG_ON (Martin KaFai Lau)

Stanislav Fomichev (4):
  bpf: remove extra lock_sock for TCP_ZEROCOPY_RECEIVE
  tools, bpf: add tcp.h to tools/uapi
  bpf: try to avoid kzalloc in cgroup/{s,g}etsockopt
  bpf: split cgroup_bpf_enabled per attach type

 include/linux/bpf-cgroup.h                    |  63 ++--
 include/linux/filter.h                        |   5 +
 include/linux/indirect_call_wrapper.h         |   6 +
 include/net/sock.h                            |   2 +
 include/net/tcp.h                             |   1 +
 kernel/bpf/cgroup.c                           | 112 +++++-
 net/ipv4/af_inet.c                            |   9 +-
 net/ipv4/tcp.c                                |  14 +
 net/ipv4/tcp_ipv4.c                           |   1 +
 net/ipv4/udp.c                                |   7 +-
 net/ipv6/af_inet6.c                           |   9 +-
 net/ipv6/tcp_ipv6.c                           |   1 +
 net/ipv6/udp.c                                |   7 +-
 net/socket.c                                  |   3 +
 tools/include/uapi/linux/tcp.h                | 357 ++++++++++++++++++
 .../selftests/bpf/prog_tests/sockopt_sk.c     |  22 ++
 .../testing/selftests/bpf/progs/sockopt_sk.c  |  15 +
 17 files changed, 582 insertions(+), 52 deletions(-)
 create mode 100644 tools/include/uapi/linux/tcp.h

-- 
2.30.0.284.gd98b1dd5eaa7-goog

