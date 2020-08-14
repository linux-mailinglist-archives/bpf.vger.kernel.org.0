Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0455F244EBC
	for <lists+bpf@lfdr.de>; Fri, 14 Aug 2020 21:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgHNTQC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Aug 2020 15:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgHNTQC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Aug 2020 15:16:02 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE68C061385
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2020 12:16:01 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id t15so11871742iob.3
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2020 12:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fbKjjZMzS+f//92PLwvFLHmIN88v7xjSKTNw8+peSH8=;
        b=Jv/+N4hxsaRgHvX55dj53w4rRxQp9vNSJetuCSsrLtozTo1d8iEPqEXBulqfAupNOW
         z6i0oM7SXYFLZJ7yWk9O8cKOdaCMPPh9FCc9Yke2oA9lS0SCzthxhJISQ/F7REnWz+yH
         qjxxs7fz/OHJehEUYLLyMQbgpWFSsgzPDXSMKsU9nNKDrtS5m7PlmPFZL/fysmNWi15K
         /UZJBy2BGnvP0ImysYycWARkN1TExfDyKHUoDVBuvGaufTU076na/7G/KSPOBVENr9Ml
         q7bnSzJ0/oq83VpBJL4X/a1Hjr6OKvdGOBTtu5f5y3Fl8mi44QC7UK0DQH5a0a30i84I
         KOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fbKjjZMzS+f//92PLwvFLHmIN88v7xjSKTNw8+peSH8=;
        b=qefpGJb+aI7NO+d0tfvw+5hwZ3yOHGK94Vh9SDEbCRxXfre+GKYDCjui6/eg2pauD9
         L/pwIYvhM8Xd5NrknDPTn0Fhs8QW4TdPX58iIxfsfv4sIlgWJMug76Mkp6umcDWeH/hR
         VIin9AbmTT0rObnIhpEufBbcYujg7nD6akueNVyy5N8P2SsYzHtDDUtDAGt4FGkJXTmp
         lI1Wx3R3dfv180uRcjEoSw2zNaRR/hpiVgW6UmmNGrBgNicTNe7Cgv/v9pl5NUZ0DapK
         d7UY8r5GrqvFE7ikyx0pcP7W6tX9JwYGy3Mk6p6kq4f6k+aGeixWtjwU2QBzQ7BXYN8Z
         FmTA==
X-Gm-Message-State: AOAM531JZ4vWoBJFPkFy2kfw2htN6+ELkrF6NquWBxJfAaou40qvxBLB
        Q//eWP2j1eiQTSegZfp5U3YEODwzyCSteg==
X-Google-Smtp-Source: ABdhPJxqW8jdqNjGJI4ReES6boVmdJZdNMqLX7eg0/HRQQUzKsTl0BizaejSLBkkltL+uQgIUshLBQ==
X-Received: by 2002:a05:6638:3bb:: with SMTP id z27mr4173868jap.0.1597432561103;
        Fri, 14 Aug 2020 12:16:01 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-219.tnkngak.clients.pavlovmedia.com. [173.230.99.219])
        by smtp.gmail.com with ESMTPSA id f15sm4521028ilc.51.2020.08.14.12.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 12:16:00 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: [RFC PATCH bpf-next 0/5] Allow storage of flexible metadata information for eBPF programs
Date:   Fri, 14 Aug 2020 14:15:53 -0500
Message-Id: <cover.1597427271.git.zhuyifei@google.com>
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

This patch set introduces a new syscall BPF_PROG_ADD_MAP to attach a map
to a program's used_maps, even if the program instructions does not
reference the map. libbpf is extended to recognize the .metadata section
and load it as an internal map, and use the new syscall to ensure the
map is attached. bpftool is also extended to have a new flag to prog
subcommand, "--metadata" to dump the contents of the metadata section
without a separate map dump call.

An example use of this would be BPF C file declaring:

 char commit_hash[] SEC(".metadata") = "abcdef123456";

and bpftool would emit:

  $ bpftool prog --metadata
  [...]
        metadata:
                commit_hash = "abcdef123456"

Patch 1 moves the used_maps array and count into an RCU-protected
struct.

Patch 2 implements the new syscall.

Patch 3 extends libbpf to have a wrapper around the syscall, probe the
kernel for support of this new syscall, and use it on .metadata section
if supported and the section exists.

Patch 4 extends bpftool so that it is able to dump metadata from prog
show.

Patch 5 adds a test to check the metadata loading and dumping.

YiFei Zhu (5):
  bpf: RCU protect used_maps array and count
  bpf: Add BPF_PROG_ADD_MAP syscall
  libbpf: Add BPF_PROG_ADD_MAP syscall and use it on .metadata section
  bpftool: support dumping metadata
  selftests/bpf: Test bpftool loading and dumping metadata

 .../net/ethernet/netronome/nfp/bpf/offload.c  |  33 +++--
 include/linux/bpf.h                           |  11 +-
 include/uapi/linux/bpf.h                      |   7 +
 kernel/bpf/core.c                             |  25 +++-
 kernel/bpf/syscall.c                          | 102 +++++++++++++-
 kernel/bpf/verifier.c                         |  37 +++--
 net/core/dev.c                                |  12 +-
 tools/bpf/bpftool/json_writer.c               |   6 +
 tools/bpf/bpftool/json_writer.h               |   3 +
 tools/bpf/bpftool/main.c                      |  10 ++
 tools/bpf/bpftool/main.h                      |   1 +
 tools/bpf/bpftool/prog.c                      | 132 ++++++++++++++++++
 tools/include/uapi/linux/bpf.h                |   7 +
 tools/lib/bpf/bpf.c                           |  11 ++
 tools/lib/bpf/bpf.h                           |   1 +
 tools/lib/bpf/libbpf.c                        |  97 ++++++++++++-
 tools/lib/bpf/libbpf.map                      |   1 +
 tools/testing/selftests/bpf/Makefile          |   3 +-
 .../selftests/bpf/progs/metadata_unused.c     |  15 ++
 .../selftests/bpf/progs/metadata_used.c       |  15 ++
 .../selftests/bpf/test_bpftool_metadata.sh    |  82 +++++++++++
 21 files changed, 572 insertions(+), 39 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/metadata_unused.c
 create mode 100644 tools/testing/selftests/bpf/progs/metadata_used.c
 create mode 100755 tools/testing/selftests/bpf/test_bpftool_metadata.sh

-- 
2.28.0

