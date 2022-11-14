Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34053627CB3
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 12:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236612AbiKNLqD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 06:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236672AbiKNLp2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 06:45:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1D1222BF;
        Mon, 14 Nov 2022 03:44:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDD5C61045;
        Mon, 14 Nov 2022 11:44:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F566C433D6;
        Mon, 14 Nov 2022 11:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426286;
        bh=l68sB4NnR3/f4L7VL19WvqH6Dh8yt/aVZ1uJVefQMtI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XtUJF22t1vMETfxkDkDoQaLgCdasT1mX3SAV8kKRXx4VF8SppR8kmCPcKMKny+Dbh
         +R5/4ermD/vAqhbI6Jfl2IqEnpgRKohqOPuvB4Lr0fp79bgVEMQTN7nYEURG2V56sP
         uAL+oq9za5RvSqWqnegWHtzmApX55dYD+0jXvOKiYAaATRPll3qAZUolXRKuXdwIp3
         tZijCM3cQmnJskEoxRP80Y42UARhTetm5DtR4MNQJ6vgwf4jlfGRFsTa01Fyg8IIcV
         8YhXFJHgBjabJP8rmmWYRTzNu549Kt7BxT7QTjZNordAq51h+KaB/RMfFHwsvewfck
         BMu5d6NEToxzA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jslaby@suse.cz>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, Martin Liska <mliska@suse.cz>
Subject: [PATCH 21/46] btf, lto: pass scope as strings
Date:   Mon, 14 Nov 2022 12:43:19 +0100
Message-Id: <20221114114344.18650-22-jirislaby@kernel.org>
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

From: Jiri Slaby <jslaby@suse.cz>

gcc LTO can put assembler top level statements into other assembler
files. The BTF IDs assumed that they are in the same file. We need to
make all BTF IDs global to work around this.

This is a preparation for that, as we will pass __global_on_lto as
scope. That is macro that expands either to "globl" or "local" depending
whether LTO is enabled.

That wouldn't work without this patch as we stringify scope at the
moment.

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
Cc: Martin Liska <mliska@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 include/linux/btf_ids.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index 2aea877d644f..3011757a48ef 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -83,16 +83,16 @@ word							\
 #define __BTF_ID_LIST(name, scope)			\
 asm(							\
 ".pushsection " BTF_IDS_SECTION ",\"a\";       \n"	\
-"." #scope " " #name ";                        \n"	\
+"." scope " " #name ";                         \n"	\
 #name ":;                                      \n"	\
 ".popsection;                                  \n");
 
 #define BTF_ID_LIST(name)				\
-__BTF_ID_LIST(name, local)				\
+__BTF_ID_LIST(name, "local")				\
 extern u32 name[];
 
 #define BTF_ID_LIST_GLOBAL(name, n)			\
-__BTF_ID_LIST(name, globl)
+__BTF_ID_LIST(name, "globl")
 
 /* The BTF_ID_LIST_SINGLE macro defines a BTF_ID_LIST with
  * a single entry.
@@ -142,18 +142,18 @@ asm(							\
 #define __BTF_SET_START(name, scope)			\
 asm(							\
 ".pushsection " BTF_IDS_SECTION ",\"a\";       \n"	\
-"." #scope " __BTF_ID__set__" #name ";         \n"	\
+"." scope " __BTF_ID__set__" #name ";          \n"	\
 "__BTF_ID__set__" #name ":;                    \n"	\
 ".zero 4                                       \n"	\
 ".popsection;                                  \n");
 
 #define BTF_SET_START(name)				\
-__BTF_ID_LIST(name, local)				\
-__BTF_SET_START(name, local)
+__BTF_ID_LIST(name, "local")				\
+__BTF_SET_START(name, "local")
 
 #define BTF_SET_START_GLOBAL(name)			\
-__BTF_ID_LIST(name, globl)				\
-__BTF_SET_START(name, globl)
+__BTF_ID_LIST(name, "globl")				\
+__BTF_SET_START(name, "globl")
 
 #define BTF_SET_END(name)				\
 asm(							\
@@ -186,14 +186,14 @@ extern struct btf_id_set name;
 #define __BTF_SET8_START(name, scope)			\
 asm(							\
 ".pushsection " BTF_IDS_SECTION ",\"a\";       \n"	\
-"." #scope " __BTF_ID__set8__" #name ";        \n"	\
+"." scope " __BTF_ID__set8__" #name ";         \n"	\
 "__BTF_ID__set8__" #name ":;                   \n"	\
 ".zero 8                                       \n"	\
 ".popsection;                                  \n");
 
 #define BTF_SET8_START(name)				\
-__BTF_ID_LIST(name, local)				\
-__BTF_SET8_START(name, local)
+__BTF_ID_LIST(name, "local")				\
+__BTF_SET8_START(name, "local")
 
 #define BTF_SET8_END(name)				\
 asm(							\
-- 
2.38.1

