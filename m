Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F02C6A747D
	for <lists+bpf@lfdr.de>; Wed,  1 Mar 2023 20:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjCATtR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Mar 2023 14:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjCATtQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Mar 2023 14:49:16 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1BBA27A;
        Wed,  1 Mar 2023 11:49:15 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id h19so15629574qtk.7;
        Wed, 01 Mar 2023 11:49:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677700154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgYDcpBcQyFTWp2ft2xfRcUxCWQprJgnX4NvGVtcxlY=;
        b=e/Ozj1fiwpPtwhwKMMRKJgFluMPEAoZfVvMUfYKefLMFJITDBzwqrM2hLpHGIUdW3Q
         CKnVOB0s4ULWsSeAOPryHSM8qR/irc/WysewwBXWvPj9UZDDl73W4AGV8M3d/yLV2DYC
         n39bvtyHxIHdqo/BVLEFXa5HOy+dVGcyzndFTu4p8x6fQYomXjIZfHf1xS4DAQfGaNul
         xQ4Yd3Ki5rot9NhlJRrHx4qVHkaVb11yr7JRYCBBtwEIHta9FNdV0yPdMgGqLFmq8+z9
         EYWlXfKDBeLOIT8akfhJImGsDzI8wevZ02gwRsXAXTElqV+aaSMJUuxntfZaJ2cmprz/
         TywQ==
X-Gm-Message-State: AO0yUKXQP/706DWUliQxwJCU3yAC99vsIgx34vj7M01WABqUKfDCxIGW
        1STx6ECqcdVAQtF3XMydNPStPH4WETIZC+Ma
X-Google-Smtp-Source: AK7set+IBogJ5guUwujaz2WAb0wt2QIoBCmJcLe65vmGBh2bYJvQESW1aAoLC+h2IXiwISYF7L3/NA==
X-Received: by 2002:a05:622a:1d4:b0:3b9:b5c5:ebb1 with SMTP id t20-20020a05622a01d400b003b9b5c5ebb1mr13474164qtw.9.1677700154635;
        Wed, 01 Mar 2023 11:49:14 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:9336])
        by smtp.gmail.com with ESMTPSA id l22-20020ac84596000000b003b9e1d3a502sm8990002qtn.54.2023.03.01.11.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 11:49:14 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next 2/2] bpf, docs: Fix __uninit kfunc doc section
Date:   Wed,  1 Mar 2023 13:49:10 -0600
Message-Id: <20230301194910.602738-2-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230301194910.602738-1-void@manifault.com>
References: <20230301194910.602738-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In commit d96d937d7c5c ("bpf: Add __uninit kfunc annotation"), the
__uninit kfunc annotation was documented in kfuncs.rst. You have to
fully underline a section in rst, or the build will issue a warning that
the title underline is too short:

./Documentation/bpf/kfuncs.rst:104: WARNING: Title underline too short.

2.2.2 __uninit Annotation
--------------------

This patch fixes that title underline.

Fixes: d96d937d7c5c ("bpf: Add __uninit kfunc annotation")
Signed-off-by: David Vernet <void@manifault.com>
---
 Documentation/bpf/kfuncs.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 9a78533d25ac..9d85bbc3b771 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -101,7 +101,7 @@ size parameter, and the value of the constant matters for program safety, __k
 suffix should be used.
 
 2.2.2 __uninit Annotation
---------------------
+-------------------------
 
 This annotation is used to indicate that the argument will be treated as
 uninitialized.
-- 
2.39.0

