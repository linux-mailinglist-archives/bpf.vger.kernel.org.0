Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5332694F8
	for <lists+bpf@lfdr.de>; Mon, 14 Sep 2020 20:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgINSgZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Sep 2020 14:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgINSgS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Sep 2020 14:36:18 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96499C06174A
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2020 11:36:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y6so642736ybi.11
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2020 11:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=Wx/K90vqFIi5BHtvsdB6gKsmX3B2NYZ/c7lFydEYsa8=;
        b=sRiP9m1200dRE2BCwFXnosr9hQXHlcpBc/tRZoL3jocNbnhGgCzyBa7QdAJCM0Oulu
         QpEickMTqUW7bebTaZIi9uwCIv7Mrg9rqFUUg2auzjJy1lSRl6ltlE57n4VfM2uaiRBn
         Y47xgxYFW92m5lNEaAe1o3zZJSPpOxYhgbaRRohoclj1MpBprCzJJZlnTi+QXvYPXHuk
         0Iwti4OwFAJcSXNOU4yI94YwvE1V6Q+C9r/aAsKSMY0y7fciOBc9UOOa+nqINcDQVQFp
         mLDY0Tv6nZA4WXhsl65kf9MDY5rxTOq87d3vl6d37Lt7jsIS5gT/4cUdqX0eLmLAMGRs
         p90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc:content-transfer-encoding;
        bh=Wx/K90vqFIi5BHtvsdB6gKsmX3B2NYZ/c7lFydEYsa8=;
        b=UdrhOdCQQqAgoW3ggCHjfyxNoK6k3zq0dlGTy9Pwbns8O/3B/KRRpVn4N9DrE1howt
         WLmqFa+6jFl6Jnn16SuXX/T1pLiS7toC4tjRqBUxha4GxkOg56hFQOlglbMUWpTIrbQI
         uh+e0dQo+KoNqCTwlEbOBOnh+wpYYS0Sbjr2d4q6Al0zIHAdIeiwUNrk2kHXKrg0X7BZ
         PhDen9WpTt0ieiokPU6caNfe0ECtc5o+t+BCQLQtvE8ELGJHRx9GAUg81L2KshykdpTP
         BGzHR3yvPgRQK5jCIYKvzApW9S63+EHt2QAJGS//yn3eP7SHyWLUhSgP3avmB759V5cu
         YxFQ==
X-Gm-Message-State: AOAM530vwuSN2sKh9KcTTXOnrkPzQTj8r+9d0NV4YMTXabXvKmViVIc/
        R5Kf/ucX3aczeP5W/0v8pFtis1E=
X-Google-Smtp-Source: ABdhPJzipQvBcvBU4a2ArN8FLnyfhwBuveHZ1YOKSJWqc5jnRl8/r8XX/GSaDYuQmhp693fHSYYbXV4=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:7220:84ff:fe09:7732])
 (user=sdf job=sendgmr) by 2002:a25:d2d3:: with SMTP id j202mr21294056ybg.275.1600108576782;
 Mon, 14 Sep 2020 11:36:16 -0700 (PDT)
Date:   Mon, 14 Sep 2020 11:36:10 -0700
Message-Id: <20200914183615.2038347-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH bpf-next v5 0/5] Allow storage of flexible metadata
 information for eBPF programs
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
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

  volatile const char bpf_metadata_commit_hash[] SEC(".rodata") =3D "abcdef=
123456";

and bpftool would emit:

  $ bpftool prog
  [...]
        metadata:
                commit_hash =3D "abcdef123456"

v5 changes:
* selftest: verify that prog holds rodata (Andrii Nakryiko)
* selftest: use volatile for metadata (Andrii Nakryiko)
* bpftool: use sizeof in BPF_METADATA_PREFIX_LEN (Andrii Nakryiko)
* bpftool: new find_metadata that does map lookup (Andrii Nakryiko)
* libbpf: don't generalize probe_create_global_data (Andrii Nakryiko)
* libbpf: use OPTS_VALID in bpf_prog_bind_map (Andrii Nakryiko)
* libbpf: keep LIBBPF_0.2.0 sorted (Andrii Nakryiko)

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
  libbpf: Add BPF_PROG_BIND_MAP syscall and use it on .rodata section
  bpftool: support dumping metadata
  selftests/bpf: Test load and dump metadata with btftool and skel

 .../net/ethernet/netronome/nfp/bpf/offload.c  |  18 +-
 include/linux/bpf.h                           |   1 +
 include/uapi/linux/bpf.h                      |   7 +
 kernel/bpf/core.c                             |  15 +-
 kernel/bpf/syscall.c                          |  79 +++++-
 net/core/dev.c                                |  11 +-
 tools/bpf/bpftool/json_writer.c               |   6 +
 tools/bpf/bpftool/json_writer.h               |   3 +
 tools/bpf/bpftool/prog.c                      | 232 ++++++++++++++++++
 tools/include/uapi/linux/bpf.h                |   7 +
 tools/lib/bpf/bpf.c                           |  16 ++
 tools/lib/bpf/bpf.h                           |   8 +
 tools/lib/bpf/libbpf.c                        |  72 ++++++
 tools/lib/bpf/libbpf.map                      |   1 +
 tools/testing/selftests/bpf/Makefile          |   3 +-
 .../selftests/bpf/prog_tests/metadata.c       | 141 +++++++++++
 .../selftests/bpf/progs/metadata_unused.c     |  15 ++
 .../selftests/bpf/progs/metadata_used.c       |  15 ++
 .../selftests/bpf/test_bpftool_metadata.sh    |  82 +++++++
 19 files changed, 714 insertions(+), 18 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/metadata.c
 create mode 100644 tools/testing/selftests/bpf/progs/metadata_unused.c
 create mode 100644 tools/testing/selftests/bpf/progs/metadata_used.c
 create mode 100755 tools/testing/selftests/bpf/test_bpftool_metadata.sh

--=20
2.28.0.618.gf4bc123cb7-goog

