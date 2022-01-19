Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC324939D1
	for <lists+bpf@lfdr.de>; Wed, 19 Jan 2022 12:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240799AbiASLoz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 06:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236274AbiASLoy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Jan 2022 06:44:54 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F199C061574
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 03:44:54 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id p18so4848174wmg.4
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 03:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P2olozTnL0fd6vOuIap15VEddI74R/yFQRqbWrihBOI=;
        b=l8IJpoP8WPCKpt0iB5lozsf8ifl/g7oaTAmvQt4Dn8BaMavMWHhH39kqX+XVYtTn4E
         gOABhs+8ywrjY0xrXlU+OpGgvEDHNkzriYXzmhB3j6+9Q2AVTVTihd0z0+zjf61Jqbhk
         vT3pc8snQS4k4FT70GyxSdSeBo2lL03CJAqPhQ9XQDp5j6/GPaQ6/QLugx6LCoKJQpEN
         JRxe6yDTsmXKeNZ22sdOeuk5WpeuL8w0AtMTqyLFpKHmkjgvKmbgVoAzpOr+5EF55TaN
         gimGspOFE9z2nukA/kn2OHNITs+P4inKMLxM7QQmraBoUlIjYSlurjCIwFwXhjzqYJ2q
         E7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P2olozTnL0fd6vOuIap15VEddI74R/yFQRqbWrihBOI=;
        b=em+r7V1O/GW7bNM3EfZaWrgn0v2t8DV7IOQepkjBHAXyLC6Zp2EMleyA0H2JFyki9T
         41bAUfSufzPfvWYEp4cQWsveceV+Z8HKJlZIbOp8QF2HHgLv4xNCRMw42XC+snDbfMnn
         Vdqr3PEJORpEtMdmjEPZDolEmoN76k8CS359vYcDLGxAri2MmHlUt/p/eeAaqrYagyX0
         ubqDfQ9JdOGUUhTiN5B0bYCu8KT6wvowiUNuA2MJesdSI9ZaQhhoMEys6dxsKPNZvyGG
         WhdwOqPrPdczsZ5ypc3AE0ygV3/nBicWhpJRqvsTQP173I0g9XGFeZnupVaGM2hIzzAH
         /B2Q==
X-Gm-Message-State: AOAM530fD9Gb5fDZRWaQDUDWtzmaHJCea63+g1ig7fHpU4Sk8e3PFbrl
        TJV4aoT4tF93r5qxqkhJcHE1+QX4OavR0w==
X-Google-Smtp-Source: ABdhPJymLjmvfAV3JyBHao8RNDBIW37v/yUH5ozoHJAreOnCIsL9HXHmQN4DnFaTWTFRsiC2vcqQeA==
X-Received: by 2002:a7b:cb18:: with SMTP id u24mr3142793wmj.15.1642592692782;
        Wed, 19 Jan 2022 03:44:52 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6d:f804:0:d40a:ebf3:7c3b:c5af])
        by smtp.gmail.com with ESMTPSA id f8sm12250295wry.23.2022.01.19.03.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 03:44:52 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, fam.zheng@bytedance.com,
        cong.wang@bytedance.com, song@kernel.org, quentin@isovalent.com,
        andrii.nakryiko@gmail.com, Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH bpf-next v3 1/3] uapi/bpf: Add missing description and returns for helper documentation
Date:   Wed, 19 Jan 2022 11:44:40 +0000
Message-Id: <20220119114442.1452088-1-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Both description and returns section will become mandatory
for helpers and syscalls in a later commit to generate man pages.

This commit also adds in the documentation that BPF_PROG_RUN is
an alias for BPF_PROG_TEST_RUN for anyone searching for the
syscall in the generated man pages.

Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 include/uapi/linux/bpf.h       | 15 +++++++++++++++
 tools/include/uapi/linux/bpf.h | 15 +++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index b0383d371b9a..a9c96c21330a 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -330,6 +330,8 @@ union bpf_iter_link_info {
  *			*ctx_out*, *data_in* and *data_out* must be NULL.
  *			*repeat* must be zero.
  *
+ *		BPF_PROG_RUN is an alias for BPF_PROG_TEST_RUN.
+ *
  *	Return
  *		Returns zero on success. On error, -1 is returned and *errno*
  *		is set appropriately.
@@ -1775,6 +1777,8 @@ union bpf_attr {
  * 		0 on success, or a negative error in case of failure.
  *
  * u64 bpf_get_current_pid_tgid(void)
+ * 	Description
+ * 		Get the current pid and tgid.
  * 	Return
  * 		A 64-bit integer containing the current tgid and pid, and
  * 		created as such:
@@ -1782,6 +1786,8 @@ union bpf_attr {
  * 		*current_task*\ **->pid**.
  *
  * u64 bpf_get_current_uid_gid(void)
+ * 	Description
+ * 		Get the current uid and gid.
  * 	Return
  * 		A 64-bit integer containing the current GID and UID, and
  * 		created as such: *current_gid* **<< 32 \|** *current_uid*.
@@ -2256,6 +2262,8 @@ union bpf_attr {
  * 		The 32-bit hash.
  *
  * u64 bpf_get_current_task(void)
+ * 	Description
+ * 		Get the current task.
  * 	Return
  * 		A pointer to the current task struct.
  *
@@ -2369,6 +2377,8 @@ union bpf_attr {
  * 		indicate that the hash is outdated and to trigger a
  * 		recalculation the next time the kernel tries to access this
  * 		hash or when the **bpf_get_hash_recalc**\ () helper is called.
+ * 	Return
+ * 		void.
  *
  * long bpf_get_numa_node_id(void)
  * 	Description
@@ -2466,6 +2476,8 @@ union bpf_attr {
  * 		A 8-byte long unique number or 0 if *sk* is NULL.
  *
  * u32 bpf_get_socket_uid(struct sk_buff *skb)
+ * 	Description
+ * 		Get the owner UID of the socked associated to *skb*.
  * 	Return
  * 		The owner UID of the socket associated to *skb*. If the socket
  * 		is **NULL**, or if it is not a full socket (i.e. if it is a
@@ -3240,6 +3252,9 @@ union bpf_attr {
  * 		The id is returned or 0 in case the id could not be retrieved.
  *
  * u64 bpf_get_current_cgroup_id(void)
+ * 	Description
+ * 		Get the current cgroup id based on the cgroup within which
+ * 		the current task is running.
  * 	Return
  * 		A 64-bit integer containing the current cgroup id based
  * 		on the cgroup within which the current task is running.
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index b0383d371b9a..a9c96c21330a 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -330,6 +330,8 @@ union bpf_iter_link_info {
  *			*ctx_out*, *data_in* and *data_out* must be NULL.
  *			*repeat* must be zero.
  *
+ *		BPF_PROG_RUN is an alias for BPF_PROG_TEST_RUN.
+ *
  *	Return
  *		Returns zero on success. On error, -1 is returned and *errno*
  *		is set appropriately.
@@ -1775,6 +1777,8 @@ union bpf_attr {
  * 		0 on success, or a negative error in case of failure.
  *
  * u64 bpf_get_current_pid_tgid(void)
+ * 	Description
+ * 		Get the current pid and tgid.
  * 	Return
  * 		A 64-bit integer containing the current tgid and pid, and
  * 		created as such:
@@ -1782,6 +1786,8 @@ union bpf_attr {
  * 		*current_task*\ **->pid**.
  *
  * u64 bpf_get_current_uid_gid(void)
+ * 	Description
+ * 		Get the current uid and gid.
  * 	Return
  * 		A 64-bit integer containing the current GID and UID, and
  * 		created as such: *current_gid* **<< 32 \|** *current_uid*.
@@ -2256,6 +2262,8 @@ union bpf_attr {
  * 		The 32-bit hash.
  *
  * u64 bpf_get_current_task(void)
+ * 	Description
+ * 		Get the current task.
  * 	Return
  * 		A pointer to the current task struct.
  *
@@ -2369,6 +2377,8 @@ union bpf_attr {
  * 		indicate that the hash is outdated and to trigger a
  * 		recalculation the next time the kernel tries to access this
  * 		hash or when the **bpf_get_hash_recalc**\ () helper is called.
+ * 	Return
+ * 		void.
  *
  * long bpf_get_numa_node_id(void)
  * 	Description
@@ -2466,6 +2476,8 @@ union bpf_attr {
  * 		A 8-byte long unique number or 0 if *sk* is NULL.
  *
  * u32 bpf_get_socket_uid(struct sk_buff *skb)
+ * 	Description
+ * 		Get the owner UID of the socked associated to *skb*.
  * 	Return
  * 		The owner UID of the socket associated to *skb*. If the socket
  * 		is **NULL**, or if it is not a full socket (i.e. if it is a
@@ -3240,6 +3252,9 @@ union bpf_attr {
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

