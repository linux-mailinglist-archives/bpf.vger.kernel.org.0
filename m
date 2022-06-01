Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CCC53AF13
	for <lists+bpf@lfdr.de>; Thu,  2 Jun 2022 00:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbiFAVqH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jun 2022 17:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbiFAVqG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jun 2022 17:46:06 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAF6BC07
        for <bpf@vger.kernel.org>; Wed,  1 Jun 2022 14:46:05 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 251HPftL010699
        for <bpf@vger.kernel.org>; Wed, 1 Jun 2022 13:16:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=//UHTcHy0RRJYWzMXl1WsySl0RZInyogWdCnZYCDfuQ=;
 b=jNdUl+vWsDCt3mBZ85zAz0y3Vzit1M6oyrXaCugxbkpaGbimF1uCx1vrSNUMKkmFxC5n
 YURk/avPgvyaaH5HOQXh7qoj2pdhF0GcL8CMgHJDhO1eDObppv9p61IoFQK3i2/4CuGm
 IK8LvvP1IpbLej5gMOvUa18aJr9nDqTevAs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ge3wk4h2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 01 Jun 2022 13:16:59 -0700
Received: from twshared14818.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 1 Jun 2022 13:16:58 -0700
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id B922AD254BEE; Wed,  1 Jun 2022 13:16:33 -0700 (PDT)
From:   Joanne Koong <joannekoong@fb.com>
To:     <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
CC:     <edumazet@google.com>, <kafai@fb.com>, <kuba@kernel.org>,
        <davem@davemloft.net>, <pabeni@redhat.com>,
        <testing@vger.kernel.org>, Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH net-next v1 resend 0/2] Update bhash2 when socket's rcv saddr changes
Date:   Wed, 1 Jun 2022 13:14:32 -0700
Message-ID: <20220601201434.1710931-1-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: G9M_N8O5pYgPQtgILTxF_FmB5KHknXH2
X-Proofpoint-ORIG-GUID: G9M_N8O5pYgPQtgILTxF_FmB5KHknXH2
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-01_07,2022-06-01_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Joanne Koong <joannelkoong@gmail.com>

As syzbot noted [1], there is an inconsistency in the bhash2 table in the c=
ase
where a socket's rcv saddr changes after it is binded. (For more details,
please see the commit message of the first patch)

This patchset fixes that and adds a test that triggers the case where the s=
k's
rcv saddr changes. The subsequent listen() call should succeed.

[1] https://lore.kernel.org/netdev/0000000000003f33bc05dfaf44fe@google.com/

Joanne Koong (2):
  net: Update bhash2 when socket's rcv saddr changes
  selftests/net: Add sk_bind_sendto_listen test

 include/net/inet_hashtables.h                 |  6 +-
 include/net/ipv6.h                            |  2 +-
 net/dccp/ipv4.c                               | 10 ++-
 net/dccp/ipv6.c                               |  4 +-
 net/ipv4/af_inet.c                            |  7 +-
 net/ipv4/inet_hashtables.c                    | 69 ++++++++++++++--
 net/ipv4/tcp_ipv4.c                           |  8 +-
 net/ipv6/inet6_hashtables.c                   |  4 +-
 net/ipv6/tcp_ipv6.c                           |  4 +-
 tools/testing/selftests/net/.gitignore        |  1 +
 tools/testing/selftests/net/Makefile          |  1 +
 .../selftests/net/sk_bind_sendto_listen.c     | 82 +++++++++++++++++++
 12 files changed, 180 insertions(+), 18 deletions(-)
 create mode 100644 tools/testing/selftests/net/sk_bind_sendto_listen.c

--=20
2.30.2

