Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31ACCCBFD6
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2019 17:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390146AbfJDP4S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Oct 2019 11:56:18 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:53141 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390031AbfJDP4S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Oct 2019 11:56:18 -0400
Received: by mail-pf1-f202.google.com with SMTP id u12so5002414pfn.19
        for <bpf@vger.kernel.org>; Fri, 04 Oct 2019 08:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=VwzelZXvMKVqfPi7TNjhPVyjYSy8RxKwQ848A3WQgV0=;
        b=sk0A6RXv2sU6dca0VvDoRtkllW+X5AA7anM26yEMg/tVE8TvGYRl1LcSj63WGYfCZw
         jMgGIVgHhVucjUZT1jrNFrBCrnwvSHLl1qK97KGDRb9GZAtuNdoC58tGFSdkd04vSULB
         s7vkUFmHXrYDdRv/XTo9S8ZO12kY0oFyfYMpgy3I8vi01nYieJgxYoP9uzu4bF0V+nVS
         DAIoX6C9zCJo+3PhmtjoIEbVzWCXO5LmCYA6l6QUciIu4RHjTwEmc/IHck1EmVIcRbeC
         xq0mXSH9CtDpL2qjfNwkPvXsF7azWpq4NOUxYkeg1K5ELDcdr31G8RLExbM7u7AkSwYo
         Z/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=VwzelZXvMKVqfPi7TNjhPVyjYSy8RxKwQ848A3WQgV0=;
        b=TSGBPJ2CCS8qaxRHny3h1o6W4ewuyNufcpERBbR93JokjuHp7ouJMjcuqWhQJDzC+1
         GAr4g8K2XkHGUHsmTsH3KXS9CFfQfEnyvVjQJr1R+yFhJSZ/uDF63qO5k8yApaHhzHqQ
         2S641ha5Vmfp0Mzmei0HCozjt32ncZObk4S6QsnKCr/ZRecP2m3zSdUr3ovlJGxxj+GT
         HH1xPzZiFStTy8UO7xkC23pnL9qQdMUHeZC593/8ZSaY30Ba8PlPdBExsIjKwvLDa86G
         AWlMVzh76ztJrTz6zjkos/tYr05hFv91plb/WiYmbnNWFlPHVRULeek+g1h3oM+ujFah
         Hpkg==
X-Gm-Message-State: APjAAAV6uLLc4PYZP/te//UKq6dCvdPj+2yFVl+EfpsmQIbZObr3uM+w
        4xjI0C39qndcE4ZWPaeWHi+lV24=
X-Google-Smtp-Source: APXvYqwP/m71gJ8MvKfW7uO5jbHe0hoOta4hVVoqxwVtGq6aLgl6/8eGDN6nJIp/arirao/sTDkIrT0=
X-Received: by 2002:a63:4e44:: with SMTP id o4mr16127867pgl.103.1570204577251;
 Fri, 04 Oct 2019 08:56:17 -0700 (PDT)
Date:   Fri,  4 Oct 2019 08:56:13 -0700
Message-Id: <20191004155615.95469-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH bpf-next v2 0/2] bpf/flow_dissector: add mode to enforce
 global BPF flow dissector
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Petar Penkov <ppenkov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

While having a per-net-ns flow dissector programs is convenient for
testing, security-wise it's better to have only one vetted global
flow dissector implementation.

Let's have a convention that when BPF flow dissector is installed
in the root namespace, child namespaces can't override it.

The intended use-case is to attach global BPF flow dissector
early from the init scripts/systemd. Attaching global dissector
is prohibited if some non-root namespace already has flow dissector
attached. Also, attaching to non-root namespace is prohibited
when there is flow dissector attached to the root namespace.

v2:
* EPERM -> EEXIST (Song Liu)
* Make sure we don't have dissector attached to non-root namespaces
  when attaching the global one (Andrii Nakryiko)

Cc: Petar Penkov <ppenkov@google.com>

Stanislav Fomichev (2):
  bpf/flow_dissector: add mode to enforce global BPF flow dissector
  selftests/bpf: add test for BPF flow dissector in the root namespace

 Documentation/bpf/prog_flow_dissector.rst     |  3 ++
 net/core/flow_dissector.c                     | 42 ++++++++++++++--
 .../selftests/bpf/test_flow_dissector.sh      | 48 ++++++++++++++++---
 3 files changed, 83 insertions(+), 10 deletions(-)

-- 
2.23.0.581.g78d2f28ef7-goog
