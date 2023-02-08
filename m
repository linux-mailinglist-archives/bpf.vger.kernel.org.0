Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B0268F8FA
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 21:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjBHUoE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 15:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjBHUoD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 15:44:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3A62202B;
        Wed,  8 Feb 2023 12:44:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 541E2617DF;
        Wed,  8 Feb 2023 20:44:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79363C433D2;
        Wed,  8 Feb 2023 20:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675889041;
        bh=M98Xx0IDGaJKfJA6ZFChxFO2lcRSmqFOfKAhi5+IxeE=;
        h=Date:From:To:Cc:Subject:From;
        b=nCXK+S60jzML3Y2CifQGwbAKUSzfhrOQUCBUEY/fGKF1sS2oey2mRwy9tOuOTBclr
         2IQePvlLlCkh+LmFsxkoxOI68DBx4htISYSxeyVN/KYsVpSTFg5jC8zR0OS/muBGZd
         ne9VGU7/kumku0FXyoAuLpYPZliGOeKiBMf/5rcH0qNnr5uFwTH7HyPSAzuXHcevL0
         OSN73pCvzDmOeY6uOAYLdp9TzH3WWISMKMhxCeK+1IiK5hjrUwJdBQVJemrYytK8+A
         RGV7UVj6mCOKz6S6tgQrcoXnQ6vx+bKHocGM32RYZlNOm3l7FFcB8BDcgcNIOB6BPS
         yZnbRAzIKW7Xg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9B625405BE; Wed,  8 Feb 2023 17:43:58 -0300 (-03)
Date:   Wed, 8 Feb 2023 17:43:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     bpf@vger.kernel.org, dwarves@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Kui-Feng Lee <sinquersw@gmail.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Stanislav Fomichev <sdf@google.com>,
        Timo Beckers <timo@incline.eu>, Yonghong Song <yhs@fb.com>
Subject: [pahole PATCH 1/1] CMakeList.txt: Bump version to the upcoming 1.25
 release, not out of the door yet
Message-ID: <Y+QJjonvzpOsTRqi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is just for CIs to be able to, building from master, add optimized
functions with consistent prototypes when encoding BTF.

Requested-by: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@chromium.org>
Cc: Kui-Feng Lee <sinquersw@gmail.com>
Cc: Martin KaFai Lau <martin.lau@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Timo Beckers <timo@incline.eu>
Cc: Yonghong Song <yhs@fb.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 CMakeLists.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 1cd82ad6e748132a..2036ac0760e8ee99 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -54,9 +54,9 @@ if (NOT DEFINED BUILD_SHARED_LIBS)
 endif (NOT DEFINED BUILD_SHARED_LIBS)
 
 # Just for grepping, DWARVES_VERSION isn't used anywhere anymore
-# add_definitions(-D_GNU_SOURCE -DDWARVES_VERSION="v1.24")
+# add_definitions(-D_GNU_SOURCE -DDWARVES_VERSION="v1.25")
 add_definitions(-D_GNU_SOURCE -DDWARVES_MAJOR_VERSION=1)
-add_definitions(-D_GNU_SOURCE -DDWARVES_MINOR_VERSION=24)
+add_definitions(-D_GNU_SOURCE -DDWARVES_MINOR_VERSION=25)
 find_package(DWARF REQUIRED)
 find_package(ZLIB REQUIRED)
 find_package(argp REQUIRED)
-- 
2.39.1

