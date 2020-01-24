Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB750149002
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2020 22:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387404AbgAXVRW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jan 2020 16:17:22 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:57549 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727295AbgAXVRW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 24 Jan 2020 16:17:22 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 11E066F1A;
        Fri, 24 Jan 2020 16:17:21 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 24 Jan 2020 16:17:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=2eFw9W427KQmw
        Xr2OWytOtbggD4B2ipeHTOy91n15rs=; b=Zpy/QXNpwzcix5wM4LiEs1CLyFD46
        mTkOCy/FeZy584mASNdt52kAWKCAhi9e4xEQQfg0zTE9a1Xq4tAud+k9/cMkDSde
        XsOB0M/0oyHnl2c3RTPLBfEVfi/xblCFRwktOFVog6u2hXF91ThvxgWgIx8/Bnzy
        wR5vFtPSqd0pTdEDfPADoT3gt27eyUsFM8ng0mRN6IPfhCIQCF9Sii4SEwE1XFFC
        vEEsK0ZLgWKnt14Qra698Rrd1pfB1M7CF7IKmMZyO+L2GVto8NwedopDJcVuNmwh
        EE9AsOWrFY7gbeR+Y3QDdEDwDkJS7cjvTm81xqti+tevnuSBpSLWLfgtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=2eFw9W427KQmwXr2OWytOtbggD4B2ipeHTOy91n15rs=; b=obWYo9O3
        Gmy+VVLSn9b4fJTzudbbpXfyUpTt+4ezeiqGlUIXYuo5p4bgDimEl/ZP6F/+tXB3
        tQNYUidg5SVcUMb3x5SnHUhK8wlNAkIOUMq+TB5J16IwyD7sNS7iBnvTMBL/V8Mq
        6ScN6atVu07ShbyXMCnKnwYlyyX+04S+0tYQcLkq2VwzYevg20itSIjulcnYqi63
        Jj5gWGWAifNhz7L0wIKJZnz+kAnS3zkbBIDusIhxslM47oPrqXMrjzFgSPB0vf+M
        C3JLaLZcvQ8ikFYCbYnmcE8K5L4f/ZRrHFDDVB7wokhyWlQlp0FcFE5m50o76Q43
        ld/bU6PdaM6kqg==
X-ME-Sender: <xms:4F4rXhB86Ys1w5lm49-1By-m3QLga6P5WlvQZr23mPi-8gs_0tM64Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrvdehgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecukfhppeduleelrddvtddurdeigedrgeenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhu
    rdighiii
X-ME-Proxy: <xmx:4F4rXgKjg_eUKEiQX3FRg3rFtuCHODzTsBF1xp0Hpa7nhjopWM3wAw>
    <xmx:4F4rXnsD6v_J40URZ4GfGe2IsRVpx6VTK2hh5ytch21j9jZALarUBg>
    <xmx:4F4rXgUI0y_HA_U0fC7siFGmPMGTJt7GqaI7-pjm1uVKsRjg_U3Kaw>
    <xmx:4V4rXh0B6YEua4TSuO_-_p3Df6APGyq9wE1DI0RiQOR8FkOqB2_i7Q>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (prnvpn05.thefacebook.com [199.201.64.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id 80E7D3062B0C;
        Fri, 24 Jan 2020 16:17:19 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org
Subject: [PATCH v4 bpf-next 1/3] bpf: Add bpf_perf_prog_read_branches() helper
Date:   Fri, 24 Jan 2020 13:17:03 -0800
Message-Id: <20200124211705.24759-2-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200124211705.24759-1-dxu@dxuuu.xyz>
References: <20200124211705.24759-1-dxu@dxuuu.xyz>
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
index f1d74a2bd234..39bfba0091dc 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2892,6 +2892,25 @@ union bpf_attr {
  *		Obtain the 64bit jiffies
  *	Return
  *		The 64 bit jiffies
+ *
+ * int bpf_perf_prog_read_branches(struct bpf_perf_event_data *ctx, void *buf, u32 buf_size, u64 flags)
+ *	Description
+ *		For an eBPF program attached to a perf event, retrieve the
+ *		branch records (struct perf_branch_entry) associated to *ctx*
+ *		and store it in	the buffer pointed by *buf* up to size
+ *		*buf_size* bytes.
+ *
+ *		The *flags* can be set to **BPF_F_GET_BR_SIZE** to instead
+ *		return the number of bytes required to store all the branch
+ *		entries. If this flag is set, *buf* may be NULL.
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
+	FN(perf_prog_read_branches),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
@@ -3091,6 +3111,9 @@ enum bpf_func_id {
 /* BPF_FUNC_sk_storage_get flags */
 #define BPF_SK_STORAGE_GET_F_CREATE	(1ULL << 0)
 
+/* BPF_FUNC_perf_prog_read_branches flags. */
+#define BPF_F_GET_BR_SIZE		(1ULL << 0)
+
 /* Mode for BPF_FUNC_skb_adjust_room helper. */
 enum bpf_adj_room_mode {
 	BPF_ADJ_ROOM_NET,
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 19e793aa441a..2f48fc85d793 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1028,6 +1028,45 @@ static const struct bpf_func_proto bpf_perf_prog_read_value_proto = {
          .arg3_type      = ARG_CONST_SIZE,
 };
 
+BPF_CALL_4(bpf_perf_prog_read_branches, struct bpf_perf_event_data_kern *, ctx,
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
+	if (unlikely(flags & ~BPF_F_GET_BR_SIZE))
+		return -EINVAL;
+
+	if (unlikely(!br_stack))
+		return -EINVAL;
+
+	if (flags & BPF_F_GET_BR_SIZE)
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
+static const struct bpf_func_proto bpf_perf_prog_read_branches_proto = {
+	.func           = bpf_perf_prog_read_branches,
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
+	case BPF_FUNC_perf_prog_read_branches:
+		return &bpf_perf_prog_read_branches_proto;
 	default:
 		return tracing_func_proto(func_id, prog);
 	}
-- 
2.21.1

