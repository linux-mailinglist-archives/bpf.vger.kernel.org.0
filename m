Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74C4358BBF
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2019 22:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfF0Ui7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jun 2019 16:38:59 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:55922 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfF0Ui6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Jun 2019 16:38:58 -0400
Received: by mail-pf1-f201.google.com with SMTP id i26so2268623pfo.22
        for <bpf@vger.kernel.org>; Thu, 27 Jun 2019 13:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=IyeyMj4roDD0kDM67GID8k8aBjlB7wnRUksBjx9pO6o=;
        b=im9YE5Ax1IW3TiAXzjnhZUwpFA3CLsu0O+o+pmS2WAChzV0brY8wqf4rrA2X9VY3G9
         2ASu1MOXrn2DbI1qIV0HCEe76a8sff5bcXJQQmGDltrVtHHLoOES72z0JlGrl7RLZiXO
         GR8psTsBy6loGsTn5hbYfI0nrd53wTW2p2tEBHQ/b81EjTEi3Q2yPV4Iik2jrM+tfsym
         8nKIcDFJ8nICfKirQjsB69UQBK31ZYCm7Bwzv99iPorlCXru8ozc2EvX8EUsMG4tyPtb
         Iuq7ZxM9Y5lAX9y3kLVUNVEcpvIba2b03rhrDijhngsiGyMska08G/u6aKjkB/5k/MwO
         CAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=IyeyMj4roDD0kDM67GID8k8aBjlB7wnRUksBjx9pO6o=;
        b=DwWZC4YxGnsZqJB/WM5X57lwYINFq0zaKH6LzAr8yZhd+VNALqFJCMza5ag0MkGTGB
         SdXBs4qhEkhAjzb1ipAIUTXyp/O6B4xrS6AkZen4a/VtlpuxYHiOJgOKdOYlBt8boV8i
         Jhyrln0avR6aLTUtk1IOw2EyRa0GbqUTOnRKjqUmxPVwZe3Wl0pUE+CyHGvWC7n8IKcs
         Y+for/68u4Pk1f0rWSBRump9pFG4GJX0eWHmx2KiY6UC6wj++THaxIaYwXQQOR0GJiJp
         hp4kJ/S+MkVLInYBM8wCFq+9oQKm5ZLtqDr7WcVBIADew25MiSucBq8lPuuHb5gCUwYL
         J9JA==
X-Gm-Message-State: APjAAAXFjCkWHxhzFnNS0LWMoi78J2mOuDDD4LxNgKQZk3rnas6Bsk/7
        t4TLCwOuGLKNM61EXX/b5tS3rMs=
X-Google-Smtp-Source: APXvYqycdK4YR0sCWfvO6YrXYvC0KrHBmL+yfD7s7GFgiCKWCMMrtTO9QS1AcKPy7G5GyvPd4GEgU9o=
X-Received: by 2002:a63:18d:: with SMTP id 135mr5636361pgb.62.1561667937778;
 Thu, 27 Jun 2019 13:38:57 -0700 (PDT)
Date:   Thu, 27 Jun 2019 13:38:46 -0700
Message-Id: <20190627203855.10515-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next v9 0/9] bpf: getsockopt and setsockopt hooks
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

v9:
* allow overwriting setsocktop arguments (Alexei Starovoitov)
  (see individual changes for more changelog details)

Stanislav Fomichev (9):
  bpf: implement getsockopt and setsockopt hooks
  bpf: sync bpf.h to tools/
  libbpf: support sockopt hooks
  selftests/bpf: test sockopt section name
  selftests/bpf: add sockopt test
  selftests/bpf: add sockopt test that exercises sk helpers
  selftests/bpf: add sockopt test that exercises BPF_F_ALLOW_MULTI
  bpf: add sockopt documentation
  bpftool: support cgroup sockopt

 Documentation/bpf/index.rst                   |    1 +
 Documentation/bpf/prog_cgroup_sockopt.rst     |   93 ++
 include/linux/bpf-cgroup.h                    |   45 +
 include/linux/bpf.h                           |    2 +
 include/linux/bpf_types.h                     |    1 +
 include/linux/filter.h                        |   10 +
 include/uapi/linux/bpf.h                      |   14 +
 kernel/bpf/cgroup.c                           |  333 ++++++
 kernel/bpf/core.c                             |    9 +
 kernel/bpf/syscall.c                          |   19 +
 kernel/bpf/verifier.c                         |    8 +
 net/core/filter.c                             |    2 +-
 net/socket.c                                  |   30 +
 .../bpftool/Documentation/bpftool-cgroup.rst  |    7 +-
 .../bpftool/Documentation/bpftool-prog.rst    |    3 +-
 tools/bpf/bpftool/bash-completion/bpftool     |    9 +-
 tools/bpf/bpftool/cgroup.c                    |    5 +-
 tools/bpf/bpftool/main.h                      |    1 +
 tools/bpf/bpftool/prog.c                      |    3 +-
 tools/include/uapi/linux/bpf.h                |   14 +
 tools/lib/bpf/libbpf.c                        |    5 +
 tools/lib/bpf/libbpf_probes.c                 |    1 +
 tools/testing/selftests/bpf/.gitignore        |    3 +
 tools/testing/selftests/bpf/Makefile          |    6 +-
 .../selftests/bpf/progs/sockopt_multi.c       |   71 ++
 .../testing/selftests/bpf/progs/sockopt_sk.c  |  111 ++
 .../selftests/bpf/test_section_names.c        |   10 +
 tools/testing/selftests/bpf/test_sockopt.c    | 1021 +++++++++++++++++
 .../selftests/bpf/test_sockopt_multi.c        |  374 ++++++
 tools/testing/selftests/bpf/test_sockopt_sk.c |  214 ++++
 30 files changed, 2415 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/bpf/prog_cgroup_sockopt.rst
 create mode 100644 tools/testing/selftests/bpf/progs/sockopt_multi.c
 create mode 100644 tools/testing/selftests/bpf/progs/sockopt_sk.c
 create mode 100644 tools/testing/selftests/bpf/test_sockopt.c
 create mode 100644 tools/testing/selftests/bpf/test_sockopt_multi.c
 create mode 100644 tools/testing/selftests/bpf/test_sockopt_sk.c

-- 
2.22.0.410.gd8fdbe21b5-goog
