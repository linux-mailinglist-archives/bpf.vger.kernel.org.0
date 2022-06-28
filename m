Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786AB55E9D5
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 18:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbiF1Qeu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 12:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiF1QeC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 12:34:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A91327FEF
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 09:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656433838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6NFHPYEx6LcCoCFgUJZqyB8qmbXcNWPDPiDpj5XQCFM=;
        b=ZruP4wcY00A/TsoGXydLZNJxiz/U20Cft0onequbxhCsQ2EF8lim5mYZj7nAYyaJgCp/Cy
        T2aPCWoCQvRPtDJLcF2vOOpaA8wQtrqme+/yjw9I63LRssDYUXCYOuG3d8ijfTP/mboJDs
        /2Xxp0SH1noKWRTIc75H0GcS3H7RI0o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-FyViuAiBN9iUFauAVzNXJw-1; Tue, 28 Jun 2022 12:30:35 -0400
X-MC-Unique: FyViuAiBN9iUFauAVzNXJw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DBB5D101A589;
        Tue, 28 Jun 2022 16:30:34 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E934492C3B;
        Tue, 28 Jun 2022 16:30:34 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id 9DECB30736C72;
        Tue, 28 Jun 2022 18:30:33 +0200 (CEST)
Subject: [PATCH RFC bpf-next 0/9] Introduce XDP-hints via BTF
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     bpf@vger.kernel.org
Cc:     xdp-hints@xdp-project.net,
        Jesper Dangaard Brouer <brouer@redhat.com>
Date:   Tue, 28 Jun 2022 18:30:33 +0200
Message-ID: <165643378969.449467.13237011812569188299.stgit@firesoul>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset expose the traditional hardware offload hints to XDP and
rely on BTF to expose the layout to users.  More advanced use-case with
driver specific offloads will likely be in followup patches.

The users/consumers are (as described in [1]):
 - XDP BPF-progs
 - XDP to SKB conversion gaining HW offloads
 - AF_XDP can consume BTF info in userspace
 - Chained BPF-progs can communicate state via metadata

This is still RFC as the following features are missing:
 - Exposing XDP-hints indication in AF_XDP descriptor
 - Exporting what XDP-hints structs are avail per driver

Two drivers i40e and mvneta gets XDP-hints in this patchset.

[1] https://github.com/xdp-project/xdp-project/blob/master/conference/LLC2022/xdp_hints_hw_metadata-final.pdf

---

Jesper Dangaard Brouer (8):
      i40e: Refactor i40e_ptp_rx_hwtstamp
      bpf: export btf functions for modules
      net: create xdp_hints_common and set functions
      net: add net_device feature flag for XDP-hints
      xdp: controlling XDP-hints from BPF-prog via helper
      i40e: refactor i40e_rx_checksum with helper
      i40e: add XDP-hints handling
      net: use XDP-hints in xdp_frame to SKB conversion

Lorenzo Bianconi (1):
      mvneta: add XDP-hints support


 drivers/net/ethernet/intel/i40e/i40e.h      |   1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c |  34 +++
 drivers/net/ethernet/intel/i40e/i40e_ptp.c  |  36 +++-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 222 ++++++++++++++++----
 drivers/net/ethernet/marvell/mvneta.c       |  61 +++++-
 include/linux/btf.h                         |   2 +
 include/linux/netdev_features.h             |   3 +-
 include/net/xdp.h                           | 181 +++++++++++++++-
 include/uapi/linux/bpf.h                    |  43 ++++
 kernel/bpf/btf.c                            |  13 +-
 net/core/filter.c                           |  45 ++++
 net/core/xdp.c                              |  73 ++++++-
 net/ethtool/common.c                        |   1 +
 13 files changed, 644 insertions(+), 71 deletions(-)

--

