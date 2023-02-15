Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EEC697C67
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 13:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbjBOM5v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 07:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbjBOM5v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 07:57:51 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E35D4;
        Wed, 15 Feb 2023 04:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676465869; x=1708001869;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7dlWOH/Qpt7bh7ECKlipjSjpc/PPCjtj6keVbKZqS+Q=;
  b=jYq0bNDgMV4Je+0bvauAs4jDjK2PA1MI2IQz3YPyP7XN0K8aogl+7hiN
   4NZaoZPW3MCyIfbEcA9JErPHFnocJ8p/ejXknObQAKHEzT5pKd6ZjVuFN
   3UH1mVT/3tPHVqWx5izRM/d+bWNYkLvMTkgfW00XRg4/9h0xxcfdDLj9U
   eUPvDUoVEQ73XPLY5i+uagkTR7mi+vSjC/AyRzu0GyjgKkg7fWGlfg+UB
   70b/ZUjw+BIHOTKxeXDy2o1tnDjtZFCNyRPVYq3xG7X+sVP841W5OPqmQ
   sdLHYRvzysvzMv5LkZhelEy7t2dCSytX+NtJnZYPADFR68aogvTQTdWyZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="393822004"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="393822004"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 04:57:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="998478588"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="998478588"
Received: from unknown (HELO paamrpdk12-S2600BPB.aw.intel.com) ([10.228.151.145])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 04:57:47 -0800
From:   Tirthendu Sarkar <tirthendu.sarkar@intel.com>
To:     intel-wired-lan@lists.osuosl.org
Cc:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
        tirthendu.sarkar@intel.com
Subject: [PATCH intel-next v4 0/8] i40e: support XDP multi-buffer
Date:   Wed, 15 Feb 2023 18:12:57 +0530
Message-Id: <20230215124305.76075-1-tirthendu.sarkar@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset adds multi-buffer support for XDP. Tx side already has
support for multi-buffer. This patchset focuses on Rx side. The last
patch contains actual multi-buffer changes while the previous ones are
preparatory patches.

On receiving the first buffer of a packet, xdp_buff is built and its
subsequent buffers are added to it as frags. While 'next_to_clean' keeps
pointing to the first descriptor, the newly introduced 'next_to_process'
keeps track of every descriptor for the packet. 

On receiving EOP buffer the XDP program is called and appropriate action
is taken (building skb for XDP_PASS, reusing page for XDP_DROP, adjusting
page offsets for XDP_{REDIRECT,TX}).

The patchset also streamlines page offset adjustments for buffer reuse
to make it easier to post process the rx_buffers after running XDP prog.

With this patchset there does not seem to be any performance degradation
for XDP_PASS and some improvement (~1% for XDP_TX, ~5% for XDP_DROP) when
measured using xdp_rxq_info program from samples/bpf/ for 64B packets.

Changelog:
    v3 -> v4:
    - Added non-linear XDP buffer support to xdp_features. [Maciej]
    - Removed double space. [Maciej]

    v2 -> v3:
    - Fixed buffer cleanup for single buffer packets on skb alloc
      failure.
    - Better naming of cleanup function.
    - Stop incrementing nr_frags for overflowing packets.
 
    v1 -> v2:
    - Instead of building xdp_buff on eop now it is built incrementally.
    - xdp_buff is now added to i40e_ring struct for preserving across
      napi calls. [Alexander Duyck]
    - Post XDP program rx_buffer processing has been simplified.
    - Rx buffer allocation pull out is reverted to avoid performance 
      issues for smaller ring sizes and now done when at least half of
      the ring has been cleaned. With v1 there was ~75% drop for
      XDP_PASS with the smallest ring size of 64 which is mitigated by
      v2 [Alexander Duyck]
    - Instead of retrying skb allocation on previous failure now the
      packet is dropped. [Maciej]
    - Simplified page offset adjustments by using xdp->frame_sz instead
      of recalculating truesize. [Maciej]
    - Change i40e_trace() to use xdp instead of skb [Maciej]
    - Reserve tailroom for legacy-rx [Maciej]
    - Centralize max frame size calculation

Tirthendu Sarkar (8):
  i40e: consolidate maximum frame size calculation for vsi
  i40e: change Rx buffer size for legacy-rx to support XDP multi-buffer
  i40e: add pre-xdp page_count in rx_buffer
  i40e: Change size to truesize when using i40e_rx_buffer_flip()
  i40e: use frame_sz instead of recalculating truesize for building skb
  i40e: introduce next_to_process to i40e_ring
  i40e: add xdp_buff to i40e_ring struct
  i40e: add support for XDP multi-buffer Rx

 drivers/net/ethernet/intel/i40e/i40e_main.c  |  78 ++--
 drivers/net/ethernet/intel/i40e/i40e_trace.h |  20 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c  | 420 +++++++++++--------
 drivers/net/ethernet/intel/i40e/i40e_txrx.h  |  21 +-
 4 files changed, 307 insertions(+), 232 deletions(-)

-- 
2.34.1

