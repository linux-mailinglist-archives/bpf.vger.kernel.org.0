Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAAB74AB5FA
	for <lists+bpf@lfdr.de>; Mon,  7 Feb 2022 08:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235648AbiBGHfc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Feb 2022 02:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbiBGHZV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Feb 2022 02:25:21 -0500
X-Greylist: delayed 1021 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 23:25:20 PST
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAC8C043186
        for <bpf@vger.kernel.org>; Sun,  6 Feb 2022 23:25:19 -0800 (PST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21747JTY022361;
        Mon, 7 Feb 2022 07:07:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=7zyMfxsovD/fPbXfWu85hxbA7vmqTYc8JyBi+lzW4tE=;
 b=rMaHrfHyL30rx1FHR01QniruzunTrpcfrMmY+LJ2pZmoPCjFiSH9THgH+tz4QKlHKP3j
 2sTNNlNfZgtCDXtV+ZzsUlHzy6LaBEQsnBREV0tEipPoJ3j2RlsZUSHVfxAcxHRn8fAJ
 1rieh2g2krM1XJpjyVVB7JQKQc0RAzyRkMJDC2r7x8amWo/OhjcYrBSme2QvdE9AK0yc
 D1dNOcAY9W2yAQwZqiPu2HiDd/LQQBG8nOM4sW7CaZQmOJ4BMdfza1WIH2C323FcJuAv
 KFCsmc1WCKiFCR0bxeS450uWrS5eso+nMwC+bhnbiJetn8Wb2FjgRhyvp6L/VOBBbMY0 gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e22u2mngd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 07:07:47 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2176qlxu005179;
        Mon, 7 Feb 2022 07:07:47 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e22u2mnfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 07:07:46 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21772OSL007925;
        Mon, 7 Feb 2022 07:07:44 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3e1gv91dr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 07:07:44 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21777fZj47186364
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Feb 2022 07:07:41 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7F3AA405C;
        Mon,  7 Feb 2022 07:07:40 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55515A405F;
        Mon,  7 Feb 2022 07:07:38 +0000 (GMT)
Received: from li-NotSettable.ibm.com.com (unknown [9.43.33.186])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  7 Feb 2022 07:07:38 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     <bpf@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Jordan Niethe <jniethe5@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [RFC PATCH 1/3] ftrace: Add ftrace_location_lookup() to lookup address of ftrace location
Date:   Mon,  7 Feb 2022 12:37:20 +0530
Message-Id: <1b71a95af2e21b8dc3599005dfa0170008ed952c.1644216043.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1644216043.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1644216043.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0eiY6WhVxMcXEuFjc4hul--u43s_vfmJ
X-Proofpoint-ORIG-GUID: WONrzMgFW36oD21lJJNs6QMpZpk8cD7S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-07_02,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 malwarescore=0 adultscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=829 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202070046
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a new function ftrace_location_lookup() that can be used to
determine the exact ftrace location around function entry. This is
useful on architectures where the ftrace location is not the very first
instruction in a function. Such architectures can override this function
to search for ftrace location and to return the exact address of the
same.

Convert some uses of ftrace_location() in BPF infrastructure to the new
function.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 include/linux/ftrace.h  |  5 +++++
 kernel/bpf/trampoline.c | 27 +++++++++------------------
 kernel/trace/ftrace.c   | 14 ++++++++++++++
 3 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 708e9d610f1337..59791f2aa0b356 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -582,6 +582,7 @@ int ftrace_test_record(struct dyn_ftrace *rec, bool enable);
 void ftrace_run_stop_machine(int command);
 unsigned long ftrace_location(unsigned long ip);
 unsigned long ftrace_location_range(unsigned long start, unsigned long end);
+unsigned long ftrace_location_lookup(unsigned long ip);
 unsigned long ftrace_get_addr_new(struct dyn_ftrace *rec);
 unsigned long ftrace_get_addr_curr(struct dyn_ftrace *rec);
 
@@ -795,6 +796,10 @@ static inline unsigned long ftrace_location(unsigned long ip)
 {
 	return 0;
 }
+static inline unsigned long ftrace_location_lookup(unsigned long ip)
+{
+	return 0;
+}
 
 /*
  * Again users of functions that have ftrace_ops may not
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 4b6974a195c138..5da9d332cd0e10 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -117,25 +117,14 @@ static void bpf_trampoline_module_put(struct bpf_trampoline *tr)
 	tr->mod = NULL;
 }
 
-static int is_ftrace_location(void *ip)
-{
-	long addr;
-
-	addr = ftrace_location((long)ip);
-	if (!addr)
-		return 0;
-	if (WARN_ON_ONCE(addr != (long)ip))
-		return -EFAULT;
-	return 1;
-}
-
 static int unregister_fentry(struct bpf_trampoline *tr, void *old_addr)
 {
 	void *ip = tr->func.addr;
 	int ret;
 
 	if (tr->func.ftrace_managed)
-		ret = unregister_ftrace_direct((long)ip, (long)old_addr);
+		ret = unregister_ftrace_direct(ftrace_location_lookup((unsigned long)ip),
+									(long)old_addr);
 	else
 		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, old_addr, NULL);
 
@@ -150,7 +139,8 @@ static int modify_fentry(struct bpf_trampoline *tr, void *old_addr, void *new_ad
 	int ret;
 
 	if (tr->func.ftrace_managed)
-		ret = modify_ftrace_direct((long)ip, (long)old_addr, (long)new_addr);
+		ret = modify_ftrace_direct(ftrace_location_lookup((unsigned long)ip),
+						(long)old_addr, (long)new_addr);
 	else
 		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, old_addr, new_addr);
 	return ret;
@@ -162,10 +152,11 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
 	void *ip = tr->func.addr;
 	int ret;
 
-	ret = is_ftrace_location(ip);
-	if (ret < 0)
-		return ret;
-	tr->func.ftrace_managed = ret;
+	ip = (void *)ftrace_location_lookup((unsigned long)ip);
+	tr->func.ftrace_managed = !!ip;
+
+	if (!ip)
+		ip = tr->func.addr;
 
 	if (bpf_trampoline_module_get(tr))
 		return -ENOENT;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index ff57a842fbebcd..6a68b86b2b6ac6 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1581,6 +1581,20 @@ unsigned long ftrace_location(unsigned long ip)
 	return ftrace_location_range(ip, ip);
 }
 
+/**
+ * ftrace_location_lookup - return exact address of traced location
+ * @ip: the instruction pointer to check
+ *
+ * Used to lookup traced location around function entry. This is
+ * especially useful on architectures where the traced location is
+ * not the very first instruction in a function. Such architectures
+ * should provide an implementation of this function.
+ */
+unsigned long __weak ftrace_location_lookup(unsigned long ip)
+{
+	return ftrace_location_range(ip, ip);
+}
+
 /**
  * ftrace_text_reserved - return true if range contains an ftrace location
  * @start: start of range to search
-- 
2.34.1

