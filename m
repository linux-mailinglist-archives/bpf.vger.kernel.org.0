Return-Path: <bpf+bounces-16280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE097FF339
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 16:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99FA82819F4
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 15:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7B951C59;
	Thu, 30 Nov 2023 15:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
X-Greylist: delayed 581 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Nov 2023 07:09:15 PST
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8F4194
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 07:09:15 -0800 (PST)
Received: from localhost.localdomain (unknown [120.208.100.109])
	by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 5DF278000BB;
	Thu, 30 Nov 2023 22:57:59 +0800 (CST)
From: Hu Haowen <2023002089@link.tyut.edu.cn>
To: song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	martin.lau@linux.dev
Cc: Hu Haowen <2023002089@link.tyut.edu.cn>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/bpf_doc: add __main__ judgement before main code
Date: Thu, 30 Nov 2023 22:57:46 +0800
Message-Id: <20231130145746.23621-1-2023002089@link.tyut.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZT0wYVk8fGElKTh1PQhgdTlUTARMWGhIXJBQOD1
	lXWRgSC1lBWUpJS1VJS0NVSktLVUpLQllXWRYaDxIVHRRZQVlLVUtVS1VLWQY+
X-HM-Tid: 0a8c20bc9835b03akuuu5df278000bb
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NRw6Sjo6SDw*KBdIMxM9Lg8#
	HDhPCxxVSlVKTEtKSE5NSUNLTEpNVTMWGhIXVUlLSUhLS0lLQ0I7FxIVEFUPAg4PVR4fDlUYFUVZ
	V1kSC1lBWUpJS1VJS0NVSktLVUpLQllXWQgBWUFOT05MNwY+

When doing Python programming it is a nice convention to insert the if
statement `if __name__ == "__main__":` before any main code that does
actual functionalities to ensure the code will be executed only as a
script rather than as an imported module.  Hence attach the missing
judgement to bpf_doc.py.

Signed-off-by: Hu Haowen <2023002089@link.tyut.edu.cn>
---
 scripts/bpf_doc.py | 81 +++++++++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 40 deletions(-)

diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index 61b7dddedc46..af2a87d97832 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -851,43 +851,44 @@ class PrinterHelpers(Printer):
 
 ###############################################################################
 
-# If script is launched from scripts/ from kernel tree and can access
-# ../include/uapi/linux/bpf.h, use it as a default name for the file to parse,
-# otherwise the --filename argument will be required from the command line.
-script = os.path.abspath(sys.argv[0])
-linuxRoot = os.path.dirname(os.path.dirname(script))
-bpfh = os.path.join(linuxRoot, 'include/uapi/linux/bpf.h')
-
-printers = {
-        'helpers': PrinterHelpersRST,
-        'syscall': PrinterSyscallRST,
-}
-
-argParser = argparse.ArgumentParser(description="""
-Parse eBPF header file and generate documentation for the eBPF API.
-The RST-formatted output produced can be turned into a manual page with the
-rst2man utility.
-""")
-argParser.add_argument('--header', action='store_true',
-                       help='generate C header file')
-if (os.path.isfile(bpfh)):
-    argParser.add_argument('--filename', help='path to include/uapi/linux/bpf.h',
-                           default=bpfh)
-else:
-    argParser.add_argument('--filename', help='path to include/uapi/linux/bpf.h')
-argParser.add_argument('target', nargs='?', default='helpers',
-                       choices=printers.keys(), help='eBPF API target')
-args = argParser.parse_args()
-
-# Parse file.
-headerParser = HeaderParser(args.filename)
-headerParser.run()
-
-# Print formatted output to standard output.
-if args.header:
-    if args.target != 'helpers':
-        raise NotImplementedError('Only helpers header generation is supported')
-    printer = PrinterHelpers(headerParser)
-else:
-    printer = printers[args.target](headerParser)
-printer.print_all()
+if __name__ == "__main__":
+    # If script is launched from scripts/ from kernel tree and can access
+    # ../include/uapi/linux/bpf.h, use it as a default name for the file to parse,
+    # otherwise the --filename argument will be required from the command line.
+    script = os.path.abspath(sys.argv[0])
+    linuxRoot = os.path.dirname(os.path.dirname(script))
+    bpfh = os.path.join(linuxRoot, 'include/uapi/linux/bpf.h')
+
+    printers = {
+            'helpers': PrinterHelpersRST,
+            'syscall': PrinterSyscallRST,
+    }
+
+    argParser = argparse.ArgumentParser(description="""
+    Parse eBPF header file and generate documentation for the eBPF API.
+    The RST-formatted output produced can be turned into a manual page with the
+    rst2man utility.
+    """)
+    argParser.add_argument('--header', action='store_true',
+                           help='generate C header file')
+    if (os.path.isfile(bpfh)):
+        argParser.add_argument('--filename', help='path to include/uapi/linux/bpf.h',
+                               default=bpfh)
+    else:
+        argParser.add_argument('--filename', help='path to include/uapi/linux/bpf.h')
+    argParser.add_argument('target', nargs='?', default='helpers',
+                           choices=printers.keys(), help='eBPF API target')
+    args = argParser.parse_args()
+
+    # Parse file.
+    headerParser = HeaderParser(args.filename)
+    headerParser.run()
+
+    # Print formatted output to standard output.
+    if args.header:
+        if args.target != 'helpers':
+            raise NotImplementedError('Only helpers header generation is supported')
+        printer = PrinterHelpers(headerParser)
+    else:
+        printer = printers[args.target](headerParser)
+    printer.print_all()
-- 
2.34.1


