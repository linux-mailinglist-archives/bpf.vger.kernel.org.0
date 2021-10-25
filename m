Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F6F43A6A5
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 00:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbhJYWgU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 18:36:20 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:21794 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233933AbhJYWgR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Oct 2021 18:36:17 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19PMGNIb017412
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 15:33:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=WIIT3c+YRWh6w59RbFWoGF5RVsv8sLsREG67zb3Ll/4=;
 b=Fx8LOD4/2PERmGQQllCnisZC2qh8qHR6SWJrDslPKos8Ed+q89+bSfYmYusG+qbEylZs
 46EG0MiuTdDuX8H6TwFeKnGezEfEC0IdOXhtRdI+eEG9qpvip9dJYXCSxCQJzr/MAsBH
 Id/DvAcMGfjQEAjwE9y1kGKWdl/eb5OQc/Q= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bx4gn8dcb-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 15:33:54 -0700
Received: from intmgw001.05.prn6.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 25 Oct 2021 15:33:52 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id 350C75DB8D3A; Mon, 25 Oct 2021 15:33:46 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, Yucong Sun <fallentree@fb.com>
Subject: [PATCH bpf-next 0/4] selftests/bpf: parallel mode improvement
Date:   Mon, 25 Oct 2021 15:33:41 -0700
Message-ID: <20211025223345.2136168-1-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: lKQ5AVwWKc0xwQy0f-40ZOTtQUkvTIpl
X-Proofpoint-ORIG-GUID: lKQ5AVwWKc0xwQy0f-40ZOTtQUkvTIpl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_07,2021-10-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=709 phishscore=0
 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2110250127
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Several patches to improve parallel execution mode, including printing
subtest status line, updating vmtest.sh and fixed two previously dropped
patch according to feedback.


Yucong Sun (4):
  selfetests/bpf: Update vmtest.sh defaults
  selftests/bpf: print subtest status line
  selftests/bpf: fix attach_probe in parallel mode
  selftests/bpf: adding a namespace reset for tc_redirect

 .../selftests/bpf/prog_tests/attach_probe.c   |  9 ++-
 .../selftests/bpf/prog_tests/tc_redirect.c    | 14 +++++
 tools/testing/selftests/bpf/test_progs.c      | 56 +++++++++++++++----
 tools/testing/selftests/bpf/test_progs.h      |  4 ++
 tools/testing/selftests/bpf/vmtest.sh         |  6 +-
 5 files changed, 74 insertions(+), 15 deletions(-)

--=20
2.30.2

