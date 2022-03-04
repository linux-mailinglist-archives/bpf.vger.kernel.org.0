Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E794CD39E
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 12:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbiCDLjU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Mar 2022 06:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236264AbiCDLjT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 06:39:19 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860F574629;
        Fri,  4 Mar 2022 03:38:30 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id C24063200F76;
        Fri,  4 Mar 2022 06:38:29 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 04 Mar 2022 06:38:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kkourt.io; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=mesmtp; bh=Gy3tSBO8IHs1mjjECvdkiou/qGkQa3BE2jjRgMF+fhg=; b=uG
        By56qClk9Qno8wSiIRwWXnvRpWfmRvPxPUa/mhb5EHlD6GsVXZWx10O8RSBFERfR
        k8aAT6p388NuiYfwtm0EZ+pC5CQo+iAaqUpnfYlzv1AOyQzHVZX+6jIIiIHVYhRA
        5suk535PVlI30Q0FgqLoW2BXvRTjtLHtw1ou/5lIs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=Gy3tSBO8IHs1mjjECvdkiou/qGkQa
        3BE2jjRgMF+fhg=; b=BvkQDo/LydqMR+lLvt1PtFmqpdaVM7qYLXnX4+0vHabmo
        yOCF7Kx7YKEmZQb9zpX6Gttau4H42wJqeZuNDSCwOW6vlwLzRhHZUz+Wtspjooie
        id+8HgUNNHBDwW85gimvqr8yF8K+1SRkdidr+Ht2E/p0ILBCu7tscBL4cMMb20Km
        8TwVqp1NFuvFFaVPkVIXFznsgCCA+hYIGjBtgUfW/SYu7hfXUV13oMh73goBI7Hu
        PySrABNdwdlAj5U6SDaKs6v5Ur99ZRwF4ZNoQhcvZuuaZn2ufWkfjPCcmnmFH+m9
        ygZKwUHBuFUth8VTgfqBEKgZrIgMEiZZI8dSL21GQ==
X-ME-Sender: <xms:NfohYtgh8UUXOv_B8IvXSJorBieibNs7_hM3QXaXlFh5K33QkAdbWA>
    <xme:NfohYiCVKTdsmeFSnfAiR4L2cw3tSqHaNozB1dyaZFwLsD2kZCtQ-nZ5MV_k8aog8
    STlPiMh6GhTlhdRrw>
X-ME-Received: <xmr:NfohYtGWjwlzi1vrOoZUFcxWWDKrqH94edwLM_Bde3Xs5L84XWJg9P5J_lhPpPuEuEE0X5pWMtntw3hAPPxRIwK71QxH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtkedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpehkkhhouhhrthes
    khhkohhurhhtrdhiohenucggtffrrghtthgvrhhnpeelkeeffeejleeihfehgeeltdevle
    ffgfffleevuefhhedtieevudejuefgudehieenucffohhmrghinhepshhouhhrtggvfigr
    rhgvrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhkohhurhhtsehkkhhouhhrthdrihho
X-ME-Proxy: <xmx:NfohYiRpMp-HLyThVxmKTN5Difl3LjzGTYa8O_x9IXXB42LZk-RxxQ>
    <xmx:NfohYqzgYHSKmjWmKx0YkLSxI6yhui_Yk01QiOFN472yANX7S_GBFw>
    <xmx:NfohYo7NkF6T9KTc4JaRloJspw7BFP8Zqkn6rfb3fKBx1_lwctm00w>
    <xmx:NfohYu8WhO0YLgEqtuVARkCGG1Gfqpw_BskOYcqtM6fPIvVd-h79Pw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Mar 2022 06:38:29 -0500 (EST)
Received: by kkourt.io (Postfix, from userid 1000)
        id C11A22541AC9; Fri,  4 Mar 2022 12:38:27 +0100 (CET)
From:   kkourt@kkourt.io
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kornilios Kourtis <kornilios@isovalent.com>
Subject: [PATCH] pahole: avoid segfault when parsing a problematic file
Date:   Fri,  4 Mar 2022 12:38:21 +0100
Message-Id: <20220304113821.2366328-1-kkourt@kkourt.io>
X-Mailer: git-send-email 2.35.1
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

When trying to use btf encoding for an apparently problematic kernel file,
pahole segfaults. As can be seen below [1], the problem is that we are trying to
dereference a NULL decoder.

Fix this by checking the return value of dwfl_getmodules which [2] whill return
-1 on errors or an offset if one of the modules did not return DWARF_CB_OK. (In
this specific case, it was __cus__load_debug_types that returnd
DWARF_CB_ABORT.)

Also, ensure that we get a reasonable error by setting errno in
cus__load_files(). Otherwise, we get a "No such file or directory" error which
might be confusing.

After tha patch:
$ ./pahole -J vmlinux-5.3.18-24.102-default.debug
pahole: vmlinux-5.3.18-24.102-default.debug: Unknown error -22

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
 dwarves.c      | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index e30b03c..fecf711 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -3235,7 +3235,10 @@ static int cus__process_file(struct cus *cus, struct conf_load *conf, int fd,
 	};
 
 	/* Process the one or more modules gleaned from this file. */
-	dwfl_getmodules(dwfl, cus__process_dwflmod, &parms, 0);
+	int err = dwfl_getmodules(dwfl, cus__process_dwflmod, &parms, 0);
+	if (err) {
+		return -1;
+	}
 
 	// We can't call dwfl_end(dwfl) here, as we keep pointers to strings
 	// allocated by libdw that will be freed at dwfl_end(), so leave this for
diff --git a/dwarves.c b/dwarves.c
index 81fa47b..c5935ec 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -2391,8 +2391,11 @@ int cus__load_files(struct cus *cus, struct conf_load *conf,
 	int i = 0;
 
 	while (filenames[i] != NULL) {
-		if (cus__load_file(cus, conf, filenames[i]))
+		int err = cus__load_file(cus, conf, filenames[i]);
+		if (err) {
+			errno = err;
 			return -++i;
+		}
 		++i;
 	}
 
-- 
2.25.1

