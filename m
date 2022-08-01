Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D44586242
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 03:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238800AbiHABio (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 31 Jul 2022 21:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238763AbiHABil (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 31 Jul 2022 21:38:41 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352FFD117;
        Sun, 31 Jul 2022 18:38:40 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 89CD43200657;
        Sun, 31 Jul 2022 21:38:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 31 Jul 2022 21:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1659317916; x=1659404316; bh=dV
        c9P++/u7qpDN8YdVfqt3p7KluPysUuZhmsQzEDFw4=; b=foAdVuru3iETy4FWr2
        vCW7fzK5U2czaPK9CwCLTo0yDTjCjPqlgRDkD0+/2CLRa3AHDGDcx/kHE8zFnvr+
        DmS8VZA2WGj3pmWAQM524ACeQlW38CfkRi7Qt3tpmNpmVn1RhqwrH5cXLFcCUztK
        Ln718HRHlMWb+I4sCpcM0oxxh76oShGccsD2jXEnjYtvvByjYnaRCspZFFdhdUub
        IxBiJDCtruRwhrV2U6V3L5vAyi36Op9RKZBKBMZPRzLVY3oyWdUa82vaBbLAKHYU
        eyrSZJB1P/tfQtFhBx3Kn/T5Yk20QjhxYekGP9ceAwjWBPzi0HpodUn5Ic2VuQDu
        FJ+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1659317916; x=1659404316; bh=dVc9P++/u7qpD
        N8YdVfqt3p7KluPysUuZhmsQzEDFw4=; b=UVRAmjU0y2ASWjXq6mgqu1H+5uCag
        UHnfOps0MrFz7aSRMSX4rYBXFXRiueHV3n3Yj75s+sGAJG1MZvxCL3v+y5ZMyQ2m
        C19XSGHCuNBfTnOOHXbT1D5rfQNsrqXw+leLjBJ2enUuK5I6bSBgAXuKULIQpvZU
        D1xRKhLy28alRe8rJOa1H39xM18tdqvkT3R+8wCnGj9D2CZIeCOsQRvewEuOpx/F
        5cgpmBOUVdAK9CZpqcELGBhg+7pBYEAcosIlnQZ6ARcQCcUdo1JNbL6ZcDpLwtY0
        hclzScYCLEbkzdWLJeRQpDVbQqCGsqtUNk276eXOJT2W92JFeCeqNAz+g==
X-ME-Sender: <xms:nC7nYnjYamhK0M0qJz9-UyuKGb3yLk9Um-NAYip_zO8D3N9W7U2YiA>
    <xme:nC7nYkAXkFpUaAlmQ6nHn7zjVFoMpnXbe3BqDD56vrR_-oUd7CwkLmDVXTCFpuLkh
    GdOMTGImYHCZNqmZg>
X-ME-Received: <xmr:nC7nYnG-neouc1lhmU7NrRRb8C0aUnZyN3hQnxO_vIzBexsdQbakEAlkSkWcgZFnPvQIAALqHGKWs7zBkcn0dHQ4q-uLcGZQcTAhTTA50ZMsgPbyhzf5DJl1BC2P>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvvddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehnughr
    vghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrf
    grthhtvghrnhepueduhedvjeeigfejvdfhgffhhfetteetfeffieehtdehjeeglefgffdu
    udejfffhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvshesrghnrghrrgiivghl
    rdguvg
X-ME-Proxy: <xmx:nC7nYkQIU3FELKpzdbueN4mOzZZFWmV_h33ghPg5xeE75C2m8iDTug>
    <xmx:nC7nYkxhu6wnTw1XiH_7-OJKu5mXwy9OUO6qMEUllSrlachBYNXwnQ>
    <xmx:nC7nYq5RKQCSOovFLsgml1T7nKqa-_79nHOmcEa8bPr_ehc_32dDJw>
    <xmx:nC7nYrlLnxq3M8TG7dlQdnWmP6HvBxVWE_8HcxMotV_KbLVXH-OIQA>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 Jul 2022 21:38:36 -0400 (EDT)
From:   Andres Freund <andres@anarazel.de>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Ben Hutchings <benh@debian.org>
Subject: [PATCH v3 2/8] tools build: Don't display disassembler-four-args feature test
Date:   Sun, 31 Jul 2022 18:38:28 -0700
Message-Id: <20220801013834.156015-3-andres@anarazel.de>
X-Mailer: git-send-email 2.37.0.3.g30cc8d0f14
In-Reply-To: <20220801013834.156015-1-andres@anarazel.de>
References: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de>
 <20220801013834.156015-1-andres@anarazel.de>
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

The feature check does not seem important enough to display. Suggested by
Jiri Olsa.

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Quentin Monnet <quentin@isovalent.com>
Link: http://lore.kernel.org/lkml/20220622181918.ykrs5rsnmx3og4sv@alap3.anarazel.de
Signed-off-by: Andres Freund <andres@anarazel.de>
---
 tools/build/Makefile.feature | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 8f6578e4d324..fc6ce0b2535a 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -135,8 +135,7 @@ FEATURE_DISPLAY ?=              \
          get_cpuid              \
          bpf			\
          libaio			\
-         libzstd		\
-         disassembler-four-args
+         libzstd
 
 # Set FEATURE_CHECK_(C|LD)FLAGS-all for all FEATURE_TESTS features.
 # If in the future we need per-feature checks/flags for features not
-- 
2.37.0.3.g30cc8d0f14

