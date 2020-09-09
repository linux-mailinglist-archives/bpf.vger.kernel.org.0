Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5DC2631BB
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 18:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730707AbgIIQY4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 12:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731024AbgIIQXK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 12:23:10 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F60EC061799
        for <bpf@vger.kernel.org>; Wed,  9 Sep 2020 09:22:57 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x14so3589657wrl.12
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2020 09:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ibbGvloEu/er/gxrQRj/eD86Ur3GzyS3TfSqdxdC+RY=;
        b=v6xcGeyQk4jBYD4EXao1WuMOfYj8b7504XXMaJ3uGCJ3UQdcVQ83+EmrYRG42BjX3n
         62QrWncVoDZKLyji40NOXa+of+ODsG4nNCFi5+zWq1mRL7GlJ+pbGcYF2AUVU/o1rgwc
         5Sis0FVFzXs1DI7rRrGgeVLQYzmSedQ8qrGuV0se0Fg3+Klbay8C4PGpf1cM6tLhuCYD
         Wyz0Dwu78+sCZy6rIzBb0P81o+YR2VgHzi7G5Az4ispCXgJlhNCJF8T2RhWhDgt1OXaI
         dOWIz8Mjmg/0kyKJfQJurhgOV9Ina7bAf93r29HsngePOrv3Ch6n339qHoWSQneHu1s6
         p1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ibbGvloEu/er/gxrQRj/eD86Ur3GzyS3TfSqdxdC+RY=;
        b=b8vsRHyrWMm7avbKUaiXo9vknjE8QGfuUHwf0K4HiSvpnJbDLghM1eOV26ITcK30B1
         me19FaI6SkHnscqP4g5j5na6FrRNYVP4H5lTO4Af+kXx1cS8W8ghy5rg6WUS/9/2tdMT
         TPFNVNDZz61+6fjwd7Z5bW3H4mv5MUUTk5S1YyrjkX9NtjxemP5kSAheChd1pfXD/zZv
         Tk7ALvNypym+xtjcs7isoyS3BJn01RVKuOZJ0Rz4/MI9NCPcdASpwXsDd4FMaI/8h9lf
         XoV/ExPrQUrSUxmoIP5+nD4HLIal/l4hZ1FXpyLTqS9x/1UGJesjR7lQRMMynX5RLhmA
         oRPg==
X-Gm-Message-State: AOAM532ZTHRxUQ0o6S787ckODUPFYX932kBjULZmypuCtBPRh8+AACPU
        7BzV0Iex1YM8vt2Km5qYX/CBYA==
X-Google-Smtp-Source: ABdhPJwO2t0HdtfD4UWht59h09D50pLZF+oL11fB2DJfFWvyycugdXcsWrZtBf1JRu8D8O90ZA1N5w==
X-Received: by 2002:a05:6000:118a:: with SMTP id g10mr4745469wrx.67.1599668576073;
        Wed, 09 Sep 2020 09:22:56 -0700 (PDT)
Received: from localhost.localdomain ([194.35.119.149])
        by smtp.gmail.com with ESMTPSA id m1sm4747787wmc.28.2020.09.09.09.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 09:22:55 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v2 2/2] selftests, bpftool: add bpftool (and eBPF helpers) documentation build
Date:   Wed,  9 Sep 2020 17:22:51 +0100
Message-Id: <20200909162251.15498-3-quentin@isovalent.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200909162251.15498-1-quentin@isovalent.com>
References: <20200909162251.15498-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

eBPF selftests include a script to check that bpftool builds correctly
with different command lines. Let's add one build for bpftool's
documentation so as to detect errors or warning reported by rst2man when
compiling the man pages. Also add a build to the selftests Makefile to
make sure we build bpftool documentation along with bpftool when
building the selftests.

This also builds and checks warnings for the man page for eBPF helpers,
which is built along bpftool's documentation.

This change adds rst2man as a dependency for selftests (it comes with
Python's "docutils").

v2:
- Use "--exit-status=1" option for rst2man instead of counting lines
  from stderr.
- Also build bpftool as part as the selftests build (and not only when
  the tests are actually run).

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/testing/selftests/bpf/Makefile          |  5 +++++
 .../selftests/bpf/test_bpftool_build.sh       | 21 +++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 65d3d9aaeb31..05798c2b5c67 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -176,6 +176,11 @@ $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
 	$(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)			       \
 		    OUTPUT=$(BUILD_DIR)/bpftool/			       \
 		    prefix= DESTDIR=$(SCRATCH_DIR)/ install
+	$(Q)mkdir -p $(BUILD_DIR)/bpftool/Documentation
+	$(Q)RST2MAN_OPTS="--exit-status=1" $(MAKE) $(submake_extras)	       \
+		    -C $(BPFTOOLDIR)/Documentation			       \
+		    OUTPUT=$(BUILD_DIR)/bpftool/Documentation/		       \
+		    prefix= DESTDIR=$(SCRATCH_DIR)/ install
 
 $(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		       \
 	   ../../../include/uapi/linux/bpf.h                                   \
diff --git a/tools/testing/selftests/bpf/test_bpftool_build.sh b/tools/testing/selftests/bpf/test_bpftool_build.sh
index ac349a5cea7e..2db3c60e1e61 100755
--- a/tools/testing/selftests/bpf/test_bpftool_build.sh
+++ b/tools/testing/selftests/bpf/test_bpftool_build.sh
@@ -85,6 +85,23 @@ make_with_tmpdir() {
 	echo
 }
 
+make_doc_and_clean() {
+	echo -e "\$PWD:    $PWD"
+	echo -e "command: make -s $* doc >/dev/null"
+	RST2MAN_OPTS="--exit-status=1" make $J -s $* doc
+	if [ $? -ne 0 ] ; then
+		ERROR=1
+		printf "FAILURE: Errors or warnings when building documentation\n"
+	fi
+	(
+		if [ $# -ge 1 ] ; then
+			cd ${@: -1}
+		fi
+		make -s doc-clean
+	)
+	echo
+}
+
 echo "Trying to build bpftool"
 echo -e "... through kbuild\n"
 
@@ -145,3 +162,7 @@ make_and_clean
 make_with_tmpdir OUTPUT
 
 make_with_tmpdir O
+
+echo -e "Checking documentation build\n"
+# From tools/bpf/bpftool
+make_doc_and_clean
-- 
2.25.1

