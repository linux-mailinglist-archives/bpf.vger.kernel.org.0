Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE072639A2
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 03:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbgIJB7F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 21:59:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34614 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730136AbgIJBxQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Sep 2020 21:53:16 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 089N18PD188409;
        Wed, 9 Sep 2020 19:24:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=0lagexYKlXDzQPuI+FQem8UZmG5eauzddwbnvHlnUNQ=;
 b=gi5HvjyoxOTZyjfsYp/YAOc2AcWenuOVP3TafgOKNA2xrN9kZ7cVbuUHYH44FCMtsj9q
 KHkxqgf2lChovs9OW9NmuSNnYeRkokh6b2xxOlSLJmDW5TWaAkLA62XO+uyQ3ssg8wn5
 6REjvz4xamUFlmrYmKqDu7gLKv8LTtAijtEXXAm4wCqPuMeBPV0FC3JNOWLLBKGSE8Y+
 iamR/5xqcNy1x47DmCmYVL+PIhuyNug4fJ0b60y4+7urbbKufQ6ulLabnBQEWIhyPXQt
 TX9YfbpM0HXpDwAiIszE9B6lkJitMgl7fcK+9XD7I+cBL+Kmg6vZeabN1a/80ZNJcjgh bw== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33f6hfuecp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 19:24:52 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 089NH24o015462;
        Wed, 9 Sep 2020 23:24:51 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 33c2a8b3fs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 23:24:50 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 089NNFdM58720576
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Sep 2020 23:23:15 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2932C11C054;
        Wed,  9 Sep 2020 23:24:48 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA1B811C052;
        Wed,  9 Sep 2020 23:24:47 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.5.224])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Sep 2020 23:24:47 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 0/3] Fix three endianness issues in test_progs
Date:   Thu, 10 Sep 2020 01:24:40 +0200
Message-Id: <20200909232443.3099637-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_17:2020-09-09,2020-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=740 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009090197
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series fixes three test_progs failures on s390, all of which occur
because of endianness issues.

Ilya Leoshkevich (3):
  selftests/bpf: Fix endianness issue in test_sockopt_sk
  selftests/bpf: Fix endianness issues in sk_lookup/ctx_narrow_access
  selftests/bpf: Fix endianness issue in sk_assign

 .../selftests/bpf/prog_tests/sk_assign.c      |   2 +-
 .../selftests/bpf/prog_tests/sockopt_sk.c     |   2 +-
 .../selftests/bpf/progs/test_sk_lookup.c      | 264 ++++++++++--------
 3 files changed, 151 insertions(+), 117 deletions(-)

-- 
2.25.4

