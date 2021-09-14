Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3DAF40A2CF
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 03:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbhINBtI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 13 Sep 2021 21:49:08 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33208 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236804AbhINBtD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Sep 2021 21:49:03 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18E1K1lE002681
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 18:47:47 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b2hyqg3en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 18:47:47 -0700
Received: from intmgw001.27.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 13 Sep 2021 18:47:44 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 0668E3F9D7B1; Mon, 13 Sep 2021 18:47:34 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 0/4] libbpf: Streamline internal BPF program sections handling
Date:   Mon, 13 Sep 2021 18:47:29 -0700
Message-ID: <20210914014733.2768-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: fSdhlhv8pw77wjEzCJPwwi_DAksa-iO5
X-Proofpoint-ORIG-GUID: fSdhlhv8pw77wjEzCJPwwi_DAksa-iO5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-13_09,2021-09-09_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1034
 lowpriorityscore=0 bulkscore=0 mlxlogscore=525 mlxscore=0 suspectscore=0
 phishscore=0 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140009
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This small patch set performs internal refactorings around libbpf BPF program
ELF section definitions' handling. This is preparatory changes for further
changes around making libbpf BPF program section handling more strict but also
pluggable and customizable, as part of the libbpf 1.0 effort. See individual
patches for details.

Andrii Nakryiko (4):
  selftests/bpf: update selftests to always provide "struct_ops" SEC
  libbpf: ensure BPF prog types are set before relocations
  libbpf: simplify BPF program auto-attach code
  libbpf: minimize explicit iterator of section definition array

 tools/lib/bpf/libbpf.c                        | 200 ++++++++----------
 tools/testing/selftests/bpf/progs/bpf_cubic.c |  12 +-
 2 files changed, 95 insertions(+), 117 deletions(-)

-- 
2.30.2

