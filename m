Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4743F8007
	for <lists+bpf@lfdr.de>; Thu, 26 Aug 2021 03:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbhHZBto (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Aug 2021 21:49:44 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:48309 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231628AbhHZBtn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 25 Aug 2021 21:49:43 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id D04365C01E8;
        Wed, 25 Aug 2021 21:48:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 25 Aug 2021 21:48:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=m1lhmJms4+1nndgAIYcXtKFwc8
        ZBa3GzL0GQeQRINrQ=; b=wCAA+DKJw0HSE5MO+I0vSxOUa//r8fqQKyNiw5kxKB
        21mc3JsBdZVaNq/KxssjHaKbGCZ1YGFu6De+WwYwetXP5MoGBdcGoU2cFotUH24Q
        T63ha/R/uAWYqR/MOwn54sHYicsL26/NcPzNm6j0K9u/bXyXPDzVFLSPev1Cto70
        6LUM4lgHyYuhOyPaOfKZwNe2wyr4tJmDsP1upKojYwtE3X7LwVg4Vo5zxTmFud3M
        /kFuPAwAScw66jqy94iEVMrrNW+MEfMnis4isUvKy6lUm18dnAv0+YAW4CNXwDir
        9TNaFhcVVGtbQIK57dNjmPlrN9wUW2ON132+PCLOoHBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=m1lhmJms4+1nndgAI
        YcXtKFwc8ZBa3GzL0GQeQRINrQ=; b=NkqyHTzt3y/NltV8r1EfBcadIu9GYhiiq
        dbkb7P1Ohu4sF6tOInmq+7RoZ2X/cqdEFh6h/1w698WfuZD7GZuPwHIkYcD+P0Or
        Hcxg+mtIlszhZzfXLwR9pDO/M7PSHsrMMcmgY7pusU+9i4+yL6vYq5KMtykT9dQC
        BhnslSqnXJhf8u3p3446yUlff5VLIG34+q9nXH4BuBzM5RqHFzGEIu2p/IqJl0Oq
        Ju+f+NppwGoJEvnYH3P4wQaO4dlUb9ivWpeBqPljAipPZySWmJLSEgGmvewVtH6P
        ZeoMGph/RD8uHCB9oLUiIL49rlz+26EtIpmN8g9jolcsZoERLX6EA==
X-ME-Sender: <xms:CPMmYWlpICjsl-k8Q9b4nIYMkNXjDluD0wNh2AV0l1pyVDbKocfGLw>
    <xme:CPMmYd1TQ7eLKuCp5DHR118cdMpb8m76cdjtLmtIFuUokocBBbJtn5qqEfRt7HOjZ
    KL7nioHE2Ykmf0G0w>
X-ME-Received: <xmr:CPMmYUqbH3L72Wo8Cs6DZEl61i1oWDQIqVOeQXlBl5zbWdzir24ejENeqN7NTYoCc19YJnOBpGAVSAEbX6ycBFWjKGyk_i74n8PB4zSNHXYFhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddutddghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvf
    fufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihu
    segugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeeifffgledvffeitdeljedvte
    effeeivdefheeiveevjeduieeigfetieevieffffenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:CPMmYakGFZZ4zi-P6s3LQL-notcKtDCq3oL6b8OvyKlJhWJPuoh0Ig>
    <xmx:CPMmYU1w_7htRstqMGxbINUQ2SS7mNaD7mTfxGQMQxDX75VOoN6szQ>
    <xmx:CPMmYRubihF0SXrC6DVhQRsgLnJogYJCFQ7omaxCdBjrMRDL1JwcxA>
    <xmx:CPMmYXRIa4ZlL_Fovgika4-cIAsbZ82QAluV4raC7YMDg3VI1i--rg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Aug 2021 21:48:55 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH bpf-next] bpf: Fix bpf-next builds without CONFIG_BPF_EVENTS
Date:   Wed, 25 Aug 2021 18:48:31 -0700
Message-Id: <05d94748d9f4b3eecedc4fddd6875418a396e23c.1629942444.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This commit fixes linker errors along the lines of:

    s390-linux-ld: task_iter.c:(.init.text+0xa4): undefined reference to `btf_task_struct_ids'`

Fix by defining btf_task_struct_ids unconditionally in kernel/bpf/btf.c
since there exists code that unconditionally uses btf_task_struct_ids.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/linux/btf_ids.h  | 1 +
 kernel/bpf/btf.c         | 2 ++
 kernel/trace/bpf_trace.c | 2 --
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index 93d881ab0d48..47d9abfbdb55 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -151,6 +151,7 @@ extern struct btf_id_set name;
 #define BTF_ID_UNUSED
 #define BTF_ID_LIST_GLOBAL(name) u32 name[1];
 #define BTF_ID_LIST_SINGLE(name, prefix, typename) static u32 name[1];
+#define BTF_ID_LIST_GLOBAL_SINGLE(name, prefix, typename) u32 name[1];
 #define BTF_SET_START(name) static struct btf_id_set name = { 0 };
 #define BTF_SET_START_GLOBAL(name) static struct btf_id_set name = { 0 };
 #define BTF_SET_END(name)
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index c395024610ed..dfe61df4f974 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6213,3 +6213,5 @@ const struct bpf_func_proto bpf_btf_find_by_name_kind_proto = {
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_ANYTHING,
 };
+
+BTF_ID_LIST_GLOBAL_SINGLE(btf_task_struct_ids, struct, task_struct)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 580e14ee7ff9..8e2eb950aa82 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -714,8 +714,6 @@ BPF_CALL_0(bpf_get_current_task_btf)
 	return (unsigned long) current;
 }
 
-BTF_ID_LIST_GLOBAL_SINGLE(btf_task_struct_ids, struct, task_struct)
-
 const struct bpf_func_proto bpf_get_current_task_btf_proto = {
 	.func		= bpf_get_current_task_btf,
 	.gpl_only	= true,
-- 
2.33.0

