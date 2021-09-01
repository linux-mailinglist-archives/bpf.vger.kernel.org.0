Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFEE3FE344
	for <lists+bpf@lfdr.de>; Wed,  1 Sep 2021 21:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343495AbhIATpt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Sep 2021 15:45:49 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51700 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344065AbhIATps (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 1 Sep 2021 15:45:48 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 181JeKwV012639
        for <bpf@vger.kernel.org>; Wed, 1 Sep 2021 12:44:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=nKzOPfD528QlaHHJ5kaCxOiXUNj/fftSjm33cSHW0d8=;
 b=fT9BL8QgDOxy4ulVcl2/jl0KCb0FqMNcMVssGo5OM+NYUj1/4reLAzcjLzwDf2fPL1E7
 vi9DjAAYcIg6+cWASge/TPDZ7c/Zkc1P+vnehIIIJaUY3Mz2c30rCa/fJpM/rA7auJU+
 cLd6hTgSq+b6DEC7sC2KEi8FHA5Im59tSk4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3atdwtu35m-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 01 Sep 2021 12:44:50 -0700
Received: from intmgw001.05.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 1 Sep 2021 12:44:49 -0700
Received: by devvm3431.ftw0.facebook.com (Postfix, from userid 239838)
        id 8612A9CDE3E1; Wed,  1 Sep 2021 12:44:42 -0700 (PDT)
From:   Matt Smith <alastorze@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andriin@kernel.org>,
        <daniel@iogearbox.net>, <kernel-team@fb.com>
CC:     Matt Smith <alastorze@fb.com>
Subject: [PATCH v2 bpf-next 0/3] Bpf skeleton helper method
Date:   Wed, 1 Sep 2021 12:44:36 -0700
Message-ID: <20210901194439.3853238-1-alastorze@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: srDjmHWH9F-2LOEh2e2-dXc-4IZF8wCl
X-Proofpoint-ORIG-GUID: srDjmHWH9F-2LOEh2e2-dXc-4IZF8wCl
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-01_05:2021-09-01,2021-09-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 mlxlogscore=848 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109010114
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch series changes the type of bpf_object_skeleton->data
to const void * and provides a helper method X__elf_bytes(size_t *sz)
for accessing the raw binary data of the compiled embedded BPF object.

The type change enforces the previously implied behavior of immutability
for this field while casting it to (void *) before assignment allows
for compiling with previous versions of the libbpf headers without
compiler warnings.

The helper method allows easier access to the BPF binary object data
and is leveraged to populate the skeleton field.  The inclusion of
this helper method will allow users to get access to the data without
needing to populate an entire skeleton first.

Checks are added in the third patch to validate the behavior of the
added method

Matt Smith (3):
  libbpf: Change bpf_object_skelecton data field to const void*
  bpftool: Provide a helper method for accessing bpf binary data
  selftests/bpf: Add checks for X__elf_bytes skeleton helper

 tools/bpf/bpftool/gen.c                       | 39 ++++++++++++-------
 tools/lib/bpf/libbpf.h                        |  2 +-
 .../selftests/bpf/prog_tests/skeleton.c       |  7 ++++
 3 files changed, 32 insertions(+), 16 deletions(-)

--=20
2.30.2

