Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487D26DFB2D
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 18:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjDLQVi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 12:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjDLQVd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 12:21:33 -0400
Received: from mail-lj1-x263.google.com (mail-lj1-x263.google.com [IPv6:2a00:1450:4864:20::263])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEB87DA8
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 09:21:28 -0700 (PDT)
Received: by mail-lj1-x263.google.com with SMTP id j11so53283ljq.10
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 09:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1681316486; x=1683908486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VJnf5BgsQnmdIKhphEaZcsTEPtdwY1zYSnMDCdjCUVw=;
        b=P5z6tcoaM4hHyR+7iAVVlydcBID3Q0fzoYzWIrIkvr67V2RLOcghssify2BsGcJlLw
         fdDH3BXzx33kT44Ta9mLF+ujhom59gyPv4hH2eCWgab/0HsJ3VIAqXmdgddXU+fY/Jyn
         HN5Jfvem6v52jI7aYHC90vAiYh2cUNdU0T6L0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681316486; x=1683908486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VJnf5BgsQnmdIKhphEaZcsTEPtdwY1zYSnMDCdjCUVw=;
        b=kRv2GTHB9aVt2eJDfrx0mJ0M/ntAQWql9Qlxi31dYriIZGI+qo67tvk5zmWGchuKfC
         Nz5eCBrh8DrDlVfnMMJDePDSzzFvHR5X5t0oaZ+EszD5IJQdkJby+Nlydm2RUIxx2JOg
         WOmkUx9jq+52gRPU8gL0ctpwFjn7xbHVt8Q60MrVhAfoWT1MNIjN6pvh9bkPcGZG0PEY
         nj2oXvAzesNwt9bOGWH207oSDYeQc7LYMVL77eIZ4eonkb0UtC4vpRNjhP9Wx2ZZq49V
         PCRPMTYjO77XZmDcAdHDFDr/YzmidOoVLWzBnOpRc4g7vlRhKb8QaUcRXdod7cO2f4Be
         fw7Q==
X-Gm-Message-State: AAQBX9ddQB3eLkIupXcmcTqxl8qHzLiAeFgVfOhLOO7xqrP33rnSWjyK
        IHT5qDxhbgYrLa9vAgdTdE8ia9sWizWZGadRzy2cstm9o+yF
X-Google-Smtp-Source: AKy350Zi4Leo4nsmxQN3QQ4BHo5IOjZSh0jCspyOUnAKnD7rEab4gsM/B9HMqV1rIRGoD7s/1fj9EyAYqBCM
X-Received: by 2002:a05:651c:c5:b0:29c:921c:4eb0 with SMTP id 5-20020a05651c00c500b0029c921c4eb0mr2096893ljr.22.1681316486183;
        Wed, 12 Apr 2023 09:21:26 -0700 (PDT)
Received: from fedora.dectris.local (dect-ch-bad-pfw.cyberlink.ch. [62.12.151.50])
        by smtp-relay.gmail.com with ESMTPS id t19-20020a2e8e73000000b002a77614d960sm2108109ljk.62.2023.04.12.09.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 09:21:26 -0700 (PDT)
X-Relaying-Domain: dectris.com
From:   Kal Conley <kal.conley@dectris.com>
To:     Magnus Karlsson <magnus.karlsson@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Kal Conley <kal.conley@dectris.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH bpf-next v6 0/4] xsk: Support UMEM chunk_size > PAGE_SIZE
Date:   Wed, 12 Apr 2023 18:21:10 +0200
Message-Id: <20230412162114.19389-1-kal.conley@dectris.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The main purpose of this patchset is to add AF_XDP support for UMEM
chunk sizes > PAGE_SIZE. This is enabled for UMEMs backed by HugeTLB
pages.

Changes since v5:
  * Fix nits from Magnus.

Changes since v4:
  * Use hugepages in DMA map (fixes zero-copy mode with IOMMU).
  * Use pool->dma_pages to check for DMA. This change is needed to avoid
    performance regressions).
  * Update commit message and benchmark table.

Changes since v3:
  * Fix checkpatch.pl whitespace error.

Changes since v2:
  * Related fixes/improvements included with v2 have been removed. These
    changes have all been resubmitted as standalone patchsets.
  * Minimize uses of #ifdef CONFIG_HUGETLB_PAGE.
  * Improve AF_XDP documentation.
  * Update benchmark table in commit message.

Changes since v1:
  * Add many fixes/improvements to the XSK selftests.
  * Add check for unaligned descriptors that overrun UMEM.
  * Fix compile errors when CONFIG_HUGETLB_PAGE is not set.
  * Fix incorrect use of _Static_assert.
  * Update AF_XDP documentation.
  * Rename unaligned 9K frame size test.
  * Make xp_check_dma_contiguity less conservative.
  * Add more information to benchmark table.

Thanks to Magnus Karlsson for all his feedback!

Kal Conley (4):
  xsk: Use pool->dma_pages to check for DMA
  xsk: Support UMEM chunk_size > PAGE_SIZE
  selftests: xsk: Use hugepages when umem->frame_size > PAGE_SIZE
  selftests: xsk: Add tests for 8K and 9K frame sizes

 Documentation/networking/af_xdp.rst      | 36 ++++++++++------
 include/net/xdp_sock.h                   |  2 +
 include/net/xdp_sock_drv.h               | 12 ++++++
 include/net/xsk_buff_pool.h              | 12 +++---
 net/xdp/xdp_umem.c                       | 55 +++++++++++++++++++-----
 net/xdp/xsk_buff_pool.c                  | 41 +++++++++++-------
 tools/testing/selftests/bpf/xskxceiver.c | 27 +++++++++++-
 tools/testing/selftests/bpf/xskxceiver.h |  2 +
 8 files changed, 141 insertions(+), 46 deletions(-)

-- 
2.39.2

