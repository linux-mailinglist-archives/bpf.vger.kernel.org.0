Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8622ED6D7
	for <lists+bpf@lfdr.de>; Thu,  7 Jan 2021 19:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbhAGSns (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jan 2021 13:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbhAGSns (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jan 2021 13:43:48 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECE8C0612F6
        for <bpf@vger.kernel.org>; Thu,  7 Jan 2021 10:43:08 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w17so11912584ybl.15
        for <bpf@vger.kernel.org>; Thu, 07 Jan 2021 10:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=OVBkrKJXNb2Lplfg4cURWT9WkIjZGCTXOe8RUPvRVcc=;
        b=idF7HKEH3HA6O86LQwsQBX6m/PvRHAtEUj1OXA3Mme99WOhkJ/SB5jpbr0NHOgQwSs
         gg8nKf7duVM0kqu+hcpwWeeWzc1clbhvywZWrB265UcpqfaEnJRXrjpsCd6h5QlixAJh
         lrANL8oTkfofAfzTKtPHOdBo/Za5m/b5hUAb74e5oDjOE0YMxiljnza7ymLb1NnRIuQL
         w40unWcB5v7PL2ml5uv2NFSy8oBbkaz+7Zf7ISjlE7QEkjpzghkPCtGfn6cMwJcBcNFN
         p940jkD7RXSkftlIyIhjRsn05WsieHlulMwQCW15/9U+MqS2Gyn9wqwAk+kcPnRgAaVo
         vHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=OVBkrKJXNb2Lplfg4cURWT9WkIjZGCTXOe8RUPvRVcc=;
        b=kaskJCGvvcw0ehCSOz8lFVTGfMXf2qCY/kh0B//p3Kd66+sC7pMkN6hsNGyOAm5saB
         baGm1Y2AD/ILUHbkoaeeiDKH9LRrswCyGlQOMENDQ4rUA0D8ZER/zwOEnBBuWj2kPgW1
         6xAkQGrB9MGdy7SWaspp5ZJFbq/2DZbduHDa1hG94GAtKvM0HiKnL9d/UWakiwD9noA+
         TRZaqE0KEJaVHXzVlrTSFuD4eqoba8yfODgQgCIBgtIOHvNCezwjD+U2K/DHIyzJ+TB/
         B0vzFYc+xBwouqNZUUvXd9A5qBjzxOrBCE7Xq1NJHDNP9v2KOK7wDwpPSGqw0SZisgVL
         gnFA==
X-Gm-Message-State: AOAM530yGvHyPixC4usVKil9XJb57VWJKvDjD3mI9//4jFwl7jOXV3AU
        G8Y72zRxwbg/i+dg+RMQ776uxo8=
X-Google-Smtp-Source: ABdhPJxF009SvsFAT2G4M1fxU3v7reIAgrO+BCO7MJBjPYsM0MjlGlcwyzkzy913hfKRC9twPJfn4Pc=
Sender: "sdf via sendgmr" <sdf@sdf2.svl.corp.google.com>
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:7220:84ff:fe09:7732])
 (user=sdf job=sendgmr) by 2002:a25:cb50:: with SMTP id b77mr270373ybg.76.1610044987238;
 Thu, 07 Jan 2021 10:43:07 -0800 (PST)
Date:   Thu,  7 Jan 2021 10:43:02 -0800
Message-Id: <20210107184305.444635-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH bpf-next v4 0/3] bpf: misc performance improvements for cgroup hooks
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

First patch tries to remove kzalloc/kfree from getsockopt for the
common cases.

Second patch switches cgroup_bpf_enabled to be per-attach to
to add only overhead for the cgroup attach types used on the system.

No visible user-side changes.

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

Stanislav Fomichev (3):
  bpf: try to avoid kzalloc in cgroup/{s,g}etsockopt
  bpf: split cgroup_bpf_enabled per attach type
  bpf: remove extra lock_sock for TCP_ZEROCOPY_RECEIVE

 include/linux/bpf-cgroup.h                    |  61 ++++++---
 include/linux/filter.h                        |   5 +
 include/net/sock.h                            |   2 +
 include/net/tcp.h                             |   1 +
 kernel/bpf/cgroup.c                           | 122 ++++++++++++++----
 net/ipv4/af_inet.c                            |   9 +-
 net/ipv4/tcp.c                                |  14 ++
 net/ipv4/tcp_ipv4.c                           |   1 +
 net/ipv4/udp.c                                |   7 +-
 net/ipv6/af_inet6.c                           |   9 +-
 net/ipv6/tcp_ipv6.c                           |   1 +
 net/ipv6/udp.c                                |   7 +-
 .../selftests/bpf/prog_tests/sockopt_sk.c     |  22 ++++
 .../testing/selftests/bpf/progs/sockopt_sk.c  |  15 +++
 14 files changed, 217 insertions(+), 59 deletions(-)

-- 
2.29.2.729.g45daf8777d-goog

