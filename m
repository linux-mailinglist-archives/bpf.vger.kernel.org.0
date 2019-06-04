Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0942351EB
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2019 23:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfFDVf2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Jun 2019 17:35:28 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:35936 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFDVf2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Jun 2019 17:35:28 -0400
Received: by mail-pg1-f201.google.com with SMTP id u1so11481606pgh.3
        for <bpf@vger.kernel.org>; Tue, 04 Jun 2019 14:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=n1ROLXgyUAH0DM4cM+9Tg1airOeoSnrup9GE7LoaOmc=;
        b=L7Iaa0TQpD6s4t6BMvoVyJ0QrR8rGjZaf1NfNVbtxnTLAQk7VXCMgmR2kGJmWqWwGU
         osXZUIOh5e8ieX4wOtyNfHsmrOEAMHin57aZHXYwYfGVLxyP3QRFVK8ULTTKBEiHIYrm
         EgbUtTE+eWU3o2ZrBSAO/mj4O8wYPQ+/5hoYbAlsrC6WGDX0GYXwQhj9eA8FQSFiRccK
         b1Uulw82lnowQai5dFtz+KrnND1k5vyFVCpqOzWVsucwca82HJZfiuOZz7G/JoUrrLFN
         6Rp/Efoo76imuYI11zx6AXDKPDdDeixE1OckcQeUAD43zflImqEMlatEh6wqyWFPnXAY
         5d/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=n1ROLXgyUAH0DM4cM+9Tg1airOeoSnrup9GE7LoaOmc=;
        b=dUCMVJZ5MqYDfRacbYJace4qc9JYF4zvhiHkvdAA4wLEV9/0IiAQ1nrWnub2e6AKCV
         6DUTPWE4nHZxKjZMvLNVfmgYgVKlktKDu+d/ujrhbHyM0hfR1HelPQOPd4o53WjvSx9T
         T6WdzDv84o5pyQHFf6kuNh47jsIXJHwSKowz5FbQtnehwl/mol8ryQKzpzGBAAaBBWaa
         KEgIn2q4R/10VEO7ahbqWLyHSsOQusBhdYmZlalK4uOALlzOktNalmqsFr3BD9gDEdoR
         u+eshwI56XDHwrHzUvkpF+zFBdUAsuUONdj/TbdgOS3ShUGmfYsfB6cvgDPhMpEBlL+K
         y1qQ==
X-Gm-Message-State: APjAAAU8mkGFdUiGDrClwvu3V01rmj6kF687eZa5JEOUYbpevnhKAEhB
        +hG+TsQYTVb997oPeB03G9cx4vI=
X-Google-Smtp-Source: APXvYqwiij4ZCRvvXAPRewKOOuTfNt+os/SCY513vsT4Rvzyi7EQ9ZQaikk9+c1KWiJknQdxeUAw9Io=
X-Received: by 2002:a63:5152:: with SMTP id r18mr2819pgl.324.1559684127127;
 Tue, 04 Jun 2019 14:35:27 -0700 (PDT)
Date:   Tue,  4 Jun 2019 14:35:17 -0700
Message-Id: <20190604213524.76347-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH bpf-next 0/7] bpf: getsockopt and setsockopt hooks
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

Stanislav Fomichev (7):
  bpf: implement getsockopt and setsockopt hooks
  bpf: sync bpf.h to tools/
  libbpf: support sockopt hooks
  selftests/bpf: test sockopt section name
  selftests/bpf: add sockopt test
  bpf: add sockopt documentation
  bpftool: support cgroup sockopt

 Documentation/bpf/index.rst                   |   1 +
 Documentation/bpf/prog_cgroup_sockopt.rst     |  42 +
 include/linux/bpf-cgroup.h                    |  29 +
 include/linux/bpf.h                           |   2 +
 include/linux/bpf_types.h                     |   1 +
 include/linux/filter.h                        |  19 +
 include/uapi/linux/bpf.h                      |  17 +-
 kernel/bpf/cgroup.c                           | 288 +++++++
 kernel/bpf/syscall.c                          |  19 +
 kernel/bpf/verifier.c                         |  12 +
 net/core/filter.c                             |   4 +-
 net/socket.c                                  |  18 +
 .../bpftool/Documentation/bpftool-cgroup.rst  |   7 +-
 .../bpftool/Documentation/bpftool-prog.rst    |   2 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   8 +-
 tools/bpf/bpftool/cgroup.c                    |   5 +-
 tools/bpf/bpftool/main.h                      |   1 +
 tools/bpf/bpftool/prog.c                      |   3 +-
 tools/include/uapi/linux/bpf.h                |  17 +-
 tools/lib/bpf/libbpf.c                        |   5 +
 tools/lib/bpf/libbpf_probes.c                 |   1 +
 tools/testing/selftests/bpf/.gitignore        |   1 +
 tools/testing/selftests/bpf/Makefile          |   3 +-
 tools/testing/selftests/bpf/bpf_helpers.h     |   2 +
 .../selftests/bpf/test_section_names.c        |  10 +
 tools/testing/selftests/bpf/test_sockopt.c    | 789 ++++++++++++++++++
 26 files changed, 1293 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/bpf/prog_cgroup_sockopt.rst
 create mode 100644 tools/testing/selftests/bpf/test_sockopt.c

-- 
2.22.0.rc1.311.g5d7573a151-goog
