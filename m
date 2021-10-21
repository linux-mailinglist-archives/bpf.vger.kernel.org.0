Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756A4435FA4
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 12:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhJUKte (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 06:49:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29444 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230073AbhJUKte (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 21 Oct 2021 06:49:34 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19L86dnh000958;
        Thu, 21 Oct 2021 06:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=cnWOUHwNtnnD8fbc0Ezs33mVjGPSw4E0EAg+RI7ffUc=;
 b=DpGxlDhAaIeDnQeaLeWHk0nsGie7D0ZpbcsKZfkwMK+Pbx/Q1lxCvQyZGJOLosqxLFc0
 ia0m6Wy1WO4jl05W8uKbWtWKUKq2dkV6nkpwplAAroc3+3LmHhe7Y2+0r/4a46LB2bRL
 HIK42PoREA9YjblHKib1nHDhgFy5axsQ+u5UV28RLdh9J2kXE58d7VmK6oyEsxdvpZQ1
 oclJUvnPzGDHS/xtc7v5bhK163dMy8iPjY9xXL+852AA5XEXb0kR/o2rcUE5u4FArM7Y
 ipBPYHtdVPxhqP82QjSad1bi6leE0Y0rkiH9nQWNJkGVCMZNgMEIDGp/RFgf5uUfKeL6 Cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bu20p6bu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 06:47:06 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19LAExRs010945;
        Thu, 21 Oct 2021 06:47:05 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bu20p6btq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 06:47:05 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19LAcLnU020334;
        Thu, 21 Oct 2021 10:47:04 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 3bqpcajucy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 10:47:04 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19LAl01r2425510
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 10:47:00 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F9A24204F;
        Thu, 21 Oct 2021 10:47:00 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3AA8B42091;
        Thu, 21 Oct 2021 10:47:00 +0000 (GMT)
Received: from vm.lan (unknown [9.145.12.156])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 21 Oct 2021 10:47:00 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v3 0/1] btf_dump fixes for s390
Date:   Thu, 21 Oct 2021 12:46:57 +0200
Message-Id: <20211021104658.624944-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hqr65OLjqmokk_qaCJ4_5DfPVdZcr5YQ
X-Proofpoint-GUID: M8pEV3Yl4sgDCxK2lYxm9sIlFx53xSpX
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-21_02,2021-10-20_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=999 malwarescore=0 bulkscore=0 impostorscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110210054
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

v2: https://lore.kernel.org/bpf/20211013160902.428340-1-iii@linux.ibm.com/
v2 -> v3:
- Drop committed patches.
- Handle potential division by zero when using btf__align_of(). Use
  btf__align_of() in btf_dump_ptr_data() instead of the direct ptr_sz
  access: although it's slightly slower, the result is the same and the
  resulting code is more uniform.

v1: https://lore.kernel.org/bpf/20211012023218.399568-1-iii@linux.ibm.com/
v1 -> v2:
- Remove redundant local variables, use t->size directly instead.
- Add btf__align_of() patch.

Ilya Leoshkevich (1):
  libbpf: Fix ptr_is_aligned() usages

 tools/lib/bpf/btf_dump.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

-- 
2.31.1

