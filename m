Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 473EF145D09
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2020 21:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgAVUXZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jan 2020 15:23:25 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:43767 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725827AbgAVUXZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 Jan 2020 15:23:25 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 247234B78;
        Wed, 22 Jan 2020 15:23:24 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 22 Jan 2020 15:23:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=8Xg2pG8bpEa91
        uOgyrlRmXd7HBJkZ4W+CJgY/E8Av+s=; b=JTKFSBjZXfSFsYHt0RLx++rzBSOBa
        e5qAkczXA2TjexLX9r8D2q5o4Lt9i9BEENgjGjLBU9uIOQoHIoSY3qtLlrw/tyOa
        ezdwYV6yLbR+4+q+/JjhOCUfNbp0GGtU0Gin31bwrk6Tz4pZPTBz+AEyNnFNK9YD
        sbShPPUXG3uEgozYXS/QVg/yyr2hKO4OhYSD0LC92EmRTKr4py1wjMLr+o8EWAlj
        p2xvHmTcqkr7szQ20Ktp7mywYjTpTGcq8mit7wsdM6sefCNqmoxbYge2oHRDnfbd
        J4M5htmqTaaV8rkaTAv1I7YJxBbPdvUplQ8gb+N18ZkPElyfbe+aFQGIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=8Xg2pG8bpEa91uOgyrlRmXd7HBJkZ4W+CJgY/E8Av+s=; b=Ojk+cIoL
        mQrM8XO1l2OHwWjdnbet1YqfUuK800SAjWk7Lay3tbzDRKHMMRukA0hg0dRZXgRf
        03Vhdw9rpBtE+8wO/+U3cciHsfPPaGGgVGMiiO6v5fYHqFYVChT+JJkHmOSSn2RV
        +gDEIQ9WbTVvkVO0xOVAOuGEVF4FEkqauER1qdyVfPpeibq07K4ho1xpgqQGrKhN
        6RZIWv5+GsQ6Io421xKR1dwWQcsXwm+jaomR6j1+XgpUdRIK0C4hE3WDnDZtV3Hv
        Vt9t6d6AzJoZnzJQKAumbl7bvkRKzMYcqK3TX4C/0EC6/+4g1uGAOsipSg/GKxAd
        hRtGbxHVzarUUg==
X-ME-Sender: <xms:PK8oXoc4PibDk6nySo4uDcWiITgKGJ5SXu_SIX2lHX9m3WnSC0MIJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrvddtgddufeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucfkphepudelledrvddtuddrieegrddvnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhu
    uhdrgiihii
X-ME-Proxy: <xmx:PK8oXtAGfOkuyWVG0-3dLnXbmhphondRvydOCM6yMQb24tILed37EQ>
    <xmx:PK8oXsTPIMGoXO9oXFu7-UhxeVi7pakxxiuJlccs9u0AjIckI63xKw>
    <xmx:PK8oXhe-F2TfKEwYft1nlJ9pLUNkv4cTrYwVzRvB8N1YUdiz8l4_xg>
    <xmx:PK8oXsAt3y8q5fF9U1a7Rq_p1YCi4VcVUoEIHzkO7I3rt0vD6NrXNQ>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [199.201.64.2])
        by mail.messagingengine.com (Postfix) with ESMTPA id DC9E5328005C;
        Wed, 22 Jan 2020 15:23:21 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org
Subject: [PATCH v2 bpf-next 1/3] bpf: Add bpf_perf_prog_read_branches() helper
Date:   Wed, 22 Jan 2020 12:22:18 -0800
Message-Id: <20200122202220.21335-2-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200122202220.21335-1-dxu@dxuuu.xyz>
References: <20200122202220.21335-1-dxu@dxuuu.xyz>
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
 include/uapi/linux/bpf.h | 13 ++++++++++++-
 kernel/trace/bpf_trace.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 033d90a2282d..7350c5be6158 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2885,6 +2885,16 @@ union bpf_attr {
  *		**-EPERM** if no permission to send the *sig*.
  *
  *		**-EAGAIN** if bpf program can try again.
+ *
+ * int bpf_perf_prog_read_branches(struct bpf_perf_event_data *ctx, void *buf, u32 buf_size)
+ * 	Description
+ * 		For en eBPF program attached to a perf event, retrieve the
+ * 		branch records (struct perf_branch_entry) associated to *ctx*
+ * 		and store it in	the buffer pointed by *buf* up to size
+ * 		*buf_size* bytes.
+ * 	Return
+ *		On success, number of bytes written to *buf*. On error, a
+ *		negative value.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3004,7 +3014,8 @@ union bpf_attr {
 	FN(probe_read_user_str),	\
 	FN(probe_read_kernel_str),	\
 	FN(tcp_send_ack),		\
-	FN(send_signal_thread),
+	FN(send_signal_thread),		\
+	FN(perf_prog_read_branches),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 19e793aa441a..24c51272a1f7 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1028,6 +1028,35 @@ static const struct bpf_func_proto bpf_perf_prog_read_value_proto = {
          .arg3_type      = ARG_CONST_SIZE,
 };
 
+BPF_CALL_3(bpf_perf_prog_read_branches, struct bpf_perf_event_data_kern *, ctx,
+	   void *, buf, u32, size)
+{
+	struct perf_branch_stack *br_stack = ctx->data->br_stack;
+	u32 to_copy = 0, to_clear = size;
+	int err = -EINVAL;
+
+	if (unlikely(!br_stack))
+		goto clear;
+
+	to_copy = min_t(u32, br_stack->nr * sizeof(struct perf_branch_entry), size);
+	to_clear -= to_copy;
+
+	memcpy(buf, br_stack->entries, to_copy);
+	err = to_copy;
+clear:
+	memset(buf + to_copy, 0, to_clear);
+	return err;
+}
+
+static const struct bpf_func_proto bpf_perf_prog_read_branches_proto = {
+         .func           = bpf_perf_prog_read_branches,
+         .gpl_only       = true,
+         .ret_type       = RET_INTEGER,
+         .arg1_type      = ARG_PTR_TO_CTX,
+         .arg2_type      = ARG_PTR_TO_UNINIT_MEM,
+         .arg3_type      = ARG_CONST_SIZE,
+};
+
 static const struct bpf_func_proto *
 pe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -1040,6 +1069,8 @@ pe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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

