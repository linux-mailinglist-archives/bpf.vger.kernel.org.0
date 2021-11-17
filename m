Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7CC454E7D
	for <lists+bpf@lfdr.de>; Wed, 17 Nov 2021 21:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239548AbhKQUZU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Nov 2021 15:25:20 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36564 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234385AbhKQUZU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 17 Nov 2021 15:25:20 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AHJtxHf006600
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 12:22:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=Zp0Gf8ZNbrE5NlUxP487cDri93l4JpDQ2k5yjUTsX64=;
 b=lbxPLogDCWKUl5+dK+pUJEYbJr4FHE+nsbyBrc03DF3GB/ulZcYgO9tMqo3w/jW8R6qO
 HpEjDCIVO8USf+WfM0jcRn1CXcCJ1HyAVN/yaQiGqHZq3kZ2Djxa82GFCWaa0I2zQRnM
 +Vi1m5Mmz5mD67/LdRWn4gij0meTd9Gr0wE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3ccyjw44uj-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 12:22:21 -0800
Received: from intmgw002.06.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 17 Nov 2021 12:22:17 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 3379028FBA11; Wed, 17 Nov 2021 12:22:14 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH dwarves 0/4] btf: support btf_type_tag attribute
Date:   Wed, 17 Nov 2021 12:22:14 -0800
Message-ID: <20211117202214.3268824-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: omRdDYuZK4p8BAYEmTTxB9DBwuTtCMLC
X-Proofpoint-GUID: omRdDYuZK4p8BAYEmTTxB9DBwuTtCMLC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_07,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 mlxlogscore=726 mlxscore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111170091
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

btf_type_tag is a new llvm type attribute which is used similar
to kernel __user/__rcu attributes. The format of btf_type_tag looks like
  __attribute__((btf_type_tag("tag1")))
For the case where the attribute applied to a pointee like
  #define __tag1 __attribute__((btf_type_tag("tag1")))
  #define __tag2 __attribute__((btf_type_tag("tag2")))
  int __tag1 * __tag1 __tag2 *g;
the information will be encoded in dwarf.

In BTF, the attribute is encoded as a new kind
BTF_KIND_TYPE_TAG and latest bpf-next supports it.

The patch added support in pahole, specifically
converts llvm dwarf btf_type_tag attributes to
BTF types. Please see individual patches for details.

Yonghong Song (4):
  libbpf: sync with latest libbpf repo
  dutil: move DW_TAG_LLVM_annotation definition to dutil.h
  dwarf_loader: support btf_type_tag attribute
  btf_encoder: support btf_type_tag attribute

 btf_encoder.c  |   7 +++
 dutil.h        |   4 ++
 dwarf_loader.c | 120 ++++++++++++++++++++++++++++++++++++++++++++++---
 dwarves.h      |  38 +++++++++++++++-
 lib/bpf        |   2 +-
 pahole.c       |   8 ++++
 6 files changed, 170 insertions(+), 9 deletions(-)

--=20
2.30.2

