Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFEC214AAA6
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2020 20:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgA0Tku (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jan 2020 14:40:50 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:43209 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726004AbgA0Tku (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 27 Jan 2020 14:40:50 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id E3DE76A26;
        Mon, 27 Jan 2020 14:40:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 27 Jan 2020 14:40:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=ZvSMU6y7wAeb8
        /2s/fn5ni9DRfl6SUxPF0nyHzLwl+M=; b=OeZMvKHeRHrtkxVP6Cdhlt28xxPiW
        CqzXkkeTy0JH6cLGaEENmDfLp36hW9b+eCGRSvH3+gGe5GwdugviO42dvrdxcGom
        joCoX4fDCE83rlx5Npkj/hGgzpobETTlDeA7sGj8AxBvh4fnsBpDmM+IhmjgwH77
        ZC+19XyKMDxVmYBVqz5Bes+twTVDeaV8aIO2EQM2O50LdUcnw3K3cTtbT6hpG/K4
        2TVIDRPd4T5cQkvALNEqUplDy0B2aUNFJjBHQIyX1vHMHw5xRta2SpKGipYhzrOq
        8MogzR0fuVGq2GQDdsE+QzYJy9bDl9+Lq5XckBOR363e5h6Cbv98iBH1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=ZvSMU6y7wAeb8/2s/fn5ni9DRfl6SUxPF0nyHzLwl+M=; b=oujBRnSo
        /e2p/R4sMXdv17/28HS+jAoqYilGnIU73befs9XcvsdIIq9A9d2soYA6/UHEXtNK
        dgahXcNbYDqiwzRHxS1I6DqbEWli1mgkx7e90PB5Zpjj2CMNOGEPZT5TdLswXbig
        gaUqnmek2/R0oXzgxkG7AInTPg4vTSveVYz5xqTQgarLiOSUktFoVPUd6+XSv4gn
        h0kOXGnRrMT1wrgdpG6A2VwE2UhYYIuXr6g+YJWfgIZTp3j84J47ZFYCcmHily0u
        zKg+6eSegQxJDnNGmYHBWqO4aWQwedI3l9Vc73cGAmkpZjT19fkS/ZHBZikrGy9J
        HCUBli7xIEiinA==
X-ME-Sender: <xms:wTwvXitvwPe-k_ZaX9e72B5H3prWHOAo0D5v1sTJlleJOXa0Y7_gYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrfedvgdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucfkphepudelledrvddtuddrieegrddufeelnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugig
    uhhuuhdrgiihii
X-ME-Proxy: <xmx:wTwvXhEE1KYNlCbf8jJvdCIHCIX2vcbE5jsszMt27wz_6gwptR9UeA>
    <xmx:wTwvXqYuGmWBqCMD_7UCihiMqsvD_U06hb41A9KmcpzHD901f6vbug>
    <xmx:wTwvXt14KaaFQg9L1TVRhXZIG_XDcEzUi__2TKwJDwydCO7YIouRIA>
    <xmx:wTwvXmvB2nn8ijw3vGBAJ6NLBAXsSwXO-ehzpp0ORifl7UlSH3JUHg>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [199.201.64.139])
        by mail.messagingengine.com (Postfix) with ESMTPA id 881D43280059;
        Mon, 27 Jan 2020 14:40:48 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org
Subject: [PATCH v7 bpf-next 1/2] bpf: Add bpf_read_branch_records() helper
Date:   Mon, 27 Jan 2020 11:40:30 -0800
Message-Id: <20200127194031.19122-2-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200127194031.19122-1-dxu@dxuuu.xyz>
References: <20200127194031.19122-1-dxu@dxuuu.xyz>
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
index f1d74a2bd234..3004470b7269 100644
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
+ *		*buf_size* bytes.
+ *	Return
+ *		On success, number of bytes written to *buf*. On error, a
+ *		negative value.
+ *
+ *		The *flags* can be set to **BPF_F_GET_BRANCH_RECORDS_SIZE** to
+ *		instead	return the number of bytes required to store all the
+ *		branch entries. If this flag is set, *buf* may be NULL.
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

