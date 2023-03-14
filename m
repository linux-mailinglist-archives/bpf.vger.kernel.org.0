Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094F66B8C27
	for <lists+bpf@lfdr.de>; Tue, 14 Mar 2023 08:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjCNHpg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Mar 2023 03:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjCNHpc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 03:45:32 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7D915C95;
        Tue, 14 Mar 2023 00:45:18 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id y189so4186367pgb.10;
        Tue, 14 Mar 2023 00:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678779918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wkbLUz3t4yNMZloDeQATgW6sx1hgcVThGklposOFn50=;
        b=QNQO0u0sIxZTgk06Widi13P5TGO2Qx7wWen083tyd1qpTR8+GNo8MopmdAYQWIpQTy
         wxegRtWriC+E5IZgVOI15ngBpzGN1N81sB88IsZdmNo+zqtu6W8k9SZ+qiD0w4tYEm7h
         L/Lu9Q3vmVAlrhwr8v3HgbxPfy0WpzeEGE3f/IQV514o/MCTr3bypfxE5c7Fdu97Kl2r
         wKBI6FewS9vJWPe99SUeOzjMUEMBH4BCI0DHfC1GK3uvX37C61rBKxvS1QQhOUg4Z76A
         AA3EbZh5pTYED1anw6viin9F2Fc022Zf+/SEqj43R9dgyQktaDbjUY/iW3QUa9vazp4d
         E5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678779918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wkbLUz3t4yNMZloDeQATgW6sx1hgcVThGklposOFn50=;
        b=Ryhfr9hoILkVmdVCHWBfpiy0ffVDd21EkwcS34bvtvPzW+jzGxEb+HjNAnPgCFD1Vo
         lbse0BWyNDQiNlkPE4jwtpBNnF7ud8Bsckox5GpYyfZJ+So3wpXorqmtTOY1myu4JOl/
         uEmeoz7UjJl/W5MzLmjVNBLkHSztWDqsMyVSP/32qiFJjNvSfWMVGQ1cHDTiA64Bo5dP
         Q6vk/j4gc49usDb75KgKO7Z+by/3l9QwyArUP3TUahwlZOFMEms0yuXO7uMX78bwM+g+
         jNa759aJfony4OPRk3L6LhrzdRnFWOVn1QQzKHGviYU/cI/+YcQgu+kayAGaPR+xUahJ
         SsEg==
X-Gm-Message-State: AO0yUKVWK3VzWPwvSIo6KwAu1opyyRdHb5GdBk8IJf/KZ90TN6YPbTRP
        4fp1sNQInlY+r6cDLnOXbhc=
X-Google-Smtp-Source: AK7set9/cPv5U5/o/v6s8RyauzxAR4FNVrk9s2o7JTfwwUiaP6vCIHWOY8NvcW6sKgQFxDjL42s4PA==
X-Received: by 2002:a62:4dc6:0:b0:624:6fdf:b36e with SMTP id a189-20020a624dc6000000b006246fdfb36emr5357025pfb.28.1678779918255;
        Tue, 14 Mar 2023 00:45:18 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-23.three.co.id. [180.214.232.23])
        by smtp.gmail.com with ESMTPSA id x4-20020aa79184000000b006089fb79f1esm951603pfa.96.2023.03.14.00.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 00:45:17 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 15BF01065A6; Tue, 14 Mar 2023 14:45:13 +0700 (WIB)
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
Subject: [PATCH bpf-next v2] bpf, docs: Use internal linking for link to netdev subsystem doc
Date:   Tue, 14 Mar 2023 14:44:49 +0700
Message-Id: <20230314074449.23620-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5399; i=bagasdotme@gmail.com; h=from:subject; bh=l4lUIuUTeBYSWJjEBK5BU+4Eb6nddzH8ARgPVJatgyA=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCkCqq/iauwCTFfYVf54sEw0I+JAwOTWpvkdf+WelUz5Eaqy 0keoo5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABOx3MnwP+G5UYHUfzfF57LapzfP5/ OaFy0scuFEXKWcc1rEn1sW8xj+ikxLuGLw8+BEtY9bl3xZYrV+tk5mwuN6fs9Hz0ROu4oVMAIA
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

Commit d56b0c461d19da ("bpf, docs: Fix link to netdev-FAQ target")
attempts to fix linking problem to undefined "netdev-FAQ" label
introduced in 287f4fa99a5281 ("docs: Update references to netdev-FAQ")
by changing internal cross reference to netdev subsystem documentation
(Documentation/process/maintainer-netdev.rst) to external one at
docs.kernel.org. However, the linking problem is still not
resolved, as the generated link points to non-existent netdev-FAQ
section of the external doc, which when clicked, will instead going to
the top of the doc.

Revert back to internal linking by simply mention the doc path while
massaging the leading text to the link, since the netdev subsystem doc
contains no FAQs but rather general information about the subsystem.

Fixes: d56b0c461d19da ("bpf, docs: Fix link to netdev-FAQ target")
Fixes: 287f4fa99a5281 ("docs: Update references to netdev-FAQ")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Changes since v1 [1]:

   * Use plain doc path for internal linking
   * Edit the surrounding text to mention what the target is about

 There is an unresolved question: Is this cross-ref fixup should be made
 against bpf tree instead, because the original problem is also seen there?
 If so, I will do the fix against that tree instead.

 [1]: https://lore.kernel.org/linux-doc/20230313025119.17430-1-bagasdotme@gmail.com/

 Documentation/bpf/bpf_devel_QA.rst | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/Documentation/bpf/bpf_devel_QA.rst b/Documentation/bpf/bpf_devel_QA.rst
index 5f5f9ccc3862b4..e151e61dff3818 100644
--- a/Documentation/bpf/bpf_devel_QA.rst
+++ b/Documentation/bpf/bpf_devel_QA.rst
@@ -128,7 +128,8 @@ into the bpf-next tree will make their way into net-next tree. net and
 net-next are both run by David S. Miller. From there, they will go
 into the kernel mainline tree run by Linus Torvalds. To read up on the
 process of net and net-next being merged into the mainline tree, see
-the `netdev-FAQ`_.
+the documentation on netdev subsystem at
+Documentation/process/maintainer-netdev.rst.
 
 
 
@@ -147,7 +148,8 @@ request)::
 Q: How do I indicate which tree (bpf vs. bpf-next) my patch should be applied to?
 ---------------------------------------------------------------------------------
 
-A: The process is the very same as described in the `netdev-FAQ`_,
+A: The process is the very same as described in the netdev subsystem
+documentation at Documentation/process/maintainer-netdev.rst,
 so please read up on it. The subject line must indicate whether the
 patch is a fix or rather "next-like" content in order to let the
 maintainers know whether it is targeted at bpf or bpf-next.
@@ -206,8 +208,9 @@ ii) run extensive BPF test suite and
 Once the BPF pull request was accepted by David S. Miller, then
 the patches end up in net or net-next tree, respectively, and
 make their way from there further into mainline. Again, see the
-`netdev-FAQ`_ for additional information e.g. on how often they are
-merged to mainline.
+documentation for netdev subsystem at
+Documentation/process/maintainer-netdev.rst for additional information
+e.g. on how often they are merged to mainline.
 
 Q: How long do I need to wait for feedback on my BPF patches?
 -------------------------------------------------------------
@@ -230,7 +233,8 @@ Q: Are patches applied to bpf-next when the merge window is open?
 -----------------------------------------------------------------
 A: For the time when the merge window is open, bpf-next will not be
 processed. This is roughly analogous to net-next patch processing,
-so feel free to read up on the `netdev-FAQ`_ about further details.
+so feel free to read up on the netdev docs at
+Documentation/process/maintainer-netdev.rst about further details.
 
 During those two weeks of merge window, we might ask you to resend
 your patch series once bpf-next is open again. Once Linus released
@@ -394,7 +398,8 @@ netdev kernel mailing list in Cc and ask for the fix to be queued up:
   netdev@vger.kernel.org
 
 The process in general is the same as on netdev itself, see also the
-`netdev-FAQ`_.
+the documentation on networking subsystem at
+Documentation/process/maintainer-netdev.rst.
 
 Q: Do you also backport to kernels not currently maintained as stable?
 ----------------------------------------------------------------------
@@ -410,7 +415,7 @@ Q: The BPF patch I am about to submit needs to go to stable as well
 What should I do?
 
 A: The same rules apply as with netdev patch submissions in general, see
-the `netdev-FAQ`_.
+the netdev docs at Documentation/process/maintainer-netdev.rst.
 
 Never add "``Cc: stable@vger.kernel.org``" to the patch description, but
 ask the BPF maintainers to queue the patches instead. This can be done
@@ -685,7 +690,6 @@ when:
 
 .. Links
 .. _Documentation/process/: https://www.kernel.org/doc/html/latest/process/
-.. _netdev-FAQ: https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
 .. _selftests:
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf/
 .. _Documentation/dev-tools/kselftest.rst:

base-commit: 9e36a204bd43553a9cd4bd574612cd9a5df791ea
-- 
An old man doll... just what I always wanted! - Clara

