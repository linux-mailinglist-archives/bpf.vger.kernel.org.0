Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9172E492543
	for <lists+bpf@lfdr.de>; Tue, 18 Jan 2022 12:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241092AbiARL4h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Jan 2022 06:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237808AbiARL4g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Jan 2022 06:56:36 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80484C061574
        for <bpf@vger.kernel.org>; Tue, 18 Jan 2022 03:56:36 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 25-20020a05600c231900b003497473a9c4so5125278wmo.5
        for <bpf@vger.kernel.org>; Tue, 18 Jan 2022 03:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FRPm5krx9chIlPxpwKUGDk2O4qqdmNfbWUVJUEJxDro=;
        b=KTowU4Ij6625bGxqu84JIzhaaoe5D7Xeyp0VJufn0SHx6ENiPw6stE+1OE1qTXT+wl
         EFgVeGyKYp0/Rv8PfUCZbrHeWOAdUegFIViL44poZ/6R5ilf3fe3dKT+s441eCdCTaIk
         5n8e/Xzrb2vCRCr2RK0HzDLUFF9nqsnI9RQ8nrQaOqNBayoNRqm/J2dFW5BFcv8BZM53
         IjUyZ1Sm6NCV94LvOns2CX5M4tlrD+mGu9XQ+rzgqTiM6aXpWDw4ne2HCKx+pXxRlusE
         253jc/DO8izmrd/KS4neH3usnIFc4LQotTcAYEj9nl8YIXRopoSYiHk4VPqY39g7hOSN
         NCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FRPm5krx9chIlPxpwKUGDk2O4qqdmNfbWUVJUEJxDro=;
        b=XRlOzFAdBjChBCKiqWs0xZYmoS+WTAgFMIUHjyDHydeANFzsLZ+haszNziC/jCwDK+
         sR375XIM/Ky7P1g288NrPL4OxiV1wQSJrwbNoMq3Cr8SJn/KZPYQ5lpQ4mzEHrgdR3lT
         hl+X3vBzV7gvrUDI4cnCjHfom9Mva0JZmAkbP83YMif7HskAwV7SIhDDiy6Npi/rz2mc
         Wi+jj6HguXbBOVl2Iy5lPfuvrvd1mKDFQDL7pNC/pM7hqopyIcFeHD5sP2KB+tFdzF9U
         8HayNwxzMyO1JGmfoqeuu+wB3TUORxCgk0Ii/QfCi4f5HBcwKThzv1qBs/Y7DK+A0mrr
         mS8Q==
X-Gm-Message-State: AOAM530m9gMmpKtBHhjBKR9q4Bz9AMakRExZzi6KMC4fUPOlw+w1iiwU
        FsNqR6oZqg0RJSezIJcFnoCxRoNak/mC7Q==
X-Google-Smtp-Source: ABdhPJzF5gGKk3NxwBK9EepM/Hf0bqNByJoeL0UPLHlCmABUBdH0m5WWEo7wjo1GOaVEojQHnIfgPg==
X-Received: by 2002:a05:6000:18cb:: with SMTP id w11mr23533980wrq.144.1642506994889;
        Tue, 18 Jan 2022 03:56:34 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6d:f804:0:4699:372e:4a59:14b2])
        by smtp.gmail.com with ESMTPSA id k31sm2234042wms.15.2022.01.18.03.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 03:56:34 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, fam.zheng@bytedance.com,
        cong.wang@bytedance.com, song@kernel.org, quentin@isovalent.com,
        andrii.nakryiko@gmail.com, Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH bpf-next 1/2] bpf/scripts: Make description and returns section for helpers/syscalls mandatory
Date:   Tue, 18 Jan 2022 11:56:19 +0000
Message-Id: <20220118115620.849425-1-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This  enforce a minimal formatting consistency for the documentation. The
description and returns missing for a few helpers have also been added.

Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 include/uapi/linux/bpf.h       | 13 +++++++++++++
 scripts/bpf_doc.py             | 30 ++++++++++++++++++------------
 tools/include/uapi/linux/bpf.h | 13 +++++++++++++
 3 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index b0383d371..8cbb3737e 100644
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
index 5cf8ae2e7..20441e5d2 100755
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
index b0383d371..8cbb3737e 100644
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

