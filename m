Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB6232C192
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445485AbhCCWvg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 17:51:36 -0500
Received: from mga14.intel.com ([192.55.52.115]:42559 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235237AbhCCQF5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Mar 2021 11:05:57 -0500
IronPort-SDR: P681GkAizM32eNqjEqUMR+5Z7a3Q9J28KxukXzQCX3mkzeHNhFjW5aAmQF3lPE6dU9VkYSEcxH
 Kca0pczKrIcw==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="186571043"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="186571043"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 08:01:55 -0800
IronPort-SDR: YA81s8hQgCDP8PgteyGBgaAF/2iLH8hitk1E9+xokrTtPUsZeKzm1py0Iq6cTpxwLdqJvk1SOu
 UgcCUW/WIc+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="445323963"
Received: from ranger.igk.intel.com ([10.102.21.164])
  by orsmga001.jf.intel.com with ESMTP; 03 Mar 2021 08:01:53 -0800
From:   Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To:     daniel@iogearbox.net, ast@kernel.org, bpf@vger.kernel.org
Cc:     bjorn.topel@intel.com, magnus.karlsson@intel.com,
        john.fastabend@gmail.com,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH bpf 2/3] samples: bpf: add missing munmap in xdpsock
Date:   Wed,  3 Mar 2021 16:51:56 +0100
Message-Id: <20210303155158.15953-3-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210303155158.15953-1-maciej.fijalkowski@intel.com>
References: <20210303155158.15953-1-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We mmap the umem region, but we never munmap it.
Add the missing call at the end of the cleanup.

Fixes: 3945b37a975d ("samples/bpf: use hugepages in xdpsock app")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 samples/bpf/xdpsock_user.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/samples/bpf/xdpsock_user.c b/samples/bpf/xdpsock_user.c
index db0cb73513a5..1e2a1105d0e6 100644
--- a/samples/bpf/xdpsock_user.c
+++ b/samples/bpf/xdpsock_user.c
@@ -1699,5 +1699,7 @@ int main(int argc, char **argv)
 
 	xdpsock_cleanup();
 
+	munmap(bufs, NUM_FRAMES * opt_xsk_frame_size);
+
 	return 0;
 }
-- 
2.20.1

