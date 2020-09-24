Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AED0277B7E
	for <lists+bpf@lfdr.de>; Fri, 25 Sep 2020 00:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgIXWHk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 18:07:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:46750 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbgIXWHk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 18:07:40 -0400
IronPort-SDR: V8MR3WtFMFxN5oYu6Oa1IKNnBVbc6LkhcEyIcmYKHYI6B9NY2dV+uXN8H8b39tab4X8lf3tUJS
 hcgJS5Ozkvng==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="222953222"
X-IronPort-AV: E=Sophos;i="5.77,299,1596524400"; 
   d="scan'208";a="222953222"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 15:07:39 -0700
IronPort-SDR: pv/hAisJv4x08MoK2fEGrqHKsRSEz/rnBUJiPRqXpuXzsIhfAdW4NfCGOk8ZGeNlkkMYcF1kp8
 jZrjfALbf4Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,299,1596524400"; 
   d="scan'208";a="339229731"
Received: from bpujari-bxdsw.sc.intel.com ([10.232.14.242])
  by orsmga008.jf.intel.com with ESMTP; 24 Sep 2020 15:07:38 -0700
From:   bimmy.pujari@intel.com
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, mchehab@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, maze@google.com,
        bimmy.pujari@intel.com, ashkan.nikravesh@intel.com
Subject: [PATCH bpf-next v5] bpf: Add bpf_ktime_get_real_ns
Date:   Thu, 24 Sep 2020 15:07:36 -0700
Message-Id: <20200924220736.23002-1-bimmy.pujari@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Bimmy Pujari <bimmy.pujari@intel.com>

The existing bpf helper functions to get timestamp return the time
elapsed since system boot. This timestamp is not particularly useful
where epoch timestamp is required or more than one server is involved
and time sync is required. Instead, you want to use CLOCK_REALTIME,
which provides epoch timestamp. Hence adding a new helper function
bfp_ktime_get_real_ns() based around CLOCK_REALTIME.

Signed-off-by: Ashkan Nikravesh <ashkan.nikravesh@intel.com>
Signed-off-by: Bimmy Pujari <bimmy.pujari@intel.com>
---
 drivers/media/rc/bpf-lirc.c    |  2 ++
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       |  8 ++++++++
 kernel/bpf/core.c              |  1 +
 kernel/bpf/helpers.c           | 13 +++++++++++++
 kernel/trace/bpf_trace.c       |  2 ++
 tools/include/uapi/linux/bpf.h |  8 ++++++++
 7 files changed, 35 insertions(+)

diff --git a/drivers/media/rc/bpf-lirc.c b/drivers/media/rc/bpf-lirc.c
index 3fe3edd80876..fe0fd07a473f 100644
--- a/drivers/media/rc/bpf-lirc.c
+++ b/drivers/media/rc/bpf-lirc.c
@@ -105,6 +105,8 @@ lirc_mode2_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_ktime_get_ns_proto;
 	case BPF_FUNC_ktime_get_boot_ns:
 		return &bpf_ktime_get_boot_ns_proto;
+	case BPF_FUNC_ktime_get_real_ns:
+		return &bpf_ktime_get_real_ns_proto;
 	case BPF_FUNC_tail_call:
 		return &bpf_tail_call_proto;
 	case BPF_FUNC_get_prandom_u32:
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index fc5c901c7542..18c4fdce65c8 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1757,6 +1757,7 @@ extern const struct bpf_func_proto bpf_get_numa_node_id_proto;
 extern const struct bpf_func_proto bpf_tail_call_proto;
 extern const struct bpf_func_proto bpf_ktime_get_ns_proto;
 extern const struct bpf_func_proto bpf_ktime_get_boot_ns_proto;
+extern const struct bpf_func_proto bpf_ktime_get_real_ns_proto;
 extern const struct bpf_func_proto bpf_get_current_pid_tgid_proto;
 extern const struct bpf_func_proto bpf_get_current_uid_gid_proto;
 extern const struct bpf_func_proto bpf_get_current_comm_proto;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index a22812561064..198e69a6508d 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3586,6 +3586,13 @@ union bpf_attr {
  * 		the data in *dst*. This is a wrapper of **copy_from_user**\ ().
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ *
+ * u64 bpf_ktime_get_real_ns(void)
+ *	Description
+ *		Return the real time in nanoseconds.
+ *		See: **clock_gettime**\ (**CLOCK_REALTIME**)
+ *	Return
+ *		Current *ktime*.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3737,6 +3744,7 @@ union bpf_attr {
 	FN(inode_storage_delete),	\
 	FN(d_path),			\
 	FN(copy_from_user),		\
+	FN(ktime_get_real_ns),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index c4811b139caa..0dbbda9b743b 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2208,6 +2208,7 @@ const struct bpf_func_proto bpf_get_smp_processor_id_proto __weak;
 const struct bpf_func_proto bpf_get_numa_node_id_proto __weak;
 const struct bpf_func_proto bpf_ktime_get_ns_proto __weak;
 const struct bpf_func_proto bpf_ktime_get_boot_ns_proto __weak;
+const struct bpf_func_proto bpf_ktime_get_real_ns_proto __weak;
 
 const struct bpf_func_proto bpf_get_current_pid_tgid_proto __weak;
 const struct bpf_func_proto bpf_get_current_uid_gid_proto __weak;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 5cc7425ee476..300db9269996 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -166,6 +166,17 @@ const struct bpf_func_proto bpf_ktime_get_boot_ns_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 };
+BPF_CALL_0(bpf_ktime_get_real_ns)
+{
+	/* NMI safe access to clock realtime */
+	return ktime_get_real_fast_ns();
+}
+
+const struct bpf_func_proto bpf_ktime_get_real_ns_proto = {
+	.func		= bpf_ktime_get_real_ns,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+};
 
 BPF_CALL_0(bpf_get_current_pid_tgid)
 {
@@ -657,6 +668,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_ktime_get_ns_proto;
 	case BPF_FUNC_ktime_get_boot_ns:
 		return &bpf_ktime_get_boot_ns_proto;
+	case BPF_FUNC_ktime_get_real_ns:
+		return &bpf_ktime_get_real_ns_proto;
 	case BPF_FUNC_ringbuf_output:
 		return &bpf_ringbuf_output_proto;
 	case BPF_FUNC_ringbuf_reserve:
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 36508f46a8db..8ea2a0e50041 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1167,6 +1167,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_ktime_get_ns_proto;
 	case BPF_FUNC_ktime_get_boot_ns:
 		return &bpf_ktime_get_boot_ns_proto;
+	case BPF_FUNC_ktime_get_real_ns:
+		return &bpf_ktime_get_real_ns_proto;
 	case BPF_FUNC_tail_call:
 		return &bpf_tail_call_proto;
 	case BPF_FUNC_get_current_pid_tgid:
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index a22812561064..198e69a6508d 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3586,6 +3586,13 @@ union bpf_attr {
  * 		the data in *dst*. This is a wrapper of **copy_from_user**\ ().
  * 	Return
  * 		0 on success, or a negative error in case of failure.
+ *
+ * u64 bpf_ktime_get_real_ns(void)
+ *	Description
+ *		Return the real time in nanoseconds.
+ *		See: **clock_gettime**\ (**CLOCK_REALTIME**)
+ *	Return
+ *		Current *ktime*.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3737,6 +3744,7 @@ union bpf_attr {
 	FN(inode_storage_delete),	\
 	FN(d_path),			\
 	FN(copy_from_user),		\
+	FN(ktime_get_real_ns),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.17.1

