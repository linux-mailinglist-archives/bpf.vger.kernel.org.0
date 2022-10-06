Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9635F6013
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 06:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJFEZM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 6 Oct 2022 00:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiJFEZL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Oct 2022 00:25:11 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30703C144
        for <bpf@vger.kernel.org>; Wed,  5 Oct 2022 21:25:09 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 2962M0Ks028604
        for <bpf@vger.kernel.org>; Wed, 5 Oct 2022 21:25:09 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3k1p5d8fxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 05 Oct 2022 21:25:08 -0700
Received: from twshared25017.14.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 5 Oct 2022 21:25:07 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 56C871FC4ED8D; Wed,  5 Oct 2022 21:24:56 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Andrea Terzolo <andrea.terzolo@polito.it>
Subject: [PATCH v2 bpf-next 2/2] scripts/bpf_doc.py: update logic to not assume sequential enum values
Date:   Wed, 5 Oct 2022 21:24:52 -0700
Message-ID: <20221006042452.2089843-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221006042452.2089843-1-andrii@kernel.org>
References: <20221006042452.2089843-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Do9R56PIaJ_23AjacOANySd6QCM5RDhf
X-Proofpoint-ORIG-GUID: Do9R56PIaJ_23AjacOANySd6QCM5RDhf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_05,2022-10-05_01,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Relax bpf_doc.py's expectation of all BPF_FUNC_xxx enumerators having
sequential values increasing by one. Instead, only make sure that
relative order of BPF helper descriptions in comments matches
enumerators definitions order.

Also additionally make sure that helper IDs are not duplicated.

And also make sure that for cases when we have multiple descriptions for
the same BPF helper (e.g., for bpf_get_socket_cookie()), all such
descriptions are grouped together.

Such checks should capture all the same (and more) issues in upstream
UAPI headers, but also handle backported kernels correctly.

Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 scripts/bpf_doc.py | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index 2fe07c9e3fe0..c0e6690be82a 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -97,6 +97,7 @@ class HeaderParser(object):
         self.desc_unique_helpers = set()
         self.define_unique_helpers = []
         self.helper_enum_vals = {}
+        self.helper_enum_pos = {}
         self.desc_syscalls = []
         self.enum_syscalls = []
 
@@ -264,42 +265,60 @@ class HeaderParser(object):
         # Searches for one FN(\w+) define or a backslash for newline
         p = re.compile('\s*FN\((\w+), (\d+), ##ctx\)|\\\\')
         fn_defines_str = ''
+        i = 0
         while True:
             capture = p.match(self.line)
             if capture:
                 fn_defines_str += self.line
-                self.helper_enum_vals[capture.expand(r'bpf_\1')] = int(capture[2])
+                helper_name = capture.expand(r'bpf_\1')
+                self.helper_enum_vals[helper_name] = int(capture[2])
+                self.helper_enum_pos[helper_name] = i
+                i += 1
             else:
                 break
             self.line = self.reader.readline()
         # Find the number of occurences of FN(\w+)
         self.define_unique_helpers = re.findall('FN\(\w+, \d+, ##ctx\)', fn_defines_str)
 
-    def assign_helper_values(self):
+    def validate_helpers(self):
+        last_helper = ''
         seen_helpers = set()
+        seen_enum_vals = set()
+        i = 0
         for helper in self.helpers:
             proto = helper.proto_break_down()
             name = proto['name']
             try:
                 enum_val = self.helper_enum_vals[name]
+                enum_pos = self.helper_enum_pos[name]
             except KeyError:
                 raise Exception("Helper %s is missing from enum bpf_func_id" % name)
 
+            if name in seen_helpers:
+                if last_helper != name:
+                    raise Exception("Helper %s has multiple descriptions which are not grouped together" % name)
+                continue
+
             # Enforce current practice of having the descriptions ordered
             # by enum value.
+            if enum_pos != i:
+                raise Exception("Helper %s (ID %d) comment order (#%d) must be aligned with its position (#%d) in enum bpf_func_id" % (name, enum_val, i + 1, enum_pos + 1))
+            if enum_val in seen_enum_vals:
+                raise Exception("Helper %s has duplicated value %d" % (name, enum_val))
+
             seen_helpers.add(name)
-            desc_val = len(seen_helpers)
-            if desc_val != enum_val:
-                raise Exception("Helper %s comment order (#%d) must be aligned with its position (#%d) in enum bpf_func_id" % (name, desc_val, enum_val))
+            last_helper = name
+            seen_enum_vals.add(enum_val)
 
             helper.enum_val = enum_val
+            i += 1
 
     def run(self):
         self.parse_desc_syscall()
         self.parse_enum_syscall()
         self.parse_desc_helpers()
         self.parse_define_helpers()
-        self.assign_helper_values()
+        self.validate_helpers()
         self.reader.close()
 
 ###############################################################################
-- 
2.30.2

