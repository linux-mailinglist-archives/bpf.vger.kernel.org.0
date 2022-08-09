Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D18F58DCE5
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 19:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245250AbiHIROK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 13:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245231AbiHIROG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 13:14:06 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297BD24F0A;
        Tue,  9 Aug 2022 10:14:06 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 1640F3200954;
        Tue,  9 Aug 2022 13:14:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 09 Aug 2022 13:14:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1660065244; x=1660151644; bh=NtaGi1m6fH6ewaaVqBbonzc3l
        RMbE0c81K+W27LNgbE=; b=hWKHsPkXIfi8yy+sp748vdOwXCp0qGRcpEMBbvwXq
        zwgZH3vrw1gENagx9PGK+HmKi8O8tYd/O6cH8QHq27jt+ZXu5MWbGnCuf+L3/JyF
        eLFzs9/rfZGbd11QclP4QX83pFYEbVSemv/AaDtxv0yWi2+7QgP/JB6CjTNql/lH
        MoYgF4NSQNdjwVGrWuHFQVXf2QS8y9jACOjuQsAlj0Qd9d6ZwVInajpsT5gTdDPE
        3/72pSNonem8sqoAXBkzEbu5zjFJ2c1cPzSSPeJYeQPXI8h2jr3uDSFyYXfpVN0q
        FuL9RrqTnQaC5ypIGFRYrPILcH5PKc+LpDEBMwmlJGE0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1660065244; x=1660151644; bh=NtaGi1m6fH6ewaaVqBbonzc3lRMbE0c81K+
        W27LNgbE=; b=aD46INOSuhkWgNGcsTBIBBThFkJYWLIhBDkFsCv8X43JHDBokic
        gaTR1WWUygCKhweNfjIIXVsYDERn4IUTKS42Z5bvBTqwONS8LThlvvSwUYtqJjZ0
        J6aQvwu14gPaM8hh+XrPWYtViZyDUc5X2RYsTYBIXMKUK+bwcft0cLd1la0x8g2B
        NXpDlT9ZuMtGpYXXUpxxZMHLgUlIiMHJOUZ0sC5Znpqh6GB0Y1wzRsRBmddVddzJ
        ivkX8YbKM9t4bUlkDI613ZPKBh+ziaW6Gf2b0P/EpYmG1PPjFcCgxJ1Jx0fbLuLc
        996wLl3zMJHcMWvEqu6kVnwfdoLr2K9Weog==
X-ME-Sender: <xms:3JXyYoKc0xFSCelhox0hewqhTwRkq2G2rKORwTUUlHrFToXtrrOpFQ>
    <xme:3JXyYoKLhAFmrSXkrVBSH9dczeltqGCCaP36luq759DYH4CP1EuiSUPjvuCVw4vVU
    sKSyKLxNCswNvhppA>
X-ME-Received: <xmr:3JXyYouK_gmsku0mHDoHVIaXOvrAlXRfJKbJeTWsCq3--PX8Q6eokM0_nLgzNFPTp9g8N8nBXUc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegtddgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpedvgefgtefgleehhfeufe
    ekuddvgfeuvdfhgeeljeduudfffffgteeuudeiieekjeenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:3JXyYlZL4XhmuOr4_S6yT6okm3UM6KTMGJztar_JIeGI5c11L8nffA>
    <xmx:3JXyYvYbKCXbf9pIoht0YVoJBaRvKBhh6ijQaKBEd1l1yBVK560lMw>
    <xmx:3JXyYhCI4XZK8cmFSQ_4S3k6Nuzuz0auSCDX3Dv1BV2tikfQqc26jw>
    <xmx:3JXyYqy8vHTt793jr5ASlwkNV1dB5GRZJv2E_utIDmDdGEuJKH5uDw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Aug 2022 13:14:03 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 0/2] bpf/selftests: Small vmtest.sh fixes
Date:   Tue,  9 Aug 2022 11:11:08 -0600
Message-Id: <cover.1660064925.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Two small quality of life fixes for vmtest.sh:

* Don't require root for `-h`
* Fix unset variable errors for failed option parsing

Daniel Xu (2):
  selftests/bpf: Fix vmtest.sh -h to not require root
  selftests/bpf: Fix vmtest.sh getopts optstring

 tools/testing/selftests/bpf/vmtest.sh | 34 +++++++++++++--------------
 1 file changed, 17 insertions(+), 17 deletions(-)

-- 
2.37.1

