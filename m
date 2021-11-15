Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5264509D0
	for <lists+bpf@lfdr.de>; Mon, 15 Nov 2021 17:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhKOQmw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Nov 2021 11:42:52 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:61778 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230132AbhKOQmq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 15 Nov 2021 11:42:46 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AFDtL0k016654
        for <bpf@vger.kernel.org>; Mon, 15 Nov 2021 08:39:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=F2/SBa+d669ztRzLRiGISCT+aEp/Ts/vF0cfvMcek6M=;
 b=ft4XI3u8Q+une9QKy+1YHaXz2XwB4kPrhcA+6JPOfxbUh+5PCnbf/gctqvPbw3L3ujlK
 ps1KcaBQ/kOfQ03Dl12x7cSLqT4eakou1fuzZiS4xYRuIiJLgu+KQLZbLdjzm1yBP8LW
 /vdA05M2iI1A2ii+G7zi5A/Vpdhx52oVqF0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cb5yuwtcv-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 15 Nov 2021 08:39:43 -0800
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 15 Nov 2021 08:39:42 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 9772627673D0; Mon, 15 Nov 2021 08:39:32 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 0/2] bpf: fix a couple of missed btf_type_tag handling in libbpf
Date:   Mon, 15 Nov 2021 08:39:32 -0800
Message-ID: <20211115163932.3921753-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: Pfzw3D9p6XU1QamSMyqsopohBw1vCcRp
X-Proofpoint-GUID: Pfzw3D9p6XU1QamSMyqsopohBw1vCcRp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-15_10,2021-11-15_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=835 suspectscore=0 clxscore=1015 mlxscore=0
 adultscore=0 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111150086
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 2dc1e488e5cd ("libbpf: Support BTF_KIND_TYPE_TAG") added
BTF_KIND_TYPE_TAG support. But BTF_KIND_TYPE_TAG is not handled
properly in libbpf btf_dedup_is_equiv() which will cause pahole dedup
failure if the kernel has the following hack:
  #define __user __attribute__((btf_type_tag("user")))

Patch 1 fixed the issue and Patch 2 added a test for it.

Yonghong Song (2):
  libbpf: fix a couple of missed btf_type_tag handling in btf.c
  selftests/bpf: add a dedup selftest with equivalent structure types

 tools/lib/bpf/btf.c                          |  2 ++
 tools/testing/selftests/bpf/prog_tests/btf.c | 26 ++++++++++++++++++++
 2 files changed, 28 insertions(+)

--=20
2.30.2

