Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4295B4BF1E
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2019 19:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfFSRAA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jun 2019 13:00:00 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:33157 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfFSRAA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Jun 2019 13:00:00 -0400
Received: by mail-yw1-f74.google.com with SMTP id d135so148456ywd.0
        for <bpf@vger.kernel.org>; Wed, 19 Jun 2019 10:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Wge+u5ZOZB6ul9wJMu3woe8hUr/62OhCT5ISxGP6XaM=;
        b=XaBnIKcRhQyFKt1NafIQRmeIT2dhr2iOIr4+7w0/5k02DC7F6PticelKK5XJlewXnL
         qvT5eLezM5oQrjM0vkuXsSSTwgCYU1K+kacU4+ji+v89H5Wyyi5Udcp+FcK7d8RUvUl8
         UnNaen92/Wg/kfMz069GL5IdEvXWOavuDa0YKiMsQFz0kPuXaL8xxnYWmuditW7nWpyb
         SKTs1owy+Nza/f83+b59M4a3PpknZ0UKpQt4PjP3k06ftJEQg8T+3cp/N5w/+47vFeVK
         Z2KG2ehrOTGFpWD9dtAcx2QuyH4Z+3wWPCpH+0y/2EAnC9MDrMwczHb07GQgRlZ5XewI
         9H6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Wge+u5ZOZB6ul9wJMu3woe8hUr/62OhCT5ISxGP6XaM=;
        b=ttuZPhUZqhdXRseMC6blhuw1EDhBRF+4cwrlYen/UqhefY8raJY/sJF00wABSYeZKa
         TTChLUsoiV72sRvMTbn2/J9pJW5oQqirD0YjFq7o0WAdYv2Bh/moUyepZWRkLrqtYo7u
         YLtbJAy3Q69ygObblD0QT+NgZlVaSZoqqhExlKiKE5CP+gICBU6EqANzVspIP6WtKP1V
         d2vCLC4qMAukrjfx4VUADSNFPGT2fsxVTQ2QfWUOfV3OIslUALX1cZBSAnw2/krPDPnC
         PaeExU+Ch+VtZWJdjZe3hr0KHvHlXw8eszHNr5B08207rigJbLrUayeK6+S4XN//vCvk
         DOsw==
X-Gm-Message-State: APjAAAVD4SHpdKNevfOVrEC59ydfmUufngrC3c59Dgprlxjy6vTH6b2a
        zylkQ4UjWQW1m5LxmCr6mzFRzJo=
X-Google-Smtp-Source: APXvYqza2edhpzvlAoLtZ+V41xL1NNpnIxk75jSZt9rpi7JO5QNQs4NRynT/dhlJMU0IhgBAEioXgNo=
X-Received: by 2002:a25:3b48:: with SMTP id i69mr43895345yba.222.1560963599730;
 Wed, 19 Jun 2019 09:59:59 -0700 (PDT)
Date:   Wed, 19 Jun 2019 09:59:48 -0700
Message-Id: <20190619165957.235580-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next v7 0/9] bpf: getsockopt and setsockopt hooks
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

 Documentation/bpf/index.rst                   |   1 +
 Documentation/bpf/prog_cgroup_sockopt.rst     |  82 ++
 include/linux/bpf-cgroup.h                    |  43 +
 include/linux/bpf.h                           |   2 +
 include/linux/bpf_types.h                     |   1 +
 include/linux/filter.h                        |  14 +
 include/uapi/linux/bpf.h                      |  14 +
 kernel/bpf/cgroup.c                           | 317 +++++++
 kernel/bpf/core.c                             |   9 +
 kernel/bpf/syscall.c                          |  19 +
 kernel/bpf/verifier.c                         |  13 +
 net/core/filter.c                             |   2 +-
 net/socket.c                                  |  16 +
 .../bpftool/Documentation/bpftool-cgroup.rst  |   7 +-
 .../bpftool/Documentation/bpftool-prog.rst    |   2 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   8 +-
 tools/bpf/bpftool/cgroup.c                    |   5 +-
 tools/bpf/bpftool/main.h                      |   1 +
 tools/bpf/bpftool/prog.c                      |   3 +-
 tools/include/uapi/linux/bpf.h                |  14 +
 tools/lib/bpf/libbpf.c                        |   5 +
 tools/lib/bpf/libbpf_probes.c                 |   1 +
 tools/testing/selftests/bpf/.gitignore        |   3 +
 tools/testing/selftests/bpf/Makefile          |   6 +-
 .../selftests/bpf/progs/sockopt_multi.c       |  53 ++
 .../testing/selftests/bpf/progs/sockopt_sk.c  |  91 ++
 .../selftests/bpf/test_section_names.c        |  10 +
 tools/testing/selftests/bpf/test_sockopt.c    | 892 ++++++++++++++++++
 .../selftests/bpf/test_sockopt_multi.c        | 276 ++++++
 tools/testing/selftests/bpf/test_sockopt_sk.c | 185 ++++
 30 files changed, 2085 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/bpf/prog_cgroup_sockopt.rst
 create mode 100644 tools/testing/selftests/bpf/progs/sockopt_multi.c
 create mode 100644 tools/testing/selftests/bpf/progs/sockopt_sk.c
 create mode 100644 tools/testing/selftests/bpf/test_sockopt.c
 create mode 100644 tools/testing/selftests/bpf/test_sockopt_multi.c
 create mode 100644 tools/testing/selftests/bpf/test_sockopt_sk.c

-- 
2.22.0.410.gd8fdbe21b5-goog
