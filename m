Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45CF82635DC
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 20:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgIISYU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 14:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIISYK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 14:24:10 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A395C061573
        for <bpf@vger.kernel.org>; Wed,  9 Sep 2020 11:24:10 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v3so3041706ybb.22
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2020 11:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=JqSfgROtJDDRj7H2nqYPi9k7xMNwm4SmLBIOYDJz6SM=;
        b=fTseVQZQss6IIwjSQbWhU9yx7DtAOr4ICOfnXVRv45GeZeoxRT+NHgSqvx0p1mvFoh
         MvXlijZlA6UidH/P0+86ADVQAR7bPr5tCDKlN4lptHzq1uXJ5JskngTdWlIDafHguwbR
         qhe1bV7JWvGxOkH5fbmGKOkAH43wGAYDllSz2kYPh7iK1CFnEBTjZAe+hNXhy3bm0MiF
         YSghLoqPht5sWTI6UdImp05/ypiUKs2XCEUjlDUxTUv4IYBjE4zZ/9eEHx8tsMl4Ubvc
         sex2fFCBRbUCoDG6IWzWdD/9tB6hTl7GhrO5dYsZwtGp35Z/UqeOnapjoTY5BfYUpjoB
         Mjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc:content-transfer-encoding;
        bh=JqSfgROtJDDRj7H2nqYPi9k7xMNwm4SmLBIOYDJz6SM=;
        b=hJ3jqSihoLFeWA7kafbwkppOX+8d2+QPrX3PQJfSCjtRZOJUsU+Ds/HgPixfFPNg1F
         pgT4Fw55FgENW69zP697mS1mLvC9xLRVbDzlbQeEyJ1iQNaXeBMN5cJT2NbWiERawSZh
         qmYo5KqK+grD8eWUmiogF+212X314EXS+W9KSQZhBPFWZJt8AOTEcMH0A79qg0T+Vd4t
         QdTv95mk4ode9Pb6XHjwhfbqmxxADofRQ6HFZ2UZZ2YNla2QCd4L9ZAYh5E+Qa97XKbs
         yhylwGcpBQpZYQ7+5UWr4lVLWHbw7erFrpEDL+HqKIUDFZzhQkDvRN8k5R4/xqVXQCbl
         gcEA==
X-Gm-Message-State: AOAM532D3mTHviEpIBBA2M0yvySVsOs+015gahk+oTlzEk8W0QZdIV78
        hSsMnxBJcUY8Oy0XhnJCzN7AuNg=
X-Google-Smtp-Source: ABdhPJxJmQVxTU98C41fqE/lL9MHjoRLgXZV1Wnqo9OJPNfcomI+5SM7Aj7q4r0Gc1YeQNvTJK0RVSI=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:7220:84ff:fe09:7732])
 (user=sdf job=sendgmr) by 2002:a25:df15:: with SMTP id w21mr7929297ybg.138.1599675848168;
 Wed, 09 Sep 2020 11:24:08 -0700 (PDT)
Date:   Wed,  9 Sep 2020 11:24:01 -0700
Message-Id: <20200909182406.3147878-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH bpf-next v4 0/5] Allow storage of flexible metadata
 information for eBPF programs
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, if a user wants to store arbitrary metadata for an eBPF
program, for example, the program build commit hash or version, they
could store it in a map, and conveniently libbpf uses .data section to
populate an internal map. However, if the program does not actually
reference the map, then the map would be de-refcounted and freed.

This patch set introduces a new syscall BPF_PROG_BIND_MAP to add a map
to a program's used_maps, even if the program instructions does not
reference the map.

libbpf is extended to always BPF_PROG_BIND_MAP .rodata section so the
metadata is kept in place.
bpftool is also extended to print metadata in the 'bpftool prog' list.

The variable is considered metadata if it starts with the
magic 'bpf_metadata_' prefix; everything after the prefix is the
metadata name.

An example use of this would be BPF C file declaring:

  const char bpf_metadata_commit_hash[] SEC(".rodata") =3D "abcdef123456";

and bpftool would emit:

  $ bpftool prog
  [...]
        metadata:
                commit_hash =3D "abcdef123456"

v4 changes:
* Don't return EEXIST from syscall if already bound (Andrii Nakryiko)
* Removed --metadata argument (Andrii Nakryiko)
* Removed custom .metadata section (Alexei Starovoitov)
* Addressed Andrii's suggestions about btf helpers and vsi (Andrii Nakryiko=
)
* Moved bpf_prog_find_metadata into bpftool (Alexei Starovoitov)

v3 changes:
* API changes for bpf_prog_find_metadata (Toke H=C3=B8iland-J=C3=B8rgensen)

v2 changes:
* Made struct bpf_prog_bind_opts in libbpf so flags is optional.
* Deduped probe_kern_global_data and probe_prog_bind_map into a common
  helper.
* Added comment regarding why EEXIST is ignored in libbpf bind map.
* Froze all LIBBPF_MAP_METADATA internal maps.
* Moved bpf_prog_bind_map into new LIBBPF_0.1.1 in libbpf.map.
* Added p_err() calls on error cases in bpftool show_prog_metadata.
* Reverse christmas tree coding style in bpftool show_prog_metadata.
* Made bpftool gen skeleton recognize .metadata as an internal map and
  generate datasec definition in skeleton.
* Added C test using skeleton to see asset that the metadata is what we
  expect and rebinding causes EEXIST.

v1 changes:
* Fixed a few missing unlocks, and missing close while iterating map fds.
* Move mutex initialization to right after prog aux allocation, and mutex
  destroy to right after prog aux free.
* s/ADD_MAP/BIND_MAP/
* Use mutex only instead of RCU to protect the used_map array & count.

Cc: YiFei Zhu <zhuyifei1999@gmail.com>

YiFei Zhu (5):
  bpf: Mutex protect used_maps array and count
  bpf: Add BPF_PROG_BIND_MAP syscall
  libbpf: Add BPF_PROG_BIND_MAP syscall and use it on .metadata section
  bpftool: support dumping metadata
  selftests/bpf: Test load and dump metadata with btftool and skel

 .../net/ethernet/netronome/nfp/bpf/offload.c  |  18 +-
 include/linux/bpf.h                           |   1 +
 include/uapi/linux/bpf.h                      |   7 +
 kernel/bpf/core.c                             |  15 +-
 kernel/bpf/syscall.c                          |  79 ++++++-
 net/core/dev.c                                |  11 +-
 tools/bpf/bpftool/json_writer.c               |   6 +
 tools/bpf/bpftool/json_writer.h               |   3 +
 tools/bpf/bpftool/prog.c                      | 222 ++++++++++++++++++
 tools/include/uapi/linux/bpf.h                |   7 +
 tools/lib/bpf/bpf.c                           |  13 +
 tools/lib/bpf/bpf.h                           |   8 +
 tools/lib/bpf/libbpf.c                        |  94 ++++++--
 tools/lib/bpf/libbpf.map                      |   1 +
 tools/testing/selftests/bpf/Makefile          |   3 +-
 .../selftests/bpf/prog_tests/metadata.c       |  81 +++++++
 .../selftests/bpf/progs/metadata_unused.c     |  15 ++
 .../selftests/bpf/progs/metadata_used.c       |  15 ++
 .../selftests/bpf/test_bpftool_metadata.sh    |  82 +++++++
 19 files changed, 645 insertions(+), 36 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/metadata.c
 create mode 100644 tools/testing/selftests/bpf/progs/metadata_unused.c
 create mode 100644 tools/testing/selftests/bpf/progs/metadata_used.c
 create mode 100755 tools/testing/selftests/bpf/test_bpftool_metadata.sh

--=20
2.28.0.526.ge36021eeef-goog

