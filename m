Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85DE263AF8
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 04:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgIJB6x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 21:58:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10536 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729135AbgIJBkY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Sep 2020 21:40:24 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 089NWx5J104000;
        Wed, 9 Sep 2020 19:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=QEURUIucr1RrGn4Zr/Brb1/uNaqT3LDxytRhxDwGNIg=;
 b=AYZ258SQTH06UO1nMDVd9H6tmMhDKAAtGT+uitC0S0K2bkGTKvN6QDdD9HUxBqoNkYkX
 OMIHs0BML20s8/chQlcBRzj3LnImk71nGy//H9XejPbd7nu0RFQSm193qIy0FXMuqVAh
 yXMOWFeQlUq1p969Pjtdm/x8+/57GgxX2Mm94lQOH237iMJFEPkLxvg2XZsTBs6ZwkGY
 GTjocYw+yCiB9kOYLOPJF46/ztvRqOz+dvBkPH5xwQUg7B3xHacBHY5OcXPTCjpmR7++
 b8iXEcT+r2e3xoACnMVxIXE9czj4bJ4+07Pk04m4tRg0LMWWyV1v5TBI8nD6npO7flZo Fw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33f8qqg4au-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 19:34:48 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 089NYl47115106;
        Wed, 9 Sep 2020 19:34:47 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33f8qqg4a5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 19:34:47 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 089NWeij023865;
        Wed, 9 Sep 2020 23:34:45 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 33c2a8db9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 23:34:45 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 089NYgNs27197924
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Sep 2020 23:34:42 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46EC1A404D;
        Wed,  9 Sep 2020 23:34:42 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9884A4040;
        Wed,  9 Sep 2020 23:34:41 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.5.224])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Sep 2020 23:34:41 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH RFC bpf-next 0/5] Do not include the original insn in zext patchlet
Date:   Thu, 10 Sep 2020 01:34:34 +0200
Message-Id: <20200909233439.3100292-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_17:2020-09-09,2020-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 mlxscore=0 mlxlogscore=835
 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090207
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi!

This patch series attempts to fix test_progs failure on s390, which
Yauheni reported here:

https://lore.kernel.org/bpf/20200903140542.156624-1-yauheni.kaliuta@redhat.com/

The problem is that zext code includes the instruction, whose result
needs to be zero-extended, into the zero-extension patchlet. If this
instruction happens to be a call, its delta is not adjusted, and as a
result verifier rejects the program later.

The code seems to have been written this way, because there is no helper
function to insert bpf instructions: currently one can either replace or
remove. So insertion seems to have been emulated with replacement.

Patches 1-4 teach bpf_patch_insn_data() how to insert (by accepting
variable number of old insns, which is normally 1, but can now be 0
too). Patch 5 uses this new capability to resolve the issue.

Ilya Leoshkevich (5):
  bpf: Make bpf_patch_insn_single() accept variable number of old insns
  bpf: Make adjust_insn_aux_data() accept variable number of old insns
  bpf: Make adjust_subprog_starts() accept variable number of old insns
  bpf: Make bpf_patch_insn_data() accept variable number of old insns
  bpf: Do not include the original insn in zext patchlet

 include/linux/filter.h |   4 +-
 kernel/bpf/core.c      |  18 ++++----
 kernel/bpf/verifier.c  | 100 ++++++++++++++++++++++++-----------------
 3 files changed, 70 insertions(+), 52 deletions(-)

-- 
2.25.4

