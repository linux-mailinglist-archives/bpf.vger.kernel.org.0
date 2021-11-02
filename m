Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810AE4439D1
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 00:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhKBXhi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Nov 2021 19:37:38 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:8740 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231359AbhKBXhh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 2 Nov 2021 19:37:37 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A2LbOo5021779
        for <bpf@vger.kernel.org>; Tue, 2 Nov 2021 16:35:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=RDMj3ZlvXpQa1DLCCkqULWVZ6BOQR+3V5qyAB0YQ+fw=;
 b=GWP4215SVuTt013Wuj8vyNW+0fZTVrgSYCNryFPZak0uWpdbwOMIpRmdz0iQrOKFWEf2
 oTUbcSFXwcUhw9PSbJJX1ZjvKEFU38VNY6hM6J8DHDKyZSIQzGpjzaxM+g/cO551Ryzm
 ogsscCczcz4ERzox2VrPySBCu+VEy4xQhL0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c3ddbrs0j-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 02 Nov 2021 16:35:01 -0700
Received: from intmgw001.05.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 2 Nov 2021 16:35:00 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 2BB311DE800F; Tue,  2 Nov 2021 16:35:00 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH dwarves v2 0/2] btf: support typedef DW_TAG_LLVM_annotation
Date:   Tue, 2 Nov 2021 16:35:00 -0700
Message-ID: <20211102233500.1024582-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: MW5-pEeEow1EzGvBmEUCrRQVchtDEF0v
X-Proofpoint-ORIG-GUID: MW5-pEeEow1EzGvBmEUCrRQVchtDEF0v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-02_08,2021-11-02_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 mlxlogscore=480 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111020122
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

Changelog:
  v1 -> v2:
   - change some "if" statements to "switch" statement.

Yonghong Song (2):
  dwarf_loader: support typedef DW_TAG_LLVM_annotation
  btf_encoder: generate BTF_KIND_DECL_TAGs for typedef btf_decl_tag
    attributes

 btf_encoder.c  | 17 ++++++++++++++---
 dwarf_loader.c |  7 ++-----
 2 files changed, 16 insertions(+), 8 deletions(-)

--=20
2.30.2

