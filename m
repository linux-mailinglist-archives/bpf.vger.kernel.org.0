Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37543F55E6
	for <lists+bpf@lfdr.de>; Tue, 24 Aug 2021 04:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbhHXCo5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Aug 2021 22:44:57 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40503 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233759AbhHXCox (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 23 Aug 2021 22:44:53 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 49A965C00D0;
        Mon, 23 Aug 2021 22:44:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 23 Aug 2021 22:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=Q6Mw3g/mXE1iS
        KUihMUa0TtUGExnnjhHmxPLwftdxpQ=; b=fgezGcFpvvuUL3NA2w6UPYRVg3htO
        jo/bwmUNSmFqYxEkdxdGqBvYaAU/USoN5LwuPSpsiy36gnIFm1fsxzkH7t04kAW5
        exnzZVD1mnVrOVp5W/A2PSyjmHOKHoyQM43UqBbFsRg08rI5igKkpdtVKW3NMF0L
        0eowqLdFMPaCawmy+rCE6CNaHl0DAlOx6YRZRzN7kIwMoF1iAvqhDAMAEcZr5cwb
        5KgVgm4GWoqA+bqDMa+NlIitWCIbOA0Nz2v0pclBklUNFzIfvAYSPDeN2aTnSYvo
        D2WYRuUJXPlmPZbCYb6QRNjaAkGnvPZFyUAMEsfDUBKli7eRVpc0FgRNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Q6Mw3g/mXE1iSKUihMUa0TtUGExnnjhHmxPLwftdxpQ=; b=OMTHJPQS
        m1UAkaBe8mCIA6YETcaYsjMDfkkYoTyRo1CFWdL1qaYT33WIzyz68by33qwzygiP
        eyJaI22QvXwscl7mq9hcZGq/9t1tv4qmB4IqIKb1xVyGGDAlCYjwl6sDEiwFnxTi
        KypSXYun9/t4DRdEF6PHup08cgamkLRgcfFt/sSSSw3mOEalXdcbxzQAKGwPKO/o
        HPJ86zFG9maYGvPX/hNl1uQiXfZ9ZNi1QmS8mbLDoXPcHA4utciX4kQo64Z9rMq1
        1pnbvxJNnaDvXIwmXD6mMa9bYpbgNz9x8TgV1QY9dIgaUPVSF78rwwu6HzKIsGrb
        4nmyxgPQiTuMvQ==
X-ME-Sender: <xms:-VwkYar-E1CdEVbD-CWb98mT4UliZv92SxQfL5rAV1eJS22rYA-KZQ>
    <xme:-VwkYYpG_ofoKhPbMJg0Dmro7r8NE8rYqg2C5TyfN2zguPTG84GaRzoBPJ1xl5B9_
    OkqcMhuJ4c0UFzisg>
X-ME-Received: <xmr:-VwkYfNcPAXlAKLoLPFwABcPUMy_OQmNEy9ejqnjfNDQU58hO8GH3zIXpOdMRUK3uP2pj-DC7-LyYJlbM_gK1nepYZNSSWCPUcGHqDUKdXrIpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddtiedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgkeduleekhfetvefhge
    fgvdegfeejfefguedvuddthffggffhhedtueeuteefieenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:-VwkYZ5RHSU4hOPq-FxiAp-JalrrjfgRhAAcN7dKwzEuj7pNkS6g7A>
    <xmx:-VwkYZ54u6LvEyuySMx4nJ2PNfRcOTvZUYiL3_X3Z-oKwOyOyE30Cw>
    <xmx:-VwkYZjrvm6SGiAa3cLYaIEpoP1KNlwV0gFJ4wwIJIb4cwxnhjsVIQ>
    <xmx:-VwkYc2pPWEEeseTxAjV1Ngi-vs7zgVAH6n308wwgx5jWgZWzXk_Aw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Aug 2021 22:44:08 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, yhs@fb.com, andriin@fb.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 3/5] bpf: Extend bpf_base_func_proto helpers with bpf_get_current_task_btf()
Date:   Mon, 23 Aug 2021 19:43:48 -0700
Message-Id: <f99870ed5f834c9803d73b3476f8272b1bb987c0.1629772842.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1629772842.git.dxu@dxuuu.xyz>
References: <cover.1629772842.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_get_current_task() is already supported so it's natural to also
include the _btf() variant for btf-powered helpers.

This is required for non-tracing progs to use bpf_task_pt_regs() in the
next commit.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 kernel/bpf/helpers.c     | 3 +++
 kernel/trace/bpf_trace.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 4e8540716187..609674f409ed 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1322,6 +1322,7 @@ void bpf_timer_cancel_and_free(void *val)
 }
 
 const struct bpf_func_proto bpf_get_current_task_proto __weak;
+const struct bpf_func_proto bpf_get_current_task_btf_proto __weak;
 const struct bpf_func_proto bpf_probe_read_user_proto __weak;
 const struct bpf_func_proto bpf_probe_read_user_str_proto __weak;
 const struct bpf_func_proto bpf_probe_read_kernel_proto __weak;
@@ -1407,6 +1408,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return bpf_get_trace_printk_proto();
 	case BPF_FUNC_get_current_task:
 		return &bpf_get_current_task_proto;
+	case BPF_FUNC_get_current_task_btf:
+		return &bpf_get_current_task_btf_proto;
 	case BPF_FUNC_probe_read_user:
 		return &bpf_probe_read_user_proto;
 	case BPF_FUNC_probe_read_kernel:
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 50d055fc2327..4e54f3dc209f 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -716,7 +716,7 @@ BPF_CALL_0(bpf_get_current_task_btf)
 
 BTF_ID_LIST_GLOBAL_SINGLE(btf_task_struct_ids, struct, task_struct)
 
-static const struct bpf_func_proto bpf_get_current_task_btf_proto = {
+const struct bpf_func_proto bpf_get_current_task_btf_proto = {
 	.func		= bpf_get_current_task_btf,
 	.gpl_only	= true,
 	.ret_type	= RET_PTR_TO_BTF_ID,
-- 
2.33.0

