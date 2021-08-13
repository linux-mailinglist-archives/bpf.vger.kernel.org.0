Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9B53EBE85
	for <lists+bpf@lfdr.de>; Sat, 14 Aug 2021 01:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbhHMXGC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Aug 2021 19:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235429AbhHMXGA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Aug 2021 19:06:00 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714A8C061756
        for <bpf@vger.kernel.org>; Fri, 13 Aug 2021 16:05:33 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j21-20020a25d2150000b029057ac4b4e78fso10564458ybg.4
        for <bpf@vger.kernel.org>; Fri, 13 Aug 2021 16:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+n7ZuxPmiJdvWsEnFRmmB91xY49OsXBWFlcEOUch7FM=;
        b=aBvYtOt8yTAy9cj6AZGbk/m7nEX+hWAK9DUCB9A2epwpksoR1bxmOmimnJ7OzxPLQg
         QNKR+CS4kq7V0IICDmWXfNbaR3jHJPhjQa4KHYsq/vBAktVlXAUP21XHIEAeqAU6LszB
         pzcv8rNIkp1sm+I632kgknpCkzi9Cr2SHhKbz7fZOqdVc1DMXgvYuI6k3byEQgttQ4ey
         7g0sSWAY9PUVNQd6M3cpbl8tZRihEpXsSxhz0xHNslWBVk1k8PUQc182LZdl6K/g38Jk
         JrPQNp3dRC0BFcGy3ENP4BY20Mkea6IeILut/niQbWaifSUCATh4ZjAfD8pzTK81ReUy
         B17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+n7ZuxPmiJdvWsEnFRmmB91xY49OsXBWFlcEOUch7FM=;
        b=q3wmTI68qe4vNlRiDkwvlKPbjWqeuzxCR+HT3X8CV9FCt+uvDr4WIiDmyHfhyyi6p3
         0d4HrnTRGLflMq5m2f9L5NR/hdoZ8tD1EEj7zDjsKetjS/+GnvVvkdjMDI4orYRqpkNv
         MHPZZi5JzB+9sEyOoNqJb2pybgPqQzlUc4dMyjUiNpRlR+lAoQttTvv2C3syWtrbNwP7
         v7TRrBuNNgBMD1mcOsVyBOAE9b9hqh5NnSWwfxsC1pvhN7XPZZrV4WfXNxOTUGHmkzPk
         YA71MKLcK2CPnYVQ/R8vQXKshDHAQ+NVxmjazAbR5z9JlSatIWwStYxwhagC2lJiqvAQ
         KbeQ==
X-Gm-Message-State: AOAM532YFTZxhzJRlG2wJL95LFq9nFjJcICpeFc2f/pdA50J3iMl0Apz
        paXoRA9eJ0xbF2i8SbfoVo5A9lw=
X-Google-Smtp-Source: ABdhPJyFj8vQPgxyDVxLiGDpzw0gykNYAP+8WeaQf5kFV3ycjXCh0Pxw+xL2qbGEi2YcsdxXT5UnFZE=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:f73:a375:cbb9:779b])
 (user=sdf job=sendgmr) by 2002:a25:ab62:: with SMTP id u89mr6149118ybi.93.1628895932752;
 Fri, 13 Aug 2021 16:05:32 -0700 (PDT)
Date:   Fri, 13 Aug 2021 16:05:28 -0700
Message-Id: <20210813230530.333779-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH bpf-next v3 0/2] bpf: Allow bpf_get_netns_cookie in BPF_PROG_TYPE_CGROUP_SOCKOPT
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We'd like to be able to identify netns from setsockopt hooks
to be able to do the enforcement of some options only in the
"initial" netns (to give users the ability to create clear/isolated
sandboxes if needed without any enforcement by doing unshare(net)).

v3:
- remove extra 'ctx->skb == NULL' check (Martin KaFai Lau)
- rework test to make sure the helper is really called, not just
  verified

v2:
- add missing CONFIG_NET

Stanislav Fomichev (2):
  bpf: Allow bpf_get_netns_cookie in BPF_PROG_TYPE_CGROUP_SOCKOPT
  selftests/bpf: verify bpf_get_netns_cookie in
    BPF_PROG_TYPE_CGROUP_SOCKOPT

 kernel/bpf/cgroup.c                            | 18 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/sockopt_sk.c | 16 ++++++++++++++++
 2 files changed, 34 insertions(+)

-- 
2.33.0.rc1.237.g0d66db33f3-goog

