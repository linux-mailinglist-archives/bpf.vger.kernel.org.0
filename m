Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72714E9388
	for <lists+bpf@lfdr.de>; Mon, 28 Mar 2022 13:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240760AbiC1LY3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Mar 2022 07:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240918AbiC1LW5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Mar 2022 07:22:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADF5574AA;
        Mon, 28 Mar 2022 04:19:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73599B8105D;
        Mon, 28 Mar 2022 11:19:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64F0C340EC;
        Mon, 28 Mar 2022 11:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648466385;
        bh=A/hAMMRh3XJNdD9x1AAtbacK618VtXEYBp3Ix1ZXMfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Edo29wWshR3KIyG3MHiaT9hq8u6O3DBpv/SYtATd1mk8R2XOcyi6iQt5A6j2PvZkq
         zDUzt2Fz8lsor01zpijauVFc/hDPhcM6Vf8XA4QJvzuUUpWxtBnix5TBkSnyXa7Q1r
         1wbJ22ecN3qeUDVn6+JZxFyQei1/Dh4BfhcBRiZFfKFnjmgkgbAT9k0YMTyMYQuurP
         2scWxsBXHoUnupiQMki8w5eRjzeFwj076JVrq7q2Me5Hd4POoD5wSoVSZtjNTOMZnr
         V5YhcgjhURCZPvPNuG+Rg2gp9F1WcEMtF+6RAYfwErDVZw4Lp0M9aY0zsphNgNSxOv
         Id7BHy24xyUDg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Matt Brown <matthew.brown.dev@gmail.com>,
        Song Liu <song@kernel.org>, Sasha Levin <sashal@kernel.org>,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.17 34/43] lib/raid6/test/Makefile: Use $(pound) instead of \# for Make 4.3
Date:   Mon, 28 Mar 2022 07:18:18 -0400
Message-Id: <20220328111828.1554086-34-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220328111828.1554086-1-sashal@kernel.org>
References: <20220328111828.1554086-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
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

From: Paul Menzel <pmenzel@molgen.mpg.de>

[ Upstream commit 633174a7046ec3b4572bec24ef98e6ee89bce14b ]

Buidling raid6test on Ubuntu 21.10 (ppc64le) with GNU Make 4.3 shows the
errors below:

    $ cd lib/raid6/test/
    $ make
    <stdin>:1:1: error: stray ‘\’ in program
    <stdin>:1:2: error: stray ‘#’ in program
    <stdin>:1:11: error: expected ‘=’, ‘,’, ‘;’, ‘asm’ or ‘__attribute__’ \
        before ‘<’ token

    [...]

The errors come from the HAS_ALTIVEC test, which fails, and the POWER
optimized versions are not built. That’s also reason nobody noticed on the
other architectures.

GNU Make 4.3 does not remove the backslash anymore. From the 4.3 release
announcment:

> * WARNING: Backward-incompatibility!
>   Number signs (#) appearing inside a macro reference or function invocation
>   no longer introduce comments and should not be escaped with backslashes:
>   thus a call such as:
>     foo := $(shell echo '#')
>   is legal.  Previously the number sign needed to be escaped, for example:
>     foo := $(shell echo '\#')
>   Now this latter will resolve to "\#".  If you want to write makefiles
>   portable to both versions, assign the number sign to a variable:
>     H := \#
>     foo := $(shell echo '$H')
>   This was claimed to be fixed in 3.81, but wasn't, for some reason.
>   To detect this change search for 'nocomment' in the .FEATURES variable.

So, do the same as commit 9564a8cf422d ("Kbuild: fix # escaping in .cmd
files for future Make") and commit 929bef467771 ("bpf: Use $(pound) instead
of \# in Makefiles") and define and use a $(pound) variable.

Reference for the change in make:
https://git.savannah.gnu.org/cgit/make.git/commit/?id=c6966b323811c37acedff05b57

Cc: Matt Brown <matthew.brown.dev@gmail.com>
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Song Liu <song@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/raid6/test/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/raid6/test/Makefile b/lib/raid6/test/Makefile
index a4c7cd74cff5..4fb7700a741b 100644
--- a/lib/raid6/test/Makefile
+++ b/lib/raid6/test/Makefile
@@ -4,6 +4,8 @@
 # from userspace.
 #
 
+pound := \#
+
 CC	 = gcc
 OPTFLAGS = -O2			# Adjust as desired
 CFLAGS	 = -I.. -I ../../../include -g $(OPTFLAGS)
@@ -42,7 +44,7 @@ else ifeq ($(HAS_NEON),yes)
         OBJS   += neon.o neon1.o neon2.o neon4.o neon8.o recov_neon.o recov_neon_inner.o
         CFLAGS += -DCONFIG_KERNEL_MODE_NEON=1
 else
-        HAS_ALTIVEC := $(shell printf '\#include <altivec.h>\nvector int a;\n' |\
+        HAS_ALTIVEC := $(shell printf '$(pound)include <altivec.h>\nvector int a;\n' |\
                          gcc -c -x c - >/dev/null && rm ./-.o && echo yes)
         ifeq ($(HAS_ALTIVEC),yes)
                 CFLAGS += -I../../../arch/powerpc/include
-- 
2.34.1

