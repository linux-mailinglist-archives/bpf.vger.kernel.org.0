Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC014AB6BA
	for <lists+bpf@lfdr.de>; Mon,  7 Feb 2022 09:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbiBGIkC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Feb 2022 03:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243845AbiBGIcb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Feb 2022 03:32:31 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD87C043181
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 00:32:30 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2174HgkV024832;
        Mon, 7 Feb 2022 07:07:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=TDb/NXwDbRCd9nBtcg23SgJfL/NvPuEe/ewt1ArEY9g=;
 b=Wz+HuOXM+BRB1wWG8QiQYK9c2E7h2ugFPEI+djS09L17FtBQG4DlQ3Mvlyqt9cD6Rhoi
 mgBN2xvjBHF5h0zI5aWE0MrJq0w5gE20hKl1jCyy+F8b8xHLTkSma6NIbQRFLnJ2nDBn
 hWCE/UBh+lyyFE20iBEM69FhqC0l4dYFbZKjU6aEF0yiX0zlYtV8joId08wo4zFqpyfe
 eBzbufdcTnpbIFLyM8lHGyACf/pNNUQRh4582Ry+GiPEIGs04dYDPc2ctQsXYuT+qw/W
 hQfk9yKEhDyg/8f1rAmwF2xLFKQjPqHNPsGLS8Kx07990jyVfhc5VJ1875TvuVupC/R/ 5w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e22tqcjun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 07:07:51 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2176ZiQC013481;
        Mon, 7 Feb 2022 07:07:50 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e22tqcjtr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 07:07:50 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21773sxm028724;
        Mon, 7 Feb 2022 07:07:47 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3e1ggjhf98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 07:07:47 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21777iHl43975082
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Feb 2022 07:07:44 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E826BA4067;
        Mon,  7 Feb 2022 07:07:43 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53B1EA4064;
        Mon,  7 Feb 2022 07:07:41 +0000 (GMT)
Received: from li-NotSettable.ibm.com.com (unknown [9.43.33.186])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  7 Feb 2022 07:07:41 +0000 (GMT)
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
Subject: [RFC PATCH 2/3] powerpc/ftrace: Override ftrace_location_lookup() for MPROFILE_KERNEL
Date:   Mon,  7 Feb 2022 12:37:21 +0530
Message-Id: <fadc5f2a295d6cb9f590bbbdd71fc2f78bf3a085.1644216043.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1644216043.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1644216043.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ni0EWLk3pI-liea96akWcwHrasZgQV4k
X-Proofpoint-GUID: 3CAQHVCI6PjZ_rIZpL70Qmt9cjRR4JAg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-07_02,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202070046
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With CONFIG_MPROFILE_KERNEL, ftrace location is within the first 5
instructions of a function. Override ftrace_location_lookup() to search
within this range for the ftrace location.

Also convert kprobe_lookup_name() to utilize this function.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/kprobes.c      |  8 +-------
 arch/powerpc/kernel/trace/ftrace.c | 11 +++++++++++
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 9a492fdec1dfbe..03cb50e4c8c3e8 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -50,13 +50,7 @@ kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset)
 	addr = (kprobe_opcode_t *)kallsyms_lookup_name(name);
 	if (addr && !offset) {
 #ifdef CONFIG_KPROBES_ON_FTRACE
-		unsigned long faddr;
-		/*
-		 * Per livepatch.h, ftrace location is always within the first
-		 * 16 bytes of a function on powerpc with -mprofile-kernel.
-		 */
-		faddr = ftrace_location_range((unsigned long)addr,
-					      (unsigned long)addr + 16);
+		unsigned long faddr = ftrace_location_lookup((unsigned long)addr);
 		if (faddr)
 			addr = (kprobe_opcode_t *)faddr;
 		else
diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index b65ca87a2eacb1..5127eb65c299af 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -1137,3 +1137,14 @@ char *arch_ftrace_match_adjust(char *str, const char *search)
 		return str;
 }
 #endif /* PPC64_ELF_ABI_v1 */
+
+#ifdef CONFIG_MPROFILE_KERNEL
+unsigned long ftrace_location_lookup(unsigned long ip)
+{
+	/*
+	 * Per livepatch.h, ftrace location is always within the first
+	 * 16 bytes of a function on powerpc with -mprofile-kernel.
+	 */
+	return ftrace_location_range(ip, ip + 16);
+}
+#endif
-- 
2.34.1

