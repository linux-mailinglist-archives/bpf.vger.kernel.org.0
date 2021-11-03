Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA0C44472D
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 18:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhKCRfR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 3 Nov 2021 13:35:17 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36310 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229885AbhKCRfQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Nov 2021 13:35:16 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1A3H58rj003838
        for <bpf@vger.kernel.org>; Wed, 3 Nov 2021 10:32:39 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3c3ves1b68-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 03 Nov 2021 10:32:39 -0700
Received: from intmgw002.48.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 3 Nov 2021 10:32:30 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 5499B7D15DB8; Wed,  3 Nov 2021 10:32:19 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 0/5] libbpf ELF sanity checking improvements
Date:   Wed, 3 Nov 2021 10:32:08 -0700
Message-ID: <20211103173213.1376990-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: SmXNWFraKziCghSIhq9cXyIGyicuSzyT
X-Proofpoint-ORIG-GUID: SmXNWFraKziCghSIhq9cXyIGyicuSzyT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-03_06,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 mlxlogscore=883 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111030094
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Few patches fixing various issues discovered by oss-fuzz project fuzzing
bpf_object__open() call. Fixes are mostly focused around additional simple
sanity checks of ELF format: symbols, relos, etc.

v1->v2:
  - address Yonghong's feedback.

Andrii Nakryiko (5):
  libbpf: detect corrupted ELF symbols section
  libbpf: improve sanity checking during BTF fix up
  libbpf: validate that .BTF and .BTF.ext sections contain data
  libbpf: fix section counting logic
  libbpf: improve ELF relo sanitization

 tools/lib/bpf/libbpf.c | 43 +++++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 13 deletions(-)

-- 
2.30.2

