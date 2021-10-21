Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A318436B9A
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 21:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbhJUT6z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 15:58:55 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:1594 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231579AbhJUT6w (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 21 Oct 2021 15:58:52 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19LJatZa028608
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 12:56:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=BP6LIiCCv0jfw5OL+AqNBC62jkKGn+r/qcJ9ImnHuZw=;
 b=gr3p8dLgDlycIf/9dZAyXu2sIg8OmwNXyr+RIQJFX2af/y6J1bQKrdhKQzBOE/IOakxk
 BmXbks9dGYjvirofHZbeSpXz7/ak+xi8DAqBYoIosWjjAyrWxn0hJDViYnYnRPH459vH
 ZLZM4o6AhxMU0gvEX4xbK7GaSCZsWyYQaD4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bu90qbmvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 12:56:35 -0700
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 21 Oct 2021 12:56:34 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id ED79815167FF; Thu, 21 Oct 2021 12:56:22 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 0/5] bpf: add support for BTF_KIND_DECL_TAG typedef
Date:   Thu, 21 Oct 2021 12:56:22 -0700
Message-ID: <20211021195622.4018339-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: KyNGo_rVApDtyhJiqjSItnW41gE5Vji-
X-Proofpoint-ORIG-GUID: KyNGo_rVApDtyhJiqjSItnW41gE5Vji-
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-21_05,2021-10-21_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 mlxscore=0
 mlxlogscore=762 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110210101
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Latest upstream llvm-project added support for btf_decl_tag attributes
for typedef declarations ([1], [2]). Similar to other btf_decl_tag cases,
func/func_param/global_var/struct/union/field, btf_decl_tag with typedef
declaration can carry information from kernel source to clang compiler
and then to dwarf/BTF, for bpf verification or other use cases.

This patch set added kernel support for BTF_KIND_DECL_TAG to typedef
declaration (Patch 1). Additional selftests are added to cover
unit testing, dedup, or bpf program usage of btf_decl_tag with typedef.
(Patches 2, 3 and 4). The btf documentation is updated to include
BTF_KIND_DECL_TAG typedef (Patch 5).

  [1] https://reviews.llvm.org/D110127
  [2] https://reviews.llvm.org/D112259

Yonghong Song (5):
  bpf: add BTF_KIND_DECL_TAG typedef support
  selftests/bpf: add BTF_KIND_DECL_TAG typedef unit tests
  selftests/bpf: test deduplication for BTF_KIND_DECL_TAG typedef
  selftests/bpf: add BTF_KIND_DECL_TAG typedef example in tag.c
  docs/bpf: update documentation for BTF_KIND_DECL_TAG typedef support

 Documentation/bpf/btf.rst                    |  6 +-
 kernel/bpf/btf.c                             |  4 +-
 tools/testing/selftests/bpf/prog_tests/btf.c | 83 ++++++++++++++++++--
 tools/testing/selftests/bpf/progs/tag.c      |  9 ++-
 4 files changed, 89 insertions(+), 13 deletions(-)

--=20
2.30.2

