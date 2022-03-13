Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730434D78A9
	for <lists+bpf@lfdr.de>; Mon, 14 Mar 2022 00:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbiCMXCy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 13 Mar 2022 19:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235529AbiCMXCx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 13 Mar 2022 19:02:53 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD9678058;
        Sun, 13 Mar 2022 16:01:44 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 72E905C0175;
        Sun, 13 Mar 2022 19:01:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 13 Mar 2022 19:01:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; bh=IYDs9sc8CZWwGN2YWUzzkzbqy9h9TzeQqqKGJhDYOyg=; b=VaNMM
        Y6htFQ1IOtt3JepcdIIILrK8Nrs1VHjfmT4r+I9Pnd2CR/e4FgqNmmmrJtRlOB+/
        Ad+EBCBSvT1bafkDnfYEEA3YcvowA/rgo3pZEijzaY46ulHg/3CMu/HBce1GiTm5
        LcRZy8UFPx6I2sm50NugEq6+zQv4PLHgZCvyz8G/eYe8iXMTyPmFfDKBVQe8iPKg
        r306pNNnt3NqUvYQ0VLb6kKrSG3PWY/6TOCVttdQ5Fe0soA4loRkKGySUNw/7ZKj
        0bmggydtyAEwIbFtzytJlf9IKiFirx4HpzwqkbOcymBw03UNn1V4JPVfx20VBQH1
        G6b8F6giVqxak2XNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=IYDs9sc8CZWwGN2YWUzzkzbqy9h9T
        zeQqqKGJhDYOyg=; b=btOWXUv+FylGBCjdTzkEvmw7dtHXJOLFVpcMheEt5RzGD
        G5OtqWBJGwDNkwPDu4aUbX/4WipE7t0v1oRESRwmGelFoF7UxQa55aZEcsebIC/P
        ixb7J1CjZQWDtt4H0+r/7FX+rjxdg0/9h3LBICbyr61Zqf90VXE+D0HLD37sZuiH
        O6kc3Qw3VagpQr1C5MwoTe/sRi2Ss8YflBr0ShQNOI8u3RJZOqSZr6F/rN2IxsA6
        aUgL3s8VLBcRABoTLjNoht3eXLJW1MbVoMcuW/eKLrmYU64ojWHDhQUwWD/KtvvN
        vgrM7sPbM54AZvPsU7AKwc65F1uxqFoJ9wyV7dKnw==
X-ME-Sender: <xms:1ncuYkWCfFZm3HTIxg4AhozwPN68LJSuEKPzoW-UWt18jd-1O-ZsHw>
    <xme:1ncuYomRn-V1_jc2CYh0rjBxb8c0V6Xqvxx0c53Jj8sd_X0JIBqsjdDK3Z0hVhGYv
    RQY_2qoxeDGZOtnfg>
X-ME-Received: <xmr:1ncuYoZlXhHuDN2FxIEr2IQsBjtEq7K39_9raHVPFrpqp-DOnkBx1LqBSANpUGYl-znwP6-xdY2QuyjX-fyE6sweIVSVL2uxi14V0X7JcfC0LA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddvjedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihu
    segugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeeifffgledvffeitdeljedvte
    effeeivdefheeiveevjeduieeigfetieevieffffenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:1ncuYjUK00Sa5zLb-pgByauFxUaAUISX9OPJYvVPzkciS-zBr3SweA>
    <xmx:1ncuYum6JoTi-zBM5SFibGK_YOj0YgPBqhLzTsLMjlJJMbX-3ecYsw>
    <xmx:1ncuYoeHHe54oQj3BOM2MG_I_yDOFAAbRrhc4lEUgFNnu7--CqZSyA>
    <xmx:1ncuYvC94GKVHo2QxTUlQEKUkaxMscssKnv1stOkfT35zcINSvXAYw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Mar 2022 19:01:41 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpftool: Add SPDX identifier to btf-dump-file output
Date:   Sun, 13 Mar 2022 16:01:26 -0700
Message-Id: <1d2931e80c03f4d3f7263beaf8f19a4867e9fe32.1647212431.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A concern about potential GPL violations came up at the new $DAYJOB when
I tried to vendor the vmlinux.h output. The central point was that the
generated vmlinux.h does not embed a license string -- making the
licensing of the file non-obvious.

This commit adds a LGPL-2.1 OR BSD-2-Clause SPDX license identifier to
the generated vmlinux.h output. This is line with what bpftool generates
in object file skeletons.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/bpf/bpftool/btf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index a2c665beda87..fca810a27768 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -425,6 +425,7 @@ static int dump_btf_c(const struct btf *btf,
 	if (err)
 		return err;
 
+	printf("/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */\n\n");
 	printf("#ifndef __VMLINUX_H__\n");
 	printf("#define __VMLINUX_H__\n");
 	printf("\n");
-- 
2.35.1

