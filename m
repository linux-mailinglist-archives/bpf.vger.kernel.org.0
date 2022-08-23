Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A23E59E1ED
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 14:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358368AbiHWLwV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 07:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358871AbiHWLvJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 07:51:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CCFD347C;
        Tue, 23 Aug 2022 02:31:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4C48B81C98;
        Tue, 23 Aug 2022 09:31:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E569BC433D6;
        Tue, 23 Aug 2022 09:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661247115;
        bh=69ovCRcumfGslh/oGLivZ4DIr8oJgQGwFuXGEqHGW5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NBMv1LGnpeev5Y3mrmaDaqsyMV18S60tPbN1xy2dDsZDuoroyypnJtV6i2p0PkXWN
         XhNgAdPx1dFtyQnae66pkGRfW1K9QinJJknioaFcJV8iWrJdrMCVE3bjx1Ks7BEIBZ
         mw66GMI1yrouvPqXRwVM2qk+YvhSkInUuh+bXeJs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Ingo Molnar <mingo@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, llvm@lists.linux.dev,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Terrell <terrelln@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Song Liu <song@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 5.4 322/389] tools build: Switch to new openssl API for test-libcrypto
Date:   Tue, 23 Aug 2022 10:26:40 +0200
Message-Id: <20220823080128.985378948@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080115.331990024@linuxfoundation.org>
References: <20220823080115.331990024@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

commit 5b245985a6de5ac18b5088c37068816d413fb8ed upstream.

Switch to new EVP API for detecting libcrypto, as Fedora 36 returns an
error when it encounters the deprecated function MD5_Init() and the others.

The error would be interpreted as missing libcrypto, while in reality it is
not.

Fixes: 6e8ccb4f624a73c5 ("tools/bpf: properly account for libbfd variations")
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: llvm@lists.linux.dev
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nick Terrell <terrelln@fb.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Monnet <quentin@isovalent.com>
Cc: Song Liu <song@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Link: https://lore.kernel.org/r/20220719170555.2576993-4-roberto.sassu@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/build/feature/test-libcrypto.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--- a/tools/build/feature/test-libcrypto.c
+++ b/tools/build/feature/test-libcrypto.c
@@ -1,16 +1,23 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <openssl/evp.h>
 #include <openssl/sha.h>
 #include <openssl/md5.h>
 
 int main(void)
 {
-	MD5_CTX context;
+	EVP_MD_CTX *mdctx;
 	unsigned char md[MD5_DIGEST_LENGTH + SHA_DIGEST_LENGTH];
 	unsigned char dat[] = "12345";
+	unsigned int digest_len;
 
-	MD5_Init(&context);
-	MD5_Update(&context, &dat[0], sizeof(dat));
-	MD5_Final(&md[0], &context);
+	mdctx = EVP_MD_CTX_new();
+	if (!mdctx)
+		return 0;
+
+	EVP_DigestInit_ex(mdctx, EVP_md5(), NULL);
+	EVP_DigestUpdate(mdctx, &dat[0], sizeof(dat));
+	EVP_DigestFinal_ex(mdctx, &md[0], &digest_len);
+	EVP_MD_CTX_free(mdctx);
 
 	SHA1(&dat[0], sizeof(dat), &md[0]);
 


