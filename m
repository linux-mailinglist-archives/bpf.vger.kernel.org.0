Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB4F32C1EA
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449676AbhCCWxd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 17:53:33 -0500
Received: from mga07.intel.com ([134.134.136.100]:62503 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350822AbhCCTIL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Mar 2021 14:08:11 -0500
IronPort-SDR: x9tllSlKWdKVsWhpLQw0xse21Wc15Z2CsnlVX/XvO5gd/oz7gQcG4WgXyk5djjZlDPkOY1ZzNN
 CR6fuSwe6vTQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="251309594"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="251309594"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 11:06:41 -0800
IronPort-SDR: DULWIvovyuAUVokbCCW2EkUi9MXWjTBgyKQoNAY4zpZXYOgo0Rk42/1lOjXlJnU3MqhId29VSO
 o5BvTVqy8BlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="506992654"
Received: from ranger.igk.intel.com ([10.102.21.164])
  by fmsmga001.fm.intel.com with ESMTP; 03 Mar 2021 11:06:39 -0800
From:   Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To:     daniel@iogearbox.net, ast@kernel.org, bpf@vger.kernel.org
Cc:     bjorn.topel@intel.com, magnus.karlsson@intel.com,
        john.fastabend@gmail.com,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH bpf v2 2/3] samples: bpf: add missing munmap in xdpsock
Date:   Wed,  3 Mar 2021 19:56:35 +0100
Message-Id: <20210303185636.18070-3-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210303185636.18070-1-maciej.fijalkowski@intel.com>
References: <20210303185636.18070-1-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We mmap the umem region, but we never munmap it.
Add the missing call at the end of the cleanup.

Fixes: 3945b37a975d ("samples/bpf: use hugepages in xdpsock app")
Acked-by: Björn Töpel <bjorn.topel@intel.com>
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

