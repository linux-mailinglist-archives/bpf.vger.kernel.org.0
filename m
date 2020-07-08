Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451A32181BE
	for <lists+bpf@lfdr.de>; Wed,  8 Jul 2020 09:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgGHHu2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Jul 2020 03:50:28 -0400
Received: from mga02.intel.com ([134.134.136.20]:60432 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgGHHu2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Jul 2020 03:50:28 -0400
IronPort-SDR: 1jr0OJzVcjEXs4LlH1EfKowfoSILt183vlcOANpA7q7gRp7u+wOrK1YvUJVfB75WUwOaN3sCnl
 x3qMruRkmHfA==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="135988077"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="135988077"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 00:50:27 -0700
IronPort-SDR: HyyQCWE+WpkWAOTRdWuznlKzzXXYr3BlywATezcFIlaxa3L8ya6aPccGOUq55zp/Q8R4jH+JxJ
 gV0/ZQtHIy+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="358030305"
Received: from silpixa00399839.ir.intel.com (HELO localhost.localdomain) ([10.237.222.116])
  by orsmga001.jf.intel.com with ESMTP; 08 Jul 2020 00:50:26 -0700
From:   Ciara Loftus <ciara.loftus@intel.com>
To:     bpf@vger.kernel.org, bjorn.topel@intel.com,
        magnus.karlsson@intel.com
Cc:     Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH bpf-next 0/3] xsk: add new statistics
Date:   Wed,  8 Jul 2020 07:28:32 +0000
Message-Id: <20200708072835.4427-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series introduces new statistics for af_xdp:
1. drops due to rx ring being full
2. drops due to fill ring being empty
3. failures pulling an item from the tx ring

These statistics should assist users debugging and troubleshooting
peformance issues and packet drops.

The statistics are made available though the getsockopt and xsk_diag
interfaces, and the ability to dump these extended statistics is made
available in the xdpsock application via the --extra-stats or -x flag.

A separate patch which will add ss/iproute2 support will follow.

Ciara Loftus (3):
  xsk: add new statistics
  samples: bpf: add an option for printing extra statistics in xdpsock
  xsk: add xdp statistics to xsk_diag

 include/net/xdp_sock.h            |  4 ++
 include/uapi/linux/if_xdp.h       |  5 +-
 include/uapi/linux/xdp_diag.h     | 11 ++++
 net/xdp/xsk.c                     | 36 +++++++++++--
 net/xdp/xsk_buff_pool.c           |  1 +
 net/xdp/xsk_diag.c                | 17 ++++++
 net/xdp/xsk_queue.h               |  6 +++
 samples/bpf/xdpsock_user.c        | 87 ++++++++++++++++++++++++++++++-
 tools/include/uapi/linux/if_xdp.h |  5 +-
 9 files changed, 163 insertions(+), 9 deletions(-)

-- 
2.17.1

