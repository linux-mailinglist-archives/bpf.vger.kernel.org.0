Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C106410E06
	for <lists+bpf@lfdr.de>; Mon, 20 Sep 2021 02:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbhITAhT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Sep 2021 20:37:19 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:11092 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229794AbhITAhT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 19 Sep 2021 20:37:19 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18JMkSU0005523
        for <bpf@vger.kernel.org>; Sun, 19 Sep 2021 17:35:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=KjyKc9CCDhvhh5QMDK9Sr1AbHxa7uN7/WC7WTvvbHzs=;
 b=DTDVlkvMV0i0bGsTe2oL/2H1QbL/ATAGVlmRYFjYb+GNb+w4sogVPmLNQnzCxXEye8AF
 jK1rz4ElzLEylzoga4c/30TPSUKmbpj+m0yOUvoj+EZMqz3TmOYZf2+WY6uUtWkjY4Nn
 HI5x5Fv1bgmnIh1tzVw9WJp3wA1fs4KuWx4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b5fe8x3st-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 19 Sep 2021 17:35:53 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Sun, 19 Sep 2021 17:35:50 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 18AAE7713252; Sun, 19 Sep 2021 17:35:45 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH dwarves 0/2] generate BTF_KIND_TAG types from DW_TAG_LLVM_annotation dwarf tags
Date:   Sun, 19 Sep 2021 17:35:45 -0700
Message-ID: <20210920003545.3524231-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: VC3KK4DcnSK4KeD078h8SINLoaUVUmJt
X-Proofpoint-ORIG-GUID: VC3KK4DcnSK4KeD078h8SINLoaUVUmJt
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-19_07,2021-09-17_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 mlxlogscore=598 malwarescore=0 clxscore=1015 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109200001
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

Patch 1 enhanced dwarf_loader to encode DW_TAG_LLVM_annotation
tags into internal data structure and Patch 2 will encode
such information to BTF with BTF_KIND_TAGs.

 [1] https://reviews.llvm.org/D106614

Yonghong Song (2):
  dwarf_loader: parse dwarf tag DW_TAG_LLVM_annotation
  btf_encoder: generate BTF_KIND_TAG from llvm annotations

 btf_encoder.c  | 45 ++++++++++++++++++++++++++
 dwarf_loader.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++----
 dwarves.h      | 10 ++++++
 pahole.c       |  8 +++++
 4 files changed, 142 insertions(+), 6 deletions(-)

--=20
2.30.2

