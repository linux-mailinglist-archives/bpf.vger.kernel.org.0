Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9413F55E3
	for <lists+bpf@lfdr.de>; Tue, 24 Aug 2021 04:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbhHXCow (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Aug 2021 22:44:52 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51025 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233664AbhHXCow (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 23 Aug 2021 22:44:52 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 5056B5C00DD;
        Mon, 23 Aug 2021 22:44:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 23 Aug 2021 22:44:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=F3W3koZQ8zrs6
        P9f79PHZ3xp/CAOoMzvM88wFU8RhHU=; b=iDfeXmKHlCzXqSd/+QbkJla/vbBQE
        CrP4PkDP24vMb/MqhqTAzz0JqUG89JGFgKQgUtujF+S/ijox+Y7kxZUqpTv0I1++
        o2Q/DPmybtXL4xaDyNq/jzQ7Mz1e5fVwNvXKlQvprBbnyeaW/jvoJIakbZ1b60up
        qOviOFjnRevvC5HAkjBQ7JUelnufqg/9X+Oi6qu2BLznpGZQO+qYDEJz+MQ6wqPE
        wl0klFDjZscMLKXMKy/EDEm0UzMfRjABD14EsoWZsCcKIBCQ9QgnMa8OUJ+g3ffr
        IlRcyLHchMd+DgJWWdOQjY1aCR+zGG516wI9ARcEhq1qWuT1BaCQofr3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=F3W3koZQ8zrs6P9f79PHZ3xp/CAOoMzvM88wFU8RhHU=; b=vrzEphWg
        Rz1YD0GXk2udqrrq3H0nwQqmh/Fu+Rgx3+LdgRTwBeTlgQTM+de8zne3ToMuKWPr
        pBalIAaOpim2GFMT+VvaNsZpJ1sIIiYyyJ7BC7GwQ6nxLFIa/p2WEoTQVksrT33T
        a2a3wwb7TaDeWFD+KyJ3GmcuYnIZZ+v2HNMOYZlPnQ5labQuz/eGUEq2CkmNFebu
        e4g7j+pX8RtWnEHpO1+bee64bAUw/ayuR+ANBpQRY8ldCueExijUCnqaeifyHKUb
        w6uy6eS5AdqbStJUenM5o0KLxrl8pEEwnfb4q68Eecg8QJoNLDoceJqboRbFQ443
        pTmS3DdhvSxjrA==
X-ME-Sender: <xms:91wkYYdV_j9_yee6zeF3uATYIJZUADkK0Hoz5y6eeKpBa3wRzvdq6w>
    <xme:91wkYaPQi_LuO-DfzA2YbI1GmfA-ivzzH5xadbaC1cO57S21RXHqQRhrHWn-CFn1T
    2G4Rf7hRKTC3LJP0A>
X-ME-Received: <xmr:91wkYZifnoovHDZTrWN6JPHc3HOvnFsK4AgRd2GlfOTWv4-f-4Gw6KaR-2I7hLqfPHNMptg5TN_SBMqkiyIkVLKtPL4hIVAAUi-3__4DqTlNDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddtiedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgkeduleekhfetvefhge
    fgvdegfeejfefguedvuddthffggffhhedtueeuteefieenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:91wkYd_v773tcw4xzv-IleZgARYT6XENtH_1AodNqsSAaf3RE2qkQA>
    <xmx:91wkYUtAgzC05zBBT8qibCja415Rk2TsZj3fwB3tmrLPILXt0o66QA>
    <xmx:91wkYUFesGPyfFYe4aIAQTuFz6o9lgRpFYWi1HmuwOwoaGWI6pNwEQ>
    <xmx:-FwkYWJ7Sms9do_R5h-7sTfpA6uIdEPfFiiMJqo5y5vjM0U98UjLmw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Aug 2021 22:44:07 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, yhs@fb.com, andriin@fb.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 2/5] bpf: Consolidate task_struct BTF_ID declarations
Date:   Mon, 23 Aug 2021 19:43:47 -0700
Message-Id: <6dcefa5bed26fe1226f26683f36819bb53ec19a2.1629772842.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1629772842.git.dxu@dxuuu.xyz>
References: <cover.1629772842.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

No need to have it defined 5 times. Once is enough.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/linux/btf_ids.h       |  2 ++
 kernel/bpf/bpf_task_storage.c |  6 ++----
 kernel/bpf/stackmap.c         |  4 +---
 kernel/bpf/task_iter.c        | 11 +++++------
 kernel/trace/bpf_trace.c      |  4 ++--
 5 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index 6d1395030616..93d881ab0d48 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -188,4 +188,6 @@ MAX_BTF_SOCK_TYPE,
 extern u32 btf_sock_ids[];
 #endif
 
+extern u32 btf_task_struct_ids[];
+
 #endif
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index 3ce75758d394..ebfa8bc90892 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -317,15 +317,13 @@ const struct bpf_map_ops task_storage_map_ops = {
 	.map_owner_storage_ptr = task_storage_ptr,
 };
 
-BTF_ID_LIST_SINGLE(bpf_task_storage_btf_ids, struct, task_struct)
-
 const struct bpf_func_proto bpf_task_storage_get_proto = {
 	.func = bpf_task_storage_get,
 	.gpl_only = false,
 	.ret_type = RET_PTR_TO_MAP_VALUE_OR_NULL,
 	.arg1_type = ARG_CONST_MAP_PTR,
 	.arg2_type = ARG_PTR_TO_BTF_ID,
-	.arg2_btf_id = &bpf_task_storage_btf_ids[0],
+	.arg2_btf_id = &btf_task_struct_ids[0],
 	.arg3_type = ARG_PTR_TO_MAP_VALUE_OR_NULL,
 	.arg4_type = ARG_ANYTHING,
 };
@@ -336,5 +334,5 @@ const struct bpf_func_proto bpf_task_storage_delete_proto = {
 	.ret_type = RET_INTEGER,
 	.arg1_type = ARG_CONST_MAP_PTR,
 	.arg2_type = ARG_PTR_TO_BTF_ID,
-	.arg2_btf_id = &bpf_task_storage_btf_ids[0],
+	.arg2_btf_id = &btf_task_struct_ids[0],
 };
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 6fbc2abe9c91..e8eefdf8cf3e 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -530,14 +530,12 @@ BPF_CALL_4(bpf_get_task_stack, struct task_struct *, task, void *, buf,
 	return res;
 }
 
-BTF_ID_LIST_SINGLE(bpf_get_task_stack_btf_ids, struct, task_struct)
-
 const struct bpf_func_proto bpf_get_task_stack_proto = {
 	.func		= bpf_get_task_stack,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID,
-	.arg1_btf_id	= &bpf_get_task_stack_btf_ids[0],
+	.arg1_btf_id	= &btf_task_struct_ids[0],
 	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index b68cb5d6d6eb..b48750bfba5a 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -525,7 +525,6 @@ static const struct seq_operations task_vma_seq_ops = {
 };
 
 BTF_ID_LIST(btf_task_file_ids)
-BTF_ID(struct, task_struct)
 BTF_ID(struct, file)
 BTF_ID(struct, vm_area_struct)
 
@@ -591,19 +590,19 @@ static int __init task_iter_init(void)
 {
 	int ret;
 
-	task_reg_info.ctx_arg_info[0].btf_id = btf_task_file_ids[0];
+	task_reg_info.ctx_arg_info[0].btf_id = btf_task_struct_ids[0];
 	ret = bpf_iter_reg_target(&task_reg_info);
 	if (ret)
 		return ret;
 
-	task_file_reg_info.ctx_arg_info[0].btf_id = btf_task_file_ids[0];
-	task_file_reg_info.ctx_arg_info[1].btf_id = btf_task_file_ids[1];
+	task_file_reg_info.ctx_arg_info[0].btf_id = btf_task_struct_ids[0];
+	task_file_reg_info.ctx_arg_info[1].btf_id = btf_task_file_ids[0];
 	ret =  bpf_iter_reg_target(&task_file_reg_info);
 	if (ret)
 		return ret;
 
-	task_vma_reg_info.ctx_arg_info[0].btf_id = btf_task_file_ids[0];
-	task_vma_reg_info.ctx_arg_info[1].btf_id = btf_task_file_ids[2];
+	task_vma_reg_info.ctx_arg_info[0].btf_id = btf_task_struct_ids[0];
+	task_vma_reg_info.ctx_arg_info[1].btf_id = btf_task_file_ids[1];
 	return bpf_iter_reg_target(&task_vma_reg_info);
 }
 late_initcall(task_iter_init);
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index cbc73c08c4a4..50d055fc2327 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -714,13 +714,13 @@ BPF_CALL_0(bpf_get_current_task_btf)
 	return (unsigned long) current;
 }
 
-BTF_ID_LIST_SINGLE(bpf_get_current_btf_ids, struct, task_struct)
+BTF_ID_LIST_GLOBAL_SINGLE(btf_task_struct_ids, struct, task_struct)
 
 static const struct bpf_func_proto bpf_get_current_task_btf_proto = {
 	.func		= bpf_get_current_task_btf,
 	.gpl_only	= true,
 	.ret_type	= RET_PTR_TO_BTF_ID,
-	.ret_btf_id	= &bpf_get_current_btf_ids[0],
+	.ret_btf_id	= &btf_task_struct_ids[0],
 };
 
 BPF_CALL_2(bpf_current_task_under_cgroup, struct bpf_map *, map, u32, idx)
-- 
2.33.0

