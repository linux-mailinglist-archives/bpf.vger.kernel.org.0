Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14AB6DDE6F
	for <lists+bpf@lfdr.de>; Tue, 11 Apr 2023 16:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjDKOsB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Apr 2023 10:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjDKOr5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Apr 2023 10:47:57 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CDF30D0
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 07:47:55 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id q5so4689746wmo.4
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 07:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1681224474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vci6wYH1qpvqDyqvyJ5tBJwpJDfjIpIyLWu7Z9afXNk=;
        b=QoO5b1cJnkJvvRmy4V16A+6mkiI5Yrq0X+5jYhsFWl552sw49Kfu5xe8xGlOflTgVQ
         ZWeQDnJgcpFZmLgWEqh1rPmnH8UarzwDwm37q2gl1+p/0UmFxeKdHxF2LLZ7yUYToSde
         2jDZgIF4v1vgW3XkW6GYYHVglkf1yr0Uifyv1KYz/EnKJPIcYV+0bdmZl89Q82q9oH9P
         JKQwL9rANGie8eQnizltaUgml7qaRB+1lA8VFNWbGvY3NNVFmI/m4IGrz9cjy8O2ocA0
         nTt/gv+7tAdFiebEZ1vrJopBto+ECm3FaciYZCWei4WiqrE8ooHVX1wLab69ALv2BTto
         DUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681224474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vci6wYH1qpvqDyqvyJ5tBJwpJDfjIpIyLWu7Z9afXNk=;
        b=y15RzWGkFVhSOCmqRkvFw2OJAB8N5+skjD6xpBGXteN8Jsh5SbqPBQvAFubRdKcUQ3
         f7+JWbY60eJI9piegxKFi/Ju/QUlLJUl44ncrbpDg+qdf2rnVvgQNVlGnLKENWKwU6yg
         WhJJkIapw2zii3USzG9gfDBzsyjJ3nbxf100o+xV097J9+dIATNVtFCeRCykGKKRfjc9
         QIzY41yZw5Z857erJ8oXm7S1Hn2dcJURV84xzohS86P0WHPKlxMTQny8YhHdh9In/rZm
         a6M0y0jz1CdWcN+GkC5Nd6wlGX7Obag0KL3h+Z5nZeFZ/MBUaf85w7D8bJ5+ao6CmwIH
         IwHw==
X-Gm-Message-State: AAQBX9f+mps47Ggaz3V8ShyCLnbggfe2T+WYIikg/x7v/Oyk8JoeUgrc
        2yKcng0fPqieloIjoKrNCRzcnw==
X-Google-Smtp-Source: AKy350biM3Lrn2RQxZckEPb8zmIrhsoRpx9EId/WTKaUDlt4aVjbA55UGkPQI2PsAoLMb+yTG2v0IA==
X-Received: by 2002:a05:600c:21da:b0:3ed:2619:6485 with SMTP id x26-20020a05600c21da00b003ed26196485mr10179840wmj.3.1681224474316;
        Tue, 11 Apr 2023 07:47:54 -0700 (PDT)
Received: from harfang.fritz.box ([2a02:8011:e80c:0:3de0:2d5:e172:b2a3])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c4fd300b003ef7058ea02sm21282794wmq.29.2023.04.11.07.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 07:47:53 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, Alejandro Colomar <alx@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next] bpf: Remove extra whitespace in SPDX tag for syscall/helpers man pages
Date:   Tue, 11 Apr 2023 15:47:47 +0100
Message-Id: <20230411144747.66734-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alejandro Colomar <alx@kernel.org>

There is an extra whitespace in the SPDX tag, before the license name,
in the script for generating man pages for the bpf() syscall and the
helpers. It has caused problems in Debian packaging, in the tool that
autodetects licenses. Let's clean it up.

Fixes: 5cb62b7598f2 ("bpf, docs: Use SPDX license identifier in bpf_doc.py")
Signed-off-by: Alejandro Colomar <alx@kernel.org>
Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 scripts/bpf_doc.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index 38d51e05c7a2..eaae2ce78381 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -383,7 +383,7 @@ class PrinterRST(Printer):
 .. Copyright (C) All BPF authors and contributors from 2014 to present.
 .. See git log include/uapi/linux/bpf.h in kernel tree for details.
 .. 
-.. SPDX-License-Identifier:  Linux-man-pages-copyleft
+.. SPDX-License-Identifier: Linux-man-pages-copyleft
 .. 
 .. Please do not edit this file. It was generated from the documentation
 .. located in file include/uapi/linux/bpf.h of the Linux kernel sources
-- 
2.34.1

