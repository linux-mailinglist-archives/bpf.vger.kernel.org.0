Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85A443A802
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 01:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbhJYXPZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 19:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbhJYXPY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Oct 2021 19:15:24 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1524C061745
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 16:13:01 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id e10-20020ac8670a000000b002a78257482eso6615078qtp.10
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 16:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=lEYJKzq6ESVEzxhVXEZIlyzeNoTUoa0zTrQe8AacXA8=;
        b=j0IinI49yymkb6Df8qxv4XjGQG2q2s79jq+AjTOqP6kHBU73Z5CT5CuhbohjqxTRr2
         RShOyjI1uZyiun6bQPDgcJLdim6ofmoMnsQUxuZVYCyfoqodXQbyGB6UPxtwoG1QWOD+
         rs/AOUqBM6RweTZOSdghVfw8luPDH34xvp/qqOp0lSOXiqiMhhxxoCwunPaEM7Z1LMd6
         8aeham6Uo12GyK1sDb4qM4Z2Ej95MPfYiN/TX/26v/TPR+Ct1RLAxNftqwfHLWv7bcGD
         /VsfP6nqafU0EUIEuRcVx9YmG9Dw60FM75+Ekw0Gxm+Aq8Hk0dzgy2Re7AaoV1c9jiNZ
         rF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=lEYJKzq6ESVEzxhVXEZIlyzeNoTUoa0zTrQe8AacXA8=;
        b=7I3RBSmPFT64AI4p3UBBc3ZOc3xoNwOaDUOyjMVFIYzjaRHp4L7JavILzJ0vK/Ji96
         dKjSwj4/WUWQL7FA401MdA2m6ZaihP7ZZ0WD1Qxn7hgJb3BVrXn2c2uo0qEzPHxCAG4k
         cMKIToi3G0Pune0J2qgGZVZIp3MVicf0UUg3OpeC4HxnjtUowvYafDBZ5gcfL1maPk5t
         b2X5YFlQUrx1YQrrm2Dsuxttj2hMeuj4rqf758fXOJrCfKDW1rcDEnyFinqLv0rKFWkf
         divsXHkvvKGXM0JUOG3Mw9JiyEL4mmPfLh7XhywPK8AfDf+dGXhY04wAnq5t2H1VXDFO
         jayQ==
X-Gm-Message-State: AOAM533VEiJuKnkuHqYtf66LpFkTH+Z89Skop2CBNhgvxrhko2NkZzo/
        XbHKteX8aIbbrvDBR6jibhPliNMaPIg=
X-Google-Smtp-Source: ABdhPJzobI4pj9nt5mH1hoZYy2Cl5b1FTgQZNODv6SXQKmrVaTCRVwwk7Xl4jmznhaZIfYFVw+mQplAuKWo=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:b4ab:b78c:418f:ca5c])
 (user=haoluo job=sendgmr) by 2002:ac8:6158:: with SMTP id d24mr20798453qtm.115.1635203580478;
 Mon, 25 Oct 2021 16:13:00 -0700 (PDT)
Date:   Mon, 25 Oct 2021 16:12:53 -0700
Message-Id: <20211025231256.4030142-1-haoluo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH bpf-next v2 0/3] bpf: Prevent writing read-only memory
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently there are two ways to modify a kernel memory in bpf programs:
 1. declare a ksym of scalar type and directly modify its memory.
 2. Pass a RDONLY_BUF into a helper function which will override
 its arguments. For example, bpf_d_path, bpf_snprintf.

This patchset fixes these two problem. For the first, we introduce a
new reg type PTR_TO_RDONLY_MEM for the scalar typed ksym, which forbids
writing. Second, we introduce a new arg type ARG_PTR_TO_WRITABLE_MEM,
which is a proper subset of the ARG_PTR_TO_MEM and includes only those
reg types that are writable. For helper functions that may override its
argument, they should use ARG_PTR_TO_WRITABLE_MEM. For other helper
functions, they can continue using ARG_PTR_TO_MEM.

There is an alternative solution to the second problem, that is, an
ARG_PTR_TO_CONST_MEM, which represents the current ARG_PTR_TO_MEM, and
ARG_PTR_TO_MEM, which represents the ARG_PTR_TO_WRITABLE_MEM in this
patchset. But I find the naming here is too confusing. Most of the
helper functions should not override their arguments, therefore, using
ARG_PTR_TO_MEM sounds natural.

Hao Luo (3):
  bpf: Prevent write to ksym memory
  bpf: Introduce ARG_PTR_TO_WRITABLE_MEM
  bpf/selftests: Test PTR_TO_RDONLY_MEM

 include/linux/bpf.h                           | 15 +++++-
 include/uapi/linux/bpf.h                      |  4 +-
 kernel/bpf/cgroup.c                           |  2 +-
 kernel/bpf/helpers.c                          |  6 +--
 kernel/bpf/verifier.c                         | 54 ++++++++++++++++---
 kernel/trace/bpf_trace.c                      |  6 +--
 net/core/filter.c                             |  6 +--
 tools/include/uapi/linux/bpf.h                |  4 +-
 .../selftests/bpf/prog_tests/ksyms_btf.c      | 14 +++++
 .../bpf/progs/test_ksyms_btf_write_check.c    | 29 ++++++++++
 10 files changed, 116 insertions(+), 24 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_ksyms_btf_write_check.c

-- 
2.33.0.1079.g6e70778dc9-goog

