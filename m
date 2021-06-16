Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC9B3AA6C2
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 00:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbhFPWtk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Jun 2021 18:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbhFPWtj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Jun 2021 18:49:39 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B2BC061574
        for <bpf@vger.kernel.org>; Wed, 16 Jun 2021 15:47:33 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id g24so2628494pji.4
        for <bpf@vger.kernel.org>; Wed, 16 Jun 2021 15:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2bGViEGJGj2MsZzTuw3aOUQXv4ShMU8TNCZXBiAhmD8=;
        b=poIUGZnJe3Lt//X/Mkv9S1Ey+fu4CasVm/vbA1vQtPDXG5VfZDg1UwQj+5iLYMwXCx
         QYJcwie7OZmMTVFirALzT64RFtmrhzC6ZOWOamxf2fIvJzt24PNcaYB8VmZesPbStThY
         dETDBEztfLH8fUHNyPuO1uslIwoEmEvGLGjOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2bGViEGJGj2MsZzTuw3aOUQXv4ShMU8TNCZXBiAhmD8=;
        b=kbzkWoIZIIgP1G9bq99DXZntLR5yVyw40npvnGU5j5lcAUGsK+n7UNbBa3laObXGNd
         IRh8YNn0h8HfbFzDKSRYqpqFtmI7DMMll/pqHZz2y9aktgX8yNSbJeE2wKwiIzMwOTQD
         k5p1/CFNmW8F3rENjd0iBMNZJ/1Na87K20aPEl7XP7ENiRiTn9rWs4Sd5Jqyd8Ngs6SL
         UdQQbQTpjJ3ieAk+A5KN/0ItRx5U2wfqIU/XVPCaYWrGgsVoLQMzo8TIYRdwjtVdrPc7
         3AGQsYbnuJsjHnC6qKFcDAZK5TOlWlyVZj3cCfq4huOMdM/fOVVvXe/lzJbbiqbYnljd
         98wQ==
X-Gm-Message-State: AOAM531tPMCclNDLubJJ32zEnE4MUDaOW8xNtuvoe3caYGmymf3dTZ3A
        ut59uloFi58ntcLjI8rU8Jmc3xI3zxXMjQ==
X-Google-Smtp-Source: ABdhPJyu9GPWRJ4bILS+PFgYREbIq1KpOr7NQsuSIz7EM47FgVwe5lg7t2EgVfp652dJsUgXOUDiRA==
X-Received: by 2002:a17:90a:4311:: with SMTP id q17mr12501597pjg.204.1623883652182;
        Wed, 16 Jun 2021 15:47:32 -0700 (PDT)
Received: from ip-10-184-182-114.us-west-2.compute.internal (ec2-54-191-147-77.us-west-2.compute.amazonaws.com. [54.191.147.77])
        by smtp.gmail.com with ESMTPSA id p6sm6278672pjk.34.2021.06.16.15.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 15:47:31 -0700 (PDT)
From:   Zvi Effron <zeffron@riotgames.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Zvi Effron <zeffron@riotgames.com>
Subject: [PATCH bpf-next v5 0/4] bpf: support input xdp_md context in BPF_PROG_TEST_RUN
Date:   Wed, 16 Jun 2021 22:47:08 +0000
Message-Id: <20210616224712.3243-1-zeffron@riotgames.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset adds support for passing an xdp_md via ctx_in/ctx_out in
bpf_attr for BPF_PROG_TEST_RUN of XDP programs.

Patch 1 adds a function to validate XDP meta data lengths.

Patch 2 adds initial support for passing XDP meta data in addition to
packet data.

Patch 3 adds support for also specifying the ingress interface and
rx queue.

Patch 4 adds selftests to ensure functionality is correct.

Changelog:
----------
v4->v5
v4: https://lore.kernel.org/bpf/20210604220235.6758-1-zeffron@riotgames.com/

 * Add new patch to introduce xdp_metalen_valid inline function to avoid
  duplicated code from net/core/filter.c
 * Correct size of bad_ctx in selftests
 * Make all declarations reverse Christmas tree
 * Move data check from xdp_convert_md_to_buff to bpf_prog_test_run_xdp
 * Merge xdp_convert_buff_to_md into bpf_prog_test_run_xdp
 * Fix line too long
 * Extracted common checks in selftests to a helper function
 * Removed redundant assignment in selftests
 * Reordered test cases in selftests
 * Check data against 0 instead of data_meta in selftests
 * Made selftests use EINVAL instead of hardcoded 22
 * Dropped "_" from XDP function name
 * Changed casts in XDP program from unsigned long to long
 * Added a comment explaining the use of the loopback interface in selftests
 * Change parameter order in xdp_convert_md_to_buff to be input first
 * Assigned xdp->ingress_ifindex and xdp->rx_queue_index to local variables in
  xdp_convert_md_to_buff
 * Made use of "meta data" versus "metadata" consistent in comments and commit
  messages

v3->v4
v3: https://lore.kernel.org/bpf/20210602190815.8096-1-zeffron@riotgames.com/

 * Clean up nits
 * Validate xdp_md->data_end in bpf_prog_test_run_xdp
 * Remove intermediate metalen variables

v2 -> v3
v2: https://lore.kernel.org/bpf/20210527201341.7128-1-zeffron@riotgames.com/

 * Check errno first in selftests
 * Use DECLARE_LIBBPF_OPTS
 * Rename tattr to opts in selftests
 * Remove extra new line
 * Rename convert_xdpmd_to_xdpb to xdp_convert_md_to_buff
 * Rename convert_xdpb_to_xdpmd to xdp_convert_buff_to_md
 * Move declaration of device and rxqueue in xdp_convert_md_to_buff to
  patch 2
 * Reorder the kfree calls in bpf_prog_test_run_xdp

v1 -> v2
v1: https://lore.kernel.org/bpf/20210524220555.251473-1-zeffron@riotgames.com

 * Fix null pointer dereference with no context
 * Use the BPF skeleton and replace CHECK with ASSERT macros

Zvi Effron (4):
  bpf: add function for XDP meta data length check
  bpf: support input xdp_md context in BPF_PROG_TEST_RUN
  bpf: support specifying ingress via xdp_md context in
    BPF_PROG_TEST_RUN
  selftests/bpf: Add test for xdp_md context in BPF_PROG_TEST_RUN

 include/net/xdp.h                             |   5 +
 include/uapi/linux/bpf.h                      |   3 -
 net/bpf/test_run.c                            |  89 ++++++++++++++-
 net/core/filter.c                             |   4 +-
 .../bpf/prog_tests/xdp_context_test_run.c     | 105 ++++++++++++++++++
 .../bpf/progs/test_xdp_context_test_run.c     |  20 ++++
 6 files changed, 215 insertions(+), 11 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_context_test_run.c


base-commit: 1f26622b791b6a1b346d1dfd9d04450e20af0f41
-- 
2.31.1

