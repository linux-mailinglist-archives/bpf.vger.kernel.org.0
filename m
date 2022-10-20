Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B413605A8B
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 11:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiJTJGB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 05:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiJTJGA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 05:06:00 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526C017C558;
        Thu, 20 Oct 2022 02:05:54 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d24so19723934pls.4;
        Thu, 20 Oct 2022 02:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7o3DdS6QAF9bYcwYa9OQ8LlTpX2ZcGANydX8jAzYar4=;
        b=TLZ04qDs5Zy8Zg0EhnSXGWOdoORY56Fwy/FrJit+9mwSG6BzgNClx6P/rXbJkjPzqi
         JT+57SRFD2qlquqvNl8YQnuAEsPm+2vcDmUCXKPq6ozQVgN7QTaGqEtbw0kTd/7th8Ab
         bF1Pz5OhPicdX55adPsAQFZ71susRlr9EG/0BK13uc0nZ2yIcYrZmFytHcaNHaUOXQkL
         1V+CdI8a21467V+T8blGn7Y3ToAe7sktnmsr1sVVqkyR5DLgMUuXmqvarECR+i9xxaBI
         D71miwyiPJALc+l6auuQjYstDpWMCFjOpxlRcehtmmAXhGt9+3L9Rhgk8n0fUnHpSUxu
         xE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7o3DdS6QAF9bYcwYa9OQ8LlTpX2ZcGANydX8jAzYar4=;
        b=tr+zuSDdZC94Y0vr+j7VFkvaji8ctEQ7a05R/acVIq9T6tOC9ZmgI+0ByRHrqAX0As
         FPCbhwTuCQmJ0cSSykch/SMT2RlI6KptZtO82W6gnpVDkBNZYOdJrPxqwSJ+n1p+zStj
         LUPtk6sabs/bDUTA1SyEZUhrvWS4cMRtTblWBdzkuHNN6UQ2jw0lhHKZzoO6U/pHsjhA
         /Q8ghRD4VUNYdwrLZvJe8yI54iuYGR9p6LrW19YtmvXwKG/4xgL3Ta+nYKddFMKNjSVg
         TgSMlsQwxVFC1PFrm5iuS9MY5trUWwiVNRv8b29qeACtc2a9eu+VHf4E5A/fzo+gPZPO
         K6TQ==
X-Gm-Message-State: ACrzQf01t3vmO3RiSQfVQzYFlDydEIo7KY4fRCH7C+KqywO6ievkKDVi
        Yfm/PGJghwHh2LCv6NqRbiw=
X-Google-Smtp-Source: AMsMyM71W/wNqPPTlWVcqYRg3hjkpwHhSLKtq/Kgii0eyBMRYiYEeJL449HJnyI3tiFJ4QAqCeOObw==
X-Received: by 2002:a17:90b:4f4e:b0:20d:9f5b:abbf with SMTP id pj14-20020a17090b4f4e00b0020d9f5babbfmr15378166pjb.148.1666256753196;
        Thu, 20 Oct 2022 02:05:53 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id w24-20020aa79558000000b00562adc8b6d3sm12642653pfq.193.2022.10.20.02.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 02:05:52 -0700 (PDT)
From:   cuijinpeng666@gmail.com
X-Google-Original-From: cui.jinpeng2@zte.com.cn
To:     ast@kernel.org, keescook@chromium.org, jolsa@kernel.org,
        cui.jinpeng2@zte.com.cn
Cc:     peterz@infradead.org, stephen.s.brennan@oracle.com,
        alan.maguire@oracle.com, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] kallsyms: Use strscpy() instead of strlcpy()
Date:   Thu, 20 Oct 2022 09:05:47 +0000
Message-Id: <20221020090547.398680-1-cui.jinpeng2@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>

The implementation of strscpy() is more robust and safer.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
---
 kernel/kallsyms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index cc244c02b4cf..639de60ed417 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -660,7 +660,7 @@ static int get_ksymbol_bpf(struct kallsym_iter *iter)
 {
 	int ret;
 
-	strlcpy(iter->module_name, "bpf", MODULE_NAME_LEN);
+	strscpy(iter->module_name, "bpf", MODULE_NAME_LEN);
 	iter->exported = 0;
 	ret = bpf_get_kallsym(iter->pos - iter->pos_ftrace_mod_end,
 			      &iter->value, &iter->type,
@@ -680,7 +680,7 @@ static int get_ksymbol_bpf(struct kallsym_iter *iter)
  */
 static int get_ksymbol_kprobe(struct kallsym_iter *iter)
 {
-	strlcpy(iter->module_name, "__builtin__kprobes", MODULE_NAME_LEN);
+	strscpy(iter->module_name, "__builtin__kprobes", MODULE_NAME_LEN);
 	iter->exported = 0;
 	return kprobe_get_kallsym(iter->pos - iter->pos_bpf_end,
 				  &iter->value, &iter->type,
-- 
2.25.1

