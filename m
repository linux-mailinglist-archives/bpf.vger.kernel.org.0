Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F78744E22B
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 08:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbhKLHEo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Nov 2021 02:04:44 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:22934 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230259AbhKLHEo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 12 Nov 2021 02:04:44 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1AC5TOME003525
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 23:01:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=v88wNH+SO7MKD6P1/lFZoe4stJ84ryDclqwta/Kju40=;
 b=J/ke9Elyl7vuxBhT6XMmqVfEUeuWTKZtpO9K3m5TdbtZN1biBXDZZbpFEhyv/MDb3AI3
 xmll0DuhAsMukOYpEJCbK0ScdwCXP5JKH4L/tE4Jcrx0SddNrjj8FhykYPIh9CUOFv8G
 eExvb9ID6ged8A26kwgtVQM61UfDN0ujRFQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3c9brfjqvu-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 23:01:53 -0800
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 11 Nov 2021 23:01:49 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 40D0B1F8ACEA0; Thu, 11 Nov 2021 23:01:45 -0800 (PST)
From:   Song Liu <songliubraving@fb.com>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kernel-team@fb.com>, Song Liu <songliubraving@fb.com>
Subject: [PATCH v2 bpf-next 0/2] introduce btf_tracing_ids
Date:   Thu, 11 Nov 2021 23:01:29 -0800
Message-ID: <20211112070131.3131449-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: bpJBGby-zfAW1zqBsUh1-d7ntnL9SyFc
X-Proofpoint-GUID: bpJBGby-zfAW1zqBsUh1-d7ntnL9SyFc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-12_02,2021-11-11_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 mlxlogscore=391 phishscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111120037
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Changes v1 =3D> v2:
1. Add patch 2/2. (Alexei)

1/2 fixes issue with btf_task_struct_ids w/o CONFIG_DEBUG_INFO_BTF.
2/2 replaces btf_task_struct_ids with easier to understand btf_tracing_id=
s.

Song Liu (2):
  bpf: extend BTF_ID_LIST_GLOBAL with parameter for number of IDs
  bpf: introduce btf_tracing_ids

 include/linux/btf_ids.h       | 20 ++++++++++++++++----
 kernel/bpf/bpf_task_storage.c |  4 ++--
 kernel/bpf/btf.c              |  8 ++++----
 kernel/bpf/stackmap.c         |  2 +-
 kernel/bpf/task_iter.c        | 12 ++++++------
 kernel/bpf/verifier.c         |  2 +-
 kernel/trace/bpf_trace.c      |  4 ++--
 net/core/filter.c             |  6 +-----
 8 files changed, 33 insertions(+), 25 deletions(-)

--
2.30.2
