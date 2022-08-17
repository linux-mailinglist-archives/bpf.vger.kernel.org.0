Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0178596A18
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 09:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238158AbiHQHLV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 03:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238773AbiHQHLR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 03:11:17 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7874C6745D
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 00:11:10 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27H0KeSC030314
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 00:11:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=PqhZWEkd7t/4jYlnXFINIA+gzLkm1J6HedioAwHDqEo=;
 b=jOe9bQXeYLBoFM5rcG29s7RZQQGj4uUGWxIX7Ej1M8i+5FlxqkN9RthCYrIq6exocbhS
 qbM00xCVKLZrssLIkhhj1g70qAmfYeOoTIQT/d0GMnYkOqjF/yHux01HaDhLGI0Q1HYL
 9quHi1KX4ndXm7TiHn0HoPkYUpJibzBOOaQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j0nq01dfb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 00:11:09 -0700
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub101.TheFacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 17 Aug 2022 00:11:07 -0700
Received: from twshared30313.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 17 Aug 2022 00:11:06 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id F2060825DBC2; Tue, 16 Aug 2022 23:17:04 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 00/15] bpf: net: Remove duplicated code from bpf_setsockopt()
Date:   Tue, 16 Aug 2022 23:17:04 -0700
Message-ID: <20220817061704.4174272-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: PCoHxYaiYrIY3Hc5AfiUWxXB-soQO-BI
X-Proofpoint-GUID: PCoHxYaiYrIY3Hc5AfiUWxXB-soQO-BI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_04,2022-08-16_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

v4:
- This set now depends on the commit f574f7f839fc ("net: bpf: Use the pro=
tocol's set_rcvlowat behavior if there is one")
  in the net-next tree.  The commit calls a specific protocol's
  set_rcvlowat and it changed the bpf_setsockopt
  which this set has also changed.

  Because of this, patch 9 of this set has also adjusted
  and a 'sock' NULL check is added to the sk_setsockopt()
  because some of the bpf hooks have a NULL sk->sk_socket.
  This removes more dup code from the bpf_setsockopt() side.
- Avoid mentioning specific prog types in the comment of
  the has_current_bpf_ctx(). (Andrii)
- Replace signed with unsigned int bitfield in the
  patch 15 selftest. (Daniel)

v3:
- s/in_bpf/has_current_bpf_ctx/ (Andrii)
- Add comment to has_current_bpf_ctx() and sockopt_lock_sock()
  (Stanislav)
- Use vmlinux.h in selftest and add defines to bpf_tracing_net.h
  (Stanislav)
- Use bpf_getsockopt(SO_MARK) in selftest (Stanislav)
- Use BPF_CORE_READ_BITFIELD in selftest (Yonghong)

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
  bpf: net: Consider has_current_bpf_ctx() when testing capable() in
    sk_setsockopt()
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

 include/linux/bpf.h                           |  13 +
 include/net/ip.h                              |   2 +
 include/net/ipv6.h                            |   2 +
 include/net/ipv6_stubs.h                      |   2 +
 include/net/sock.h                            |   7 +
 include/net/tcp.h                             |   2 +
 kernel/bpf/bpf_iter.c                         |   5 +
 net/core/filter.c                             | 371 ++++++--------
 net/core/sock.c                               |  83 +++-
 net/ipv4/ip_sockglue.c                        |  16 +-
 net/ipv4/tcp.c                                |  22 +-
 net/ipv6/af_inet6.c                           |   1 +
 net/ipv6/ipv6_sockglue.c                      |  18 +-
 .../selftests/bpf/prog_tests/setget_sockopt.c | 125 +++++
 .../selftests/bpf/progs/bpf_tracing_net.h     |  31 +-
 .../selftests/bpf/progs/setget_sockopt.c      | 451 ++++++++++++++++++
 16 files changed, 874 insertions(+), 277 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/setget_sockopt=
.c
 create mode 100644 tools/testing/selftests/bpf/progs/setget_sockopt.c

--=20
2.30.2

