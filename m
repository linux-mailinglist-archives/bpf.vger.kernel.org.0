Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCBD94939D2
	for <lists+bpf@lfdr.de>; Wed, 19 Jan 2022 12:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240819AbiASLo5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 06:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236274AbiASLo4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Jan 2022 06:44:56 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C983C061574
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 03:44:56 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id e9-20020a05600c4e4900b0034d23cae3f0so5391566wmq.2
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 03:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MDiP9vW7ev7b05ZmQyJMozlZPyBHdvO8mtN/VgkQsVQ=;
        b=XAx3bCWipn3EzfPcl8F3peaXG/ohh0ctJYvGC4K5qYK5u3bXX/7jTx0PwFhiuLMPj3
         JdB/zF6TIAFOHoCDtkRHbI4sPEcbQ32p7tx6f32e6butAyhg9fabMoCNRPv8K+0+nPov
         CjsGOwkw/fjH60oGqyshTPB92XPS3cg1FGly2VdJf6vRw+Uv/lR6dqw32LcqiLMwmZHp
         Lp7a7mJLuwmtRC/36ZdbznHSPshmcK06TRonjS/4VJ5LaOCa84wW5pDv64NsfP+Cr8m7
         CODkM79Y7T4utY/HIB2MoTq5m1dWGoyq4nJqen5nA7PMvVonB4PELQL4GkMdSfpAbQoO
         /TsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MDiP9vW7ev7b05ZmQyJMozlZPyBHdvO8mtN/VgkQsVQ=;
        b=2K+n9eRZ+xukm4ksycWzMjEL8fNgPIjcMMxni+jec8uOGgAAMY5XdeVQRaEKm+Owzd
         Wo6wQAEiuO68t2kNkrEgCBPOYz90f7n5viAT6HWDNjVperLAyoTSLjd2sIO306SYu+Cn
         u66ySnvsbNkOBwHV9zc2pgUkTUfneyr4tTu1+v+ExxIgO6fUhQgBZ/HrvVLlPBL07/IB
         CeZJ72ZRqKX4ywsZO3R9FAOj9Nql/PzsGO1ggMZpTeR0VUOe+aAxHnlNMQBR/vPen3+9
         526dbCgWmTTK9IZ7/YaWVlH9TXnVca9zmjRB2zLB14qcJUbTa6GwTMqe9qEG/k04Y2zp
         e5Rw==
X-Gm-Message-State: AOAM533nNZmV3k4rnj3ikR9+BacjYJJtMSnQquY63ff4VoUe2mzHH1zE
        TMLIo7e4oJT92Z94woUuC3kVlGeJg5DbtA==
X-Google-Smtp-Source: ABdhPJxozl2NUp7GdAoNZjta1rx8skpUoHnGxD+++fWCgRAeQu7vbT5J0452A+x+Mtc/aDQ7e1WY1w==
X-Received: by 2002:a5d:6d41:: with SMTP id k1mr29266537wri.478.1642592694650;
        Wed, 19 Jan 2022 03:44:54 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6d:f804:0:d40a:ebf3:7c3b:c5af])
        by smtp.gmail.com with ESMTPSA id f8sm12250295wry.23.2022.01.19.03.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 03:44:54 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, fam.zheng@bytedance.com,
        cong.wang@bytedance.com, song@kernel.org, quentin@isovalent.com,
        andrii.nakryiko@gmail.com, Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH bpf-next v3 2/3] bpf/scripts: Make description and returns section for helpers/syscalls mandatory
Date:   Wed, 19 Jan 2022 11:44:41 +0000
Message-Id: <20220119114442.1452088-2-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220119114442.1452088-1-usama.arif@bytedance.com>
References: <20220119114442.1452088-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This  enforce a minimal formatting consistency for the documentation. The
description and returns missing for a few helpers have also been added.

Signed-off-by: Usama Arif <usama.arif@bytedance.com>
Reviewed-by: Quentin Monnet <quentin@isovalent.com>

---
v1->v3:
- Moved UAPI header changes to a seperate commit (suggested by
Andrii Nakryiko)
---
 scripts/bpf_doc.py | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index 5cf8ae2e72bd..20441e5d2d33 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -92,14 +92,14 @@ class HeaderParser(object):
 
     def parse_element(self):
         proto    = self.parse_symbol()
-        desc     = self.parse_desc()
-        ret      = self.parse_ret()
+        desc     = self.parse_desc(proto)
+        ret      = self.parse_ret(proto)
         return APIElement(proto=proto, desc=desc, ret=ret)
 
     def parse_helper(self):
         proto    = self.parse_proto()
-        desc     = self.parse_desc()
-        ret      = self.parse_ret()
+        desc     = self.parse_desc(proto)
+        ret      = self.parse_ret(proto)
         return Helper(proto=proto, desc=desc, ret=ret)
 
     def parse_symbol(self):
@@ -129,16 +129,15 @@ class HeaderParser(object):
         self.line = self.reader.readline()
         return capture.group(1)
 
-    def parse_desc(self):
+    def parse_desc(self, proto):
         p = re.compile(' \* ?(?:\t| {5,8})Description$')
         capture = p.match(self.line)
         if not capture:
-            # Helper can have empty description and we might be parsing another
-            # attribute: return but do not consume.
-            return ''
+            raise Exception("No description section found for " + proto)
         # Description can be several lines, some of them possibly empty, and it
         # stops when another subsection title is met.
         desc = ''
+        desc_present = False
         while True:
             self.line = self.reader.readline()
             if self.line == ' *\n':
@@ -147,21 +146,24 @@ class HeaderParser(object):
                 p = re.compile(' \* ?(?:\t| {5,8})(?:\t| {8})(.*)')
                 capture = p.match(self.line)
                 if capture:
+                    desc_present = True
                     desc += capture.group(1) + '\n'
                 else:
                     break
+
+        if not desc_present:
+            raise Exception("No description found for " + proto)
         return desc
 
-    def parse_ret(self):
+    def parse_ret(self, proto):
         p = re.compile(' \* ?(?:\t| {5,8})Return$')
         capture = p.match(self.line)
         if not capture:
-            # Helper can have empty retval and we might be parsing another
-            # attribute: return but do not consume.
-            return ''
+            raise Exception("No return section found for " + proto)
         # Return value description can be several lines, some of them possibly
         # empty, and it stops when another subsection title is met.
         ret = ''
+        ret_present = False
         while True:
             self.line = self.reader.readline()
             if self.line == ' *\n':
@@ -170,9 +172,13 @@ class HeaderParser(object):
                 p = re.compile(' \* ?(?:\t| {5,8})(?:\t| {8})(.*)')
                 capture = p.match(self.line)
                 if capture:
+                    ret_present = True
                     ret += capture.group(1) + '\n'
                 else:
                     break
+
+        if not ret_present:
+            raise Exception("No return found for " + proto)
         return ret
 
     def seek_to(self, target, help_message):
-- 
2.25.1

