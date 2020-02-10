Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCC9158416
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2020 21:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbgBJUII (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Feb 2020 15:08:08 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:41679 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727029AbgBJUIH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 10 Feb 2020 15:08:07 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 97E758124;
        Mon, 10 Feb 2020 15:08:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 10 Feb 2020 15:08:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=ZvSMU6y7wAeb8
        /2s/fn5ni9DRfl6SUxPF0nyHzLwl+M=; b=sth0NNbOajC2XiSgPUQkT8nsXn97I
        oTMnlOhXEwiNBKxmc8Mldgy0zrHRkvVxC8oEacRvDMCls4gdArgWTISajOsif7F9
        bFv+m58A4u/0tAUL79pnO2NfNaj6Tl6llRGyvziG10+5Zba059BcsIJbMfjGbOhx
        LBP4OW7S8xegpfGlbspm+9h2uaNVQxafkHkhMM/ZaagyNHUBwa4Iy9wIjb+lx9OB
        8eI5BmXFixxbHLe2IsmLGbBfuXPym0jXgLOpsz4gsskFdKjShZjRpdvhl9Kr29ow
        fU9y0V1gUzao/sZIu5Igqh0jeiHUb5A1X7GRlXvisTI+KWjl/Gzgn1Hbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=ZvSMU6y7wAeb8/2s/fn5ni9DRfl6SUxPF0nyHzLwl+M=; b=bkAOZFga
        s2pCu4kaDv58PUQXUYbMBcJ9ryEt8iUA3ZZz9tZPZO+fx68ivRnmw3a1nUAO681c
        Aexe1IILsipR6dFK0ljSCkpud2frfYAE+pLVEhUJT1I7ySCw2dkOtsoyrP0CI0lT
        e5sepNQzhG+mIjphruaPh011O+w6dsFyAIvouXrjPPJyiuKDVYDY8tJ4KSVPNqVO
        666QxrcPCa7P/HYm/k7bQ133va9BiVYWuTdIt76Ha0bc9sv5GepZG2ZjqN/DS4lY
        E1Z4waPtPTqotgKvqfF3bRjclLFj2+gviW4iNQuRTwCgnqs8/AVV62YC++JyJkm8
        a2MWhG05/qding==
X-ME-Sender: <xms:JrhBXt5N6dFT3z52T7Kb_8ZN5qzZC5r8FmD8BY4ksop4Nod5Hp_CVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedriedugdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucfkphepudelledrvddtuddrieegrddufeeknecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugig
    uhhuuhdrgiihii
X-ME-Proxy: <xmx:JrhBXsa3ugpsn0C3WGXU9Oo_kftfZgIkphuLBx1aKy6cjFXEWL5ABA>
    <xmx:JrhBXtGxPCZo7I6YoaaTEhmHp_h_jQe1aQilqJkm-qPjvrEeQvR50g>
    <xmx:JrhBXoKOnj8I6WU8-Dwpv6J-LSMIGUZa8lJni2Ebvz-8a50ALENNGQ>
    <xmx:JrhBXgtXe9FOh1xY94BQhxNz3wckpUJtNfTOWmrtho37BgeftJfA6Q>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [199.201.64.138])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2F0EA30607B0;
        Mon, 10 Feb 2020 15:08:05 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org
Subject: [PATCH v7 bpf-next RESEND 1/2] bpf: Add bpf_read_branch_records() helper
Date:   Mon, 10 Feb 2020 12:07:36 -0800
Message-Id: <20200210200737.13866-2-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200210200737.13866-1-dxu@dxuuu.xyz>
References: <20200210200737.13866-1-dxu@dxuuu.xyz>
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

