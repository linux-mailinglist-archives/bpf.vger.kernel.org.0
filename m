Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD06C589376
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 22:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238261AbiHCUsZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Aug 2022 16:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236179AbiHCUsY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Aug 2022 16:48:24 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEE95C95B
        for <bpf@vger.kernel.org>; Wed,  3 Aug 2022 13:48:23 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 273Fc3LK025765
        for <bpf@vger.kernel.org>; Wed, 3 Aug 2022 13:48:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=8q51bHPYqZIqK1g3l2p20ghy4BeXezLI9t67HNE+0rw=;
 b=fR7ifT9FnIWrkYaPZIDGPaDiWSH+MS04/NJZnfDskaHKvclwgXD+SIEuPGuVa7ojjfX9
 tjUcjIy6b54Y1uM9+afJbjHixZeQAhAYyPAI3ehEhtQdF6N0Ju3zQIIXoavCkb3KehSR
 Pl8L4LHWjld2bg2Uoy2iQDgedjpR2OcMsHM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hpy32mq0x-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 03 Aug 2022 13:48:22 -0700
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub204.TheFacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 3 Aug 2022 13:48:21 -0700
Received: from twshared22413.18.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 3 Aug 2022 13:48:21 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id A6CD07A3F6B5; Wed,  3 Aug 2022 13:46:01 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, <kernel-team@fb.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Stanislav Fomichev <sdf@google.com>
Subject: [PATCH v2 bpf-next 00/15] bpf: net: Remove duplicated code from bpf_setsockopt()
Date:   Wed, 3 Aug 2022 13:46:01 -0700
Message-ID: <20220803204601.3075863-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: JnExU2FhNYeVjnvQse3OjpkogIYg2NpY
X-Proofpoint-GUID: JnExU2FhNYeVjnvQse3OjpkogIYg2NpY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-03_06,2022-08-02_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The code in bpf_setsockopt() is mostly a copy-and-paste from
the sock_setsockopt(), do_tcp_setsockopt(), do_ipv6_setsockopt(),
and do_ip_setsockopt().  As the allowed optnames in bpf_setsockopt()
grows, so are the duplicated code.  The code between the copies
also slowly drifted.

This set is an effort to clean this up and reuse the existing
{sock,do_tcp,do_ipv6,do_ip}_setsockopt() as much as possible.

After the clean up, this set also adds a few allowed optnames
that we need to the bpf_setsockopt().

The initial attempt was to clean up both bpf_setsockopt() and
bpf_getsockopt() together.  However, the patch set was getting
too long.  It is beneficial to leave the bpf_getsockopt()
out for another patch set.  Thus, this set is focusing
on the bpf_setsockopt().

v2:
- A major change is to use in_bpf() to test if a setsockopt()
  is called by a bpf prog and use in_bpf() to skip capable
  check.  Suggested by Stanislav.
- Instead of passing is_locked through sockptr_t or through an extra
  argument to sk_setsockopt, v2 uses in_bpf() to skip the lock_sock()
  also because bpf prog has the lock acquired.
- No change to the current sockptr_t in this revision
- s/codes/code/

Martin KaFai Lau (15):
  net: Add sk_setsockopt() to take the sk ptr instead of the sock ptr
  bpf: net: Avoid sk_setsockopt() taking sk lock when called from bpf
  bpf: net: Consider in_bpf() when testing capable() in sk_setsockopt()
  bpf: net: Change do_tcp_setsockopt() to use the sockopt's lock_sock()
    and capable()
  bpf: net: Change do_ip_setsockopt() to use the sockopt's lock_sock()
    and capable()
  bpf: net: Change do_ipv6_setsockopt() to use the sockopt's lock_sock()
    and capable()
  bpf: Initialize the bpf_run_ctx in bpf_iter_run_prog()
  bpf: Embed kernel CONFIG check into the if statement in bpf_setsockopt
  bpf: Change bpf_setsockopt(SOL_SOCKET) to reuse sk_setsockopt()
  bpf: Refactor bpf specific tcp optnames to a new function
  bpf: Change bpf_setsockopt(SOL_TCP) to reuse do_tcp_setsockopt()
  bpf: Change bpf_setsockopt(SOL_IP) to reuse do_ip_setsockopt()
  bpf: Change bpf_setsockopt(SOL_IPV6) to reuse do_ipv6_setsockopt()
  bpf: Add a few optnames to bpf_setsockopt
  selftests/bpf: bpf_setsockopt tests

 include/linux/bpf.h                           |   8 +
 include/net/ip.h                              |   2 +
 include/net/ipv6.h                            |   2 +
 include/net/ipv6_stubs.h                      |   2 +
 include/net/sock.h                            |   7 +
 include/net/tcp.h                             |   2 +
 kernel/bpf/bpf_iter.c                         |   5 +
 net/core/filter.c                             | 377 +++++-------
 net/core/sock.c                               |  77 ++-
 net/ipv4/ip_sockglue.c                        |  16 +-
 net/ipv4/tcp.c                                |  22 +-
 net/ipv6/af_inet6.c                           |   1 +
 net/ipv6/ipv6_sockglue.c                      |  18 +-
 .../selftests/bpf/prog_tests/setget_sockopt.c | 125 ++++
 .../selftests/bpf/progs/setget_sockopt.c      | 547 ++++++++++++++++++
 15 files changed, 939 insertions(+), 272 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/setget_sockopt=
.c
 create mode 100644 tools/testing/selftests/bpf/progs/setget_sockopt.c

--=20
2.30.2

