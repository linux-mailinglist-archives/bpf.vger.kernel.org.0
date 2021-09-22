Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDEB3413F4A
	for <lists+bpf@lfdr.de>; Wed, 22 Sep 2021 04:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhIVCPD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Sep 2021 22:15:03 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54712 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229693AbhIVCPD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 Sep 2021 22:15:03 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LLHDiY030023
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 19:13:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=PeDNCnYFitH+YCnO9TBfSC89dObIlrQAqmBLoGkQ64M=;
 b=GOAFceJl8Xu9RL9Qe3KDVCjcduKbAFk3RkolnU40fzi6NjfCkCqR7m+iVAiTMEGHxoNp
 wECZgEsxQ4eD853nKgvUSFTuz1dOHRRtI/z/JN5zMS6ZnXrJbrN7eJpNTrEEqSL1fnjS
 4I+kEP82B4FVRLZ4Xp3irRAhMd7ECGfm+DE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b7q5wsh9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 19:13:33 -0700
Received: from intmgw001.05.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 21 Sep 2021 19:13:32 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id B2DDE24E20A; Tue, 21 Sep 2021 19:13:21 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH dwarves v2 0/2] generate BTF_KIND_TAG types from DW_TAG_LLVM_annotation dwarf tags
Date:   Tue, 21 Sep 2021 19:13:21 -0700
Message-ID: <20210922021321.2286360-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 82krZ8UL7M9ZC4_EI1Cd0ipp5zX9bBX0
X-Proofpoint-GUID: 82krZ8UL7M9ZC4_EI1Cd0ipp5zX9bBX0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-21_07,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 phishscore=0 clxscore=1015 mlxlogscore=641 impostorscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109220013
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

LLVM has implemented btf_tag attribute ([1]) which intended
to provide a "string" tag for struct/union or its member, var,
a func or its parameter. Such a "string" tag will be encoded
in dwarf. For non-BPF target like x86_64, pahole needs to
convert those dwarf btf_tag annotations to BTF so kernel
can utilize these "string" tags for bpf program verification, etc.
=20=20=20=20=20=20=20=20
Patch 1 enhanced dwarf_loader to encode DW_TAG_LLVM_annotation
tags into internal data structure and Patch 2 will encode
such information to BTF with BTF_KIND_TAGs.

 [1] https://reviews.llvm.org/D106614

Changelog:
  v1 -> v2:
    - handle returning error cases for btf_encoder__add_tag().

Yonghong Song (2):
  dwarf_loader: parse dwarf tag DW_TAG_LLVM_annotation
  btf_encoder: generate BTF_KIND_TAG from llvm annotations

 btf_encoder.c  | 63 ++++++++++++++++++++++++++++++++++++-
 dwarf_loader.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++----
 dwarves.h      | 10 ++++++
 pahole.c       |  8 +++++
 4 files changed, 159 insertions(+), 7 deletions(-)

--=20
2.30.2

