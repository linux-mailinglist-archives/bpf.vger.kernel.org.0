Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6163E627CB7
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 12:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236624AbiKNLqG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 06:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236632AbiKNLpa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 06:45:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E944B22BF5;
        Mon, 14 Nov 2022 03:44:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 845D061029;
        Mon, 14 Nov 2022 11:44:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7258C433D7;
        Mon, 14 Nov 2022 11:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426289;
        bh=dM14MOihj97NYzJwhWL5SRRwVL0+QAgx8foCL3a4QiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D4l3yS3yBfgD2zeune7JyBhi9yZvfRVo03Vw2CsrpN2qXewu6FVFqX+CycSXiYnE6
         YAn/HPAzO2Cv02XdSbbNATOUQXGwpbKZ5GPnCeKpDeTb9ovq7zHgnCYAAEYUBoWZYH
         PAka5pjed2VwRUgOVwmgAyMDfMAkb6rrVgvHwMeArFlKbhYJroYU6GSwxmzwHMiCXS
         l6yIxL6P9bKUMzd50lLwvLNgExDTPPDnJ1e/XhAiNZQLil/BH4VFMfm123x4vTyhvY
         OBs3lehnT+iFHQts+mAjkgNtImz3iicmMM0yJkIo8/AT96ZT+bWqChaGXVh+iH+Ssr
         PxwwM9K7eJw8w==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andi Kleen <andi@firstfloor.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, Martin Liska <mliska@suse.cz>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 22/46] btf, lto: Make all BTF IDs global on LTO
Date:   Mon, 14 Nov 2022 12:43:20 +0100
Message-Id: <20221114114344.18650-23-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114114344.18650-1-jirislaby@kernel.org>
References: <20221114114344.18650-1-jirislaby@kernel.org>
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

From: Andi Kleen <andi@firstfloor.org>

gcc LTO can put assembler top level statements into other assembler
files. The BTF IDs assumed that they are in the same file. So if we are
building with gcc LTO, make all BTF IDs global to work around this.

This is done by new __global_on_lto macro.

[js] do that for 8B BTF set too (commit ab21d6063c01)
[js] do global only in LTO case

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yhs@fb.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
Signed-off-by: Andi Kleen <andi@firstfloor.org>
Signed-off-by: Martin Liska <mliska@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 include/linux/btf_ids.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index 3011757a48ef..a2bef302e42c 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -37,7 +37,7 @@ struct btf_id_set8 {
 #define ____BTF_ID(symbol, word)			\
 asm(							\
 ".pushsection " BTF_IDS_SECTION ",\"a\";       \n"	\
-".local " #symbol " ;                          \n"	\
+"." __global_on_lto " " #symbol " ;            \n"	\
 ".type  " #symbol ", STT_OBJECT;               \n"	\
 ".size  " #symbol ", 4;                        \n"	\
 #symbol ":                                     \n"	\
@@ -88,7 +88,7 @@ asm(							\
 ".popsection;                                  \n");
 
 #define BTF_ID_LIST(name)				\
-__BTF_ID_LIST(name, "local")				\
+__BTF_ID_LIST(name, __global_on_lto)			\
 extern u32 name[];
 
 #define BTF_ID_LIST_GLOBAL(name, n)			\
@@ -148,8 +148,8 @@ asm(							\
 ".popsection;                                  \n");
 
 #define BTF_SET_START(name)				\
-__BTF_ID_LIST(name, "local")				\
-__BTF_SET_START(name, "local")
+__BTF_ID_LIST(name, __global_on_lto)			\
+__BTF_SET_START(name, __global_on_lto)
 
 #define BTF_SET_START_GLOBAL(name)			\
 __BTF_ID_LIST(name, "globl")				\
@@ -192,8 +192,8 @@ asm(							\
 ".popsection;                                  \n");
 
 #define BTF_SET8_START(name)				\
-__BTF_ID_LIST(name, "local")				\
-__BTF_SET8_START(name, "local")
+__BTF_ID_LIST(name, __global_on_lto)			\
+__BTF_SET8_START(name, __global_on_lto)
 
 #define BTF_SET8_END(name)				\
 asm(							\
-- 
2.38.1

