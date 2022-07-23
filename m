Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820A557EB41
	for <lists+bpf@lfdr.de>; Sat, 23 Jul 2022 04:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbiGWCEZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 22:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbiGWCET (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 22:04:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9483FA0BB1
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 19:04:18 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26N1gJ5h008169;
        Sat, 23 Jul 2022 02:04:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=7M8ZAU6jhM84BMxcCE29mREjmmxsZRiFvm9g6bfSErQ=;
 b=I5a0u1nMiwhpSuOo5rc19KahKCFFuuvZcswaqVSZXhau6N3i45xZGKkxsZosw65r67gG
 vigHs4hR6zlurqHoP5+ScMZiW32QqN8buZ1z8hj+PPQqsvswnW43C7Wf79cwzIwTQ1eS
 JbsulqdE/VGR1kzw8lxP35ajwHAWTdTho/+WkrIiX9UM+NeWKmFJKejxvBhth6Clt/Jw
 WAR3+cGw1Mytqem2DdrgK3N7VBoQNXTHrZcZ73HQaDRKZa64e1g6oiur7BdCEQJ0Ue8p
 MbAprbmm+dC4YAl0k6Ewrql/fLdZtO0bWD3dQGaPFI0vLAFBI3t+bPMmURKxDqGYyOK+ 0A== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hg7j4gb4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 23 Jul 2022 02:04:05 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26N1nl5h032248;
        Sat, 23 Jul 2022 02:04:03 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 3hbmy8xqn6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 23 Jul 2022 02:04:03 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26N24Apa18088194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Jul 2022 02:04:10 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFC8AAE04D;
        Sat, 23 Jul 2022 02:03:57 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71FF8AE045;
        Sat, 23 Jul 2022 02:03:57 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.90.71])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 23 Jul 2022 02:03:57 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 1/2] libbpf: Extend BPF_KSYSCALL documentation
Date:   Sat, 23 Jul 2022 04:03:43 +0200
Message-Id: <20220723020344.21699-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220723020344.21699-1-iii@linux.ibm.com>
References: <20220723020344.21699-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DZwC8m8mHL2o4IFx5dCvmVz_z1Y4ysh_
X-Proofpoint-ORIG-GUID: DZwC8m8mHL2o4IFx5dCvmVz_z1Y4ysh_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_06,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxscore=0 malwarescore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207230007
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Explicitly list known quirks.
Mention that socket-related syscalls can be invoked via socketcall().

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/bpf_tracing.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index f4d3e1e2abe2..9d2feab7d903 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -523,10 +523,16 @@ static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
  * Original struct pt_regs * context is preserved as 'ctx' argument. This might
  * be necessary when using BPF helpers like bpf_perf_event_output().
  *
- * At the moment BPF_KSYSCALL does not handle all the calling convention
- * quirks for mmap(), clone() and compat syscalls transparrently. This may or
- * may not change in the future. User needs to take extra measures to handle
- * such quirks explicitly, if necessary.
+ * At the moment BPF_KSYSCALL does not transparently handle all the calling
+ * convention quirks for the following syscalls:
+ *
+ * - mmap(): __ARCH_WANT_SYS_OLD_MMAP.
+ * - clone(): CLONE_BACKWARDS, CLONE_BACKWARDS2 and CLONE_BACKWARDS3.
+ * - socket-related syscalls: __ARCH_WANT_SYS_SOCKETCALL.
+ * - compat syscalls.
+ *
+ * This may or may not change in the future. User needs to take extra measures
+ * to handle such quirks explicitly, if necessary.
  *
  * This macro relies on BPF CO-RE support and virtual __kconfig externs.
  */
-- 
2.35.3

