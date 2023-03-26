Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5336C9261
	for <lists+bpf@lfdr.de>; Sun, 26 Mar 2023 06:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjCZEke (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 26 Mar 2023 00:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjCZEkd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 26 Mar 2023 00:40:33 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8B1618D;
        Sat, 25 Mar 2023 21:40:30 -0700 (PDT)
X-UUID: b6cde0c7e2b64c718c7dc18a8eab4dc3-20230326
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:8e8edc52-f736-4f72-9b68-3722b697739c,IP:10,
        URL:0,TC:0,Content:0,EDM:25,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:36
X-CID-INFO: VERSION:1.1.20,REQID:8e8edc52-f736-4f72-9b68-3722b697739c,IP:10,UR
        L:0,TC:0,Content:0,EDM:25,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:36
X-CID-META: VersionHash:25b5999,CLOUDID:0cdd7f29-564d-42d9-9875-7c868ee415ec,B
        ulkID:230326123044RXI7AJ6O,BulkQuantity:3,Recheck:0,SF:38|24|17|19|43|102,
        TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,O
        SI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: b6cde0c7e2b64c718c7dc18a8eab4dc3-20230326
X-User: guodongtai@kylinos.cn
Received: from localhost.localdomain [(210.12.40.82)] by mailgw
        (envelope-from <guodongtai@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 124657828; Sun, 26 Mar 2023 12:40:21 +0800
From:   George Guo <guodongtai@kylinos.cn>
To:     chenhuacai@kernel.org, masahiroy@kernel.org,
        michal.lkml@markovi.net
Cc:     kernel@xen0n.name, ndesaulniers@google.com, daniel@iogearbox.net,
        ast@kernel.org, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH] loongarch/bpf: Fix bpf load failed with CONFIG_BPF_JIT_ALWAYS_ON, caused by jit (BPF_ST | BPF_NOSPEC) code
Date:   Sun, 26 Mar 2023 12:40:19 +0800
Message-Id: <20230326044019.2139628-1-guodongtai@kylinos.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Here just skip the code(BPF_ST | BPF_NOSPEC) that has no couterpart to the loongarch.

To verify, use ltp testcase:

Without this patch:
$ ./bpf_prog02
... ...
bpf_common.c:123: TBROK: Failed verification: ??? (524)

Summary:
passed   0
failed   0
broken   1
skipped  0
warnings 0

With this patch:
$ ./bpf_prog02
... ...
Summary:
passed   0
failed   0
broken   0
skipped  0
warnings 0

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 arch/loongarch/net/bpf_jit.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 288003a9f0ca..745d344385ed 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1046,6 +1046,11 @@ static int build_body(struct jit_ctx *ctx, bool extra_pass)
 		if (ctx->image == NULL)
 			ctx->offset[i] = ctx->idx;
 
+		/* skip the code that has no couterpart to the host arch */
+		if(insn->code == (BPF_ST | BPF_NOSPEC)) {
+			continue;
+		}
+
 		ret = build_insn(insn, ctx, extra_pass);
 		if (ret > 0) {
 			i++;
-- 
2.34.1

