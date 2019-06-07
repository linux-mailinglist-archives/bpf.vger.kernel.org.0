Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8587D39201
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2019 18:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbfFGQ3X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Jun 2019 12:29:23 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:40453 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730334AbfFGQ3X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Jun 2019 12:29:23 -0400
Received: by mail-oi1-f201.google.com with SMTP id l63so752585oia.7
        for <bpf@vger.kernel.org>; Fri, 07 Jun 2019 09:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=MQg5YXmUW5YMs6Iwc/kDwaZ3qkNdiWI+Z1HjuF980Xg=;
        b=XEurjodSBdJtZHF8Fq0M3ocJPRYMb+87VLTZ7tyVdVctIdh6JQKdJtrPSQcy9G1yYM
         Y0AmQT4O+KP0C2vFbOybjOVlguxhQaoYV+AWgMGf1WmjozRoCBSISIfUamaLN3VvSrRg
         zOgH1ZVpu1Mw4fkIsqCm+dRY6A7qyKynKxaAn3KD5socPGRv3NAdNFwKQRC+Sz8gwcz1
         iOiAIG8Rv+817JEMJ0T+GPKm1CCAWMiY42VgCI3vg5m93vlXNh1Su61m59OOzH/GZVde
         9WEaVEhHnZxutBtXfHm2rX5LriwoRMekRsm54p5jSyxZH7j4V4w1dKXjFmlBRFhcsrrC
         t10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=MQg5YXmUW5YMs6Iwc/kDwaZ3qkNdiWI+Z1HjuF980Xg=;
        b=WLzFrAcSKCHWK4PdwWpiQVzaD1IHumtQ9ymc2ucKE5ACmtvCaAWelBCds62Mgbiey/
         J2jSygJzb7LKv/eliT9XhcMchXog09Ya5Awr/DFe1K1digu7X9HxL4fWmbUVM+/ffXp7
         jYPeCXVmPgjhlXGxpTZFZla6f2MEVLxblYBZn0ylVWkHbJWF06Q1OwfzcGQwHE8922cC
         g1rNVuMDepA/SBrZuVFsnEy5VYJK/DjydvsZ9GhhzFc2ddmCwOhwy8KBL+0dpdsmpRuy
         N248BeADboSxJqibfyB36Dbavk4fp5RHOPLBjmLntss1YxPK35TmeyJEwb3sK83ztCTT
         Qx/Q==
X-Gm-Message-State: APjAAAWOWOvW/7eayTmMKefd1YI8d02LuDN7FrxW1yWiHWVMie++ftRl
        A5BDFo5LhplbqPWMybXAIEJDtZE=
X-Google-Smtp-Source: APXvYqy/CoXgz7/qtToEIeQK3OXo7MuXAztZDQY5Lj8plqv2wdfxKWWF/mm1n6y/GmUz5zhfk7mSD58=
X-Received: by 2002:aca:ac4d:: with SMTP id v74mr4161795oie.66.1559924962094;
 Fri, 07 Jun 2019 09:29:22 -0700 (PDT)
Date:   Fri,  7 Jun 2019 09:29:12 -0700
Message-Id: <20190607162920.24546-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH bpf-next v3 0/8] bpf: getsockopt and setsockopt hooks
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series implements two new per-cgroup hooks: getsockopt and
setsockopt along with a new sockopt program type. The idea is pretty
similar to recently introduced cgroup sysctl hooks, but
implementation is simpler (no need to convert to/from strings).

What this can be applied to:
* move business logic of what tos/priority/etc can be set by
  containers (either pass or reject)
* handle existing options (or introduce new ones) differently by
  propagating some information in cgroup/socket local storage

Compared to a simple syscall/{g,s}etsockopt tracepoint, those
hooks are context aware. Meaning, they can access underlying socket
and use cgroup and socket local storage.

Stanislav Fomichev (8):
  bpf: implement getsockopt and setsockopt hooks
  bpf: sync bpf.h to tools/
  libbpf: support sockopt hooks
  selftests/bpf: test sockopt section name
  selftests/bpf: add sockopt test
  selftests/bpf: add sockopt test that exercises sk helpers
  bpf: add sockopt documentation
  bpftool: support cgroup sockopt

 Documentation/bpf/index.rst                   |   1 +
 Documentation/bpf/prog_cgroup_sockopt.rst     |  39 +
 include/linux/bpf-cgroup.h                    |  29 +
 include/linux/bpf.h                           |  46 ++
 include/linux/bpf_types.h                     |   1 +
 include/linux/filter.h                        |  13 +
 include/uapi/linux/bpf.h                      |  13 +
 kernel/bpf/cgroup.c                           | 264 ++++++
 kernel/bpf/core.c                             |   9 +
 kernel/bpf/syscall.c                          |  19 +
 kernel/bpf/verifier.c                         |  15 +
 net/core/filter.c                             |   4 +-
 net/socket.c                                  |  18 +
 .../bpftool/Documentation/bpftool-cgroup.rst  |   7 +-
 .../bpftool/Documentation/bpftool-prog.rst    |   2 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   8 +-
 tools/bpf/bpftool/cgroup.c                    |   5 +-
 tools/bpf/bpftool/main.h                      |   1 +
 tools/bpf/bpftool/prog.c                      |   3 +-
 tools/include/uapi/linux/bpf.h                |  14 +
 tools/lib/bpf/libbpf.c                        |   5 +
 tools/lib/bpf/libbpf_probes.c                 |   1 +
 tools/testing/selftests/bpf/.gitignore        |   2 +
 tools/testing/selftests/bpf/Makefile          |   4 +-
 .../testing/selftests/bpf/progs/sockopt_sk.c  |  77 ++
 .../selftests/bpf/test_section_names.c        |  10 +
 tools/testing/selftests/bpf/test_sockopt.c    | 773 ++++++++++++++++++
 tools/testing/selftests/bpf/test_sockopt_sk.c | 156 ++++
 28 files changed, 1528 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/bpf/prog_cgroup_sockopt.rst
 create mode 100644 tools/testing/selftests/bpf/progs/sockopt_sk.c
 create mode 100644 tools/testing/selftests/bpf/test_sockopt.c
 create mode 100644 tools/testing/selftests/bpf/test_sockopt_sk.c

-- 
2.22.0.rc1.311.g5d7573a151-goog
