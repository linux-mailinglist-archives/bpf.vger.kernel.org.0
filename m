Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D558732C190
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441905AbhCCWvZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 17:51:25 -0500
Received: from mga14.intel.com ([192.55.52.115]:42575 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235302AbhCCQF5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Mar 2021 11:05:57 -0500
IronPort-SDR: O4Cko/TLlc61K2/oFbE1Xu3ZHNhztWAAsFV5EH37Bz4ld0MPuLVGaNtx/IRGG2jAmsguA7vql7
 VcQGCTx2s9Tw==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="186571029"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="186571029"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 08:01:51 -0800
IronPort-SDR: NYmeVEKGfcacvobMLtwkuyvOu/6PvxXY1HvfP92z8WNnbgn2aNijs34zVEEBXcmObtpKW5k4gt
 6xfSp0KBEuiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="445323923"
Received: from ranger.igk.intel.com ([10.102.21.164])
  by orsmga001.jf.intel.com with ESMTP; 03 Mar 2021 08:01:49 -0800
From:   Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To:     daniel@iogearbox.net, ast@kernel.org, bpf@vger.kernel.org
Cc:     bjorn.topel@intel.com, magnus.karlsson@intel.com,
        john.fastabend@gmail.com,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH bpf 0/3] AF_XDP small fixes
Date:   Wed,  3 Mar 2021 16:51:54 +0100
Message-Id: <20210303155158.15953-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

This time three no-brainers, one is a fix that I sent among with
bpf_link for AF_XDP set where John suggested that it should land in bpf
tree.

Other is the missing munmap on xdpsock and some ancient function
declaration removal.

Thanks!
Maciej

Maciej Fijalkowski (3):
  xsk: remove dangling function declaration from header file
  samples: bpf: add missing munmap in xdpsock
  libbpf: clear map_info before each bpf_obj_get_info_by_fd

 include/linux/netdevice.h  | 2 --
 samples/bpf/xdpsock_user.c | 2 ++
 tools/lib/bpf/xsk.c        | 5 +++--
 3 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.20.1

