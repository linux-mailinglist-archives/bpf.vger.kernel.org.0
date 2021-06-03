Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13CE399705
	for <lists+bpf@lfdr.de>; Thu,  3 Jun 2021 02:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhFCAmR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 2 Jun 2021 20:42:17 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:26724 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229635AbhFCAmR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 2 Jun 2021 20:42:17 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 1530eGKb025764
        for <bpf@vger.kernel.org>; Wed, 2 Jun 2021 17:40:32 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 38xby4bhpv-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 02 Jun 2021 17:40:32 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:40:30 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id D0CCB2EDE105; Wed,  2 Jun 2021 17:40:28 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 0/4] Few small libbpf and selftests/bpf fixes
Date:   Wed, 2 Jun 2021 17:40:22 -0700
Message-ID: <20210603004026.2698513-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: xvN9rO6O1dLr4x6vl0dydHJpetA8Z8sc
X-Proofpoint-GUID: xvN9rO6O1dLr4x6vl0dydHJpetA8Z8sc
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-02_11:2021-06-02,2021-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 spamscore=0 clxscore=1015
 bulkscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106030002
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix few small issues in libbpf and selftests/bpf:
  - fix up libbpf.map and move few APIs that didn't make it into final 0.4
    release;
  - install skel_internal.h which is used by light skeleton;
  - fix .gitignore for xdp_redirect_multi.

Andrii Nakryiko (4):
  libbpf: move few APIs from 0.4 to 0.5 version
  libbpf: refactor header installation portions of Makefile
  libbpf: install skel_internal.h header used from light skeletons
  selftests/bpf: add xdp_redirect_multi into .gitignore

 tools/lib/bpf/Makefile                 | 19 +++++++------------
 tools/lib/bpf/libbpf.map               |  6 +++---
 tools/testing/selftests/bpf/.gitignore |  1 +
 3 files changed, 11 insertions(+), 15 deletions(-)

-- 
2.30.2

