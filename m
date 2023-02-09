Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442FF690C03
	for <lists+bpf@lfdr.de>; Thu,  9 Feb 2023 15:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjBIOiX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 09:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjBIOiW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 09:38:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9270360BA4
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 06:37:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0044B820FA
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 14:37:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5E1C433D2;
        Thu,  9 Feb 2023 14:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675953460;
        bh=8SElCkcDHnwulrdhegLxkDjCwE01YQPd1eYDepC1WCM=;
        h=From:To:Cc:Subject:Date:From;
        b=rAtYR6j75dyX9VXXD0/YzSR9NDsHpjWaoYx/m241cY+fVPkKLd6fceYVvDk5KlSCk
         9xg857gJZX4mk4PwcjmyFYCBwDOZ9XwVULa0/mjAon1yFca9whL0l0Fg8DpmTPDbkf
         nhNnO8lFkk3ZD2BuwYVZSvh1oOVAT4uMbv+6JXkvs6jQ63qYVQQVsZ5KzqvU3v/7D5
         yf1JOZddXrv9aRSJgvGXmAZnAcrW3iRMfYupspT81kkPkMdHrFvP+dJnF8Sm2Gq9/Q
         T/MNY7s3ogmcImUiRJjlpkUUKiyvkT47AjSBNIB5CSJGdADpn2VnmWe6pryG7aa3iF
         d4w+OdNHcMazg==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Ian Rogers <irogers@google.com>
Subject: [PATCH bpf-next] tools/resolve_btfids: Pass HOSTCFLAGS as EXTRA_CFLAGS to prepare targets
Date:   Thu,  9 Feb 2023 15:37:35 +0100
Message-Id: <20230209143735.4112845-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thorsten reported build issue with command line that defined extra
HOSTCFLAGS that were not passed into 'prepare' targets, but were
used to build resolve_btfids objects.

This results in build fail when these objects are linked together:

  /usr/bin/ld: /build.../tools/bpf/resolve_btfids//libbpf/libbpf.a(libbpf-in.o):
  relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a PIE \
  object; recompile with -fPIE

Fixing this by passing HOSTCFLAGS in EXTRA_CFLAGS as part of
HOST_OVERRIDES variable for prepare targets.

[1] https://lore.kernel.org/bpf/f7922132-6645-6316-5675-0ece4197bfff@leemhuis.info/

Fixes: 56a2df7615fa ("tools/resolve_btfids: Compile resolve_btfids as host program")
Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
Tested-by: Thorsten Leemhuis <linux@leemhuis.info>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/bpf/resolve_btfids/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index 2abdd85b4a08..ac548a7baa73 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -19,7 +19,7 @@ endif
 
 # Overrides for the prepare step libraries.
 HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)" \
-		  CROSS_COMPILE=""
+		  CROSS_COMPILE="" EXTRA_CFLAGS="$(HOSTCFLAGS)"
 
 RM      ?= rm
 HOSTCC  ?= gcc
-- 
2.39.1

