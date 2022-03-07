Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E89B4D0014
	for <lists+bpf@lfdr.de>; Mon,  7 Mar 2022 14:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiCGNbw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Mar 2022 08:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236126AbiCGNbv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Mar 2022 08:31:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3877F6F4
        for <bpf@vger.kernel.org>; Mon,  7 Mar 2022 05:30:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C96746122D
        for <bpf@vger.kernel.org>; Mon,  7 Mar 2022 13:30:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509EAC340F3;
        Mon,  7 Mar 2022 13:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646659856;
        bh=31+R4UnZ61SObhWIDQT9GnDaCSVSHfzKpVrsfw4E2Ug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jV/PMZ4cOudyFd/TnyuXL7WghWMcSNT3fj4YTeuuONM87gHs92KR/5+ed0mocukVt
         wqevJ2MK2tCiZaEWi/A7VcRZHdsbSJ57MbJuzn38FeuveBRY0GddmdzZHIFVxs2e4k
         iSHMczr/d2XJFzxWSWh3Kcwh6MRYu8iCDyR3qKet9r551L5K8NSaW6aDhPwgm7gPat
         8HSfEUSR2YtxtlOQoUreuNf8/4z3MjwodhY5JK3A++Lx1oNxdlfbRRhU9uN6HvXDS1
         dmAo6oQ2J7nosd6UNeeMhgENUoCjiqPkIprwn1XMDHOIr4DltRIYjCs3wqyZiXO1IR
         rQctaUP4Rni4A==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 2/2] bpf/docs: Update list of architectures supported.
Date:   Mon,  7 Mar 2022 13:30:48 +0000
Message-Id: <20220307133048.1287644-2-kpsingh@kernel.org>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
In-Reply-To: <20220307133048.1287644-1-kpsingh@kernel.org>
References: <20220307133048.1287644-1-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

vmtest.sh also supports s390x now.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 tools/testing/selftests/bpf/README.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftests/bpf/README.rst
index f7fa74448492..54410ef3fc1c 100644
--- a/tools/testing/selftests/bpf/README.rst
+++ b/tools/testing/selftests/bpf/README.rst
@@ -44,7 +44,7 @@ Incase of linker errors when running selftests, try using static linking:
           If you want to change pahole and llvm, you can change `PATH` environment
           variable in the beginning of script.
 
-.. note:: The script currently only supports x86_64.
+.. note:: The script currently only supports x86_64 and s390x architectures.
 
 Additional information about selftest failures are
 documented here.
-- 
2.35.1.616.g0bdcbb4464-goog

