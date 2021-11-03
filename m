Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B66443A46
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 01:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbhKCAMs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 2 Nov 2021 20:12:48 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52736 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232308AbhKCAMr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 2 Nov 2021 20:12:47 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A2Lar9V019210
        for <bpf@vger.kernel.org>; Tue, 2 Nov 2021 17:10:11 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c3ddbryb6-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 02 Nov 2021 17:10:11 -0700
Received: from intmgw002.48.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 2 Nov 2021 17:10:08 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id EDE687C14DA3; Tue,  2 Nov 2021 17:10:04 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 0/5] libbpf ELF sanity checking improvements
Date:   Tue, 2 Nov 2021 17:09:58 -0700
Message-ID: <20211103001003.398812-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: P4BHKLKrCU_5g62JEcS7_QIfypoITkOJ
X-Proofpoint-ORIG-GUID: P4BHKLKrCU_5g62JEcS7_QIfypoITkOJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-02_08,2021-11-02_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 mlxlogscore=766 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111020125
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Few patches fixing various issues discovered by oss-fuzz project fuzzing
bpf_object__open() call. Fixes are mostly focused around additional simple
sanity checks of ELF format: symbols, relos, section indices.

Andrii Nakryiko (5):
  libbpf: detect corrupted ELF symbols section
  libbpf: improve sanity checking during BTF fix up
  libbpf: validate that .BTF and .BTF.ext sections contain data
  libbpf: fix section counting logic
  libbpf: improve ELF relo sanitization

 tools/lib/bpf/libbpf.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

-- 
2.30.2

