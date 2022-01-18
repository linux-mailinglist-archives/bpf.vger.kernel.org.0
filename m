Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D97E2492C1A
	for <lists+bpf@lfdr.de>; Tue, 18 Jan 2022 18:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346981AbiARRQb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Jan 2022 12:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbiARRQ2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Jan 2022 12:16:28 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63438C061574
        for <bpf@vger.kernel.org>; Tue, 18 Jan 2022 09:16:28 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id d18-20020a05600c251200b0034974323cfaso7472630wma.4
        for <bpf@vger.kernel.org>; Tue, 18 Jan 2022 09:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ONg13Yr1DkuyC8HObgJ4JqbBSEKPIjpwJs43n+LGl8s=;
        b=7XSKQFGuEV+3YpvDNhPJU3+rkCgRG3szEUlEWxZVkEk+qMCZ9Hcbj41MU3XURgPZHZ
         Ev5dXYMYlgfi52GDM8yYWdqwnf21Xhf51k1shdPZZb6huEU+HzaV83jmeWfQMZzyGRng
         znqbxNjRcRgRSXXFLrjU8r4/m4wOveSQiOJxD0IPtBHUDESQeDdCOs6lK4X7d0x0iK21
         DlF3MJ5QgLSTsEce8w+DvOKMWlucxsdBJwe5l9xPqjdUCRCGRn1iYT4jiytGFgmyV6Ow
         Q8yRUpOvKy+h9NPpuK9Ha9Sq61dDru0UT2/k6IF88VZfodPL0QFEKSjJM5K5kh4EsYlr
         4ouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ONg13Yr1DkuyC8HObgJ4JqbBSEKPIjpwJs43n+LGl8s=;
        b=GAGTsGVgOkZO6Nl6TwiCkd4GkXtdIgl9Ckn26AjJzFKGzdOp/nPb2ftck9NIWsSmIu
         tWQ5AFOUtMNnHxI46mzYyYjq6VDlX9cf0GoTPRKut0o/9kbOROqlpIlTOUXSwMdfm/yo
         +tDNsnFrTmOs3oYlgTrVoI8eR23vB6c2zHWRxytDB5ajJ5hSqo6eSoDzxT7sWDbWZ8yo
         YseUebLPwAM7AbtFYyHOoxmWDp1A+z5bwjqRhkXu724CnQmpUtqivwm5bYPEkipYfSAH
         nNwpoUlXvKfoCdgoUf2bWqogBc+zeJ/psZadZ/QIG3Zei2R+bhJcu/KlhbXu6QHRGtkX
         7Nqg==
X-Gm-Message-State: AOAM531JJ8TO1i+/362hpiKYbwSwmjkMViVsERBchAWZVRuWzeIGyOkw
        8qW77/szvt0mdxCQe23kMLaoHcgYC24B7w==
X-Google-Smtp-Source: ABdhPJxhngwLW+BPeA/yDoW/qPM456lsVfQ/yEjCtBwMZeMuSeMQ5aQxocE2tBxOEAPHpjA4vWc+6Q==
X-Received: by 2002:a5d:4089:: with SMTP id o9mr3339376wrp.299.1642526186771;
        Tue, 18 Jan 2022 09:16:26 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6d:f804:0:d40a:ebf3:7c3b:c5af])
        by smtp.gmail.com with ESMTPSA id g6sm18983449wri.80.2022.01.18.09.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 09:16:26 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, fam.zheng@bytedance.com,
        cong.wang@bytedance.com, song@kernel.org, quentin@isovalent.com,
        andrii.nakryiko@gmail.com, Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH bpf-next v2 1/2] bpf/scripts: Make description and returns section for helpers/syscalls mandatory
Date:   Tue, 18 Jan 2022 17:16:08 +0000
Message-Id: <20220118171609.1044550-1-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
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
 include/uapi/linux/bpf.h       | 13 +++++++++++++
 scripts/bpf_doc.py             | 30 ++++++++++++++++++------------
 tools/include/uapi/linux/bpf.h | 13 +++++++++++++
 3 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index b0383d371b9a..8cbb3737ee97 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1775,6 +1775,8 @@ union bpf_attr {
  * 		0 on success, or a negative error in case of failure.
  *
  * u64 bpf_get_current_pid_tgid(void)
+ * 	Description
+ * 		Get the current pid and tgid.
  * 	Return
  * 		A 64-bit integer containing the current tgid and pid, and
  * 		created as such:
@@ -1782,6 +1784,8 @@ union bpf_attr {
  * 		*current_task*\ **->pid**.
  *
  * u64 bpf_get_current_uid_gid(void)
+ * 	Description
+ * 		Get the current uid and gid.
  * 	Return
  * 		A 64-bit integer containing the current GID and UID, and
  * 		created as such: *current_gid* **<< 32 \|** *current_uid*.
@@ -2256,6 +2260,8 @@ union bpf_attr {
  * 		The 32-bit hash.
  *
  * u64 bpf_get_current_task(void)
+ * 	Description
+ * 		Get the current task.
  * 	Return
  * 		A pointer to the current task struct.
  *
@@ -2369,6 +2375,8 @@ union bpf_attr {
  * 		indicate that the hash is outdated and to trigger a
  * 		recalculation the next time the kernel tries to access this
  * 		hash or when the **bpf_get_hash_recalc**\ () helper is called.
+ * 	Return
+ * 		void.
  *
  * long bpf_get_numa_node_id(void)
  * 	Description
@@ -2466,6 +2474,8 @@ union bpf_attr {
  * 		A 8-byte long unique number or 0 if *sk* is NULL.
  *
  * u32 bpf_get_socket_uid(struct sk_buff *skb)
+ * 	Description
+ * 		Get the owner UID of the socked associated to *skb*.
  * 	Return
  * 		The owner UID of the socket associated to *skb*. If the socket
  * 		is **NULL**, or if it is not a full socket (i.e. if it is a
@@ -3240,6 +3250,9 @@ union bpf_attr {
  * 		The id is returned or 0 in case the id could not be retrieved.
  *
  * u64 bpf_get_current_cgroup_id(void)
+ * 	Description
+ * 		Get the current cgroup id based on the cgroup within which
+ * 		the current task is running.
  * 	Return
  * 		A 64-bit integer containing the current cgroup id based
  * 		on the cgroup within which the current task is running.
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
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index b0383d371b9a..8cbb3737ee97 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1775,6 +1775,8 @@ union bpf_attr {
  * 		0 on success, or a negative error in case of failure.
  *
  * u64 bpf_get_current_pid_tgid(void)
+ * 	Description
+ * 		Get the current pid and tgid.
  * 	Return
  * 		A 64-bit integer containing the current tgid and pid, and
  * 		created as such:
@@ -1782,6 +1784,8 @@ union bpf_attr {
  * 		*current_task*\ **->pid**.
  *
  * u64 bpf_get_current_uid_gid(void)
+ * 	Description
+ * 		Get the current uid and gid.
  * 	Return
  * 		A 64-bit integer containing the current GID and UID, and
  * 		created as such: *current_gid* **<< 32 \|** *current_uid*.
@@ -2256,6 +2260,8 @@ union bpf_attr {
  * 		The 32-bit hash.
  *
  * u64 bpf_get_current_task(void)
+ * 	Description
+ * 		Get the current task.
  * 	Return
  * 		A pointer to the current task struct.
  *
@@ -2369,6 +2375,8 @@ union bpf_attr {
  * 		indicate that the hash is outdated and to trigger a
  * 		recalculation the next time the kernel tries to access this
  * 		hash or when the **bpf_get_hash_recalc**\ () helper is called.
+ * 	Return
+ * 		void.
  *
  * long bpf_get_numa_node_id(void)
  * 	Description
@@ -2466,6 +2474,8 @@ union bpf_attr {
  * 		A 8-byte long unique number or 0 if *sk* is NULL.
  *
  * u32 bpf_get_socket_uid(struct sk_buff *skb)
+ * 	Description
+ * 		Get the owner UID of the socked associated to *skb*.
  * 	Return
  * 		The owner UID of the socket associated to *skb*. If the socket
  * 		is **NULL**, or if it is not a full socket (i.e. if it is a
@@ -3240,6 +3250,9 @@ union bpf_attr {
  * 		The id is returned or 0 in case the id could not be retrieved.
  *
  * u64 bpf_get_current_cgroup_id(void)
+ * 	Description
+ * 		Get the current cgroup id based on the cgroup within which
+ * 		the current task is running.
  * 	Return
  * 		A 64-bit integer containing the current cgroup id based
  * 		on the cgroup within which the current task is running.
-- 
2.25.1

