Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84926147317
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2020 22:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbgAWVXl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 16:23:41 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:35833 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729508AbgAWVXk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Jan 2020 16:23:40 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2FB604765;
        Thu, 23 Jan 2020 16:23:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 23 Jan 2020 16:23:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=1pOY6NnXuTrtO
        rNBPH2A+RlZvbQQ49qUow5adELd1XU=; b=bIkCNs2sMGQHoDxOjQQ/GYS9JH1+R
        fL7+0fvIaS634Kpn3S0JK2jsNncgQ4/cvwz4VrF/NHRMpIrPXhAPB0lLv3a0iCRG
        XLt6HYZtD0YRlg5Hl0n+IfpJVbwxGf1VMEbPOYRGbJCXBqDyUsmBroSuuw+ffAb3
        G51JUnlliTZGidl7RCOY8ZZea6f2IsQsCrA+pTDE5a3kbEwX7o2WsXFyjHevNCjX
        2A1T1btS4DEflrNrjJokE/KWe4LvGqW6/VZ+3h3oX54Ukk1V/kjqC7XTW2G3A6n2
        tzl0npEaq92Ao46xdhwu0fFifIvznRkGcBN6ysDOPeLJGtOsMt9aIhggw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=1pOY6NnXuTrtOrNBPH2A+RlZvbQQ49qUow5adELd1XU=; b=UgcTrf8/
        LPmX82x0/micOOnkGzWYbcyTU7I1E1cH4xbJN0u7H1XDZGWo5JRJmiwrrcr0Wzj5
        0CXSlNEjl3LK+WAQx+AlwFj++MOiNGWYLOWCgUrHu4UoaWaT+j4vJ7AIDcdAC8f6
        fdah3MrupbPwHO735zWDv5F8avg+3usJW4kiMVbBASTSG/0MdHApE6SPaGXJ/qQW
        jRcu9g0Ui0B1Dkwnd/QUxCNmZjVIW4yxy0Rn9hGZd+kNbpY6NbxCWgyvIquJTouK
        HNLxdWni/23GUjWIiYXt9GvktahhEQQI5LAfV31Y2gh24pMiFERQVkge+KUv7ePM
        qa4wYhCoEmTXWg==
X-ME-Sender: <xms:2w4qXkgH8LRrMjVxJQUN20lIIyjtVMsW5kr4e_WGBiDq71p3AWM3Ow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrvddvgdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecukfhppeduleelrddvtddurdeigedrudefheenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihu
    uhhurdighiii
X-ME-Proxy: <xmx:2w4qXs3mVXvdT-LSpHn7gt-NQEdqZjWVtK6gLrSvrA2Cc3RnRWxKRg>
    <xmx:2w4qXur6Hck9-rEHZW0R5FYzU_LmkDg6Yncg4DXnvsmLPZk5zs2INg>
    <xmx:2w4qXh1q8jMwzDL3nUGpMKmCsjbg_93uK1zqbCppkLKeUuLR_5keFw>
    <xmx:2w4qXo4ciK6OoiKFrDgZrcDPihY4-X89hQAdSaTbNVP2SZBCsxeovA>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [199.201.64.135])
        by mail.messagingengine.com (Postfix) with ESMTPA id BB0883060ACE;
        Thu, 23 Jan 2020 16:23:37 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org
Subject: [PATCH v3 bpf-next 1/3] bpf: Add bpf_perf_prog_read_branches() helper
Date:   Thu, 23 Jan 2020 13:23:10 -0800
Message-Id: <20200123212312.3963-2-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200123212312.3963-1-dxu@dxuuu.xyz>
References: <20200123212312.3963-1-dxu@dxuuu.xyz>
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
 include/uapi/linux/bpf.h | 15 ++++++++++++++-
 kernel/trace/bpf_trace.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index f1d74a2bd234..50c580c8a201 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2892,6 +2892,18 @@ union bpf_attr {
  *		Obtain the 64bit jiffies
  *	Return
  *		The 64 bit jiffies
+ *
+ * int bpf_perf_prog_read_branches(struct bpf_perf_event_data *ctx, void *buf, u32 buf_size)
+ *	Description
+ *		For en eBPF program attached to a perf event, retrieve the
+ *		branch records (struct perf_branch_entry) associated to *ctx*
+ *		and store it in	the buffer pointed by *buf* up to size
+ *		*buf_size* bytes.
+ *
+ *		Any unused parts of *buf* will be filled with zeros.
+ *	Return
+ *		On success, number of bytes written to *buf*. On error, a
+ *		negative value.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3012,7 +3024,8 @@ union bpf_attr {
 	FN(probe_read_kernel_str),	\
 	FN(tcp_send_ack),		\
 	FN(send_signal_thread),		\
-	FN(jiffies64),
+	FN(jiffies64),			\
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

