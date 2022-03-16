Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5D24DB157
	for <lists+bpf@lfdr.de>; Wed, 16 Mar 2022 14:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241948AbiCPNZG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Mar 2022 09:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241443AbiCPNZF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Mar 2022 09:25:05 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B8D33E37;
        Wed, 16 Mar 2022 06:23:52 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 49B613202010;
        Wed, 16 Mar 2022 09:23:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 16 Mar 2022 09:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kkourt.io; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=mesmtp; bh=bENHhIi915KsPjgABUpRtuQfqeP
        QoymgG+Vo887wrCc=; b=ThPMiqaRipdQRREPicRBAfL5RZN0Arp5CRNwQRMghW7
        IWz9jCKtOtIPwN8ER78Y66h6G6DnWYO6Vgh6+uQQf2A4aCYckDwBJSg2Ypi58Ono
        GAxxHyXJ5SmCAjmWMtaQufccAPWVZArFiePoH1oHzVNPKRtUR9oR8JTxko8GIS8Q
        =
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=bENHhI
        i915KsPjgABUpRtuQfqePQoymgG+Vo887wrCc=; b=GVZ8IFqGGnEylI1Gd/HqP1
        BfIk46n62ljKMPRmki2auOerraMtzlXsbxc4dZa0QlbMEsi9b8nAR++hkFbEusys
        iAS7QayhoYvUtlstxONb2pF87IfH46xrXAgivb8d18f3Fn+DEInCdwi53Q1we6bW
        6YONofyrAvqBwD+by6PFo7guABjStb22r23a/fz2UgPuzN1i+JF6FAucjErcR/sH
        E+P2Atu1XxOAe3yff8zkSn9Px6JQcKG2TBQvhjNMRiLKjpH64BsJZ+MvY69JZFil
        JQVI7nykMKDhajiabYjZsDCd+iNLVSgnYaIVQNm3KWilkdQ98i5mLWTTBwvNbSrg
        ==
X-ME-Sender: <xms:5uQxYn0pDrlAMbNSDk19o4i1qtD3t7HHPn8_NAup1QG2Wdw_zEZmtQ>
    <xme:5uQxYmEUgHHBa__jXd8X3RlbUQRhfB7PW-xj6VTi4ABhWy_fz7_dO4BBAk95fMEk9
    f7uesZVvzdZ1veafQ>
X-ME-Received: <xmr:5uQxYn4rpERdhR5jNEuXxiQSyh6A87jqkbY7rLuOLS4ts3QbUu4NMzSKjVZQq9qCnBgzbcoLDNwqNj_hGZ4KmxBa0ydt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudefvddggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpehkkhhouhhr
    theskhhkohhurhhtrdhiohenucggtffrrghtthgvrhhnpeekkeeuiedujeekvdefjefffe
    eggfdugeettdeiieevgffghfelgeetffeijeegffenucffohhmrghinhepshhouhhrtggv
    figrrhgvrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepkhhkohhurhhtsehkkhhouhhrthdrihho
X-ME-Proxy: <xmx:5uQxYs0kBVqKuW6gupNhMVxNHyW9QEmCNykD0J9JsknrQGSWdtJkNw>
    <xmx:5uQxYqGdgOKLIN6XWKs1jzVIw7Je3EumIP4hsOuemNYLzjvow6Rb0w>
    <xmx:5uQxYt9ftG2Z7JlzeUVBdWbrgPLBZQdtC67LtWhXQek2K1Kb1gXjAA>
    <xmx:5uQxYmBCr21vwoVnVYoFGMfW0GDTyeGZOG4cw2A9tg-22XgTB9OAKA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Mar 2022 09:23:50 -0400 (EDT)
Received: by kkourt.io (Postfix, from userid 1000)
        id 21ADB2541B5C; Wed, 16 Mar 2022 14:23:48 +0100 (CET)
From:   kkourt@kkourt.io
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kornilios Kourtis <kornilios@isovalent.com>
Subject: [PATCH 1/2] pahole: avoid segfault when parsing bogus file
Date:   Wed, 16 Mar 2022 14:23:38 +0100
Message-Id: <20220316132338.3226871-1-kkourt@kkourt.io>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <YjHjLkYBk/XfXSK0@tinh>
References: <YjHjLkYBk/XfXSK0@tinh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Kornilios Kourtis <kornilios@isovalent.com>

When trying to use btf encoding for an apparently problematic kernel
file, pahole segfaults. As can be seen below [1], the problem is that we
are trying to dereference a NULL decoder.

Fix this by checking the return value of dwfl_getmodules which [2] whill
return -1 on errors or an offset if one of the modules did not return
DWARF_CB_OK. (In this specific case, it was __cus__load_debug_types that
returned DWARF_CB_ABORT.)

[1]:
$ gdb -q --args ./pahole -J vmlinux-5.3.18-24.102-default.debug
Reading symbols from ./pahole...
(gdb) r
Starting program: /tmp/pahole/build/pahole -J vmlinux-5.3.18-24.102-default.debug
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".

Program received signal SIGSEGV, Segmentation fault.
0x00007ffff7f4000e in gobuffer__size (gb=0x18) at /tmp/pahole/gobuffer.h:39
39              return gb->index;
(gdb) bt
(gdb) frame 1
1042            if (gobuffer__size(&encoder->percpu_secinfo) != 0)
(gdb) list
1037
1038    int btf_encoder__encode(struct btf_encoder *encoder)
1039    {
1040            int err;
1041
1042            if (gobuffer__size(&encoder->percpu_secinfo) != 0)
1043                    btf_encoder__add_datasec(encoder, PERCPU_SECTION);
1044
1045            /* Empty file, nothing to do, so... done! */
1046            if (btf__get_nr_types(encoder->btf) == 0)
(gdb) print encoder
$1 = (struct btf_encoder *) 0x0

[2] https://sourceware.org/git/?p=elfutils.git;a=blob;f=libdwfl/libdwfl.h;h=f98f1d525d94bc7bcfc7c816890de5907ee4bd6d;hb=HEAD#l200

Signed-off-by: Kornilios Kourtis <kornilios@isovalent.com>
---
 dwarf_loader.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 151bc83..c87378b 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -3268,7 +3268,10 @@ static int cus__process_file(struct cus *cus, struct conf_load *conf, int fd,
 	};
 
 	/* Process the one or more modules gleaned from this file. */
-	dwfl_getmodules(dwfl, cus__process_dwflmod, &parms, 0);
+	int err = dwfl_getmodules(dwfl, cus__process_dwflmod, &parms, 0);
+	if (err) {
+		return -1;
+	}
 
 	// We can't call dwfl_end(dwfl) here, as we keep pointers to strings
 	// allocated by libdw that will be freed at dwfl_end(), so leave this for
-- 
2.25.1

