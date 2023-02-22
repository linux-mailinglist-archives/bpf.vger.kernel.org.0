Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7B569F05E
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 09:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjBVIgB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 03:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjBVIf6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 03:35:58 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7300230B36;
        Wed, 22 Feb 2023 00:35:47 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id e5so8994287plg.8;
        Wed, 22 Feb 2023 00:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kti8JgugRVGLXizNka/HYINXfKruoK/QDuSJAx3hfIU=;
        b=qdPdPA9JC+RKYJV7GtxPcqGD/C42MNquMUh00lproMLqkg1EfHKK4IPtgQTB6Eb+Be
         o1LU7+BR/OvnFKnaTp0QAY9U/Zq34ORx+2G/P745uFNHO2cJNY9kmZzfQuux1E5D+5h0
         9abp6IzWr24g78juJ/xxxfzKmJDhr80FPO/YRyCrflB/fWWq5urnxa6yfC2AGbHNXaGB
         MwpV/UujEw054q7l+nXMuJvyl6rkdV4ecJohC5aHnfHuxM2davf5Im7cWXKplAgODbtU
         B79KVhfLgcp3m+nWVuqFmRqWoDJksVOAnJ6Ae7RlnGK22903KXwiNxcFN4kdNvwqJCTN
         Lqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kti8JgugRVGLXizNka/HYINXfKruoK/QDuSJAx3hfIU=;
        b=S3CjmHXsOnfYbL1McN1lmoM86flahpBcBGwRr7Nx8j71aK6aeprjfpCJmL0HNJ2eQI
         43aKjfh8Ety6Mkf+ffadEwWpQ3HBjKe4YlNsP+xzxVxMdRqXCZGI3yIxMnMGhWCYcEH2
         fjoqnM6/K3pUleWxHhRALn1SF4Cgez2VBvGajwDfdA9edvnYCbOep6pNtxrY3LHY7F/W
         xoux7KMqMsuWwU1/CEub8O4whX4nHjODUdc9vVERGU2f9w1ji1AK5cm3GNK8ztoSfoll
         c3XOIRrAkDNCFHY86xiT/jjwc7F9wW48lIRLNIyqJH8rw3aN8lq4K2Gdl1drupJW6UbQ
         u9Rg==
X-Gm-Message-State: AO0yUKUuQzDFxrG2EmEJl6D2hg1EsbvU0G19drwI4ra7qKr45MraFRlx
        47serhQgI30F7tX5HgC0Rtw=
X-Google-Smtp-Source: AK7set+8KuBgbHI7br2D4+Z0RBwGinzpSWzxE0w3j++VzmdMaJuJkqx+d+nEga9GuWIKz/GhtDCPYA==
X-Received: by 2002:a17:902:dad1:b0:196:5839:b374 with SMTP id q17-20020a170902dad100b001965839b374mr8650865plx.9.1677054946877;
        Wed, 22 Feb 2023 00:35:46 -0800 (PST)
Received: from debian.me (subs02-180-214-232-84.three.co.id. [180.214.232.84])
        by smtp.gmail.com with ESMTPSA id o4-20020a170902bcc400b0019c901b35ecsm3014759pls.106.2023.02.22.00.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 00:35:46 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id B9D1C10658F; Wed, 22 Feb 2023 15:35:41 +0700 (WIB)
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
Subject: [PATCH v2] Documentation: bpf: Fix link to BTF doc
Date:   Wed, 22 Feb 2023 15:35:30 +0700
Message-Id: <20230222083530.26136-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2388; i=bagasdotme@gmail.com; h=from:subject; bh=oKNgKZHFEdu2il286nEDO6UrFE9zRMlSbKSG+cvR994=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMlfL5+UnMD7bZ4JX0R8Rd6uJfcmic/bz/2MU0Zb5O/aJS21 iU7TOkpZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjCRxFcM/7RfcHwX4sh31Q79d2nOSk HuwCWPVPaYJV9LDuPbYheVpcfIsOun+eOuy0q3glztHxs6H+vl98nYtlfD6n2xS6fOwqvVHAA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Ross reported broken link to BTF documentation
(Documentation/bpf/btf.rst) in Documentation/bpf/bpf_devel_QA.rst. The
link in question is written using external link syntax, with the target
refers to BTF doc in reST source (btf.rst), which doesn't exist in
resulting HTML output.

Fix the link by replacing external link syntax with simply writing out
the target doc, which the link will be generated to the correct HTML doc
target.

Link: https://lore.kernel.org/linux-doc/Y++09LKx25dtR4Ow@google.com/
Fixes: 6736aa793c2b5f ("selftests/bpf: Add general instructions for test execution")
Reported-by: Ross Zwisler <zwisler@google.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
Changes since v1 [1]:

  * Reword patch description (I don't see external link semantics on
    Sphinx documentation [2] when I submit v1).
  * Drop the corresponding orphan target definition.
  * Rebase on top of current bpf tree.

Ross, do you want to give a Reviewed-by or Acked-by?

[1]: https://lore.kernel.org/linux-doc/20230219030956.22662-1-bagasdotme@gmail.com/ 
[2]: https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#external-links

 Documentation/bpf/bpf_devel_QA.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/bpf/bpf_devel_QA.rst b/Documentation/bpf/bpf_devel_QA.rst
index 03d4993eda6f05..715f7321020f27 100644
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
@@ -690,6 +690,5 @@ when:
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf/
 .. _Documentation/dev-tools/kselftest.rst:
    https://www.kernel.org/doc/html/latest/dev-tools/kselftest.html
-.. _Documentation/bpf/btf.rst: btf.rst
 
 Happy BPF hacking!

base-commit: 345d24a91c79f408e355c8b7e873ccde0f097eea
-- 
An old man doll... just what I always wanted! - Clara

