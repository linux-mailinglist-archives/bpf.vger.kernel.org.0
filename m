Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70E213BE0D
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2019 23:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389601AbfFJVId (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Jun 2019 17:08:33 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:51902 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388642AbfFJVId (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Jun 2019 17:08:33 -0400
Received: by mail-vk1-f202.google.com with SMTP id s145so1064164vke.18
        for <bpf@vger.kernel.org>; Mon, 10 Jun 2019 14:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=l9/dXELCjGvp9d7K5iU/HJOyPZVm7QUj+fuxv9xF5cE=;
        b=WVrm6VCOG3hSJ23gH96QMmu6t/rImQ2W8Fh7XeHqkJro8imZHd2QTQeaK1b/1RS7sT
         P9dBG7Dm++ieIIpXC5GFbmGBuL37kf/1Aesn0sIkqdpSg8jLm8xP81EVIrNPEOXwZdjp
         NfqqXY6q7T7NLdI9vxM+gb8XHZE6Fd6rg+LhAiAEsrP23WcZGURErMOOTqgqzV5GOs4e
         nQSWHZk/3XTtd7DzibRBfdQtAW28up/rwn+g+I6KooLHYHzBgcRAt0fyGh/8UvB04sfH
         Jia/VwIC66/EMnAunIjhpUl2jdj2ODICJA7UMFOr6j52vNpGbseGNiszZI2f9oEJ78fT
         DYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=l9/dXELCjGvp9d7K5iU/HJOyPZVm7QUj+fuxv9xF5cE=;
        b=NbtHSY8Y4JyNuvF7zhBKeh2BBDMatjIwEDoz67KZMMy905LazDOSkFna3CTc74FQ8o
         XiqONNRqH/Sf8svv0USqmIthYKUp9hLNgAgXvp8sm2chzQjqM0PMB2QEaIthpqTCC81h
         H3l9fH/aGBD5St+glSgxGwMdtNAnAsoes7UbBA+dowxHrMRfqbwJNeAJX6RIifMqajwR
         OhTj8ogB6tl73+p8VCvLha+QT2UF4qUc3vuMhFj26IeErGZXyJvnwsbvaqQas6AhMQeD
         PDJ23ZAaqaaQC4o13KOHhT2UFVgda0VYrdAwGQS5wXQ8bAFgs5sD6VOspAVBMpASHH7k
         ku9w==
X-Gm-Message-State: APjAAAWJArreiIuq0SCp9QXXUsgqnY/O3PL38ILSRGTP0+D4yOpyrQ9N
        7E79h7AGDKevawgtTw3kDoxPJjM=
X-Google-Smtp-Source: APXvYqw07rS31q4aCgj4MwoDWWKc2zZzzV6WjT4AERtQsiPvnUEvLeYxDWxCT9MgNcQojVUKGgMrKYo=
X-Received: by 2002:ab0:7442:: with SMTP id p2mr22624528uaq.92.1560200912650;
 Mon, 10 Jun 2019 14:08:32 -0700 (PDT)
Date:   Mon, 10 Jun 2019 14:08:22 -0700
Message-Id: <20190610210830.105694-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH bpf-next v5 0/8] bpf: getsockopt and setsockopt hooks
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
 include/linux/bpf.h                           |  45 +
 include/linux/bpf_types.h                     |   1 +
 include/linux/filter.h                        |  13 +
 include/uapi/linux/bpf.h                      |  13 +
 kernel/bpf/cgroup.c                           | 260 ++++++
 kernel/bpf/core.c                             |   9 +
 kernel/bpf/syscall.c                          |  19 +
 kernel/bpf/verifier.c                         |  15 +
 net/core/filter.c                             |   2 +-
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
 .../testing/selftests/bpf/progs/sockopt_sk.c  |  67 ++
 .../selftests/bpf/test_section_names.c        |  10 +
 tools/testing/selftests/bpf/test_sockopt.c    | 773 ++++++++++++++++++
 tools/testing/selftests/bpf/test_sockopt_sk.c | 156 ++++
 28 files changed, 1512 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/bpf/prog_cgroup_sockopt.rst
 create mode 100644 tools/testing/selftests/bpf/progs/sockopt_sk.c
 create mode 100644 tools/testing/selftests/bpf/test_sockopt.c
 create mode 100644 tools/testing/selftests/bpf/test_sockopt_sk.c

-- 
2.22.0.rc2.383.gf4fbbf30c2-goog
