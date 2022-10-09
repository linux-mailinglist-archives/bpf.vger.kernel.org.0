Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67EBD5F8B88
	for <lists+bpf@lfdr.de>; Sun,  9 Oct 2022 15:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiJINNj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 9 Oct 2022 09:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJINNi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 9 Oct 2022 09:13:38 -0400
X-Greylist: delayed 564 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 09 Oct 2022 06:13:36 PDT
Received: from mail-200163.simplelogin.co (mail-200163.simplelogin.co [176.119.200.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD6226109
        for <bpf@vger.kernel.org>; Sun,  9 Oct 2022 06:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lirui.org; s=dkim;
        t=1665320650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=l5bv8JJTWrUbMLpWEm/kLrumWiCr7L4/4GhcnsQX1hw=;
        b=hdbPh73bwnYtjv7Rz1SJZWiHAfhw2zsANgr5874Za3l7K5Jka4nzDdh9Q1fZyr9GjN2Uj4
        ZeKedi9eFgp9x6s80s9j4xP/AcmtValhYg0M3eDk/CCfkzqtBIi+ZUoryui1i+IELwJ7R3
        NLV/0CjpNs/Shq/kZnSBOojn/wrx1eg=
Subject: [PATCH] bpf: Replace strlcpy with strscpy in preload module
Date:   Sun,  9 Oct 2022 21:03:27 +0800
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From:   Rui Li <me@lirui.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <166532064978.9.18239510123131509626.67790627@lirui.org>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 67790636
X-SimpleLogin-Want-Signing: yes
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_FMBLA_NEWDOM28,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use strscpy instead of strlcpy as the former one checks the size
of source. Especially for this case, source strings are less than
dst size.

Signed-off-by: Rui Li <me@lirui.org>
---
 kernel/bpf/preload/bpf_preload_kern.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/preload/bpf_preload_kern.c b/kernel/bpf/preload/bpf_preload_kern.c
index 5106b5372f0c..af8dd3a7c928 100644
--- a/kernel/bpf/preload/bpf_preload_kern.c
+++ b/kernel/bpf/preload/bpf_preload_kern.c
@@ -19,9 +19,9 @@ static void free_links_and_skel(void)
 
 static int preload(struct bpf_preload_info *obj)
 {
-	strlcpy(obj[0].link_name, "maps.debug", sizeof(obj[0].link_name));
+	strscpy(obj[0].link_name, "maps.debug", sizeof(obj[0].link_name));
 	obj[0].link = maps_link;
-	strlcpy(obj[1].link_name, "progs.debug", sizeof(obj[1].link_name));
+	strscpy(obj[1].link_name, "progs.debug", sizeof(obj[1].link_name));
 	obj[1].link = progs_link;
 	return 0;
 }
-- 
2.30.2


