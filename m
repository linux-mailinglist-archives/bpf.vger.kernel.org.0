Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F8325615A
	for <lists+bpf@lfdr.de>; Fri, 28 Aug 2020 21:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgH1TgK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Aug 2020 15:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgH1TgH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Aug 2020 15:36:07 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368D3C061264
        for <bpf@vger.kernel.org>; Fri, 28 Aug 2020 12:36:07 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d14so251996pln.4
        for <bpf@vger.kernel.org>; Fri, 28 Aug 2020 12:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=LIlGK/Ax6RIqxr8cZxsOwCtqjDpUNwGZQiT8jrnTk+E=;
        b=kwhFEAelZ2iw7+50F7qlZBc5UjBpy5XCI12sSEdZm4ffEdTpdwSjZs2gQsYJTZ7pLw
         UsdY5wF6s0OzWeyeAuTImv4Mg6+dETrbOChe6lFlfzCvr0XcwR1O0GW2a1/CvcUzxCbL
         dyfjwwbjoSWmoYOcB1HROOLNK3hAAWHkLhd7Oc1EH5fnZGacJXON7upG84aqPi++s/cu
         muPH1mlU+uUtN11eyLMqfnhDZ1rqtEUPkQ5Rtbq2ExHUK6eJiJyEmn70mOrQnV3e2kfZ
         gkRWM0ngOe3WdmptwzEsadc55g/VwvPNOEaWIs0CYbUyUrUfPsV9HzQDyQGSL3ieFuX/
         qkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=LIlGK/Ax6RIqxr8cZxsOwCtqjDpUNwGZQiT8jrnTk+E=;
        b=AMkzkE52rk66uCTiRXHz4aGX3tqpN0eHGunVTL6Kzo0Km3B6F3F6UFSUfSu4051fft
         4O6elOKqP2CTXrMR4R245yZh7KwXxOdXKNiowxLCfUIOKFTQDHACxbX2MqFSgobS3f9J
         ebAiuu4BS9Yp1MmT/K6cyvncQKoy0g1TmwN/2q8ib7fX9lsakiHwrRBKHx1Zece3j9oE
         vkCJI7gF8x0HKFwhsnkMi5HzSHIYIIZGiJAZmR0XGWmOHbvpNcZenf9ptlb2xyLpz3j9
         5Kvg5Xj/ap+OhoJMFY9+YWBiY238NAPkWwIlq5L7b7ezWOrw9Kw0ipGbyRFajrUJUNQ0
         jrfA==
X-Gm-Message-State: AOAM530raz6JOSR7NwVbFtsBTlaHd0GzsbQ49XOYmd4G7Q4ZO1fAdHlR
        jGQntmCkoWuZ+5giNLnV9JspsM8=
X-Google-Smtp-Source: ABdhPJzaoLFMQZd+DCTSKo3T+4awecWgk4V+BJNR3GAE0bo0Ss6iosI5v4pNelGHvx6vqohEEyRAY/g=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:7220:84ff:fe09:7732])
 (user=sdf job=sendgmr) by 2002:a17:902:8f91:: with SMTP id
 z17mr330606plo.123.1598643365421; Fri, 28 Aug 2020 12:36:05 -0700 (PDT)
Date:   Fri, 28 Aug 2020 12:35:55 -0700
Message-Id: <20200828193603.335512-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH bpf-next v3 0/8] Allow storage of flexible metadata
 information for eBPF programs
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
reference the map. libbpf is extended to recognize the .metadata section
and load it as an internal map, and use the new syscall to ensure the
map is bound. bpftool is also extended to have a new flag to prog
subcommand, "--metadata" to dump the contents of the metadata section
without a separate map dump call.

An example use of this would be BPF C file declaring:

  char commit_hash[] SEC(".metadata") = "abcdef123456";

and bpftool would emit:

  $ bpftool prog --metadata
  [...]
        metadata:
                commit_hash = "abcdef123456"

Patch 1 protects the used_maps array and count with a mutex.

Patch 2 implements the new syscall.

Patch 3 extends libbpf to have a wrapper around the syscall, probe the
kernel for support of this new syscall, and use it on .metadata section
if supported and the section exists.

Patch 4 extends bpftool so that it is able to dump metadata from prog
show.

Patch 5 extends bpftool gen skeleton to treat the metadata section like
an rodata section so that it mmaps the map read-only at load time.

Patch 6 adds a test to check the metadata loading and dumping.

Changes since RFC:
* Fixed a few missing unlocks, and missing close while iterating map fds.
* Move mutex initialization to right after prog aux allocation, and mutex
  destroy to right after prog aux free.
* s/ADD_MAP/BIND_MAP/
* Use mutex only instead of RCU to protect the used_map array & count.

Changes since v1:
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

Cc: YiFei Zhu <zhuyifei1999@gmail.com>

Stanislav Fomichev (2):
  libbpf: implement bpf_prog_find_metadata
  bpftool: mention --metadata in the documentation

YiFei Zhu (6):
  bpf: Mutex protect used_maps array and count
  bpf: Add BPF_PROG_BIND_MAP syscall
  libbpf: Add BPF_PROG_BIND_MAP syscall and use it on .metadata section
  bpftool: support dumping metadata
  bpftool: support metadata internal map in gen skeleton
  selftests/bpf: Test load and dump metadata with btftool and skel

 .../net/ethernet/netronome/nfp/bpf/offload.c  |  18 ++-
 include/linux/bpf.h                           |   1 +
 include/uapi/linux/bpf.h                      |   7 +
 kernel/bpf/core.c                             |  15 +-
 kernel/bpf/syscall.c                          |  81 ++++++++++-
 net/core/dev.c                                |  11 +-
 .../bpftool/Documentation/bpftool-prog.rst    |   5 +-
 tools/bpf/bpftool/gen.c                       |   5 +
 tools/bpf/bpftool/json_writer.c               |   6 +
 tools/bpf/bpftool/json_writer.h               |   3 +
 tools/bpf/bpftool/main.c                      |  10 ++
 tools/bpf/bpftool/main.h                      |   1 +
 tools/bpf/bpftool/prog.c                      | 132 +++++++++++++++++-
 tools/include/uapi/linux/bpf.h                |   7 +
 tools/lib/bpf/bpf.c                           |  87 ++++++++++++
 tools/lib/bpf/bpf.h                           |   9 ++
 tools/lib/bpf/libbpf.c                        | 130 ++++++++++++++---
 tools/lib/bpf/libbpf.map                      |   2 +
 tools/testing/selftests/bpf/Makefile          |   3 +-
 .../selftests/bpf/prog_tests/metadata.c       |  83 +++++++++++
 .../selftests/bpf/progs/metadata_unused.c     |  15 ++
 .../selftests/bpf/progs/metadata_used.c       |  15 ++
 .../selftests/bpf/test_bpftool_metadata.sh    |  82 +++++++++++
 23 files changed, 687 insertions(+), 41 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/metadata.c
 create mode 100644 tools/testing/selftests/bpf/progs/metadata_unused.c
 create mode 100644 tools/testing/selftests/bpf/progs/metadata_used.c
 create mode 100755 tools/testing/selftests/bpf/test_bpftool_metadata.sh

-- 
2.28.0.402.g5ffc5be6b7-goog

