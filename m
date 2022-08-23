Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC7059EA4C
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 19:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbiHWRxh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 13:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbiHWRwt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 13:52:49 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9D194ED0
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 08:54:26 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id b5so13254883wrr.5
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 08:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=vh52awskeItZOpUKkVy87rMrn/g3p6/h+Ynuvw85Drc=;
        b=FGlNFaSP6Q44C1G8G+/fYstGzueHBI4uWSGcULREFvyrlxCN3byNC8D9/V67qonRox
         tTrZyOvWWE9umOS5VloGOlccd0IxuCSfDnEp3f5Z9z8Ge5Edt49mVUUv2+AJSU9mDK9i
         AVA7DHlT7KyFlqJho8hWq4ikvSxoNv6nCPVsAsrAx8gj7oOt70sF2OfdatBsWrU5o9YY
         PCklo68zglCfb4BVB1tyA9BN2ZvjeDPMaOWZw3NYC0TychXgS+8Ia0pFlkptMq88DpH2
         WSKYoNM+0TEWXhdG5BhliZ1QwJu7aLlO6abHUSIZ2gZk7lYzrZw3HhGL3dzI9TMoOjo1
         9dTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=vh52awskeItZOpUKkVy87rMrn/g3p6/h+Ynuvw85Drc=;
        b=sARKzChVq8+ZM16tIN8tYt9fos8s34sYhnQk4quXKZ8qMqh6LHEU1DST4FIIM44gt6
         TUmNeHz33SzAzSO2YtYJNULaIJcpeIV5RQG3mKJEzafV8a8nWQK+mA/PLmJ1qdspkQQe
         Zdx0hn1IFr4oyVcUVLERqPWcSR+E40G6DYBin4e/A9H/V9haqg1uV5p5lCA2Cg0a3r3N
         oMq9XXpIoMezoy1vrf6fKvMkCvx6v8KY0OvCtfr/4xOpI4ijSUXHYxAoK9Mc2Jl3DTrh
         hguDNpVPEI3aYJRILloRSq8jUY2ikFut35wSY1kJE4m4JnbVPhYWmi3IurQgpkZJkiUm
         AAlw==
X-Gm-Message-State: ACgBeo0HAQKRPCDOxzM9FDvVA7vvUx9rvTYHkfCDnwnePdv2RJtwoYfx
        sVqWFo9dSvTRFVMgjdc6qhdG5g==
X-Google-Smtp-Source: AA6agR4pqHVMP/UeG3qcaTFOE8u2w53BMA1ShU/x1NIWe9PEhl2SZQrMsViIgPZ9eKU0vnN2LkIjUg==
X-Received: by 2002:a05:6000:1882:b0:221:b062:e578 with SMTP id a2-20020a056000188200b00221b062e578mr13402255wri.500.1661270065181;
        Tue, 23 Aug 2022 08:54:25 -0700 (PDT)
Received: from harfang.fritz.box ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id m9-20020a7bce09000000b003a3442f1229sm21064089wmc.29.2022.08.23.08.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 08:54:24 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 2/2] scripts/bpf: Set date attribute for bpf-helpers(7) man page
Date:   Tue, 23 Aug 2022 16:53:27 +0100
Message-Id: <20220823155327.98888-2-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220823155327.98888-1-quentin@isovalent.com>
References: <20220823155327.98888-1-quentin@isovalent.com>
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

The man page should contain the date of last modification of the
documentation. This commit adds the relevant date when generating the
page.

Before:

    $ ./scripts/bpf_doc.py helpers | rst2man | grep '\.TH'
    .TH BPF-HELPERS 7 "" "Linux v5.19-14022-g30d2a4d74e11" ""

After:

    $ ./scripts/bpf_doc.py helpers | rst2man | grep '\.TH'
    .TH BPF-HELPERS 7 "2022-08-15" "Linux v5.19-14022-g30d2a4d74e11" ""

We get the version by using "git log" to look for the commit date of the
latest change to the section of the BPF header containing the
documentation. If the command fails, we just skip the date field. and
keep generating the page.

Cc: Alejandro Colomar <alx.manpages@gmail.com>
Reported-by: Alejandro Colomar <alx.manpages@gmail.com>
Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 scripts/bpf_doc.py | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index 061ad1dc3212..f4f3e7ec6d44 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -12,6 +12,7 @@ import re
 import sys, os
 import subprocess
 
+helpersDocStart = 'Start of BPF helper function descriptions:'
 
 class NoHelperFound(BaseException):
     pass
@@ -235,7 +236,7 @@ class HeaderParser(object):
         self.enum_syscalls = re.findall('(BPF\w+)+', bpf_cmd_str)
 
     def parse_desc_helpers(self):
-        self.seek_to('* Start of BPF helper function descriptions:',
+        self.seek_to(helpersDocStart,
                      'Could not find start of eBPF helper descriptions list')
         while True:
             try:
@@ -373,6 +374,17 @@ class PrinterRST(Printer):
                 return 'Linux'
         return 'Linux {version}'.format(version=version)
 
+    def get_last_doc_update(self, delimiter):
+        try:
+            cmd = ['git', 'log', '-1', '--pretty=format:%cs', '--no-patch',
+                   '-L',
+                   '/{}/,/\*\//:include/uapi/linux/bpf.h'.format(delimiter)]
+            date = subprocess.run(cmd, cwd=linuxRoot,
+                                  capture_output=True, check=True)
+            return date.stdout.decode().rstrip()
+        except:
+            return ''
+
 class PrinterHelpersRST(PrinterRST):
     """
     A printer for dumping collected information about helpers as a ReStructured
@@ -395,6 +407,7 @@ list of eBPF helper functions
 
 :Manual section: 7
 :Version: {version}
+{date_field}{date}
 
 DESCRIPTION
 ===========
@@ -428,9 +441,12 @@ HELPERS
 =======
 '''
         kernelVersion = self.get_kernel_version()
+        lastUpdate = self.get_last_doc_update(helpersDocStart)
 
         PrinterRST.print_license(self)
-        print(header.format(version=kernelVersion))
+        print(header.format(version=kernelVersion,
+                            date_field = ':Date: ' if lastUpdate else '',
+                            date=lastUpdate))
 
     def print_footer(self):
         footer = '''
-- 
2.25.1

