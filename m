Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B714A987C
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 12:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358441AbiBDLg3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 06:36:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45848 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358414AbiBDLg3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Feb 2022 06:36:29 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 214B89Y7017439;
        Fri, 4 Feb 2022 11:35:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=X1HNFXhkXdkesPv1MpBDPoT7h0htw8qKbG2WUQD1oKg=;
 b=pnvNNs6RKYBvhZeYx1N8hWwfYfug/Qy3hiCmpK8qcQP9jBc1twG3SpgxPiTGhFTh4/V0
 CAnkrgjdqqSfMkXouBFfwCUCB1Cihb/gi9Gce22m0JozeRLVJjQX+pyrXFdriPUk1XOD
 d4bc4cV6MSXEBvj/kkZcaHzws6aBBT76iPQIDdlAtF2sWK8Wj1cQYzS8f6fIpcenTfLa
 JP+DQKfLcJIAN3L87Ld0MDCzZZaNe6hQVGjCSm7diMPA9ggmRwWmwsObdD5vngisyJDG
 qku5G8KafEkqIvk5IXznxjb6zX6EGCc3njlqitaNwQ+yu7UuuQ+aMe/D8fHU6AGHUhGN ZA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e0qx93k5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 11:35:49 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 214BZmei018740;
        Fri, 4 Feb 2022 11:35:48 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e0qx93k5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 11:35:48 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 214BX4HR005579;
        Fri, 4 Feb 2022 11:35:47 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3e0r0sm4sn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 11:35:46 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 214BZhLI44957992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Feb 2022 11:35:43 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A6B311C052;
        Fri,  4 Feb 2022 11:35:43 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5684511C05E;
        Fri,  4 Feb 2022 11:35:41 +0000 (GMT)
Received: from li-NotSettable.ibm.com.com (unknown [9.43.69.119])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  4 Feb 2022 11:35:41 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Hari Bathini <hbathini@linux.ibm.com>
Subject: [PATCH bpf-next 0/3] selftests/bpf: Fix tests on non-x86 architectures
Date:   Fri,  4 Feb 2022 17:05:17 +0530
Message-Id: <cover.1643973917.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2ZegYgVT-HFumoWmtqWzR2cuxRaKLBV7
X-Proofpoint-ORIG-GUID: 4GCwTyPK2n-Vq5W-DSPCMBNsBKkTk4U8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_04,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202040063
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The first patch fixes an issue with bpf_syscall_macro test to work 
properly on architectures that don't have a syscall wrapper. The second 
patch updates SYS_PREFIX for architectures without a syscall wrapper.
The final patch fixes some of the tests to use correct syscall entry 
names on non-x86 architectures. 

- Naveen


Naveen N. Rao (3):
  selftests/bpf: Use correct pt_regs on architectures without syscall
    wrapper
  selftests/bpf: Use "__se_" prefix on architectures without syscall
    wrapper
  selftests/bpf: Fix tests to use arch-dependent syscall entry points

 tools/testing/selftests/bpf/progs/bloom_filter_bench.c | 7 ++++---
 tools/testing/selftests/bpf/progs/bloom_filter_map.c   | 5 +++--
 tools/testing/selftests/bpf/progs/bpf_loop.c           | 9 +++++----
 tools/testing/selftests/bpf/progs/bpf_loop_bench.c     | 3 ++-
 tools/testing/selftests/bpf/progs/bpf_misc.h           | 2 +-
 tools/testing/selftests/bpf/progs/bpf_syscall_macro.c  | 4 ++++
 tools/testing/selftests/bpf/progs/fexit_sleep.c        | 9 +++++----
 tools/testing/selftests/bpf/progs/perfbuf_bench.c      | 3 ++-
 tools/testing/selftests/bpf/progs/ringbuf_bench.c      | 3 ++-
 tools/testing/selftests/bpf/progs/test_ringbuf.c       | 3 ++-
 tools/testing/selftests/bpf/progs/trace_printk.c       | 3 ++-
 tools/testing/selftests/bpf/progs/trace_vprintk.c      | 3 ++-
 tools/testing/selftests/bpf/progs/trigger_bench.c      | 9 +++++----
 13 files changed, 39 insertions(+), 24 deletions(-)


base-commit: 227a0713b319e7a8605312dee1c97c97a719a9fc
-- 
2.34.1

