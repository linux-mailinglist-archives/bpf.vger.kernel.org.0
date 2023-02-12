Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8536935E6
	for <lists+bpf@lfdr.de>; Sun, 12 Feb 2023 04:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjBLDxO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Feb 2023 22:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBLDxN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 11 Feb 2023 22:53:13 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E22111E99
        for <bpf@vger.kernel.org>; Sat, 11 Feb 2023 19:53:12 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id rm7-20020a17090b3ec700b0022c05558d22so9273614pjb.5
        for <bpf@vger.kernel.org>; Sat, 11 Feb 2023 19:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4h9WsUjmRZxu6NcTdxjKOjuLJtm5ecgWlCdBojSgEo=;
        b=Duai0FFr0vViGfcGbGoyoFjMUy1Pdd7aLYF36PlQAfHBxjxvw4j8LuPtUv6NJJHAuC
         Be7rKxydxqF67thEl11uCeZ9W3gAkmKS1CTyne5i5MwoFmMRRyZ5ib5ahE2n+NmzOTZ+
         G3bVpK/TRlgnlK4lcuXMWu1unCUb2LB2nDXSh815TOg7lDeOmS5LS5nEONlJ7raoMHzC
         4UpuX4ktY2bbMw9tlVS5t5cpn2lGjsDo51Sk9yNW9u8byuvn93AnxmaFJ6iA7YuoVF9e
         rQbd7fJ5V5aCnovG1YMwwfCZpugLOsQa4pM4TNwQUMqIJyqjsd/3iAd5PIGMZOJk8EMG
         zc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4h9WsUjmRZxu6NcTdxjKOjuLJtm5ecgWlCdBojSgEo=;
        b=Z/qz6rvePKvWgPnFHbxI//j2jHt1yzdnETWTGvNKhOvM2cXZDo/ovEoESMO/6MnXHl
         SR/8SWUhnnlOvQ+39d9Bi1cnjstqwKFTaG2sYjV+7UooVGD4XeNUP8/ANiDugDauv0fW
         jjWNT11gmvdxtNatyNnv4GLE4a8/icXJDogTOzqpTxic/MuOZM/9Y765w9a3vtGuyC/e
         rxQQ62S4lQfY/lfu0W6jiv++OZFMZ5+fVp6PPlhAMLyCwtPdCYKK/QRf4NZJLGzU8wQh
         PXL2qyO/HPi4SCkNUxZepVDdF9kVoomxIOEM4KBvrvxkDNJNdIRfvltCrwfq1k0AjW7p
         4z2Q==
X-Gm-Message-State: AO0yUKU/AhyVAMlMIQ5DeLx3evEJ91ywFwd9CROveSvdchzPpsKC5p7v
        iUWb/Iq0u/5mVbpwn6OvYh660nhTM4A=
X-Google-Smtp-Source: AK7set8135vryfARAaRnU8fQfooqphztWQGg4x2hS0DF9JblOf2Xw5wkGvUzM7T0tz/eY9wX1lxITg==
X-Received: by 2002:a17:90b:30c1:b0:233:c3e3:182f with SMTP id hi1-20020a17090b30c100b00233c3e3182fmr4611280pjb.8.1676173991946;
        Sat, 11 Feb 2023 19:53:11 -0800 (PST)
Received: from localhost.localdomain ([43.132.141.9])
        by smtp.gmail.com with ESMTPSA id s1-20020a63dc01000000b004fab4455748sm5055399pgg.75.2023.02.11.19.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 19:53:11 -0800 (PST)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org, loongarch@lists.linux.dev
Cc:     hengqi.chen@gmail.com
Subject: [PATCH 2/2] LoongArch: BPF: Support mixing bpf2bpf and tailcalls
Date:   Sun, 12 Feb 2023 11:52:36 +0800
Message-Id: <20230212035236.1436532-3-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230212035236.1436532-1-hengqi.chen@gmail.com>
References: <20230212035236.1436532-1-hengqi.chen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The current implementation already allow such mixing.
Let's enable it in JIT.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 arch/loongarch/net/bpf_jit.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 2d952110be72..01892dfa637e 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1269,3 +1269,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 
 	return prog;
 }
+
+/* Indicate the JIT backend supports mixing bpf2bpf and tailcalls. */
+bool bpf_jit_supports_subprog_tailcalls(void)
+{
+	return true;
+}
-- 
2.31.1

