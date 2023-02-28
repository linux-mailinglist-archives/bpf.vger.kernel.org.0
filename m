Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BB46A5824
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 12:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjB1Ld3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 06:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbjB1Ld1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 06:33:27 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC0418B;
        Tue, 28 Feb 2023 03:33:26 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 8C3545C00D1;
        Tue, 28 Feb 2023 06:33:25 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 28 Feb 2023 06:33:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1677584005; x=1677670405; bh=OUst0onvS1
        az3p2Wru+5zWDfOfS0/TABrIMuRCVdU1U=; b=sXXMnOxyGyBNSJbkza2riaDzmk
        IeGFSIsNDwaB2nmMXFvjFmfXFq2/vMvWTH4eOx7aq7ABaJ5h+F942Q45JDQkwKHy
        BkyJ5Xq88M/KvigWecm7PreXYK89N/eeHiEkJlQJja/jz5hwThIPmB/iHzt5HBa9
        2uHRt8Pyf/KYreUt7cfosELB+oEwHUHnolAZeoia4ymSxkN1PvjQDGq0BgQViBBA
        Ch2bIaDyUCK71C24hbHZUxiV03CVmJfXvLnJ4gzEOkGMfLVDAuLHp7umtdiXqUkQ
        PXSzQdBur5z1QRVugWkQiUL5kL6M/hj1Lb6Jme7mVh2cos8g8UG04B2hxCbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677584005; x=1677670405; bh=OUst0onvS1az3
        p2Wru+5zWDfOfS0/TABrIMuRCVdU1U=; b=s15Ujjrid1NPlWZUk6NcTTNQcTiZr
        rs7UuceCL6kFioVi3VO51dKWnBlaNJ1mgSfjw82hrdcJpllVOZ2R1iIgYPCOwEYu
        eZBTROlskD64DfL6Lw74W7NG4iDzzUo90U91SPIe4FoT9LB+wlka+zEt4zyIE1jv
        j8LwvbBaX3/OgpQnkiqi6LiI1n0I4Wm9WMJaU21+QS2J0Y7gCX18wLYNixdJAzJi
        yY8XF7Sk/wZrYCjKoIUMgzwOGH3TGwBCKwOZlfbMGzMXcTH2K3iFSBgaomYium+V
        P9bRdfFZH2gI02QCmx89ZvMhemCA0q42Ikv/einLbkgInPG52SqSdfeNA==
X-ME-Sender: <xms:heb9Y88-ZO3OdfosvjyUU8-G1Kp-NWoDhemGtLhdOXVjJ4AyVr1rmA>
    <xme:heb9Y0vU5tQMOK3UpsMg2Dabg766cDLsHzlxV6W_D6e5wko4e2Ge-8dKbtQZoihuD
    ow0lruydsmiCZJ779E>
X-ME-Received: <xmr:heb9YyAeiL_mKLPfdyxQUJ0_jCGIw2s9LdxPw9t_uCPpO3ikbk_Q69Di5xO7kVJ-9HoEFTaq9uZ0kighwNwh2oj4cxPTBv4akPPRRlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudelvddgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffogggtgfesthekre
    dtredtjeenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhg
    sehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpedtgfduvedvtdfgkeektd
    ffveeiueeludegheehtdegheduueeuueegtdehjeehheenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihgh
    horghtrdgtohhm
X-ME-Proxy: <xmx:heb9Y8f_aKKPsoxqM4QH8yDE4oAGpQXGe_NBpilvFE0oredtSJ3STg>
    <xmx:heb9YxN2ORa_cjsOni2Wc2qeIO-tBrqZY4f-Z83mpJDudOK6VVc1dg>
    <xmx:heb9Y2n09urrHgz_0qjV4yV5iufc-k1FsmRfXcSobn4QR1enFLV8aA>
    <xmx:heb9Y00WCtuIb0XbbF6fgEcvYQnn_KlLMcdbIeHV57hEtEX1tFvvWQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Feb 2023 06:33:24 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        johan.almbladh@anyfinetworks.com, paulburton@kernel.org,
        bpf@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 0/2] MIPS: Implement two workarounds for BPF JIT
Date:   Tue, 28 Feb 2023 11:33:03 +0000
Message-Id: <20230228113305.83751-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 arch/mips/net/bpf_jit_comp.c   | 4 ++++
 arch/mips/net/bpf_jit_comp64.c | 3 +++
 3 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.37.1 (Apple Git-137.1)

