Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1471D161F2F
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2020 04:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgBRDFB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Feb 2020 22:05:01 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:40219 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726237AbgBRDFB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 17 Feb 2020 22:05:01 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 8E03969A;
        Mon, 17 Feb 2020 22:04:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 17 Feb 2020 22:04:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=YZ/usbZEAgRJR
        JQqoniG+SjdSG0TnzTAIojOtlHAvuE=; b=v4qiLM8R28KpHR1k1pnkmekX1mCdL
        3p5LSFjTtxb4hyZ4Qu+JZeCu+vLf5TKnWFebosT/V7SwKfm+zSFpfjgCDeQA3KQo
        4efXCL952Wtj8LWEE8dSgOVUBd1E1l13yyLMw3Yp5RLttyCuEytwKQAgPLkVJZ0M
        4bhQQFBpjTfrvI3WEPsoAg79ksYkdrjjshO9DAhXKnGv6Gz4onCGkCY4nvfeRWQj
        pB0pxssVlPaL37YPTpNEkqe3Yv4iFGTLo1IPrtcV/+f5rxAmaRJUH4AOJM2eyH3T
        CWsuyv4kl+1F5Dznk30b3WNvnVWxrOXsF1IIPdGipPLt789sxt/J2zueQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=YZ/usbZEAgRJRJQqoniG+SjdSG0TnzTAIojOtlHAvuE=; b=J3XKy8Ep
        gEQzZznkZo59t8k9kAXFrmcDmHDXkTlEgd3K/S+0FncxHU6Ib+NY/ThWe1+f4qUj
        s/H4F5lNuLRd48lNN+EEX07wAyxYFNCH0p3bDzr2v7JZRyw4KwDJeO7cFpCzyJGH
        EizT8EH0zSZwLUerpHZZZu5FtBObVCzyqcHalWpaxaTdJX3X13cw/Gdypa5DS/j/
        H5wW0Vi9IWtUXhu5LQmdXraCoC58c0ivhFruAGtbQ3pnklP6OpatzLys2DIJeTla
        AGj+f5E8ayZwTZHFFfXmfenGBdQVtGUr05yYXhNZP2vVlbuO3e4VAfLZJiuaSuru
        uY5FF62gW5H6rw==
X-ME-Sender: <xms:UVRLXkCvmu9a6V1igBHikbDwEk13Z8SuHikknEEWX_5c9LCf712uzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeejgdehfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephffvuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecukfhppeduieefrdduudegrddufedtrddunecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhu
    uhdrgiihii
X-ME-Proxy: <xmx:UVRLXgMsogNJ63KwnNaeC7xk1HotK93I7nuHB2tYck0F0QQ3HagMOg>
    <xmx:UVRLXuhO1CcevTLoivZCXZnbgODx-z1-Cxy7OJjfBbBCWd9ml4gKJg>
    <xmx:UVRLXu0lYkb-xh2Avslt-XOx0edVznfJD03V-pYWj0XjYt1Dhss4Uw>
    <xmx:WFRLXtffkCZe6089ZbbcmXu4wNndmliQ4-a6N7D2sXHwHlq6l90EDav55EQ>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [163.114.130.1])
        by mail.messagingengine.com (Postfix) with ESMTPA id 069B93060D1A;
        Mon, 17 Feb 2020 22:04:47 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org
Subject: [PATCH v8 bpf-next 1/2] bpf: Add bpf_read_branch_records() helper
Date:   Mon, 17 Feb 2020 19:04:31 -0800
Message-Id: <20200218030432.4600-2-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200218030432.4600-1-dxu@dxuuu.xyz>
References: <20200218030432.4600-1-dxu@dxuuu.xyz>
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

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/uapi/linux/bpf.h | 25 +++++++++++++++++++++++-
 kernel/trace/bpf_trace.c | 41 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index f1d74a2bd234..a7e59756853f 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2892,6 +2892,25 @@ union bpf_attr {
  *		Obtain the 64bit jiffies
  *	Return
  *		The 64 bit jiffies
+ *
+ * int bpf_read_branch_records(struct bpf_perf_event_data *ctx, void *buf, u32 size, u64 flags)
+ *	Description
+ *		For an eBPF program attached to a perf event, retrieve the
+ *		branch records (struct perf_branch_entry) associated to *ctx*
+ *		and store it in	the buffer pointed by *buf* up to size
+ *		*size* bytes.
+ *	Return
+ *		On success, number of bytes written to *buf*. On error, a
+ *		negative value.
+ *
+ *		The *flags* can be set to **BPF_F_GET_BRANCH_RECORDS_SIZE** to
+ *		instead	return the number of bytes required to store all the
+ *		branch entries. If this flag is set, *buf* may be NULL.
+ *
+ *		**-EINVAL** if arguments invalid or **size** not a multiple
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
index 19e793aa441a..4d3c87a1d215 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1028,6 +1028,45 @@ static const struct bpf_func_proto bpf_perf_prog_read_value_proto = {
          .arg3_type      = ARG_CONST_SIZE,
 };
 
+BPF_CALL_4(bpf_read_branch_records, struct bpf_perf_event_data_kern *, ctx,
+	   void *, buf, u32, size, u64, flags)
+{
+#ifndef CONFIG_X86
+	return -ENOENT;
+#else
+	static const u32 br_entry_size = sizeof(struct perf_branch_entry);
+	struct perf_branch_stack *br_stack = ctx->data->br_stack;
+	u32 to_copy;
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
+#endif
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

