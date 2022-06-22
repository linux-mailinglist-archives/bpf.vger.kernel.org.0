Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9C9555338
	for <lists+bpf@lfdr.de>; Wed, 22 Jun 2022 20:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343838AbiFVSTZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jun 2022 14:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359782AbiFVSTY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jun 2022 14:19:24 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD00101C9;
        Wed, 22 Jun 2022 11:19:23 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id B9FDB3200944;
        Wed, 22 Jun 2022 14:19:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 22 Jun 2022 14:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1655921960; x=1656008360; bh=BOv4zfNJ43
        lhXbjUgMokcKvSsmqFJ3GbVqMgFbujkcE=; b=mdJUuWzirR/P8hMbptpAD4g8Fh
        LImJfkZ9hI0GD7bEKnt8qiBrUrP8AhMel4ULyqF7VihPUC/q4aAxjr++9Oher/2W
        fZLoohOTohGX7hwXQ7evWdrLrUAWgv4JtHxTUnaJupvhIc9pa1IXzkCQdHcfrzMo
        fd9gBe2FnZRVOcDmpZJzTLkoG4H74i2EPFbZUKMesUTpdLVGYnfPeK1+xlcAamuS
        QuDifaykE/y1EnxMmF90UMqB7WJvsK3bBsI9KQuO6LHczXcF3P1vlsEYg4w1FE1t
        qQ8RgVrB8PCtmCAXff8AcImDM3ffktIOIbRxU+UhBjwcuMPFOV8mnPRjmyDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1655921960; x=1656008360; bh=BOv4zfNJ43lhXbjUgMokcKvSsmqF
        J3GbVqMgFbujkcE=; b=hGMTqY61Hvpqs/2+evnS+K0/LYzuCEMPN1jy1h04BVZ2
        N1qI80eSHyarrLp6gd33BZ798ApAlEksAY1RhT6yZrL0f20XwcDW6ZzicD1uA7c9
        xhMh/bxNQvKy4+rkVrvz8umsnGb6yPDt2wk5Kz9Cdcm3MGD8TkpkhZo5scTqmpcj
        pBwQQ8Il62DdLrP+Zc0ArAnnP24kn29cmx2AJCvrj5BNMWhXVw4KhaDeqhiKn82W
        IRHd8N1EYtX98tAL4rdUmKmDDCngadLTUBw1GUmbwLniMra7N68eOFpYZ+72TOpV
        NgHbBKu2dlBd+6h4QEtRFj+8qqmleNg45vbDe9rekA==
X-ME-Sender: <xms:J12zYlFJlJbKz20mk3qUSGZdrlPGwQH-fKXg0BLUtKM8K-U1CGP4QQ>
    <xme:J12zYqUZpHOZkgdIBvaBkhfOozxoZy2mKsCOEpuLeMKL5zfdM4AQGBDjRqGP3b0YD
    N1WNIxVmTSTKpAMNQ>
X-ME-Received: <xmr:J12zYnKBZV1xKyoLHtaClR9mVT_Hm53eruePoDpwnd-INCNa3ctPmXbb5mqlFiZgMqYfQvxuZscyGls38_Yg4GhocG4a8xxxr3FYkyblTrL9b-VEnug8d-FX2yl9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefhedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkgggtugfgsehmkeerredttdejnecuhfhrohhmpeetnhgurhgv
    shcuhfhrvghunhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqeenucggtffrrg
    htthgvrhhnpeehtedtueegueekkeelkeehleffteejjeekheeifeelvefgvddugfefkeel
    feekleenucffohhmrghinhepshhouhhrtggvfigrrhgvrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvghssegrnhgrrhgr
    iigvlhdruggv
X-ME-Proxy: <xmx:J12zYrH1f2xubPTW4NkCcUjYnLOyGyIkkDAVFfX_gR1AhAxfuN9bvQ>
    <xmx:J12zYrVmqGLdCk7VSdDJb6nUatl_PdWyozSImL52Arj5-d7JusCICg>
    <xmx:J12zYmP1vHN-M5cuMkQaP0QqCmTfex9z635CG7guFHv0A_dLyWK4jQ>
    <xmx:KF2zYoi1c0-83PiLAK0B9Z-673tMjYLy1_P7SIF-vgUP2RTDAOd6Ww>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jun 2022 14:19:19 -0400 (EDT)
Date:   Wed, 22 Jun 2022 11:19:18 -0700
From:   Andres Freund <andres@anarazel.de>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: init_disassemble_info() signature changes causes compile failures
Message-ID: <20220622181918.ykrs5rsnmx3og4sv@alap3.anarazel.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="yy7koo44v5in4hu5"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--yy7koo44v5in4hu5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,

binutils changed the signature of init_disassemble_info(), which now causes
perf and bpftool to fail to compile (e.g. on debian unstable).

Relevant binutils commit: https://sourceware.org/git/?p=binutils-gdb.git;a=commitdiff;h=60a3da00bd5407f07d64dff82a4dae98230dfaac

util/annotate.c: In function ‘symbol__disassemble_bpf’:
util/annotate.c:1765:9: error: too few arguments to function ‘init_disassemble_info’
 1765 |         init_disassemble_info(&info, s,
      |         ^~~~~~~~~~~~~~~~~~~~~
In file included from util/annotate.c:1718:
/usr/include/dis-asm.h:472:13: note: declared here
  472 | extern void init_disassemble_info (struct disassemble_info *dinfo, void *stream,
      |             ^~~~~~~~~~~~~~~~~~~~~

with equivalent failures in

tools/bpf/bpf_jit_disasm.c
tools/bpf/bpftool/jit_disasm.c

The fix is easy enough, add a wrapper around fprintf() that conforms to the
new signature.

However I assume the necessary feature test and wrapper should only be added
once? I don't know the kernel stuff well enough to choose the right structure
here.

Attached is my local fix for perf. Obviously would need work to be a real
solution.

Greetings,

Andres Freund

--yy7koo44v5in4hu5
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="perf-compile-bfd.diff"

diff --git i/tools/perf/util/annotate.c w/tools/perf/util/annotate.c
index 82cc396ef516..b0e364d235b4 100644
--- i/tools/perf/util/annotate.c
+++ w/tools/perf/util/annotate.c
@@ -1721,6 +1721,18 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 #include <bpf/libbpf.h>
 #include <linux/btf.h>
 
+static int fprintf_styled(void *, enum disassembler_style, const char* fmt, ...)
+{
+  va_list args;
+  int r;
+
+  va_start(args, fmt);
+  r = vprintf(fmt, args);
+  va_end(args);
+
+  return r;
+}
+
 static int symbol__disassemble_bpf(struct symbol *sym,
 				   struct annotate_args *args)
 {
@@ -1763,7 +1775,8 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 		goto out;
 	}
 	init_disassemble_info(&info, s,
-			      (fprintf_ftype) fprintf);
+			      (fprintf_ftype) fprintf,
+			      fprintf_styled);
 
 	info.arch = bfd_get_arch(bfdf);
 	info.mach = bfd_get_mach(bfdf);

--yy7koo44v5in4hu5--
