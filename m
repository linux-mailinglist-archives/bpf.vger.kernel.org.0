Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B292C38D49
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2019 16:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbfFGOgW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Jun 2019 10:36:22 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35732 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729441AbfFGOfd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Jun 2019 10:35:33 -0400
Received: by mail-qt1-f195.google.com with SMTP id d23so2511680qto.2
        for <bpf@vger.kernel.org>; Fri, 07 Jun 2019 07:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=GbgsWWJsYfuFE0Ayk1WcQ4Df2lBstgQ/CvJS7+ETd2s=;
        b=QGUXZscHEoL0COiYgKJzGauvXiRnD/yzWrfJsYJcTclbPX9TCvCrdfjxhLSv6VqVOy
         Ds63L+KT50jtxVnmqpdXm+k0hnKJi5RXnLS0g7q5/aYYikllYLDJlOL5jJq9fIyS2KXT
         N4kSzGLH1BqH5+sIoQRhIEIplVz6xOOFXH3kUevzoxUvalU97d0JQV8t5yyidDelIDry
         k8NouTI/Vwk3wkIkBwrPlJNHi55Eas42L1+bSUxShFHT/PfTIYvWn+XASslmcOf+opCq
         Xe44NUEbE+9/+hU7i7HYNQl4s6GIv+QUbmYg2o2r2mDo0R1jnV48MtbC/0gPLmPAyG0T
         qL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GbgsWWJsYfuFE0Ayk1WcQ4Df2lBstgQ/CvJS7+ETd2s=;
        b=G0UuswP9wuETUmAvOeBbNZZDMscfyEgKrZspQaTMJ5fLeML6UNwkuU5/q8+D6DmpEQ
         xdJsmIfxsGwj9JPhlhDL2P5Jx8w76mUiEWmi7EAUEUCK3iNp5gyp8tHVXSj8pHett9II
         TqGtfmVLKhkitqyXpbAuO1ry/hw/C0HC5jHkV/7dZDCCj1iwYsT7dOLHWnQcLzYlY6mg
         AltzpYAqTrQEA77s+SAL/hOZxLceI0xRLO6Qai+wNTiCDcJZA7bYLgKgVmJWSMrqb2XP
         9if0NjAAWE2MR1cof9bgqJ8tQv/ZFsHe4nlSOWZEz1v5a/iWUGiTrgujNOcw4SUJ/Zk7
         szxw==
X-Gm-Message-State: APjAAAXvqYMd4An98+BKbMd8Qy0yCpSbIGZk+fiskMCsEpAemoXTI2H3
        4ps0uwDqGDE2ShGnXLekC73j6u+TI1xN6A==
X-Google-Smtp-Source: APXvYqylHXL8PP8WU7yZy4f3dkfIgSoGD/enIs4QVNUfQMUWy/e2kCWQ7kzXKicoMTtJqeMAeDYHQA==
X-Received: by 2002:ac8:2ca5:: with SMTP id 34mr47371137qtw.246.1559918132104;
        Fri, 07 Jun 2019 07:35:32 -0700 (PDT)
Received: from localhost.localdomain (li1322-146.members.linode.com. [45.79.223.146])
        by smtp.gmail.com with ESMTPSA id c5sm1243963qkb.41.2019.06.07.07.35.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 07:35:31 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andi Kleen <ak@linux.intel.com>, Mark Drayton <mbd@fb.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] perf config: Update default value for llvm.clang-bpf-cmd-template
Date:   Fri,  7 Jun 2019 22:35:08 +0800
Message-Id: <20190607143508.18141-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The clang bpf cmdline template has defined default value in the file
tools/perf/util/llvm-utils.c, which has been changed for several times.

This patch updates the documentation to reflect the latest default value
for the configuration llvm.clang-bpf-cmd-template.

Fixes: d35b168c3dcd ("perf bpf: Give precedence to bpf header dir")
Fixes: cb76371441d0 ("perf llvm: Allow passing options to llc in addition to clang")
Fixes: 1b16fffa389d ("perf llvm-utils: Add bpf include path to clang command line")
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/Documentation/perf-config.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 462b3cde0675..e4aa268d2e38 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -564,9 +564,12 @@ llvm.*::
 	llvm.clang-bpf-cmd-template::
 		Cmdline template. Below lines show its default value. Environment
 		variable is used to pass options.
-		"$CLANG_EXEC -D__KERNEL__ $CLANG_OPTIONS $KERNEL_INC_OPTIONS \
-		-Wno-unused-value -Wno-pointer-sign -working-directory \
-		$WORKING_DIR  -c $CLANG_SOURCE -target bpf -O2 -o -"
+		"$CLANG_EXEC -D__KERNEL__ -D__NR_CPUS__=$NR_CPUS "\
+		"-DLINUX_VERSION_CODE=$LINUX_VERSION_CODE "	\
+		"$CLANG_OPTIONS $PERF_BPF_INC_OPTIONS $KERNEL_INC_OPTIONS " \
+		"-Wno-unused-value -Wno-pointer-sign "		\
+		"-working-directory $WORKING_DIR "		\
+		"-c \"$CLANG_SOURCE\" -target bpf $CLANG_EMIT_LLVM -O2 -o - $LLVM_OPTIONS_PIPE"
 
 	llvm.clang-opt::
 		Options passed to clang.
-- 
2.17.1

