Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE463F55E5
	for <lists+bpf@lfdr.de>; Tue, 24 Aug 2021 04:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbhHXCo4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Aug 2021 22:44:56 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:57157 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233796AbhHXCoy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 23 Aug 2021 22:44:54 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7B5AC580482;
        Mon, 23 Aug 2021 22:44:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 23 Aug 2021 22:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=cSJsC18zbGZY1
        36ARviaNi6B6FaQ+nUXhOmna6iTmJk=; b=YqPgtvw9bpaTNwCQud1wVbqVIH+ex
        pJpkU9+khVz2g30j9v2XO96mH1s7h+IyUPi67+g8hN6MX5PNPJzsRtN54n7Da286
        sj9SANB86wz4MlRLZAjHjum3MLMcu25v4uD4Mp1Of/o20w/PbV3bMAiWhCv7b3yE
        rpJ0/NsFo5OGnXeWfbhN3mzNKVRAqii3ldI7Gy7yjrB8kQ+OkSDZyUca4j+da0Uq
        QGMWQATQpsW5to8UrBDiwAjIjPiQSinqZ+dJbiIFEqlGaxpTew00h4umjI/b/ooP
        HSuqu5z67iFOX77JDwvrMLksLUBiXuvYQVel1OTEfihfrQUj8sfT0+E7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=cSJsC18zbGZY136ARviaNi6B6FaQ+nUXhOmna6iTmJk=; b=hDOHSkKp
        8wd/GXRMB6JOha5mYx5GES8n008Q1EcK2asNnAyVV57WBr2B8XZhFbXHv/4nlBy8
        vxoYm6B+1rvYT9YzGvYQ99Hmx6ru1BYtTJ4bbiynnPW/aD+rsCJO020FU6fDr+7s
        SW6mXh5/8CSjf2xs+XwTSCeM76x103Ma9xwoulJhlJ4Lfw4MxZV0j4Jk+Rr3WRai
        1B1GhPbPEipuKHJQSNlCchEA5jnH3hjEFmAUbF1j9nO1Mo7UBGMyeAtmGKAFALSi
        pm3Br31Hk1IVEVNHbREJ04ePuu2Gouo/ROemleFvO9IhxY5PfwtCHhJcyf5iVt8r
        u1Ye1o81Ya9VSA==
X-ME-Sender: <xms:-lwkYa9Of6BbcS-WM95RZ0ZdNFm1c1KrPYkXsFfCpRS40oWOBPuN_w>
    <xme:-lwkYavWL0pia5xgnHxcN_6tfb8kWPF7hq8MIdwksl4F9jGOCZjrbwlyGRe_IdRFm
    pSiopmCgznucRWnjQ>
X-ME-Received: <xmr:-lwkYQBhQLiapWq31U2bilmOzf_D9s3aeNYOYjdLWqKzYsSjPuJMBxLofEb74iDs5yvy1UU9M1A1_r4dEa4Aa4IDQ9YDbJ-5e17d8YW9LsiEgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddtiedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlvdefmdenogevohgrshhtrg
    hlqdfhgeduvddqtddvucdludehtddmnecujfgurhephffvufffkffojghfggfgsedtkeer
    tdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihii
    eqnecuggftrfgrthhtvghrnhepuefgffffudffkeeuteeifeegledtveefkefhgfegieek
    jedvudetveekueegvddtnecuffhomhgrihhnpehlkhhmlhdrohhrghdpghhithhhuhgsrd
    gtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    ugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:-lwkYSe5cvuVut8vG9InN65nBO5J6ng2zrjoN9xxXdMX1hQTLdw8UQ>
    <xmx:-lwkYfOjaeDU3SDzYZ-a1XFCav7_8CGPApVmBPl1FaQpFF-LputikQ>
    <xmx:-lwkYcm8MdW8U50X2mfkQvSbgBElsrsWjmbwFNpZFKDFCNQSdyn2TA>
    <xmx:-lwkYUoAJaNkmAZ7nfxOZQpN5UDCpWaMyCsUFVANTslAWu5yWYxEhA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Aug 2021 22:44:09 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, yhs@fb.com, andriin@fb.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 4/5] bpf: Add bpf_task_pt_regs() helper
Date:   Mon, 23 Aug 2021 19:43:49 -0700
Message-Id: <e2718ced2d51ef4268590ab8562962438ab82815.1629772842.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1629772842.git.dxu@dxuuu.xyz>
References: <cover.1629772842.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The motivation behind this helper is to access userspace pt_regs in a
kprobe handler.

uprobe's ctx is the userspace pt_regs. kprobe's ctx is the kernelspace
pt_regs. bpf_task_pt_regs() allows accessing userspace pt_regs in a
kprobe handler. The final case (kernelspace pt_regs in uprobe) is
pretty rare (usermode helper) so I think that can be solved later if
necessary.

More concretely, this helper is useful in doing BPF-based DWARF stack
unwinding. Currently the kernel can only do framepointer based stack
unwinds for userspace code. This is because the DWARF state machines are
too fragile to be computed in kernelspace [0]. The idea behind
DWARF-based stack unwinds w/ BPF is to copy a chunk of the userspace
stack (while in prog context) and send it up to userspace for unwinding
(probably with libunwind) [1]. This would effectively enable profiling
applications with -fomit-frame-pointer using kprobes and uprobes.

[0]: https://lkml.org/lkml/2012/2/10/356
[1]: https://github.com/danobi/bpf-dwarf-walk

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/uapi/linux/bpf.h       |  7 +++++++
 kernel/bpf/helpers.c           |  3 +++
 kernel/trace/bpf_trace.c       | 19 +++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  7 +++++++
 4 files changed, 36 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 191f0b286ee3..791f31dd0abe 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4871,6 +4871,12 @@ union bpf_attr {
  * 	Return
  *		Value specified by user at BPF link creation/attachment time
  *		or 0, if it was not specified.
+ *
+ * long bpf_task_pt_regs(struct task_struct *task)
+ *	Description
+ *		Get the struct pt_regs associated with **task**.
+ *	Return
+ *		A pointer to struct pt_regs.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5048,6 +5054,7 @@ union bpf_attr {
 	FN(timer_cancel),		\
 	FN(get_func_ip),		\
 	FN(get_attach_cookie),		\
+	FN(task_pt_regs),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 609674f409ed..c227b7d4f56c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1327,6 +1327,7 @@ const struct bpf_func_proto bpf_probe_read_user_proto __weak;
 const struct bpf_func_proto bpf_probe_read_user_str_proto __weak;
 const struct bpf_func_proto bpf_probe_read_kernel_proto __weak;
 const struct bpf_func_proto bpf_probe_read_kernel_str_proto __weak;
+const struct bpf_func_proto bpf_task_pt_regs_proto __weak;
 
 const struct bpf_func_proto *
 bpf_base_func_proto(enum bpf_func_id func_id)
@@ -1424,6 +1425,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_snprintf_btf_proto;
 	case BPF_FUNC_snprintf:
 		return &bpf_snprintf_proto;
+	case BPF_FUNC_task_pt_regs:
+		return &bpf_task_pt_regs_proto;
 	default:
 		return NULL;
 	}
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 4e54f3dc209f..580e14ee7ff9 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -723,6 +723,23 @@ const struct bpf_func_proto bpf_get_current_task_btf_proto = {
 	.ret_btf_id	= &btf_task_struct_ids[0],
 };
 
+BPF_CALL_1(bpf_task_pt_regs, struct task_struct *, task)
+{
+	return (unsigned long) task_pt_regs(task);
+}
+
+BTF_ID_LIST(bpf_task_pt_regs_ids)
+BTF_ID(struct, pt_regs)
+
+const struct bpf_func_proto bpf_task_pt_regs_proto = {
+	.func		= bpf_task_pt_regs,
+	.gpl_only	= true,
+	.arg1_type	= ARG_PTR_TO_BTF_ID,
+	.arg1_btf_id	= &btf_task_struct_ids[0],
+	.ret_type	= RET_PTR_TO_BTF_ID,
+	.ret_btf_id	= &bpf_task_pt_regs_ids[0],
+};
+
 BPF_CALL_2(bpf_current_task_under_cgroup, struct bpf_map *, map, u32, idx)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
@@ -1032,6 +1049,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_current_task_proto;
 	case BPF_FUNC_get_current_task_btf:
 		return &bpf_get_current_task_btf_proto;
+	case BPF_FUNC_task_pt_regs:
+		return &bpf_task_pt_regs_proto;
 	case BPF_FUNC_get_current_uid_gid:
 		return &bpf_get_current_uid_gid_proto;
 	case BPF_FUNC_get_current_comm:
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 191f0b286ee3..791f31dd0abe 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4871,6 +4871,12 @@ union bpf_attr {
  * 	Return
  *		Value specified by user at BPF link creation/attachment time
  *		or 0, if it was not specified.
+ *
+ * long bpf_task_pt_regs(struct task_struct *task)
+ *	Description
+ *		Get the struct pt_regs associated with **task**.
+ *	Return
+ *		A pointer to struct pt_regs.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5048,6 +5054,7 @@ union bpf_attr {
 	FN(timer_cancel),		\
 	FN(get_func_ip),		\
 	FN(get_attach_cookie),		\
+	FN(task_pt_regs),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.33.0

