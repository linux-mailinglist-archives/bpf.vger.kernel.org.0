Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A906A889A
	for <lists+bpf@lfdr.de>; Thu,  2 Mar 2023 19:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjCBSjX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 13:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCBSjW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 13:39:22 -0500
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871D410263;
        Thu,  2 Mar 2023 10:39:21 -0800 (PST)
Received: by mail-qv1-f46.google.com with SMTP id o3so172652qvr.1;
        Thu, 02 Mar 2023 10:39:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677782360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xh37jVV18tU4XLWiHUq7/XGNNCrD2HtDOL15WPjQ7Os=;
        b=UsnBUeY4APLvnG5/lRzdQ/TXh9PiHQak3KDRUUCmWER4CPcHySsjncprXkd7S4jdmA
         2YeWSlMRTsYlMfUD66uyMKjX2vX5T8MH3dTJi4xd6//DR4R9xeJ2PxPUfY5nx1afQ536
         lpmk/AJHwTc3xZA3jrEzMQvAvm1tWoJkCSlFKfpJLs4qksgeWxuhi484scGo98gQQl6w
         mTqdLpVz4unLadv3BSlnk99H7wc58UxkXZKWQtHxD9fIHOVg9lk3lmAfK6X4ZmPpPol4
         rsa/7qZQZou9XrPkqXz+w+JsAU6RYqOtr/YDqfhwZ9XMfdHoMkKmTjdNypUizexGCHjv
         7NVg==
X-Gm-Message-State: AO0yUKUsA4xGZLKxdUHpIdDH5yaAt6O8+P6YGitcKqt98zwWP3ZOSdWc
        WBPkLFWeE5mkzGtEAV86zH+504YHga35g+qB
X-Google-Smtp-Source: AK7set+a+m30hD1vItmKf8TpDPISS8DbpLHPihQyCZGszCawPXeoyfqm3JnZaq4siDBbK13eXYDWMQ==
X-Received: by 2002:a05:6214:248c:b0:56e:b1d2:9c2a with SMTP id gi12-20020a056214248c00b0056eb1d29c2amr22091937qvb.28.1677782360212;
        Thu, 02 Mar 2023 10:39:20 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:5434])
        by smtp.gmail.com with ESMTPSA id l19-20020a05620a211300b007423c122457sm150050qkl.63.2023.03.02.10.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 10:39:19 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next 1/2] bpf, docs: Fix link to netdev-FAQ target
Date:   Thu,  2 Mar 2023 12:39:17 -0600
Message-Id: <20230302183918.54190-1-void@manifault.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The BPF devel Q&A documentation page makes frequent reference to the
netdev-QA page via the netdev-FAQ rst link. This link is currently
broken, as is evidenced by the build output when making BPF docs:

./Documentation/bpf/bpf_devel_QA.rst:150: WARNING: undefined label: 'netdev-faq'
./Documentation/bpf/bpf_devel_QA.rst:206: WARNING: undefined label: 'netdev-faq'
./Documentation/bpf/bpf_devel_QA.rst:231: WARNING: undefined label: 'netdev-faq'
./Documentation/bpf/bpf_devel_QA.rst:396: WARNING: undefined label: 'netdev-faq'
./Documentation/bpf/bpf_devel_QA.rst:412: WARNING: undefined label: 'netdev-faq'

Fix the links to point to the actual netdev-faq page.

Signed-off-by: David Vernet <void@manifault.com>
---
 Documentation/bpf/bpf_devel_QA.rst | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/bpf/bpf_devel_QA.rst b/Documentation/bpf/bpf_devel_QA.rst
index 03d4993eda6f..5f5f9ccc3862 100644
--- a/Documentation/bpf/bpf_devel_QA.rst
+++ b/Documentation/bpf/bpf_devel_QA.rst
@@ -128,7 +128,7 @@ into the bpf-next tree will make their way into net-next tree. net and
 net-next are both run by David S. Miller. From there, they will go
 into the kernel mainline tree run by Linus Torvalds. To read up on the
 process of net and net-next being merged into the mainline tree, see
-the :ref:`netdev-FAQ`
+the `netdev-FAQ`_.
 
 
 
@@ -147,7 +147,7 @@ request)::
 Q: How do I indicate which tree (bpf vs. bpf-next) my patch should be applied to?
 ---------------------------------------------------------------------------------
 
-A: The process is the very same as described in the :ref:`netdev-FAQ`,
+A: The process is the very same as described in the `netdev-FAQ`_,
 so please read up on it. The subject line must indicate whether the
 patch is a fix or rather "next-like" content in order to let the
 maintainers know whether it is targeted at bpf or bpf-next.
@@ -206,7 +206,7 @@ ii) run extensive BPF test suite and
 Once the BPF pull request was accepted by David S. Miller, then
 the patches end up in net or net-next tree, respectively, and
 make their way from there further into mainline. Again, see the
-:ref:`netdev-FAQ` for additional information e.g. on how often they are
+`netdev-FAQ`_ for additional information e.g. on how often they are
 merged to mainline.
 
 Q: How long do I need to wait for feedback on my BPF patches?
@@ -230,7 +230,7 @@ Q: Are patches applied to bpf-next when the merge window is open?
 -----------------------------------------------------------------
 A: For the time when the merge window is open, bpf-next will not be
 processed. This is roughly analogous to net-next patch processing,
-so feel free to read up on the :ref:`netdev-FAQ` about further details.
+so feel free to read up on the `netdev-FAQ`_ about further details.
 
 During those two weeks of merge window, we might ask you to resend
 your patch series once bpf-next is open again. Once Linus released
@@ -394,7 +394,7 @@ netdev kernel mailing list in Cc and ask for the fix to be queued up:
   netdev@vger.kernel.org
 
 The process in general is the same as on netdev itself, see also the
-:ref:`netdev-FAQ`.
+`netdev-FAQ`_.
 
 Q: Do you also backport to kernels not currently maintained as stable?
 ----------------------------------------------------------------------
@@ -410,7 +410,7 @@ Q: The BPF patch I am about to submit needs to go to stable as well
 What should I do?
 
 A: The same rules apply as with netdev patch submissions in general, see
-the :ref:`netdev-FAQ`.
+the `netdev-FAQ`_.
 
 Never add "``Cc: stable@vger.kernel.org``" to the patch description, but
 ask the BPF maintainers to queue the patches instead. This can be done
@@ -685,7 +685,7 @@ when:
 
 .. Links
 .. _Documentation/process/: https://www.kernel.org/doc/html/latest/process/
-.. _netdev-FAQ: Documentation/process/maintainer-netdev.rst
+.. _netdev-FAQ: https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
 .. _selftests:
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf/
 .. _Documentation/dev-tools/kselftest.rst:
-- 
2.39.0

