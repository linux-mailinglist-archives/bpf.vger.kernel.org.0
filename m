Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D2844059A
	for <lists+bpf@lfdr.de>; Sat, 30 Oct 2021 00:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbhJ2WwV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Oct 2021 18:52:21 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41780 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231563AbhJ2WwV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 29 Oct 2021 18:52:21 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19TMhemu013940
        for <bpf@vger.kernel.org>; Fri, 29 Oct 2021 15:49:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=0oI2BEPa7tlL7uGSe/wGxDU6GuOcCGfmylt1qAZvEEI=;
 b=lTFkOAA04CgtYw515p5IKht+ruKMyryJVvCt3+/th/VMpvy7cX2TG0TCsQgU2ZN0HPYf
 LjQzDI2kwt3CkF/ZLTzzSU6aq2jfemvdcYm35jsVWICoNWatkdoyoTdtMuo/skqh9Bsv
 pmmVhWZ/0h6IgjEdfCeOvYcBJqYEYU0eZp8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c0edjp4fq-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 29 Oct 2021 15:49:51 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 29 Oct 2021 15:49:43 -0700
Received: by devbig612.frc2.facebook.com (Postfix, from userid 115148)
        id 5AB764373048; Fri, 29 Oct 2021 15:49:36 -0700 (PDT)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kafai@fb.com>, <Kernel-team@fb.com>, <yhs@fb.com>,
        Joanne Koong <joannekoong@fb.com>
Subject: [PATCH bpf-next 0/3] "map_extra" and bloom filter fixups
Date:   Fri, 29 Oct 2021 15:49:06 -0700
Message-ID: <20211029224909.1721024-1-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: HUp13CrrMuRg1aXK5bV5ORgP4riThfIK
X-Proofpoint-GUID: HUp13CrrMuRg1aXK5bV5ORgP4riThfIK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-29_06,2021-10-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 impostorscore=0 mlxscore=0 phishscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxlogscore=751 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2110290127
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There are 3 patches in this patchset:

1/3 - Bloom filter naming fixups (kernel/bpf/bloom_filter.c)

2/3 - Add alignment padding for map_extra, rearrange fields in
bpf_map struct to consolidate holes

3/3 - Bloom filter tests (prog_tests/bloom_filter_map):
Add test for successful userspace calls, some refactoring to
use bpf_create_map instead of bpf_create_map_xattr

v1 -> v2:
    * In prog_tests/bloom_filter_map: remove unneeded line break,
	also change the inner_map_test to use bpf_create_map instead
	of bpf_create_map_xattr.
    * Add acked-bys to commit messages

Joanne Koong (3):
  bpf: Bloom filter map naming fixups
  bpf: Add alignment padding for "map_extra" + consolidate holes
  selftests/bpf: Add bloom map success test for userspace calls

 include/linux/bpf.h                           |  6 +-
 include/uapi/linux/bpf.h                      |  1 +
 kernel/bpf/bloom_filter.c                     | 49 +++++++--------
 tools/include/uapi/linux/bpf.h                |  1 +
 .../bpf/prog_tests/bloom_filter_map.c         | 59 +++++++++++--------
 5 files changed, 64 insertions(+), 52 deletions(-)

--=20
2.30.2

