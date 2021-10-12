Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6F5429B84
	for <lists+bpf@lfdr.de>; Tue, 12 Oct 2021 04:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhJLCej (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Oct 2021 22:34:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31808 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230362AbhJLCei (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 11 Oct 2021 22:34:38 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19C2VaEj020427;
        Mon, 11 Oct 2021 22:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=B6Ng5ih1Z+B/odpthd6S+J0bQpv/Cw24KuqaUAnL3dg=;
 b=DnopFDVLFQ+9ufqA/QYEo9Rth2rBCaMGjNhycyS/ok8bXSpekTvswUjgCgs/0KeFhpVm
 8ppSEMD9Sizt6c/hoVsOAmVYcJo/gvnVO/NGEIXLsQiM+j4RbCHPpX2M0I/Vy4YncQWW
 m/UXnajKTWoK0VBvlLiCjBMBF+qaLJPfZ4OPNlN/Vs6pJq61HzEHrGIR9vCqcTg9ZK4f
 Smo5hUpvjF4CxmB2sl6nV704oZNFFkYKkEAeCjos8Uh2FTLQWSM2vVxS0/G4vmBsziPg
 RwVRekq4XFUg+k6lTZxX5sGHmOGU+pS7Olu69zsNBM85gWr7leE41m3BERYyAeuAJSVD UA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bn1ng00cq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 22:32:25 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19C2WP0Q026777;
        Mon, 11 Oct 2021 22:32:25 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bn1ng00cd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 22:32:25 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19C2BorV014379;
        Tue, 12 Oct 2021 02:32:23 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3bk2bj3kpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 02:32:23 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19C2WJCS29491672
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Oct 2021 02:32:19 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC0F611C04A;
        Tue, 12 Oct 2021 02:32:19 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B21211C058;
        Tue, 12 Oct 2021 02:32:19 +0000 (GMT)
Received: from vm.lan (unknown [9.145.45.184])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Oct 2021 02:32:19 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 0/3] btf_dump fixes for s390
Date:   Tue, 12 Oct 2021 04:32:15 +0200
Message-Id: <20211012023218.399568-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BCPCpbeBERxZ05nSrh9C6KcsXTyjmuE9
X-Proofpoint-ORIG-GUID: Sbs5cRhTSNbTXBSNyra902qgZfgS5yW1
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-11_11,2021-10-11_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110120008
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

This series along with [1] and [2] fixes all the failures in the
btf_dump testsuite currently present on s390, in particular:

* [1] fixes intermittent build bug causing "failed to encode tag ..."
  * error messages.
* [2] fixes missing VAR entries on s390.
* Patch 1 disables Intel-specific code in a testcase.
* Patch 2 fixes an endianness-related bug.
* Patch 3 fixes an alignment-related bug.

[1] https://lore.kernel.org/bpf/20211012022521.399302-1-iii@linux.ibm.com/
[2] https://lore.kernel.org/bpf/20211012022637.399365-1-iii@linux.ibm.com/

Best regards,
Ilya

Ilya Leoshkevich (3):
  selftests/bpf: Use cpu_number only on arches that have it
  libbpf: Fix dumping big-endian bitfields
  libbpf: Fix dumping __int128

 tools/lib/bpf/btf_dump.c                          | 12 ++++++++----
 tools/testing/selftests/bpf/prog_tests/btf_dump.c |  2 ++
 2 files changed, 10 insertions(+), 4 deletions(-)

-- 
2.31.1

