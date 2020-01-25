Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B75D5149818
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2020 23:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgAYWbh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Jan 2020 17:31:37 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:39925 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727430AbgAYWbh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 25 Jan 2020 17:31:37 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 8B57A3DB;
        Sat, 25 Jan 2020 17:31:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 25 Jan 2020 17:31:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=MHaMt2bw1Y6x2
        UGDyINCj6XMZVOisVmJfKZYK+uFfdo=; b=eYaHFGvBau+ZxXOsa1alcJ6l4/27l
        RuV2zSiYyuQqWBxe4ykzh4d9tYQ8smS5y1FxaYn+qApRWyDZlQLbXJJyFcTXLGa6
        18pYrgJIW7mdL8kFYY/oRcG1IhCf1S7kyONal6RYYBbnKv3zPLnUnoSQ97kUOzfl
        rbW/kfmJVNLjIuwtIOLHn1B1hJeTXTZ2KFeuGu1Bo5CoOBUv2tzd0YCg3EqPFMcS
        duhAgLU6Kps57lJ5+9uvvs+DURdBEHjrSViyYO6UxZdK0rwCzqW6HsTIjZenM1md
        xvWzmOevGMctZSnbA+mot8qPc9VF/bH4jANMZbOyo/7ngZ8CU5gM0juyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=MHaMt2bw1Y6x2UGDyINCj6XMZVOisVmJfKZYK+uFfdo=; b=kKKDpn7f
        /m5J3tIt8xPQhtL6ggVWYhQJshn6KABCUtmrijxbyCtwQBOzmV+7ddFseuEteHfp
        RT518+X2t0sHPmF6VZ5GUEzBLtEm5sQakHmOz23Z5/2qW7jyd92ZfFLy86YUlvZG
        D5c+zbPWb6wqz4IzWS0rSPxfn8+QjxBqgTUn//99lZfFbZhq87ALyvGQva9FV0Qv
        frbezPFSMjlFhUseg4A+lMBAklSkVKSIOKQDQH9oUHp3U6XlhcXlJglWbu0Dl/Fj
        +WMxpJlqSC2tPJzqBZYECrlEBKUrQZoFZ7TZEV5XQ4xn+Uc9OpE3pGndV8ctU2Z8
        s6XYAgcpyq3i2g==
X-ME-Sender: <xms:x8EsXhUiHNDpOqhQeMk8CkLTdbukYtBxi-rRY_tNIZ8LBqJKbMgSzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrvdekgddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecukfhppeduleelrddvtddurdeigedrfeenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhu
    rdighiii
X-ME-Proxy: <xmx:x8EsXgB-hiGE1PltcU3FnMrSTOYWtTPtZUCYFc4JAXiwfBXIBIaCxw>
    <xmx:x8EsXgBWR3MrVfm9IFA0fJCdOOupKvOR8e4FSGanj92BjIPdSDjhNg>
    <xmx:x8EsXvqzGH_8I6nDK52LeUMYkC7-2FFoy6BOg654D3-SI0FUnBjBaQ>
    <xmx:x8EsXqX2B1tyj5_4WIDXP7a7GSByXafuZpIkAdIy-cpdEGvaaUjhxdTMeNs>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (prn-fbagreements-ext.thefacebook.com [199.201.64.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id A30E23280060;
        Sat, 25 Jan 2020 17:31:33 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org
Subject: [PATCH v5 bpf-next 1/2] bpf: Add bpf_read_branch_records() helper
Date:   Sat, 25 Jan 2020 14:31:16 -0800
Message-Id: <20200125223117.20813-2-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200125223117.20813-1-dxu@dxuuu.xyz>
References: <20200125223117.20813-1-dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Branch records are a CPU feature that can be configured to record
certain branches that are taken during code execution. This data is
particularly interesting for profile guided optimizations. perf has had
branch record support for a while but the data collection can be a bit
coarse grained.

We (Facebook) have seen in experiments that associating metadata with
branch records can improve results (after postprocessing). We generally
use bpf_probe_read_*() to get metadata out of userspace. That's why bpf
support for branch records is useful.

Aside from this particular use case, having branch data available to bpf
progs can be useful to get stack traces out of userspace applications
that omit frame pointers.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/uapi/linux/bpf.h | 25 +++++++++++++++++++++++-
 kernel/trace/bpf_trace.c | 41 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index f1d74a2bd234..332aa433d045 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2892,6 +2892,25 @@ union bpf_attr {
  *		Obtain the 64bit jiffies
  *	Return
  *		The 64 bit jiffies
+ *
+ * int bpf_read_branch_records(struct bpf_perf_event_data *ctx, void *buf, u32 buf_size, u64 flags)
+ *	Description
+ *		For an eBPF program attached to a perf event, retrieve the
+ *		branch records (struct perf_branch_entry) associated to *ctx*
+ *		and store it in	the buffer pointed by *buf* up to size
+ *		*buf_size* bytes.
+ *
+ *		The *flags* can be set to **BPF_F_GET_BRANCH_RECORDS_SIZE** to
+ *		instead	return the number of bytes required to store all the
+ *		branch entries. If this flag is set, *buf* may be NULL.
+ *	Return
+ *		On success, number of bytes written to *buf*. On error, a
+ *		negative value.
+ *
+ *		**-EINVAL** if arguments invalid or **buf_size** not a multiple
+ *		of sizeof(struct perf_branch_entry).
+ *
+ *		**-ENOENT** if architecture does not support branch records.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3012,7 +3031,8 @@ union bpf_attr {
 	FN(probe_read_kernel_str),	\
 	FN(tcp_send_ack),		\
 	FN(send_signal_thread),		\
-	FN(jiffies64),
+	FN(jiffies64),			\
+	FN(read_branch_records),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
@@ -3091,6 +3111,9 @@ enum bpf_func_id {
 /* BPF_FUNC_sk_storage_get flags */
 #define BPF_SK_STORAGE_GET_F_CREATE	(1ULL << 0)
 
+/* BPF_FUNC_read_branch_records flags. */
+#define BPF_F_GET_BRANCH_RECORDS_SIZE	(1ULL << 0)
+
 /* Mode for BPF_FUNC_skb_adjust_room helper. */
 enum bpf_adj_room_mode {
 	BPF_ADJ_ROOM_NET,
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 19e793aa441a..5a0ab7c9a1dc 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1028,6 +1028,45 @@ static const struct bpf_func_proto bpf_perf_prog_read_value_proto = {
          .arg3_type      = ARG_CONST_SIZE,
 };
 
+BPF_CALL_4(bpf_read_branch_records, struct bpf_perf_event_data_kern *, ctx,
+	   void *, buf, u32, size, u64, flags)
+{
+	struct perf_branch_stack *br_stack = ctx->data->br_stack;
+	u32 br_entry_size = sizeof(struct perf_branch_entry);
+	u32 to_copy;
+
+#ifndef CONFIG_X86
+	return -ENOENT;
+#endif
+
+	if (unlikely(flags & ~BPF_F_GET_BRANCH_RECORDS_SIZE))
+		return -EINVAL;
+
+	if (unlikely(!br_stack))
+		return -EINVAL;
+
+	if (flags & BPF_F_GET_BRANCH_RECORDS_SIZE)
+		return br_stack->nr * br_entry_size;
+
+	if (!buf || (size % br_entry_size != 0))
+		return -EINVAL;
+
+	to_copy = min_t(u32, br_stack->nr * br_entry_size, size);
+	memcpy(buf, br_stack->entries, to_copy);
+
+	return to_copy;
+}
+
+static const struct bpf_func_proto bpf_read_branch_records_proto = {
+	.func           = bpf_read_branch_records,
+	.gpl_only       = true,
+	.ret_type       = RET_INTEGER,
+	.arg1_type      = ARG_PTR_TO_CTX,
+	.arg2_type      = ARG_PTR_TO_MEM_OR_NULL,
+	.arg3_type      = ARG_CONST_SIZE_OR_ZERO,
+	.arg4_type      = ARG_ANYTHING,
+};
+
 static const struct bpf_func_proto *
 pe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -1040,6 +1079,8 @@ pe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_stack_proto_tp;
 	case BPF_FUNC_perf_prog_read_value:
 		return &bpf_perf_prog_read_value_proto;
+	case BPF_FUNC_read_branch_records:
+		return &bpf_read_branch_records_proto;
 	default:
 		return tracing_func_proto(func_id, prog);
 	}
-- 
2.21.1

