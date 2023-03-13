Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85E86B6DA2
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 03:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjCMCvi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 12 Mar 2023 22:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCMCvh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 12 Mar 2023 22:51:37 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1180B28D13;
        Sun, 12 Mar 2023 19:51:36 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id ay18so6778892pfb.2;
        Sun, 12 Mar 2023 19:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678675895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VRRSMx2v2DFmECtt35XBQ21MW6ZdBg/28xz4jFsuanE=;
        b=lfoxsY9D87Q7C6KtXsO8WiUJKHolc51gda+7MZhvBWwbSolQy1nIc2Nyc965rYD+TQ
         fvET9OYMU59D3WdpUN2H9o4MLfu1TXKLj2kq+CI/Akve4KL7zMEeLQYi6//a77+ODVSS
         PpwKmHUPLHNI7BjwLA2UqQgJLtyVE0uvaISivtQpEexi786HF7DfRVDRDRB48qJMEZpJ
         ZNR28Gg8YBbstfqTSSs7UAJfYsmiUE0n7D99hIIdSM1j7Kc6c6Eyn1lBeRmLJrnxcCiP
         6LIB8sHS2+X5iLwawApfzyI3eJsBwllkfyuYudL7D05gb2kCYNsP0n3VNdoDBtxFNOeq
         Z2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678675895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VRRSMx2v2DFmECtt35XBQ21MW6ZdBg/28xz4jFsuanE=;
        b=YzAvQPDlAI3q3Vtam0o/S0g1WEj88mawTjnm5AdobDVimFGaNZxzlhQx6dz13CEOTL
         P6yvyDceltGCPd8l9yC0g3qWBMSOpTQYPRAyqbAyBrdVcwVxQhp9ihwrbjU398eV+WXU
         EYMOfB/7UkqjJOFvFskJqdYpyJGZSI7qyB4XiF59FjuLypQMsGMzRpgIKLkGX2uc7Os3
         4cFPzrQjE/7+rEJL8cub/u3QuDIHZCYlPrMU84Flm132YKaRaptkGqK8rS1G9NH3wVKX
         8LZopgqFjM/wQOY2n1fO86JzNq8mNHNJEXulu4P4l/quG68DihO5Zg8Qs1lTEjkTJSy0
         AaCg==
X-Gm-Message-State: AO0yUKWrqGwdfhYKARAEMDJq6SpOIVlDwTZUmn6H/KVnmH3W2lEZ4tCZ
        dFn9f/yyEcHGxz7SuVeXemY=
X-Google-Smtp-Source: AK7set822DufyHOEZO9JTZdPitKHVb43JFGKBQCrugbH23UNCiiJD5t0zSU2b9M8ASIVIrVyd8H+jw==
X-Received: by 2002:a62:8445:0:b0:5e0:a86:a76f with SMTP id k66-20020a628445000000b005e00a86a76fmr33604047pfd.0.1678675895358;
        Sun, 12 Mar 2023 19:51:35 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-80.three.co.id. [180.214.233.80])
        by smtp.gmail.com with ESMTPSA id k14-20020aa7820e000000b005a8c92f7c27sm3241527pfi.212.2023.03.12.19.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 19:51:34 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 0C4E9106689; Mon, 13 Mar 2023 09:51:30 +0700 (WIB)
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
        David Vernet <void@manifault.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Tobin C. Harding" <me@tobin.cc>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH bpf-next] bpf, doc: use internal linking for link to netdev FAQ
Date:   Mon, 13 Mar 2023 09:51:19 +0700
Message-Id: <20230313025119.17430-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4770; i=bagasdotme@gmail.com; h=from:subject; bh=jhf+dtsbEIBfXmk2P4Y9c6wrkiaOxN7o0ZTSvFJVu2k=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCl8/Yu7rQ9yaXL+tpi/lXf1C5kpyW59gWvz91l03Ht52kD+ 1N5THaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZjIwl2MDFuZHX+4f2n3fVDw443RgS c+N+o2r17Md2+arMNfUb7Hj+4yMmwUf7Ds5srkWzlFMUUhAruENq9c/Na1gOv/23eaSdszDnIDAA==
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

Commit d56b0c461d19da ("bpf, docs: Fix link to netdev-FAQ target") fixes
link to netdev FAQ documentation introduced in <blurb> introduced in
287f4fa99a5281 ("docs: Update references to netdev-FAQ"), although the
former commit doesn't mention Fixes: to the latter. However, the former
changes the link to external link to docs.kernel.org, in contrast to the
internal linking employed by the latter.

Use :doc: directive for linking to netdev FAQ doc, while keeping the
anchor text intact and consistency with intention of 287f4fa99a5281.

Fixes: d56b0c461d19da ("bpf, docs: Fix link to netdev-FAQ target")
Fixes: 287f4fa99a5281 ("docs: Update references to netdev-FAQ")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Indeed, this internal linking fix should have been made against bpf
 tree, since the problematic original linking in 287f4fa99a5281 is also
 seen in bpf tree. If that is the case, I will rebase on that tree.

 Documentation/bpf/bpf_devel_QA.rst | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/bpf/bpf_devel_QA.rst b/Documentation/bpf/bpf_devel_QA.rst
index 5f5f9ccc3862b4..e523991da9e0ce 100644
--- a/Documentation/bpf/bpf_devel_QA.rst
+++ b/Documentation/bpf/bpf_devel_QA.rst
@@ -128,7 +128,7 @@ into the bpf-next tree will make their way into net-next tree. net and
 net-next are both run by David S. Miller. From there, they will go
 into the kernel mainline tree run by Linus Torvalds. To read up on the
 process of net and net-next being merged into the mainline tree, see
-the `netdev-FAQ`_.
+the :doc:`netdev-FAQ </process/maintainer-netdev>`.
 
 
 
@@ -147,7 +147,8 @@ request)::
 Q: How do I indicate which tree (bpf vs. bpf-next) my patch should be applied to?
 ---------------------------------------------------------------------------------
 
-A: The process is the very same as described in the `netdev-FAQ`_,
+A: The process is the very same as described in the
+:doc:`netdev-FAQ </process/maintainer-netdev>`,
 so please read up on it. The subject line must indicate whether the
 patch is a fix or rather "next-like" content in order to let the
 maintainers know whether it is targeted at bpf or bpf-next.
@@ -206,8 +207,8 @@ ii) run extensive BPF test suite and
 Once the BPF pull request was accepted by David S. Miller, then
 the patches end up in net or net-next tree, respectively, and
 make their way from there further into mainline. Again, see the
-`netdev-FAQ`_ for additional information e.g. on how often they are
-merged to mainline.
+:doc:`netdev-FAQ </process/maintainer-netdev>` for additional
+information e.g. on how often they are merged to mainline.
 
 Q: How long do I need to wait for feedback on my BPF patches?
 -------------------------------------------------------------
@@ -230,7 +231,8 @@ Q: Are patches applied to bpf-next when the merge window is open?
 -----------------------------------------------------------------
 A: For the time when the merge window is open, bpf-next will not be
 processed. This is roughly analogous to net-next patch processing,
-so feel free to read up on the `netdev-FAQ`_ about further details.
+so feel free to read up on the
+:doc:`netdev-FAQ </process/maintainer-netdev>` about further details.
 
 During those two weeks of merge window, we might ask you to resend
 your patch series once bpf-next is open again. Once Linus released
@@ -394,7 +396,7 @@ netdev kernel mailing list in Cc and ask for the fix to be queued up:
   netdev@vger.kernel.org
 
 The process in general is the same as on netdev itself, see also the
-`netdev-FAQ`_.
+:doc:`netdev-FAQ </process/maintainer-netdev>`.
 
 Q: Do you also backport to kernels not currently maintained as stable?
 ----------------------------------------------------------------------
@@ -410,7 +412,7 @@ Q: The BPF patch I am about to submit needs to go to stable as well
 What should I do?
 
 A: The same rules apply as with netdev patch submissions in general, see
-the `netdev-FAQ`_.
+the :doc:`netdev-FAQ </process/maintainer-netdev>`.
 
 Never add "``Cc: stable@vger.kernel.org``" to the patch description, but
 ask the BPF maintainers to queue the patches instead. This can be done
@@ -685,7 +687,6 @@ when:
 
 .. Links
 .. _Documentation/process/: https://www.kernel.org/doc/html/latest/process/
-.. _netdev-FAQ: https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
 .. _selftests:
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf/
 .. _Documentation/dev-tools/kselftest.rst:

base-commit: 49b5300f1f8f2b542b31d63043c2febd13edbe3a
-- 
An old man doll... just what I always wanted! - Clara

