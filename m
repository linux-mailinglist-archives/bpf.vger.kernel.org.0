Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC794203A7
	for <lists+bpf@lfdr.de>; Sun,  3 Oct 2021 21:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbhJCTYY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Oct 2021 15:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbhJCTYV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Oct 2021 15:24:21 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD06BC061798
        for <bpf@vger.kernel.org>; Sun,  3 Oct 2021 12:22:28 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l18-20020a05600c4f1200b002f8cf606262so17206505wmq.1
        for <bpf@vger.kernel.org>; Sun, 03 Oct 2021 12:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6qPlM6MAUchBkbCWCD/H91DQxecPf+FzubhRu6ucuSs=;
        b=JzLgue6VTP/8H6wnhXA7pOgI6vuWWCcHDEe2O2SAqEHI67lRMcZvxR6eCVzkUghmsD
         ZEbp0J97ousKvr3bdTc/f1kAjwQKmPJj1kwCrd6yrOANRhEAxh9wZXH7PwXaPrQ/jmlk
         jMMC5Ls3ejUqG6EyO+KkPtRigtuzqr06NvXN2uMxY7lF9EpPtDwvwjUIprbaJxENOs3B
         TGY6YhqjgjYS709dr2kntVswYdFKzsQS+3V08trhh13RRx90Ag3hl7icV9NRiJ8hqjIG
         HMhQmvBbW0BVCzIIRYGMePVBfSdrfCmOTpiNKWo1toxVlQ+ZxNRzCIfBkJ/YHWDHKCqk
         uQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6qPlM6MAUchBkbCWCD/H91DQxecPf+FzubhRu6ucuSs=;
        b=JuJkmWwBuly5GIPnK7nRDABvjGahyRX88g8aXJ637vgGUo2hG8vEkJmXZ4kHvFMrS9
         CafQ3YFnpjhWmIUw7CT3OsNv9NYW1NorhTbvcIPJ0wd9AMGPIpn7PPaIFUhreNL6gA8P
         /AYzZQskk/CmgZDb8AUlfQKj89OFGW2xaIrEVXPpI0yALyTXNznOgNb4/vKAn7LZeoWV
         nB1g0WTtNRW5nIMjTKtR0yAOU2avo/R8FQu7ytvqUIG9WqzH5BO6EWzYiBQWaQRDwwKz
         ELah/Lb4FBY/1xgcX0W7qxZ249yImD4ydR1yak3CJz/RHEZeH7nrZcvGiFz+TUtBK/xM
         EEdg==
X-Gm-Message-State: AOAM533yPpn58Snx/G1IHGWvv3JCajz+rL+hXrSkjMroby/FnnyxB8fv
        0dF/Dap4WYEFt14WfdzkGnfR2w==
X-Google-Smtp-Source: ABdhPJx+xW/iFnEmz526jnqKOBhDKHPGkVElpt95MJBSlFuMp1iCwteFzsttq9RK88kCs20SsSj+lQ==
X-Received: by 2002:a1c:7706:: with SMTP id t6mr3472713wmi.134.1633288947389;
        Sun, 03 Oct 2021 12:22:27 -0700 (PDT)
Received: from localhost.localdomain ([149.86.88.77])
        by smtp.gmail.com with ESMTPSA id d3sm14124642wrb.36.2021.10.03.12.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 12:22:27 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v3 09/10] selftests/bpf: better clean up for runqslower in test_bpftool_build.sh
Date:   Sun,  3 Oct 2021 20:22:07 +0100
Message-Id: <20211003192208.6297-10-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211003192208.6297-1-quentin@isovalent.com>
References: <20211003192208.6297-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The script test_bpftool_build.sh attempts to build bpftool in the
various supported ways, to make sure nothing breaks.

One of those ways is to run "make tools/bpf" from the root of the kernel
repository. This command builds bpftool, along with the other tools
under tools/bpf, and runqslower in particular. After running the
command and upon a successful bpftool build, the script attempts to
cleanup the generated objects. However, after building with this target
and in the case of runqslower, the files are not cleaned up as expected.

This is because the "tools/bpf" target sets $(OUTPUT) to
.../tools/bpf/runqslower/ when building the tool, causing the object
files to be placed directly under the runqslower directory. But when
running "cd tools/bpf; make clean", the value for $(OUTPUT) is set to
".output" (relative to the runqslower directory) by runqslower's
Makefile, and this is where the Makefile looks for files to clean up.

We cannot easily fix in the root Makefile (where "tools/bpf" is defined)
or in tools/scripts/Makefile.include (setting $(OUTPUT)), where changing
the way the output variables are passed would likely have consequences
elsewhere. We could change runqslower's Makefile to build in the
repository instead of in a dedicated ".output/", but doing so just to
accommodate a test script doesn't sound great. Instead, let's just make
sure that we clean up runqslower properly by adding the correct command
to the script.

This will attempt to clean runqslower twice: the first try with command
"cd tools/bpf; make clean" will search for tools/bpf/runqslower/.output
and fail to clean it (but will still clean the other tools, in
particular bpftool), the second one (added in this commit) sets the
$(OUTPUT) variable like for building with the "tool/bpf" target and
should succeed.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/testing/selftests/bpf/test_bpftool_build.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_bpftool_build.sh b/tools/testing/selftests/bpf/test_bpftool_build.sh
index b03a87571592..1453a53ed547 100755
--- a/tools/testing/selftests/bpf/test_bpftool_build.sh
+++ b/tools/testing/selftests/bpf/test_bpftool_build.sh
@@ -90,6 +90,10 @@ echo -e "... through kbuild\n"
 
 if [ -f ".config" ] ; then
 	make_and_clean tools/bpf
+	## "make tools/bpf" sets $(OUTPUT) to ...tools/bpf/runqslower for
+	## runqslower, but the default (used for the "clean" target) is .output.
+	## Let's make sure we clean runqslower's directory properly.
+	make -C tools/bpf/runqslower OUTPUT=${KDIR_ROOT_DIR}/tools/bpf/runqslower/ clean
 
 	## $OUTPUT is overwritten in kbuild Makefile, and thus cannot be passed
 	## down from toplevel Makefile to bpftool's Makefile.
-- 
2.30.2

