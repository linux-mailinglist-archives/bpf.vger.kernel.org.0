Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71812561A28
	for <lists+bpf@lfdr.de>; Thu, 30 Jun 2022 14:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbiF3MQB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jun 2022 08:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiF3MP7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jun 2022 08:15:59 -0400
X-Greylist: delayed 683 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Jun 2022 05:15:57 PDT
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D741DA6E;
        Thu, 30 Jun 2022 05:15:57 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 431405802D5;
        Thu, 30 Jun 2022 08:04:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 30 Jun 2022 08:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1656590681; x=1656597881; bh=6kn/V/P7kY12b
        Tv38jMdAFQS2rhiZ7f6EmWkOUkG8B8=; b=Fzc/rAEdrH7bUPG6mmx8s3XEP30Hq
        xaZUnf3evMdhmunr8E29zyMZLCnHgfOZziJNrjz+BZMBtc86l7h+lTsYlE7zlo5J
        Yr8DYW8xXUxJ86JkNeaCjfivRS7PaSuhgmOpR7OLJoqm2kWVf8p9NbBQIEom9uJE
        cR9NfIb7M7LjYhvMMk2q6Gs8/ZVx8kTeY87eyeQGUSwZEDbXRWzlWdvPMoE2Yzh3
        LTCjiPZocuxVhVcRA0l+8OMKAVjNdqDcRwQwap95vAvzrB0urmQvUCDf7VcxGnYs
        9mWVbfjmRcl6faulYmE4P6yqYAZ113sxOPnOLV58/S6gbyTHti1kIu7Cw==
X-ME-Sender: <xms:WJG9YnOZ_01Sj2aTPtOM7-aJbaYght1ZEPiEIKtJIWk89FdHz3OVqA>
    <xme:WJG9Yh_Eq1GAKUcqdiB9JEfe6h7mKXBqW02qhYy5X16jn2mkVXpHAKoDgBErkXZwM
    7NRrqaD2nqEomtRYg>
X-ME-Received: <xmr:WJG9YmSzSr74Ro8aYDrRfJoVqRIxq6nvCoK4koTvUsfdWn2Lvzbnfwhdo-aYwpYuFNdbfVv44w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehuddggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeffrghvvgcuvfhutghkvghruceouggrvhgvseguthhutghk
    vghrrdgtohdruhhkqeenucggtffrrghtthgvrhhnpeelueefuddvleffgfeivdduudeute
    fhgeehgeekueehffekffeileeuteffteffudenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpegurghvvgesughtuhgtkhgvrhdrtghordhukh
X-ME-Proxy: <xmx:WZG9YrulDYB8k5e6RIrOTQCZ1V3E-JKzvOhP2faX5kHDME4HLZuNjw>
    <xmx:WZG9YvdWXffjVt7usVGG_uIoF3RxRoadtOd6E4o-4XRBqIEgRjYJqQ>
    <xmx:WZG9Yn2Neg2XOQyLg6X9rygJmy9iqBWndvKrF7-d1EOxgVp4fKZL9g>
    <xmx:WZG9Yj6rk_Sjo1J0XS_Eb2zd5pdK95ax6dw2Ix0oI2F3_RkfGxw2ZA>
Feedback-ID: i559945a3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jun 2022 08:04:40 -0400 (EDT)
From:   Dave Tucker <dave@dtucker.co.uk>
To:     bpf@vger.kernel.org
Cc:     corbet@lwn.net, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-doc@vger.kernel.org, Dave Tucker <dave@dtucker.co.uk>
Subject: [PATCH v4 bpf-next 1/2] bpf, docs: add kernel version to map_cgroup_storage
Date:   Thu, 30 Jun 2022 13:04:08 +0100
Message-Id: <8fd94a697b41cd39e600b87c59954c703bc75850.1656590177.git.dave@dtucker.co.uk>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1656590177.git.dave@dtucker.co.uk>
References: <cover.1656590177.git.dave@dtucker.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_FAIL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds the version at which this map became available to use in the
documentation

Signed-off-by: Dave Tucker <dave@dtucker.co.uk>
---
 Documentation/bpf/map_cgroup_storage.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/bpf/map_cgroup_storage.rst b/Documentation/bpf/map_cgroup_storage.rst
index cab9543017bf..b626cb068846 100644
--- a/Documentation/bpf/map_cgroup_storage.rst
+++ b/Documentation/bpf/map_cgroup_storage.rst
@@ -5,6 +5,8 @@
 BPF_MAP_TYPE_CGROUP_STORAGE
 ===========================
 
+.. note:: Introduced in Kernel version 4.19
+
 The ``BPF_MAP_TYPE_CGROUP_STORAGE`` map type represents a local fix-sized
 storage. It is only available with ``CONFIG_CGROUP_BPF``, and to programs that
 attach to cgroups; the programs are made available by the same Kconfig. The
-- 
2.37.0

