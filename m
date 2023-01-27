Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C9267E7C4
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 15:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbjA0OJz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 09:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjA0OJx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 09:09:53 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26003431B
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 06:09:51 -0800 (PST)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 014F73F2F6
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 14:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1674828589;
        bh=ThPASxkQPa8akyDheX0+gKydQu/0488KOg7wyMg90UM=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=A33JDy0p+EiigmA0nSmGKWTc6sMGANHsNpIiRvSvACUez5uorViZAcZr+qCNx+eyA
         DnIYKIfiwDMIpQi5kE0S6UXMnV13Ar/Mj4rmzmRQy0RcBND+C/m4qhuzVcHw4Mu0YB
         Hn7wygLCAJBOpdHasq8Mn2W4B7JRSSk5/W+/jLLQEflWAhApkctbvT0lN6kWb30q6U
         hHnwr6GQndB14Z0wsUr5k+w7nNWz4sCGoQh0VQdwPfYelJY6DLcdzQJ4tMWoueyza8
         fkYry74/2cpkcA7scqAOUQYY+XaUrpw4/DndTOtnSQO8paByaVlYZ+VtFSxGPwB6Xo
         pytVKfZX29ULg==
Received: by mail-wm1-f70.google.com with SMTP id o5-20020a05600c4fc500b003db0b3230efso4706281wmq.9
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 06:09:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ThPASxkQPa8akyDheX0+gKydQu/0488KOg7wyMg90UM=;
        b=T5HA0v14t49yijYSVP7Lho3q7RCACeGyIwIMpA8oHR1D2hUObueeA4OnAmzN9hvies
         w203+tMbAM5B8/8HQCmimFUkDLhuWGYs2ooxFN1HdB43MrKqidIz4Do+qZTeVOxzfeTb
         6iGmr7f48XD5ihwffhRJhRloy22EpRP7+3skcpbIrkmaHaxIEP2l03z3jq2Gul89+5Ar
         BA8DbeKEQ8pY+CSU1/M35nmmYuBWFJhVmTq2dnuA7NtFjbnAJZjG1OkAs/KLG/6fsrb2
         wHs2PCWeqjZXCKHIJCQSzQYwpQ4Qfl0nfL/7Ov/1cJGoTo7+k03Cs9z9qnMMcGiHVjBZ
         POxA==
X-Gm-Message-State: AFqh2kolQwIUL09nOz6ScKyH4DDNDD4i1kS1aY2lReDw67vDlkamy2uk
        9Mxa94saydDj4fDS+3yQ/dfwbHeYD/ls3UDBH2/tNzH4PY73ZPHSgvBtNHTg/yqwd5UIhmxg/TJ
        5AjFsO+f37hEpi2mtBMjB3qwf0DS0Gw==
X-Received: by 2002:a05:600c:354a:b0:3da:1f6a:7b36 with SMTP id i10-20020a05600c354a00b003da1f6a7b36mr40128696wmq.0.1674828587973;
        Fri, 27 Jan 2023 06:09:47 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs7b7lhU/Xr193ycZjTx4N8Y9Ik+fcCC7Uk9va/piM6WqgeOvJzsU8QQFjACQP4jx7hH+udxQ==
X-Received: by 2002:a05:600c:354a:b0:3da:1f6a:7b36 with SMTP id i10-20020a05600c354a00b003da1f6a7b36mr40128673wmq.0.1674828587759;
        Fri, 27 Jan 2023 06:09:47 -0800 (PST)
Received: from qwirkle.internal ([81.2.157.149])
        by smtp.gmail.com with ESMTPSA id f21-20020a5d58f5000000b00236883f2f5csm4105833wrd.94.2023.01.27.06.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 06:09:47 -0800 (PST)
From:   Andrei Gherzan <andrei.gherzan@canonical.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     Andrei Gherzan <andrei.gherzan@canonical.com>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH v3 1/3] selftests: net: .gitignore the scratch directory of bpf
Date:   Fri, 27 Jan 2023 14:09:42 +0000
Message-Id: <20230127140944.265135-1-andrei.gherzan@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The net/bpf Makefile uses a similar build infrastructure to BPF[1] while
building libbpf as a dependency of nat6to4. This change adds a .gitignore
entry for SCRATCH_DIR where libbpf and its headers end up built/installed.

[1] Introduced in commit 837a3d66d698 ("selftests: net: Add
cross-compilation support for BPF programs")

Signed-off-by: Andrei Gherzan <andrei.gherzan@canonical.com>
---
 tools/testing/selftests/net/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index a6911cae368c..0d07dd13c973 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -40,6 +40,7 @@ test_unix_oob
 timestamping
 tls
 toeplitz
+/tools
 tun
 txring_overwrite
 txtimestamp
-- 
2.34.1

