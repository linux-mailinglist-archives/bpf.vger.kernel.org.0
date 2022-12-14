Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8000B64D360
	for <lists+bpf@lfdr.de>; Thu, 15 Dec 2022 00:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiLNX2b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 18:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiLNX2E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 18:28:04 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FB5442E3;
        Wed, 14 Dec 2022 15:26:11 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 7DB95320070D;
        Wed, 14 Dec 2022 18:26:09 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 14 Dec 2022 18:26:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1671060369; x=1671146769; bh=2H
        //0Y9RAGciK3bd0PHbQuXcwoJvkHSOlJrDofxj0TQ=; b=NJF57KhZRRHZv9r1KI
        w85sWf7gHbiL3cPoHEEmvQaLA1D19YDCUCbC8jCyjbewolrunXGZxEvsftXXmHJY
        ZiZGAsTFeSIwuEMOvO8+qo9SP2wbdadp0bwS5047K29uUfroQ3mCBv8aBPEKrvrz
        ax363pnE66mvXugJKistXkPFOyfKCOLe7C1WAmocPI8qgu+oPZeHArwlZxJF1LdX
        kxprYT5jvjNuioAtFfz1MhIq3p3gvVOBPUClI8JuSi6G4V1q8NCqcclyINCBFDJZ
        njYjTQG1Qd9URCnz5UZqaZvxvvn6OP2d7kshMxGbnOIC1YxBkkNJmhCuP6Jpc8sF
        5KfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1671060369; x=1671146769; bh=2H//0Y9RAGciK
        3bd0PHbQuXcwoJvkHSOlJrDofxj0TQ=; b=V8UGbeDVbBUBu96dosQh5lLxITdvy
        H95LItiFmZNrp08k2Ppmbdf6FlSbQfFbgbUPbGRk0iR47jcxhBZiaNpN51iv62r5
        v2cohqnDCC9W0ORS1sqdpIVAbd2u+gJvplOcSFssVSZdRsUyxWatcSWyftrYHm2v
        qdaxyGVps3bIz8IGcP1XJTOfw35SqtcIhRAQPxoZsukQPUTXujWxCx9yVUJ4gFo1
        9HLiym0KI3z721R7/sxyyJeLTlZOEPSSY/DSA1z6EX4GxJ9HCCz/wpFD95s9F9H+
        ZK3ZFc8QoBpNMmvSCRMYBcunBeYUOjlk5IMdCxAfkCT9gpxiRpvfiwmSA==
X-ME-Sender: <xms:kFuaY4ue91ffPe3IUtLx4CNVWGjlEftN0f7tM7nLHqx9pbQfW7tu3w>
    <xme:kFuaY1d_-eYaV0ikm0POm-cIVEuKZ4uiMK_91AJyV1r2zfAe1rAc6rIb86udc6t1Q
    Sg7R1t04qpNOi1VYQ>
X-ME-Received: <xmr:kFuaYzy6N044jjvOYyJ_pai5miT6wJaq5YqfiXg7HU8ZQHWwhY--VTk_sZQxzBtQGQMJ2E6GI1Q-nzAKzP_rvI80OeZ1HAEzQxf-H2HWsgE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeggddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdejtddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenuc
    ggtffrrghtthgvrhhnpefgfefggeejhfduieekvdeuteffleeifeeuvdfhheejleejjeek
    gfffgefhtddtteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:kFuaY7OfP1v9sh9nMQL8hxYdz7j9pzFpG6JHWqIie4yRSKLilsuAUA>
    <xmx:kFuaY4-V2bK36Qjfy4eQPUu6f7QkgF5U3ArqrhxJhE8rug3Pb5RhhQ>
    <xmx:kFuaYzXEvQX9SbsNpP_1SWyrMBUIMad5sp0dPGZbh7Jah9QJ5Hi6sA>
    <xmx:kVuaY7fQgvCKPqatmycKvbKXuLGt4HiizHNKFYGs9HGg6PpVL6PtsQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Dec 2022 18:26:07 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     ppenkov@aviatrix.com, dbird@aviatrix.com, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 2/6] bpf: verifier: Support KF_CHANGES_PKT flag
Date:   Wed, 14 Dec 2022 16:25:29 -0700
Message-Id: <fc37530d6cf954c3ebd1173d2bdc6b731c733134.1671049840.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1671049840.git.dxu@dxuuu.xyz>
References: <cover.1671049840.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,T_PDS_OTHER_BAD_TLD
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

KF_CHANGES_PKT indicates that the kfunc call may change packet data.
This is analogous to bpf_helper_changes_pkt_data().

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 Documentation/bpf/kfuncs.rst | 7 +++++++
 include/linux/btf.h          | 1 +
 kernel/bpf/verifier.c        | 8 ++++++++
 3 files changed, 16 insertions(+)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 9fd7fb539f85..061ab392a02f 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -200,6 +200,13 @@ single argument which must be a trusted argument or a MEM_RCU pointer.
 The argument may have reference count of 0 and the kfunc must take this
 into consideration.
 
+2.4.9 KF_CHANGES_PKT flag
+-----------------
+
+The KF_CHANGES_PKT is used for kfuncs that may change packet data.
+After calls to such kfuncs, existing packet pointers will be invalidated
+and must be revalidated before the prog can access packet data.
+
 2.5 Registering the kfuncs
 --------------------------
 
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 5f628f323442..0575f530e40b 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -71,6 +71,7 @@
 #define KF_SLEEPABLE    (1 << 5) /* kfunc may sleep */
 #define KF_DESTRUCTIVE  (1 << 6) /* kfunc performs destructive actions */
 #define KF_RCU          (1 << 7) /* kfunc only takes rcu pointer arguments */
+#define KF_CHANGES_PKT  (1 << 8) /* kfunc may change packet data */
 
 /*
  * Return the name of the passed struct, if exists, or halt the build if for
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a5255a0dcbb6..0ac505cbd6ba 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8213,6 +8213,11 @@ static bool is_kfunc_rcu(struct bpf_kfunc_call_arg_meta *meta)
 	return meta->kfunc_flags & KF_RCU;
 }
 
+static bool is_kfunc_changes_pkt(struct bpf_kfunc_call_arg_meta *meta)
+{
+	return meta->kfunc_flags & KF_CHANGES_PKT;
+}
+
 static bool is_kfunc_arg_kptr_get(struct bpf_kfunc_call_arg_meta *meta, int arg)
 {
 	return arg == 0 && (meta->kfunc_flags & KF_KPTR_GET);
@@ -9313,6 +9318,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			mark_btf_func_reg_size(env, regno, t->size);
 	}
 
+	if (is_kfunc_changes_pkt(&meta))
+		clear_all_pkt_pointers(env);
+
 	return 0;
 }
 
-- 
2.39.0

