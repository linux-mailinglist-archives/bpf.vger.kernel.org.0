Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC7F1F35EE
	for <lists+bpf@lfdr.de>; Tue,  9 Jun 2020 10:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgFIIKf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Jun 2020 04:10:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21524 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728029AbgFIIKe (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Jun 2020 04:10:34 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05982lTj137693;
        Tue, 9 Jun 2020 04:10:31 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31hrn86urv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 04:10:31 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05983CKq139600;
        Tue, 9 Jun 2020 04:10:31 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31hrn86uqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 04:10:30 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0598ACUH030386;
        Tue, 9 Jun 2020 08:10:29 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 31g2s7t845-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 08:10:28 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0598AQY712058950
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Jun 2020 08:10:26 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3A7FA4066;
        Tue,  9 Jun 2020 08:10:25 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C949A405C;
        Tue,  9 Jun 2020 08:10:25 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  9 Jun 2020 08:10:25 +0000 (GMT)
From:   Sumanth Korikkar <sumanthk@linux.ibm.com>
To:     linux-perf-users@vger.kernel.org, acme@kernel.org
Cc:     bpf@vger.kernel.org, jolsa@redhat.com, tmricht@linux.ibm.com,
        heiko.carstens@de.ibm.com, mhiramat@kernel.org, iii@linux.ibm.com,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [PATCH v2 0/2] perf: Fix bpf prologue generation, uaccess
Date:   Tue,  9 Jun 2020 10:10:17 +0200
Message-Id: <20200609081019.60234-1-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-09_02:2020-06-08,2020-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 phishscore=0 clxscore=1015 adultscore=0 mlxlogscore=924
 cotscore=-2147483648 suspectscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006090056
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Patches:
1. Fix bpf prologue generation. bpf_probe_read is unavailable for arch
   with overlapping address space.  If uaccess, use bpf_probe_read_user.
   Otherwise, use bpf_probe_read_kernel.
2. Fix uaccess in kprobes. Now perf probe add with @user attribute works

v1->v2:
- Split the patches and add Acked-By

Thank you.

Sumanth Korikkar (2):
  perf: Fix user attribute access in kprobes
  perf: Fix bpf prologue generation

 tools/perf/util/bpf-prologue.c | 14 ++++++++++----
 tools/perf/util/probe-event.c  |  7 +++++--
 tools/perf/util/probe-file.c   |  2 +-
 3 files changed, 16 insertions(+), 7 deletions(-)

-- 
2.17.1

