Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCAB31FC53
	for <lists+bpf@lfdr.de>; Fri, 19 Feb 2021 16:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhBSPp3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Feb 2021 10:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhBSPo6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Feb 2021 10:44:58 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B2AC061574
        for <bpf@vger.kernel.org>; Fri, 19 Feb 2021 07:44:11 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m1so8053031wml.2
        for <bpf@vger.kernel.org>; Fri, 19 Feb 2021 07:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QOK5tqyMrf0VhdHsN9YlLPzIHk5OveJrMaj7nuQmlDo=;
        b=cHqU1Se98VIOO11MfBlGoKkP688LKTQ2SC6QpPPywm20J9MDx94MN1xTJPlsbJevyq
         0NspLe2WramN/uT1lneiTtAaY4ByxbwdncPIZG8s6nQe3MiI5y3Ho6xr+THn8kQwYb+n
         B6ygNfRRfAujMfdao6C4XDSOVzaipjgwWB+AE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QOK5tqyMrf0VhdHsN9YlLPzIHk5OveJrMaj7nuQmlDo=;
        b=LukvazQvDArkMJv8MUPuvIyYGrAB/BNwIsIEEP5e6uPmKWhUxE+eFCKWlzCz9sDdIq
         ivP/TFR7Qi2lNgmOFItNlCBdMwIICumqqFk/JudhtaowKYOqJkPyAUDbSntx0llpCs25
         Nis9C2K3issOOhahagBTbbWCBBdwNcpbGAeH694bnnNU69Qo2/+cbTWRv9Jq6qR56Prd
         c6OOacwrndDbVLXWqH6MZxSt0EwLEyulUZeihd1LPkyIETqnoMkrADA8xTfkHsjDrx7r
         Mauyj0ez4dItsSLyXrN1WtmDo3cgYMNtmDwZ1BeX1jT0oQQMukv7GITZFZoIGCLrX+Kg
         ZXJQ==
X-Gm-Message-State: AOAM532REyTftqhN74qEv7d4wWxBQh2pULiv8Gsqp5dqNWxUtCvjUhA7
        sj64vxxMLJWRbSfY8E0KTjweiHcJVYnkGQ==
X-Google-Smtp-Source: ABdhPJxPiH2ycMO1eWLrR4h+G9hDDgpIlT17PycRquSdaIl+ysZ2CYrZDE5wNEsUK9rXhdAD9kP+LQ==
X-Received: by 2002:a7b:cb58:: with SMTP id v24mr8779105wmj.182.1613749450047;
        Fri, 19 Feb 2021 07:44:10 -0800 (PST)
Received: from antares.lan (b.3.5.8.9.a.e.c.e.a.6.2.c.1.9.b.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:b91c:26ae:cea9:853b])
        by smtp.gmail.com with ESMTPSA id v204sm12321929wmg.38.2021.02.19.07.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 07:44:09 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     eric.dumazet@gmail.com, daniel@iogearbox.net, ast@kernel.org,
        andrii@kernel.org
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v3 0/4] Expose network namespace cookies to user space
Date:   Fri, 19 Feb 2021 15:43:26 +0000
Message-Id: <20210219154330.93615-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We're working on a user space control plane for the BPF sk_lookup
hook [1]. The hook attaches to a network namespace and allows
control over which socket receives a new connection / packet.

I'm proposing to add a new getsockopt and a netns ioctl to retrieve
netns cookies, which allows identifying which netns a socket belongs
to.

1: https://www.kernel.org/doc/html/latest/bpf/prog_sk_lookup.html

Changes in v3:
- Use sock_net unconditionally
- Fix unused variable in nsfs ioctl
- Be strict about getsockopt value size

Changes in v2:
- Rebase on top of Eric Dumazet's netns cookie simplification

Lorenz Bauer (4):
  net: add SO_NETNS_COOKIE socket option
  nsfs: add an ioctl to discover the network namespace cookie
  tools/testing: add test for NS_GET_COOKIE
  tools/testing: add a selftest for SO_NETNS_COOKIE

 arch/alpha/include/uapi/asm/socket.h          |  2 +
 arch/mips/include/uapi/asm/socket.h           |  2 +
 arch/parisc/include/uapi/asm/socket.h         |  2 +
 arch/sparc/include/uapi/asm/socket.h          |  2 +
 fs/nsfs.c                                     |  7 +++
 include/uapi/asm-generic/socket.h             |  2 +
 include/uapi/linux/nsfs.h                     |  2 +
 net/core/sock.c                               |  7 +++
 tools/testing/selftests/net/.gitignore        |  1 +
 tools/testing/selftests/net/Makefile          |  2 +-
 tools/testing/selftests/net/config            |  1 +
 tools/testing/selftests/net/so_netns_cookie.c | 61 +++++++++++++++++++
 tools/testing/selftests/nsfs/.gitignore       |  1 +
 tools/testing/selftests/nsfs/Makefile         |  2 +-
 tools/testing/selftests/nsfs/config           |  1 +
 tools/testing/selftests/nsfs/netns.c          | 57 +++++++++++++++++
 16 files changed, 150 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/net/so_netns_cookie.c
 create mode 100644 tools/testing/selftests/nsfs/netns.c

-- 
2.27.0

