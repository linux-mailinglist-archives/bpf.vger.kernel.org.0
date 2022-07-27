Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C800581FD8
	for <lists+bpf@lfdr.de>; Wed, 27 Jul 2022 08:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiG0GJM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Jul 2022 02:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiG0GJG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Jul 2022 02:09:06 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934FA3FA0B
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 23:09:05 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 26QND3cS001027
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 23:09:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=/sS9tLVy0y93k2xzF9fh/c4ifa2Z9xGz3jqt21SgAxI=;
 b=MJsJYZUdSXOfmEU0j6gJ+N++Le91AIGtLCEQH3C9Heb9EOqys3+2yibUEdvUS0vdjiZa
 Gq3CGzcTWz/iSafSUMo00Vzyg3F+yBz7aDEDWVK0lgNpareCmHrQbIdV8sVUUQCKHSCz
 vIB2jzzuj58GbdLWNfQX0lGF1d6/H8T3lQw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3hjj4e4wd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 23:09:04 -0700
Received: from twshared5413.23.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 26 Jul 2022 23:09:03 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id 4B993757CB36; Tue, 26 Jul 2022 23:08:56 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, <kernel-team@fb.com>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH bpf-next 00/14] bpf: net: Remove duplicated codes from bpf_setsockopt()
Date:   Tue, 26 Jul 2022 23:08:56 -0700
Message-ID: <20220727060856.2370358-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 8Q34RsVWDU4NgEKtvS5Kw4Mwx6w2XVgV
X-Proofpoint-GUID: 8Q34RsVWDU4NgEKtvS5Kw4Mwx6w2XVgV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_07,2022-07-26_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The codes in bpf_setsockopt() is mostly a copy-and-paste from
the sock_setsockopt(), do_tcp_setsockopt(), do_ipv6_setsockopt(),
and do_ip_setsockopt().  As the allowed optnames in bpf_setsockopt()
grows, so are the duplicated codes.  The codes between the copies
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

Martin KaFai Lau (14):
  net: Change sock_setsockopt from taking sock ptr to sk ptr
  bpf: net: Avoid sock_setsockopt() taking sk lock when called from bpf
  bpf: net: Consider optval.is_bpf before capable check in
    sock_setsockopt()
  bpf: net: Avoid do_tcp_setsockopt() taking sk lock when called from
    bpf
  bpf: net: Avoid do_ip_setsockopt() taking sk lock when called from bpf
  bpf: net: Avoid do_ipv6_setsockopt() taking sk lock when called from
    bpf
  bpf: Embed kernel CONFIG check into the if statement in bpf_setsockopt
  bpf: Change bpf_setsockopt(SOL_SOCKET) to reuse sock_setsockopt()
  bpf: Refactor bpf specific tcp optnames to a new function
  bpf: Change bpf_setsockopt(SOL_TCP) to reuse do_tcp_setsockopt()
  bpf: Change bpf_setsockopt(SOL_IP) to reuse do_ip_setsockopt()
  bpf: Change bpf_setsockopt(SOL_IPV6) to reuse do_ipv6_setsockopt()
  bpf: Add a few optnames to bpf_setsockopt
  selftests/bpf: bpf_setsockopt tests

 drivers/nvme/host/tcp.c                       |   2 +-
 fs/ksmbd/transport_tcp.c                      |   2 +-
 include/linux/sockptr.h                       |   8 +-
 include/net/ip.h                              |   2 +
 include/net/ipv6.h                            |   2 +
 include/net/ipv6_stubs.h                      |   2 +
 include/net/sock.h                            |  14 +-
 include/net/tcp.h                             |   2 +
 net/core/filter.c                             | 378 +++++-------
 net/core/sock.c                               |  25 +-
 net/ipv4/ip_sockglue.c                        |  10 +-
 net/ipv4/tcp.c                                |  21 +-
 net/ipv6/af_inet6.c                           |   1 +
 net/ipv6/ipv6_sockglue.c                      |  10 +-
 net/mptcp/sockopt.c                           |  12 +-
 net/socket.c                                  |   2 +-
 .../selftests/bpf/prog_tests/setget_sockopt.c | 125 ++++
 .../selftests/bpf/progs/setget_sockopt.c      | 538 ++++++++++++++++++
 18 files changed, 890 insertions(+), 266 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/setget_sockopt=
.c
 create mode 100644 tools/testing/selftests/bpf/progs/setget_sockopt.c

--=20
2.30.2

