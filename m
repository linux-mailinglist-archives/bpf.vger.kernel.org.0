Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF2424B332
	for <lists+bpf@lfdr.de>; Thu, 20 Aug 2020 11:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbgHTJnM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Aug 2020 05:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729146AbgHTJmR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Aug 2020 05:42:17 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAB7C061757
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2020 02:42:16 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id g14so1561382iom.0
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2020 02:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hfrDwkUxCWJWhcrr/MkZm9iD6Oaf34/kRmbpIKwwIkA=;
        b=GC4KoTR+glWOgbethpzs30WzX+5FToyNviIynKCIW8vaPERfA/3+DRIZyYqCWupBJ3
         Mg6EbRPb7NJ8Y392ikW0K8c+7NhHhw1dI8yMTN51qsPeKqJk6b7iGBAgET8RcHaFmxVP
         Uf0cHnGVJ7wzZJlakWlgJrohOnOOmbHRPALCTanlHa8kO8xl+zbW6gFJzD5Oc71txxiT
         qvZvawMG0tNYD/fwGGlP+Zi6ltsKOQ7HBxwuGa1eUTMzyJoVuMNRD2Lars0K+RkE0dLN
         SLPPb/eW47CbeBJTGSouyzaT8vkKbYIKDpAMcF2VgQZcIqSxZFsCU/436zCDrMKQBmhD
         jAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hfrDwkUxCWJWhcrr/MkZm9iD6Oaf34/kRmbpIKwwIkA=;
        b=P3j0lD1aA5nfBAbxDbAPVvtA9c8T/CFSEBKea5ebyqbNFxN1sR5eOqgy5K9OjPIDgN
         ewISdp3WoW2I9KEYlS0Keq15awVOb+XxVhh+NDmQgdBWgMEt88Gmt2yQKY63bUtjsgB/
         BRXCwJJxhLwD1oe7J2JlDX/KqBOAas0A+x9hurCdU46HWx2+Wb4yCtmsEmM/7mrFI0V7
         3mo4LXR5wYyPPxS5csQYVQPmu2xAltb+TS5H8oqJBpCc62qIA04V2FbbmBYbcZsOnrge
         8avMHanyj5A/PY4qmmQNZaeuDYCkMaPqlGEfzCgqAuPQHv6FJ075nfAJNkZMKl+xJVRm
         meYA==
X-Gm-Message-State: AOAM532SfNPR6oHS4nyl8XwqMWlmlOl3TfAt+KkHi0mvi6Sv/1eJPVX2
        gJtmBQHbS1Ya2oXvzwA13xMqhRutCE4Iuw==
X-Google-Smtp-Source: ABdhPJwRVzUHGWZZWBPG7oFSOJ7tbU30+JNE+T+JanSJ/ibZ8FoZOCbZpcDH6h3DlpDvSEZ4LdWW1w==
X-Received: by 2002:a05:6638:13c5:: with SMTP id i5mr2393322jaj.29.1597916535130;
        Thu, 20 Aug 2020 02:42:15 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-219.tnkngak.clients.pavlovmedia.com. [173.230.99.219])
        by smtp.gmail.com with ESMTPSA id r3sm1145597iov.22.2020.08.20.02.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 02:42:14 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: [PATCH bpf-next 0/5] Allow storage of flexible metadata information for eBPF programs
Date:   Thu, 20 Aug 2020 04:42:06 -0500
Message-Id: <cover.1597915265.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: YiFei Zhu <zhuyifei@google.com>

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

Patch 5 adds a test to check the metadata loading and dumping.

Changes since RFC:
* Fixed a few missing unlocks, and missing close while iterating map fds.
* Move mutex initialization to right after prog aux allocation, and mutex
  destroy to right after prog aux free.
* s/ADD_MAP/BIND_MAP/
* Use mutex only instead of RCU to protect the used_map array & count.

YiFei Zhu (5):
  bpf: Mutex protect used_maps array and count
  bpf: Add BPF_PROG_BIND_MAP syscall
  libbpf: Add BPF_PROG_BIND_MAP syscall and use it on .metadata section
  bpftool: support dumping metadata
  selftests/bpf: Test bpftool loading and dumping metadata

 .../net/ethernet/netronome/nfp/bpf/offload.c  |  18 ++-
 include/linux/bpf.h                           |   1 +
 include/uapi/linux/bpf.h                      |   7 +
 kernel/bpf/core.c                             |  15 +-
 kernel/bpf/syscall.c                          |  81 ++++++++++-
 net/core/dev.c                                |  11 +-
 tools/bpf/bpftool/json_writer.c               |   6 +
 tools/bpf/bpftool/json_writer.h               |   3 +
 tools/bpf/bpftool/main.c                      |  10 ++
 tools/bpf/bpftool/main.h                      |   1 +
 tools/bpf/bpftool/prog.c                      | 135 ++++++++++++++++++
 tools/include/uapi/linux/bpf.h                |   7 +
 tools/lib/bpf/bpf.c                           |  11 ++
 tools/lib/bpf/bpf.h                           |   1 +
 tools/lib/bpf/libbpf.c                        | 100 ++++++++++++-
 tools/lib/bpf/libbpf.map                      |   1 +
 tools/testing/selftests/bpf/Makefile          |   3 +-
 .../selftests/bpf/progs/metadata_unused.c     |  15 ++
 .../selftests/bpf/progs/metadata_used.c       |  15 ++
 .../selftests/bpf/test_bpftool_metadata.sh    |  82 +++++++++++
 20 files changed, 504 insertions(+), 19 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/metadata_unused.c
 create mode 100644 tools/testing/selftests/bpf/progs/metadata_used.c
 create mode 100755 tools/testing/selftests/bpf/test_bpftool_metadata.sh

-- 
2.28.0

