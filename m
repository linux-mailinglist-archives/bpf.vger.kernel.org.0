Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B426A4B9C
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 20:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjB0TwG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 14:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjB0TwC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 14:52:02 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59142887D;
        Mon, 27 Feb 2023 11:51:52 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 26EB032000CC;
        Mon, 27 Feb 2023 14:51:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 27 Feb 2023 14:51:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1677527510; x=1677613910; bh=2w
        S7QXee/ZD2u1qIg7tfCJKh+l0Hd7Y+MEF85vsyvdY=; b=ltEEr5nsui4odRXKET
        yer0ZxMVXfaBCaaLcvWs7eNHjqd/FtdIOiRpVst+nvP1EBs59AKzuiCQ1OTMF9Ir
        ovITRvtGrVcFajtCzBrCuccx/FhehzVotm4RuZg3gYLyZ3hqV15eWsgJ7ySbc+fD
        ajKI4iv+kAJitaFso/fBTOzaN80WRQ/y5sJpmDFY5iJXYFU+FyyH6gMzxd7hqH85
        lK2w3bJMGVpQhNtG8d7SZ+qyei8O96B7EEUq37P+QGjrTxnjr9K15KiPHA8FbYhj
        15wcSh7o906GNpmwibc6TGji1Ke+CxxhxrzjPEHArKqpy2/JLrkolfA4zdV00tj8
        +VOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677527510; x=1677613910; bh=2wS7QXee/ZD2u
        1qIg7tfCJKh+l0Hd7Y+MEF85vsyvdY=; b=KVE1sgYfCYqBVJFZEoOkdxkLLhpcV
        X9sTPVEl80dCszfxkvQphyXW9nyPHR9ouM+dj0EXr8GNNuK9amA9+lowwtb1y0vm
        q2YtvL56n5T/jc7VWCpg2EnN/rb+gN8LbZIo8eir3VbtnrysNyUX8Uetmv+xIoH9
        Bs1JTHSLLMLs2jjLqxTKzzb4r1k3dGkqrrI+CcUwh1/1yBbBhKGd8NvddAreAA/7
        DX2WddKOzvDqFZsF0i81AYTs5JywQKptGsfUIhnOivQQvPISNxq1KVb5wQf7XOob
        dP46H8uTMHUTavnolSp9PnfyIVQpw/3QIUPTuGsvvz0XdqnZq4RekSYHg==
X-ME-Sender: <xms:1gn9Y02o6wE5ble9OOraIsCmR2SJpBW7mosR_D7GJonzR82_hhxN9Q>
    <xme:1gn9Y_Hyfb9AC43oz9H6mfTWJINUTZZm0bxWgsKY5zPynwaWYbtZHeMZtjiCVoMqS
    lNA_QmysR3NCHsayw>
X-ME-Received: <xmr:1gn9Y85OcZx5C387z_muDRUsoH9hFit1nDoi166kPym-pxNbIoUTxaHL8_RNn6exaYb4zpw_8B3jh6mRf-3pr0Vmsl1SKMK0W6EO6yxDF536dw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeltddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduie
    ekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhi
    iigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:1gn9Y90N1_eZAe31wj-gB0mllIylXHE7MOSLefQRgwZtPrd8lVSKDg>
    <xmx:1gn9Y3E5BWcHmvpTOna-eML9CQ62cihjiXGW2lBXAJxzYmsfsTk_IQ>
    <xmx:1gn9Y2-X5wHO1IuVG4eaNYSlK9YQ8-nDnREv-99tEh_SkdK--fL1GA>
    <xmx:1gn9Y3Ezzz1YSM0JQQd8g-lqhgp9DEZey1B-rvD8Fzh5b0CLT6yGIw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Feb 2023 14:51:49 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     corbet@lwn.net, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, ast@kernel.org
Cc:     song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 2/8] bpf: verifier: Support KF_CHANGES_PKT flag
Date:   Mon, 27 Feb 2023 12:51:04 -0700
Message-Id: <991bc64ee4013bc81d7d4ab908d541d8978595a8.1677526810.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1677526810.git.dxu@dxuuu.xyz>
References: <cover.1677526810.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 226313747be5..16c387ee987f 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -260,6 +260,13 @@ encouraged to make their use-cases known as early as possible, and participate
 in upstream discussions regarding whether to keep, change, deprecate, or remove
 those kfuncs if and when such discussions occur.
 
+2.4.10 KF_CHANGES_PKT flag
+-----------------
+
+The KF_CHANGES_PKT is used for kfuncs that may change packet data.
+After calls to such kfuncs, existing packet pointers will be invalidated
+and must be revalidated before the prog can access packet data.
+
 2.5 Registering the kfuncs
 --------------------------
 
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 49e0fe6d8274..ee3d6c3e6cc0 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -71,6 +71,7 @@
 #define KF_SLEEPABLE    (1 << 5) /* kfunc may sleep */
 #define KF_DESTRUCTIVE  (1 << 6) /* kfunc performs destructive actions */
 #define KF_RCU          (1 << 7) /* kfunc only takes rcu pointer arguments */
+#define KF_CHANGES_PKT  (1 << 8) /* kfunc may change packet data */
 
 /*
  * Tag marking a kernel function as a kfunc. This is meant to minimize the
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5cb8b623f639..e58065498a35 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8681,6 +8681,11 @@ static bool is_kfunc_rcu(struct bpf_kfunc_call_arg_meta *meta)
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
@@ -10083,6 +10088,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			mark_btf_func_reg_size(env, regno, t->size);
 	}
 
+	if (is_kfunc_changes_pkt(&meta))
+		clear_all_pkt_pointers(env);
+
 	return 0;
 }
 
-- 
2.39.1

