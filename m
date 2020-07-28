Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C126230964
	for <lists+bpf@lfdr.de>; Tue, 28 Jul 2020 14:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbgG1MB1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jul 2020 08:01:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43610 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729391AbgG1MB0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 Jul 2020 08:01:26 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06SBWMpQ069183;
        Tue, 28 Jul 2020 08:01:13 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32jga9ehsp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jul 2020 08:01:13 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06SBxdZ3018303;
        Tue, 28 Jul 2020 12:01:08 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 32gcpx3h02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jul 2020 12:01:07 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06SC15qV26542420
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jul 2020 12:01:05 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDF1C11C069;
        Tue, 28 Jul 2020 12:01:03 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2276F11C064;
        Tue, 28 Jul 2020 12:01:03 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.173.62])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 28 Jul 2020 12:01:03 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 0/3] samples/bpf: A couple s390 fixes
Date:   Tue, 28 Jul 2020 14:00:56 +0200
Message-Id: <20200728120059.132256-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-28_07:2020-07-28,2020-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=783
 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007280085
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series contains small fixes that make samples work on s390:

Patch 1: Fix building M=samples/bpf with O=.
Patch 2: Use more portable __sys_connect instead of
         SYSCALL(sys_connect).
Patch 3: Use bpf_probe_read_kernel instead of bpf_probe_read in
         libbpf.

Ilya Leoshkevich (3):
  samples/bpf: Fix building out of srctree
  samples/bpf: Fix test_map_in_map on s390
  libbpf: Use bpf_probe_read_kernel

 samples/bpf/Makefile               |  1 +
 samples/bpf/test_map_in_map_kern.c |  7 ++--
 tools/lib/bpf/bpf_core_read.h      | 51 ++++++++++++++++--------------
 tools/lib/bpf/bpf_tracing.h        | 15 ++++++---
 4 files changed, 41 insertions(+), 33 deletions(-)

-- 
2.25.4

