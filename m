Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B166332B34D
	for <lists+bpf@lfdr.de>; Wed,  3 Mar 2021 04:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352523AbhCCDuo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Mar 2021 22:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344082AbhCBRlc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Mar 2021 12:41:32 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B67C0698C7
        for <bpf@vger.kernel.org>; Tue,  2 Mar 2021 09:20:44 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id e9so2474351pjj.0
        for <bpf@vger.kernel.org>; Tue, 02 Mar 2021 09:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cilium-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fRChbTS8wm3//f2BALQqTT/xFw+Hx0cBe+aJeD7Uh84=;
        b=qXgIqqi4ObJ6UdZYB5w747BTk9f9amHZx1zbj15a59wo3j1hcw5u6sHcTuAHT7onMU
         BVZhfAmy/WK0q4aWiIfTI0e2WJP0ljZ8OXEi94p851QdY9+kjbHFzIkPJzYc3N6H9HpC
         QA6az0JLL/E1Uz4uXm4IWqA+fpAXqH7/bqtqVXbqsu7s+03/evhsa8YrntRGCoEFaVrf
         pk+0N1LYEdjDe1Wsc61K+L9khdbNArLuIPw9DFHfl6jaC+FiU1kIOEWmHWBCIc3f0w6W
         cvgObljR+dTW9RFKKxXL8P0NZfTYviXe/ONvH8RXfRzCgVvQ+HaKR6S60RFkF1Pgct+o
         kKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fRChbTS8wm3//f2BALQqTT/xFw+Hx0cBe+aJeD7Uh84=;
        b=s9HZZKlMWR5VCYGgmXKlgkMVka7/blBPtWYe9gMKDbKVW9jj5j9LhmBBp5jeGAM+UE
         P7AbU/zx5ynkR0qWCHddv5T2onMdMOFRWAKTwV3G88c4RktzuEiT+ZYiOyv7ND1M5G6l
         Uozl2DsZLseLKxy8zgpjUtqgAjtwhDiXfJoQRtcv6B+9MR72kmKK4XgOcRjF5wdDo+cL
         xPeJS/KZmFezHtfWO1LrGLGZWOpWydj66mltlHlTWLESL9yePnWH1WLz53A1sLXhTNRG
         jLMJqlfrBUYXEtn8fj6/pM+i877atm/32Jn+JXRpdXGeuckjpZj6wV33xXxNpUKNvXeI
         8EsA==
X-Gm-Message-State: AOAM533RCliiJ7ogLVnv9iT6fOmB2K1cMkJphpizv/ZYRwMgt/KXUU98
        ugqlpkJrua+OLAO6Dn3yDfD4TilivwCwxCUa
X-Google-Smtp-Source: ABdhPJy+RrBwQTGcQzFWXHdEQ7YNuC9XacWs/v2BYwcrWyiLn3qvoyC6OROFYlLSPxV0G/BLWTnZNA==
X-Received: by 2002:a17:90a:39c9:: with SMTP id k9mr5395908pjf.121.1614705643910;
        Tue, 02 Mar 2021 09:20:43 -0800 (PST)
Received: from localhost.localdomain (c-73-93-5-123.hsd1.ca.comcast.net. [73.93.5.123])
        by smtp.gmail.com with ESMTPSA id b15sm20073923pgg.85.2021.03.02.09.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 09:20:43 -0800 (PST)
From:   Joe Stringer <joe@cilium.io>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, ast@kernel.org, linux-doc@vger.kernel.org,
        linux-man@vger.kernel.org,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCHv2 bpf-next 09/15] scripts/bpf: Abstract eBPF API target parameter
Date:   Tue,  2 Mar 2021 09:19:41 -0800
Message-Id: <20210302171947.2268128-10-joe@cilium.io>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210302171947.2268128-1-joe@cilium.io>
References: <20210302171947.2268128-1-joe@cilium.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Abstract out the target parameter so that upcoming commits, more than
just the existing "helpers" target can be called to generate specific
portions of docs from the eBPF UAPI headers.

Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reviewed-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Joe Stringer <joe@cilium.io>
---
 MAINTAINERS                                |  1 +
 include/uapi/linux/bpf.h                   |  2 +-
 scripts/{bpf_helpers_doc.py => bpf_doc.py} | 91 +++++++++++++++-------
 tools/bpf/Makefile.helpers                 |  2 +-
 tools/include/uapi/linux/bpf.h             |  2 +-
 tools/lib/bpf/Makefile                     |  2 +-
 tools/perf/MANIFEST                        |  2 +-
 7 files changed, 69 insertions(+), 33 deletions(-)
 rename scripts/{bpf_helpers_doc.py => bpf_doc.py} (92%)

diff --git a/MAINTAINERS b/MAINTAINERS
index a50a543e3c81..8d56c7044067 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3223,6 +3223,7 @@ F:	net/core/filter.c
 F:	net/sched/act_bpf.c
 F:	net/sched/cls_bpf.c
 F:	samples/bpf/
+F:	scripts/bpf_doc.py
 F:	tools/bpf/
 F:	tools/lib/bpf/
 F:	tools/testing/selftests/bpf/
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c8b9d19fce22..63a56ed6a785 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1439,7 +1439,7 @@ union bpf_attr {
  * parsed and used to produce a manual page. The workflow is the following,
  * and requires the rst2man utility:
  *
- *     $ ./scripts/bpf_helpers_doc.py \
+ *     $ ./scripts/bpf_doc.py \
  *             --filename include/uapi/linux/bpf.h > /tmp/bpf-helpers.rst
  *     $ rst2man /tmp/bpf-helpers.rst > /tmp/bpf-helpers.7
  *     $ man /tmp/bpf-helpers.7
diff --git a/scripts/bpf_helpers_doc.py b/scripts/bpf_doc.py
similarity index 92%
rename from scripts/bpf_helpers_doc.py
rename to scripts/bpf_doc.py
index 867ada23281c..5a4f68aab335 100755
--- a/scripts/bpf_helpers_doc.py
+++ b/scripts/bpf_doc.py
@@ -2,6 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 # Copyright (C) 2018-2019 Netronome Systems, Inc.
+# Copyright (C) 2021 Isovalent, Inc.
 
 # In case user attempts to run with Python 2.
 from __future__ import print_function
@@ -165,10 +166,11 @@ class Printer(object):
     """
     A generic class for printers. Printers should be created with an array of
     Helper objects, and implement a way to print them in the desired fashion.
-    @helpers: array of Helper objects to print to standard output
+    @parser: A HeaderParser with objects to print to standard output
     """
-    def __init__(self, helpers):
-        self.helpers = helpers
+    def __init__(self, parser):
+        self.parser = parser
+        self.elements = []
 
     def print_header(self):
         pass
@@ -181,19 +183,23 @@ class Printer(object):
 
     def print_all(self):
         self.print_header()
-        for helper in self.helpers:
-            self.print_one(helper)
+        for elem in self.elements:
+            self.print_one(elem)
         self.print_footer()
 
+
 class PrinterRST(Printer):
     """
-    A printer for dumping collected information about helpers as a ReStructured
-    Text page compatible with the rst2man program, which can be used to
-    generate a manual page for the helpers.
-    @helpers: array of Helper objects to print to standard output
+    A generic class for printers that print ReStructured Text. Printers should
+    be created with a HeaderParser object, and implement a way to print API
+    elements in the desired fashion.
+    @parser: A HeaderParser with objects to print to standard output
     """
-    def print_header(self):
-        header = '''\
+    def __init__(self, parser):
+        self.parser = parser
+
+    def print_license(self):
+        license = '''\
 .. Copyright (C) All BPF authors and contributors from 2014 to present.
 .. See git log include/uapi/linux/bpf.h in kernel tree for details.
 .. 
@@ -221,9 +227,39 @@ class PrinterRST(Printer):
 .. 
 .. Please do not edit this file. It was generated from the documentation
 .. located in file include/uapi/linux/bpf.h of the Linux kernel sources
-.. (helpers description), and from scripts/bpf_helpers_doc.py in the same
+.. (helpers description), and from scripts/bpf_doc.py in the same
 .. repository (header and footer).
+'''
+        print(license)
+
+    def print_elem(self, elem):
+        if (elem.desc):
+            print('\tDescription')
+            # Do not strip all newline characters: formatted code at the end of
+            # a section must be followed by a blank line.
+            for line in re.sub('\n$', '', elem.desc, count=1).split('\n'):
+                print('{}{}'.format('\t\t' if line else '', line))
+
+        if (elem.ret):
+            print('\tReturn')
+            for line in elem.ret.rstrip().split('\n'):
+                print('{}{}'.format('\t\t' if line else '', line))
+
+        print('')
 
+
+class PrinterHelpersRST(PrinterRST):
+    """
+    A printer for dumping collected information about helpers as a ReStructured
+    Text page compatible with the rst2man program, which can be used to
+    generate a manual page for the helpers.
+    @parser: A HeaderParser with Helper objects to print to standard output
+    """
+    def __init__(self, parser):
+        self.elements = parser.helpers
+
+    def print_header(self):
+        header = '''\
 ===========
 BPF-HELPERS
 ===========
@@ -264,6 +300,7 @@ kernel at the top).
 HELPERS
 =======
 '''
+        PrinterRST.print_license(self)
         print(header)
 
     def print_footer(self):
@@ -380,27 +417,19 @@ SEE ALSO
 
     def print_one(self, helper):
         self.print_proto(helper)
+        self.print_elem(helper)
 
-        if (helper.desc):
-            print('\tDescription')
-            # Do not strip all newline characters: formatted code at the end of
-            # a section must be followed by a blank line.
-            for line in re.sub('\n$', '', helper.desc, count=1).split('\n'):
-                print('{}{}'.format('\t\t' if line else '', line))
 
-        if (helper.ret):
-            print('\tReturn')
-            for line in helper.ret.rstrip().split('\n'):
-                print('{}{}'.format('\t\t' if line else '', line))
 
-        print('')
 
 class PrinterHelpers(Printer):
     """
     A printer for dumping collected information about helpers as C header to
     be included from BPF program.
-    @helpers: array of Helper objects to print to standard output
+    @parser: A HeaderParser with Helper objects to print to standard output
     """
+    def __init__(self, parser):
+        self.elements = parser.helpers
 
     type_fwds = [
             'struct bpf_fib_lookup',
@@ -511,7 +540,7 @@ class PrinterHelpers(Printer):
 
     def print_header(self):
         header = '''\
-/* This is auto-generated file. See bpf_helpers_doc.py for details. */
+/* This is auto-generated file. See bpf_doc.py for details. */
 
 /* Forward declarations of BPF structs */'''
 
@@ -589,8 +618,12 @@ script = os.path.abspath(sys.argv[0])
 linuxRoot = os.path.dirname(os.path.dirname(script))
 bpfh = os.path.join(linuxRoot, 'include/uapi/linux/bpf.h')
 
+printers = {
+        'helpers': PrinterHelpersRST,
+}
+
 argParser = argparse.ArgumentParser(description="""
-Parse eBPF header file and generate documentation for eBPF helper functions.
+Parse eBPF header file and generate documentation for the eBPF API.
 The RST-formatted output produced can be turned into a manual page with the
 rst2man utility.
 """)
@@ -601,6 +634,8 @@ if (os.path.isfile(bpfh)):
                            default=bpfh)
 else:
     argParser.add_argument('--filename', help='path to include/uapi/linux/bpf.h')
+argParser.add_argument('target', nargs='?', default='helpers',
+                       choices=printers.keys(), help='eBPF API target')
 args = argParser.parse_args()
 
 # Parse file.
@@ -609,7 +644,7 @@ headerParser.run()
 
 # Print formatted output to standard output.
 if args.header:
-    printer = PrinterHelpers(headerParser.helpers)
+    printer = PrinterHelpers(headerParser)
 else:
-    printer = PrinterRST(headerParser.helpers)
+    printer = printers[args.target](headerParser)
 printer.print_all()
diff --git a/tools/bpf/Makefile.helpers b/tools/bpf/Makefile.helpers
index 854d084026dd..a26599022fd6 100644
--- a/tools/bpf/Makefile.helpers
+++ b/tools/bpf/Makefile.helpers
@@ -35,7 +35,7 @@ man7: $(DOC_MAN7)
 RST2MAN_DEP := $(shell command -v rst2man 2>/dev/null)
 
 $(OUTPUT)$(HELPERS_RST): $(UP2DIR)../../include/uapi/linux/bpf.h
-	$(QUIET_GEN)$(UP2DIR)../../scripts/bpf_helpers_doc.py --filename $< > $@
+	$(QUIET_GEN)$(UP2DIR)../../scripts/bpf_doc.py --filename $< > $@
 
 $(OUTPUT)%.7: $(OUTPUT)%.rst
 ifndef RST2MAN_DEP
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index b89af20cfa19..b4c5c529ad17 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -729,7 +729,7 @@ union bpf_attr {
  * parsed and used to produce a manual page. The workflow is the following,
  * and requires the rst2man utility:
  *
- *     $ ./scripts/bpf_helpers_doc.py \
+ *     $ ./scripts/bpf_doc.py \
  *             --filename include/uapi/linux/bpf.h > /tmp/bpf-helpers.rst
  *     $ rst2man /tmp/bpf-helpers.rst > /tmp/bpf-helpers.7
  *     $ man /tmp/bpf-helpers.7
diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 887a494ad5fc..8170f88e8ea6 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -158,7 +158,7 @@ $(BPF_IN_STATIC): force $(BPF_HELPER_DEFS)
 	$(Q)$(MAKE) $(build)=libbpf OUTPUT=$(STATIC_OBJDIR)
 
 $(BPF_HELPER_DEFS): $(srctree)/tools/include/uapi/linux/bpf.h
-	$(QUIET_GEN)$(srctree)/scripts/bpf_helpers_doc.py --header \
+	$(QUIET_GEN)$(srctree)/scripts/bpf_doc.py --header \
 		--file $(srctree)/tools/include/uapi/linux/bpf.h > $(BPF_HELPER_DEFS)
 
 $(OUTPUT)libbpf.so: $(OUTPUT)libbpf.so.$(LIBBPF_VERSION)
diff --git a/tools/perf/MANIFEST b/tools/perf/MANIFEST
index 5d7b947320fb..f05c4d48fd7e 100644
--- a/tools/perf/MANIFEST
+++ b/tools/perf/MANIFEST
@@ -20,4 +20,4 @@ tools/lib/bitmap.c
 tools/lib/str_error_r.c
 tools/lib/vsprintf.c
 tools/lib/zalloc.c
-scripts/bpf_helpers_doc.py
+scripts/bpf_doc.py
-- 
2.27.0

