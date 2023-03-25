Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9206C8A5C
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjCYCz5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCYCz4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:55:56 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DF215170
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:55:54 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n19so2116989wms.0
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679712953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4KcWWbPVCdbcLUdC7IsA8wzN8o+KuuhTDVqzFNgoOA=;
        b=dQ4RSQxhTabGRuymvsHJ1K8ffSGGpwfG4Nh36HhcSd46rAo59CudeUmwvb3uSKyEwm
         F+LVpRUNYDadixcmJACrxaFCKW1beHUbAlN2OU0ztHihPd84pRVJEyMjJUGktzBZceKV
         yjl8x9Ri5aDYLLxdM2rmzIQgDG3XrNQ5eUjltLqhvNQW/rDXkDkQWiVHjqxu9HRM4qyG
         mxwcMpI3gfMokHs/zw/7S6SFT8Kq62d2uJclfwY4/EkMDmwMdj3CGjk5LnELUCDFi23q
         3BBI149ewp7UxccewPru4JXDw4+Xkiq8DYxUsXalNGyKhxuqlsyyrCrDKXlOmOEhiTg9
         Cmcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679712953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G4KcWWbPVCdbcLUdC7IsA8wzN8o+KuuhTDVqzFNgoOA=;
        b=tCxdtNlM2aCfAZ9HLXkB/q6gxHq/ZL8yLR+lVjpwwZZc81+LZDkyR4Ojvj5+As6RW+
         YDV0GvUAwuPtXDLGVWVVpO4Ps68dpG6XOuTASZPB0IK0RdSN8aUzMe6ADmqB0/yIFOTn
         aLLxBJ529Y81Kp+xVP3gVAmoNRu0q3WKzDvbrb7S5Z5wspk+QSZcnNnxAK87c9Z+uPOw
         SA3BuGZYQNRXFvYTxIobvnU/pmUcvrZ80+5JRnlMgAXPLRIexCMBa5vbPyF12Q2x/AUz
         6NvPixT/uVB6VggPRoHM5UXvz6YpLwaoV3HEEjjjOSmN8cqFrf6GlDit83N4AYjv1BMv
         LkAg==
X-Gm-Message-State: AO0yUKXUJcek3+WyaYJyeNZmH3W7avSOgn1k/639+OTDhPNeL/uw1UiH
        +w0Vdf2C6681nIbHyGTe+w9ppC4y+pE=
X-Google-Smtp-Source: AK7set/l5voiucQQIapxgx6+9i7b6RK9gXhR+BOUd/Q42UmPfanvPIAqPaOG4NyaueA5F7nq/zqDPA==
X-Received: by 2002:a1c:790e:0:b0:3ed:a82d:dfe2 with SMTP id l14-20020a1c790e000000b003eda82ddfe2mr3868399wme.29.1679712952882;
        Fri, 24 Mar 2023 19:55:52 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:55:51 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 01/43] selftests/bpf: Report program name on parse_test_spec error
Date:   Sat, 25 Mar 2023 04:54:42 +0200
Message-Id: <20230325025524.144043-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230325025524.144043-1-eddyz87@gmail.com>
References: <20230325025524.144043-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Change test_loader.c:run_subtest() behavior to show BPF program name
when test spec for that program can't be parsed.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/test_loader.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index bf41390157bf..8ca5121b5329 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -232,8 +232,11 @@ void run_subtest(struct test_loader *tester,
 
 		/* if we can't derive test specification, go to the next test */
 		err = parse_test_spec(tester, obj, prog, &spec);
-		if (!ASSERT_OK(err, "parse_test_spec"))
+		if (err) {
+			PRINT_FAIL("Can't parse test spec for program '%s'\n",
+				   bpf_program__name(prog));
 			continue;
+		}
 
 		tobj = bpf_object__open_mem(obj_bytes, obj_byte_cnt, &open_opts);
 		if (!ASSERT_OK_PTR(tobj, "obj_open_mem")) /* shouldn't happen */
-- 
2.40.0

