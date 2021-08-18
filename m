Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49D03F0EB4
	for <lists+bpf@lfdr.de>; Thu, 19 Aug 2021 01:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbhHRXmd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Aug 2021 19:42:33 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:52991 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234860AbhHRXma (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 18 Aug 2021 19:42:30 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 64F3D580E0B;
        Wed, 18 Aug 2021 19:41:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 18 Aug 2021 19:41:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=Yk3euvXXlMCwY
        vGhvhfMir2QOXlVuyuGj4zvye1lxR8=; b=CJkcBFuIyHHZndihoY2jocWg5WF/9
        g07b8+jeGMwgwtmO2H/K3sqX0X427JFal0Chw8HhAXKeMaFqrI21Q5zhimCp5xqN
        c23GHoLCYsNO+eyD81Zn2cS2CmeDwfmDFLyv5jPEHSHUijQGiSyAaV72Q9kuEqUB
        bXP4OCizYzSA+0bAhdCDWkXVjfcGZo1bHDceL1GGH1zI0AFFdnpf/fJkXX9qEQfW
        e7LGrOml/Jxgdh75T3BegLTILJJP54sBBxqVZvd9Kg4b2tGAm5prgoWVQXlwJFxS
        32B3lAMifXMpoYZuo/1en0aScnMmPpgUSwqO9qxFcfjZCTS4dilNpBLLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Yk3euvXXlMCwYvGhvhfMir2QOXlVuyuGj4zvye1lxR8=; b=j3K1KuOo
        0GEFw0iMAfQlbN+sK5oaDbgGJzipgQ8Cb3U7pj6dnZetDSN82BjOmsq0iEV4w6Xv
        hbYjswvth7QkXjsy+7lbEH8Y32IycKJD/VJAZyKplfWuGnuivDwQu9sG1FbRjosQ
        uzSDQcIBwRzk7reI3Qpdj2Zcju2uMwdyLLuFsnofVeqYdEVfW0bIeJfqvsXxerrb
        4SoURgVTk7xxzy02X8KSTq0di7IQqr8xnNgq4HUMzUCk8luPDLUOv4fY2piEetRb
        TKUSOZ70lwRrIbXK79odCq38PjepXmYOkhA3rYOfKEoawKbZRYzOmoO7iCZgTho7
        SmqSDjkBOJwtxA==
X-ME-Sender: <xms:w5odYfy8radMDdQKp0-2l9MERs9DQdGFQX3xDaKJaKodc4ht_wygQw>
    <xme:w5odYXT7CYUNPNZvHgPBQUWRxlPxWHTDU0KCPyajTTFex0tMquJlYOGJrZmJ7-XIw
    VSflv_jpwTqUY0hTA>
X-ME-Received: <xmr:w5odYZWgevsMW2rHKTbsA3No_4L2xHgLtDY_QEpV63NVnWoMvomS3CucjMHnErumVdlgYwbROKU0WUtp3dHzpkivbmkDJQ0SctNkoVqtjNhppw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleeigddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculddvfedmnegovehorghsthgrlh
    dqhfeguddvqddtvdculdduhedtmdenucfjughrpefhvffufffkofgjfhgggfestdekredt
    redttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpeeugfffffduffekueetieefgeeltdevfeekhffggeeikeej
    vdduteevkeeugedvtdenucffohhmrghinheplhhkmhhlrdhorhhgpdhgihhthhhusgdrtg
    homhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegu
    gihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:w5odYZipu8NL6G_dANBPs4nEgXBRYG1Y_gNXZ_Q9TKzbbXuobUiKQw>
    <xmx:w5odYRCKqVWQZPN32aq-s4cVuZqLXAaxhDsDl4eoMQw2b7Jq05uTKA>
    <xmx:w5odYSLF4HJnySgEvIqA70G9zWlY2BxJwTTRknLnHrA92tige5E0bQ>
    <xmx:w5odYc87jFUqthbWoBZFX7aV5tpXQPvErmuuKZntJYzf5AJTdv4Edw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Aug 2021 19:41:54 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, yhs@fb.com, andriin@fb.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 1/2] bpf: Add bpf_task_pt_regs() helper
Date:   Wed, 18 Aug 2021 16:41:41 -0700
Message-Id: <6d269f13f2ff742e319a8c19112ef40f0b4c2f46.1629329560.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1629329560.git.dxu@dxuuu.xyz>
References: <cover.1629329560.git.dxu@dxuuu.xyz>
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
 kernel/trace/bpf_trace.c       | 20 ++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  7 +++++++
 3 files changed, 34 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c4f7892edb2b..47427493206a 100644
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
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index cbc73c08c4a4..5924bb5a1462 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -723,6 +723,24 @@ static const struct bpf_func_proto bpf_get_current_task_btf_proto = {
 	.ret_btf_id	= &bpf_get_current_btf_ids[0],
 };
 
+BPF_CALL_1(bpf_task_pt_regs, struct task_struct *, task)
+{
+	return (unsigned long) task_pt_regs(task);
+}
+
+BTF_ID_LIST(bpf_task_pt_regs_ids)
+BTF_ID(struct, task_struct)
+BTF_ID(struct, pt_regs)
+
+static const struct bpf_func_proto bpf_task_pt_regs_proto = {
+	.func		= bpf_task_pt_regs,
+	.gpl_only	= true,
+	.arg1_type	= ARG_PTR_TO_BTF_ID,
+	.arg1_btf_id	= &bpf_task_pt_regs_ids[0],
+	.ret_type	= RET_PTR_TO_BTF_ID,
+	.ret_btf_id	= &bpf_task_pt_regs_ids[1],
+};
+
 BPF_CALL_2(bpf_current_task_under_cgroup, struct bpf_map *, map, u32, idx)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
@@ -1032,6 +1050,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_current_task_proto;
 	case BPF_FUNC_get_current_task_btf:
 		return &bpf_get_current_task_btf_proto;
+	case BPF_FUNC_task_pt_regs:
+		return &bpf_task_pt_regs_proto;
 	case BPF_FUNC_get_current_uid_gid:
 		return &bpf_get_current_uid_gid_proto;
 	case BPF_FUNC_get_current_comm:
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index c4f7892edb2b..47427493206a 100644
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
2.32.0

