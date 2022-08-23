Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D676859EA50
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 19:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbiHWRxf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 13:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbiHWRws (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 13:52:48 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7CE6FA3C
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 08:54:25 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id v7-20020a1cac07000000b003a6062a4f81so9846321wme.1
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 08:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=bkLmSlSilGFE1QJrhM8SiC5gWbFLHjcrAXY+jH31wms=;
        b=qxZST4kipaSZftXRzTnaR7laRUKswCCQF3JQ4elcqgtdpHUe0++m5alK0T1PtApuiA
         Slo+ZzFk3ZUdbA2B0WgbasnuF0xutN24hVG3aCKYBIGdaxxif/Ba3v2dfp+V8lU+DgJR
         dtDBS44C+xY+tfCaI5lWJMtFvoVqZHKfXndk7OrZyvs408m4GWjjWGTTakQseX2OM4JK
         mqwbw1GLGdTkgFyLEY0mcLblGLOy7wYoAi+0SObZ7nh9E4iu3mFd3box22xdCc0IXmi8
         htCQCA3oDYogTl7uzBVHKqOsce6yRqHUtQrXAIJBfCCTAup4SgXaR7bbOTPqQzCfIFrz
         TMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=bkLmSlSilGFE1QJrhM8SiC5gWbFLHjcrAXY+jH31wms=;
        b=WjXvi0NcVIwI7K9VmpkjfmTKMMRx2bXZ3W2vSDgrPIacnd1qkseqo9OvQsHWinOS23
         aJoE2ecNPVzDZkIz2Hyvb/0vDydDcOeIonFftNCqCfmsFtPLEc+HD43FroqMPKPq5Cb/
         FunibiG2/0JI4101cu7IUilvQ5cGGgC3Ic0gXL3nOv1Gd7lXQRsYNKMaHjmpICDimqvJ
         KeInYSzN+080Comu8MAHtO67Wr+JYQWhtcioqT43r9W/fBHz/BuidjLFnHm8rz4lH+1w
         osj8/CxDKdhH/dEjJpTHI11VrthBv1kLu/x68iOoAaYdB7xUKYyxaYcIpfRCTjgkRzWO
         g+NQ==
X-Gm-Message-State: ACgBeo2jjuMGBLBEwCtGE9ZFYIAVmdFb9ge1xCCLW01np7okd2sIOaqW
        l/JY0DQNqw9Vu3ZFAYUbpP5Aew==
X-Google-Smtp-Source: AA6agR7zgG0FfbmeTqsmhRtDnKN2jHC72LSYtoLOBfAA95BKXTvfIz9D8Zz2rse7og0A9hqNWTGDdw==
X-Received: by 2002:a05:600c:1da3:b0:3a5:c1ea:cd98 with SMTP id p35-20020a05600c1da300b003a5c1eacd98mr2634716wms.174.1661270064255;
        Tue, 23 Aug 2022 08:54:24 -0700 (PDT)
Received: from harfang.fritz.box ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id m9-20020a7bce09000000b003a3442f1229sm21064089wmc.29.2022.08.23.08.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 08:54:23 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, Quentin Monnet <quentin@isovalent.com>,
        Alejandro Colomar <alx.manpages@gmail.com>
Subject: [PATCH bpf-next v2 1/2] scripts/bpf: Set version attribute for bpf-helpers(7) man page
Date:   Tue, 23 Aug 2022 16:53:26 +0100
Message-Id: <20220823155327.98888-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The bpf-helpers(7) manual page shipped in the man-pages project is
generated from the documentation contained in the BPF UAPI header, in
the Linux repository, parsed by script/bpf_doc.py and then fed to
rst2man.

After a recent update of that page [0], Alejandro reported that the
linter used to validate the man pages complains about the generated
document [1]. The header for the page is supposed to contain some
attributes that we do not set correctly with the script. This commit
updates the "project and version" field. We discussed the format of
those fields in [1] and [2].

Before:

    $ ./scripts/bpf_doc.py helpers | rst2man | grep '\.TH'
    .TH BPF-HELPERS 7 "" "" ""

After:

    $ ./scripts/bpf_doc.py helpers | rst2man | grep '\.TH'
    .TH BPF-HELPERS 7 "" "Linux v5.19-14022-g30d2a4d74e11" ""

We get the version from "git describe", but if unavailable, we fall back
on "make kernelversion". If none works, for example because neither git
nore make are installed, we just set the field to "Linux" and keep
generating the page.

[0] https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/man7/bpf-helpers.7?id=19c7f78393f2b038e76099f87335ddf43a87f039
[1] https://lore.kernel.org/all/20220823084719.13613-1-quentin@isovalent.com/t/#m58a418a318642c6428e14ce9bb84eba5183b06e8
[2] https://lore.kernel.org/all/20220721110821.8240-1-alx.manpages@gmail.com/t/#m8e689a822e03f6e2530a0d6de9d128401916c5de

Cc: Alejandro Colomar <alx.manpages@gmail.com>
Reported-by: Alejandro Colomar <alx.manpages@gmail.com>
Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 scripts/bpf_doc.py | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index dfb260de17a8..061ad1dc3212 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -10,6 +10,8 @@ from __future__ import print_function
 import argparse
 import re
 import sys, os
+import subprocess
+
 
 class NoHelperFound(BaseException):
     pass
@@ -357,6 +359,20 @@ class PrinterRST(Printer):
 
         print('')
 
+    def get_kernel_version(self):
+        try:
+            version = subprocess.run(['git', 'describe'], cwd=linuxRoot,
+                                     capture_output=True, check=True)
+            version = version.stdout.decode().rstrip()
+        except:
+            try:
+                version = subprocess.run(['make', 'kernelversion'], cwd=linuxRoot,
+                                         capture_output=True, check=True)
+                version = version.stdout.decode().rstrip()
+            except:
+                return 'Linux'
+        return 'Linux {version}'.format(version=version)
+
 class PrinterHelpersRST(PrinterRST):
     """
     A printer for dumping collected information about helpers as a ReStructured
@@ -378,6 +394,7 @@ list of eBPF helper functions
 -------------------------------------------------------------------------------
 
 :Manual section: 7
+:Version: {version}
 
 DESCRIPTION
 ===========
@@ -410,8 +427,10 @@ kernel at the top).
 HELPERS
 =======
 '''
+        kernelVersion = self.get_kernel_version()
+
         PrinterRST.print_license(self)
-        print(header)
+        print(header.format(version=kernelVersion))
 
     def print_footer(self):
         footer = '''
-- 
2.25.1

