Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83EFB300316
	for <lists+bpf@lfdr.de>; Fri, 22 Jan 2021 13:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbhAVMcw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jan 2021 07:32:52 -0500
Received: from mga11.intel.com ([192.55.52.93]:31333 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727364AbhAVMcj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jan 2021 07:32:39 -0500
IronPort-SDR: QRm3okV+xeqptNytfnW0wq+5GGwc8GsK9tX2IZ/mhYULb/K0lnN1o67zBxV4lfUfrVItKRVLuX
 U3no3Bj49qRw==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="175927663"
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="175927663"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 04:30:41 -0800
IronPort-SDR: uBVrSlQRMN/Wxt2zRSFR7E76RsH9hsyGA+ovXv0UiNK4th1b1gegW9JUEYhv/AfBua00CQUTnF
 wVcigEihKHzw==
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="385741921"
Received: from rbentoli-mobl1.ger.corp.intel.com (HELO outtakka.ger.corp.intel.com) ([10.251.187.124])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 04:30:12 -0800
From:   Mikko Ylinen <mikko.ylinen@linux.intel.com>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kpsingh@google.com, daniel@iogearbox.net
Subject: [PATCH] bpf: Drop disabled LSM hooks from the sleepable set
Date:   Fri, 22 Jan 2021 14:30:03 +0200
Message-Id: <20210122123003.46125-1-mikko.ylinen@linux.intel.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Networking LSM hooks are conditionally enabled and when building the new
sleepable BPF LSM hooks with the networking LSM hooks disabled, the
following build error occurs:

BTFIDS  vmlinux
FAILED unresolved symbol bpf_lsm_socket_socketpair

To fix the error, conditionally add the networking LSM hooks to the
sleepable set.

Fixes: 423f16108c9d8 ("bpf: Augment the set of sleepable LSM hooks")
Signed-off-by: Mikko Ylinen <mikko.ylinen@linux.intel.com>
---
 kernel/bpf/bpf_lsm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 70e5e0b6d69d..5041dd35f2a6 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -149,7 +149,11 @@ BTF_ID(func, bpf_lsm_file_ioctl)
 BTF_ID(func, bpf_lsm_file_lock)
 BTF_ID(func, bpf_lsm_file_open)
 BTF_ID(func, bpf_lsm_file_receive)
+
+#ifdef CONFIG_SECURITY_NETWORK
 BTF_ID(func, bpf_lsm_inet_conn_established)
+#endif /* CONFIG_SECURITY_NETWORK */
+
 BTF_ID(func, bpf_lsm_inode_create)
 BTF_ID(func, bpf_lsm_inode_free_security)
 BTF_ID(func, bpf_lsm_inode_getattr)
@@ -181,6 +185,8 @@ BTF_ID(func, bpf_lsm_sb_show_options)
 BTF_ID(func, bpf_lsm_sb_statfs)
 BTF_ID(func, bpf_lsm_sb_umount)
 BTF_ID(func, bpf_lsm_settime)
+
+#ifdef CONFIG_SECURITY_NETWORK
 BTF_ID(func, bpf_lsm_socket_accept)
 BTF_ID(func, bpf_lsm_socket_bind)
 BTF_ID(func, bpf_lsm_socket_connect)
@@ -195,6 +201,8 @@ BTF_ID(func, bpf_lsm_socket_recvmsg)
 BTF_ID(func, bpf_lsm_socket_sendmsg)
 BTF_ID(func, bpf_lsm_socket_shutdown)
 BTF_ID(func, bpf_lsm_socket_socketpair)
+#endif /* CONFIG_SECURITY_NETWORK */
+
 BTF_ID(func, bpf_lsm_syslog)
 BTF_ID(func, bpf_lsm_task_alloc)
 BTF_ID(func, bpf_lsm_task_getsecid)
-- 
2.17.1

