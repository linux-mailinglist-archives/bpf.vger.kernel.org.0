Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7721F32B349
	for <lists+bpf@lfdr.de>; Wed,  3 Mar 2021 04:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352519AbhCCDul (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Mar 2021 22:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344097AbhCBRlc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Mar 2021 12:41:32 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D1AC0698CA
        for <bpf@vger.kernel.org>; Tue,  2 Mar 2021 09:20:46 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id m6so14265343pfk.1
        for <bpf@vger.kernel.org>; Tue, 02 Mar 2021 09:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cilium-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y+YcpUVr7LDyGFtvHmMjDnyPsDr68hKJkv6AGVIRT3Y=;
        b=Rp5v5A14/uC75JpS8WLyl2oXZSjMYyIQFkEiPl4ZINMcxDxI348/xLTD6m0jtWk9Ec
         aleRvpbPKXhFyYT46yDQ4MPmlN49N3q96FOHck48avTz8LMfy/eqQg+UBMQquFr57H5p
         HwVlvfbD1+hdrjHyQ/WRM2790r9Jt9H25V5j3aGi55ZhyMU1tAU9iT10Bw5TzzBl8kr9
         ZWkKme6tjLL6BqsfL2m0a9Z0qYhnaHArgqhsj5n1SRGiyJgnA3Pe/quB+KFLrPlcq7ng
         KsA4vcxLGPd/DS8PD727FS+xr8DkzQ0/LO4fpEj2GDqqbvo9LzKVPCxHJGYKNge+H5+i
         rH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y+YcpUVr7LDyGFtvHmMjDnyPsDr68hKJkv6AGVIRT3Y=;
        b=EL1bJnjwl3x/WEwbiFSTGvNjOYuAY50vs1swwERDqWhoYCjpbTiOT9SBWsy8l0Cgdm
         jt+x6ivr2UkuAbjKpiaImpTNTDYp3SbYB0iAK9CIWQvpqfRFcpGnR0I5bvNJWyWs++WF
         e86gMdXA3Ji8CbJmXFq8GzhlsH13IYL6MLXkyGcbumKTiDSQgeAKmPaLzR1W4jFlVTtb
         1C1vkJ3MdVztKHirys3q5EHlaUVUVfL9m7xa9vNt9lbtWkEh80qMp7v5pY7X4qIYq7MA
         OAS83e0UV0F6ZvSZyxS6t+I14R93boOxO2ujUnx5RDEXFo09ldB8OwoP3loAsD6qbHos
         vSEQ==
X-Gm-Message-State: AOAM532oQIHSJqt3NBmhbuIwnk2OK2V/WYq25T1Wsp1dOzwPGy4oDjH9
        nA+nMDUH5WeJBbzuMuMd07VSZnxLMacUDYKQ
X-Google-Smtp-Source: ABdhPJzRmXxKE3NeYoNTv2Wb6UuOiXhbHE0sPmPP7v+b1QA2sVKS8vNLK86MDTp8LsIIIAsqUyq8fQ==
X-Received: by 2002:a05:6a00:148a:b029:1ae:6d20:fbb3 with SMTP id v10-20020a056a00148ab02901ae6d20fbb3mr4055694pfu.55.1614705645090;
        Tue, 02 Mar 2021 09:20:45 -0800 (PST)
Received: from localhost.localdomain (c-73-93-5-123.hsd1.ca.comcast.net. [73.93.5.123])
        by smtp.gmail.com with ESMTPSA id b15sm20073923pgg.85.2021.03.02.09.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 09:20:44 -0800 (PST)
From:   Joe Stringer <joe@cilium.io>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, ast@kernel.org, linux-doc@vger.kernel.org,
        linux-man@vger.kernel.org,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCHv2 bpf-next 10/15] scripts/bpf: Add syscall commands printer
Date:   Tue,  2 Mar 2021 09:19:42 -0800
Message-Id: <20210302171947.2268128-11-joe@cilium.io>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210302171947.2268128-1-joe@cilium.io>
References: <20210302171947.2268128-1-joe@cilium.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a new target to bpf_doc.py to support generating the list of syscall
commands directly from the UAPI headers. Assuming that developer
submissions keep the main header up to date, this should allow the man
pages to be automatically generated based on the latest API changes
rather than requiring someone to separately go back through the API and
describe each command.

Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reviewed-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Joe Stringer <joe@cilium.io>
---
 scripts/bpf_doc.py | 100 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 91 insertions(+), 9 deletions(-)

diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index 5a4f68aab335..2d94025b38e9 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -14,6 +14,9 @@ import sys, os
 class NoHelperFound(BaseException):
     pass
 
+class NoSyscallCommandFound(BaseException):
+    pass
+
 class ParsingError(BaseException):
     def __init__(self, line='<line not provided>', reader=None):
         if reader:
@@ -23,18 +26,27 @@ class ParsingError(BaseException):
         else:
             BaseException.__init__(self, 'Error parsing line: %s' % line)
 
-class Helper(object):
+
+class APIElement(object):
     """
-    An object representing the description of an eBPF helper function.
-    @proto: function prototype of the helper function
-    @desc: textual description of the helper function
-    @ret: description of the return value of the helper function
+    An object representing the description of an aspect of the eBPF API.
+    @proto: prototype of the API symbol
+    @desc: textual description of the symbol
+    @ret: (optional) description of any associated return value
     """
     def __init__(self, proto='', desc='', ret=''):
         self.proto = proto
         self.desc = desc
         self.ret = ret
 
+
+class Helper(APIElement):
+    """
+    An object representing the description of an eBPF helper function.
+    @proto: function prototype of the helper function
+    @desc: textual description of the helper function
+    @ret: description of the return value of the helper function
+    """
     def proto_break_down(self):
         """
         Break down helper function protocol into smaller chunks: return type,
@@ -61,6 +73,7 @@ class Helper(object):
 
         return res
 
+
 class HeaderParser(object):
     """
     An object used to parse a file in order to extract the documentation of a
@@ -73,6 +86,13 @@ class HeaderParser(object):
         self.reader = open(filename, 'r')
         self.line = ''
         self.helpers = []
+        self.commands = []
+
+    def parse_element(self):
+        proto    = self.parse_symbol()
+        desc     = self.parse_desc()
+        ret      = self.parse_ret()
+        return APIElement(proto=proto, desc=desc, ret=ret)
 
     def parse_helper(self):
         proto    = self.parse_proto()
@@ -80,6 +100,18 @@ class HeaderParser(object):
         ret      = self.parse_ret()
         return Helper(proto=proto, desc=desc, ret=ret)
 
+    def parse_symbol(self):
+        p = re.compile(' \* ?(.+)$')
+        capture = p.match(self.line)
+        if not capture:
+            raise NoSyscallCommandFound
+        end_re = re.compile(' \* ?NOTES$')
+        end = end_re.match(self.line)
+        if end:
+            raise NoSyscallCommandFound
+        self.line = self.reader.readline()
+        return capture.group(1)
+
     def parse_proto(self):
         # Argument can be of shape:
         #   - "void"
@@ -141,16 +173,29 @@ class HeaderParser(object):
                     break
         return ret
 
-    def run(self):
-        # Advance to start of helper function descriptions.
-        offset = self.reader.read().find('* Start of BPF helper function descriptions:')
+    def seek_to(self, target, help_message):
+        self.reader.seek(0)
+        offset = self.reader.read().find(target)
         if offset == -1:
-            raise Exception('Could not find start of eBPF helper descriptions list')
+            raise Exception(help_message)
         self.reader.seek(offset)
         self.reader.readline()
         self.reader.readline()
         self.line = self.reader.readline()
 
+    def parse_syscall(self):
+        self.seek_to('* DOC: eBPF Syscall Commands',
+                     'Could not find start of eBPF syscall descriptions list')
+        while True:
+            try:
+                command = self.parse_element()
+                self.commands.append(command)
+            except NoSyscallCommandFound:
+                break
+
+    def parse_helpers(self):
+        self.seek_to('* Start of BPF helper function descriptions:',
+                     'Could not find start of eBPF helper descriptions list')
         while True:
             try:
                 helper = self.parse_helper()
@@ -158,6 +203,9 @@ class HeaderParser(object):
             except NoHelperFound:
                 break
 
+    def run(self):
+        self.parse_syscall()
+        self.parse_helpers()
         self.reader.close()
 
 ###############################################################################
@@ -420,6 +468,37 @@ SEE ALSO
         self.print_elem(helper)
 
 
+class PrinterSyscallRST(PrinterRST):
+    """
+    A printer for dumping collected information about the syscall API as a
+    ReStructured Text page compatible with the rst2man program, which can be
+    used to generate a manual page for the syscall.
+    @parser: A HeaderParser with APIElement objects to print to standard
+             output
+    """
+    def __init__(self, parser):
+        self.elements = parser.commands
+
+    def print_header(self):
+        header = '''\
+===
+bpf
+===
+-------------------------------------------------------------------------------
+Perform a command on an extended BPF object
+-------------------------------------------------------------------------------
+
+:Manual section: 2
+
+COMMANDS
+========
+'''
+        PrinterRST.print_license(self)
+        print(header)
+
+    def print_one(self, command):
+        print('**%s**' % (command.proto))
+        self.print_elem(command)
 
 
 class PrinterHelpers(Printer):
@@ -620,6 +699,7 @@ bpfh = os.path.join(linuxRoot, 'include/uapi/linux/bpf.h')
 
 printers = {
         'helpers': PrinterHelpersRST,
+        'syscall': PrinterSyscallRST,
 }
 
 argParser = argparse.ArgumentParser(description="""
@@ -644,6 +724,8 @@ headerParser.run()
 
 # Print formatted output to standard output.
 if args.header:
+    if args.target != 'helpers':
+        raise NotImplementedError('Only helpers header generation is supported')
     printer = PrinterHelpers(headerParser)
 else:
     printer = printers[args.target](headerParser)
-- 
2.27.0

