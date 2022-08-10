Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D8E58F4C2
	for <lists+bpf@lfdr.de>; Thu, 11 Aug 2022 01:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbiHJXRG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 19:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbiHJXRD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 19:17:03 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2C67A524;
        Wed, 10 Aug 2022 16:17:02 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E0EF85C01B2;
        Wed, 10 Aug 2022 19:17:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 10 Aug 2022 19:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1660173421; x=1660259821; bh=rq
        QdddERpZ6h+Dz3PfNtsNxkKxZspx2pv9UNJ9J1FoI=; b=cDEs1KkoHMRlmKlU65
        dNqtqzMyRvyXFkHQ5FsI8vOkuN1+fEJAebjUh2U4CcKPMrNRp+dsVX1n9FXASbJX
        qISVwK/htL/rmTP+Gmr3Kln/5nxjsXbQjdAjXyjyL4wZtKbKWbwaDpE6dmWoRqcE
        0PF5NHEoBVTy+1VhPHSyI1HVV3gKgrVsZ4DTho+YU9/NO1wO71nGqDQ1aZEcAXyx
        h31IQ6JVbhxVMiEGqFzLZRTEHaxKM6Oc7BfAJ+nLsm2psBs2E8Mu0Qh5J3Uvbwwb
        f2p530mBnBmsVtpwq/AH5GNydZ+7WQqjR2WkjMY7bgWn+pYpBUOAEsvLZQiMKpG6
        UD3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660173421; x=1660259821; bh=rqQdddERpZ6h+
        Dz3PfNtsNxkKxZspx2pv9UNJ9J1FoI=; b=B53XW8PTVdgTEY7VBTduOLBGJlutu
        86Dg1mXt7MSHMOx84fR6vLK0cVRKY4BBzHQVz1+F+v7WW/t1259ZOCa0kcHXQtJ3
        oP/FvwMKkiE2C7Tf7GmRQEJGhCbmT3rRx1GRyLSgI56IoGhRmYibwVBjNrh+unJR
        tD39Z/JnIX8kuIwjg8CpiHKkvakKX8bLtItuCPI5vKTkIWDMvxCSt8M0WQMp1mc1
        0xqG6NQE71YkivWcXgtSnGV8H81JEpwmePLaCX49FIsLf+F6UN9bxYoFg4fYxlq/
        L6+Fsj0x5CGfqvJLK5FT3QS80t33t5IFkxYkj91AYisUKmiGxcLPQYKkg==
X-ME-Sender: <xms:bTz0YoSyf-ahKva0OaDLirX6XBElLcg_BqbBUiOcX51fCju1v_WUJA>
    <xme:bTz0Yly2ZzCNJ6uIhaWPPTAfyqUGB1tzLV29p3WbnPx58zwJvJtmmu_DWRhoO34gT
    a92nTgd9rD8Q_LB4A>
X-ME-Received: <xmr:bTz0Yl2lL6bf_m5jIxpPXjeGCMKrp_998R0jnDi_kEaUUbm-huRtKs_HO9Awb3JSNA6KaKSswso>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegfedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:bTz0YsBieu1Q4zabwdEZMRhag5_Fauwnil137dzGKNLiiVbwCIb00g>
    <xmx:bTz0YhhQGNfB6WYEKDvtaF6_AQvBz4l-_mzLc3yEqzSOvMk8LO8JLA>
    <xmx:bTz0YopGVpTr62MZyMhMFb3UQEsgqWsYqbNQKCNSrRB_5bQaF8fWqQ>
    <xmx:bTz0YvZXQHiacYuV-Tl1MqtR4JFWt1weAmbrHkvKlN863VUp8fVSSw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Aug 2022 19:17:00 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, memxor@gmail.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: Update CI kconfig
Date:   Wed, 10 Aug 2022 17:16:44 -0600
Message-Id: <539623914b93e2bc51ca1e420d19473d436b327c.1660173222.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1660173222.git.dxu@dxuuu.xyz>
References: <cover.1660173222.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The previous selftest changes require two kconfig changes in bpf-ci.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/testing/selftests/bpf/config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index fabf0c014349..3fc46f9cfb22 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -50,9 +50,11 @@ CONFIG_NET_SCHED=y
 CONFIG_NETDEVSIM=m
 CONFIG_NETFILTER=y
 CONFIG_NETFILTER_SYNPROXY=y
+CONFIG_NETFILTER_XT_CONNMARK=y
 CONFIG_NETFILTER_XT_MATCH_STATE=y
 CONFIG_NETFILTER_XT_TARGET_CT=y
 CONFIG_NF_CONNTRACK=y
+CONFIG_NF_CONNTRACK_MARK=y
 CONFIG_NF_DEFRAG_IPV4=y
 CONFIG_NF_DEFRAG_IPV6=y
 CONFIG_RC_CORE=y
-- 
2.37.1

