Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA8BF100B11
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2019 19:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfKRSD4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Nov 2019 13:03:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42572 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726317AbfKRSD4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 18 Nov 2019 13:03:56 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAII2cvA008489
        for <bpf@vger.kernel.org>; Mon, 18 Nov 2019 13:03:55 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2way67ke29-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 18 Nov 2019 13:03:54 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Mon, 18 Nov 2019 18:03:50 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 18 Nov 2019 18:03:48 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAII3lXh52625650
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Nov 2019 18:03:47 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE507AE051;
        Mon, 18 Nov 2019 18:03:46 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B4C7AE055;
        Mon, 18 Nov 2019 18:03:46 +0000 (GMT)
Received: from white.boeblingen.de.ibm.com (unknown [9.152.97.207])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 18 Nov 2019 18:03:46 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 0/6] s390/bpf: remove JITed image size limitations
Date:   Mon, 18 Nov 2019 19:03:34 +0100
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19111818-0020-0000-0000-000003899D02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111818-0021-0000-0000-000021DFC533
Message-Id: <20191118180340.68373-1-iii@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_05:2019-11-15,2019-11-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=584
 bulkscore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1911180154
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch series introduces usage of relative long jumps and loads in
order to lift 64/512k size limits on JITed BPF programs on s390.

Patch 1 introduces long relative branches.
Patch 2 changes the way literal pool is arranged in order to be
compatible with long relative loads.
Patch 3 changes the way literal pool base register is loaded for large
programs.
Patch 4 replaces regular loads with long relative loads where they are
totally superior.
Patch 5 introduces long relative loads as an alternative way to load
constants in large programs. Regular loads are kept and still used for
small programs.
Patch 6 removes the size limit check.

Ilya Leoshkevich (6):
  s390/bpf: use relative long branches
  s390/bpf: align literal pool entries
  s390/bpf: load literal pool register using larl
  s390/bpf: use lgrl instead of lg where possible
  s390/bpf: use lg(f)rl when long displacement cannot be used
  s390/bpf: remove JITed image size limitations

 arch/s390/net/bpf_jit_comp.c | 348 +++++++++++++++++++++++++++--------
 1 file changed, 268 insertions(+), 80 deletions(-)

-- 
2.23.0

