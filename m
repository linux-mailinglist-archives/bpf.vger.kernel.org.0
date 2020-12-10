Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC752D5060
	for <lists+bpf@lfdr.de>; Thu, 10 Dec 2020 02:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbgLJBed (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Dec 2020 20:34:33 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:10640 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726263AbgLJBed (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Dec 2020 20:34:33 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BA1Oki6026355
        for <bpf@vger.kernel.org>; Wed, 9 Dec 2020 17:33:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=SrYTVEVuJ1J0Mj0dbctu3z2rcFILerd0vGUQnf60cK4=;
 b=fOlnNqK0gPd4hN58bG+8hGV1xlOlpYtzwrzH28oJT6m7ahZI/dSxH7UK/AsD3wDd6Bm4
 p1QYXi34YHtGDLMP1tC2s8yiuM4Bh5/3h719b6VnDoiYFPxMtw3B8v6ejGRwI2tw6UT7
 u8bGrUwSZf1FzJrr1ckIVkvBckdvNQpWPHM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 35avdh5dg5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 09 Dec 2020 17:33:52 -0800
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 9 Dec 2020 17:33:51 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id F055037053FB; Wed,  9 Dec 2020 17:33:48 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 0/2] bpf: permits pointers on stack for helper calls
Date:   Wed, 9 Dec 2020 17:33:48 -0800
Message-ID: <20201210013348.943623-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-09_19:2020-12-09,2020-12-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=767 lowpriorityscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 suspectscore=13 adultscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012100009
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch permits pointers on stack for helper calls if permission is
granted. Patch #1 described the detailed usecase and Patch #2
added a test.

Changelog:
  v1 -> v2:
    - fix a verifier test failure due to verifier change.

Yonghong Song (2):
  bpf: permits pointers on stack for helper calls
  selftests/bpf: add a test for ptr_to_map_value on stack for helper
    access

 kernel/bpf/verifier.c                             | 3 ++-
 tools/testing/selftests/bpf/progs/bpf_iter_task.c | 3 ++-
 tools/testing/selftests/bpf/verifier/unpriv.c     | 5 +++--
 3 files changed, 7 insertions(+), 4 deletions(-)

--=20
2.24.1

