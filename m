Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F94869F8AF
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 17:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjBVQMg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 11:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjBVQMc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 11:12:32 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E4F3D907;
        Wed, 22 Feb 2023 08:12:30 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id D21E05C0048;
        Wed, 22 Feb 2023 11:12:28 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 22 Feb 2023 11:12:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1677082348; x=1677168748; bh=jENbBW+G22sQYNJk2HJrdTZtS
        9lMqLYmantZB53Hxew=; b=fO3xRdzobWnowQYjMPVMfWmC2QSziJsdtAoUd76td
        tPs7AQILej0zwe6Ad4j2gUOtty86QD0wJ+rYI5GyYqjvLIiHLDL7fYiJkl+74KLF
        RWaCUtmbD8D347rVblYVCvwSdu3EBjbAjoTwQCAb5S9xbOZoE4cvFBN46YL30MUN
        tz93cRWEUlcjEOn4MVu/xN0vQ1eezaXaTR82xhaTJi+GZek6qgSSDh13YheHvhNv
        3j8EvBdP7iOS8pS05U4WOko/rdOZNAQPnKk0S+tf2QNJmCHMORTKkL5nKBFAchQE
        xBULxjqFsTI7bWtW4ad/7sE/pgpGM+9NGDQrqDrNm7oGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1677082348; x=1677168748; bh=jENbBW+G22sQYNJk2HJrdTZtS9lMqLYmant
        ZB53Hxew=; b=rDyHJpw/IohvksQjwv2Qo8M+Lim/mHGuU47F6MreMUVANeHHuub
        qV6phYGanm8On2g2VMkS8qlyGj3GD4j3slNlL9iGl/ttZVmfz+FvMwHgEUqxqYah
        tAS0opJpR50/yEhLDdv3Pkp90T8sIT5MVxXxyefcVWoicIkmNdrY1EJvpH8zIXBy
        JSJmgG0BLZCaFVQduq6xGdtUOO8IY8pqs870q7GcYvsrJLUt50JssJOqDbHjhCsx
        +JVUiuyqdeOtraWV5cuEuE4tWQnRruKYWfWON3eGmmEO6nDMc2DtYOz25yF9QodY
        6phX4y//GswfcHxSBGxD9QC7zYBOoHklvOw==
X-ME-Sender: <xms:7D72Y6jsEcOstQPKq9Npe9Wq9N1HskC3L-gN1bJD0vU1FGH-P8nFoA>
    <xme:7D72Y7DPFkyBsi5rShR70QyRauIka0z0LyYZt_YoEIPi1Tj5d44BVr8Fx_VFBQR8n
    CkUnPqtiox1duWCToY>
X-ME-Received: <xmr:7D72YyHm7vGWrcHrPZvcjiIn2BDd5fT0Y_v3ZxgqlOHGGD129hoMsWZ4Vgzz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejledgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhephfetuddtudevieeljeejte
    ffheeujeduhefgffejudfhueelleduffefgfffveeknecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgoh
    grthdrtghomh
X-ME-Proxy: <xmx:7D72YzQOya4F_d36P0kCsLRxev0d0vQ41pFFNVfpWSi0bx_W0_HEFA>
    <xmx:7D72Y3yIkXrHdVkKUtxt38dFLw-gViKfdJepxOTpUgUhyNX-5sdZdw>
    <xmx:7D72Yx4hzcsbv_PFO79rJ98lNRMwIaYAwcfsrUeeJxCkjasY9RXJVQ>
    <xmx:7D72Yypp_USbs22Xm7tr7Faxkk9VhK-fmQLTqNbJOvHlWyM6qcOMmw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Feb 2023 11:12:27 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        johan.almbladh@anyfinetworks.com, paulburton@kernel.org,
        bpf@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/2] MIPS: Implement two workarounds for BPF JIT
Date:   Wed, 22 Feb 2023 16:12:20 +0000
Message-Id: <20230222161222.11879-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi all,

Just noticed eBPF JIT is not working on R4000 when messing around with QEMU.

This patchset implements two workarounds that is blocking us from enabling eBPF
JIT on R4000.

Thanks.
- Jiaxun

Jiaxun Yang (2):
  MIPS: ebpf jit: Implement DADDI workarounds
  MIPS: ebpf jit: Implement R4000 workarounds

 arch/mips/Kconfig              | 5 +----
 arch/mips/net/bpf_jit_comp.c   | 8 ++++++++
 arch/mips/net/bpf_jit_comp32.c | 4 ++++
 arch/mips/net/bpf_jit_comp64.c | 3 +++
 4 files changed, 16 insertions(+), 4 deletions(-)

-- 
2.37.1 (Apple Git-137.1)

