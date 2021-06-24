Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B420B3B3865
	for <lists+bpf@lfdr.de>; Thu, 24 Jun 2021 23:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbhFXVPd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Jun 2021 17:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbhFXVPc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Jun 2021 17:15:32 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718F0C061756
        for <bpf@vger.kernel.org>; Thu, 24 Jun 2021 14:13:13 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id t19-20020a17090ae513b029016f66a73701so6686741pjy.3
        for <bpf@vger.kernel.org>; Thu, 24 Jun 2021 14:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3FoPLVrMLmOXEeEmO52U5Q60AKREHOODGm7fxqjZuZk=;
        b=j2M/9bEiqWhmy56pWT6OU6OpiLn89V3BLMo/PxSboHtfBJCEPm7WtrZUXfnBxzuaI/
         h3ru6SMe4vnyM9MJYo9na6CZ1Ww2hF2r7lWqbHXRHbAMiHVyTAuGFUoFetlfdVLWL2YZ
         5uJKgvOGzYCQ0BdDRC4ZOVBdtgOG5Uy3AP89Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3FoPLVrMLmOXEeEmO52U5Q60AKREHOODGm7fxqjZuZk=;
        b=ayw7+uIp6RcMCuN/ym6EhgOHJY/oGJEBzY2cbUWJ3a8InNkFJnv7erow3YVW1o+IKg
         n90Hfr5RzOuCoSsDv13e2lnwlUDwXzloN6RVyf4pCOAw/rSSciy+Kc3ljfuoihDAf0i2
         WL9CRk426ig+yl8oxFXN/MvtCEd6wri+wAge485isnVuyKL4lXYtX8KTmZGR+TxzfZxs
         lFwUk3ADmyJVfPPA2DgY6GzYRdX7ewzKeKqAkUiwvSuhdM4avYjjZ2Xub0mR89+63u43
         aMQKRif1OeH5k+HtOIolLy86XiV3lD81JgYVstFxysf6tBOasCFlttUv27m9Plw37Cbd
         dKVA==
X-Gm-Message-State: AOAM533ektqrWaSrX045H/txX0KVaZ0GICgjL313A26J2Km1x9G246HI
        7fqdI3G0ThtRAidcJbUTKT2X441HQsrXURHE
X-Google-Smtp-Source: ABdhPJwVOGMoB7gpWnTJqd6FINoevRUwPxFyo0rbKrjqNVI7PLKsX130PGThgPhU54xD94Wgl9QSrA==
X-Received: by 2002:a17:902:e810:b029:121:94ea:909c with SMTP id u16-20020a170902e810b029012194ea909cmr5956428plg.17.1624569191050;
        Thu, 24 Jun 2021 14:13:11 -0700 (PDT)
Received: from ip-10-184-182-114.us-west-2.compute.internal (ec2-54-191-147-77.us-west-2.compute.amazonaws.com. [54.191.147.77])
        by smtp.gmail.com with ESMTPSA id d13sm3615394pfn.136.2021.06.24.14.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 14:13:10 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 0/4] bpf: support input xdp_md context in BPF_PROG_TEST_RUN
Date:   Thu, 24 Jun 2021 21:13:00 +0000
Message-Id: <20210624211304.90807-1-zeffron@riotgames.com>
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
v6->v7
v6: https://lore.kernel.org/bpf/20210617232904.1899-1-zeffron@riotgames.com/

 * Add Yonghong Song's Acked-by to commit message in patch 1
 * Add Yonghong Song's Acked-by to commit message in patch 2
 * Extracted the post-update of the xdp_md context into a function (again)
 * Validate that the rx queue was registered with XDP info
 * Decrement the reference count on a found netdevice on failure to find
  a valid rx queue
 * Decrement the reference count on a found netdevice after the XDP
  program is run
 * Drop Yonghong Song's Acked-By for patch 3 because of patch changes
 * Improve a comment in the selftests
 * Drop Yonghong Song's Acked-By for patch 4 because of patch changes

v5->v6
v5: https://lore.kernel.org/bpf/20210616224712.3243-1-zeffron@riotgames.com/

 * Correct commit messages in patches 1 and 3
 * Add Acked-by to commit message in patch 4
 * Use gotos instead of returns to correctly free resources in
  bpf_prog_test_run_xdp
 * Rename xdp_metalen_valid to xdp_metalen_invalid
 * Improve the function signature for xdp_metalen_invalid
 * Merged declaration of ingress_ifindex and rx_queue_index into one line

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
 net/bpf/test_run.c                            | 107 ++++++++++++++++--
 net/core/filter.c                             |   4 +-
 .../bpf/prog_tests/xdp_context_test_run.c     | 105 +++++++++++++++++
 .../bpf/progs/test_xdp_context_test_run.c     |  20 ++++
 6 files changed, 231 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_context_test_run.c


base-commit: ee62a5c6bb100b6fb07f3da3818c10a24d440e10
-- 
2.31.1

