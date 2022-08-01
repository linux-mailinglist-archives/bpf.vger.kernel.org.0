Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1A8586243
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 03:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238807AbiHABip (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 31 Jul 2022 21:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238765AbiHABil (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 31 Jul 2022 21:38:41 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C16BD118;
        Sun, 31 Jul 2022 18:38:41 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 0FD61320077A;
        Sun, 31 Jul 2022 21:38:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sun, 31 Jul 2022 21:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1659317919; x=1659404319; bh=rD
        7/11Zj88Bzau+Vwi4eZX1L45MuyWwCwsxlNl9bPbo=; b=O9dsZiya22K/CCej90
        Cq8/IEDMFgPUag4IhOP3cDes6/uEl4K5BaC2oNvcNw4ONIDXI76k7C9Xv6fL/PhC
        v2vOXHvAv8l8NSvjgRkk1YV9H0RuiR/CL4P92rHj1faQuH2oqULZBG9zIadd3rjI
        t0C2ZtA/t6zAWaSVNyixIaZgS7s6OCYVVgHxo6797VvSAcCQESkC8nk8dbpR1LBY
        1+IbXDLqvdZ1XtCu0yKqWhkpC5mUHt4axk43VeGXqySZi/diVNkZ1LZt34ftA/5k
        E90HQiLOwVWPWJNmc6Z0f9WOrGa4RgiOnCfulQCvV3y4FyTPdzNL7Q3mcUV7QMyU
        B9UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1659317919; x=1659404319; bh=rD7/11Zj88Bza
        u+Vwi4eZX1L45MuyWwCwsxlNl9bPbo=; b=sp1Z2nGdxv4sx0AYKoO8u8M0Cio12
        tAasnqd1WoQ67MyQ2hABZz85PZAhwEzmiqeIx+HH4IKZ4RG4DFLA9SHDQw0PhqaR
        27DtggW/j9xkDL60xELIbwmJDgQzTsdyJ/2o9s5nYvka2qXjvOH4y+F/sa26fV92
        E61uzA2MXqvMqXmVy7bdPRub+m1DWT7TWzFQ/QSVfFksrDZqY30KE/TqwZjFQ9FP
        0V9ERXC03ArPHe4yGIn2LPqFtNWwr7AkaflE0VZ7L5kA8uziToVTbJHU1nxtRJB+
        7MpqCo6j5JHP7AaViTKuas9ILeVYBeCLstKVwqebveLCX3ihW/58O3fdw==
X-ME-Sender: <xms:ny7nYsQWO4InSOu46Eo-byMlNJzwqyBFOC8th9-3GnFfAzWHboBAGA>
    <xme:ny7nYpzlQsYwJNu43DEmGJKlEXmGHAAQK28niWHHHnC9-uUEwZw_FTcL1Exv0gEMJ
    FDTeBsoWYNETA6-AQ>
X-ME-Received: <xmr:ny7nYp1D9m9A7HQMvMC0XwLJxA6zqo6GbZHOJS7XUDTEmfAnF6Lt13b0sb5hTtnwxAAIIXrSwpC7VXAQwMbjQGrLCloZ6XZ83GNF07IdRJ9Yr3h1JkA89TmLUD9O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvvddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehnughr
    vghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrf
    grthhtvghrnhepueduhedvjeeigfejvdfhgffhhfetteetfeffieehtdehjeeglefgffdu
    udejfffhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvshesrghnrghrrgiivghl
    rdguvg
X-ME-Proxy: <xmx:ny7nYgBEOawl65or0wqzvaIbzjurzR5AEYVdOoQ1ZSSWbIG8T2mb0w>
    <xmx:ny7nYli4vbP_OG6LIFIctqMfr3VshxKblmTSevqZbsxC6ApPH3nV3g>
    <xmx:ny7nYsopbb3KR8wIEG7M2bV1YQBDDYtASqNKkSGjx1Vd1SPyx8bd2Q>
    <xmx:ny7nYtgO4VlMiFWArA1elH-h2wDG_LUL10wCvsgxFZA2blFrVb7MyA>
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
        Ben Hutchings <benh@debian.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v3 6/8] tools bpf_jit_disasm: Don't display disassembler-four-args feature test
Date:   Sun, 31 Jul 2022 18:38:32 -0700
Message-Id: <20220801013834.156015-7-andres@anarazel.de>
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
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Quentin Monnet <quentin@isovalent.com>
Link: http://lore.kernel.org/lkml/20220622181918.ykrs5rsnmx3og4sv@alap3.anarazel.de
Signed-off-by: Andres Freund <andres@anarazel.de>
---
 tools/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/Makefile b/tools/bpf/Makefile
index 664601ab1705..243b79f2b451 100644
--- a/tools/bpf/Makefile
+++ b/tools/bpf/Makefile
@@ -35,7 +35,7 @@ endif
 
 FEATURE_USER = .bpf
 FEATURE_TESTS = libbfd disassembler-four-args disassembler-init-styled
-FEATURE_DISPLAY = libbfd disassembler-four-args
+FEATURE_DISPLAY = libbfd
 
 check_feat := 1
 NON_CHECK_FEAT_TARGETS := clean bpftool_clean runqslower_clean resolve_btfids_clean
-- 
2.37.0.3.g30cc8d0f14

