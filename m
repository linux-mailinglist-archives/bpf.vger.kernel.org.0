Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F001D24F0
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 03:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbgENBu5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 May 2020 21:50:57 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:8314 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725925AbgENBu5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 13 May 2020 21:50:57 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04E1ou2k006254
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 18:50:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=fDCRrSXe+0hgnfwobrJ58sh0nZoT5HAkHpjewg/Hodg=;
 b=aW9E4C69H5+o050c3fXep4Tap7ng7ud3ON1qUT3rCvDaPU4o3ni0/I3n/iGiv0FjoLON
 BTDdsgAYaUAWNF3JEOKH5oZ1azHLgcaG9v+BXZ7VaaSvbpcpMlkJQ5QQKkEAgDS7Pnxg
 Ppb6o5DSxXEKJrmy7OiiZngcbMWuWl5HbaY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3100y1rmrn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 18:50:56 -0700
Received: from intmgw001.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 13 May 2020 18:50:47 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 5112D3700963; Wed, 13 May 2020 18:50:43 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 0/2] bpf: Narrow loads for bpf_sock_addr.user_port
Date:   Wed, 13 May 2020 18:50:26 -0700
Message-ID: <cover.1589420814.git.rdna@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-13_09:2020-05-13,2020-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=13 phishscore=0 cotscore=-2147483648 mlxscore=0 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=589 clxscore=1015
 impostorscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005140015
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set adds support for narrow loads from bpf_sock_addr.user_port
in BPF_PROG_TYPE_CGROUP_SOCK_ADDR program.s

Patch 1 adds narrow loads support for user_port.
Patch 2 tests it.


Andrey Ignatov (2):
  bpf: Support narrow loads from bpf_sock_addr.user_port
  selftests/bpf: Test narrow loads for bpf_sock_addr.user_port

 include/uapi/linux/bpf.h                     |  2 +-
 net/core/filter.c                            | 15 ++++----
 tools/include/uapi/linux/bpf.h               |  2 +-
 tools/testing/selftests/bpf/test_sock_addr.c | 38 ++++++++++++++------
 4 files changed, 37 insertions(+), 20 deletions(-)

--=20
2.24.1

