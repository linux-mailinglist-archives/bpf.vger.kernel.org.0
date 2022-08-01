Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD9558624B
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 03:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238562AbiHABir (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 31 Jul 2022 21:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238770AbiHABim (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 31 Jul 2022 21:38:42 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08FA11A08;
        Sun, 31 Jul 2022 18:38:41 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 021123200754;
        Sun, 31 Jul 2022 21:38:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 31 Jul 2022 21:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1659317919; x=1659404319; bh=6n
        KfbW0v7Y4ArSpwOn82/9CJJgLYAvDqGhJ+A2bxllE=; b=S80hUbKnDlCs5USsr8
        Hf4qml0BxyECU/jxcok4qIV6+PVzahIaoVATXlFrQuXOSgfJ0QZMofbGz6i+Rsic
        ugcgY/w4vA3ChjlTSOCCaHZmzgH4crleqNvXInS28ShnrCCM2gsKT6MmV1QPNugb
        g6Ewv/xz9EFtHglHoBc1se92piDaurQYi9So113BVIcAtyfXHAyWEzeIZa+YuNLj
        /LA4pvEvP45u0yAgTs0R+2oJTP9zXkWC0oOeIGJyWU0k7wluIeEWBVoigLdNDXOx
        YqWmG9xBwHHL/0G5VN1ClTicFCPTkUXi1UgACaP4NUYoKI2PRPskdCX1lmLhQPOg
        yilg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1659317919; x=1659404319; bh=6nKfbW0v7Y4Ar
        SpwOn82/9CJJgLYAvDqGhJ+A2bxllE=; b=KmbnfcWyoxtdB7bJz/kToIkcS///6
        P9n5Rs1Tev189tItvn3Rx0nI+dKkiaIcQ6tiB0rU7ngEGAhCtu8SCT0KbqY/yiq9
        XojJREcelboZn1M7abcAxJIijljyapu/iZKhOmJndX3034SSogYIcmJqkK4eq+pi
        N2g0cfI6HSjJtIlktrqBhBY8RZtrh0UmtQhBEyYSoQvC6kL0ou4F6m61FxIdbchQ
        vnPoVt272g9oPLoVrf1s8T106mnUyg1ulPqMvjepuO2sbLQ2czfLkrL0MAJVYPKU
        LRxTqnpmSloeZn1Gg/4EEGkg0pEZRCGoUXK2ejezRWirHsWxgz+98pUKQ==
X-ME-Sender: <xms:ny7nYkE385Ry_XV-uRF8k1W674TW0l-Xp-dezVU6nMSPUjYydP6swQ>
    <xme:ny7nYtUIFYU008T8abL63s8nIWdJ-hIjVi5mxEe2Lj2KcYNbTjXj_5yy5SzDk4xKs
    yaVqQSFucMEn3Fpag>
X-ME-Received: <xmr:ny7nYuJ4oGElVijAPonH8aiD6hy6TIaa580ZnywTdpdiF7ttwI7LSrLoP94waaE80z7G2MuPFplfELI5yvRZf_aaR926cV1b9ojVy7xdhDxC2sR2Uyd6tBGd0xfk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvvddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehnughr
    vghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrf
    grthhtvghrnhepueduhedvjeeigfejvdfhgffhhfetteetfeffieehtdehjeeglefgffdu
    udejfffhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvshesrghnrghrrgiivghl
    rdguvg
X-ME-Proxy: <xmx:ny7nYmHwKW-4AjNeIo9IvDJaC4pvGTX6ZLAaznu_S0OlKJnzRi0tHw>
    <xmx:ny7nYqVDgvYoM7lH6GVmEf4K2YMH9ocqa3lXx2nEV7hOSDp4kSzadg>
    <xmx:ny7nYpOnP_Ed98_nzSuZoUWRgkzsafVstw8NDa98JEK6N-U68Um8eg>
    <xmx:ny7nYsLuEM3pl97nq-iaYUAYItzc2mRPALeoBgpzq2jR9i56zNS8JQ>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 Jul 2022 21:38:38 -0400 (EDT)
From:   Andres Freund <andres@anarazel.de>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Ben Hutchings <benh@debian.org>
Subject: [PATCH v3 8/8] tools bpftool: Don't display disassembler-four-args feature test
Date:   Sun, 31 Jul 2022 18:38:34 -0700
Message-Id: <20220801013834.156015-9-andres@anarazel.de>
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

The feature check does not seem important enough to display. Requested by
Jiri Olsa.

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Quentin Monnet <quentin@isovalent.com>
Link: http://lore.kernel.org/lkml/20220622181918.ykrs5rsnmx3og4sv@alap3.anarazel.de
Signed-off-by: Andres Freund <andres@anarazel.de>
---
 tools/bpf/bpftool/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 436e671b2657..517df016d54a 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -95,8 +95,7 @@ RM ?= rm -f
 FEATURE_USER = .bpftool
 FEATURE_TESTS = libbfd disassembler-four-args disassembler-init-styled zlib libcap \
 	clang-bpf-co-re
-FEATURE_DISPLAY = libbfd disassembler-four-args zlib libcap \
-	clang-bpf-co-re
+FEATURE_DISPLAY = libbfd zlib libcap clang-bpf-co-re
 
 check_feat := 1
 NON_CHECK_FEAT_TARGETS := clean uninstall doc doc-clean doc-install doc-uninstall
-- 
2.37.0.3.g30cc8d0f14

