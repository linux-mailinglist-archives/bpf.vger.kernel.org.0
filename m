Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4557B43D739
	for <lists+bpf@lfdr.de>; Thu, 28 Oct 2021 01:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhJ0XLG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Oct 2021 19:11:06 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:18076 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230232AbhJ0XLF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 27 Oct 2021 19:11:05 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 19RLfcoS002506
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 16:08:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=aksdkqbwAFBUpoB48tO4rmlG4MOyRmEF4AdIY8iL+i4=;
 b=M0/OUL6fhp/KUKCu/CXE6WwlaBLD2mI9hK24aa49v84KxkAw8Bjiexu1Nb8MJGtxJF4p
 sDvEVSk5R3UN2oKKPOJJABvmhs1Bm1K5WUaejMPKZRgTp4EYJwOTkQxhG9dgW6rd01RE
 SMmkEBH8yiS4EEpmGNEYXW1cfiCQSlX6TSA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3by7psws7c-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 16:08:39 -0700
Received: from intmgw006.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 27 Oct 2021 16:08:38 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 7AD3519948C3; Wed, 27 Oct 2021 16:08:22 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH dwarves 0/2] btf: support typedef DW_TAG_LLVM_annotation
Date:   Wed, 27 Oct 2021 16:08:22 -0700
Message-ID: <20211027230822.2465100-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: EpfEBiJd1qDERBBURxySQm3OjAtoO9eK
X-Proofpoint-ORIG-GUID: EpfEBiJd1qDERBBURxySQm3OjAtoO9eK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-27_06,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=402 lowpriorityscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2110270128
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Latest llvm is able to generate DW_TAG_LLVM_annotation for typedef
declarations. Latest bpf-next supports BTF_KIND_DECL_TAG for
typedef declarations. This patch implemented dwarf DW_TAG_LLVM_annotation
to btf BTF_KIND_DECL_TAG conversion. Patch 1 is for dwarf_loader
to process DW_TAG_LLVM_annotation tags. Patch 2 is for the
dwarf->btf conversion.

Yonghong Song (2):
  dwarf_loader: support typedef DW_TAG_LLVM_annotation
  btf_encoder: generate BTF_KIND_DECL_TAGs for typedef btf_decl_tag
    attributes

 btf_encoder.c  | 12 +++++++++---
 dwarf_loader.c |  7 ++-----
 2 files changed, 11 insertions(+), 8 deletions(-)

--=20
2.30.2

