Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF25343482C
	for <lists+bpf@lfdr.de>; Wed, 20 Oct 2021 11:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhJTJtJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 05:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhJTJtH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 05:49:07 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D189C06161C
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 02:46:53 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id v127so17567961wme.5
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 02:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GeWdIKHBF0SI3AbP7SbsLae9yLN/fn+RNWHpeLCDp48=;
        b=NQcA0xbrHWJfeLAw6CRpOmW+dn1hmTi/9lQbZwDfKRjbqOfGX9t3j1UdMxEdgxX3Ui
         jFEChQTTUjfPFqCybu0rzLMrfMVmN6dI4PETzOFYHgs6gVg1IyuZNMBhnXvdMBDyIcN2
         eaW4srPc+J6h03PN1Jc6JLI8o5UqzrUtqSaliiLOMHB41NmVK2WSo9uFt1Zddr52B+ZC
         9LwsBdp7ZQ2uyWV1sRiStGyrK6khm6hCnGHD/BXxHQFJ1xbsRbhHLSlyR1ropHuNnn1D
         T4/EetD+hrYxftM/xzTvLEuIgipxwbYIAHxhInd0e9o+4oQc+64+P74l2WYryBNQfF06
         C9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GeWdIKHBF0SI3AbP7SbsLae9yLN/fn+RNWHpeLCDp48=;
        b=fymIx8S/br5E2FMecvP1EY8KH1t4xcu9hSHJPuRY+9LrOs42ncEefbKqoi5sJeH+AT
         8iJHmechjE97ek4OPFciCfnlOfqWWSrzUTPYJnijYzWZ/kFdDydqfokXtXDtCtvMwUmy
         6rd+H2UDK4GuiEG59qH0vX3fMW4Ii48R6YZyL2JcIb1/KdmyV5Ac6rSqEQ4tndKbGMa/
         BcSms046ZRFG+cTXvoM+wecmXzWkqhYCPhPVBaXGqX/jzeMLdxEoYFSoG+EyQo49hgxA
         yHOGmdZKB+0Fle7g+cthkQJIfq/jwkluOOXRq8CQPAuPmKXa66WRaUWhnEJGyjc4bF4r
         MwuA==
X-Gm-Message-State: AOAM530xyR6BEw4CLBphSdy2tOJu4SYimW6IapaYirrcthAv1Z615H+y
        SMHycmN8qplgRidXqh5TMGVjUA==
X-Google-Smtp-Source: ABdhPJz0ZHwJC9sZ4mJQxnhWL4CuW5XjYVeJ4v6gSWEVLErPtYTyE9JVjUscDC0GwmO5ycgFxy7b3A==
X-Received: by 2002:a05:600c:b43:: with SMTP id k3mr12196401wmr.142.1634723212165;
        Wed, 20 Oct 2021 02:46:52 -0700 (PDT)
Received: from localhost.localdomain ([149.86.71.75])
        by smtp.gmail.com with ESMTPSA id u5sm1553533wrg.57.2021.10.20.02.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 02:46:51 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>,
        John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH bpf-next v2] bpf/preload: Clean up .gitignore and "clean-files" target
Date:   Wed, 20 Oct 2021 10:46:47 +0100
Message-Id: <20211020094647.15564-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

kernel/bpf/preload/Makefile was recently updated to have it install
libbpf's headers locally instead of pulling them from tools/lib/bpf. But
two items still need to be addressed.

First, the local .gitignore file was not adjusted to ignore the files
generated in the new kernel/bpf/preload/libbpf output directory.

Second, the "clean-files" target is now incorrect. The old artefacts
names were not removed from the target, while the new ones were added
incorrectly. This is because "clean-files" expects names relative to
$(obj), but we passed the absolute path instead. This results in the
output and header-destination directories for libbpf (and their
contents) not being removed from kernel/bpf/preload on "make clean" from
the root of the repository.

This commit fixes both issues. Note that $(userprogs) needs not be added
to "clean-files", because the cleaning infrastructure already accounts
for it.

Cleaning the files properly also prevents make from printing the
following message, for builds coming after a "make clean":
"make[4]: Nothing to be done for 'install_headers'."

v2: Simplify the "clean-files" target.

Fixes: bf60791741d4 ("bpf: preload: Install libbpf headers when building")
Signed-off-by: Quentin Monnet <quentin@isovalent.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 kernel/bpf/preload/.gitignore | 4 +---
 kernel/bpf/preload/Makefile   | 3 +--
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/preload/.gitignore b/kernel/bpf/preload/.gitignore
index 856a4c5ad0dd..9452322902a5 100644
--- a/kernel/bpf/preload/.gitignore
+++ b/kernel/bpf/preload/.gitignore
@@ -1,4 +1,2 @@
-/FEATURE-DUMP.libbpf
-/bpf_helper_defs.h
-/feature
+/libbpf
 /bpf_preload_umd
diff --git a/kernel/bpf/preload/Makefile b/kernel/bpf/preload/Makefile
index 469d35e890eb..1400ac58178e 100644
--- a/kernel/bpf/preload/Makefile
+++ b/kernel/bpf/preload/Makefile
@@ -27,8 +27,7 @@ userccflags += -I $(srctree)/tools/include/ -I $(srctree)/tools/include/uapi \
 
 userprogs := bpf_preload_umd
 
-clean-files := $(userprogs) bpf_helper_defs.h FEATURE-DUMP.libbpf staticobjs/ feature/
-clean-files += $(LIBBPF_OUT) $(LIBBPF_DESTDIR)
+clean-files := libbpf/
 
 $(obj)/iterators/iterators.o: | libbpf_hdrs
 
-- 
2.30.2

