Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D4C21176B
	for <lists+bpf@lfdr.de>; Thu,  2 Jul 2020 02:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgGBAsu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jul 2020 20:48:50 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:6498 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726814AbgGBAsu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 1 Jul 2020 20:48:50 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0620lTc0001372
        for <bpf@vger.kernel.org>; Wed, 1 Jul 2020 17:48:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=Q+HZl1qoJ/AZ+gCC113kr5LiZeM4NWq3MOVMELM2P1w=;
 b=kYPR5GLqxjgjMGdhjqhUdjQDMRNH6uQ1Zl7RKPM+aOM++MtdTzThm7KFqhQexyRwxT7Q
 VKjT87W5r72P04EXvEFIX0bOlbbIByq4z/FyIBDBBnBQG5HpGSAWr0kNsYCBc241HdQa
 TAp9hrWkrnFxT/Qo6fJyY/93LBbW/Lyz/+8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31xny2j8tc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2020 17:48:49 -0700
Received: from intmgw003.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 1 Jul 2020 17:48:49 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id 40A8E294573F; Wed,  1 Jul 2020 17:48:46 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Hostname: devbig005.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <netdev@vger.kernel.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next 0/2]  bpf: selftests: A few changes to network_helpers and netns-reset
Date:   Wed, 1 Jul 2020 17:48:46 -0700
Message-ID: <20200702004846.2101805-1-kafai@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-02_01:2020-07-01,2020-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 cotscore=-2147483648
 mlxscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 clxscore=1015 mlxlogscore=790 adultscore=0 suspectscore=1
 bulkscore=0 impostorscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007020002
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This set is separated out from the bpf tcp header option series [1] since
I think it is in general useful for other network related tests.
e.g. enforce socket-fd related timeout and restore netns after each test.

[1]: https://lore.kernel.org/netdev/20200626175501.1459961-1-kafai@fb.com=
/

v2:
- Mention non-NULL addr use case in commit message. (Yonghong)
- Add prefix "__" to variables used in macro. (Yonghong)

Martin KaFai Lau (2):
  bpf: selftests: A few improvements to network_helpers.c
  bpf: selftests: Restore netns after each test

 tools/testing/selftests/bpf/network_helpers.c | 157 +++++++++++-------
 tools/testing/selftests/bpf/network_helpers.h |   9 +-
 .../bpf/prog_tests/cgroup_skb_sk_lookup.c     |  12 +-
 .../bpf/prog_tests/connect_force_port.c       |  10 +-
 .../bpf/prog_tests/load_bytes_relative.c      |   4 +-
 .../selftests/bpf/prog_tests/tcp_rtt.c        |   4 +-
 tools/testing/selftests/bpf/test_progs.c      |  23 ++-
 tools/testing/selftests/bpf/test_progs.h      |   2 +
 8 files changed, 133 insertions(+), 88 deletions(-)

--=20
2.24.1

