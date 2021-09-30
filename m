Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE6941D8E2
	for <lists+bpf@lfdr.de>; Thu, 30 Sep 2021 13:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350559AbhI3Lf4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Sep 2021 07:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350524AbhI3Lfw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Sep 2021 07:35:52 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9E8C06176A
        for <bpf@vger.kernel.org>; Thu, 30 Sep 2021 04:34:10 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id x20so9491987wrg.10
        for <bpf@vger.kernel.org>; Thu, 30 Sep 2021 04:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6qPlM6MAUchBkbCWCD/H91DQxecPf+FzubhRu6ucuSs=;
        b=ngoQMemrzIewdd3+IzesJcp06Wm6Qo2mJJj4JtXI83Ie4+j3CnMKPemhFtRk370aYB
         At51Lvv1n7GMQVGDu8x4ocfwd+TfhooeLe7QrX1VUp5eM4Fzx+FkhpWdRY4ExI/WG8tw
         3hiVBKB/xefgKpOMhL3Gp6C5Y3nkmm0sjKa5FSChj/n3dHZzddS/xRepLtRVPY6vfwOr
         3f1p5WcFy/qrHKBumoB/AOJ9QSaq0BUPqlau6XaA4odR9Hy6knvewR4kvf2HJdDC0AwE
         5SJZP4CZdhAvKwAdIE4ONcbfE7U87ejPTr30jDBL69v1VROCmNX+/eFitdRfepsF5x3C
         DmEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6qPlM6MAUchBkbCWCD/H91DQxecPf+FzubhRu6ucuSs=;
        b=wcVZd6+3AuyymHS7Z++pBqc7hOrDg/N1QHP6F+M9lMJuj+zxag0qv0yfG8QQA0JoLM
         x6J2AK8CNsWdOtB39dLwpGB7YmJASSypKPD27VteMM4fMG93jb/kXKn+NpJBBMiIVlL2
         e9mcWZjes9cZP7ybAZG8Z2v8zjQiO9h2YOCY7zTVXKDBlt/9BfMvedSjZuAMgr7w+2IW
         HVc8h5J1lKTiDVWhQfxlxvim0AUjlaj8f0digu3HJ9B0WFR+4i2Kug6orP6Y6cuYbhgU
         4ZvA4K8T6oYF9A8SGvCPPJGLVMzNosgFLXPuBVXe9DRYZpH5gbI0/kCAD+9IboefeJSI
         X0nA==
X-Gm-Message-State: AOAM533youmO+jLZ64lHYAjiwRUHykCUDD6tslVoBBJewdIKCbnoljZr
        lhZO7hyx8EUQPSBmP6eJxnvSHQ==
X-Google-Smtp-Source: ABdhPJz9dIovrgp2dDGP6xv6Y83kaTlcPNC+pb+jjtkJNXRphLp/ODWzSocZaAvxA9DAFqQlXgEDww==
X-Received: by 2002:a5d:4a46:: with SMTP id v6mr5553856wrs.262.1633001649001;
        Thu, 30 Sep 2021 04:34:09 -0700 (PDT)
Received: from localhost.localdomain ([149.86.91.95])
        by smtp.gmail.com with ESMTPSA id v10sm2904660wrm.71.2021.09.30.04.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 04:34:08 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 9/9] selftests/bpf: better clean up for runqslower in test_bpftool_build.sh
Date:   Thu, 30 Sep 2021 12:33:06 +0100
Message-Id: <20210930113306.14950-10-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210930113306.14950-1-quentin@isovalent.com>
References: <20210930113306.14950-1-quentin@isovalent.com>
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

