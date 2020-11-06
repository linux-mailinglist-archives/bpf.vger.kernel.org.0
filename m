Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418D52A8EDA
	for <lists+bpf@lfdr.de>; Fri,  6 Nov 2020 06:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbgKFFZy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 6 Nov 2020 00:25:54 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:6786 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725835AbgKFFZy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 6 Nov 2020 00:25:54 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A65OAtB001456
        for <bpf@vger.kernel.org>; Thu, 5 Nov 2020 21:25:53 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34mx9p8e64-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2020 21:25:53 -0800
Received: from intmgw003.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 5 Nov 2020 21:25:52 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 5DC732EC8EF6; Thu,  5 Nov 2020 21:25:51 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <dwarves@vger.kernel.org>, <acme@kernel.org>, <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH dwarves 0/4] Add split BTF support to pahole
Date:   Thu, 5 Nov 2020 21:25:45 -0800
Message-ID: <20201106052549.3782099-1-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_01:2020-11-05,2020-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 malwarescore=0 impostorscore=0 mlxscore=0
 mlxlogscore=677 suspectscore=8 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011060037
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add ability to generate split BTF (for kernel modules), as well as load split
BTF. --btf_base argument is added to specify base BTF for split BTF. This
works for both btf_loader and btf_encoder.

Andrii Nakryiko (4):
  btf_encoder: fix array index type numbering
  libbtf: improve variable naming and error reporting when writing out
    BTF
  libbpf: update libbpf submodlue reference to latest master
  btf: add support for split BTF loading and encoding

 btf_encoder.c | 15 ++++++++-------
 btf_loader.c  |  2 +-
 lib/bpf       |  2 +-
 libbtf.c      | 43 +++++++++++++++++++++++++++----------------
 libbtf.h      |  4 +++-
 pahole.c      | 23 +++++++++++++++++++++++
 6 files changed, 63 insertions(+), 26 deletions(-)

-- 
2.24.1

