Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A405169BE54
	for <lists+bpf@lfdr.de>; Sun, 19 Feb 2023 04:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjBSDKR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 18 Feb 2023 22:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBSDKQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 18 Feb 2023 22:10:16 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325CA12BD0;
        Sat, 18 Feb 2023 19:10:14 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id t15so1909046plg.6;
        Sat, 18 Feb 2023 19:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMxey5fgUXmuDtMw1WnDp+7u+hDJ5DMHaMqjjQ1kA6M=;
        b=ZmmyS3WaSkXr90PdP9egZsWRomrEE3eZrrM7iwNnrdZvXXH0o/EL86j8Q4lZAX+Jka
         nDPonioMiP/7zpr9sBFlOpr+TgS5YKkMmd0cM8XrsFDqt7Dh0Nr/yZa0g0b3BB8qgFbO
         q52pyo4wVU+T/CyYOEoz8+2vsChOraLkGrqDsvQusDk4Oshz1QceDIVzV05g6VamPrqC
         JlNkrOIYS5NpG7r8HPdjZbdRdP1SY75zoxhJxGZrTx7xXHbMTLpNoOHaOHoxX8OXISU8
         YNaz3d12PSJ9cGUyHjJnh6/sZnlsK9Al1aFmtSUZzSDWbL1QB9JErKYCC0IlZaUGWzYR
         gLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AMxey5fgUXmuDtMw1WnDp+7u+hDJ5DMHaMqjjQ1kA6M=;
        b=yTGoFvB689o87kRUOxkqn7vZGsDgFRzNcxBab9RPUe8g+lR4yH8Wgk0lqRJm/6QDkK
         o5spRLzEkPf6PGghHFF4JCwPCbeW3ayemoR5MWPGKjdAP/SmW9CFeZwlKejhpR5HVJdV
         hCJw5azcd3Nopeglnyp43WB855w7UTAyXf3CrpukwbZ4VnwNMGCJauNjd/mOdI0yVst3
         hUgbliQLSzIOhGMQIVVpjRowCJ3Gt2pOzNsE+n9tWVd5gUXxDj1MfAMAB7ddVdZEXIwJ
         zbm8cmn8ePdgWkUkBDAXcAIjhSZPr+9+sYJ9G1OyoQvOXiMLa8G2D86Lan3uk/Z3P7ra
         7I9g==
X-Gm-Message-State: AO0yUKVfitzOoaJdtoO4jBFIkkgNp3suQKFor7dVZidIvAAlBaojRl8E
        b+qE3nSIs9x1Q3rQQY+q7FE=
X-Google-Smtp-Source: AK7set+83IH+jFeIwXqmgax6iqqaYNHExJH0dGVhNcBAmDmtzQVupgTRWs8ZyFYMd+lOHH34+ZP5ZA==
X-Received: by 2002:a17:902:f910:b0:19a:b6b1:ca82 with SMTP id kw16-20020a170902f91000b0019ab6b1ca82mr2837312plb.10.1676776213573;
        Sat, 18 Feb 2023 19:10:13 -0800 (PST)
Received: from debian.me (subs28-116-206-12-59.three.co.id. [116.206.12.59])
        by smtp.gmail.com with ESMTPSA id ji9-20020a170903324900b0019aa5e0aadesm3551331plb.110.2023.02.18.19.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 19:10:13 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 747F6105AB3; Sun, 19 Feb 2023 10:10:10 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux BPF <bpf@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Ross Zwisler <zwisler@google.com>
Subject: [PATCH] Documentation: bpf: Fix link to BTF doc
Date:   Sun, 19 Feb 2023 10:09:56 +0700
Message-Id: <20230219030956.22662-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <Y/GRSd/ZfFGnGQ+4@debian.me>
References: <Y/GRSd/ZfFGnGQ+4@debian.me>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1481; i=bagasdotme@gmail.com; h=from:subject; bh=OCe9vfoq2z8zrJCalpAnmb2OUlb2m+yvHWTKun/50mg=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMkfJzM76/zQ/OvZFc1wt9Hcxekj3xLHsqcXRVteXFCMmPhv 31unjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEzEs5+RYVPJwy1udyS6X2+ddF4tUu 3ivtWZnY/rDfLtgnm/dWZ1vmb4w3t0V+SbX1y/S+qWbj394MRVO4H77yfadm59K9Ek8EhejRUA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
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

Ross reported broken link to BTF documentation
(Documentation/bpf/btf.rst) in Documentation/bpf/bpf_devel_QA.rst. The
link in question is written using external link syntax, which behaves
badly when the link target is sibling doc.

Fix the link by replacing external link syntax with simply writing out
the target doc.

Link: https://lore.kernel.org/linux-doc/Y++09LKx25dtR4Ow@google.com/
Fixes: 6736aa793c2b5f ("selftests/bpf: Add general instructions for test execution")
Reported-by: Ross Zwisler <zwisler@google.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/bpf/bpf_devel_QA.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/bpf/bpf_devel_QA.rst b/Documentation/bpf/bpf_devel_QA.rst
index 03d4993eda6f05..a4c1634d18955d 100644
--- a/Documentation/bpf/bpf_devel_QA.rst
+++ b/Documentation/bpf/bpf_devel_QA.rst
@@ -469,7 +469,7 @@ under test should match the config file fragment in
 tools/testing/selftests/bpf as closely as possible.
 
 Finally to ensure support for latest BPF Type Format features -
-discussed in `Documentation/bpf/btf.rst`_ - pahole version 1.16
+discussed in Documentation/bpf/btf.rst - pahole version 1.16
 is required for kernels built with CONFIG_DEBUG_INFO_BTF=y.
 pahole is delivered in the dwarves package or can be built
 from source at

base-commit: 168de0233586fb06c5c5c56304aa9a928a09b0ba
-- 
An old man doll... just what I always wanted! - Clara

