Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C8C581454
	for <lists+bpf@lfdr.de>; Tue, 26 Jul 2022 15:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238978AbiGZNke (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jul 2022 09:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238982AbiGZNkb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jul 2022 09:40:31 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858AA1837D
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 06:40:29 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QDMC9C024954;
        Tue, 26 Jul 2022 13:40:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=tfxyUC9goWxD80cLjSVfdXEhPbbH7PXFAdr7PYiNao0=;
 b=LovvnKZVJ7wKsRCvd6laa15EXJOcBvZrHx+y1cehZma9HsN0qvbARoSIL3cL2ck4XqdB
 WbFpH+8vxj+XH9CAJDyYQLwxONNlGX3sABUcd+WwaHYmibyp48Q0ZNqyCuA6ZoAaC3+z
 Wk2UmQYzCg253K+qmTiNI1STf699nKaIDmq2LnZtthphMnH9U9Hqjp3BUagVRJzz9gG0
 3smZif7pghbSuGYUOosbncho79huSZhW99q6hJnWaklZGhUNhjkot0/gyZYfcNMUdApr
 tN9PGYuprwoKCkKn87ogY1UVH5i0/jU24w8uEMZqmprSvC/S6u3edwXJLOvKOjhKHdrP hQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hjh3f0jsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jul 2022 13:40:15 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26QDLB6M003403;
        Tue, 26 Jul 2022 13:40:13 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3hg97tbtvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jul 2022 13:40:13 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26QDeABn15401326
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jul 2022 13:40:10 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F60CA4066;
        Tue, 26 Jul 2022 13:40:10 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CAFB3A4060;
        Tue, 26 Jul 2022 13:40:09 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.20.53])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Jul 2022 13:40:09 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 1/2] libbpf: Extend BPF_KSYSCALL documentation
Date:   Tue, 26 Jul 2022 15:40:07 +0200
Message-Id: <20220726134008.256968-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220726134008.256968-1-iii@linux.ibm.com>
References: <20220726134008.256968-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jx9QjEtDkqm3NCsWldU7-4Tv1nfWfT8Q
X-Proofpoint-ORIG-GUID: jx9QjEtDkqm3NCsWldU7-4Tv1nfWfT8Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_04,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 phishscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207260051
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
 tools/lib/bpf/bpf_tracing.h | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index f4d3e1e2abe2..43ca3aff2292 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -523,10 +523,17 @@ static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
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
+ * - clone(): CONFIG_CLONE_BACKWARDS, CONFIG_CLONE_BACKWARDS2 and
+ *            CONFIG_CLONE_BACKWARDS3.
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

